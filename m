Return-Path: <SRS0=V+Ds=VJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 534BFC742A5
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 08:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DCE220863
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jul 2019 08:57:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726299AbfGLI5Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jul 2019 04:57:24 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:40294 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725929AbfGLI5Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jul 2019 04:57:24 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 48D8F5B8F6391BDF6638;
        Fri, 12 Jul 2019 16:57:15 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Fri, 12 Jul 2019 16:57:04 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: disallow switching io_bits option during remount
Date:   Fri, 12 Jul 2019 16:57:00 +0800
Message-ID: <20190712085700.4239-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If IO alignment feature is turned on after remount, we didn't
initialize mempool of it, it turns out we will encounter panic
during IO submission due to access NULL mempool pointer.

This feature should be set only at mount time, so simply deny
configuring during remount.

This fixes bug reported in bugzilla:

https://bugzilla.kernel.org/show_bug.cgi?id=204135

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/super.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 84e5a9bf4571..602a0791246d 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1567,6 +1567,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 	bool need_stop_gc = false;
 	bool no_extent_cache = !test_opt(sbi, EXTENT_CACHE);
 	bool disable_checkpoint = test_opt(sbi, DISABLE_CHECKPOINT);
+	bool no_io_align = !F2FS_IO_ALIGNED(sbi);
 	bool checkpoint_changed;
 #ifdef CONFIG_QUOTA
 	int i, j;
@@ -1646,6 +1647,12 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 		goto restore_opts;
 	}
 
+	if (no_io_align == !!F2FS_IO_ALIGNED(sbi)) {
+		err = -EINVAL;
+		f2fs_warn(sbi, "switch io_bits option is not allowed");
+		goto restore_opts;
+	}
+
 	if ((*flags & SB_RDONLY) && test_opt(sbi, DISABLE_CHECKPOINT)) {
 		err = -EINVAL;
 		f2fs_warn(sbi, "disabling checkpoint not compatible with read-only");
-- 
2.18.0.rc1

