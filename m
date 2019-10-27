Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F37CA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 14:46:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34CFD21850
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 14:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572187582;
	bh=wb8MnmVIHroJM9PSk6o4I+88KKLW/wWOgZB5RORktF4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=t2HPn2plKG+JTEgvv4AKZ72orkNJfe807OKeTZ4VH2hoTYHXozVE98Zid4LqEKS84
	 Bi+4xoNOtjXcTErAAOaq761HOI3/QKhIehwlVu1EqoXtQmrShU7EFoIqOfFojE5xlO
	 uLBgmoANOs7L84A+SAc+Z9oIxxaEnrwd+GcW51pQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727506AbfJ0OqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 10:46:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:38982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726817AbfJ0OqU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 10:46:20 -0400
Received: from localhost.localdomain (82-132-239-15.dab.02.net [82.132.239.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EED521726;
        Sun, 27 Oct 2019 14:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572187580;
        bh=wb8MnmVIHroJM9PSk6o4I+88KKLW/wWOgZB5RORktF4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lmNHF40SztBAGcoItfEeP4saZVNK3PO8ndRou08M55Se0UZhKIR+LYFNJcCCd9yQ0
         JuGa3PcjSKcsWdIQVo8cEPrQodmraqCEbggPzzgbiAbtCJuAHUV5B0zmI3Mt6t9vFw
         W5fZwx41oPaHllmwvevsCvI/X+1RoHc+UJYtrJyg=
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
Subject: [PATCH v2 31/36] irqchip/gic-v4.1: Add VSGI property setup
Date:   Sun, 27 Oct 2019 14:42:29 +0000
Message-Id: <20191027144234.8395-32-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191027144234.8395-1-maz@kernel.org>
References: <20191027144234.8395-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the SGI configuration entry point for KVM to use.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v4.c       | 13 +++++++++++++
 include/linux/irqchip/arm-gic-v4.h |  1 +
 2 files changed, 14 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v4.c b/drivers/irqchip/irq-gic-v4.c
index a29a063861bc..b937e51a9178 100644
--- a/drivers/irqchip/irq-gic-v4.c
+++ b/drivers/irqchip/irq-gic-v4.c
@@ -324,6 +324,19 @@ int its_prop_update_vlpi(int irq, u8 config, bool inv)
 	return irq_set_vcpu_affinity(irq, &info);
 }
 
+int its_prop_update_vsgi(int irq, u8 priority, bool group)
+{
+	struct its_cmd_info info = {
+		.cmd_type = PROP_UPDATE_SGI,
+		{
+			.priority	= priority,
+			.group		= group,
+		},
+	};
+
+	return irq_set_vcpu_affinity(irq, &info);
+}
+
 int its_init_v4(struct irq_domain *domain,
 		const struct irq_domain_ops *vpe_ops,
 		const struct irq_domain_ops *sgi_ops)
diff --git a/include/linux/irqchip/arm-gic-v4.h b/include/linux/irqchip/arm-gic-v4.h
index 5578cbe7430b..b894796df9ab 100644
--- a/include/linux/irqchip/arm-gic-v4.h
+++ b/include/linux/irqchip/arm-gic-v4.h
@@ -127,6 +127,7 @@ int its_map_vlpi(int irq, struct its_vlpi_map *map);
 int its_get_vlpi(int irq, struct its_vlpi_map *map);
 int its_unmap_vlpi(int irq);
 int its_prop_update_vlpi(int irq, u8 config, bool inv);
+int its_prop_update_vsgi(int irq, u8 priority, bool group);
 
 struct irq_domain_ops;
 int its_init_v4(struct irq_domain *domain,
-- 
2.20.1

