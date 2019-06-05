Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B44C282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 06:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB806206BA
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 06:55:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="AQWjnzxa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfFEGzM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 02:55:12 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:60934 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbfFEGzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 02:55:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1559717709; x=1591253709;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=+jzu3rfqIEsHpAlKj+HQyzKuayZFNSN++n05AsZi5qA=;
  b=AQWjnzxaymypqVRPlG1VzrCvk8hsU/OUllxCS/Ue95ubmvRkv7jpldDY
   nuPof28zxQiG5e5yQAf0P/VAddta/QqSkKt60P3pq8CnnzERURshUhVnO
   de+Ce3ZSU9YN1mPQdWm1ddUs1XJVSuCWXWFpwQfnIdR9jS9N7RWnc9+7i
   Q=;
X-IronPort-AV: E=Sophos;i="5.60,550,1549929600"; 
   d="scan'208";a="803662369"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 05 Jun 2019 06:55:08 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com (Postfix) with ESMTPS id D8B7EA26C1;
        Wed,  5 Jun 2019 06:55:04 +0000 (UTC)
Received: from EX13D01EUB001.ant.amazon.com (10.43.166.194) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 5 Jun 2019 06:55:04 +0000
Received: from udc4a3e82dbc15a031435.hfa15.amazon.com (10.43.160.91) by
 EX13D01EUB001.ant.amazon.com (10.43.166.194) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 5 Jun 2019 06:54:54 +0000
From:   Talel Shenhar <talel@amazon.com>
To:     <nicolas.ferre@microchip.com>, <jason@lakedaemon.net>,
        <marc.zyngier@arm.com>, <mark.rutland@arm.com>,
        <mchehab+samsung@kernel.org>, <robh+dt@kernel.org>,
        <davem@davemloft.net>, <shawn.lin@rock-chips.com>,
        <tglx@linutronix.de>, <devicetree@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <linux-kernel@vger.kernel.org>
CC:     <dwmw@amazon.co.uk>, <benh@kernel.crashing.org>,
        <jonnyc@amazon.com>, <hhhawa@amazon.com>, <ronenk@amazon.com>,
        <hanochu@amazon.com>, <barakw@amazon.com>,
        Talel Shenhar <talel@amazon.com>
Subject: [PATCH 3/3] irqchip: al-fic: Introducing support for MSI-X
Date:   Wed, 5 Jun 2019 09:54:13 +0300
Message-ID: <1559717653-11258-4-git-send-email-talel@amazon.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559717653-11258-1-git-send-email-talel@amazon.com>
References: <1559717653-11258-1-git-send-email-talel@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.43.160.91]
X-ClientProxiedBy: EX13d09UWC001.ant.amazon.com (10.43.162.60) To
 EX13D01EUB001.ant.amazon.com (10.43.166.194)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The FIC supports either a (single) wired output, or generation of an MSI-X
interrupt per input (for cases where it is embedded in a PCIe device,
hence, allowing the PCIe drivers to call this API).
This patch introduces the support for allowing the configuration of MSI-X
instead of a wire interrupt.

Signed-off-by: Talel Shenhar <talel@amazon.com>
---
 drivers/irqchip/irq-al-fic.c   | 48 +++++++++++++++++++++++++++++++++++++++---
 include/linux/irqchip/al-fic.h |  2 ++
 2 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-al-fic.c b/drivers/irqchip/irq-al-fic.c
index d881d42..e49b912 100644
--- a/drivers/irqchip/irq-al-fic.c
+++ b/drivers/irqchip/irq-al-fic.c
@@ -19,6 +19,7 @@
 #define AL_FIC_MASK		0x10
 #define AL_FIC_CONTROL		0x28
 
+#define CONTROL_AUTO_CLEAR	BIT(2)
 #define CONTROL_TRIGGER_RISING	BIT(3)
 #define CONTROL_MASK_MSI_X	BIT(5)
 
@@ -193,9 +194,11 @@ struct irq_domain *al_fic_wire_get_domain(struct al_fic *fic)
 }
 EXPORT_SYMBOL_GPL(al_fic_wire_get_domain);
 
-static void al_fic_hw_init(struct al_fic *fic)
+static void al_fic_hw_init(struct al_fic *fic,
+			   int use_msi)
 {
-	u32 control = CONTROL_MASK_MSI_X;
+	u32 control = (use_msi ? (CONTROL_AUTO_CLEAR | CONTROL_TRIGGER_RISING) :
+		       CONTROL_MASK_MSI_X);
 
 	/* mask out all interrupts */
 	writel(0xFFFFFFFF, fic->base + AL_FIC_MASK);
@@ -240,7 +243,7 @@ struct al_fic *al_fic_wire_init(struct device_node *node,
 	fic->parent_irq = parent_irq;
 	fic->name = (name ?: "al-fic-wire");
 
-	al_fic_hw_init(fic);
+	al_fic_hw_init(fic, false);
 
 	ret = al_fic_register(node, fic);
 	if (ret) {
@@ -260,6 +263,45 @@ struct al_fic *al_fic_wire_init(struct device_node *node,
 EXPORT_SYMBOL_GPL(al_fic_wire_init);
 
 /**
+ * al_fic_msi_x_init() - initialize and configure fic in msi-x mode
+ * @base: mmio to fic register
+ * @name: name of the fic
+ *
+ * This API will configure the fic hardware to to work in msi-x mode.
+ * msi-x fic is to be configured for fics that are embedded inside AL PCIE EP.
+ * Those kind of fic are aware of the fact that they live inside PCIE and
+ * familiar with the MSI-X table which is configured as part of
+ * pci_enable_msix_range() and friends.
+ * Interrupt can be generated based on a positive edge or level - configuration
+ * is to be determined based on connected hardware to this fic.
+ *
+ * Returns pointer to fic context or ERR_PTR in case of error.
+ */
+struct al_fic *al_fic_msi_x_init(void __iomem *base,
+				 const char *name)
+{
+	struct al_fic *fic;
+
+	if (!base)
+		return ERR_PTR(-EINVAL);
+
+	fic = kzalloc(sizeof(*fic), GFP_KERNEL);
+	if (!fic)
+		return ERR_PTR(-ENOMEM);
+
+	fic->base = base;
+	fic->name = (name ?: "al-fic-full-fledged");
+
+	al_fic_hw_init(fic, true);
+
+	pr_debug("%s initialized successfully in Full-Fledged mode\n",
+		 fic->name);
+
+	return fic;
+}
+EXPORT_SYMBOL_GPL(al_fic_msi_x_init);
+
+/**
  * al_fic_cleanup() - free all resources allocated by fic
  * @fic: pointer to fic context
  *
diff --git a/include/linux/irqchip/al-fic.h b/include/linux/irqchip/al-fic.h
index 0833749..a2e89ff 100644
--- a/include/linux/irqchip/al-fic.h
+++ b/include/linux/irqchip/al-fic.h
@@ -16,6 +16,8 @@ struct al_fic *al_fic_wire_init(struct device_node *node,
 				void __iomem *base,
 				const char *name,
 				unsigned int parent_irq);
+struct al_fic *al_fic_msi_x_init(void __iomem *base,
+				 const char *name);
 int al_fic_cleanup(struct al_fic *fic);
 
 #endif
-- 
2.7.4

