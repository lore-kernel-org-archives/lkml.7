Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD7A1CA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 14:44:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 934F421D80
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 14:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572187484;
	bh=hs2nwn07oy+s0UfoqrxrS6DXQmYU6agBSrXljPfGE/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=db2SZ2Quc4dmGt0MNL1b4/LClKQg7lyAr0BWXSDNuBhzLeAKWMN+ioD0WALNvzKsu
	 EXuDbmY/AnJYhCKH+cYeiUT+BBSMMwqssmPo2dAze+2YllQZe6oXj9tfN4EvH8Epvl
	 egVeExhp5VLawNVFlyzfaEg9WelOuuYJ6wnOiDTQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfJ0Oon (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 10:44:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:37832 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726944AbfJ0Oon (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 10:44:43 -0400
Received: from localhost.localdomain (82-132-239-15.dab.02.net [82.132.239.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0DF4214AF;
        Sun, 27 Oct 2019 14:44:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572187482;
        bh=hs2nwn07oy+s0UfoqrxrS6DXQmYU6agBSrXljPfGE/w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TD9ZKXznkULRWZ9s7Jeyh1O8qBOcFm+euTuml9VcPsnqJnw2JEcGhXR0Bi8nM1Eq4
         1sWZsKscuWv8c44r76xkEUAzOf27H45+xkyfYbCZsmYXDHSwVUmZilY/bj6n1wFk22
         rJRzLv1/o9MAZZr878TjhIiXMexfYxi6Vrque9zw=
From:   Marc Zyngier <maz@kernel.org>
To:     kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
Cc:     Eric Auger <eric.auger@redhat.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <Andrew.Murray@arm.com>,
        Zenghui Yu <yuzenghui@huawei.com>,
        Jayachandran C <jnair@marvell.com>,
        Robert Richter <rrichter@marvell.com>
Subject: [PATCH v2 15/36] irqchip/gic-v4.1: Plumb skeletal VPE irqchip
Date:   Sun, 27 Oct 2019 14:42:13 +0000
Message-Id: <20191027144234.8395-16-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191027144234.8395-1-maz@kernel.org>
References: <20191027144234.8395-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just like for GICv4.0, each VPE has its own doorbell interrupt, and
thus an irqchip that manages them. Since the doorbell management is
quite different on GICv4.1, let's introduce an almost empty irqchip
the will get populated over the next new patches.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v3-its.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index b5a122093a46..dcc7227af5f1 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -3408,6 +3408,32 @@ static struct irq_chip its_vpe_irq_chip = {
 	.irq_set_vcpu_affinity	= its_vpe_set_vcpu_affinity,
 };
 
+static int its_vpe_4_1_set_vcpu_affinity(struct irq_data *d, void *vcpu_info)
+{
+	struct its_cmd_info *info = vcpu_info;
+
+	switch (info->cmd_type) {
+	case SCHEDULE_VPE:
+		return 0;
+
+	case DESCHEDULE_VPE:
+		return 0;
+
+	case INVALL_VPE:
+		return 0;
+
+	default:
+		return -EINVAL;
+	}
+}
+
+static struct irq_chip its_vpe_4_1_irq_chip = {
+	.name			= "GICv4.1-vpe",
+	.irq_eoi		= irq_chip_eoi_parent,
+	.irq_set_affinity	= its_vpe_set_affinity,
+	.irq_set_vcpu_affinity	= its_vpe_4_1_set_vcpu_affinity,
+};
+
 static int its_vpe_id_alloc(void)
 {
 	return ida_simple_get(&its_vpeid_ida, 0, ITS_MAX_VPEID, GFP_KERNEL);
@@ -3488,6 +3514,7 @@ static void its_vpe_irq_domain_free(struct irq_domain *domain,
 static int its_vpe_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
 				    unsigned int nr_irqs, void *args)
 {
+	struct irq_chip *irqchip = &its_vpe_irq_chip;
 	struct its_vm *vm = args;
 	unsigned long *bitmap;
 	struct page *vprop_page;
@@ -3515,6 +3542,9 @@ static int its_vpe_irq_domain_alloc(struct irq_domain *domain, unsigned int virq
 	vm->nr_db_lpis = nr_ids;
 	vm->vprop_page = vprop_page;
 
+	if (gic_rdists->has_rvpeid)
+		irqchip = &its_vpe_4_1_irq_chip;
+
 	for (i = 0; i < nr_irqs; i++) {
 		vm->vpes[i]->vpe_db_lpi = base + i;
 		err = its_vpe_init(vm->vpes[i]);
@@ -3525,7 +3555,7 @@ static int its_vpe_irq_domain_alloc(struct irq_domain *domain, unsigned int virq
 		if (err)
 			break;
 		irq_domain_set_hwirq_and_chip(domain, virq + i, i,
-					      &its_vpe_irq_chip, vm->vpes[i]);
+					      irqchip, vm->vpes[i]);
 		set_bit(i, bitmap);
 	}
 
-- 
2.20.1

