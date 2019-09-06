Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF707C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 11:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3C87206BB
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 11:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729395AbfIFLKQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 07:10:16 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47012 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392228AbfIFLIX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 07:08:23 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i6C6A-00072C-Qa; Fri, 06 Sep 2019 13:08:14 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 299391C0DE8;
        Fri,  6 Sep 2019 13:08:14 +0200 (CEST)
Date:   Fri, 06 Sep 2019 11:08:14 -0000
From:   "tip-bot2 for Masahiro Yamada" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/uniphier-aidet: Use devm_platform_ioremap_resource()
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Marc Zyngier <maz@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20190905034932.12587-1-yamada.masahiro@socionext.com>
References: <20190905034932.12587-1-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Message-ID: <156776809407.24167.7594401755357124629.tip-bot2@tip-bot2>
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

Commit-ID:     e89327f659dd517f30b6232b1fabd6f6c6777c3e
Gitweb:        https://git.kernel.org/tip/e89327f659dd517f30b6232b1fabd6f6c6777c3e
Author:        Masahiro Yamada <yamada.masahiro@socionext.com>
AuthorDate:    Thu, 05 Sep 2019 12:49:32 +09:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 05 Sep 2019 09:28:13 +01:00

irqchip/uniphier-aidet: Use devm_platform_ioremap_resource()

Replace the chain of platform_get_resource() and devm_ioremap_resource()
with devm_platform_ioremap_resource().

This allows to remove the local variable for (struct resource *), and
have one function call less.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20190905034932.12587-1-yamada.masahiro@socionext.com
---
 drivers/irqchip/irq-uniphier-aidet.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-uniphier-aidet.c b/drivers/irqchip/irq-uniphier-aidet.c
index ed7b4f4..89121b3 100644
--- a/drivers/irqchip/irq-uniphier-aidet.c
+++ b/drivers/irqchip/irq-uniphier-aidet.c
@@ -166,7 +166,6 @@ static int uniphier_aidet_probe(struct platform_device *pdev)
 	struct device_node *parent_np;
 	struct irq_domain *parent_domain;
 	struct uniphier_aidet_priv *priv;
-	struct resource *res;
 
 	parent_np = of_irq_find_parent(dev->of_node);
 	if (!parent_np)
@@ -181,8 +180,7 @@ static int uniphier_aidet_probe(struct platform_device *pdev)
 	if (!priv)
 		return -ENOMEM;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	priv->reg_base = devm_ioremap_resource(dev, res);
+	priv->reg_base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(priv->reg_base))
 		return PTR_ERR(priv->reg_base);
 
