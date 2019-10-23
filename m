Return-Path: <SRS0=OaAC=YQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34CD8CA9EAE
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 05:28:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 070B121920
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Oct 2019 05:28:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389488AbfJWF2k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Oct 2019 01:28:40 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:44860 "EHLO
        omr2.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2389389AbfJWF2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 01:28:39 -0400
Received: from mr5.cc.vt.edu (smtp.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr2.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x9N5Sbu0020016
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 01:28:37 -0400
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
        by mr5.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x9N5SWCo025841
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 01:28:37 -0400
Received: by mail-qt1-f200.google.com with SMTP id d6so20184763qtn.2
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2019 22:28:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=3R3TYJQENxlxM/7hiSPDOzoGGvmVuWM26HSA4gktLsc=;
        b=AnTzw9x/CoiZ9XzQrNXssOk4Wp1zCVFaPNPAb/XvT3B/v9o6BI5gebmGS+cEle15iJ
         EgXNXNGB5zOtDQV1ZhR1q9JUEU7yOY4tn0oYN3XYQf8owueTyy/Wp+rnujMy33vpHvds
         NZXclUIqfFXaVOZeqa68IEEXq5xYsBh7/CCeEDhbMU3APU41DpnC6SATJwaJQeJy/J1c
         oIal99S6JaKY30xVLtZNFOJ21eNU6Puu4UwQevspCzC/z1RQzieI76nUdgZes2RjkxNv
         c8trKI1E2fhSjJR38g2TxIxjpGcJQbHI+sWKXRN1dMIXcCmyEbIqATMlevfGCYYFNcd4
         ff9g==
X-Gm-Message-State: APjAAAXOJt7jeemoIrMp9vLTqgJUUpgdOK14TlxIBVSdKZ7YG1j2+TXY
        e4KfxZi+Xyofyy1F6nr+nBjpL3smNuQDXysS66SWf/ViZInTv0n726QjLf9YFerpvW8nIkrl0GQ
        POuGJOmTSEFIyGiYtgfdbJOeT+C+or+Y5ls4=
X-Received: by 2002:ac8:70c3:: with SMTP id g3mr7202618qtp.391.1571808512070;
        Tue, 22 Oct 2019 22:28:32 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzy4r7y16DC8h4ydIFPzLdAGCvDsekngAhlepEpIYK5p7QCs9OYpm9liB0aPVEfxDo6Cc6ONA==
X-Received: by 2002:ac8:70c3:: with SMTP id g3mr7202598qtp.391.1571808511686;
        Tue, 22 Oct 2019 22:28:31 -0700 (PDT)
Received: from turing-police.lan ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id 14sm10397445qtb.54.2019.10.22.22.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2019 22:28:30 -0700 (PDT)
From:   Valdis Kletnieks <valdis.kletnieks@vt.edu>
X-Google-Original-From: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Valdis.Kletnieks@vt.edu
Cc:     Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] staging: exfat: Clean up static definitions in exfat_cache.c
Date:   Wed, 23 Oct 2019 01:27:48 -0400
Message-Id: <20191023052752.693689-6-Valdis.Kletnieks@vt.edu>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191023052752.693689-1-Valdis.Kletnieks@vt.edu>
References: <20191023052752.693689-1-Valdis.Kletnieks@vt.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move static function bodies before first use, remove the definition in exfat.h

Signed-off-by: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
---
 drivers/staging/exfat/exfat.h       |  4 --
 drivers/staging/exfat/exfat_cache.c | 94 +++++++++++++++--------------
 2 files changed, 48 insertions(+), 50 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index dbd86a6cdc95..654a0c46c1a0 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -768,17 +768,13 @@ void buf_init(struct super_block *sb);
 void buf_shutdown(struct super_block *sb);
 int FAT_read(struct super_block *sb, u32 loc, u32 *content);
 s32 FAT_write(struct super_block *sb, u32 loc, u32 content);
-static u8 *FAT_getblk(struct super_block *sb, sector_t sec);
-static void FAT_modify(struct super_block *sb, sector_t sec);
 void FAT_release_all(struct super_block *sb);
-static void FAT_sync(struct super_block *sb);
 u8 *buf_getblk(struct super_block *sb, sector_t sec);
 void buf_modify(struct super_block *sb, sector_t sec);
 void buf_lock(struct super_block *sb, sector_t sec);
 void buf_unlock(struct super_block *sb, sector_t sec);
 void buf_release(struct super_block *sb, sector_t sec);
 void buf_release_all(struct super_block *sb);
-static void buf_sync(struct super_block *sb);
 
 /* fs management functions */
 void fs_set_vol_flags(struct super_block *sb, u32 new_flag);
diff --git a/drivers/staging/exfat/exfat_cache.c b/drivers/staging/exfat/exfat_cache.c
index e1b001718709..e9ad0353b4e5 100644
--- a/drivers/staging/exfat/exfat_cache.c
+++ b/drivers/staging/exfat/exfat_cache.c
@@ -193,6 +193,50 @@ void buf_shutdown(struct super_block *sb)
 {
 }
 
+static u8 *FAT_getblk(struct super_block *sb, sector_t sec)
+{
+	struct buf_cache_t *bp;
+	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
+
+	bp = FAT_cache_find(sb, sec);
+	if (bp) {
+		move_to_mru(bp, &p_fs->FAT_cache_lru_list);
+		return bp->buf_bh->b_data;
+	}
+
+	bp = FAT_cache_get(sb, sec);
+
+	FAT_cache_remove_hash(bp);
+
+	bp->drv = p_fs->drv;
+	bp->sec = sec;
+	bp->flag = 0;
+
+	FAT_cache_insert_hash(sb, bp);
+
+	if (sector_read(sb, sec, &bp->buf_bh, 1) != FFS_SUCCESS) {
+		FAT_cache_remove_hash(bp);
+		bp->drv = -1;
+		bp->sec = ~0;
+		bp->flag = 0;
+		bp->buf_bh = NULL;
+
+		move_to_lru(bp, &p_fs->FAT_cache_lru_list);
+		return NULL;
+	}
+
+	return bp->buf_bh->b_data;
+}
+
+static void FAT_modify(struct super_block *sb, sector_t sec)
+{
+	struct buf_cache_t *bp;
+
+	bp = FAT_cache_find(sb, sec);
+	if (bp)
+		sector_write(sb, sec, bp->buf_bh, 0);
+}
+
 static int __FAT_read(struct super_block *sb, u32 loc, u32 *content)
 {
 	s32 off;
@@ -441,50 +485,6 @@ int FAT_write(struct super_block *sb, u32 loc, u32 content)
 	return ret;
 }
 
-u8 *FAT_getblk(struct super_block *sb, sector_t sec)
-{
-	struct buf_cache_t *bp;
-	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
-
-	bp = FAT_cache_find(sb, sec);
-	if (bp) {
-		move_to_mru(bp, &p_fs->FAT_cache_lru_list);
-		return bp->buf_bh->b_data;
-	}
-
-	bp = FAT_cache_get(sb, sec);
-
-	FAT_cache_remove_hash(bp);
-
-	bp->drv = p_fs->drv;
-	bp->sec = sec;
-	bp->flag = 0;
-
-	FAT_cache_insert_hash(sb, bp);
-
-	if (sector_read(sb, sec, &bp->buf_bh, 1) != FFS_SUCCESS) {
-		FAT_cache_remove_hash(bp);
-		bp->drv = -1;
-		bp->sec = ~0;
-		bp->flag = 0;
-		bp->buf_bh = NULL;
-
-		move_to_lru(bp, &p_fs->FAT_cache_lru_list);
-		return NULL;
-	}
-
-	return bp->buf_bh->b_data;
-}
-
-void FAT_modify(struct super_block *sb, sector_t sec)
-{
-	struct buf_cache_t *bp;
-
-	bp = FAT_cache_find(sb, sec);
-	if (bp)
-		sector_write(sb, sec, bp->buf_bh, 0);
-}
-
 void FAT_release_all(struct super_block *sb)
 {
 	struct buf_cache_t *bp;
@@ -510,7 +510,8 @@ void FAT_release_all(struct super_block *sb)
 	up(&f_sem);
 }
 
-void FAT_sync(struct super_block *sb)
+/* FIXME - this function is not used anyplace. See TODO */
+static void FAT_sync(struct super_block *sb)
 {
 	struct buf_cache_t *bp;
 	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
@@ -704,7 +705,8 @@ void buf_release_all(struct super_block *sb)
 	up(&b_sem);
 }
 
-void buf_sync(struct super_block *sb)
+/* FIXME - this function is not used anyplace. See TODO */
+static void buf_sync(struct super_block *sb)
 {
 	struct buf_cache_t *bp;
 	struct fs_info_t *p_fs = &(EXFAT_SB(sb)->fs_info);
-- 
2.23.0

