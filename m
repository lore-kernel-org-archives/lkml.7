Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4ECCC7618B
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 09:34:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AFF1122BED
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 09:34:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390554AbfGYJeB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 05:34:01 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:54458 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390537AbfGYJeA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 05:34:00 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A5C5D3CF4F397CE816FD;
        Thu, 25 Jul 2019 17:33:58 +0800 (CST)
Received: from szvp000203569.huawei.com (10.120.216.130) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Thu, 25 Jul 2019 17:33:50 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix to handle quota_{on,off} correctly
Date:   Thu, 25 Jul 2019 17:33:37 +0800
Message-ID: <20190725093337.123063-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With quota_ino feature on, generic/232 reports an inconsistence issue
on the image.

The root cause is that the testcase tries to:
- use quotactl to shutdown journalled quota based on sysfile;
- and then use quotactl to enable/turn on quota based on specific file
(aquota.user or aquota.group).

Eventually, quota sysfile will be out-of-update due to following specific
file creation.

Change as below to fix this issue:
- deny enabling quota based on specific file if quota sysfile exists.
- set SBI_QUOTA_NEED_REPAIR once sysfile based quota shutdowns via
ioctl.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/super.c | 27 +++++++++++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index e5cae67935f6..c28d2b864975 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2000,6 +2000,12 @@ static int f2fs_quota_on(struct super_block *sb, int type, int format_id,
 	struct inode *inode;
 	int err;
 
+	/* if quota sysfile exists, deny enabling quota with specific file */
+	if (f2fs_sb_has_quota_ino(F2FS_SB(sb))) {
+		f2fs_err(F2FS_SB(sb), "quota sysfile already exists");
+		return -EBUSY;
+	}
+
 	err = f2fs_quota_sync(sb, type);
 	if (err)
 		return err;
@@ -2019,7 +2025,7 @@ static int f2fs_quota_on(struct super_block *sb, int type, int format_id,
 	return 0;
 }
 
-static int f2fs_quota_off(struct super_block *sb, int type)
+static int __f2fs_quota_off(struct super_block *sb, int type)
 {
 	struct inode *inode = sb_dqopt(sb)->files[type];
 	int err;
@@ -2045,13 +2051,30 @@ static int f2fs_quota_off(struct super_block *sb, int type)
 	return err;
 }
 
+static int f2fs_quota_off(struct super_block *sb, int type)
+{
+	struct f2fs_sb_info *sbi = F2FS_SB(sb);
+	int err;
+
+	err = __f2fs_quota_off(sb, type);
+
+	/*
+	 * quotactl can shutdown journalled quota, result in inconsistence
+	 * between quota record and fs data by following updates, tag the
+	 * flag to let fsck be aware of it.
+	 */
+	if (is_journalled_quota(sbi))
+		set_sbi_flag(sbi, SBI_QUOTA_NEED_REPAIR);
+	return err;
+}
+
 void f2fs_quota_off_umount(struct super_block *sb)
 {
 	int type;
 	int err;
 
 	for (type = 0; type < MAXQUOTAS; type++) {
-		err = f2fs_quota_off(sb, type);
+		err = __f2fs_quota_off(sb, type);
 		if (err) {
 			int ret = dquot_quota_off(sb, type);
 
-- 
2.18.0.rc1

