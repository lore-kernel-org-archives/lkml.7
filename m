Return-Path: <SRS0=UImc=ZL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FCBAC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:33:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5403C208C3
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Nov 2019 05:33:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574141609;
	bh=fzxvrBp3LsbCgd4FvX0URPQl8gN42nJGUeUp4p/M1dU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bVWQkZ4772zF3NPQgD4DSjbnDmDi+sBGLazxPYw48Fry3dMJE4jVP2xXwD5BXnv7o
	 NxoFZb+eGi4yL/bOSCPtGPSKq3b3DiBWUU/jH7hRiDkO4H2uQBt7pb7NBJ1T/2LGH1
	 5XtwKNVga58YtHzuh2WLC2ncOFYGkmyTUbNwzqa0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727677AbfKSFd2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Nov 2019 00:33:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:53878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729023AbfKSFdV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Nov 2019 00:33:21 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A1E4222DF;
        Tue, 19 Nov 2019 05:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574141600;
        bh=fzxvrBp3LsbCgd4FvX0URPQl8gN42nJGUeUp4p/M1dU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uHMMCWgYrrZH7l5PBeYETf6w9v/cLKBBF/ORcW+tAgaX6Y1JuDNuzlTKt7mpfo5hi
         ibo+SM/zWS2azeZGvD6hi7TBy4K87ewv6ubTqov5ioftiSAlw1/W7hzC7aVsrjTvue
         xu/AxioQwpZ7jUAXhYMQ//E8QGXTPcDH/y18KWQM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 215/422] pinctrl: at91: dont use the same irqchip with multiple gpiochips
Date:   Tue, 19 Nov 2019 06:16:52 +0100
Message-Id: <20191119051412.537446950@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191119051400.261610025@linuxfoundation.org>
References: <20191119051400.261610025@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ludovic Desroches <ludovic.desroches@microchip.com>

[ Upstream commit 0c3dfa176912b5f87732545598200fb55e9c1978 ]

Sharing the same irqchip with multiple gpiochips is not a good
practice. For instance, when installing hooks, we change the state
of the irqchip. The initial state of the irqchip for the second
gpiochip to register is then disrupted.

Signed-off-by: Ludovic Desroches <ludovic.desroches@microchip.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/pinctrl-at91.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
index 50f0ec42c6372..fad0e132ead84 100644
--- a/drivers/pinctrl/pinctrl-at91.c
+++ b/drivers/pinctrl/pinctrl-at91.c
@@ -1574,16 +1574,6 @@ void at91_pinctrl_gpio_resume(void)
 #define gpio_irq_set_wake	NULL
 #endif /* CONFIG_PM */
 
-static struct irq_chip gpio_irqchip = {
-	.name		= "GPIO",
-	.irq_ack	= gpio_irq_ack,
-	.irq_disable	= gpio_irq_mask,
-	.irq_mask	= gpio_irq_mask,
-	.irq_unmask	= gpio_irq_unmask,
-	/* .irq_set_type is set dynamically */
-	.irq_set_wake	= gpio_irq_set_wake,
-};
-
 static void gpio_irq_handler(struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_desc_get_chip(desc);
@@ -1624,12 +1614,22 @@ static int at91_gpio_of_irq_setup(struct platform_device *pdev,
 	struct gpio_chip	*gpiochip_prev = NULL;
 	struct at91_gpio_chip   *prev = NULL;
 	struct irq_data		*d = irq_get_irq_data(at91_gpio->pioc_virq);
+	struct irq_chip		*gpio_irqchip;
 	int ret, i;
 
+	gpio_irqchip = devm_kzalloc(&pdev->dev, sizeof(*gpio_irqchip), GFP_KERNEL);
+	if (!gpio_irqchip)
+		return -ENOMEM;
+
 	at91_gpio->pioc_hwirq = irqd_to_hwirq(d);
 
-	/* Setup proper .irq_set_type function */
-	gpio_irqchip.irq_set_type = at91_gpio->ops->irq_type;
+	gpio_irqchip->name = "GPIO";
+	gpio_irqchip->irq_ack = gpio_irq_ack;
+	gpio_irqchip->irq_disable = gpio_irq_mask;
+	gpio_irqchip->irq_mask = gpio_irq_mask;
+	gpio_irqchip->irq_unmask = gpio_irq_unmask;
+	gpio_irqchip->irq_set_wake = gpio_irq_set_wake,
+	gpio_irqchip->irq_set_type = at91_gpio->ops->irq_type;
 
 	/* Disable irqs of this PIO controller */
 	writel_relaxed(~0, at91_gpio->regbase + PIO_IDR);
@@ -1640,7 +1640,7 @@ static int at91_gpio_of_irq_setup(struct platform_device *pdev,
 	 * interrupt.
 	 */
 	ret = gpiochip_irqchip_add(&at91_gpio->chip,
-				   &gpio_irqchip,
+				   gpio_irqchip,
 				   0,
 				   handle_edge_irq,
 				   IRQ_TYPE_NONE);
@@ -1658,7 +1658,7 @@ static int at91_gpio_of_irq_setup(struct platform_device *pdev,
 	if (!gpiochip_prev) {
 		/* Then register the chain on the parent IRQ */
 		gpiochip_set_chained_irqchip(&at91_gpio->chip,
-					     &gpio_irqchip,
+					     gpio_irqchip,
 					     at91_gpio->pioc_virq,
 					     gpio_irq_handler);
 		return 0;
-- 
2.20.1



