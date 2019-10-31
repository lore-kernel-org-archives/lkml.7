Return-Path: <SRS0=21RF=YY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B8CFCA9ECB
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 23:03:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DBCB2080F
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Oct 2019 23:03:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e7uWKCWt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727600AbfJaXDX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Oct 2019 19:03:23 -0400
Received: from mail-qt1-f173.google.com ([209.85.160.173]:42910 "EHLO
        mail-qt1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726602AbfJaXDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 19:03:23 -0400
Received: by mail-qt1-f173.google.com with SMTP id z17so10752819qts.9
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2019 16:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QzRITthHa6LggIeQu+O+FQbDuXS83uUpJUnnNNtWNV8=;
        b=e7uWKCWtFxcM7BHBQtZ+C7zNpjqfWuED1f0/XihIOgQbRJ8a6+hmIt87t7F82xbYMM
         P1x4YKmbiGDtetWjr9tkjVkRAqOgFLFAeoMnCIuqoAd08ztnCzaGmQwPFAMZ+qzdPUg3
         rRHwBZuHaqqZHxiUWRWXm8lPqON3rOVYnCsHOW+0A4vR2K5vUks8DXTg8NSRXUM8TtdH
         up3epXh0ydw5RbxhG4Fj+afpz3AU0P/JBOPLxNgm+Sm55C+5dlnxCJmXqEMr+II/ICrj
         E7/ab0Mlj0NLmUeeTWHEtQeBaeuVQPfhAls/n7EE7fQHp1X7onExFSItS5lU+Waaxt/5
         N8SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QzRITthHa6LggIeQu+O+FQbDuXS83uUpJUnnNNtWNV8=;
        b=JrTnYymFcmvFq9jemF3056weLkjSHKxpGDILNhAYi+voByaa6SiBvH8YTu+esQ7clX
         DSIvB3//+j4Vk13M/CHsRNJkYvpOtYynulh9bdC7VFwyBKZLgNXM6IQulX3qCWUwDwAg
         qSSJIQv29A9u/KAUYEpYt76Rv5635JW3MG6Zsi6kZhKUSyB/Eb5vibrUdfE7r8EliBge
         /ZIX+at9nUENxJRomI//uSP9ljKKhIzxkclBkZxWhn3LP4lGaoEXW4YnPFhq/iaFihcf
         dTvsjUb4E3bTxkOd85FbW8K8XXnG4lxAY4Y38Iaq02XEI9ou74izYcWSsAgdax5k0HHq
         3+Cw==
X-Gm-Message-State: APjAAAWv6HMYFKVjdfxCMRUjuxqZaNbxxlydjDvgeZuzE4tIyVC0KUNW
        Q/aS/IeAULF/1udXfl9moeo=
X-Google-Smtp-Source: APXvYqw7e/KCV1PRaZPiUSXtxV7I6Fb3aj7SJbu/VW5Ww+PueTMd05twpvUcp9lcZNRutWT3xs6Dtg==
X-Received: by 2002:ad4:5447:: with SMTP id h7mr7201009qvt.188.1572563002063;
        Thu, 31 Oct 2019 16:03:22 -0700 (PDT)
Received: from localhost.localdomain ([187.106.44.83])
        by smtp.gmail.com with ESMTPSA id s67sm2633875qkh.70.2019.10.31.16.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2019 16:03:21 -0700 (PDT)
From:   Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
To:     outreachy-kernel@googlegroups.com, gregkh@linuxfoundation.org,
        kim.jamie.bradley@gmail.com, nishkadg.linux@gmail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org
Cc:     Gabriela Bittencourt <gabrielabittencourt00@gmail.com>,
        Julia Lawall <julia.lawall@lip6.fr>
Subject: [PATCH v4 2/3] staging: rts5208: Eliminate the use of Camel Case in files xd.{h,c}
Date:   Thu, 31 Oct 2019 20:02:42 -0300
Message-Id: <20191031230243.3462-3-gabrielabittencourt00@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191031230243.3462-1-gabrielabittencourt00@gmail.com>
References: <20191031230243.3462-1-gabrielabittencourt00@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleans up checks of "Avoid CamelCase" in files xd.{h,c}

Acked-by: Julia Lawall <julia.lawall@lip6.fr>
Signed-off-by: Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
---
 drivers/staging/rts5208/xd.c | 8 ++++----
 drivers/staging/rts5208/xd.h | 6 +++---
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/rts5208/xd.c b/drivers/staging/rts5208/xd.c
index f3dc96a4c59d..0f369935fb6c 100644
--- a/drivers/staging/rts5208/xd.c
+++ b/drivers/staging/rts5208/xd.c
@@ -630,13 +630,13 @@ static int reset_xd(struct rtsx_chip *chip)
 			xd_card->zone_cnt = 32;
 			xd_card->capacity = 1024000;
 			break;
-		case xD_1G_X8_512:
+		case XD_1G_X8_512:
 			XD_PAGE_512(xd_card);
 			xd_card->addr_cycle = 4;
 			xd_card->zone_cnt = 64;
 			xd_card->capacity = 2048000;
 			break;
-		case xD_2G_X8_512:
+		case XD_2G_X8_512:
 			XD_PAGE_512(xd_card);
 			xd_card->addr_cycle = 4;
 			xd_card->zone_cnt = 128;
@@ -669,10 +669,10 @@ static int reset_xd(struct rtsx_chip *chip)
 		return STATUS_FAIL;
 	}
 
-	retval = xd_read_id(chip, READ_xD_ID, id_buf, 4);
+	retval = xd_read_id(chip, READ_XD_ID, id_buf, 4);
 	if (retval != STATUS_SUCCESS)
 		return STATUS_FAIL;
-	dev_dbg(rtsx_dev(chip), "READ_xD_ID: 0x%x 0x%x 0x%x 0x%x\n",
+	dev_dbg(rtsx_dev(chip), "READ_XD_ID: 0x%x 0x%x 0x%x 0x%x\n",
 		id_buf[0], id_buf[1], id_buf[2], id_buf[3]);
 	if (id_buf[2] != XD_ID_CODE)
 		return STATUS_FAIL;
diff --git a/drivers/staging/rts5208/xd.h b/drivers/staging/rts5208/xd.h
index 57b94129b26f..98c00f268e56 100644
--- a/drivers/staging/rts5208/xd.h
+++ b/drivers/staging/rts5208/xd.h
@@ -36,7 +36,7 @@
 #define	BLK_ERASE_1			0x60
 #define	BLK_ERASE_2			0xD0
 #define READ_STS			0x70
-#define READ_xD_ID			0x9A
+#define READ_XD_ID			0x9A
 #define	COPY_BACK_512			0x8A
 #define	COPY_BACK_2K			0x85
 #define	READ1_1_2			0x30
@@ -72,8 +72,8 @@
 #define	XD_128M_X16_2048		0xC1
 #define	XD_4M_X8_512_1			0xE3
 #define	XD_4M_X8_512_2			0xE5
-#define	xD_1G_X8_512			0xD3
-#define	xD_2G_X8_512			0xD5
+#define	XD_1G_X8_512			0xD3
+#define	XD_2G_X8_512			0xD5
 
 #define	XD_ID_CODE			0xB5
 
-- 
2.20.1

