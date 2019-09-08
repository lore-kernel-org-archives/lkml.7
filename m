Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_ADSP_ALL,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A6F1C433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 15:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 011BE214D9
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 15:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=valentin-vidic.from.hr header.i=@valentin-vidic.from.hr header.b="QEwHuc12"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbfIHP0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 11:26:25 -0400
Received: from valentin-vidic.from.hr ([94.229.67.141]:56353 "EHLO
        valentin-vidic.from.hr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727213AbfIHP0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 11:26:24 -0400
X-Virus-Scanned: Debian amavisd-new at valentin-vidic.from.hr
Received: by valentin-vidic.from.hr (Postfix, from userid 1000)
        id A090A216; Sun,  8 Sep 2019 15:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
        d=valentin-vidic.from.hr; s=2017; t=1567956382;
        bh=otD4YtoGAnYiwKsiyXlPmaPgOS8/hYDsF7LNBx+rN88=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QEwHuc12TN4TaxOWvpJKV97Z6OldPbuuAd5AKsStLBfQrknH5rJ2eev9wQj29lox6
         LbJ27cq1r5imOorWdAS7ZC6Se7uUilZ6GoWBa4HWu67JwiWPtkKEa7eDFkgQstVy6n
         KVH+qRNuowFT2FBb0UlCOqG7/VglCBkanjTkN7uCeUONg2A/yfXeYW0PlaZKulxDOj
         pAoTHf2E0QcVr4d7H8rTW+JK13kGFj8vGZvMGD1abwqYUfc6NwmTujEmWpA0LN4w5d
         3MMbwM4h8M7TTIY28mTD8OEWs6OlBufG9PQUfHWkCVyL+j7rNQzTm7fN/qZ886rsl/
         /5iRXZbCYfuQA==
From:   Valentin Vidic <vvidic@valentin-vidic.from.hr>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Valentin Vidic <vvidic@valentin-vidic.from.hr>
Subject: [PATCH v3 3/3] staging: exfat: use integer constants
Date:   Sun,  8 Sep 2019 15:26:16 +0000
Message-Id: <20190908152616.25459-3-vvidic@valentin-vidic.from.hr>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190908152616.25459-1-vvidic@valentin-vidic.from.hr>
References: <20190908152616.25459-1-vvidic@valentin-vidic.from.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace manually generated values with predefined constants.

Signed-off-by: Valentin Vidic <vvidic@valentin-vidic.from.hr>
---
v2: Use constants where possible
v3: Split up changes of constants

 drivers/staging/exfat/exfat_core.c  | 18 +++++++++---------
 drivers/staging/exfat/exfat_super.c |  8 ++++----
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/exfat/exfat_core.c b/drivers/staging/exfat/exfat_core.c
index 8965e8453fcb..6eee2aa06bd7 100644
--- a/drivers/staging/exfat/exfat_core.c
+++ b/drivers/staging/exfat/exfat_core.c
@@ -204,7 +204,7 @@ s32 fat_alloc_cluster(struct super_block *sb, s32 num_alloc,
 
 			if ((--num_alloc) == 0) {
 				p_fs->clu_srch_ptr = new_clu;
-				if (p_fs->used_clusters != (u32)~0)
+				if (p_fs->used_clusters != UINT_MAX)
 					p_fs->used_clusters += num_clusters;
 
 				return num_clusters;
@@ -215,7 +215,7 @@ s32 fat_alloc_cluster(struct super_block *sb, s32 num_alloc,
 	}
 
 	p_fs->clu_srch_ptr = new_clu;
-	if (p_fs->used_clusters != (u32)~0)
+	if (p_fs->used_clusters != UINT_MAX)
 		p_fs->used_clusters += num_clusters;
 
 	return num_clusters;
@@ -273,7 +273,7 @@ s32 exfat_alloc_cluster(struct super_block *sb, s32 num_alloc,
 
 		if ((--num_alloc) == 0) {
 			p_fs->clu_srch_ptr = hint_clu;
-			if (p_fs->used_clusters != (u32)~0)
+			if (p_fs->used_clusters != UINT_MAX)
 				p_fs->used_clusters += num_clusters;
 
 			p_chain->size += num_clusters;
@@ -293,7 +293,7 @@ s32 exfat_alloc_cluster(struct super_block *sb, s32 num_alloc,
 	}
 
 	p_fs->clu_srch_ptr = hint_clu;
-	if (p_fs->used_clusters != (u32)~0)
+	if (p_fs->used_clusters != UINT_MAX)
 		p_fs->used_clusters += num_clusters;
 
 	p_chain->size += num_clusters;
@@ -337,7 +337,7 @@ void fat_free_cluster(struct super_block *sb, struct chain_t *p_chain,
 
 	} while (clu != CLUSTER_32(~0));
 
-	if (p_fs->used_clusters != (u32)~0)
+	if (p_fs->used_clusters != UINT_MAX)
 		p_fs->used_clusters -= num_clusters;
 }
 
@@ -396,7 +396,7 @@ void exfat_free_cluster(struct super_block *sb, struct chain_t *p_chain,
 		} while ((clu != CLUSTER_32(0)) && (clu != CLUSTER_32(~0)));
 	}
 
-	if (p_fs->used_clusters != (u32)~0)
+	if (p_fs->used_clusters != UINT_MAX)
 		p_fs->used_clusters -= num_clusters;
 }
 
@@ -3064,7 +3064,7 @@ s32 fat16_mount(struct super_block *sb, struct pbr_sector_t *p_pbr)
 
 	p_fs->vol_flag = VOL_CLEAN;
 	p_fs->clu_srch_ptr = 2;
-	p_fs->used_clusters = (u32)~0;
+	p_fs->used_clusters = UINT_MAX;
 
 	p_fs->fs_func = &fat_fs_func;
 
@@ -3117,7 +3117,7 @@ s32 fat32_mount(struct super_block *sb, struct pbr_sector_t *p_pbr)
 
 	p_fs->vol_flag = VOL_CLEAN;
 	p_fs->clu_srch_ptr = 2;
-	p_fs->used_clusters = (u32)~0;
+	p_fs->used_clusters = UINT_MAX;
 
 	p_fs->fs_func = &fat_fs_func;
 
@@ -3192,7 +3192,7 @@ s32 exfat_mount(struct super_block *sb, struct pbr_sector_t *p_pbr)
 
 	p_fs->vol_flag = (u32)GET16(p_bpb->vol_flags);
 	p_fs->clu_srch_ptr = 2;
-	p_fs->used_clusters = (u32)~0;
+	p_fs->used_clusters = UINT_MAX;
 
 	p_fs->fs_func = &exfat_fs_func;
 
diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index 1cb0ec06c54e..610f20683611 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -502,7 +502,7 @@ static int ffsGetVolInfo(struct super_block *sb, struct vol_info_t *info)
 	/* acquire the lock for file system critical section */
 	down(&p_fs->v_sem);
 
-	if (p_fs->used_clusters == (u32)~0)
+	if (p_fs->used_clusters == UINT_MAX)
 		p_fs->used_clusters = p_fs->fs_func->count_used_clusters(sb);
 
 	info->FatType = p_fs->vol_type;
@@ -3503,7 +3503,7 @@ static int exfat_statfs(struct dentry *dentry, struct kstatfs *buf)
 	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
 	struct vol_info_t info;
 
-	if (p_fs->used_clusters == (u32)~0) {
+	if (p_fs->used_clusters == UINT_MAX) {
 		if (ffsGetVolInfo(sb, &info) == FFS_MEDIAERR)
 			return -EIO;
 
@@ -3678,7 +3678,7 @@ static int parse_options(char *options, int silent, int *debug,
 	opts->fs_uid = current_uid();
 	opts->fs_gid = current_gid();
 	opts->fs_fmask = opts->fs_dmask = current->fs->umask;
-	opts->allow_utime = (unsigned short)-1;
+	opts->allow_utime = U16_MAX;
 	opts->codepage = exfat_default_codepage;
 	opts->iocharset = exfat_default_iocharset;
 	opts->casesensitive = 0;
@@ -3770,7 +3770,7 @@ static int parse_options(char *options, int silent, int *debug,
 	}
 
 out:
-	if (opts->allow_utime == (unsigned short)-1)
+	if (opts->allow_utime == U16_MAX)
 		opts->allow_utime = ~opts->fs_dmask & 0022;
 
 	return 0;
-- 
2.20.1

