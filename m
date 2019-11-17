Return-Path: <SRS0=PwuH=ZJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 519CCC432C0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 22:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 295B6206E1
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 22:14:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gerhold.net header.i=@gerhold.net header.b="EGlbayNh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbfKQWOu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 17:14:50 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.165]:19013 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbfKQWOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 17:14:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1574028885;
        s=strato-dkim-0002; d=gerhold.net;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=OTBQfgiMgiFDMKt/EGwPBC5FtoOl9EQykalo6VCqi+Y=;
        b=EGlbayNh21jLySf1s/f0N1+Ro6JQoT29EoGM25+kHCt6EGRlG1tHPv/QS3UCHRla9s
        dSfI9nWWJm61ewcQpHXr1P2aFGMqH2sZxJPjy6AZQTEjCsNVuhm5rhGJbbUG9Iez7Av9
        gdrHttGJ1FO+MHQBmoLuvhrJ2aIBYF8emOPLVx7Hn+VY94G4nxM2jdOx0Dd5LAGMF7Ic
        ThcWZWiGB8EKwUNKD9kA5BGqbBQJJsu8STjG+OSoBrmn3UTX3GJEEE8jLOeaPy/tCFLS
        V9L4jjxGw+ce363gjsnITuLt1Khbh6iLzBysUvOqz2Vl5lXHemAQ3TJt9rWrnqPrM4kl
        O3fA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVORvLd4SsytBXQrEOHTIXsMvvtBRRPA=="
X-RZG-CLASS-ID: mo00
Received: from localhost.localdomain
        by smtp.strato.de (RZmta 44.29.0 AUTH)
        with ESMTPSA id e07688vAHMEebBO
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Sun, 17 Nov 2019 23:14:40 +0100 (CET)
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 2/2] mfd: ab8500-core: Add device tree support for AB8505
Date:   Sun, 17 Nov 2019 23:10:53 +0100
Message-Id: <20191117221053.278415-2-stephan@gerhold.net>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191117221053.278415-1-stephan@gerhold.net>
References: <20191117221053.278415-1-stephan@gerhold.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AB8505 support was never fully converted to the device tree.
Most of the MFD cells for AB8505 lack an "of_compatible",
which prevents them from being configured through the device tree.

Align the definition of the AB8505 MFD cells with the ones for AB8500,
and add device tree compatibles. Except for GPIO and regulators the
compatibles are equal to those used for AB8500 because the hardware
does not differ much.

Finally, change db8500_prcmu_register_ab8500() to check for the AB8505
device tree node additionally, and probe it if it is found.

Cc: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
---
 drivers/mfd/ab8500-core.c  | 14 ++++++++++++--
 drivers/mfd/db8500-prcmu.c | 26 ++++++++++++++++++++------
 2 files changed, 32 insertions(+), 8 deletions(-)

diff --git a/drivers/mfd/ab8500-core.c b/drivers/mfd/ab8500-core.c
index bafc729fc434..6db7969101d6 100644
--- a/drivers/mfd/ab8500-core.c
+++ b/drivers/mfd/ab8500-core.c
@@ -718,17 +718,20 @@ static const struct mfd_cell ab8505_devs[] = {
 #ifdef CONFIG_DEBUG_FS
 	{
 		.name = "ab8500-debug",
+		.of_compatible = "stericsson,ab8500-debug",
 	},
 #endif
 	{
 		.name = "ab8500-sysctrl",
+		.of_compatible = "stericsson,ab8500-sysctrl",
 	},
 	{
 		.name = "ab8500-regulator",
+		.of_compatible = "stericsson,ab8505-regulator",
 	},
 	{
 		.name = "abx500-clk",
-		.of_compatible = "stericsson,abx500-clk",
+		.of_compatible = "stericsson,ab8500-clk",
 	},
 	{
 		.name = "ab8500-gpadc",
@@ -736,25 +739,32 @@ static const struct mfd_cell ab8505_devs[] = {
 	},
 	{
 		.name = "ab8500-rtc",
+		.of_compatible = "stericsson,ab8500-rtc",
 	},
 	{
 		.name = "ab8500-acc-det",
+		.of_compatible = "stericsson,ab8500-acc-det",
 	},
 	{
 		.name = "ab8500-poweron-key",
+		.of_compatible = "stericsson,ab8500-poweron-key",
 	},
 	{
 		.name = "ab8500-pwm",
+		.of_compatible = "stericsson,ab8500-pwm",
 		.id = 1,
 	},
 	{
 		.name = "pinctrl-ab8505",
+		.of_compatible = "stericsson,ab8505-gpio",
 	},
 	{
 		.name = "ab8500-usb",
+		.of_compatible = "stericsson,ab8500-usb",
 	},
 	{
 		.name = "ab8500-codec",
+		.of_compatible = "stericsson,ab8500-codec",
 	},
 	{
 		.name = "ab-iddet",
@@ -1276,7 +1286,7 @@ static int ab8500_probe(struct platform_device *pdev)
 
 static const struct platform_device_id ab8500_id[] = {
 	{ "ab8500-core", AB8500_VERSION_AB8500 },
-	{ "ab8505-i2c", AB8500_VERSION_AB8505 },
+	{ "ab8505-core", AB8500_VERSION_AB8505 },
 	{ "ab9540-i2c", AB8500_VERSION_AB9540 },
 	{ "ab8540-i2c", AB8500_VERSION_AB8540 },
 	{ }
diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
index 57ac58b4b5f3..26d967a1a046 100644
--- a/drivers/mfd/db8500-prcmu.c
+++ b/drivers/mfd/db8500-prcmu.c
@@ -3060,30 +3060,44 @@ static const struct mfd_cell db8500_prcmu_devs[] = {
 static int db8500_prcmu_register_ab8500(struct device *parent)
 {
 	struct device_node *np;
-	struct resource ab8500_resource;
+	struct resource ab850x_resource;
 	const struct mfd_cell ab8500_cell = {
 		.name = "ab8500-core",
 		.of_compatible = "stericsson,ab8500",
 		.id = AB8500_VERSION_AB8500,
-		.resources = &ab8500_resource,
+		.resources = &ab850x_resource,
 		.num_resources = 1,
 	};
+	const struct mfd_cell ab8505_cell = {
+		.name = "ab8505-core",
+		.of_compatible = "stericsson,ab8505",
+		.id = AB8500_VERSION_AB8505,
+		.resources = &ab850x_resource,
+		.num_resources = 1,
+	};
+	const struct mfd_cell *ab850x_cell;
 
 	if (!parent->of_node)
 		return -ENODEV;
 
 	/* Look up the device node, sneak the IRQ out of it */
 	for_each_child_of_node(parent->of_node, np) {
-		if (of_device_is_compatible(np, ab8500_cell.of_compatible))
+		if (of_device_is_compatible(np, ab8500_cell.of_compatible)) {
+			ab850x_cell = &ab8500_cell;
 			break;
+		}
+		if (of_device_is_compatible(np, ab8505_cell.of_compatible)) {
+			ab850x_cell = &ab8505_cell;
+			break;
+		}
 	}
 	if (!np) {
-		dev_info(parent, "could not find AB8500 node in the device tree\n");
+		dev_info(parent, "could not find AB850X node in the device tree\n");
 		return -ENODEV;
 	}
-	of_irq_to_resource_table(np, &ab8500_resource, 1);
+	of_irq_to_resource_table(np, &ab850x_resource, 1);
 
-	return mfd_add_devices(parent, 0, &ab8500_cell, 1, NULL, 0, NULL);
+	return mfd_add_devices(parent, 0, ab850x_cell, 1, NULL, 0, NULL);
 }
 
 /**
-- 
2.23.0

