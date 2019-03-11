Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E72ABC4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B78C9214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 19:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552334339;
	bh=E0fgIza9+M28y/WMr1PzLTFMqibo3W94Ud5zHJmftuI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mUf95yg/FGL7jltXGfG95hb3kqolwEDdIOADf11ZW3GicMgLpUkEn2XhJBBy+c6I5
	 vXxI6WxSxRxEBbnQw8UxTr/aJHF7ye/Vx1xK25exupMZmhXZjJPcC+MHqK+LgUp7gA
	 nDx44CORR6w0JRWY4jhA5mgny6HythzP8/sCAZHU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729500AbfCKT66 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 15:58:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:36160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729420AbfCKT6l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 15:58:41 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1002121738;
        Mon, 11 Mar 2019 19:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552334320;
        bh=E0fgIza9+M28y/WMr1PzLTFMqibo3W94Ud5zHJmftuI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=wM02WW5wu11WBPNvQfVZ8QnEpoHk87w6iCvdj7tmMANGT+AIhk8sbhZbvgNmreuQB
         MP41rsVR9yczxJ33DDyCnEzR68TDQPmJD9oi0SAw7VY2pBb6BV/mSJsp58ZS3p3NGb
         +tVeVbjk2U5jDWjbxaPSQaR9q8aXahL5mUqjWw0E=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Christoffer Dall <christoffer.dall@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Sasha Levin <sashal@kernel.org>, kvmarm@lists.cs.columbia.edu
Subject: [PATCH AUTOSEL 4.14 11/27] KVM: arm/arm64: Reset the VCPU without preemption and vcpu state loaded
Date:   Mon, 11 Mar 2019 15:58:08 -0400
Message-Id: <20190311195824.139043-11-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190311195824.139043-1-sashal@kernel.org>
References: <20190311195824.139043-1-sashal@kernel.org>
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
index a74311beda35..c1c5a57249d2 100644
--- a/arch/arm64/kvm/reset.c
+++ b/arch/arm64/kvm/reset.c
@@ -95,16 +95,33 @@ int kvm_arch_dev_ioctl_check_extension(struct kvm *kvm, long ext)
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
@@ -127,5 +144,10 @@ int kvm_reset_vcpu(struct kvm_vcpu *vcpu)
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
-- 
2.19.1

