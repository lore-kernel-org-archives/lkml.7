Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C42FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:57:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E457F2087C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552334237;
	bh=XukdhBXvSJy8wHNVKBvdDe00YoJD4Ilq8W0JUFG4GcE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=m30akcez/p4L3iaEvW6VXtBfPoVGFKJ3WSl0mIoO6f/QhQs9TdT+41Wt+f3SSfILL
	 WXUqmtR0SxvWsJ9l9rEK/U5P1qSQP9AhZJgzPEB1NpB2dq41SoXinXomSmkun/NdSz
	 QtnIPkQzPwJVoVzbkKN95q8V3PAqsohcxCaEDoio=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729005AbfCKT5P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 15:57:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:34650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728243AbfCKT5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 15:57:13 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1470F214AE;
        Mon, 11 Mar 2019 19:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552334232;
        bh=XukdhBXvSJy8wHNVKBvdDe00YoJD4Ilq8W0JUFG4GcE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DA2s2aWKoQiBh43zgh0iD6i+LRlq2lMNy/CXTTqd+nzemAPhpUoog/n0nZe7MJEb7
         sytOlCIcLHx+m84Mk+PiBorx4MlAqH+VREESwkkXcPrslXFZY5k4nAfqOPzy7dDBwA
         vaWZY3wcO/vgcfxG5bKzSvvuvBa7Labb40g71HDM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Julien Thierry <julien.thierry@arm.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Sasha Levin <sashal@kernel.org>, kvmarm@lists.cs.columbia.edu
Subject: [PATCH AUTOSEL 4.19 07/44] KVM: arm/arm64: vgic: Make vgic_dist->lpi_list_lock a raw_spinlock
Date:   Mon, 11 Mar 2019 15:56:23 -0400
Message-Id: <20190311195700.138462-7-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190311195700.138462-1-sashal@kernel.org>
References: <20190311195700.138462-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julien Thierry <julien.thierry@arm.com>

[ Upstream commit fc3bc475231e12e9c0142f60100cf84d077c79e1 ]

vgic_dist->lpi_list_lock must always be taken with interrupts disabled as
it is used in interrupt context.

For configurations such as PREEMPT_RT_FULL, this means that it should
be a raw_spinlock since RT spinlocks are interruptible.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Acked-by: Christoffer Dall <christoffer.dall@arm.com>
Acked-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/kvm/arm_vgic.h        |  2 +-
 virt/kvm/arm/vgic/vgic-init.c |  2 +-
 virt/kvm/arm/vgic/vgic-its.c  |  8 ++++----
 virt/kvm/arm/vgic/vgic.c      | 10 +++++-----
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/kvm/arm_vgic.h b/include/kvm/arm_vgic.h
index 4f31f96bbfab..90ac450745f1 100644
--- a/include/kvm/arm_vgic.h
+++ b/include/kvm/arm_vgic.h
@@ -256,7 +256,7 @@ struct vgic_dist {
 	u64			propbaser;
 
 	/* Protects the lpi_list and the count value below. */
-	spinlock_t		lpi_list_lock;
+	raw_spinlock_t		lpi_list_lock;
 	struct list_head	lpi_list_head;
 	int			lpi_list_count;
 
diff --git a/virt/kvm/arm/vgic/vgic-init.c b/virt/kvm/arm/vgic/vgic-init.c
index c0c0b88af1d5..33e7ee814f7b 100644
--- a/virt/kvm/arm/vgic/vgic-init.c
+++ b/virt/kvm/arm/vgic/vgic-init.c
@@ -64,7 +64,7 @@ void kvm_vgic_early_init(struct kvm *kvm)
 	struct vgic_dist *dist = &kvm->arch.vgic;
 
 	INIT_LIST_HEAD(&dist->lpi_list_head);
-	spin_lock_init(&dist->lpi_list_lock);
+	raw_spin_lock_init(&dist->lpi_list_lock);
 }
 
 /* CREATION */
diff --git a/virt/kvm/arm/vgic/vgic-its.c b/virt/kvm/arm/vgic/vgic-its.c
index 12502251727e..f376c82afb61 100644
--- a/virt/kvm/arm/vgic/vgic-its.c
+++ b/virt/kvm/arm/vgic/vgic-its.c
@@ -73,7 +73,7 @@ static struct vgic_irq *vgic_add_lpi(struct kvm *kvm, u32 intid,
 	irq->target_vcpu = vcpu;
 	irq->group = 1;
 
-	spin_lock_irqsave(&dist->lpi_list_lock, flags);
+	raw_spin_lock_irqsave(&dist->lpi_list_lock, flags);
 
 	/*
 	 * There could be a race with another vgic_add_lpi(), so we need to
@@ -101,7 +101,7 @@ static struct vgic_irq *vgic_add_lpi(struct kvm *kvm, u32 intid,
 	dist->lpi_list_count++;
 
 out_unlock:
-	spin_unlock_irqrestore(&dist->lpi_list_lock, flags);
+	raw_spin_unlock_irqrestore(&dist->lpi_list_lock, flags);
 
 	/*
 	 * We "cache" the configuration table entries in our struct vgic_irq's.
@@ -339,7 +339,7 @@ int vgic_copy_lpi_list(struct kvm *kvm, struct kvm_vcpu *vcpu, u32 **intid_ptr)
 	if (!intids)
 		return -ENOMEM;
 
-	spin_lock_irqsave(&dist->lpi_list_lock, flags);
+	raw_spin_lock_irqsave(&dist->lpi_list_lock, flags);
 	list_for_each_entry(irq, &dist->lpi_list_head, lpi_list) {
 		if (i == irq_count)
 			break;
@@ -348,7 +348,7 @@ int vgic_copy_lpi_list(struct kvm *kvm, struct kvm_vcpu *vcpu, u32 **intid_ptr)
 			continue;
 		intids[i++] = irq->intid;
 	}
-	spin_unlock_irqrestore(&dist->lpi_list_lock, flags);
+	raw_spin_unlock_irqrestore(&dist->lpi_list_lock, flags);
 
 	*intid_ptr = intids;
 	return i;
diff --git a/virt/kvm/arm/vgic/vgic.c b/virt/kvm/arm/vgic/vgic.c
index f884a54b2601..c5165e3b80cb 100644
--- a/virt/kvm/arm/vgic/vgic.c
+++ b/virt/kvm/arm/vgic/vgic.c
@@ -72,7 +72,7 @@ static struct vgic_irq *vgic_get_lpi(struct kvm *kvm, u32 intid)
 	struct vgic_irq *irq = NULL;
 	unsigned long flags;
 
-	spin_lock_irqsave(&dist->lpi_list_lock, flags);
+	raw_spin_lock_irqsave(&dist->lpi_list_lock, flags);
 
 	list_for_each_entry(irq, &dist->lpi_list_head, lpi_list) {
 		if (irq->intid != intid)
@@ -88,7 +88,7 @@ static struct vgic_irq *vgic_get_lpi(struct kvm *kvm, u32 intid)
 	irq = NULL;
 
 out_unlock:
-	spin_unlock_irqrestore(&dist->lpi_list_lock, flags);
+	raw_spin_unlock_irqrestore(&dist->lpi_list_lock, flags);
 
 	return irq;
 }
@@ -138,15 +138,15 @@ void vgic_put_irq(struct kvm *kvm, struct vgic_irq *irq)
 	if (irq->intid < VGIC_MIN_LPI)
 		return;
 
-	spin_lock_irqsave(&dist->lpi_list_lock, flags);
+	raw_spin_lock_irqsave(&dist->lpi_list_lock, flags);
 	if (!kref_put(&irq->refcount, vgic_irq_release)) {
-		spin_unlock_irqrestore(&dist->lpi_list_lock, flags);
+		raw_spin_unlock_irqrestore(&dist->lpi_list_lock, flags);
 		return;
 	};
 
 	list_del(&irq->lpi_list);
 	dist->lpi_list_count--;
-	spin_unlock_irqrestore(&dist->lpi_list_lock, flags);
+	raw_spin_unlock_irqrestore(&dist->lpi_list_lock, flags);
 
 	kfree(irq);
 }
-- 
2.19.1

