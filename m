Return-Path: <SRS0=n7Fw=UL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47600C31E46
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 05:16:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C9D82086A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Jun 2019 05:16:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730549AbfFLFQ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Jun 2019 01:16:26 -0400
Received: from gate.crashing.org ([63.228.1.57]:51103 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725958AbfFLFQ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 01:16:26 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x5C5G5tU001179;
        Wed, 12 Jun 2019 00:16:07 -0500
Message-ID: <e4c7b434452775d00b6621012ad5e263076b3fcf.camel@kernel.crashing.org>
Subject: [PATCH+DISCUSSION] irqchip: armada-370-xp: Remove redundant ops
 assignment
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc:     Gregory CLEMENT <gregory.clement@free-electrons.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Wed, 12 Jun 2019 15:16:05 +1000
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pci_msi_create_irq_domain -> pci_msi_domain_update_chip_ops will
set those two already since the driver sets MSI_FLAG_USE_DEF_CHIP_OPS

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

[UNTESTED]

Just something I noticed while browsing through those drivers in
search of ways to factor some of the code.

That leads to a question here:

Some MSI drivers such as this one (or any using the defaults mask/unmask
provided by drivers/pci/msi.c) only call the PCI MSI mask/unmask functions.

Some other drivers call those PCI function but *also* call the parent
mask/unmask (giv-v2m for example) which generally is the inner domain
which just itself forwards to its own parent.

Is there any preference for doing it one way or the other ? I can see
that in cases where the device doesn't support MSI masking, calling the
parent could be useful but we don't know that at the moment in the
corresponding code.

It feels like something we should consolidate (and remove code from
drivers). For example, the defaults in drivers/pci/msi.c could always
call the parent if it exists and has a mask/unmask callback.

Opinions ? I'm happy to produce patches once we agree...

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
index c9bdc5221b82..911230f28e2d 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -197,8 +197,6 @@ static void armada_370_xp_irq_unmask(struct irq_data *d)
 
 static struct irq_chip armada_370_xp_msi_irq_chip = {
 	.name = "MPIC MSI",
-	.irq_mask = pci_msi_mask_irq,
-	.irq_unmask = pci_msi_unmask_irq,
 };
 
 static struct msi_domain_info armada_370_xp_msi_domain_info = {

