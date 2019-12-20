Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C77FDC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 21:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87CB120866
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 21:02:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ObFZ3YrL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727652AbfLTVCI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 16:02:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55993 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727599AbfLTVCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 16:02:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576875724;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xw6vxNv2Dzp8BiJgba6J6ltllpBfM6qD76X6Uw0YGI0=;
        b=ObFZ3YrLDj1zScZwxXxxBSRwlw4GyWFWwC1EGx+qBSCjE4UH/zteZ5/oBou17IHMvzn2pP
        hipavgjsdqqJUrjth/8EL7d97GXMsd6UmgBAmPtZ9qhjZOnPKe865BFAru0NAK8gwBXSwh
        s1JaxR7aMdcXciyfLEP+MxaRwXf7Jm8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-Mw5YUpALM664R26vZ9MsYg-1; Fri, 20 Dec 2019 16:02:01 -0500
X-MC-Unique: Mw5YUpALM664R26vZ9MsYg-1
Received: by mail-qv1-f69.google.com with SMTP id k2so6687354qvu.22
        for <linux-kernel@vger.kernel.org>; Fri, 20 Dec 2019 13:02:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xw6vxNv2Dzp8BiJgba6J6ltllpBfM6qD76X6Uw0YGI0=;
        b=PgWVITadVCZaNZDjTbsQ1kpm2wDb3jKwWSf2xqcLPCQQech5tV0cLcROJRYXhaHP55
         ZHXJ0nzEal9D6w/AH64oHSvlTy72A+dOMwvfUcMgHdfD8fL7CdKhFq8TO4ebTna1WyXv
         8lvE85UX6TpdKP0321GL/Wtux1CV2240WpA1EOYau1kA48v8SJkDqSQfKnOXlSvWZyt8
         noZST8Fy24jkKo9IH8JSvCF69riYJZK98wnY583okGYOYyfvTN5iDoDJa7qMeb5wP2Wa
         KodtjMCXrNuKO7GUoqVEUfEWdW3VA98rPPZtwbdB2uKjSxNXGVE3NZic6/WW06aD3wkD
         Q/uQ==
X-Gm-Message-State: APjAAAXDMpaC5UZV7WHR8xbhdgZLwXw4ZnXu8DvxmfqLlu5Ff3riEyCd
        JT6EhdvGrcSkaUyKGkQby0101xRgvwNIRPmS8RGUOGIFujgP9/h0cDOqH7EgVyTLvtbgfTxHRYI
        k7yS+l1V5BdmyP+RjcCJtezBV
X-Received: by 2002:ac8:541a:: with SMTP id b26mr13788177qtq.276.1576875721033;
        Fri, 20 Dec 2019 13:02:01 -0800 (PST)
X-Google-Smtp-Source: APXvYqzT5oWo6p+6Ll1ByC/kV6xa+HbcTKEqscWADuYQ4gGZR1CWopyTrBlWNXSJHOEDZdLf5lzecQ==
X-Received: by 2002:ac8:541a:: with SMTP id b26mr13788131qtq.276.1576875720685;
        Fri, 20 Dec 2019 13:02:00 -0800 (PST)
Received: from xz-x1.redhat.com ([104.156.64.74])
        by smtp.gmail.com with ESMTPSA id q25sm3243836qkq.88.2019.12.20.13.01.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2019 13:01:59 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jason Wang <jasowang@redhat.com>, peterx@redhat.com,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Christophe de Dinechin <dinechin@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>
Subject: [PATCH v2 07/17] KVM: Move running VCPU from ARM to common code
Date:   Fri, 20 Dec 2019 16:01:37 -0500
Message-Id: <20191220210147.49617-8-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191220210147.49617-1-peterx@redhat.com>
References: <20191220210147.49617-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo Bonzini <pbonzini@redhat.com>

For ring-based dirty log tracking, it will be more efficient to account
writes during schedule-out or schedule-in to the currently running VCPU.
We would like to do it even if the write doesn't use the current VCPU's
address space, as is the case for cached writes (see commit 4e335d9e7ddb,
"Revert "KVM: Support vCPU-based gfn->hva cache"", 2017-05-02).

Therefore, add a mechanism to track the currently-loaded kvm_vcpu struct.
There is already something similar in KVM/ARM; one important difference
is that kvm_arch_vcpu_{load,put} have two callers in virt/kvm/kvm_main.c:
we have to update both the architecture-independent vcpu_{load,put} and
the preempt notifiers.

Another change made in the process is to allow using kvm_get_running_vcpu()
in preemptible code.  This is allowed because preempt notifiers ensure
that the value does not change even after the VCPU thread is migrated.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/arm/include/asm/kvm_host.h   |  2 --
 arch/arm64/include/asm/kvm_host.h |  2 --
 include/linux/kvm_host.h          |  3 +++
 virt/kvm/arm/arch_timer.c         |  2 +-
 virt/kvm/arm/arm.c                | 29 -----------------------------
 virt/kvm/arm/perf.c               |  6 +++---
 virt/kvm/arm/vgic/vgic-mmio.c     | 15 +++------------
 virt/kvm/kvm_main.c               | 25 ++++++++++++++++++++++++-
 8 files changed, 34 insertions(+), 50 deletions(-)

diff --git a/arch/arm/include/asm/kvm_host.h b/arch/arm/include/asm/kvm_host.h
index 8a37c8e89777..40eff9cc3744 100644
--- a/arch/arm/include/asm/kvm_host.h
+++ b/arch/arm/include/asm/kvm_host.h
@@ -274,8 +274,6 @@ int kvm_arm_copy_reg_indices(struct kvm_vcpu *vcpu, u64 __user *indices);
 int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end);
 int kvm_test_age_hva(struct kvm *kvm, unsigned long hva);
 
-struct kvm_vcpu *kvm_arm_get_running_vcpu(void);
-struct kvm_vcpu __percpu **kvm_get_running_vcpus(void);
 void kvm_arm_halt_guest(struct kvm *kvm);
 void kvm_arm_resume_guest(struct kvm *kvm);
 
diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index f656169db8c3..df8d72f7c20e 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -430,8 +430,6 @@ int kvm_set_spte_hva(struct kvm *kvm, unsigned long hva, pte_t pte);
 int kvm_age_hva(struct kvm *kvm, unsigned long start, unsigned long end);
 int kvm_test_age_hva(struct kvm *kvm, unsigned long hva);
 
-struct kvm_vcpu *kvm_arm_get_running_vcpu(void);
-struct kvm_vcpu * __percpu *kvm_get_running_vcpus(void);
 void kvm_arm_halt_guest(struct kvm *kvm);
 void kvm_arm_resume_guest(struct kvm *kvm);
 
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 24854c9e3717..b4f7bef38e0d 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -1323,6 +1323,9 @@ static inline void kvm_vcpu_set_dy_eligible(struct kvm_vcpu *vcpu, bool val)
 }
 #endif /* CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT */
 
+struct kvm_vcpu *kvm_get_running_vcpu(void);
+struct kvm_vcpu __percpu **kvm_get_running_vcpus(void);
+
 #ifdef CONFIG_HAVE_KVM_IRQ_BYPASS
 bool kvm_arch_has_irq_bypass(void);
 int kvm_arch_irq_bypass_add_producer(struct irq_bypass_consumer *,
diff --git a/virt/kvm/arm/arch_timer.c b/virt/kvm/arm/arch_timer.c
index e2bb5bd60227..085e7fed850c 100644
--- a/virt/kvm/arm/arch_timer.c
+++ b/virt/kvm/arm/arch_timer.c
@@ -1022,7 +1022,7 @@ static bool timer_irqs_are_valid(struct kvm_vcpu *vcpu)
 
 bool kvm_arch_timer_get_input_level(int vintid)
 {
-	struct kvm_vcpu *vcpu = kvm_arm_get_running_vcpu();
+	struct kvm_vcpu *vcpu = kvm_get_running_vcpu();
 	struct arch_timer_context *timer;
 
 	if (vintid == vcpu_vtimer(vcpu)->irq.irq)
diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index 86c6aa1cb58e..f7dbb94ec525 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -47,9 +47,6 @@ __asm__(".arch_extension	virt");
 DEFINE_PER_CPU(kvm_host_data_t, kvm_host_data);
 static DEFINE_PER_CPU(unsigned long, kvm_arm_hyp_stack_page);
 
-/* Per-CPU variable containing the currently running vcpu. */
-static DEFINE_PER_CPU(struct kvm_vcpu *, kvm_arm_running_vcpu);
-
 /* The VMID used in the VTTBR */
 static atomic64_t kvm_vmid_gen = ATOMIC64_INIT(1);
 static u32 kvm_next_vmid;
@@ -58,31 +55,8 @@ static DEFINE_SPINLOCK(kvm_vmid_lock);
 static bool vgic_present;
 
 static DEFINE_PER_CPU(unsigned char, kvm_arm_hardware_enabled);
-
-static void kvm_arm_set_running_vcpu(struct kvm_vcpu *vcpu)
-{
-	__this_cpu_write(kvm_arm_running_vcpu, vcpu);
-}
-
 DEFINE_STATIC_KEY_FALSE(userspace_irqchip_in_use);
 
-/**
- * kvm_arm_get_running_vcpu - get the vcpu running on the current CPU.
- * Must be called from non-preemptible context
- */
-struct kvm_vcpu *kvm_arm_get_running_vcpu(void)
-{
-	return __this_cpu_read(kvm_arm_running_vcpu);
-}
-
-/**
- * kvm_arm_get_running_vcpus - get the per-CPU array of currently running vcpus.
- */
-struct kvm_vcpu * __percpu *kvm_get_running_vcpus(void)
-{
-	return &kvm_arm_running_vcpu;
-}
-
 int kvm_arch_vcpu_should_kick(struct kvm_vcpu *vcpu)
 {
 	return kvm_vcpu_exiting_guest_mode(vcpu) == IN_GUEST_MODE;
@@ -374,7 +348,6 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 	vcpu->cpu = cpu;
 	vcpu->arch.host_cpu_context = &cpu_data->host_ctxt;
 
-	kvm_arm_set_running_vcpu(vcpu);
 	kvm_vgic_load(vcpu);
 	kvm_timer_vcpu_load(vcpu);
 	kvm_vcpu_load_sysregs(vcpu);
@@ -398,8 +371,6 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 	kvm_vcpu_pmu_restore_host(vcpu);
 
 	vcpu->cpu = -1;
-
-	kvm_arm_set_running_vcpu(NULL);
 }
 
 static void vcpu_power_off(struct kvm_vcpu *vcpu)
diff --git a/virt/kvm/arm/perf.c b/virt/kvm/arm/perf.c
index 918cdc3839ea..d45b8b9a4415 100644
--- a/virt/kvm/arm/perf.c
+++ b/virt/kvm/arm/perf.c
@@ -13,14 +13,14 @@
 
 static int kvm_is_in_guest(void)
 {
-        return kvm_arm_get_running_vcpu() != NULL;
+        return kvm_get_running_vcpu() != NULL;
 }
 
 static int kvm_is_user_mode(void)
 {
 	struct kvm_vcpu *vcpu;
 
-	vcpu = kvm_arm_get_running_vcpu();
+	vcpu = kvm_get_running_vcpu();
 
 	if (vcpu)
 		return !vcpu_mode_priv(vcpu);
@@ -32,7 +32,7 @@ static unsigned long kvm_get_guest_ip(void)
 {
 	struct kvm_vcpu *vcpu;
 
-	vcpu = kvm_arm_get_running_vcpu();
+	vcpu = kvm_get_running_vcpu();
 
 	if (vcpu)
 		return *vcpu_pc(vcpu);
diff --git a/virt/kvm/arm/vgic/vgic-mmio.c b/virt/kvm/arm/vgic/vgic-mmio.c
index 0d090482720d..d656ebd5f9d4 100644
--- a/virt/kvm/arm/vgic/vgic-mmio.c
+++ b/virt/kvm/arm/vgic/vgic-mmio.c
@@ -190,15 +190,6 @@ unsigned long vgic_mmio_read_pending(struct kvm_vcpu *vcpu,
  * value later will give us the same value as we update the per-CPU variable
  * in the preempt notifier handlers.
  */
-static struct kvm_vcpu *vgic_get_mmio_requester_vcpu(void)
-{
-	struct kvm_vcpu *vcpu;
-
-	preempt_disable();
-	vcpu = kvm_arm_get_running_vcpu();
-	preempt_enable();
-	return vcpu;
-}
 
 /* Must be called with irq->irq_lock held */
 static void vgic_hw_irq_spending(struct kvm_vcpu *vcpu, struct vgic_irq *irq,
@@ -221,7 +212,7 @@ void vgic_mmio_write_spending(struct kvm_vcpu *vcpu,
 			      gpa_t addr, unsigned int len,
 			      unsigned long val)
 {
-	bool is_uaccess = !vgic_get_mmio_requester_vcpu();
+	bool is_uaccess = !kvm_get_running_vcpu();
 	u32 intid = VGIC_ADDR_TO_INTID(addr, 1);
 	int i;
 	unsigned long flags;
@@ -274,7 +265,7 @@ void vgic_mmio_write_cpending(struct kvm_vcpu *vcpu,
 			      gpa_t addr, unsigned int len,
 			      unsigned long val)
 {
-	bool is_uaccess = !vgic_get_mmio_requester_vcpu();
+	bool is_uaccess = !kvm_get_running_vcpu();
 	u32 intid = VGIC_ADDR_TO_INTID(addr, 1);
 	int i;
 	unsigned long flags;
@@ -335,7 +326,7 @@ static void vgic_mmio_change_active(struct kvm_vcpu *vcpu, struct vgic_irq *irq,
 				    bool active)
 {
 	unsigned long flags;
-	struct kvm_vcpu *requester_vcpu = vgic_get_mmio_requester_vcpu();
+	struct kvm_vcpu *requester_vcpu = kvm_get_running_vcpu();
 
 	raw_spin_lock_irqsave(&irq->irq_lock, flags);
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 17969cf110dd..5c606d158854 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -108,6 +108,7 @@ struct kmem_cache *kvm_vcpu_cache;
 EXPORT_SYMBOL_GPL(kvm_vcpu_cache);
 
 static __read_mostly struct preempt_ops kvm_preempt_ops;
+static DEFINE_PER_CPU(struct kvm_vcpu *, kvm_running_vcpu);
 
 struct dentry *kvm_debugfs_dir;
 EXPORT_SYMBOL_GPL(kvm_debugfs_dir);
@@ -199,6 +200,8 @@ bool kvm_is_reserved_pfn(kvm_pfn_t pfn)
 void vcpu_load(struct kvm_vcpu *vcpu)
 {
 	int cpu = get_cpu();
+
+	__this_cpu_write(kvm_running_vcpu, vcpu);
 	preempt_notifier_register(&vcpu->preempt_notifier);
 	kvm_arch_vcpu_load(vcpu, cpu);
 	put_cpu();
@@ -210,6 +213,7 @@ void vcpu_put(struct kvm_vcpu *vcpu)
 	preempt_disable();
 	kvm_arch_vcpu_put(vcpu);
 	preempt_notifier_unregister(&vcpu->preempt_notifier);
+	__this_cpu_write(kvm_running_vcpu, NULL);
 	preempt_enable();
 }
 EXPORT_SYMBOL_GPL(vcpu_put);
@@ -4294,8 +4298,8 @@ static void kvm_sched_in(struct preempt_notifier *pn, int cpu)
 	WRITE_ONCE(vcpu->preempted, false);
 	WRITE_ONCE(vcpu->ready, false);
 
+	__this_cpu_write(kvm_running_vcpu, vcpu);
 	kvm_arch_sched_in(vcpu, cpu);
-
 	kvm_arch_vcpu_load(vcpu, cpu);
 }
 
@@ -4309,6 +4313,25 @@ static void kvm_sched_out(struct preempt_notifier *pn,
 		WRITE_ONCE(vcpu->ready, true);
 	}
 	kvm_arch_vcpu_put(vcpu);
+	__this_cpu_write(kvm_running_vcpu, NULL);
+}
+
+/**
+ * kvm_get_running_vcpu - get the vcpu running on the current CPU.
+ * Thanks to preempt notifiers, this can also be called from
+ * preemptible context.
+ */
+struct kvm_vcpu *kvm_get_running_vcpu(void)
+{
+        return __this_cpu_read(kvm_running_vcpu);
+}
+
+/**
+ * kvm_get_running_vcpus - get the per-CPU array of currently running vcpus.
+ */
+struct kvm_vcpu * __percpu *kvm_get_running_vcpus(void)
+{
+        return &kvm_running_vcpu;
 }
 
 static void check_processor_compat(void *rtn)
-- 
2.24.1

