Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18314C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 05:49:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDFFE205ED
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 05:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557208179;
	bh=5P2H5+gsVcPZ1ggy4BitQnui3B9j4EZ5RodrYR8oJJM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hsJMWEgqgx+UVt5Z9q7amk5baeVWIY0ykFNNTRPhxOSgjXFrHOKXjmzr/JqvWIERM
	 heKRBpocDZ/6emJbPxofoQI+FXDsEpZjUx+Y8HQWZ23ehAbrYohUd2P0iCAdu1VcyY
	 o5kWbLEa7RBsZjgHVMK+GLzMb2Lr8O8u6tPUc4XE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729305AbfEGFtj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 01:49:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:59918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728293AbfEGFk0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 01:40:26 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60077216C8;
        Tue,  7 May 2019 05:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557207625;
        bh=5P2H5+gsVcPZ1ggy4BitQnui3B9j4EZ5RodrYR8oJJM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DlUNJYJqRVdPkIcTWhyswyECS6OeSd22y3+1vtJaq3i/H10sAMWUnqCZkPSne9VHF
         iLKjxS8MkTpKgiHXk7dfJUM5Lo5GPbetzNpMpkpKISdCagpWhQ8TdD3f43+GFsjyKt
         wC58OTzKfkDd5fK3SMmWPkH70M3ubTNMREWBw/60=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        James Morse <james.morse@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Sasha Levin <alexander.levin@microsoft.com>,
        kvmarm@lists.cs.columbia.edu
Subject: [PATCH AUTOSEL 4.14 63/95] arm64: KVM: Make VHE Stage-2 TLB invalidation operations non-interruptible
Date:   Tue,  7 May 2019 01:37:52 -0400
Message-Id: <20190507053826.31622-63-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190507053826.31622-1-sashal@kernel.org>
References: <20190507053826.31622-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marc Zyngier <marc.zyngier@arm.com>

[ Upstream commit c987876a80e7bcb98a839f10dca9ce7fda4feced ]

Contrary to the non-VHE version of the TLB invalidation helpers, the VHE
code  has interrupts enabled, meaning that we can take an interrupt in
the middle of such a sequence, and start running something else with
HCR_EL2.TGE cleared.

That's really not a good idea.

Take the heavy-handed option and disable interrupts in
__tlb_switch_to_guest_vhe, restoring them in __tlb_switch_to_host_vhe.
The latter also gain an ISB in order to make sure that TGE really has
taken effect.

Cc: stable@vger.kernel.org
Acked-by: Christoffer Dall <christoffer.dall@arm.com>
Reviewed-by: James Morse <james.morse@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/arm64/kvm/hyp/tlb.c | 35 +++++++++++++++++++++++++----------
 1 file changed, 25 insertions(+), 10 deletions(-)

diff --git a/arch/arm64/kvm/hyp/tlb.c b/arch/arm64/kvm/hyp/tlb.c
index 73464a96c365..db23c6e5c885 100644
--- a/arch/arm64/kvm/hyp/tlb.c
+++ b/arch/arm64/kvm/hyp/tlb.c
@@ -15,13 +15,18 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#include <linux/irqflags.h>
+
 #include <asm/kvm_hyp.h>
 #include <asm/tlbflush.h>
 
-static void __hyp_text __tlb_switch_to_guest_vhe(struct kvm *kvm)
+static void __hyp_text __tlb_switch_to_guest_vhe(struct kvm *kvm,
+						 unsigned long *flags)
 {
 	u64 val;
 
+	local_irq_save(*flags);
+
 	/*
 	 * With VHE enabled, we have HCR_EL2.{E2H,TGE} = {1,1}, and
 	 * most TLB operations target EL2/EL0. In order to affect the
@@ -36,7 +41,8 @@ static void __hyp_text __tlb_switch_to_guest_vhe(struct kvm *kvm)
 	isb();
 }
 
-static void __hyp_text __tlb_switch_to_guest_nvhe(struct kvm *kvm)
+static void __hyp_text __tlb_switch_to_guest_nvhe(struct kvm *kvm,
+						  unsigned long *flags)
 {
 	write_sysreg(kvm->arch.vttbr, vttbr_el2);
 	isb();
@@ -47,7 +53,8 @@ static hyp_alternate_select(__tlb_switch_to_guest,
 			    __tlb_switch_to_guest_vhe,
 			    ARM64_HAS_VIRT_HOST_EXTN);
 
-static void __hyp_text __tlb_switch_to_host_vhe(struct kvm *kvm)
+static void __hyp_text __tlb_switch_to_host_vhe(struct kvm *kvm,
+						unsigned long flags)
 {
 	/*
 	 * We're done with the TLB operation, let's restore the host's
@@ -55,9 +62,12 @@ static void __hyp_text __tlb_switch_to_host_vhe(struct kvm *kvm)
 	 */
 	write_sysreg(0, vttbr_el2);
 	write_sysreg(HCR_HOST_VHE_FLAGS, hcr_el2);
+	isb();
+	local_irq_restore(flags);
 }
 
-static void __hyp_text __tlb_switch_to_host_nvhe(struct kvm *kvm)
+static void __hyp_text __tlb_switch_to_host_nvhe(struct kvm *kvm,
+						 unsigned long flags)
 {
 	write_sysreg(0, vttbr_el2);
 }
@@ -69,11 +79,13 @@ static hyp_alternate_select(__tlb_switch_to_host,
 
 void __hyp_text __kvm_tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t ipa)
 {
+	unsigned long flags;
+
 	dsb(ishst);
 
 	/* Switch to requested VMID */
 	kvm = kern_hyp_va(kvm);
-	__tlb_switch_to_guest()(kvm);
+	__tlb_switch_to_guest()(kvm, &flags);
 
 	/*
 	 * We could do so much better if we had the VA as well.
@@ -116,36 +128,39 @@ void __hyp_text __kvm_tlb_flush_vmid_ipa(struct kvm *kvm, phys_addr_t ipa)
 	if (!has_vhe() && icache_is_vpipt())
 		__flush_icache_all();
 
-	__tlb_switch_to_host()(kvm);
+	__tlb_switch_to_host()(kvm, flags);
 }
 
 void __hyp_text __kvm_tlb_flush_vmid(struct kvm *kvm)
 {
+	unsigned long flags;
+
 	dsb(ishst);
 
 	/* Switch to requested VMID */
 	kvm = kern_hyp_va(kvm);
-	__tlb_switch_to_guest()(kvm);
+	__tlb_switch_to_guest()(kvm, &flags);
 
 	__tlbi(vmalls12e1is);
 	dsb(ish);
 	isb();
 
-	__tlb_switch_to_host()(kvm);
+	__tlb_switch_to_host()(kvm, flags);
 }
 
 void __hyp_text __kvm_tlb_flush_local_vmid(struct kvm_vcpu *vcpu)
 {
 	struct kvm *kvm = kern_hyp_va(kern_hyp_va(vcpu)->kvm);
+	unsigned long flags;
 
 	/* Switch to requested VMID */
-	__tlb_switch_to_guest()(kvm);
+	__tlb_switch_to_guest()(kvm, &flags);
 
 	__tlbi(vmalle1);
 	dsb(nsh);
 	isb();
 
-	__tlb_switch_to_host()(kvm);
+	__tlb_switch_to_host()(kvm, flags);
 }
 
 void __hyp_text __kvm_flush_vm_context(void)
-- 
2.20.1

