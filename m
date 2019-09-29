Return-Path: <SRS0=maO4=XY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A092CC4360C
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 14:51:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7081B2075D
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Sep 2019 14:51:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p9XjC7YY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbfI2OvU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Sep 2019 10:51:20 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:44678 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728479AbfI2OvU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Sep 2019 10:51:20 -0400
Received: by mail-ot1-f66.google.com with SMTP id 21so6174932otj.11
        for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2019 07:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hib8D+V0D3BwDwwAI6M1zboYoKRedpSshNbRty1BMwY=;
        b=p9XjC7YYvytpt5fNNzOG7FTyKwNqeSFc+8kmsrM2he3vm/hDflFhlNmKel5L47Cspk
         m0Gce0izFndyhDBiKDkR92pSysRmayOwxTbQeRIhHs5qgRPd6p355ip+hubpwnF5rzYJ
         SPMFQeOkjA353XzgNEtvGN4oZmu5WYJXaC6pnPKFY5lzzsZd6+Rr4kGjxnTL4ONysni6
         M2kgg0pWMyXff1idIiuBmSOPqjirAx79d8qwfWKeeoOR8NFVSto5WU5Up1DP81kNIb2M
         BfMUaoauQfa/2pW947YkcBek8d2HqpNgPjt4rg22gtgVxtfPwDyDa+Hrq2571E6CqtFX
         VYGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Hib8D+V0D3BwDwwAI6M1zboYoKRedpSshNbRty1BMwY=;
        b=NODIV59eoX1CgTIZ2VSpTPClizv/3vS6b2sCQncthcmSVtlllCO0Deau37mo7eYbw9
         MSR0Tzq9xYFTOkmfu6EbOP6abjeQ6Zim0q89QrJ3hMhTl05ty7vGzxR88vueC6ImAAV0
         WF3nqnRhVEMo4twONM8HTs8mH7fY546vllAEvwxppVEthijisvW6vgPxodnP9/AoxYs6
         RJEEUMRcapyLZZwUv6JIIBGf/y+qHAAQOmxQyO/JDNCnp0OONN7LQ+m46cAPG5fAjuUY
         RskPhlE1PIp7trzHBoHvVuvY0AhJIfIUFraXc2/Q78Q6qu7t13JYXge5vRx6fc/IxJXf
         m34g==
X-Gm-Message-State: APjAAAUxjPni5NcvPEa+w9vQbrlmUP41DhKyki5SLC/ZI613jhIxbhaf
        WBKY88shKeVl50BvBaSIE1M=
X-Google-Smtp-Source: APXvYqxjzs5Kyrha7Xjrwqr58WyZM+Qr/hyb4dghv7D24eCTAOnBAFh27BJBoLNItWXw/x4/rA35Iw==
X-Received: by 2002:a05:6830:2059:: with SMTP id f25mr10285704otp.137.1569768679166;
        Sun, 29 Sep 2019 07:51:19 -0700 (PDT)
Received: from localhost (ip72-210-101-152.tu.ok.cox.net. [72.210.101.152])
        by smtp.gmail.com with ESMTPSA id r19sm2765149ota.79.2019.09.29.07.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2019 07:51:18 -0700 (PDT)
From:   Jesse Barton <jessebarton95@gmail.com>
To:     valdis.kletnieks@vt.edu
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Jesse Barton <jessebarton95@gmail.com>
Subject: [PATCH 1/3] Staging: exfat: exfat_super.c: fixed camelcase coding style issue
Date:   Sun, 29 Sep 2019 09:50:57 -0500
Message-Id: <20190929145057.37752-1-jessebarton95@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changed function names:
ffsUmountVol to ffs_umount_vol
ffsMountVol to ffs_mount_vol
ffsSyncVol to ffs_sync_vol


Signed-off-by: Jesse Barton <jessebarton95@gmail.com>
---
 drivers/staging/exfat/exfat_super.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index 5f6caee819a6..665eb25e318d 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -342,7 +342,7 @@ static inline void exfat_save_attr(struct inode *inode, u32 attr)
 		EXFAT_I(inode)->fid.attr = attr & (ATTR_RWMASK | ATTR_READONLY);
 }
 
-static int ffsMountVol(struct super_block *sb)
+static int ffs_mount_vol(struct super_block *sb)
 {
 	int i, ret;
 	struct pbr_sector_t *p_pbr;
@@ -446,7 +446,7 @@ static int ffsMountVol(struct super_block *sb)
 	return ret;
 }
 
-static int ffsUmountVol(struct super_block *sb)
+static int ffs_umount_vol(struct super_block *sb)
 {
 	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
 	int err = FFS_SUCCESS;
@@ -518,7 +518,7 @@ static int ffsGetVolInfo(struct super_block *sb, struct vol_info_t *info)
 	return err;
 }
 
-static int ffsSyncVol(struct super_block *sb, bool do_sync)
+static int ffs_sync_vol(struct super_block *sb, bool do_sync)
 {
 	int err = FFS_SUCCESS;
 	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
@@ -3043,7 +3043,7 @@ static int exfat_file_release(struct inode *inode, struct file *filp)
 	struct super_block *sb = inode->i_sb;
 
 	EXFAT_I(inode)->fid.size = i_size_read(inode);
-	ffsSyncVol(sb, false);
+	ffs_sync_vol(sb, false);
 	return 0;
 }
 
@@ -3460,7 +3460,7 @@ static void exfat_put_super(struct super_block *sb)
 	if (__is_sb_dirty(sb))
 		exfat_write_super(sb);
 
-	ffsUmountVol(sb);
+	ffs_umount_vol(sb);
 
 	sb->s_fs_info = NULL;
 	exfat_free_super(sbi);
@@ -3473,7 +3473,7 @@ static void exfat_write_super(struct super_block *sb)
 	__set_sb_clean(sb);
 
 	if (!sb_rdonly(sb))
-		ffsSyncVol(sb, true);
+		ffs_sync_vol(sb, true);
 
 	__unlock_super(sb);
 }
@@ -3485,7 +3485,7 @@ static int exfat_sync_fs(struct super_block *sb, int wait)
 	if (__is_sb_dirty(sb)) {
 		__lock_super(sb);
 		__set_sb_clean(sb);
-		err = ffsSyncVol(sb, true);
+		err = ffs_sync_vol(sb, true);
 		__unlock_super(sb);
 	}
 
@@ -3865,10 +3865,10 @@ static int exfat_fill_super(struct super_block *sb, void *data, int silent)
 	sb_min_blocksize(sb, 512);
 	sb->s_maxbytes = 0x7fffffffffffffffLL;    /* maximum file size */
 
-	ret = ffsMountVol(sb);
+	ret = ffs_mount_vol(sb);
 	if (ret) {
 		if (!silent)
-			pr_err("[EXFAT] ffsMountVol failed\n");
+			pr_err("[EXFAT] ffs_mount_vol failed\n");
 
 		goto out_fail;
 	}
@@ -3919,7 +3919,7 @@ static int exfat_fill_super(struct super_block *sb, void *data, int silent)
 	return 0;
 
 out_fail2:
-	ffsUmountVol(sb);
+	ffs_umount_vol(sb);
 out_fail:
 	if (root_inode)
 		iput(root_inode);
-- 
2.23.0

