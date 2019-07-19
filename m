Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5BC3C76188
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 07:19:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4B75218A4
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 07:19:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726909AbfGSHTD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 03:19:03 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:50636 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726135AbfGSHTD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 03:19:03 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 64A8F54C5AA7980B1836;
        Fri, 19 Jul 2019 15:18:58 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.439.0; Fri, 19 Jul 2019 15:18:48 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix to avoid discard command leak
Date:   Fri, 19 Jul 2019 15:18:44 +0800
Message-ID: <20190719071844.5690-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

 =============================================================================
 BUG discard_cmd (Tainted: G    B      OE  ): Objects remaining in discard_cmd on __kmem_cache_shutdown()
 -----------------------------------------------------------------------------

 INFO: Slab 0xffffe1ac481d22c0 objects=36 used=2 fp=0xffff936b4748bf50 flags=0x2ffff0000000100
 Call Trace:
  dump_stack+0x63/0x87
  slab_err+0xa1/0xb0
  __kmem_cache_shutdown+0x183/0x390
  shutdown_cache+0x14/0x110
  kmem_cache_destroy+0x195/0x1c0
  f2fs_destroy_segment_manager_caches+0x21/0x40 [f2fs]
  exit_f2fs_fs+0x35/0x641 [f2fs]
  SyS_delete_module+0x155/0x230
  ? vtime_user_exit+0x29/0x70
  do_syscall_64+0x6e/0x160
  entry_SYSCALL64_slow_path+0x25/0x25

 INFO: Object 0xffff936b4748b000 @offset=0
 INFO: Object 0xffff936b4748b070 @offset=112
 kmem_cache_destroy discard_cmd: Slab cache still has objects
 Call Trace:
  dump_stack+0x63/0x87
  kmem_cache_destroy+0x1b4/0x1c0
  f2fs_destroy_segment_manager_caches+0x21/0x40 [f2fs]
  exit_f2fs_fs+0x35/0x641 [f2fs]
  SyS_delete_module+0x155/0x230
  do_syscall_64+0x6e/0x160
  entry_SYSCALL64_slow_path+0x25/0x25

Recovery can cache discard commands, so in error path of fill_super(),
we need give a chance to handle them, otherwise it will lead to leak
of discard_cmd slab cache.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/segment.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 57a83a68ae03..449ef70d99cc 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2084,6 +2084,13 @@ static void destroy_discard_cmd_control(struct f2fs_sb_info *sbi)
 
 	f2fs_stop_discard_thread(sbi);
 
+	/*
+	 * Recovery can cache discard commands, so in error path of
+	 * fill_super(), it needs to give a chance to handle them.
+	 */
+	if (unlikely(atomic_read(&dcc->discard_cmd_cnt)))
+		f2fs_issue_discard_timeout(sbi);
+
 	kvfree(dcc);
 	SM_I(sbi)->dcc_info = NULL;
 }
-- 
2.18.0.rc1

