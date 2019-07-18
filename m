Return-Path: <SRS0=Pa1K=VP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 738ADC76191
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 08:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4AC8F208C0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jul 2019 08:40:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbfGRIkN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jul 2019 04:40:13 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2679 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726386AbfGRIkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jul 2019 04:40:12 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 845C59CC8DD15DCFDDC0;
        Thu, 18 Jul 2019 16:40:10 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Thu, 18 Jul 2019 16:40:01 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        <drosen@google.com>, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix to drop meta/node pages during umount
Date:   Thu, 18 Jul 2019 16:39:59 +0800
Message-ID: <20190718083959.32321-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As reported in bugzilla:

https://bugzilla.kernel.org/show_bug.cgi?id=204193

A null pointer dereference bug is triggered in f2fs under kernel-5.1.3.

 kasan_report.cold+0x5/0x32
 f2fs_write_end_io+0x215/0x650
 bio_endio+0x26e/0x320
 blk_update_request+0x209/0x5d0
 blk_mq_end_request+0x2e/0x230
 lo_complete_rq+0x12c/0x190
 blk_done_softirq+0x14a/0x1a0
 __do_softirq+0x119/0x3e5
 irq_exit+0x94/0xe0
 call_function_single_interrupt+0xf/0x20

During umount, we will access NULL sbi->node_inode pointer in
f2fs_write_end_io():

	f2fs_bug_on(sbi, page->mapping == NODE_MAPPING(sbi) &&
				page->index != nid_of_node(page));

The reason is if disable_checkpoint mount option is on, meta dirty
pages can remain during umount, and then be flushed by iput() of
meta_inode, however node_inode has been iput()ed before
meta_inode's iput().

Since checkpoint is disabled, all meta/node datas are useless and
should be dropped in next mount, so in umount, let's adjust
drop_inode() to give a hint to iput_final() to drop all those dirty
datas correctly.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/super.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 580fa3d837c7..e5cae67935f6 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -873,7 +873,21 @@ static struct inode *f2fs_alloc_inode(struct super_block *sb)
 
 static int f2fs_drop_inode(struct inode *inode)
 {
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	int ret;
+
+	/*
+	 * during filesystem shutdown, if checkpoint is disabled,
+	 * drop useless meta/node dirty pages.
+	 */
+	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED))) {
+		if (inode->i_ino == F2FS_NODE_INO(sbi) ||
+			inode->i_ino == F2FS_META_INO(sbi)) {
+			trace_f2fs_drop_inode(inode, 1);
+			return 1;
+		}
+	}
+
 	/*
 	 * This is to avoid a deadlock condition like below.
 	 * writeback_single_inode(inode)
-- 
2.18.0.rc1

