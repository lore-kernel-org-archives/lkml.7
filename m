Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1212DC43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 12:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C39A320989
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 12:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="LpSUkQYu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731242AbfCaMfg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 08:35:36 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:17991 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726975AbfCaMff (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 08:35:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1554035734; x=1585571734;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=6IZK+5tanW/xUNL8pm7VpvQzsJDgY+GHrhJhRxnWkmQ=;
  b=LpSUkQYu5MieB+DRlw9YhVMDpeE6iGM7l3s68ej131YZrpxs4pxwmrJU
   70l68HQcOo8BUXQlSzeTkoy7MoxUO8HyrWlzQOzc44NCdUSf6FW21qWzR
   R1kBlZESkIl7oGdsuWXHjHdIak1zwqshw//sCEe3SHuMBFFaeFtGv+Q87
   c=;
X-IronPort-AV: E=Sophos;i="5.60,292,1549929600"; 
   d="scan'208";a="796653353"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2a-69849ee2.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 31 Mar 2019 12:35:34 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2a-69849ee2.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id x2VCZR9r093438
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Sun, 31 Mar 2019 12:35:32 GMT
Received: from EX13D19EUB003.ant.amazon.com (10.43.166.69) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 31 Mar 2019 12:35:31 +0000
Received: from ub6d44c9ce3e25c.ant.amazon.com (10.43.160.69) by
 EX13D19EUB003.ant.amazon.com (10.43.166.69) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 31 Mar 2019 12:35:21 +0000
From:   Hanna Hawa <hhhawa@amazon.com>
To:     <tsahee@annapurnalabs.com>, <antoine.tenart@bootlin.com>,
        <linux@armlinux.org.uk>, <catalin.marinas@arm.com>,
        <will.deacon@arm.com>, <rjw@rjwysocki.net>, <lenb@kernel.org>,
        <tglx@linutronix.de>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>
CC:     <ronenk@amazon.com>, <dwmw@amazon.co.uk>, <vaerov@amazon.com>,
        <zeev@amazon.com>, <alisaidi@amazon.com>, <talel@amazon.com>,
        <hhhawa@amazon.com>, <jonnyc@amazon.com>, <hanochu@amazon.com>,
        <barakw@amazon.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>
Subject: [PATCH 4/7] irqchip/al-msi: Update wrong parameter naming
Date:   Sun, 31 Mar 2019 15:34:12 +0300
Message-ID: <1554035655-11352-5-git-send-email-hhhawa@amazon.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554035655-11352-1-git-send-email-hhhawa@amazon.com>
References: <1554035655-11352-1-git-send-email-hhhawa@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.69]
X-ClientProxiedBy: EX13P01UWA003.ant.amazon.com (10.43.160.197) To
 EX13D19EUB003.ant.amazon.com (10.43.166.69)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the naming of sgi parameter to be spi, and fix comments.

The message interrupts target the SPIs in the target GIC, and not the
SGIs.

No functional change in this patch.

Signed-off-by: Hanna Hawa <hhhawa@amazon.com>
---
 drivers/irqchip/irq-al-msi.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/drivers/irqchip/irq-al-msi.c b/drivers/irqchip/irq-al-msi.c
index a1bbefc..f04a311c 100644
--- a/drivers/irqchip/irq-al-msi.c
+++ b/drivers/irqchip/irq-al-msi.c
@@ -28,8 +28,8 @@
 struct al_msix_data {
 	spinlock_t msi_map_lock;
 	phys_addr_t addr;
-	u32 spi_first;		/* The SGI number that MSIs start */
-	u32 num_spis;		/* The number of SGIs for MSIs */
+	u32 spi_first;		/* The SPI number that MSIs start */
+	u32 num_spis;		/* The number of SPIs for MSIs */
 	unsigned long *msi_map;
 };
 
@@ -53,7 +53,7 @@ static struct irq_chip al_msix_irq_chip = {
 	.irq_set_affinity	= irq_chip_set_affinity_parent,
 };
 
-static int al_msix_allocate_sgi(struct al_msix_data *priv, int num_req)
+static int al_msix_allocate_spi(struct al_msix_data *priv, int num_req)
 {
 	int first;
 
@@ -73,10 +73,10 @@ static int al_msix_allocate_sgi(struct al_msix_data *priv, int num_req)
 	return priv->spi_first + first;
 }
 
-static void al_msix_free_sgi(struct al_msix_data *priv, unsigned int sgi,
+static void al_msix_free_spi(struct al_msix_data *priv, unsigned int spi,
 			     int num_req)
 {
-	int first = sgi - priv->spi_first;
+	int first = spi - priv->spi_first;
 
 	spin_lock(&priv->msi_map_lock);
 
@@ -119,7 +119,7 @@ static struct irq_chip middle_irq_chip = {
 };
 
 static int al_msix_gic_domain_alloc(struct irq_domain *domain,
-				    unsigned int virq, int sgi)
+				    unsigned int virq, int spi)
 {
 	struct irq_fwspec fwspec;
 	struct irq_data *d;
@@ -131,7 +131,7 @@ static int al_msix_gic_domain_alloc(struct irq_domain *domain,
 	fwspec.fwnode = domain->parent->fwnode;
 	fwspec.param_count = 3;
 	fwspec.param[0] = 0;
-	fwspec.param[1] = sgi;
+	fwspec.param[1] = spi;
 	fwspec.param[2] = IRQ_TYPE_EDGE_RISING;
 
 	ret = irq_domain_alloc_irqs_parent(domain, virq, 1, &fwspec);
@@ -149,27 +149,27 @@ static int al_msix_middle_domain_alloc(struct irq_domain *domain,
 				       unsigned int nr_irqs, void *args)
 {
 	struct al_msix_data *priv = domain->host_data;
-	int sgi, err, i;
+	int spi, err, i;
 
-	sgi = al_msix_allocate_sgi(priv, nr_irqs);
-	if (sgi < 0)
-		return sgi;
+	spi = al_msix_allocate_spi(priv, nr_irqs);
+	if (spi < 0)
+		return spi;
 
 	for (i = 0; i < nr_irqs; i++) {
-		err = al_msix_gic_domain_alloc(domain, virq + i, sgi + i);
+		err = al_msix_gic_domain_alloc(domain, virq + i, spi + i);
 		if (err)
-			goto err_sgi;
+			goto err_spi;
 
-		irq_domain_set_hwirq_and_chip(domain, virq + i, sgi + i,
+		irq_domain_set_hwirq_and_chip(domain, virq + i, spi + i,
 					      &middle_irq_chip, priv);
 	}
 
 	return 0;
 
-err_sgi:
+err_spi:
 	while (--i >= 0)
 		irq_domain_free_irqs_parent(domain, virq, i);
-	al_msix_free_sgi(priv, sgi, nr_irqs);
+	al_msix_free_spi(priv, spi, nr_irqs);
 	return err;
 }
 
@@ -181,7 +181,7 @@ static void al_msix_middle_domain_free(struct irq_domain *domain,
 	struct al_msix_data *priv = irq_data_get_irq_chip_data(d);
 
 	irq_domain_free_irqs_parent(domain, virq, nr_irqs);
-	al_msix_free_sgi(priv, d->hwirq, nr_irqs);
+	al_msix_free_spi(priv, d->hwirq, nr_irqs);
 }
 
 static const struct irq_domain_ops al_msix_middle_domain_ops = {
-- 
2.7.4

