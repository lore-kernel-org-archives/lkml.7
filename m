Return-Path: <SRS0=+gZy=2O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD7FC2D0CF
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 11:40:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 786132071A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Dec 2019 11:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577187643;
	bh=t9Kl3yZrBArspPDMQoAAKvJlujmxgcm2jC0QHlgJiUU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EinVmzcXqXPHLV0hoeUWKAWz7fMDY2lkf9vXqja/z6w0o8Mp10143X+7xJBUQ4iVE
	 djWtR9DcmUbRLVM3jRscKmcH4R75dS7wed2Z9uPz536Jv5Zxem1uv5PFwY1sSSCemo
	 6Rpgk6AV5qb99NdWsMVVmCtKFiBjkuK82UeOzXao=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbfLXLk3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Dec 2019 06:40:29 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:48198 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726102AbfLXLk2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Dec 2019 06:40:28 -0500
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why.lan)
        by cheepnis.misterjones.org with esmtpsa (TLSv1.2:DHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1iji67-000169-TL; Tue, 24 Dec 2019 12:11:32 +0100
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
        Robert Richter <rrichter@marvell.com>
Subject: [PATCH v3 23/32] irqchip/gic-v4.1: Move doorbell management to the GICv4 abstraction layer
Date:   Tue, 24 Dec 2019 11:10:46 +0000
Message-Id: <20191224111055.11836-24-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191224111055.11836-1-maz@kernel.org>
References: <20191224111055.11836-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org, eric.auger@redhat.com, james.morse@arm.com, julien.thierry.kdev@gmail.com, suzuki.poulose@arm.com, tglx@linutronix.de, jason@lakedaemon.net, lorenzo.pieralisi@arm.com, Andrew.Murray@arm.com, yuzenghui@huawei.com, rrichter@marvell.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to hide some of the differences between v4.0 and v4.1, move
the doorbell management out of the KVM code, and into the GICv4-specific
layer. This allows the calling code to ask for the doorbell when blocking,
and otherwise to leave the doorbell permanently disabled.

This matches the v4.1 code perfectly, and only results in a minor
refactoring of the v4.0 code.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-v4.c       | 45 +++++++++++++++++++++++++++---
 include/kvm/arm_vgic.h             |  1 +
 include/linux/irqchip/arm-gic-v4.h |  3 +-
 virt/kvm/arm/vgic/vgic-v3.c        |  1 +
 virt/kvm/arm/vgic/vgic-v4.c        | 34 ++++++++++------------
 5 files changed, 59 insertions(+), 25 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v4.c b/drivers/irqchip/irq-gic-v4.c
index c01910d53f9e..117ba6db023d 100644
--- a/drivers/irqchip/irq-gic-v4.c
+++ b/drivers/irqchip/irq-gic-v4.c
@@ -87,6 +87,11 @@ static struct irq_domain *gic_domain;
 static const struct irq_domain_ops *vpe_domain_ops;
 static const struct irq_domain_ops *sgi_domain_ops;
 
+static bool has_v4_1(void)
+{
+	return !!sgi_domain_ops;
+}
+
 int its_alloc_vcpu_irqs(struct its_vm *vm)
 {
 	int vpe_base_irq, i;
@@ -139,18 +144,50 @@ static int its_send_vpe_cmd(struct its_vpe *vpe, struct its_cmd_info *info)
 	return irq_set_vcpu_affinity(vpe->irq, info);
 }
 
-int its_schedule_vpe(struct its_vpe *vpe, bool on)
+int its_make_vpe_non_resident(struct its_vpe *vpe, bool db)
 {
-	struct its_cmd_info info;
+	struct irq_desc *desc = irq_to_desc(vpe->irq);
+	struct its_cmd_info info = { };
 	int ret;
 
 	WARN_ON(preemptible());
 
-	info.cmd_type = on ? SCHEDULE_VPE : DESCHEDULE_VPE;
+	info.cmd_type = DESCHEDULE_VPE;
+	if (has_v4_1()) {
+		/* GICv4.1 can directly deal with doorbells */
+		info.req_db = db;
+	} else {
+		/* Undo the nested disable_irq() calls... */
+		while (db && irqd_irq_disabled(&desc->irq_data))
+			enable_irq(vpe->irq);
+	}
+
+	ret = its_send_vpe_cmd(vpe, &info);
+	if (!ret)
+		vpe->resident = false;
+
+	return ret;
+}
+
+int its_make_vpe_resident(struct its_vpe *vpe, bool g0en, bool g1en)
+{
+	struct its_cmd_info info = { };
+	int ret;
+
+	WARN_ON(preemptible());
+
+	info.cmd_type = SCHEDULE_VPE;
+	if (has_v4_1()) {
+		info.g0en = g0en;
+		info.g1en = g1en;
+	} else {
+		/* Disabled the doorbell, as we're about to enter the guest */
+		disable_irq_nosync(vpe->irq);
+	}
 
 	ret = its_send_vpe_cmd(vpe, &info);
 	if (!ret)
-		vpe->resident = on;
+		vpe->resident = true;
 
 	return ret;
 }
diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
index 9d53f545a3d5..63457908c9c4 100644
--- a/include/kvm/arm_vgic.h
+++ b/include/kvm/arm_vgic.h
@@ -70,6 +70,7 @@ struct vgic_global {
 
 	/* Hardware has GICv4? */
 	bool			has_gicv4;
+	bool			has_gicv4_1;
 
 	/* GIC system register CPU interface */
 	struct static_key_false gicv3_cpuif;
diff --git a/include/linux/irqchip/arm-gic-v4.h b/include/linux/irqchip/arm-gic-v4.h
index a1a9d40266f5..cca4198fa1d5 100644
--- a/include/linux/irqchip/arm-gic-v4.h
+++ b/include/linux/irqchip/arm-gic-v4.h
@@ -120,7 +120,8 @@ struct its_cmd_info {
 
 int its_alloc_vcpu_irqs(struct its_vm *vm);
 void its_free_vcpu_irqs(struct its_vm *vm);
-int its_schedule_vpe(struct its_vpe *vpe, bool on);
+int its_make_vpe_resident(struct its_vpe *vpe, bool g0en, bool g1en);
+int its_make_vpe_non_resident(struct its_vpe *vpe, bool db);
 int its_invall_vpe(struct its_vpe *vpe);
 int its_map_vlpi(int irq, struct its_vlpi_map *map);
 int its_get_vlpi(int irq, struct its_vlpi_map *map);
diff --git a/virt/kvm/arm/vgic/vgic-v3.c b/virt/kvm/arm/vgic/vgic-v3.c
index f45635a6f0ec..c2fdea201747 100644
--- a/virt/kvm/arm/vgic/vgic-v3.c
+++ b/virt/kvm/arm/vgic/vgic-v3.c
@@ -595,6 +595,7 @@ int vgic_v3_probe(const struct gic_kvm_info *info)
 	/* GICv4 support? */
 	if (info->has_v4) {
 		kvm_vgic_global_state.has_gicv4 = gicv4_enable;
+		kvm_vgic_global_state.has_gicv4_1 = info->has_v4_1;
 		kvm_info("GICv4 support %sabled\n",
 			 gicv4_enable ? "en" : "dis");
 	}
diff --git a/virt/kvm/arm/vgic/vgic-v4.c b/virt/kvm/arm/vgic/vgic-v4.c
index 46f875589c47..1eb0f8c76219 100644
--- a/virt/kvm/arm/vgic/vgic-v4.c
+++ b/virt/kvm/arm/vgic/vgic-v4.c
@@ -67,10 +67,10 @@
  * it. And if we've migrated our vcpu from one CPU to another, we must
  * tell the ITS (so that the messages reach the right redistributor).
  * This is done in two steps: first issue a irq_set_affinity() on the
- * irq corresponding to the vcpu, then call its_schedule_vpe(). You
- * must be in a non-preemptible context. On exit, another call to
- * its_schedule_vpe() tells the redistributor that we're done with the
- * vcpu.
+ * irq corresponding to the vcpu, then call its_make_vpe_resident().
+ * You must be in a non-preemptible context. On exit, a call to
+ * its_make_vpe_non_resident() tells the redistributor that we're done
+ * with the vcpu.
  *
  * Finally, the doorbell handling: Each vcpu is allocated an interrupt
  * which will fire each time a VLPI is made pending whilst the vcpu is
@@ -86,7 +86,8 @@ static irqreturn_t vgic_v4_doorbell_handler(int irq, void *info)
 	struct kvm_vcpu *vcpu = info;
 
 	/* We got the message, no need to fire again */
-	if (!irqd_irq_disabled(&irq_to_desc(irq)->irq_data))
+	if (!kvm_vgic_global_state.has_gicv4_1 &&
+	    !irqd_irq_disabled(&irq_to_desc(irq)->irq_data))
 		disable_irq_nosync(irq);
 
 	vcpu->arch.vgic_cpu.vgic_v3.its_vpe.pending_last = true;
@@ -199,19 +200,11 @@ void vgic_v4_teardown(struct kvm *kvm)
 int vgic_v4_put(struct kvm_vcpu *vcpu, bool need_db)
 {
 	struct its_vpe *vpe = &vcpu->arch.vgic_cpu.vgic_v3.its_vpe;
-	struct irq_desc *desc = irq_to_desc(vpe->irq);
 
 	if (!vgic_supports_direct_msis(vcpu->kvm) || !vpe->resident)
 		return 0;
 
-	/*
-	 * If blocking, a doorbell is required. Undo the nested
-	 * disable_irq() calls...
-	 */
-	while (need_db && irqd_irq_disabled(&desc->irq_data))
-		enable_irq(vpe->irq);
-
-	return its_schedule_vpe(vpe, false);
+	return its_make_vpe_non_resident(vpe, need_db);
 }
 
 int vgic_v4_load(struct kvm_vcpu *vcpu)
@@ -232,18 +225,19 @@ int vgic_v4_load(struct kvm_vcpu *vcpu)
 	if (err)
 		return err;
 
-	/* Disabled the doorbell, as we're about to enter the guest */
-	disable_irq_nosync(vpe->irq);
-
-	err = its_schedule_vpe(vpe, true);
+	err = its_make_vpe_resident(vpe, false, vcpu->kvm->arch.vgic.enabled);
 	if (err)
 		return err;
 
 	/*
 	 * Now that the VPE is resident, let's get rid of a potential
-	 * doorbell interrupt that would still be pending.
+	 * doorbell interrupt that would still be pending. This is a
+	 * GICv4.0 only "feature"...
 	 */
-	return irq_set_irqchip_state(vpe->irq, IRQCHIP_STATE_PENDING, false);
+	if (!kvm_vgic_global_state.has_gicv4_1)
+		err = irq_set_irqchip_state(vpe->irq, IRQCHIP_STATE_PENDING, false);
+
+	return err;
 }
 
 static struct vgic_its *vgic_get_its(struct kvm *kvm,
-- 
2.20.1

