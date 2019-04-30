Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 185D3C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 10:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBE7721670
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 10:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mo6y7xYp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727241AbfD3KNy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 06:13:54 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:56746 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727165AbfD3KNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 06:13:53 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3UADXVA010141;
        Tue, 30 Apr 2019 05:13:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1556619213;
        bh=xPQl9JjmQxyn3zo4bM1wLXs+byZ03Zol063XB/EjZcQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=mo6y7xYpMHsgFc7vM+Voz7QCzhSAu67LApEALVUUjrR9mHjKYVlj6KZZ5OYa4qkEZ
         GLnzyuAGX7cvCctyDrINmtiKuEW+B/RZxUHeCy7s/+8x0TsK6idfx3GCN3IChQXbMk
         FqVyxCXmb1/Y1K/P82oNiRAa/N4xlMNl6b8CEtos=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3UADXLh126058
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 Apr 2019 05:13:33 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 30
 Apr 2019 05:13:32 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 30 Apr 2019 05:13:32 -0500
Received: from uda0131933.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3UAD0Y8085082;
        Tue, 30 Apr 2019 05:13:28 -0500
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
Subject: [PATCH v8 06/14] genirq: Introduce irq_chip_{request,release}_resource_parent() apis
Date:   Tue, 30 Apr 2019 15:42:22 +0530
Message-ID: <20190430101230.21794-7-lokeshvutla@ti.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190430101230.21794-1-lokeshvutla@ti.com>
References: <20190430101230.21794-1-lokeshvutla@ti.com>
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
Changes since v7:
-None

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

