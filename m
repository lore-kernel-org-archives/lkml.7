Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0533CC43603
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 16:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD89A2073D
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 16:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576080337;
	bh=Mq3SGusfebHCfJl9Dcu8BiE07V5/LWMYiVw7kO22oiU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jXcFQmeBQ0woUCQGOKMOdIP50bLk4jBmXnxYHPNtgbByEeE8iv7Q9UUXY2azEH8j3
	 eHgVRzWYyPi9EG8dXN/SWytAmjdf5gLrd0S1mnkYPh1IRsFMY96ACa3Q/tqwhkYsNH
	 4hXcTpkkpOEZA0/1ObExRPEeYjGHA/mB2OqLGBeM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388894AbfLKQFg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 11:05:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:35136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731231AbfLKPMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 10:12:48 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 895E424680;
        Wed, 11 Dec 2019 15:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576077168;
        bh=Mq3SGusfebHCfJl9Dcu8BiE07V5/LWMYiVw7kO22oiU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vYn2jmZGrt3esF5ECOasaICEbfqwMEd8uUdwNiSJ6IAwyG4pSv7T+G6IDXorjWj99
         49jMn3W1vOWDns/B0QokUC085YtxFd7MU4DmV9HOaFagfsKkFXnthiv/2pF8g4TKrK
         +hc754F9E6rYJ1sABCHIKKziEgtoAj7oWFCJg69U=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Paul Cercueil <paul@crapouillou.net>,
        Marc Zyngier <maz@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 053/134] irqchip: ingenic: Error out if IRQ domain creation failed
Date:   Wed, 11 Dec 2019 10:10:29 -0500
Message-Id: <20191211151150.19073-53-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191211151150.19073-1-sashal@kernel.org>
References: <20191211151150.19073-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paul Cercueil <paul@crapouillou.net>

[ Upstream commit 52ecc87642f273a599c9913b29fd179c13de457b ]

If we cannot create the IRQ domain, the driver should fail to probe
instead of succeeding with just a warning message.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/1570015525-27018-3-git-send-email-zhouyanjie@zoho.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/irqchip/irq-ingenic.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-ingenic.c b/drivers/irqchip/irq-ingenic.c
index f126255b3260c..dda512dfe2c17 100644
--- a/drivers/irqchip/irq-ingenic.c
+++ b/drivers/irqchip/irq-ingenic.c
@@ -108,6 +108,14 @@ static int __init ingenic_intc_of_init(struct device_node *node,
 		goto out_unmap_irq;
 	}
 
+	domain = irq_domain_add_legacy(node, num_chips * 32,
+				       JZ4740_IRQ_BASE, 0,
+				       &irq_domain_simple_ops, NULL);
+	if (!domain) {
+		err = -ENOMEM;
+		goto out_unmap_base;
+	}
+
 	for (i = 0; i < num_chips; i++) {
 		/* Mask all irqs */
 		writel(0xffffffff, intc->base + (i * CHIP_SIZE) +
@@ -134,14 +142,11 @@ static int __init ingenic_intc_of_init(struct device_node *node,
 				       IRQ_NOPROBE | IRQ_LEVEL);
 	}
 
-	domain = irq_domain_add_legacy(node, num_chips * 32, JZ4740_IRQ_BASE, 0,
-				       &irq_domain_simple_ops, NULL);
-	if (!domain)
-		pr_warn("unable to register IRQ domain\n");
-
 	setup_irq(parent_irq, &intc_cascade_action);
 	return 0;
 
+out_unmap_base:
+	iounmap(intc->base);
 out_unmap_irq:
 	irq_dispose_mapping(parent_irq);
 out_free:
-- 
2.20.1

