Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19798C4CECF
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 18:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3AEC20B7C
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 18:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569263315;
	bh=rT1g/raMHC8EmgZx/1zwUJDNQKU4ZVLYts5C3N9/83M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=GnjE/NAyWQHSIfdk2t2aRhHFZurP5yyR5cDmPo4Gy2TD4J5FwsVKfdDBdr5+v+LHJ
	 YD1IjANkhHQVgGTVNTIGX40+6BeYFz4BXQC9mgziCH+pQsObPUNKWDyEvkW4Z/QvQm
	 HHoNNedmRv1vU+sTQt1rKq6uyVRTA1An3g3otp3Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733094AbfIWS2e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 14:28:34 -0400
Received: from foss.arm.com ([217.140.110.172]:47282 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733081AbfIWS2c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 14:28:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ECBC12D97;
        Mon, 23 Sep 2019 11:28:31 -0700 (PDT)
Received: from big-swifty.lan (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4139A3F694;
        Mon, 23 Sep 2019 11:28:28 -0700 (PDT)
From:   Marc Zyngier <maz@kernel.org>
To:     kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
Cc:     Eric Auger <eric.auger@redhat.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <Andrew.Murray@arm.com>
Subject: [PATCH 34/35] KVM: arm64: GICv4.1: Configure SGIs as HW interrupts
Date:   Mon, 23 Sep 2019 19:26:05 +0100
Message-Id: <20190923182606.32100-35-maz@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190923182606.32100-1-maz@kernel.org>
References: <20190923182606.32100-1-maz@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To enable HW delivery of SGIs, set their hw flag to true, link them
to the corresponding Linux interrupt, which is then activated.

This configures the SGIs at the ITS level, and put the show
on the road!

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 virt/kvm/arm/vgic/vgic-v4.c | 42 +++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/virt/kvm/arm/vgic/vgic-v4.c b/virt/kvm/arm/vgic/vgic-v4.c
index e61c7a149515..0ff6dac16cba 100644
--- a/virt/kvm/arm/vgic/vgic-v4.c
+++ b/virt/kvm/arm/vgic/vgic-v4.c
@@ -97,6 +97,46 @@ static irqreturn_t vgic_v4_doorbell_handler(int irq, void *info)
 	return IRQ_HANDLED;
 }
 
+static void vgic_v4_sync_sgi_config(struct its_vpe *vpe, struct vgic_irq *irq)
+{
+	vpe->sgi_config[irq->intid].enabled	= irq->enabled;
+	vpe->sgi_config[irq->intid].group 	= irq->group;
+	vpe->sgi_config[irq->intid].priority	= irq->priority;
+}
+
+static void vgic_v4_init_vsgis(struct kvm_vcpu *vcpu)
+{
+	struct its_vpe *vpe = &vcpu->arch.vgic_cpu.vgic_v3.its_vpe;
+	int i;
+
+	if (!kvm_vgic_global_state.has_gicv4_1)
+		return;
+
+	/*
+	 * With GICv4.1, every virtual SGI can be directly injected. So
+	 * let's pretend that they are HW interrupts, tied to a host
+	 * IRQ. The SGI code will do its magic.
+	 */
+	for (i = 0; i < VGIC_NR_SGIS; i++) {
+		struct vgic_irq *irq = vgic_get_irq(vcpu->kvm, vcpu, i);
+		struct irq_desc *desc;
+		int ret;
+
+		irq->hw = true;
+		irq->host_irq = irq_find_mapping(vpe->sgi_domain, i);
+		vgic_v4_sync_sgi_config(vpe, irq);
+		/*
+		 * SGIs are initialised as disabled. Enable them if
+		 * required by the rest of the VGIC init code.
+		 */
+		desc = irq_to_desc(irq->host_irq);
+		ret = irq_domain_activate_irq(irq_desc_get_irq_data(desc),
+					      false);
+		WARN_ON(ret);
+		vgic_put_irq(vcpu->kvm, irq);
+	}
+}
+
 /**
  * vgic_v4_init - Initialize the GICv4 data structures
  * @kvm:	Pointer to the VM being initialized
@@ -168,6 +208,8 @@ int vgic_v4_init(struct kvm *kvm)
 			dist->its_vm.nr_vpes = i;
 			break;
 		}
+
+		vgic_v4_init_vsgis(vcpu);
 	}
 
 	if (ret)
-- 
2.20.1

