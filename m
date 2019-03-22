Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7392BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39FD720830
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256641;
	bh=DaBm2ZrIMxnLc0vQPeKno+09WLuDZrBJgSBvb7oNR0g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Qk3OEmu044w+LMzL9/V/zDqMIdrA/KrxGkgsbN3Ck5PpCfhnLqN7W57ZHHAi5j1j9
	 ADaDPBRH+xPUzgkTJxX2I1aHqyuT+uQf2z1N9hE2NWIxZLJW9yOHQ7QcCdzTr2en3O
	 TDuuYoOMI1t4vDV/ayd/zlfEK+wlRhM2ZO0L5+PE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389443AbfCVMKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:10:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:49000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733055AbfCVMKh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:10:37 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A57420830;
        Fri, 22 Mar 2019 12:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256636;
        bh=DaBm2ZrIMxnLc0vQPeKno+09WLuDZrBJgSBvb7oNR0g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XmbpWrl8XGXcSN4hg9ON201p3WL2bdWXYrekuW3zyWxF3l+zKqIShiJKEI2kQFpOT
         mE/rVUMzgtpAFrG/0/oYKZ9Is6YOar+EHK8V6VsuEuEHVFFQ2HaxWDdQR2+M6Ta3Ro
         LetGeE/SwAYAREM8DOKvzx13Z8+32ZOEToVaSpSk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 4.19 273/280] KVM: Call kvm_arch_memslots_updated() before updating memslots
Date:   Fri, 22 Mar 2019 12:17:06 +0100
Message-Id: <20190322111346.599618273@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1131,7 +1131,7 @@ static inline void kvm_arch_hardware_uns
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
@@ -822,7 +822,7 @@ struct kvm_vcpu_arch {
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
@@ -865,7 +865,7 @@ static inline void kvm_arch_vcpu_uninit(
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
@@ -1194,7 +1194,7 @@ void kvm_mmu_clear_dirty_pt_masked(struc
 				   struct kvm_memory_slot *slot,
 				   gfn_t gfn_offset, unsigned long mask);
 void kvm_mmu_zap_all(struct kvm *kvm);
-void kvm_mmu_invalidate_mmio_sptes(struct kvm *kvm, struct kvm_memslots *slots);
+void kvm_mmu_invalidate_mmio_sptes(struct kvm *kvm, u64 gen);
 unsigned int kvm_mmu_calculate_mmu_pages(struct kvm *kvm);
 void kvm_mmu_change_mmu_pages(struct kvm *kvm, unsigned int kvm_nr_mmu_pages);
 
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -5774,13 +5774,13 @@ static bool kvm_has_zapped_obsolete_page
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
@@ -9108,13 +9108,13 @@ out_free:
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
@@ -633,7 +633,7 @@ void kvm_arch_free_memslot(struct kvm *k
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
@@ -2154,7 +2154,7 @@ int kvm_arch_create_memslot(struct kvm *
 	return 0;
 }
 
-void kvm_arch_memslots_updated(struct kvm *kvm, struct kvm_memslots *slots)
+void kvm_arch_memslots_updated(struct kvm *kvm, u64 gen)
 {
 }
 
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -873,6 +873,7 @@ static struct kvm_memslots *install_new_
 		int as_id, struct kvm_memslots *slots)
 {
 	struct kvm_memslots *old_memslots = __kvm_memslots(kvm, as_id);
+	u64 gen;
 
 	/*
 	 * Set the low bit in the generation, which disables SPTE caching
@@ -895,9 +896,11 @@ static struct kvm_memslots *install_new_
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


