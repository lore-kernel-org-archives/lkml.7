Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01644C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF45E21900
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 09:49:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbfDXJtF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 05:49:05 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2994 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726274AbfDXJtE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 05:49:04 -0400
Received: from DGGEMM406-HUB.china.huawei.com (unknown [172.30.72.57])
        by Forcepoint Email with ESMTP id 3A0831C229B203AFC7A9;
        Wed, 24 Apr 2019 17:49:01 +0800 (CST)
Received: from dggeme763-chm.china.huawei.com (10.3.19.109) by
 DGGEMM406-HUB.china.huawei.com (10.3.20.214) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Wed, 24 Apr 2019 17:48:58 +0800
Received: from szvp000201624.huawei.com (10.120.216.130) by
 dggeme763-chm.china.huawei.com (10.3.19.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.1591.10; Wed, 24 Apr 2019 17:48:57 +0800
From:   Chao Yu <yuchao0@huawei.com>
To:     <jaegeuk@kernel.org>
CC:     <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>, <chao@kernel.org>,
        Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix to do sanity with enabled features in image
Date:   Wed, 24 Apr 2019 17:48:50 +0800
Message-ID: <20190424094850.118323-1-yuchao0@huawei.com>
X-Mailer: git-send-email 2.18.0.rc1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.120.216.130]
X-ClientProxiedBy: dggeme711-chm.china.huawei.com (10.1.199.107) To
 dggeme763-chm.china.huawei.com (10.3.19.109)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes to do sanity with enabled features in image, if
there are features kernel can not recognize, just fail the mount.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/f2fs.h  | 13 +++++++++++++
 fs/f2fs/super.c |  9 +++++++++
 2 files changed, 22 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index f5ffc09705eb..15b640967e12 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -151,6 +151,19 @@ struct f2fs_mount_info {
 #define F2FS_FEATURE_VERITY		0x0400	/* reserved */
 #define F2FS_FEATURE_SB_CHKSUM		0x0800
 
+#define F2FS_ALL_FEATURES	(F2FS_FEATURE_ENCRYPT |			\
+				F2FS_FEATURE_BLKZONED |			\
+				F2FS_FEATURE_ATOMIC_WRITE |		\
+				F2FS_FEATURE_EXTRA_ATTR |		\
+				F2FS_FEATURE_PRJQUOTA |			\
+				F2FS_FEATURE_INODE_CHKSUM |		\
+				F2FS_FEATURE_FLEXIBLE_INLINE_XATTR |	\
+				F2FS_FEATURE_QUOTA_INO |		\
+				F2FS_FEATURE_INODE_CRTIME |		\
+				F2FS_FEATURE_LOST_FOUND |		\
+				F2FS_FEATURE_VERITY |			\
+				F2FS_FEATURE_SB_CHKSUM)
+
 #define __F2FS_HAS_FEATURE(raw_super, mask)				\
 	((raw_super->feature & cpu_to_le32(mask)) != 0)
 #define F2FS_HAS_FEATURE(sbi, mask)	__F2FS_HAS_FEATURE(sbi->raw_super, mask)
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 4f8e9ab48b26..57f2fc6d14ba 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2573,6 +2573,15 @@ static int sanity_check_raw_super(struct f2fs_sb_info *sbi,
 		return 1;
 	}
 
+	/* check whether kernel supports all features */
+	if (le32_to_cpu(raw_super->feature) & (~F2FS_ALL_FEATURES)) {
+		f2fs_msg(sb, KERN_INFO,
+			"Unsupported feature:%u: supported:%u",
+			le32_to_cpu(raw_super->feature),
+			F2FS_ALL_FEATURES);
+		return 1;
+	}
+
 	/* check CP/SIT/NAT/SSA/MAIN_AREA area boundary */
 	if (sanity_check_area_boundary(sbi, bh))
 		return 1;
-- 
2.18.0.rc1

