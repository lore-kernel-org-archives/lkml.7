Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2262CC4740C
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 01:14:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA84221726
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 01:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391057AbfIJBOf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 21:14:35 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2197 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729327AbfIJBOf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 21:14:35 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 79E7E2D5954FCE6DA913;
        Tue, 10 Sep 2019 09:14:33 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Tue, 10 Sep 2019 09:14:24 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH v2] f2fs: fix to avoid accessing uninitialized field of inode page in is_alive()
Date:   Tue, 10 Sep 2019 09:14:16 +0800
Message-ID: <20190910011416.28768-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If inode is newly created, inode page may not synchronize with inode cache,
so fields like .i_inline or .i_extra_isize could be wrong, in below call
path, we may access such wrong fields, result in failing to migrate valid
target block.

Thread A				Thread B
- f2fs_create
 - f2fs_add_link
  - f2fs_add_dentry
   - f2fs_init_inode_metadata
    - f2fs_add_inline_entry
     - f2fs_new_inode_page
     - f2fs_put_page
     : inode page wasn't updated with inode cache
					- gc_data_segment
					 - is_alive
					  - f2fs_get_node_page
					  - datablock_addr
					   - offset_in_addr
					   : access uninitialized fields

Fixes: 7a2af766af15 ("f2fs: enhance on-disk inode structure scalability")
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
v2:
- update inode page before f2fs_put_page()
 fs/f2fs/dir.c    | 5 +++++
 fs/f2fs/inline.c | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 7afbf8f5ab08..4033778bcbbf 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -682,6 +682,11 @@ int f2fs_add_regular_entry(struct inode *dir, const struct qstr *new_name,
 
 	if (inode) {
 		f2fs_i_pino_write(inode, dir->i_ino);
+
+		/* synchronize inode page's data from inode cache */
+		if (is_inode_flag_set(inode, FI_NEW_INODE))
+			f2fs_update_inode(inode, page);
+
 		f2fs_put_page(page, 1);
 	}
 
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 16ebdd4d1f2c..896db0416f0e 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -589,6 +589,11 @@ int f2fs_add_inline_entry(struct inode *dir, const struct qstr *new_name,
 	/* we don't need to mark_inode_dirty now */
 	if (inode) {
 		f2fs_i_pino_write(inode, dir->i_ino);
+
+		/* synchronize inode page's data from inode cache */
+		if (is_inode_flag_set(inode, FI_NEW_INODE))
+			f2fs_update_inode(inode, page);
+
 		f2fs_put_page(page, 1);
 	}
 
-- 
2.18.0.rc1

