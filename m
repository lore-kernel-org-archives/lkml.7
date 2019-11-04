Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F54CA9EBB
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 01:45:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF39E222C7
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 01:45:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728862AbfKDBpz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 20:45:55 -0500
Received: from outbound.smtp.vt.edu ([198.82.183.121]:39712 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728519AbfKDBpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 20:45:55 -0500
Received: from mr4.cc.vt.edu (mail.ipv6.vt.edu [IPv6:2607:b400:92:9:0:9d:8fcb:4116])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id xA41jr7w025744
        for <linux-kernel@vger.kernel.org>; Sun, 3 Nov 2019 20:45:53 -0500
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
        by mr4.cc.vt.edu (8.14.7/8.14.7) with ESMTP id xA41jmQp025939
        for <linux-kernel@vger.kernel.org>; Sun, 3 Nov 2019 20:45:53 -0500
Received: by mail-qt1-f198.google.com with SMTP id g5so10744191qtc.5
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2019 17:45:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=20ClKaSxdTtYUl7yKYvg1lJfKYAyqVPXfA1ed+3FbDA=;
        b=OGw1tX8CnaaIZ1d1y3xoMRxxzVBcCmgQJl1cB3INYayaHvJwHJjTyVrwxZV1WNcSQn
         bThvbgJu4K86c4tsk+50E9rl7gNxHW4f8HKrFRIOgqMghT26vksITMhNZ+lX2VajbBUy
         IZHzqEt3AVzhLt83qXvtK8UaKGwahKVlwy5xVMF2orQDGkjOeVR2TloiOXy+fpT2P0Ya
         RWD9XjcfVujPqTP046ytK7rjLdldQ1uL+DL1OfhG2GbqOm5ZQrHK7Cag0CNXYoQ/y+5x
         lRIbrmlFMIKC4eps6+5O/pQ0KWKH+DCgSDPVRaN8ES7zuJ6sV9jiTrUOOObdEF+tntzn
         PhfA==
X-Gm-Message-State: APjAAAXQVA2RU1EBYD287McyOt9vEyTnTchgu0Zb5Be5Ie1CBJVE5qzi
        CRbuo/ZJ5njvfKJ706MZxwqOi2R1v4MtrXefWbYr9+8eKW2admz0kGdR6tsnR8gV6mlaX01M2lu
        Mka/YZXJ3OZbaKz6Hu3Q7DuoLQ9E0v+noFKI=
X-Received: by 2002:a37:4a92:: with SMTP id x140mr161863qka.24.1572831948512;
        Sun, 03 Nov 2019 17:45:48 -0800 (PST)
X-Google-Smtp-Source: APXvYqwbDRmzYHUGWNH5Sgtu91J2HEyqdoVZnJbx1gLacnfOaGwU1RcbU9QveIo4fdPjLOTXuwToSg==
X-Received: by 2002:a37:4a92:: with SMTP id x140mr161854qka.24.1572831948246;
        Sun, 03 Nov 2019 17:45:48 -0800 (PST)
Received: from turing-police.lan ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id d2sm8195354qkg.77.2019.11.03.17.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2019 17:45:47 -0800 (PST)
From:   Valdis Kletnieks <valdis.kletnieks@vt.edu>
X-Google-Original-From: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
To:     Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
Cc:     Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 01/10] staging: exfat: Clean up return codes - FFS_FORMATERR
Date:   Sun,  3 Nov 2019 20:44:57 -0500
Message-Id: <20191104014510.102356-2-Valdis.Kletnieks@vt.edu>
X-Mailer: git-send-email 2.24.0.rc1
In-Reply-To: <20191104014510.102356-1-Valdis.Kletnieks@vt.edu>
References: <20191104014510.102356-1-Valdis.Kletnieks@vt.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert FFS_FORMATERR to -EFSCORRUPTED

Signed-off-by: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
---
 drivers/staging/exfat/exfat.h      | 3 ++-
 drivers/staging/exfat/exfat_core.c | 8 ++++----
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index acb73f47a253..4f9ba235d967 100644
--- a/drivers/staging/exfat/exfat.h
+++ b/drivers/staging/exfat/exfat.h
@@ -30,6 +30,8 @@
 #undef DEBUG
 #endif
 
+#define EFSCORRUPTED	EUCLEAN		/* Filesystem is corrupted */
+
 #define DENTRY_SIZE		32	/* dir entry size */
 #define DENTRY_SIZE_BITS	5
 
@@ -209,7 +211,6 @@ static inline u16 get_row_index(u16 i)
 /* return values */
 #define FFS_SUCCESS             0
 #define FFS_MEDIAERR            1
-#define FFS_FORMATERR           2
 #define FFS_MOUNTED             3
 #define FFS_NOTMOUNTED          4
 #define FFS_ALIGNMENTERR        5
diff --git a/drivers/staging/exfat/exfat_core.c b/drivers/staging/exfat/exfat_core.c
index b23fbf3ebaa5..e90b54a17150 100644
--- a/drivers/staging/exfat/exfat_core.c
+++ b/drivers/staging/exfat/exfat_core.c
@@ -573,7 +573,7 @@ s32 load_alloc_bitmap(struct super_block *sb)
 			return FFS_MEDIAERR;
 	}
 
-	return FFS_FORMATERR;
+	return -EFSCORRUPTED;
 }
 
 void free_alloc_bitmap(struct super_block *sb)
@@ -3016,7 +3016,7 @@ s32 fat16_mount(struct super_block *sb, struct pbr_sector_t *p_pbr)
 	struct bd_info_t *p_bd = &(EXFAT_SB(sb)->bd_info);
 
 	if (p_bpb->num_fats == 0)
-		return FFS_FORMATERR;
+		return -EFSCORRUPTED;
 
 	num_root_sectors = GET16(p_bpb->num_root_entries) << DENTRY_SIZE_BITS;
 	num_root_sectors = ((num_root_sectors - 1) >>
@@ -3078,7 +3078,7 @@ s32 fat32_mount(struct super_block *sb, struct pbr_sector_t *p_pbr)
 	struct bd_info_t *p_bd = &(EXFAT_SB(sb)->bd_info);
 
 	if (p_bpb->num_fats == 0)
-		return FFS_FORMATERR;
+		return -EFSCORRUPTED;
 
 	p_fs->sectors_per_clu = p_bpb->sectors_per_clu;
 	p_fs->sectors_per_clu_bits = ilog2(p_bpb->sectors_per_clu);
@@ -3157,7 +3157,7 @@ s32 exfat_mount(struct super_block *sb, struct pbr_sector_t *p_pbr)
 	struct bd_info_t *p_bd = &(EXFAT_SB(sb)->bd_info);
 
 	if (p_bpb->num_fats == 0)
-		return FFS_FORMATERR;
+		return -EFSCORRUPTED;
 
 	p_fs->sectors_per_clu = 1 << p_bpb->sectors_per_clu_bits;
 	p_fs->sectors_per_clu_bits = p_bpb->sectors_per_clu_bits;
-- 
2.24.0.rc1

