Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5725C33C9B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 10:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92ABC2087F
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 10:48:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727936AbgAHKsK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 05:48:10 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:57867 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727478AbgAHKsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 05:48:07 -0500
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28] helo=dude02.lab.pengutronix.de)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1ip8se-0000eb-56; Wed, 08 Jan 2020 11:48:04 +0100
Received: from mfe by dude02.lab.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1ip8sd-000159-J6; Wed, 08 Jan 2020 11:48:03 +0100
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     support.opensource@diasemi.com, lee.jones@linaro.org,
        robh+dt@kernel.org, linus.walleij@linaro.org,
        Adam.Thomson.Opensource@diasemi.com
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, linux-gpio@vger.kernel.org
Subject: [PATCH v4 2/3] mfd: da9062: add support for the DA9062 GPIOs in the core
Date:   Wed,  8 Jan 2020 11:47:45 +0100
Message-Id: <20200108104746.1765-3-m.felsch@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200108104746.1765-1-m.felsch@pengutronix.de>
References: <20200108104746.1765-1-m.felsch@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the da9062 GPIO's aren't available. The patch adds the support
to make these available by adding a gpio device with the corresponding
irq resources. Furthermore the patch fixes a minor style issue for the
onkey device.

Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Reviewed-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/da9062-core.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/da9062-core.c b/drivers/mfd/da9062-core.c
index e69626867c26..5290bdc0ddcd 100644
--- a/drivers/mfd/da9062-core.c
+++ b/drivers/mfd/da9062-core.c
@@ -233,6 +233,14 @@ static struct resource da9062_onkey_resources[] = {
 	DEFINE_RES_NAMED(DA9062_IRQ_ONKEY, 1, "ONKEY", IORESOURCE_IRQ),
 };
 
+static struct resource da9062_gpio_resources[] = {
+	DEFINE_RES_NAMED(DA9062_IRQ_GPI0, 1, "GPI0", IORESOURCE_IRQ),
+	DEFINE_RES_NAMED(DA9062_IRQ_GPI1, 1, "GPI1", IORESOURCE_IRQ),
+	DEFINE_RES_NAMED(DA9062_IRQ_GPI2, 1, "GPI2", IORESOURCE_IRQ),
+	DEFINE_RES_NAMED(DA9062_IRQ_GPI3, 1, "GPI3", IORESOURCE_IRQ),
+	DEFINE_RES_NAMED(DA9062_IRQ_GPI4, 1, "GPI4", IORESOURCE_IRQ),
+};
+
 static const struct mfd_cell da9062_devs[] = {
 	{
 		.name		= "da9062-core",
@@ -266,7 +274,13 @@ static const struct mfd_cell da9062_devs[] = {
 		.name		= "da9062-onkey",
 		.num_resources	= ARRAY_SIZE(da9062_onkey_resources),
 		.resources	= da9062_onkey_resources,
-		.of_compatible = "dlg,da9062-onkey",
+		.of_compatible	= "dlg,da9062-onkey",
+	},
+	{
+		.name		= "da9062-gpio",
+		.num_resources	= ARRAY_SIZE(da9062_gpio_resources),
+		.resources	= da9062_gpio_resources,
+		.of_compatible	= "dlg,da9062-gpio",
 	},
 };
 
-- 
2.20.1

