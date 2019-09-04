Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B623EC3A5A8
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:08:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D8A42087E
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 18:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567620537;
	bh=JEiG6Dy27j7ZODpzmrYkgxRrMO3t6AHP83ZMOOZ8TH4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OVnn05Arofcoh4ZKZ3pZOV9YWC+Wu1AiaQhPQg3CmcqXrbWeJxGw20G//IFyq+Yey
	 C6CJvLe+sSAqkxHc4pjVuxXgL9y/XZiTr6RykRIk9E9KWQTpPn3SQw+V7tTiGA7pWh
	 KbFyjjiaHO9TFI/ab97a3zVHUQGt9tAnNdpDnhHw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731971AbfIDSI4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 14:08:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:51876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389864AbfIDSIw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 14:08:52 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DD50C206B8;
        Wed,  4 Sep 2019 18:08:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567620531;
        bh=JEiG6Dy27j7ZODpzmrYkgxRrMO3t6AHP83ZMOOZ8TH4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xn3NcSd2oDHauucnabC/byQbxonYebZiHMVTVZZU4WZHb2Nl6v0V0j2RostSW8YyG
         wXoJg4w40BUMKiPrDuHN+Uq3Jg8gKYXpftJKx5B4b4emC6qDNJqeghta6mY6dzsNSn
         oA8lTOzCwNnhCMDpnsE8YPpH4YjQO/yh4D5OI/o0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 86/93] KVM: arm/arm64: vgic-v2: Handle SGI bits in GICD_I{S,C}PENDR0 as WI
Date:   Wed,  4 Sep 2019 19:54:28 +0200
Message-Id: <20190904175310.545595742@linuxfoundation.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190904175302.845828956@linuxfoundation.org>
References: <20190904175302.845828956@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 82e40f558de566fdee214bec68096bbd5e64a6a4 ]

A guest is not allowed to inject a SGI (or clear its pending state)
by writing to GICD_ISPENDR0 (resp. GICD_ICPENDR0), as these bits are
defined as WI (as per ARM IHI 0048B 4.3.7 and 4.3.8).

Make sure we correctly emulate the architecture.

Fixes: 96b298000db4 ("KVM: arm/arm64: vgic-new: Add PENDING registers handlers")
Cc: stable@vger.kernel.org # 4.7+
Reported-by: Andre Przywara <andre.przywara@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 virt/kvm/arm/vgic/vgic-mmio.c | 18 ++++++++++++++++++
 virt/kvm/arm/vgic/vgic-v2.c   |  5 ++++-
 virt/kvm/arm/vgic/vgic-v3.c   |  5 ++++-
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/arm/vgic/vgic-mmio.c b/virt/kvm/arm/vgic/vgic-mmio.c
index ceeda7e04a4d9..762f81900529e 100644
--- a/virt/kvm/arm/vgic/vgic-mmio.c
+++ b/virt/kvm/arm/vgic/vgic-mmio.c
@@ -203,6 +203,12 @@ static void vgic_hw_irq_spending(struct kvm_vcpu *vcpu, struct vgic_irq *irq,
 	vgic_irq_set_phys_active(irq, true);
 }
 
+static bool is_vgic_v2_sgi(struct kvm_vcpu *vcpu, struct vgic_irq *irq)
+{
+	return (vgic_irq_is_sgi(irq->intid) &&
+		vcpu->kvm->arch.vgic.vgic_model == KVM_DEV_TYPE_ARM_VGIC_V2);
+}
+
 void vgic_mmio_write_spending(struct kvm_vcpu *vcpu,
 			      gpa_t addr, unsigned int len,
 			      unsigned long val)
@@ -215,6 +221,12 @@ void vgic_mmio_write_spending(struct kvm_vcpu *vcpu,
 	for_each_set_bit(i, &val, len * 8) {
 		struct vgic_irq *irq = vgic_get_irq(vcpu->kvm, vcpu, intid + i);
 
+		/* GICD_ISPENDR0 SGI bits are WI */
+		if (is_vgic_v2_sgi(vcpu, irq)) {
+			vgic_put_irq(vcpu->kvm, irq);
+			continue;
+		}
+
 		spin_lock_irqsave(&irq->irq_lock, flags);
 		if (irq->hw)
 			vgic_hw_irq_spending(vcpu, irq, is_uaccess);
@@ -262,6 +274,12 @@ void vgic_mmio_write_cpending(struct kvm_vcpu *vcpu,
 	for_each_set_bit(i, &val, len * 8) {
 		struct vgic_irq *irq = vgic_get_irq(vcpu->kvm, vcpu, intid + i);
 
+		/* GICD_ICPENDR0 SGI bits are WI */
+		if (is_vgic_v2_sgi(vcpu, irq)) {
+			vgic_put_irq(vcpu->kvm, irq);
+			continue;
+		}
+
 		spin_lock_irqsave(&irq->irq_lock, flags);
 
 		if (irq->hw)
diff --git a/virt/kvm/arm/vgic/vgic-v2.c b/virt/kvm/arm/vgic/vgic-v2.c
index 57281c1594d0f..91b14dfacd1dd 100644
--- a/virt/kvm/arm/vgic/vgic-v2.c
+++ b/virt/kvm/arm/vgic/vgic-v2.c
@@ -195,7 +195,10 @@ void vgic_v2_populate_lr(struct kvm_vcpu *vcpu, struct vgic_irq *irq, int lr)
 		if (vgic_irq_is_sgi(irq->intid)) {
 			u32 src = ffs(irq->source);
 
-			BUG_ON(!src);
+			if (WARN_RATELIMIT(!src, "No SGI source for INTID %d\n",
+					   irq->intid))
+				return;
+
 			val |= (src - 1) << GICH_LR_PHYSID_CPUID_SHIFT;
 			irq->source &= ~(1 << (src - 1));
 			if (irq->source) {
diff --git a/virt/kvm/arm/vgic/vgic-v3.c b/virt/kvm/arm/vgic/vgic-v3.c
index 5c55995a1a164..8b958ed05306e 100644
--- a/virt/kvm/arm/vgic/vgic-v3.c
+++ b/virt/kvm/arm/vgic/vgic-v3.c
@@ -179,7 +179,10 @@ void vgic_v3_populate_lr(struct kvm_vcpu *vcpu, struct vgic_irq *irq, int lr)
 		    model == KVM_DEV_TYPE_ARM_VGIC_V2) {
 			u32 src = ffs(irq->source);
 
-			BUG_ON(!src);
+			if (WARN_RATELIMIT(!src, "No SGI source for INTID %d\n",
+					   irq->intid))
+				return;
+
 			val |= (src - 1) << GICH_LR_PHYSID_CPUID_SHIFT;
 			irq->source &= ~(1 << (src - 1));
 			if (irq->source) {
-- 
2.20.1



