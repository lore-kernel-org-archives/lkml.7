Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71C5EC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35A58218A1
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553257430;
	bh=WYxeJRNJyvQLCp+OoOoqeTC1fe7HV2Aj62FUHb376AQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ZnK/5tVMdB64KCbWR5sZs/YZBQ2MImhxQLXG3f72+euD/VWqlf/kA2dFHnNXdWEMm
	 xYgPkKBK4DI7qwnL0Hrc5+90XLkUPaSp4XG+EH/UhStDgVsBwg/fle9f6EpgmsPO/h
	 6EoVTTRIIVpf9WLgIsUelPbl4GaXfg5cFf/P6ZPU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390855AbfCVMXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:23:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:35140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390984AbfCVMXh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:23:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D09662054F;
        Fri, 22 Mar 2019 12:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553257416;
        bh=WYxeJRNJyvQLCp+OoOoqeTC1fe7HV2Aj62FUHb376AQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cwTecd/xUJ6J2S1lQekshLexnreuurno8QMvbPTlgmw/MtPzY78mVV/lO0wsSUg/3
         u6fho/4jBc36qxXJ8B87shGGqN1pa+jq/DQWWxGrm7LS38wu09rCUUX5cABlJG2VgY
         R73buHLxlB+g9pvxGyvRDvEszEz7+TIxj1e99tGg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 5.0 224/238] KVM: Call kvm_arch_memslots_updated() before updating memslots
Date:   Fri, 22 Mar 2019 12:17:23 +0100
Message-Id: <20190322111311.555641753@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111258.383569278@linuxfoundation.org>
References: <20190322111258.383569278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Christopherson <sean.j.christopherson@intel.com>

commit 152482580a1b0accb60676063a1ac57b2d12daf6 upstream.

kvm_arch_memslots_updated() is at this point in time an x86-specific
hook for handling MMIO generation wraparound.  x86 stashes 19 bits of
the memslots generation number in its MMIO sptes in order to avoid
full page fault walks for repeat faults on emulated MMIO addresses.
Because only 19 bits are used, wrapping the MMIO generation number is
possible, if unlikely.  kvm_arch_memslots_updated() alerts x86 that
the generation has changed so that it can invalidate all MMIO sptes in
case the effective MMIO generation has wrapped so as to avoid using a
stale spte, e.g. a (very) old spte that was created with generation==0.

Given that the purpose of kvm_arch_memslots_updated() is to prevent
consuming stale entries, it needs to be called before the new generation
is propagated to memslots.  Invalidating the MMIO sptes after updating
memslots means that there is a window where a vCPU could dereference
the new memslots generation, e.g. 0, and incorrectly reuse an old MMIO
spte that was created with (pre-wrap) generation==0.

Fixes: e59dbe09f8e6 ("KVM: Introduce kvm_arch_memslots_updated()")
Cc: <stable@vger.kernel.org>
Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/include/asm/kvm_host.h    |    2 +-
 arch/powerpc/include/asm/kvm_host.h |    2 +-
 arch/s390/include/asm/kvm_host.h    |    2 +-
 arch/x86/include/asm/kvm_host.h     |    2 +-
 arch/x86/kvm/mmu.c                  |    4 ++--
 arch/x86/kvm/x86.c                  |    4 ++--
 include/linux/kvm_host.h            |    2 +-
 virt/kvm/arm/mmu.c                  |    2 +-
 virt/kvm/kvm_main.c                 |    7 +++++--
 9 files changed, 15 insertions(+), 12 deletions(-)

--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -1134,7 +1134,7 @@ static inline void kvm_arch_hardware_uns
 static inline void kvm_arch_sync_events(struct kvm *kvm) {}
 static inline void kvm_arch_free_memslot(struct kvm *kvm,
 		struct kvm_memory_slot *free, struct kvm_memory_slot *dont) {}
-static inline void kvm_arch_memslots_updated(struct kvm *kvm, struct kvm_memslots *slots) {}
+static inline void kvm_arch_memslots_updated(struct kvm *kvm, u64 gen) {}
 static inline void kvm_arch_sched_in(struct kvm_vcpu *vcpu, int cpu) {}
 static inline void kvm_arch_vcpu_blocking(struct kvm_vcpu *vcpu) {}
 static inline void kvm_arch_vcpu_unblocking(struct kvm_vcpu *vcpu) {}
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -837,7 +837,7 @@ struct kvm_vcpu_arch {
 static inline void kvm_arch_hardware_disable(void) {}
 static inline void kvm_arch_hardware_unsetup(void) {}
 static inline void kvm_arch_sync_events(struct kvm *kvm) {}
-static inline void kvm_arch_memslots_updated(struct kvm *kvm, struct kvm_memslots *slots) {}
+static inline void kvm_arch_memslots_updated(struct kvm *kvm, u64 gen) {}
 static inline void kvm_arch_flush_shadow_all(struct kvm *kvm) {}
 static inline void kvm_arch_sched_in(struct kvm_vcpu *vcpu, int cpu) {}
 static inline void kvm_arch_exit(void) {}
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -878,7 +878,7 @@ static inline void kvm_arch_vcpu_uninit(
 static inline void kvm_arch_sched_in(struct kvm_vcpu *vcpu, int cpu) {}
 static inline void kvm_arch_free_memslot(struct kvm *kvm,
 		struct kvm_memory_slot *free, struct kvm_memory_slot *dont) {}
-static inline void kvm_arch_memslots_updated(struct kvm *kvm, struct kvm_memslots *slots) {}
+static inline void kvm_arch_memslots_updated(struct kvm *kvm, u64 gen) {}
 static inline void kvm_arch_flush_shadow_all(struct kvm *kvm) {}
 static inline void kvm_arch_flush_shadow_memslot(struct kvm *kvm,
 		struct kvm_memory_slot *slot) {}
--- a/arch/x86/include/asm/kvm_host.h
+++ b/arch/x86/include/asm/kvm_host.h
@@ -1255,7 +1255,7 @@ void kvm_mmu_clear_dirty_pt_masked(struc
 				   struct kvm_memory_slot *slot,
 				   gfn_t gfn_offset, unsigned long mask);
 void kvm_mmu_zap_all(struct kvm *kvm);
-void kvm_mmu_invalidate_mmio_sptes(struct kvm *kvm, struct kvm_memslots *slots);
+void kvm_mmu_invalidate_mmio_sptes(struct kvm *kvm, u64 gen);
 unsigned int kvm_mmu_calculate_mmu_pages(struct kvm *kvm);
 void kvm_mmu_change_mmu_pages(struct kvm *kvm, unsigned int kvm_nr_mmu_pages);
 
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -5891,13 +5891,13 @@ static bool kvm_has_zapped_obsolete_page
 	return unlikely(!list_empty_careful(&kvm->arch.zapped_obsolete_pages));
 }
 
-void kvm_mmu_invalidate_mmio_sptes(struct kvm *kvm, struct kvm_memslots *slots)
+void kvm_mmu_invalidate_mmio_sptes(struct kvm *kvm, u64 gen)
 {
 	/*
 	 * The very rare case: if the generation-number is round,
 	 * zap all shadow pages.
 	 */
-	if (unlikely((slots->generation & MMIO_GEN_MASK) == 0)) {
+	if (unlikely((gen & MMIO_GEN_MASK) == 0)) {
 		kvm_debug_ratelimited("kvm: zapping shadow pages for mmio generation wraparound\n");
 		kvm_mmu_invalidate_zap_all_pages(kvm);
 	}
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -9348,13 +9348,13 @@ out_free:
 	return -ENOMEM;
 }
 
-void kvm_arch_memslots_updated(struct kvm *kvm, struct kvm_memslots *slots)
+void kvm_arch_memslots_updated(struct kvm *kvm, u64 gen)
 {
 	/*
 	 * memslots->generation has been incremented.
 	 * mmio generation may have reached its maximum value.
 	 */
-	kvm_mmu_invalidate_mmio_sptes(kvm, slots);
+	kvm_mmu_invalidate_mmio_sptes(kvm, gen);
 }
 
 int kvm_arch_prepare_memory_region(struct kvm *kvm,
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -634,7 +634,7 @@ void kvm_arch_free_memslot(struct kvm *k
 			   struct kvm_memory_slot *dont);
 int kvm_arch_create_memslot(struct kvm *kvm, struct kvm_memory_slot *slot,
 			    unsigned long npages);
-void kvm_arch_memslots_updated(struct kvm *kvm, struct kvm_memslots *slots);
+void kvm_arch_memslots_updated(struct kvm *kvm, u64 gen);
 int kvm_arch_prepare_memory_region(struct kvm *kvm,
 				struct kvm_memory_slot *memslot,
 				const struct kvm_userspace_memory_region *mem,
--- a/virt/kvm/arm/mmu.c
+++ b/virt/kvm/arm/mmu.c
@@ -2353,7 +2353,7 @@ int kvm_arch_create_memslot(struct kvm *
 	return 0;
 }
 
-void kvm_arch_memslots_updated(struct kvm *kvm, struct kvm_memslots *slots)
+void kvm_arch_memslots_updated(struct kvm *kvm, u64 gen)
 {
 }
 
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -874,6 +874,7 @@ static struct kvm_memslots *install_new_
 		int as_id, struct kvm_memslots *slots)
 {
 	struct kvm_memslots *old_memslots = __kvm_memslots(kvm, as_id);
+	u64 gen;
 
 	/*
 	 * Set the low bit in the generation, which disables SPTE caching
@@ -896,9 +897,11 @@ static struct kvm_memslots *install_new_
 	 * space 0 will use generations 0, 4, 8, ... while * address space 1 will
 	 * use generations 2, 6, 10, 14, ...
 	 */
-	slots->generation += KVM_ADDRESS_SPACE_NUM * 2 - 1;
+	gen = slots->generation + KVM_ADDRESS_SPACE_NUM * 2 - 1;
 
-	kvm_arch_memslots_updated(kvm, slots);
+	kvm_arch_memslots_updated(kvm, gen);
+
+	slots->generation = gen;
 
 	return old_memslots;
 }


