Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C8A1CA9EC5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 19:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33EED20873
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 19:05:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bOK7P2lx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727164AbfJ3TFc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 15:05:32 -0400
Received: from mail-qt1-f175.google.com ([209.85.160.175]:46100 "EHLO
        mail-qt1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbfJ3TFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 15:05:31 -0400
Received: by mail-qt1-f175.google.com with SMTP id u22so4695569qtq.13
        for <linux-kernel@vger.kernel.org>; Wed, 30 Oct 2019 12:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G/CLbA2eHut9jnlfxg8nn7rhAl1LzWfOSEW3r5Byzck=;
        b=bOK7P2lxlfyGq9rodQ/zhPwa8PTwWOLk/pRJ0OBGdkrVvNV3Rxms5+TexpYxEFEgWX
         QJKhBs0hX0sz92F9UkRWCfD8EDfRFGOzYG7fYcrYXXPPnXpqrmv8mx9lFalwAbGXVX3D
         B5Qojm0kK5rYnJlQ3GaGLljpBzcegjv5bdTxfp/lPeaVvcbttfXxE0xjsws5YNAIFqSd
         lZVcnUOSKgug3+quJIJEeqkP6BlVHYNGavi88yqBUJGvUFmn9ZnZx0O2SOnFhMuqC7yq
         77ayCW3VszzHN0oW4cIAHG7pNFXwXdk42cnO41VCgelNXZDsTx37EcAdkGQUALkUvSCE
         hmhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G/CLbA2eHut9jnlfxg8nn7rhAl1LzWfOSEW3r5Byzck=;
        b=YW2UEU4S9BN+xq7/Nf0TXv7/Z5hMTb3TqlZL6aSnW9UazlahLJL1tOinYVW5VRUOvF
         LzfUvBa85dh31xW0jiB0Ctqy/BwQ00XilohvDT8KCZg766BfTGyWYRy+chi9ne7MlBvC
         A9Lu7SS+wDmDs78tB5lQSY/04AeJDB+0qthgOflCQsW3+luH3zf2El0u0Wq1a3As6Unf
         29u1puWZEkJvh1UAmfRhryD1cJXe2gcFUct8or8ni41xosPFNmx8iGqIYazAcvn2wTey
         blcIyLLHdbcb80Y9L7kyjcSDFlzQdzPeb2zprQtTpBH0JJloTX9QnW0q2lh9b8B7cKUV
         NOLg==
X-Gm-Message-State: APjAAAWds4RR4ur/g26z4SxO6ifIY1Rls9ngUHJmTXMYziTGeZw9F4ez
        cgxri6vmBNQZ2gCUCzJCXTQ=
X-Google-Smtp-Source: APXvYqzEx235ls/hYY4v2X6pXnThtWx8fvVcOZ4FBt9n4uuTuTkTqI3xUEvdEJvcpgBr9HUYC0YsfQ==
X-Received: by 2002:a0c:fca5:: with SMTP id h5mr630877qvq.149.1572462329964;
        Wed, 30 Oct 2019 12:05:29 -0700 (PDT)
Received: from GBdebian.ic.unicamp.br (wifi-177-220-85-136.wifi.ic.unicamp.br. [177.220.85.136])
        by smtp.gmail.com with ESMTPSA id o28sm690544qtk.4.2019.10.30.12.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2019 12:05:29 -0700 (PDT)
From:   Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
To:     outreachy-kernel@googlegroups.com, gregkh@linuxfoundation.org,
        nishkadg.linux@gmail.com, kim.jamie.bradley@gmail.com,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        lkcamp@lists.libreplanetbr.org
Cc:     Gabriela Bittencourt <gabrielabittencourt00@gmail.com>
Subject: [PATCH v3 2/3] staging: rts5208: Eliminate the use of Camel Case in files xd.{h,c}
Date:   Wed, 30 Oct 2019 16:05:13 -0300
Message-Id: <20191030190514.10011-3-gabrielabittencourt00@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191030190514.10011-1-gabrielabittencourt00@gmail.com>
References: <20191030190514.10011-1-gabrielabittencourt00@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleans up checks of "Avoid CamelCase" in files xd.{h,c}

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

