Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8827EC4332F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63A0020693
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 12:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567947235;
	bh=x/AUzuA/QiQehPBLz5MlYb30zRSR4H9iv1XIP52Nig4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xbXnvYNeCz4oJPJU0aagbt7eE1HmAg6Htrl/loaeLL5hM/33zMLDZGkScoYpGTQCk
	 4rnu2195haEd4jacsH9LAKNiWi+O8xRcB08EOTsJWLxoCzFLouWIsEwgrAX/lQ5acA
	 +OMKkTXsdMQyTJQUNpo+US9ALEADrGRM7s7UbUZ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732476AbfIHMxA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 08:53:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:45558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733230AbfIHMw4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 08:52:56 -0400
Received: from localhost (unknown [62.28.240.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2663218AC;
        Sun,  8 Sep 2019 12:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567947175;
        bh=x/AUzuA/QiQehPBLz5MlYb30zRSR4H9iv1XIP52Nig4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=itZpuzHi6Ydm9E30VPyfpcupoMDdNxEuEhODXePL2f4hAsqeJH+oDiLenDRokpLTw
         /y1lW8i6IgFv7SLxoIKOGVgS8kOywDCe1lNSIBTKlxt75YRzYbbxjBGMQGs0tQzAum
         vyYnVTVanj+G4fvjcAU8bRSpGaVl1BqvAJKfeRVs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>,
        Dave Martin <dave.martin@arm.com>,
        Julien Grall <julien.grall@arm.com>,
        Marc Zyngier <maz@kernel.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.2 89/94] KVM: arm/arm64: VGIC: Properly initialise private IRQ affinity
Date:   Sun,  8 Sep 2019 13:42:25 +0100
Message-Id: <20190908121152.978390753@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190908121150.420989666@linuxfoundation.org>
References: <20190908121150.420989666@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 2e16f3e926ed48373c98edea85c6ad0ef69425d1 ]

At the moment we initialise the target *mask* of a virtual IRQ to the
VCPU it belongs to, even though this mask is only defined for GICv2 and
quickly runs out of bits for many GICv3 guests.
This behaviour triggers an UBSAN complaint for more than 32 VCPUs:
------
[ 5659.462377] UBSAN: Undefined behaviour in virt/kvm/arm/vgic/vgic-init.c:223:21
[ 5659.471689] shift exponent 32 is too large for 32-bit type 'unsigned int'
------
Also for GICv3 guests the reporting of TARGET in the "vgic-state" debugfs
dump is wrong, due to this very same problem.

Because there is no requirement to create the VGIC device before the
VCPUs (and QEMU actually does it the other way round), we can't safely
initialise mpidr or targets in kvm_vgic_vcpu_init(). But since we touch
every private IRQ for each VCPU anyway later (in vgic_init()), we can
just move the initialisation of those fields into there, where we
definitely know the VGIC type.

On the way make sure we really have either a VGICv2 or a VGICv3 device,
since the existing code is just checking for "VGICv3 or not", silently
ignoring the uninitialised case.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
Reported-by: Dave Martin <dave.martin@arm.com>
Tested-by: Julien Grall <julien.grall@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 virt/kvm/arm/vgic/vgic-init.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/virt/kvm/arm/vgic/vgic-init.c b/virt/kvm/arm/vgic/vgic-init.c
index bdbc297d06fb4..e621b5d45b278 100644
--- a/virt/kvm/arm/vgic/vgic-init.c
+++ b/virt/kvm/arm/vgic/vgic-init.c
@@ -8,6 +8,7 @@
 #include <linux/cpu.h>
 #include <linux/kvm_host.h>
 #include <kvm/arm_vgic.h>
+#include <asm/kvm_emulate.h>
 #include <asm/kvm_mmu.h>
 #include "vgic.h"
 
@@ -164,12 +165,18 @@ static int kvm_vgic_dist_init(struct kvm *kvm, unsigned int nr_spis)
 		irq->vcpu = NULL;
 		irq->target_vcpu = vcpu0;
 		kref_init(&irq->refcount);
-		if (dist->vgic_model == KVM_DEV_TYPE_ARM_VGIC_V2) {
+		switch (dist->vgic_model) {
+		case KVM_DEV_TYPE_ARM_VGIC_V2:
 			irq->targets = 0;
 			irq->group = 0;
-		} else {
+			break;
+		case KVM_DEV_TYPE_ARM_VGIC_V3:
 			irq->mpidr = 0;
 			irq->group = 1;
+			break;
+		default:
+			kfree(dist->spis);
+			return -EINVAL;
 		}
 	}
 	return 0;
@@ -209,7 +216,6 @@ int kvm_vgic_vcpu_init(struct kvm_vcpu *vcpu)
 		irq->intid = i;
 		irq->vcpu = NULL;
 		irq->target_vcpu = vcpu;
-		irq->targets = 1U << vcpu->vcpu_id;
 		kref_init(&irq->refcount);
 		if (vgic_irq_is_sgi(i)) {
 			/* SGIs */
@@ -219,11 +225,6 @@ int kvm_vgic_vcpu_init(struct kvm_vcpu *vcpu)
 			/* PPIs */
 			irq->config = VGIC_CONFIG_LEVEL;
 		}
-
-		if (dist->vgic_model == KVM_DEV_TYPE_ARM_VGIC_V3)
-			irq->group = 1;
-		else
-			irq->group = 0;
 	}
 
 	if (!irqchip_in_kernel(vcpu->kvm))
@@ -286,10 +287,19 @@ int vgic_init(struct kvm *kvm)
 
 		for (i = 0; i < VGIC_NR_PRIVATE_IRQS; i++) {
 			struct vgic_irq *irq = &vgic_cpu->private_irqs[i];
-			if (dist->vgic_model == KVM_DEV_TYPE_ARM_VGIC_V3)
+			switch (dist->vgic_model) {
+			case KVM_DEV_TYPE_ARM_VGIC_V3:
 				irq->group = 1;
-			else
+				irq->mpidr = kvm_vcpu_get_mpidr_aff(vcpu);
+				break;
+			case KVM_DEV_TYPE_ARM_VGIC_V2:
 				irq->group = 0;
+				irq->targets = 1U << idx;
+				break;
+			default:
+				ret = -EINVAL;
+				goto out;
+			}
 		}
 	}
 
-- 
2.20.1



