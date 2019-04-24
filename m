Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30B5AC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:02:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 024CA20685
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 18:02:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJGipjPl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390074AbfDXSCw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 14:02:52 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:36919 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389617AbfDXSCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 14:02:49 -0400
Received: by mail-lj1-f196.google.com with SMTP id v13so5203099ljk.4;
        Wed, 24 Apr 2019 11:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DjJKtm/R6i9o8qcXqXMBfsK5KZD61RVVhbJADm6TWaU=;
        b=IJGipjPlKnxVk5DMmHc2huZos0Q6faYN+J2p20gcc4jzRbDYaaP6YvUS2xuXNAL6vQ
         5B9lwb9gg2hh+5cNtxQZHc75nxlECRO1BwXHGtOPCnYuB/ZHQvFb2f2nDCtnBmorGwB4
         awjBzR8NNNeDkxgPa2+3Gg+uonNIP07ScX7gcI/ekfoLf+4Twic385QenPx7cJiw2bmr
         5bzg3DddZ4xukFGxx5cnBGy1Ly28pBN/BIr5u3AxGF9Gxv8le1etlAQ7eYAbNykCLo9g
         hOCfs4sLeoJUPg7fiLPvV7kxRZtowddrXHtZ8alJ84vDe7+su01E6yOf4uwlsjyKIgdF
         0bAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DjJKtm/R6i9o8qcXqXMBfsK5KZD61RVVhbJADm6TWaU=;
        b=JB/aM6dy1WhZIBsLPSny67Y0G0QhKOUi/kMPJTA0W3o1KC5w0n8anuoaeUBq54rTTU
         HwKw2yytoVFje+2VBUt3YR3Z5BIrYg3lE81OU0mdMslYayiWLK3Z+em9FBTJt9iD3eeS
         R2h4hxf4UWXKlv0dsuH/KY70ayrQgylJ/jzaGYEPyBbm4pnhF0COvgCJGAAQKr3FUJGS
         Q0wYvYxXxe2W4w+YWpqWXRnFb3cW6+cEaHfN4XXi30AdqY64nPsIVdA285iZZ1O5Zz/G
         U3o+jfBIGDIdYyq8XblSATbgvEwI93tKDmwpyGcBNTpEXeb0uHwu3iljelz5FWqQota9
         jsew==
X-Gm-Message-State: APjAAAUFMqjDfi2jieHViKN1fFm4GFZAY5USXfiUXwJsKhsEg8tfOQDn
        j91hkNuW0MTfaMpShlyyh4k=
X-Google-Smtp-Source: APXvYqxvghpu1QaPhbpWC3coRNnVl0ClUm0loF9I7ldF+kL8zX7fhlOqqEm2dHrp673botHmTqCtqg==
X-Received: by 2002:a2e:9d59:: with SMTP id y25mr1039278ljj.137.1556128967046;
        Wed, 24 Apr 2019 11:02:47 -0700 (PDT)
Received: from z50.gdansk-morena.vectranet.pl (109241207190.gdansk.vectranet.pl. [109.241.207.190])
        by smtp.gmail.com with ESMTPSA id s21sm5550597lfb.0.2019.04.24.11.02.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 11:02:45 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <bbrezillon@kernel.org>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Tony Lindgren <tony@atomide.com>,
        Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH v3] mtd: rawnand: ams-delta: Drop board specific partition info
Date:   Wed, 24 Apr 2019 20:02:12 +0200
Message-Id: <20190424180212.10830-1-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190324223344.24590-1-jmkrzyszt@gmail.com>
References: <20190324223344.24590-1-jmkrzyszt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After recent modifications, only a hardcoded partition info makes
the driver device specific.  Other than that, the driver uses GPIO
exclusively and can be used on any hardware.

Drop the partition info and use MTD partition parser with default list
of parser names instead.  For the OF parser to work correctly, pass
device of_node to mtd.

Amstrad Delta users should append the following partition info to their
kernel command line, possibly embedding it in CONFIG_CMDLINE:

mtdparts=ams-delta-nand:3584k(Kernel),256k(u-boot),256k(u-boot_params),\
256k(Amstrad_LDR),27m(File_system),768k(PBL_reserved)

For their convenience, that information is added to the board Kconfig
entry help text, as well as CONFIG_MTD_CMDLINE_PARTS symbol is selected
automatically from the board Kconfig entry if the NAND driver is also
selected.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>
---
Changelog:
v2->v3:
- add information on the requirement for passing partition info via
  kernel command line to the board Kconfig entry help text
v1->v2:
- fix a typo poitned out by Aaro - thanks!
- fix device_node not passed to OF parser via mtd_info
- commit message reworded and reformatted a bit for better readability

 arch/arm/mach-omap1/Kconfig      |  7 ++++++-
 drivers/mtd/nand/raw/ams-delta.c | 29 ++---------------------------
 2 files changed, 8 insertions(+), 28 deletions(-)

diff --git a/arch/arm/mach-omap1/Kconfig b/arch/arm/mach-omap1/Kconfig
index c4694f26b5c4..41a47d251cac 100644
--- a/arch/arm/mach-omap1/Kconfig
+++ b/arch/arm/mach-omap1/Kconfig
@@ -164,17 +164,22 @@ config MACH_NOKIA770
 	  have such a device.
 
 config MACH_AMS_DELTA
-	bool "Amstrad E3 (Delta)"
+	bool "Amstrad E3 (Delta) - see help for important information"
 	depends on ARCH_OMAP1 && ARCH_OMAP15XX
 	select FIQ
 	select GPIO_GENERIC_PLATFORM
 	select LEDS_GPIO_REGISTER
 	select REGULATOR
 	select REGULATOR_FIXED_VOLTAGE
+	select MTD_CMDLINE_PARTS if MTD_NAND_AMS_DELTA
 	help
 	  Support for the Amstrad E3 (codename Delta) videophone. Say Y here
 	  if you have such a device.
 
+	  If you are using built-in NAND, append the following partition
+	  info to kernel command line:
+	  mtdparts=ams-delta-nand:3584k(Kernel),256k(u-boot),256k(u-boot_params),256k(Amstrad_LDR),27m(File_system),768k(PBL_reserved)
+
 config MACH_OMAP_GENERIC
 	bool "Generic OMAP board"
 	depends on ARCH_OMAP1 && (ARCH_OMAP15XX || ARCH_OMAP16XX)
diff --git a/drivers/mtd/nand/raw/ams-delta.c b/drivers/mtd/nand/raw/ams-delta.c
index 8312182088c1..e0f09179bbda 100644
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
@@ -238,6 +213,7 @@ static int ams_delta_init(struct platform_device *pdev)
 	mtd->dev.parent = &pdev->dev;
 
 	nand_set_controller_data(this, priv);
+	nand_set_flash_node(this, pdev->dev.of_node);
 
 	priv->gpiod_rdy = devm_gpiod_get_optional(&pdev->dev, "rdy", GPIOD_IN);
 	if (IS_ERR(priv->gpiod_rdy)) {
@@ -315,8 +291,7 @@ static int ams_delta_init(struct platform_device *pdev)
 		return err;
 
 	/* Register the partitions */
-	err = mtd_device_register(mtd, partition_info,
-				  ARRAY_SIZE(partition_info));
+	err = mtd_device_parse_register(mtd, NULL, NULL, NULL, 0);
 	if (err)
 		goto err_nand_cleanup;
 
-- 
2.21.0

