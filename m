Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D0ECA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 15:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C110920684
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 15:54:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503365AbfJXPyu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 11:54:50 -0400
Received: from outbound.smtp.vt.edu ([198.82.183.121]:42972 "EHLO
        omr1.cc.vt.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2503351AbfJXPyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 11:54:41 -0400
Received: from mr6.cc.vt.edu (mr6.cc.ipv6.vt.edu [IPv6:2607:b400:92:8500:0:af:2d00:4488])
        by omr1.cc.vt.edu (8.14.4/8.14.4) with ESMTP id x9OFseYV010376
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 11:54:40 -0400
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
        by mr6.cc.vt.edu (8.14.7/8.14.7) with ESMTP id x9OFsYXR021836
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 11:54:39 -0400
Received: by mail-qk1-f197.google.com with SMTP id b29so23739079qka.23
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 08:54:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=D/1VhmAhD3zi1l2243w8fbyxsU10KIHq0czBUcE2Eo8=;
        b=C7gh6FhcjOVqLfS7ZdmFEGft+JCU5TmUbC14gWcFk4it2/XRp/N+dOvRhP0R7BfnpI
         /YvXbf9XsX9hzm5cTXuZs061do0riXm6xBTsYUm9d7LXxUrLPSi1PPn6Z1VReu4fEPTI
         AIkbjwiOTHr2fBfgKy/gom6MKfxXYj3OlezAVweA8fAzeuY7Qcj/Yxr5sYAYIUqyF10V
         LUaEAG1v7FB7Jj1JP8Lcf02CVBUxfT1Gw1j8aLgtKa32oB5YNz8xRiuVNzOcvd4dCOLH
         +SiWj5oqJ1+VTH04wcs1E1aM8aqOeYi4dV+OrsCUqy/jsEbw+0+fpxUrVneDMbRJNaDg
         koTw==
X-Gm-Message-State: APjAAAV0Z4bzs5nwjK7OevMNDpAOo7humMSY6Tzob+6UUAscC2BGs4mq
        iAp9bboplJFIeMhsNxppUoLrCpyouOIKnebGdVN4UjYGOrEGvZpuLX7eVRJ1HGYHnDztVotWFL5
        5JhZxJPgfUxarfGrmPNVwE/ZnG0Vwu5xFViU=
X-Received: by 2002:a37:a50a:: with SMTP id o10mr14381380qke.115.1571932474701;
        Thu, 24 Oct 2019 08:54:34 -0700 (PDT)
X-Google-Smtp-Source: APXvYqy4esJktLLI4kSKiGMacw/otWmsfL+5VwGdnUH9R6Wajz3T1AOiruITnXjnTZAYbU4iCu4DWw==
X-Received: by 2002:a37:a50a:: with SMTP id o10mr14381364qke.115.1571932474401;
        Thu, 24 Oct 2019 08:54:34 -0700 (PDT)
Received: from turing-police.lan ([2601:5c0:c001:c9e1::359])
        by smtp.gmail.com with ESMTPSA id x133sm12693274qka.44.2019.10.24.08.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Oct 2019 08:54:33 -0700 (PDT)
From:   Valdis Kletnieks <valdis.kletnieks@vt.edu>
X-Google-Original-From: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Valdis Kletnieks <Valdis.Kletnieks@vt.edu>,
        Valdis Kletnieks <valdis.kletnieks@vt.edu>,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/15] staging: exfat: Clean up return codes - FFS_FORMATERR
Date:   Thu, 24 Oct 2019 11:53:20 -0400
Message-Id: <20191024155327.1095907-10-Valdis.Kletnieks@vt.edu>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191024155327.1095907-1-Valdis.Kletnieks@vt.edu>
References: <20191024155327.1095907-1-Valdis.Kletnieks@vt.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert FFS_FORMATERR to -EFSCORRUPTED

Signed-off-by: Valdis Kletnieks <Valdis.Kletnieks@vt.edu>
---
 drivers/staging/exfat/exfat.h       | 3 ++-
 drivers/staging/exfat/exfat_core.c  | 4 ++--
 drivers/staging/exfat/exfat_super.c | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/exfat/exfat.h b/drivers/staging/exfat/exfat.h
index 2588a6cbe552..7ca187e77cbe 100644
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
index fa2bf18b4a14..39c103e73b63 100644
--- a/drivers/staging/exfat/exfat_core.c
+++ b/drivers/staging/exfat/exfat_core.c
@@ -205,7 +205,7 @@ s32 load_alloc_bitmap(struct super_block *sb)
 			return FFS_MEDIAERR;
 	}
 
-	return FFS_FORMATERR;
+	return -EFSCORRUPTED;
 }
 
 void free_alloc_bitmap(struct super_block *sb)
@@ -2309,7 +2309,7 @@ s32 exfat_mount(struct super_block *sb, struct pbr_sector_t *p_pbr)
 	struct bd_info_t *p_bd = &(EXFAT_SB(sb)->bd_info);
 
 	if (p_bpb->num_fats == 0)
-		return FFS_FORMATERR;
+		return -EFSCORRUPTED;
 
 	p_fs->sectors_per_clu = 1 << p_bpb->sectors_per_clu_bits;
 	p_fs->sectors_per_clu_bits = p_bpb->sectors_per_clu_bits;
diff --git a/drivers/staging/exfat/exfat_super.c b/drivers/staging/exfat/exfat_super.c
index 5b35e3683605..161971c80c02 100644
--- a/drivers/staging/exfat/exfat_super.c
+++ b/drivers/staging/exfat/exfat_super.c
@@ -384,7 +384,7 @@ static int ffsMountVol(struct super_block *sb)
 	if (GET16_A(p_pbr->signature) != PBR_SIGNATURE) {
 		brelse(tmp_bh);
 		bdev_close(sb);
-		ret = FFS_FORMATERR;
+		ret = -EFSCORRUPTED;
 		goto out;
 	}
 
-- 
2.23.0

