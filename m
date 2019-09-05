Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F209C3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 03:50:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A311208E4
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 03:50:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="XyM51OJW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730741AbfIEDue (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 23:50:34 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:38925 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbfIEDue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 23:50:34 -0400
Received: from localhost.localdomain (p14092-ipngnfx01kyoto.kyoto.ocn.ne.jp [153.142.97.92]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id x853naL4022436;
        Thu, 5 Sep 2019 12:49:36 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com x853naL4022436
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1567655376;
        bh=m+VFVDgsbj7vdDly5A6Xk6C0RvP7zfj9OdjMeGF3RbM=;
        h=From:To:Cc:Subject:Date:From;
        b=XyM51OJWda3Wd0pahMvAKiSfBLO4I85fcNhBbIorH1tg1KsrSN/w+GAtiUETA0lOr
         VJEcO4+nZEWa+Hsfzghx66gPYhUs3kiaNScFuwgf1QL/ui5ISGp7HxQA8h6tEmOsxV
         1Q/IM5OMaAmyCVu4D+qIYOEAijJXYyEcH13wWu+jYsvQWR2xpBiuGpm6jsEh7whMVg
         n9m5BbTj2W7VDkAGrIjYurD6/b1LH3/cr4tfpbU045p44JFn838L0h2xAKtT0rXzt6
         P93ga3wjY8zwMnObhW1n9yksTk9+hsSRnyl3OK0d7pHLoEYmJU9U80zsORF7SLT5fg
         UyoLJD/8SnYQA==
X-Nifty-SrcIP: [153.142.97.92]
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
To:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] irqchip: uniphier-aidet: use devm_platform_ioremap_resource()
Date:   Thu,  5 Sep 2019 12:49:32 +0900
Message-Id: <20190905034932.12587-1-yamada.masahiro@socionext.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the chain of platform_get_resource() and devm_ioremap_resource()
with devm_platform_ioremap_resource().

This allows to remove the local variable for (struct resource *), and
have one function call less.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 drivers/irqchip/irq-uniphier-aidet.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-uniphier-aidet.c b/drivers/irqchip/irq-uniphier-aidet.c
index ed7b4f47ff3f..89121b39be26 100644
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
 
-- 
2.17.1

