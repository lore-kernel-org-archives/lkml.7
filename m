Return-Path: <SRS0=OvUS=X5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C3F4C47404
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 15:07:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A18C222C4
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Oct 2019 15:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570201672;
	bh=qYioEzDmICb0pDIcd2sao32iGGG/DdI1z0g1uD+bG7w=;
	h=From:To:Subject:Date:In-Reply-To:References:List-ID:From;
	b=v8WwWph7bZ/urgq9Cw3asBa9PR8RShDe9vrf/PJiQxs22iaaCQ9DbV3GF/UwDNtPt
	 ZAgVIuTqUBRVs5lWsFyhkGjrievQBh8ffdpjQB7fC89mVzq/5LvutTbsh63gbISNJ2
	 IdLpKmJITaP6RyPjE4138oez79evF+dx0xJgA5IY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389637AbfJDPHv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Oct 2019 11:07:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:50402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388802AbfJDPHt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 11:07:49 -0400
Received: from localhost.localdomain (unknown [194.230.155.145])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F257521D81;
        Fri,  4 Oct 2019 15:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570201668;
        bh=qYioEzDmICb0pDIcd2sao32iGGG/DdI1z0g1uD+bG7w=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=QxMOULfhqAHILdyIZyGrilDN3NMOHFLVFs1DQK2m3A3Kgc53Sy9lrgf6WfAxseFC7
         z/lVWyJmrLK/sgW43+7YUZGRN5UNjWPy69Cgt2uB4Pdv/a3PxmdjvZmBIc5ZgVPMqg
         1nZLHnCqZVXtqEkiGjZZ4X0sMtIH74tEyFJS6YWA=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFT 2/3] power: supply: ab8500_fg: Do not free non-requested IRQs in probe's error path
Date:   Fri,  4 Oct 2019 17:07:37 +0200
Message-Id: <20191004150738.6542-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191004150738.6542-1-krzk@kernel.org>
References: <20191004150738.6542-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When requesting interrupt fails, free only interrupts already requested,
not all of them.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Not marking as cc-stable as this was not reproduced and not tested.
---
 drivers/power/supply/ab8500_fg.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index 36bbb8ea05da..7d879589adc2 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -3158,7 +3158,7 @@ static int ab8500_fg_probe(struct platform_device *pdev)
 		if (ret != 0) {
 			dev_err(di->dev, "failed to request %s IRQ %d: %d\n",
 				ab8500_fg_irq_th[i].name, irq, ret);
-			goto free_irq;
+			goto free_irq_th;
 		}
 		dev_dbg(di->dev, "Requested %s IRQ %d: %d\n",
 			ab8500_fg_irq_th[i].name, irq, ret);
@@ -3173,7 +3173,7 @@ static int ab8500_fg_probe(struct platform_device *pdev)
 	if (ret != 0) {
 		dev_err(di->dev, "failed to request %s IRQ %d: %d\n",
 			ab8500_fg_irq_bh[0].name, irq, ret);
-		goto free_irq;
+		goto free_irq_th;
 	}
 	dev_dbg(di->dev, "Requested %s IRQ %d: %d\n",
 		ab8500_fg_irq_bh[0].name, irq, ret);
@@ -3215,7 +3215,9 @@ static int ab8500_fg_probe(struct platform_device *pdev)
 	/* We also have to free all registered irqs */
 	irq = platform_get_irq_byname(pdev, ab8500_fg_irq_bh[0].name);
 	free_irq(irq, di);
-	for (i = 0; i < ARRAY_SIZE(ab8500_fg_irq_th); i++) {
+free_irq_th:
+	while (--i >= 0) {
+		/* Last assignment of i from primary interrupt handlers */
 		irq = platform_get_irq_byname(pdev, ab8500_fg_irq_th[i].name);
 		free_irq(irq, di);
 	}
-- 
2.17.1

