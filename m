Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A540C3276C
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6216F22314
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 22:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578003188;
	bh=pDuXdvwcH9iqYEt10AaDUURx/7FQZnI+NBdX5KLKZNc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=A9+uKpyKZPZwfgSIB/iEvGQ4YBkM75IgfZSoC91Jb59Q7LPTloWzVH1eNCBJwPwrM
	 ZYAIyyOeKhC5jPEksytzO7iEmU2WeRjVv/zoCPID3BzsLf9H9IkhVtUl5Ja1uwlc42
	 kd9HskmxI7voc44PMrKV91NLMlWifayQc3LZmV1I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbgABWNH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 17:13:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:52570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727602AbgABWNC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 17:13:02 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF6AB22B48;
        Thu,  2 Jan 2020 22:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578003182;
        bh=pDuXdvwcH9iqYEt10AaDUURx/7FQZnI+NBdX5KLKZNc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KFC9Q9zlTS/EfAZB/GmbGgG5o2flyY1gYOUU2oUCVPyaSqzXOFVaRp0cqjP8fyo1J
         WFPT2rDO0Pw6ACzF8k0OjbdRKYGTBT9o6EYpa1Hl7slLO8R7tr4fpcxkt0+xFwGrx+
         yuaUZqYrDfrkMzrCGegPGtwOm6JCgTNepRQIipRs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Marc Zyngier <maz@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 053/191] irqchip: ingenic: Error out if IRQ domain creation failed
Date:   Thu,  2 Jan 2020 23:05:35 +0100
Message-Id: <20200102215835.586756286@linuxfoundation.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200102215829.911231638@linuxfoundation.org>
References: <20200102215829.911231638@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index f126255b3260..dda512dfe2c1 100644
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



