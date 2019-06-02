Return-Path: <SRS0=BIzH=UB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4874FC282DC
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 15:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EAE427973
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Jun 2019 15:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MpH4OVk3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbfFBP7S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Jun 2019 11:59:18 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:33243 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbfFBP7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jun 2019 11:59:17 -0400
Received: by mail-qt1-f195.google.com with SMTP id 14so6875348qtf.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2019 08:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cwSi5MhwwNuPtX+N4n2xqn5nIAMMQTMMy9Sqt0rjx2Y=;
        b=MpH4OVk3AUkP/GBsRXlZx67QY3EGSa0W78a99p8pZOpnpfxkJ/YU/KnR5rHablTERN
         ZfJmd7nj8YPKmjv5tW8gFCbjgMrlWoNQ0MTiRqCygyu/+xP1Z0yx3KAyFVhk3hiwEj8p
         jzaaJOYXzMWKOgzHjBBUmZDdtzDY1UQL7bWozRrUi3q6nvaPUmkKoFRtrzJVm5+MnqY8
         495ecp82BeJVbMgq6UK20O5BV96kr3UnGWg47eF+DihHGvjMzmL8XbH2wMX5T4W99AVT
         9E3YgiekXuX4Qnl//SpOwrPdZdBTxrwoiug8FJ0IJjPH12ZI5+KNalBIcIdKgZ0Mcyfv
         U/mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cwSi5MhwwNuPtX+N4n2xqn5nIAMMQTMMy9Sqt0rjx2Y=;
        b=uO0XBGlKa9X0gMbFT6nAmY+M3X5vHX93wD51oCVMK/vL6kddYtABfyZrFf8FHK96zK
         Dfnr2CFf+sTp0RoT1PhAbr6DaVJG0G/heqF6WQAsbk6Ky6NTsV2mVHv5fOeof0cbOA3T
         plgX9JFDfyS8P8pEhx2WJO8/cX6cdxWwdBa/h6WkKZu1zhJct+NeI57u3r0p+xvKT10H
         Gih725ibFluO/BuJO0YQ67UEO+N/7FhmYysOonfbIWtihHJkNe6GfPYt5RJmuEWqQ9zI
         uTYVjOmVauPN1ZnjV63ZLD03vrrpUPxsqSjnvwKuQLd7Tvcj+WeDSMB2eDIzEdd1h93E
         XCyQ==
X-Gm-Message-State: APjAAAXPr+Ob/KWjb/7hXVJde4NdKy5hlHf4B782c7YDT11ML0ndED1f
        AhrOCb9e596QpzXT2QVXJZ8=
X-Google-Smtp-Source: APXvYqxacy95ztVh2aIoXGuNQecgk7mcerQLv1cPC8o9FeQnvGyIWfIQFt+QNRMJH/HGzuMlf3PjbQ==
X-Received: by 2002:ac8:38a4:: with SMTP id f33mr19437642qtc.163.1559491156619;
        Sun, 02 Jun 2019 08:59:16 -0700 (PDT)
Received: from arch-01.home (c-73-132-202-198.hsd1.md.comcast.net. [73.132.202.198])
        by smtp.gmail.com with ESMTPSA id n7sm7378589qkd.53.2019.06.02.08.59.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Jun 2019 08:59:16 -0700 (PDT)
From:   Geordan Neukum <gneukum1@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jeremy Sowden <jeremy@azazel.net>, Mao Wenan <maowenan@huawei.com>,
        YueHaibing <yuehaibing@huawei.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Geordan Neukum <gneukum1@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] staging: kpc2000: kpc_spi: Remove unnecessary consecutive newlines
Date:   Sun,  2 Jun 2019 15:58:33 +0000
Message-Id: <bc19f98c3b5468abfc66839569d72016d03c79af.1559488571.git.gneukum1@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1559488571.git.gneukum1@gmail.com>
References: <cover.1559488571.git.gneukum1@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kpc2000_spi.c file contains instances of unnecessary consecutive
newlines which negatively impact the readability of the file. Remove
all unnecessary consecutive newlines.

Signed-off-by: Geordan Neukum <gneukum1@gmail.com>
---
 drivers/staging/kpc2000/kpc2000_spi.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/drivers/staging/kpc2000/kpc2000_spi.c b/drivers/staging/kpc2000/kpc2000_spi.c
index 9a23808ffaa1..ef7e062bf52c 100644
--- a/drivers/staging/kpc2000/kpc2000_spi.c
+++ b/drivers/staging/kpc2000/kpc2000_spi.c
@@ -97,8 +97,6 @@ static struct spi_board_info p2kr0_board_info[] = {
 #define KP_SPI_REG_STATUS_RXFFE 0x40
 #define KP_SPI_REG_STATUS_RXFFF 0x80
 
-
-
 /******************
  * SPI Structures *
  ******************/
@@ -111,7 +109,6 @@ struct kp_spi {
 	unsigned int        pin_dir:1;
 };
 
-
 struct kp_spi_controller_state {
 	void __iomem   *base;
 	unsigned long   phys;
@@ -120,7 +117,6 @@ struct kp_spi_controller_state {
 	s64             conf_cache;
 };
 
-
 union kp_spi_config {
 	/* use this to access individual elements */
 	struct __attribute__((packed)) spi_config_bitfield {
@@ -141,8 +137,6 @@ union kp_spi_config {
 	u32 reg;
 };
 
-
-
 union kp_spi_status {
 	struct __attribute__((packed)) spi_status_bitfield {
 		unsigned int rx    :  1; /* Rx Status       */
@@ -158,8 +152,6 @@ union kp_spi_status {
 	u32 reg;
 };
 
-
-
 union kp_spi_ffctrl {
 	struct __attribute__((packed)) spi_ffctrl_bitfield {
 		unsigned int ffstart :  1; /* FIFO Start */
@@ -168,8 +160,6 @@ union kp_spi_ffctrl {
 	u32 reg;
 };
 
-
-
 /***************
  * SPI Helpers *
  ***************/
@@ -445,8 +435,6 @@ kp_spi_cleanup(struct spi_device *spidev)
 	}
 }
 
-
-
 /******************
  * Probe / Remove *
  ******************/
@@ -538,7 +526,6 @@ kp_spi_remove(struct platform_device *pldev)
 	return 0;
 }
 
-
 static struct platform_driver kp_spi_driver = {
 	.driver = {
 		.name =     KP_DRIVER_NAME_SPI,
-- 
2.21.0

