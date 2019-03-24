Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A4ACC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 22:34:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B93320989
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 22:34:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MkcXvtFj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729077AbfCXWeb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 18:34:31 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35434 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727137AbfCXWeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 18:34:31 -0400
Received: by mail-lj1-f196.google.com with SMTP id t13so6122584lji.2;
        Sun, 24 Mar 2019 15:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jo46dSpvZSN1TN7vD8NpGaggh1SE8FrmPLyEYV3JD/Y=;
        b=MkcXvtFjLvU0+Or9yc3L+Epwks0AgedL9rcDQQrKq9TGR6llz1b5hsz4mZaOGyH95c
         bgLNiMi84HSntOgV0PRgQ8JFffvZY2mYAck4EYCFz+Hb4jg/XF1m4PzDxiuIL0c3e1se
         R5qmu3by1qggAfd09pf2mgNlA9fETu4FN4b4mZO0AOgZmeYnMAsg+uTprJLzW95J7k+4
         RFu+9Gh28inRQplofEF1nk43nKmwJM0WxbMYHk3ZmTelfgQzT5EMGKqFzPpA3JdcWfDO
         nyT7ZMwB3BFoYI7SKTpwLhgmEv4GRPJMkEGuOcYFSLVbRy6iYIjZbI5e/M1omG6SulEo
         MEwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jo46dSpvZSN1TN7vD8NpGaggh1SE8FrmPLyEYV3JD/Y=;
        b=JzT4bVlrvkSKHO6u22feCUfGTefcI37/BKnot6nj+yvdlTSzRvJ/iVP2e3Iol5V15Y
         OADvA6Yw51o1YAwiFUa7Bm7BYelC6SyqRslIKlyFx1KfPS4KcA0ohz4X3jwwGypn9eKX
         eICVhhqtUGyKo50CNWRcpEtFF08n5xoy3giSExmasoEQdiJFXsPiopTUTO7EE5nDM01G
         YdgFUPZWTpMFnIqBScKK8XjO+IrNwiBwFSgZC2XDVD60JC/DmOCXBFF17Zpz3NsHVZOn
         d/sM9xFJD10Ac2j5gXpBpNqkwGLRhSt6yDB8FTchgC9zRqjyHd//34ecAStub0NiCt8Z
         oPPw==
X-Gm-Message-State: APjAAAWnppB8f7v7188upoCUyQbW0fQhAt9ToXd+oE7paGG8tUOqGjeJ
        tsDXMYBtKXSTXZWAYj3HavE=
X-Google-Smtp-Source: APXvYqw5HGdP9TLmBjfsNtycFwIx6TtTmV1CL2ndpqJUJyVNMec6h44CyqSsLVBj4orKb7nx0nS/qw==
X-Received: by 2002:a2e:9b4e:: with SMTP id o14mr11530352ljj.189.1553466869131;
        Sun, 24 Mar 2019 15:34:29 -0700 (PDT)
Received: from z50.gdansk-morena.vectranet.pl (109241207190.gdansk.vectranet.pl. [109.241.207.190])
        by smtp.gmail.com with ESMTPSA id x76sm3144324ljb.17.2019.03.24.15.34.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Mar 2019 15:34:28 -0700 (PDT)
From:   Janusz Krzysztofik <jmkrzyszt@gmail.com>
To:     Boris Brezillon <bbrezillon@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Tony Lindgren <tony@atomide.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mtd@lists.infradead.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>
Subject: [PATCH v2] mtd: rawnand: ams-delta: Drop board specific partition info
Date:   Sun, 24 Mar 2019 23:33:44 +0100
Message-Id: <20190324223344.24590-1-jmkrzyszt@gmail.com>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190319223718.26131-1-jmkrzyszt@gmail.com>
References: <20190319223718.26131-1-jmkrzyszt@gmail.com>
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
kernel command line, possibly by embedding it in CONFIG_CMDLINE:

mtdparts=ams-delta-nand:3584k(Kernel),256k(u-boot),256k(u-boot_params),\
256k(Amstrad_LDR),27m(File_system),768k(PBL_reserved).

For their convenience, CONFIG_MTD_CMDLINE_PARTS symbol is selected
automatically from that board Kconfig if this NAND driver is also
selected.

Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Cc: Tony Lindgren <tony@atomide.com>
---
CHangelog:
v1->v2:
- fix a typo poined out by Aaro - thanks!
- fix device_node not passed to OF parser via mtd_info
- commit message reworded and reformatted a bit for better readability

 arch/arm/mach-omap1/Kconfig      |  1 +
 drivers/mtd/nand/raw/ams-delta.c | 29 ++---------------------------
 2 files changed, 3 insertions(+), 27 deletions(-)

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
2.19.2

