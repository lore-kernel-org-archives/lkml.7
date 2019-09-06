Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18FFCC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 11:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F026D20854
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 11:09:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393223AbfIFLJK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 07:09:10 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47109 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392487AbfIFLIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 07:08:38 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i6C6H-00073P-8r; Fri, 06 Sep 2019 13:08:21 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5AC241C0DE8;
        Fri,  6 Sep 2019 13:08:15 +0200 (CEST)
Date:   Fri, 06 Sep 2019 11:08:15 -0000
From:   "tip-bot2 for Stephen Boyd" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip: Remove dev_err() usage after platform_get_irq()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Marc Zyngier <maz@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <156776809532.24167.9145068577595923086.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     6c9050a73469268c4c82129e2c840f33d4333bd5
Gitweb:        https://git.kernel.org/tip/6c9050a73469268c4c82129e2c840f33d4333bd5
Author:        Stephen Boyd <swboyd@chromium.org>
AuthorDate:    Tue, 30 Jul 2019 11:15:23 -07:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 20 Aug 2019 10:35:55 +01:00

irqchip: Remove dev_err() usage after platform_get_irq()

We don't need dev_err() messages when platform_get_irq() fails now that
platform_get_irq() prints an error message itself when something goes
wrong. Let's remove these prints with a simple semantic patch.

// <smpl>
@@
expression ret;
struct platform_device *E;
@@

ret =
(
platform_get_irq(E, ...)
|
platform_get_irq_byname(E, ...)
);

if ( \( ret < 0 \| ret <= 0 \) )
{
(
-if (ret != -EPROBE_DEFER)
-{ ...
-dev_err(...);
-... }
|
...
-dev_err(...);
)
...
}
// </smpl>

While we're here, remove braces on if statements that only have one
statement (manually).

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-imgpdc.c        | 8 ++------
 drivers/irqchip/irq-keystone.c      | 4 +---
 drivers/irqchip/qcom-irq-combiner.c | 4 +---
 3 files changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/irqchip/irq-imgpdc.c b/drivers/irqchip/irq-imgpdc.c
index d00489a..698d07f 100644
--- a/drivers/irqchip/irq-imgpdc.c
+++ b/drivers/irqchip/irq-imgpdc.c
@@ -362,10 +362,8 @@ static int pdc_intc_probe(struct platform_device *pdev)
 	}
 	for (i = 0; i < priv->nr_perips; ++i) {
 		irq = platform_get_irq(pdev, 1 + i);
-		if (irq < 0) {
-			dev_err(&pdev->dev, "cannot find perip IRQ #%u\n", i);
+		if (irq < 0)
 			return irq;
-		}
 		priv->perip_irqs[i] = irq;
 	}
 	/* check if too many were provided */
@@ -376,10 +374,8 @@ static int pdc_intc_probe(struct platform_device *pdev)
 
 	/* Get syswake IRQ number */
 	irq = platform_get_irq(pdev, 0);
-	if (irq < 0) {
-		dev_err(&pdev->dev, "cannot find syswake IRQ\n");
+	if (irq < 0)
 		return irq;
-	}
 	priv->syswake_irq = irq;
 
 	/* Set up an IRQ domain */
diff --git a/drivers/irqchip/irq-keystone.c b/drivers/irqchip/irq-keystone.c
index efbcf84..8118ebe 100644
--- a/drivers/irqchip/irq-keystone.c
+++ b/drivers/irqchip/irq-keystone.c
@@ -164,10 +164,8 @@ static int keystone_irq_probe(struct platform_device *pdev)
 	}
 
 	kirq->irq = platform_get_irq(pdev, 0);
-	if (kirq->irq < 0) {
-		dev_err(dev, "no irq resource %d\n", kirq->irq);
+	if (kirq->irq < 0)
 		return kirq->irq;
-	}
 
 	kirq->dev = dev;
 	kirq->mask = ~0x0;
diff --git a/drivers/irqchip/qcom-irq-combiner.c b/drivers/irqchip/qcom-irq-combiner.c
index d88e993..abfe592 100644
--- a/drivers/irqchip/qcom-irq-combiner.c
+++ b/drivers/irqchip/qcom-irq-combiner.c
@@ -248,10 +248,8 @@ static int __init combiner_probe(struct platform_device *pdev)
 		return err;
 
 	combiner->parent_irq = platform_get_irq(pdev, 0);
-	if (combiner->parent_irq <= 0) {
-		dev_err(&pdev->dev, "Error getting IRQ resource\n");
+	if (combiner->parent_irq <= 0)
 		return -EPROBE_DEFER;
-	}
 
 	combiner->domain = irq_domain_create_linear(pdev->dev.fwnode, combiner->nirqs,
 						    &domain_ops, combiner);
