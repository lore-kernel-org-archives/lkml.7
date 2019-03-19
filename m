Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D062AC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 22:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A1D3217F4
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 22:37:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EWpvVzXr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbfCSWhx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 18:37:53 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44517 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726686AbfCSWhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 18:37:52 -0400
Received: by mail-lj1-f194.google.com with SMTP id n18so501075ljg.11;
        Tue, 19 Mar 2019 15:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d2uS3JYGyQ73AUhjSqp6WbiOn0rKDAb2enK7Ui9OG1k=;
        b=EWpvVzXrXBYLmg4ieBzv3cl784Xf9T968WwgPowvJKcHSmFbwGgIcs6Of9Z4/tz/7s
         EZeoucooRipWxBcUbTnfXUFLV1+ZrWulSBMXOUEACygIoWjxo3UgbJYkyKYQvWsMGleR
         QriXZGfH7BvlyVeeAhMg5RVYoJsg+lssZlpsynrchTqGeOoetgP20B/PD0yOWsHY3blE
         +hS1HiGrTaVyVpWjTndgKqUXm+AB5XlxI457V+dt1y8mbJbOnvWNY2vbc83X/V5h14gK
         ypUF7jpoGhrBag36xsFshcHgLBMlEaSTF89VAGrTw8A8QAllZ7LdI0YfCVkYIXinxYtb
         PskA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d2uS3JYGyQ73AUhjSqp6WbiOn0rKDAb2enK7Ui9OG1k=;
        b=epJ+chQsvO8Zq8jQAxWnowyl0xI48M091vYKjM+Q4eA/im/jtxEO3yElqf1UCFbnSX
         rmQe/7JLPdrONyFRUUwazlcedCXUye0ZjxBD4wIOGPGJYQEJGLLLddKG0xbce+nhCBly
         Q8tCpCNMf4NngZiU5Yc0wfWxPctxU6Z3MtsxW7RNyPszhT6vYc8t4wKLouM9R0A5LVvR
         k67UbDIbCHO68PkX9HHxh+rb2zzMzwC0FL6N+9bgnrum91+CdNk8xUoa5YLLdU4P6jf3
         MXJ/O5/PTIHRd+tZGm+r4Qi/0z5bCiEDjWuw2re8JWSNtTuu8eI5fWZ7tZrbPZvf20b9
         7PEw==
X-Gm-Message-State: APjAAAVD4W81H98Tq+ERUS2vPkY2urDr/QRARy9n+jJIM2d9KyCzqzuU
        dNvXJeHoxo0uKr0jtfIop4M3TtBU
X-Google-Smtp-Source: APXvYqxRGGAMBczbx5QCobRazLvMcrQnc58m6gR2XMzSf0XUPwTAHtOEYTkf0qZQql0G5AidHWzl0w==
X-Received: by 2002:a2e:5b44:: with SMTP id p65mr15344283ljb.182.1553035070683;
        Tue, 19 Mar 2019 15:37:50 -0700 (PDT)
Received: from z50.gdansk-morena.vectranet.pl (109241207190.gdansk.vectranet.pl. [109.241.207.190])
        by smtp.gmail.com with ESMTPSA id t18sm51192ljg.64.2019.03.19.15.37.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 Mar 2019 15:37:49 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Boris Brezillon <bbrezillon@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH] mtd: rawnand: ams-delta: Drop board specific partition info
Date:   Tue, 19 Mar 2019 23:37:18 +0100
Message-Id: <20190319223718.26131-1-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After recent modifications, only a hardcoded partition info makes
the driver device specific.  Other than that, the driver uses GPIO
exclusively and can be used on any hardware.

Drop the partition info and use MTD partition parser with default
list of partition types instead.

Amstrad Delta users should append the followig partition info to their
kernel command line, possibly by embedding it in CONFIG_CMDLINE:
mtdparts=ams-delta-nand:3584k(Kernel),256k(u-boot),256k(u-boot_params),\
256k(Amstrad_LDR),27m(File_system),768k(PBL_reserved).  For their
convenience, select CONFIG_MTD_CMDLINE_PARTS  symbol from that board
Kconfig automatically if this NAND driver is also selected.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap1/Kconfig      |  1 +
 drivers/mtd/nand/raw/ams-delta.c | 28 +---------------------------
 2 files changed, 2 insertions(+), 27 deletions(-)

diff --git a/arch/arm/mach-omap1/Kconfig b/arch/arm/mach-omap1/Kconfig
index c4694f26b5c4..62cf20f22828 100644
--- a/arch/arm/mach-omap1/Kconfig
+++ b/arch/arm/mach-omap1/Kconfig
@@ -171,6 +171,7 @@ config MACH_AMS_DELTA
 	select LEDS_GPIO_REGISTER
 	select REGULATOR
 	select REGULATOR_FIXED_VOLTAGE
+	select MTD_CMDLINE_PARTS if MTD_NAND_AMS_DELTA
 	help
 	  Support for the Amstrad E3 (codename Delta) videophone. Say Y here
 	  if you have such a device.
diff --git a/drivers/mtd/nand/raw/ams-delta.c b/drivers/mtd/nand/raw/ams-delta.c
index 8312182088c1..2e8e37ea549a 100644
--- a/drivers/mtd/nand/raw/ams-delta.c
+++ b/drivers/mtd/nand/raw/ams-delta.c
@@ -41,31 +41,6 @@ struct ams_delta_nand {
 	bool			data_in;
 };
 
-/*
- * Define partitions for flash devices
- */
-
-static const struct mtd_partition partition_info[] = {
-	{ .name		= "Kernel",
-	  .offset	= 0,
-	  .size		= 3 * SZ_1M + SZ_512K },
-	{ .name		= "u-boot",
-	  .offset	= 3 * SZ_1M + SZ_512K,
-	  .size		= SZ_256K },
-	{ .name		= "u-boot params",
-	  .offset	= 3 * SZ_1M + SZ_512K + SZ_256K,
-	  .size		= SZ_256K },
-	{ .name		= "Amstrad LDR",
-	  .offset	= 4 * SZ_1M,
-	  .size		= SZ_256K },
-	{ .name		= "File system",
-	  .offset	= 4 * SZ_1M + 1 * SZ_256K,
-	  .size		= 27 * SZ_1M },
-	{ .name		= "PBL reserved",
-	  .offset	= 32 * SZ_1M - 3 * SZ_256K,
-	  .size		=  3 * SZ_256K },
-};
-
 static void ams_delta_write_commit(struct ams_delta_nand *priv)
 {
 	gpiod_set_value(priv->gpiod_nwe, 0);
@@ -315,8 +290,7 @@ static int ams_delta_init(struct platform_device *pdev)
 		return err;
 
 	/* Register the partitions */
-	err = mtd_device_register(mtd, partition_info,
-				  ARRAY_SIZE(partition_info));
+	err = mtd_device_parse_register(mtd, NULL, NULL, NULL, 0);
 	if (err)
 		goto err_nand_cleanup;
 
-- 
2.19.2

