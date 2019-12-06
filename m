Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D80E6C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 03:32:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B23DB21823
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 03:32:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726418AbfLFDcA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 22:32:00 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:7643 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726076AbfLFDcA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 22:32:00 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 67EADA3DF8EF18778786;
        Fri,  6 Dec 2019 11:31:58 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Fri, 6 Dec 2019 11:31:47 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix to relocate f2fs_balance_fs() in mkwrite()
Date:   Fri, 6 Dec 2019 11:31:00 +0800
Message-ID: <20191206033100.36345-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Dinosaur Huang reported, there is a potential deadlock in between
GC and mkwrite():

Thread A			Thread B
- do_page_mkwrite
 - f2fs_vm_page_mkwrite
  - lock_page
				- f2fs_balance_fs
                                 - mutex_lock(gc_mutex)
				 - f2fs_gc
				  - do_garbage_collect
				   - ra_data_block
				    - grab_cache_page
  - f2fs_balance_fs
   - mutex_lock(gc_mutex)

In order to fix this, we just move f2fs_balance_fs() out of page lock's
coverage in f2fs_vm_page_mkwrite().

Reported-by: Dinosaur Huang <dinosaur.huang@unisoc.com>
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index c0560d62dbee..ed3290225506 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -67,6 +67,8 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 
 	f2fs_bug_on(sbi, f2fs_has_inline_data(inode));
 
+	f2fs_balance_fs(sbi, true);
+
 	file_update_time(vmf->vma->vm_file);
 	down_read(&F2FS_I(inode)->i_mmap_sem);
 	lock_page(page);
@@ -120,8 +122,6 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 out_sem:
 	up_read(&F2FS_I(inode)->i_mmap_sem);
 
-	f2fs_balance_fs(sbi, dn.node_changed);
-
 	sb_end_pagefault(inode->i_sb);
 err:
 	return block_page_mkwrite_return(err);
-- 
2.18.0.rc1

