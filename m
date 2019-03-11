Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6983C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:55:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 772992087C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:55:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552334158;
	bh=PEkBIFyXcJ2DpV/L32KekIZZRvIBc5Y5zocXa7nrNeo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0+9rq0vKJA6bDPoNZE3Vkgjv+M/PTCRWqMuQR4Prgd8G6NjFP6AM3ufkJINChLLAd
	 rSRGRGVDDxhJfShQ+qqMIEfDbeFCSSTSJyCaS+t/vtUQEoymdpYywJk7TtE+NQDF6X
	 qV7uzvvFW5u0MCpuhXAqx61TFIDgzUYGqu0/e+VM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbfCKTz5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 15:55:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:33156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728419AbfCKTzz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 15:55:55 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E2CF0217F4;
        Mon, 11 Mar 2019 19:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552334153;
        bh=PEkBIFyXcJ2DpV/L32KekIZZRvIBc5Y5zocXa7nrNeo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yy9iBLc8wg0NZmzepimrnkgLpGHAVfPeI8cvJIcURWZdU103ZEv9PhDm8chCanmNA
         bH5YERXEoagwCcXwkq6HP21+U7j3sTgXaG++fA9yf9U4WLv2U4HCmEMSh/SvCyY3/h
         gTu8MHGRn9cRFA+BhUfBcjPc66QgahbVc1uvb2YM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christoffer Dall <christoffer.dall@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Sasha Levin <sashal@kernel.org>, kvmarm@lists.cs.columbia.edu
Subject: [PATCH AUTOSEL 4.20 18/52] KVM: arm/arm64: Reset the VCPU without preemption and vcpu state loaded
Date:   Mon, 11 Mar 2019 15:54:42 -0400
Message-Id: <20190311195516.137772-18-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190311195516.137772-1-sashal@kernel.org>
References: <20190311195516.137772-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoffer Dall <christoffer.dall@arm.com>

[ Upstream commit e761a927bc9a7ee6ceb7c4f63d5922dbced87f0d ]

We have two ways to reset a vcpu:
- either through VCPU_INIT
- or through a PSCI_ON call

The first one is easy to reason about. The second one is implemented
in a more bizarre way, as it is the vcpu that handles PSCI_ON that
resets the vcpu that is being powered-on. As we need to turn the logic
around and have the target vcpu to reset itself, we must take some
preliminary steps.

Resetting the VCPU state modifies the system register state in memory,
but this may interact with vcpu_load/vcpu_put if running with preemption
disabled, which in turn may lead to corrupted system register state.

Address this by disabling preemption and doing put/load if required
around the reset logic.

Reviewed-by: Andrew Jones <drjones@redhat.com>
Signed-off-by: Christoffer Dall <christoffer.dall@arm.com>
Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/kvm/reset.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
index b72a3dd56204..f21a2a575939 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -105,16 +105,33 @@ int kvm_arch_vm_ioctl_check_extension(struct kvm *kvm, long ext)
  * This function finds the right table above and sets the registers on
  * the virtual CPU struct to their architecturally defined reset
  * values.
+ *
+ * Note: This function can be called from two paths: The KVM_ARM_VCPU_INIT
+ * ioctl or as part of handling a request issued by another VCPU in the PSCI
+ * handling code.  In the first case, the VCPU will not be loaded, and in the
+ * second case the VCPU will be loaded.  Because this function operates purely
+ * on the memory-backed valus of system registers, we want to do a full put if
+ * we were loaded (handling a request) and load the values back at the end of
+ * the function.  Otherwise we leave the state alone.  In both cases, we
+ * disable preemption around the vcpu reset as we would otherwise race with
+ * preempt notifiers which also call put/load.
  */
 int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
 {
 	const struct kvm_regs *cpu_reset;
+	int ret = -EINVAL;
+	bool loaded;
+
+	preempt_disable();
+	loaded = (vcpu->cpu != -1);
+	if (loaded)
+		kvm_arch_vcpu_put(vcpu);
 
 	switch (vcpu->arch.target) {
 	default:
 		if (test_bit(KVM_ARM_VCPU_EL1_32BIT, vcpu->arch.features)) {
 			if (!cpu_has_32bit_el1())
-				return -EINVAL;
+				goto out;
 			cpu_reset = &default_regs_reset32;
 		} else {
 			cpu_reset = &default_regs_reset;
@@ -137,7 +154,12 @@ int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
 		vcpu->arch.workaround_flags |= VCPU_WORKAROUND_2_FLAG;
 
 	/* Reset timer */
-	return kvm_timer_vcpu_reset(vcpu);
+	ret = kvm_timer_vcpu_reset(vcpu);
+out:
+	if (loaded)
+		kvm_arch_vcpu_load(vcpu, smp_processor_id());
+	preempt_enable();
+	return ret;
 }
 
 void kvm_set_ipa_limit(void)
-- 
2.19.1

