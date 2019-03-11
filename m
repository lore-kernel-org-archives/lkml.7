Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A27C10F0C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 06:28:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73FB92075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 06:28:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WQJg6c0h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfCKG2J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 02:28:09 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:41023 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726633AbfCKG2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 02:28:07 -0400
Received: by mail-pf1-f193.google.com with SMTP id d25so2964829pfn.8;
        Sun, 10 Mar 2019 23:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FucV4xmaQpW0g5ag0DNsjakkAYyguzHLUsgHU2+3MJM=;
        b=WQJg6c0h9PEPWkuhREut2WFmWqxBv05+kjsy92DB+r2DPNDe+wH9rjjHeE6fkwWj9c
         jatd8P4Dp20Fu5930yJEuZKSV/GplhYMfcs75tIAPzkhYRLHESFnG+U++bvQRvsDerJs
         sfF9sRvkXVeJvtbz5KEZGuGaXYzr9uyo9VZRJKuo87MzBLRz5slSQkjNt7tc66gB0eRO
         G2KZjOOx2AojV0aO6H05Eby0Lw8Ir7ryBDvhIf/2gEaF2Xp+DUh1ppKdbUeMzmZWIgdf
         wLRmEJCl9UxkMbEFk3vbHJe/TMjhihH8pm/0M2bq3ubEMucr7uokLI5bC9Cyktbo8t5q
         jkVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FucV4xmaQpW0g5ag0DNsjakkAYyguzHLUsgHU2+3MJM=;
        b=UulMMexQ1o4wEgYS4/SPJ3ahktqmM9jEc2p1Rd90H9fofwGaI2hmWK/gaSY10MkYON
         ECGbhDvL8vw3YPgdzePUZc0GG1tSKOEd6RBAiZ+mMEMN5PXSqFlzIKYaUu73b2Aap3+H
         AUPAokbPDZov2Fb7H2uVdT/tSPnJHFTpZpA1I3bQqNHM6SYVEvfhXkdZM0o2XqLW6RYp
         4ro5cbE9ovHoGaLzHOh0zzLB6nLE2jWn/xME4Edyw+JGENh5h2h2OIOGcGFrhpyRpQ59
         I4v8dPNM1EWE5rAzlwHM4zjsnVqVwhEun+4R6H42+sAIWrhpPjzjyv/gDaG5wX6sulF6
         DQ9w==
X-Gm-Message-State: APjAAAVwnxtWK6ZcUQUVPehwEplSN6CsP7vbJgSKzylWH9zepqoeDuZ6
        rGnr9l4P+YktfUncMFBN0IFeXNabs7g=
X-Google-Smtp-Source: APXvYqxe7P7wpWkxkI8ViRxptxK87IEs7t8WSl9npEWo8ryQZ+UJ44ekmW8tbR4Ux8NdkJ17U/DTDQ==
X-Received: by 2002:a63:5721:: with SMTP id l33mr3313762pgb.300.1552285686381;
        Sun, 10 Mar 2019 23:28:06 -0700 (PDT)
Received: from squirtle.lan (c-24-22-235-96.hsd1.wa.comcast.net. [24.22.235.96])
        by smtp.gmail.com with ESMTPSA id f192sm10241679pfc.180.2019.03.10.23.28.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 10 Mar 2019 23:28:05 -0700 (PDT)
From:   Andrey Smirnov <andrew.smirnov@gmail.com>
To:     linux-gpio@vger.kernel.org
Cc:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Chris Healy <cphealy@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH 1/7] gpio: vf610: Do not share irq_chip
Date:   Sun, 10 Mar 2019 23:27:31 -0700
Message-Id: <20190311062737.6652-2-andrew.smirnov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190311062737.6652-1-andrew.smirnov@gmail.com>
References: <20190311062737.6652-1-andrew.smirnov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the warning produced by gpiochip_set_irq_hooks() by allocating a
dedicated IRQ chip per GPIO chip/port.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: linux-gpio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-imx@nxp.com
---
 drivers/gpio/gpio-vf610.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/gpio/gpio-vf610.c b/drivers/gpio/gpio-vf610.c
index 541fa6ac399d..7e9451f47efe 100644
--- a/drivers/gpio/gpio-vf610.c
+++ b/drivers/gpio/gpio-vf610.c
@@ -29,6 +29,7 @@ struct fsl_gpio_soc_data {
 
 struct vf610_gpio_port {
 	struct gpio_chip gc;
+	struct irq_chip ic;
 	void __iomem *base;
 	void __iomem *gpio_base;
 	const struct fsl_gpio_soc_data *sdata;
@@ -60,8 +61,6 @@ struct vf610_gpio_port {
 #define PORT_INT_EITHER_EDGE	0xb
 #define PORT_INT_LOGIC_ONE	0xc
 
-static struct irq_chip vf610_gpio_irq_chip;
-
 static const struct fsl_gpio_soc_data imx_data = {
 	.have_paddr = true,
 };
@@ -237,15 +236,6 @@ static int vf610_gpio_irq_set_wake(struct irq_data *d, u32 enable)
 	return 0;
 }
 
-static struct irq_chip vf610_gpio_irq_chip = {
-	.name		= "gpio-vf610",
-	.irq_ack	= vf610_gpio_irq_ack,
-	.irq_mask	= vf610_gpio_irq_mask,
-	.irq_unmask	= vf610_gpio_irq_unmask,
-	.irq_set_type	= vf610_gpio_irq_set_type,
-	.irq_set_wake	= vf610_gpio_irq_set_wake,
-};
-
 static int vf610_gpio_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -253,6 +243,7 @@ static int vf610_gpio_probe(struct platform_device *pdev)
 	struct vf610_gpio_port *port;
 	struct resource *iores;
 	struct gpio_chip *gc;
+	struct irq_chip *ic;
 	int i;
 	int ret;
 
@@ -316,6 +307,14 @@ static int vf610_gpio_probe(struct platform_device *pdev)
 	gc->direction_output = vf610_gpio_direction_output;
 	gc->set = vf610_gpio_set;
 
+	ic = &port->ic;
+	ic->name = "gpio-vf610";
+	ic->irq_ack = vf610_gpio_irq_ack;
+	ic->irq_mask = vf610_gpio_irq_mask;
+	ic->irq_unmask = vf610_gpio_irq_unmask;
+	ic->irq_set_type = vf610_gpio_irq_set_type;
+	ic->irq_set_wake = vf610_gpio_irq_set_wake;
+
 	ret = gpiochip_add_data(gc, port);
 	if (ret < 0)
 		return ret;
@@ -327,14 +326,13 @@ static int vf610_gpio_probe(struct platform_device *pdev)
 	/* Clear the interrupt status register for all GPIO's */
 	vf610_gpio_writel(~0, port->base + PORT_ISFR);
 
-	ret = gpiochip_irqchip_add(gc, &vf610_gpio_irq_chip, 0,
-				   handle_edge_irq, IRQ_TYPE_NONE);
+	ret = gpiochip_irqchip_add(gc, ic, 0, handle_edge_irq, IRQ_TYPE_NONE);
 	if (ret) {
 		dev_err(dev, "failed to add irqchip\n");
 		gpiochip_remove(gc);
 		return ret;
 	}
-	gpiochip_set_chained_irqchip(gc, &vf610_gpio_irq_chip, port->irq,
+	gpiochip_set_chained_irqchip(gc, ic, port->irq,
 				     vf610_gpio_irq_handler);
 
 	return 0;
-- 
2.20.1

