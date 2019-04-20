Return-Path: <SRS0=ruH4=SW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D96C282E2
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 10:11:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 80AE32186A
	for <linux-kernel@archiver.kernel.org>; Sat, 20 Apr 2019 10:11:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Cgx3VHoj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728173AbfDTKLX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 20 Apr 2019 06:11:23 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:54570 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727922AbfDTKLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Apr 2019 06:11:21 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3KAAnTE023748;
        Sat, 20 Apr 2019 05:10:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1555755050;
        bh=hYgQZLwdVEu2Jv9X+FiwCNP4RJj9SEUYOWe2S7VOsQQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Cgx3VHoj8I3P+lTgbzydTWRpjYvj7rDKTjoDP4LSuS2AFo5FUXzbs0KoUubP+upIQ
         /CmNWiZoFnU34l9nBclhfo2HpHG/vFtYCO2Dy4wDzANdH2GquTJOA/2DrRSkjpP9RR
         E5Z9cU8w3yF9txZUeCOaVwOd7Ajhf62Z/wML4AYk=
Received: from DLEE111.ent.ti.com (dlee111.ent.ti.com [157.170.170.22])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3KAAnUt097487
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 20 Apr 2019 05:10:49 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Sat, 20
 Apr 2019 05:10:49 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Sat, 20 Apr 2019 05:10:49 -0500
Received: from uda0131933.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3KAAHZv070234;
        Sat, 20 Apr 2019 05:10:45 -0500
From:   Lokesh Vutla <lokeshvutla@ti.com>
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
        <tglx@linutronix.de>, <jason@lakedaemon.net>
CC:     Linux ARM Mailing List <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Tero Kristo <t-kristo@ti.com>,
        Sekhar Nori <nsekhar@ti.com>, Tony Lindgren <tony@atomide.com>,
        <linus.walleij@linaro.org>, Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Device Tree Mailing List <devicetree@vger.kernel.org>
Subject: [PATCH v7 06/14] genirq: Introduce irq_chip_{request,release}_resource_parent() apis
Date:   Sat, 20 Apr 2019 15:39:42 +0530
Message-ID: <20190420100950.7997-7-lokeshvutla@ti.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190420100950.7997-1-lokeshvutla@ti.com>
References: <20190420100950.7997-1-lokeshvutla@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce irq_chip_{request,release}_resource_parent() apis so
that these can be used in hierarchical irqchips.

Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
---
Changes since v6:
- New patch

 include/linux/irq.h |  2 ++
 kernel/irq/chip.c   | 27 +++++++++++++++++++++++++++
 2 files changed, 29 insertions(+)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 7ae8de5ad0f2..fb301cf29148 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -625,6 +625,8 @@ extern int irq_chip_set_wake_parent(struct irq_data *data, unsigned int on);
 extern int irq_chip_set_vcpu_affinity_parent(struct irq_data *data,
 					     void *vcpu_info);
 extern int irq_chip_set_type_parent(struct irq_data *data, unsigned int type);
+extern int irq_chip_request_resources_parent(struct irq_data *data);
+extern void irq_chip_release_resources_parent(struct irq_data *data);
 #endif
 
 /* Handling of unhandled and spurious interrupts: */
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 51128bea3846..29d6c7d070b4 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -1459,6 +1459,33 @@ int irq_chip_set_wake_parent(struct irq_data *data, unsigned int on)
 	return -ENOSYS;
 }
 EXPORT_SYMBOL_GPL(irq_chip_set_wake_parent);
+
+/**
+ * irq_chip_request_resources_parent - Request resources on the parent interrupt
+ * @data:	Pointer to interrupt specific data
+ */
+int irq_chip_request_resources_parent(struct irq_data *data)
+{
+	data = data->parent_data;
+
+	if (data->chip->irq_request_resources)
+		return data->chip->irq_request_resources(data);
+
+	return -ENOSYS;
+}
+EXPORT_SYMBOL_GPL(irq_chip_request_resources_parent);
+
+/**
+ * irq_chip_release_resources_parent - Release resources on the parent interrupt
+ * @data:	Pointer to interrupt specific data
+ */
+void irq_chip_release_resources_parent(struct irq_data *data)
+{
+	data = data->parent_data;
+	if (data->chip->irq_release_resources)
+		data->chip->irq_release_resources(data);
+}
+EXPORT_SYMBOL_GPL(irq_chip_release_resources_parent);
 #endif
 
 /**
-- 
2.21.0

