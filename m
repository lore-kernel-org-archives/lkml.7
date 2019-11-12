Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 849AEC17441
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 21:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F09120818
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 21:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbfKLVNO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 16:13:14 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:44326 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727137AbfKLVNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 16:13:13 -0500
Received: from mr6.cc.vt.edu (mr6.cc.vt.edu [IPv6:2607:b400:92:8500:0:af:2d00:4488])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id xACLDBpU012558
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 16:13:11 -0500
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
        by mr6.cc.vt.edu (8.14.7/8.14.7) with ESMTP id xACLD69c014550
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 16:13:11 -0500
Received: by mail-qk1-f200.google.com with SMTP id a129so18933qkg.22
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2019 13:13:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=TMs8EqizOmcbL5afEJ4pYIbimEUxR6OYXves9AYPvSE=;
        b=lP0WutVgAHhocmq8r/1owDtw09yEe3QUCsa468SmIkxjOuzL+Pc3Vg4/EYfQJ2PIX6
         P9RhqSj+WFpY+sxXGlBbOqCJvl3w2bt+6Az2BrmN9yyo4HxupEgZ6I5Vg6Z1o+mmNxh4
         Nbnd5469U75u3A3xxyAeLGk7IHXAy4hTNdH9NWw0u0plRNh25icMx+e1t3nkB7CAzebb
         KgW4MN90gSqUlH/ye0IvIRLqGmsu9G4/WJzvCjXgLdbXS8X8i7dhQi8GIVbkl5G6bvgy
         YxBdoN60pBb7ISD0pWuRyxzKSy8xSk0s0bE3ACTeEIpBJ/CzBMEIaBNKAxLQvBhYqHCl
         +rCg==
X-Gm-Message-State: APjAAAWXrIMu6x4pk1GD8F0aIXm3iYwL+tEgXjFPpf+5Es82UnoeeWjx
        oLIdaldDZQrYqM5c8xAwbhgH8/JcBTRkdOyrUyev06fNbVAhfOc46bnlZ5+zablpFrELbeuAcm4
        LsytUwW5L2jSwgT41KAGg1P6yc+GpO4QJ5q8=
X-Received: by 2002:aed:36a1:: with SMTP id f30mr33552688qtb.154.1573593185381;
        Tue, 12 Nov 2019 13:13:05 -0800 (PST)
X-Google-Smtp-Source: APXvYqwMIzBc7/V6/Sa0fznfG8MW9/AqSpNPbu3O0+gx6/O116Gln8e/aT+JIJORaBahR9LjgiElOQ==
X-Received: by 2002:aed:36a1:: with SMTP id f30mr33552655qtb.154.1573593184966;
        Tue, 12 Nov 2019 13:13:04 -0800 (PST)
Received: from turing-police.lan ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id 130sm9674214qkd.33.2019.11.12.13.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2019 13:13:03 -0800 (PST)
From:   Valdis Kletnieks <valdis.kletnieks@vt.edu>
X-Google-Original-From: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
Cc:     Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/12] staging: exfat: Remove FAT/VFAT mount support, part 1
Date:   Tue, 12 Nov 2019 16:12:27 -0500
Message-Id: <20191112211238.156490-2-Valdis.Kletnieks@vt.edu>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191112211238.156490-1-Valdis.Kletnieks@vt.edu>
References: <20191112211238.156490-1-Valdis.Kletnieks@vt.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the top-level mount functionality, to make this driver handle
only exfat file systems.

Signed-off-by: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
---
 drivers/staging/exfat/Kconfig       |   9 --
 drivers/staging/exfat/exfat.h       |   2 -
 drivers/staging/exfat/exfat_core.c  | 193 ----------------------------
 drivers/staging/exfat/exfat_super.c |   8 +-
 4 files changed, 1 insertion(+), 211 deletions(-)

diff --git a/drivers/staging/exfat/Kconfig b/drivers/staging/exfat/Kconfig
index ce32dfe33bec..0130019cbec2 100644
--- a/drivers/staging/exfat/Kconfig
+++ b/drivers/staging/exfat/Kconfig
@@ -6,15 +6,6 @@ config EXFAT_FS
 	help
 	  This adds support for the exFAT file system.
 
-config EXFAT_DONT_MOUNT_VFAT
-	bool "Prohibit mounting of fat/vfat filesystems by exFAT"
-	depends on EXFAT_FS
-	default y
-	help
-	  By default, the exFAT driver will only mount exFAT filesystems, and refuse
-	  to mount fat/vfat filesystems.  Set this to 'n' to allow the exFAT driver
-	  to mount these filesystems.
-
 config EXFAT_DISCARD
 	bool "enable discard support"
 	depends on EXFAT_FS
diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index 72cf40e123de..68f79e13af2b 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -915,8 +915,6 @@ s32 resolve_path(struct inode *inode, char *path, struct chain_t *p_dir,
 s32 resolve_name(u8 *name, u8 **arg);
 
 /* file operation functions */
-s32 fat16_mount(struct super_block *sb, struct pbr_sector_t *p_pbr);
-s32 fat32_mount(struct super_block *sb, struct pbr_sector_t *p_pbr);
 s32 exfat_mount(struct super_block *sb, struct pbr_sector_t *p_pbr);
 s32 create_dir(struct inode *inode, struct chain_t *p_dir,
 	       struct uni_name_t *p_uniname, struct file_id_t *fid);
diff --git a/drivers/staging/exfat/exfat_core.c b/drivers/staging/exfat/exfat_core.c
index 1f0ef94bdd47..89bed7460162 100644
--- a/drivers/staging/exfat/exfat_core.c
+++ b/drivers/staging/exfat/exfat_core.c
@@ -1284,57 +1284,6 @@ s32 exfat_init_dir_entry(struct super_block *sb, struct chain_t *p_dir,
 	return 0;
 }
 
-static s32 fat_init_ext_entry(struct super_block *sb, struct chain_t *p_dir,
-			      s32 entry, s32 num_entries,
-			      struct uni_name_t *p_uniname,
-			      struct dos_name_t *p_dosname)
-{
-	int i;
-	sector_t sector;
-	u8 chksum;
-	u16 *uniname = p_uniname->name;
-	struct dos_dentry_t *dos_ep;
-	struct ext_dentry_t *ext_ep;
-
-	dos_ep = (struct dos_dentry_t *)get_entry_in_dir(sb, p_dir, entry,
-							 &sector);
-	if (!dos_ep)
-		return -EIO;
-
-	dos_ep->lcase = p_dosname->name_case;
-	memcpy(dos_ep->name, p_dosname->name, DOS_NAME_LENGTH);
-	buf_modify(sb, sector);
-
-	if ((--num_entries) > 0) {
-		chksum = calc_checksum_1byte((void *)dos_ep->name,
-					     DOS_NAME_LENGTH, 0);
-
-		for (i = 1; i < num_entries; i++) {
-			ext_ep = (struct ext_dentry_t *)get_entry_in_dir(sb,
-									 p_dir,
-									 entry - i,
-									 &sector);
-			if (!ext_ep)
-				return -EIO;
-
-			init_ext_entry(ext_ep, i, chksum, uniname);
-			buf_modify(sb, sector);
-			uniname += 13;
-		}
-
-		ext_ep = (struct ext_dentry_t *)get_entry_in_dir(sb, p_dir,
-								 entry - i,
-								 &sector);
-		if (!ext_ep)
-			return -EIO;
-
-		init_ext_entry(ext_ep, i + 0x40, chksum, uniname);
-		buf_modify(sb, sector);
-	}
-
-	return 0;
-}
-
 static s32 exfat_init_ext_entry(struct super_block *sb, struct chain_t *p_dir,
 				s32 entry, s32 num_entries,
 				struct uni_name_t *p_uniname,
@@ -2981,148 +2930,6 @@ s32 resolve_path(struct inode *inode, char *path, struct chain_t *p_dir,
 /*
  *  File Operation Functions
  */
-static struct fs_func fat_fs_func = {
-	.alloc_cluster = fat_alloc_cluster,
-	.free_cluster = fat_free_cluster,
-	.count_used_clusters = fat_count_used_clusters,
-
-	.init_dir_entry = fat_init_dir_entry,
-	.init_ext_entry = fat_init_ext_entry,
-	.find_dir_entry = fat_find_dir_entry,
-	.delete_dir_entry = fat_delete_dir_entry,
-	.get_uni_name_from_ext_entry = fat_get_uni_name_from_ext_entry,
-	.count_ext_entries = fat_count_ext_entries,
-	.calc_num_entries = fat_calc_num_entries,
-
-	.get_entry_type = fat_get_entry_type,
-	.set_entry_type = fat_set_entry_type,
-	.get_entry_attr = fat_get_entry_attr,
-	.set_entry_attr = fat_set_entry_attr,
-	.get_entry_flag = fat_get_entry_flag,
-	.set_entry_flag = fat_set_entry_flag,
-	.get_entry_clu0 = fat_get_entry_clu0,
-	.set_entry_clu0 = fat_set_entry_clu0,
-	.get_entry_size = fat_get_entry_size,
-	.set_entry_size = fat_set_entry_size,
-	.get_entry_time = fat_get_entry_time,
-	.set_entry_time = fat_set_entry_time,
-};
-
-s32 fat16_mount(struct super_block *sb, struct pbr_sector_t *p_pbr)
-{
-	s32 num_reserved, num_root_sectors;
-	struct bpb16_t *p_bpb = (struct bpb16_t *)p_pbr->bpb;
-	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
-	struct bd_info_t *p_bd = &(EXFAT_SB(sb)->bd_info);
-
-	if (p_bpb->num_fats == 0)
-		return -EFSCORRUPTED;
-
-	num_root_sectors = GET16(p_bpb->num_root_entries) << DENTRY_SIZE_BITS;
-	num_root_sectors = ((num_root_sectors - 1) >>
-			    p_bd->sector_size_bits) + 1;
-
-	p_fs->sectors_per_clu = p_bpb->sectors_per_clu;
-	p_fs->sectors_per_clu_bits = ilog2(p_bpb->sectors_per_clu);
-	p_fs->cluster_size_bits = p_fs->sectors_per_clu_bits +
-				  p_bd->sector_size_bits;
-	p_fs->cluster_size = 1 << p_fs->cluster_size_bits;
-
-	p_fs->num_FAT_sectors = GET16(p_bpb->num_fat_sectors);
-
-	p_fs->FAT1_start_sector = p_fs->PBR_sector + GET16(p_bpb->num_reserved);
-	if (p_bpb->num_fats == 1)
-		p_fs->FAT2_start_sector = p_fs->FAT1_start_sector;
-	else
-		p_fs->FAT2_start_sector = p_fs->FAT1_start_sector +
-					  p_fs->num_FAT_sectors;
-
-	p_fs->root_start_sector = p_fs->FAT2_start_sector +
-				  p_fs->num_FAT_sectors;
-	p_fs->data_start_sector = p_fs->root_start_sector + num_root_sectors;
-
-	p_fs->num_sectors = GET16(p_bpb->num_sectors);
-	if (p_fs->num_sectors == 0)
-		p_fs->num_sectors = GET32(p_bpb->num_huge_sectors);
-
-	num_reserved = p_fs->data_start_sector - p_fs->PBR_sector;
-	p_fs->num_clusters = ((p_fs->num_sectors - num_reserved) >>
-			      p_fs->sectors_per_clu_bits) + 2;
-	/* because the cluster index starts with 2 */
-
-	if (p_fs->num_clusters < FAT12_THRESHOLD)
-		p_fs->vol_type = FAT12;
-	else
-		p_fs->vol_type = FAT16;
-	p_fs->vol_id = GET32(p_bpb->vol_serial);
-
-	p_fs->root_dir = 0;
-	p_fs->dentries_in_root = GET16(p_bpb->num_root_entries);
-	p_fs->dentries_per_clu = 1 << (p_fs->cluster_size_bits -
-				       DENTRY_SIZE_BITS);
-
-	p_fs->vol_flag = VOL_CLEAN;
-	p_fs->clu_srch_ptr = 2;
-	p_fs->used_clusters = UINT_MAX;
-
-	p_fs->fs_func = &fat_fs_func;
-
-	return 0;
-}
-
-s32 fat32_mount(struct super_block *sb, struct pbr_sector_t *p_pbr)
-{
-	s32 num_reserved;
-	struct bpb32_t *p_bpb = (struct bpb32_t *)p_pbr->bpb;
-	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
-	struct bd_info_t *p_bd = &(EXFAT_SB(sb)->bd_info);
-
-	if (p_bpb->num_fats == 0)
-		return -EFSCORRUPTED;
-
-	p_fs->sectors_per_clu = p_bpb->sectors_per_clu;
-	p_fs->sectors_per_clu_bits = ilog2(p_bpb->sectors_per_clu);
-	p_fs->cluster_size_bits = p_fs->sectors_per_clu_bits +
-				  p_bd->sector_size_bits;
-	p_fs->cluster_size = 1 << p_fs->cluster_size_bits;
-
-	p_fs->num_FAT_sectors = GET32(p_bpb->num_fat32_sectors);
-
-	p_fs->FAT1_start_sector = p_fs->PBR_sector + GET16(p_bpb->num_reserved);
-	if (p_bpb->num_fats == 1)
-		p_fs->FAT2_start_sector = p_fs->FAT1_start_sector;
-	else
-		p_fs->FAT2_start_sector = p_fs->FAT1_start_sector +
-					  p_fs->num_FAT_sectors;
-
-	p_fs->root_start_sector = p_fs->FAT2_start_sector +
-				  p_fs->num_FAT_sectors;
-	p_fs->data_start_sector = p_fs->root_start_sector;
-
-	p_fs->num_sectors = GET32(p_bpb->num_huge_sectors);
-	num_reserved = p_fs->data_start_sector - p_fs->PBR_sector;
-
-	p_fs->num_clusters = ((p_fs->num_sectors - num_reserved) >>
-			      p_fs->sectors_per_clu_bits) + 2;
-	/* because the cluster index starts with 2 */
-
-	p_fs->vol_type = FAT32;
-	p_fs->vol_id = GET32(p_bpb->vol_serial);
-
-	p_fs->root_dir = GET32(p_bpb->root_cluster);
-	p_fs->dentries_in_root = 0;
-	p_fs->dentries_per_clu = 1 << (p_fs->cluster_size_bits -
-				       DENTRY_SIZE_BITS);
-
-	p_fs->vol_flag = VOL_CLEAN;
-	p_fs->clu_srch_ptr = 2;
-	p_fs->used_clusters = UINT_MAX;
-
-	p_fs->fs_func = &fat_fs_func;
-
-	return 0;
-}
-
 static struct fs_func exfat_fs_func = {
 	.alloc_cluster = exfat_alloc_cluster,
 	.free_cluster = exfat_free_cluster,
diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index e2254d45ef6e..10e0a75765d9 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -396,16 +396,10 @@ static int ffsMountVol(struct super_block *sb)
 			break;
 
 	if (i < 53) {
-#ifdef CONFIG_EXFAT_DONT_MOUNT_VFAT
+		/* Not sure how we'd get here, but complain if it does */
 		ret = -EINVAL;
 		pr_info("EXFAT: Attempted to mount VFAT filesystem\n");
 		goto out;
-#else
-		if (GET16(p_pbr->bpb + 11)) /* num_fat_sectors */
-			ret = fat16_mount(sb, p_pbr);
-		else
-			ret = fat32_mount(sb, p_pbr);
-#endif
 	} else {
 		ret = exfat_mount(sb, p_pbr);
 	}
-- 
2.24.0

