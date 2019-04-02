Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ED55C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69A2F20856
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 13:42:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731584AbfDBNmJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 09:42:09 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:43786 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731283AbfDBNkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 09:40:13 -0400
Received: from [167.98.27.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBJe6-0002o0-Sl; Tue, 02 Apr 2019 14:40:11 +0100
Received: from ben by deadeye with local (Exim 4.92)
        (envelope-from <ben@decadent.org.uk>)
        id 1hBJdw-0004ur-RD; Tue, 02 Apr 2019 14:40:00 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Julien Thierry" <julien.thierry@arm.com>,
        "Christoffer Dall" <christoffer.dall@arm.com>,
        "Marc Zyngier" <marc.zyngier@arm.com>
Date:   Tue, 02 Apr 2019 14:38:27 +0100
Message-ID: <lsq.1554212307.588124430@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 55/99] KVM: arm/arm64: Fix VMID alloc race by
 reverting to lock-less
In-Reply-To: <lsq.1554212307.17110877@decadent.org.uk>
X-SA-Exim-Connect-IP: 167.98.27.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.65-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Christoffer Dall <christoffer.dall@arm.com>

commit fb544d1ca65a89f7a3895f7531221ceeed74ada7 upstream.

We recently addressed a VMID generation race by introducing a read/write
lock around accesses and updates to the vmid generation values.

However, kvm_arch_vcpu_ioctl_run() also calls need_new_vmid_gen() but
does so without taking the read lock.

As far as I can tell, this can lead to the same kind of race:

  VM 0, VCPU 0			VM 0, VCPU 1
  ------------			------------
  update_vttbr (vmid 254)
  				update_vttbr (vmid 1) // roll over
				read_lock(kvm_vmid_lock);
				force_vm_exit()
  local_irq_disable
  need_new_vmid_gen == false //because vmid gen matches

  enter_guest (vmid 254)
  				kvm_arch.vttbr = <PGD>:<VMID 1>
				read_unlock(kvm_vmid_lock);

  				enter_guest (vmid 1)

Which results in running two VCPUs in the same VM with different VMIDs
and (even worse) other VCPUs from other VMs could now allocate clashing
VMID 254 from the new generation as long as VCPU 0 is not exiting.

Attempt to solve this by making sure vttbr is updated before another CPU
can observe the updated VMID generation.

Fixes: f0cf47d939d0 "KVM: arm/arm64: Close VMID generation race"
Reviewed-by: Julien Thierry <julien.thierry@arm.com>
Signed-off-by: Christoffer Dall <christoffer.dall@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
[bwh: Backported to 3.16:
 - Use ACCESS_ONCE() instead of {READ,WRITE}_ONCE()
 - Adjust filename]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/arm/kvm/arm.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

--- a/arch/arm/kvm/arm.c
+++ b/arch/arm/kvm/arm.c
@@ -59,7 +59,7 @@ static DEFINE_PER_CPU(struct kvm_vcpu *,
 /* The VMID used in the VTTBR */
 static atomic64_t kvm_vmid_gen = ATOMIC64_INIT(1);
 static u8 kvm_next_vmid;
-static DEFINE_RWLOCK(kvm_vmid_lock);
+static DEFINE_SPINLOCK(kvm_vmid_lock);
 
 static bool vgic_present;
 
@@ -376,7 +376,9 @@ void force_vm_exit(const cpumask_t *mask
  */
 static bool need_new_vmid_gen(struct kvm *kvm)
 {
-	return unlikely(kvm->arch.vmid_gen != atomic64_read(&kvm_vmid_gen));
+	u64 current_vmid_gen = atomic64_read(&kvm_vmid_gen);
+	smp_rmb(); /* Orders read of kvm_vmid_gen and kvm->arch.vmid */
+	return unlikely(ACCESS_ONCE(kvm->arch.vmid_gen) != current_vmid_gen);
 }
 
 /**
@@ -391,16 +393,11 @@ static void update_vttbr(struct kvm *kvm
 {
 	phys_addr_t pgd_phys;
 	u64 vmid;
-	bool new_gen;
 
-	read_lock(&kvm_vmid_lock);
-	new_gen = need_new_vmid_gen(kvm);
-	read_unlock(&kvm_vmid_lock);
-
-	if (!new_gen)
+	if (!need_new_vmid_gen(kvm))
 		return;
 
-	write_lock(&kvm_vmid_lock);
+	spin_lock(&kvm_vmid_lock);
 
 	/*
 	 * We need to re-check the vmid_gen here to ensure that if another vcpu
@@ -408,7 +405,7 @@ static void update_vttbr(struct kvm *kvm
 	 * use the same vmid.
 	 */
 	if (!need_new_vmid_gen(kvm)) {
-		write_unlock(&kvm_vmid_lock);
+		spin_unlock(&kvm_vmid_lock);
 		return;
 	}
 
@@ -431,7 +428,6 @@ static void update_vttbr(struct kvm *kvm
 		kvm_call_hyp(__kvm_flush_vm_context);
 	}
 
-	kvm->arch.vmid_gen = atomic64_read(&kvm_vmid_gen);
 	kvm->arch.vmid = kvm_next_vmid;
 	kvm_next_vmid++;
 
@@ -441,7 +437,10 @@ static void update_vttbr(struct kvm *kvm
 	vmid = ((u64)(kvm->arch.vmid) << VTTBR_VMID_SHIFT) & VTTBR_VMID_MASK;
 	kvm->arch.vttbr = pgd_phys | vmid;
 
-	write_unlock(&kvm_vmid_lock);
+	smp_wmb();
+	ACCESS_ONCE(kvm->arch.vmid_gen) = atomic64_read(&kvm_vmid_gen);
+
+	spin_unlock(&kvm_vmid_lock);
 }
 
 static int kvm_vcpu_first_run_init(struct kvm_vcpu *vcpu)

