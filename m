Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70AA2C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F5CD21916
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 11:47:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553255274;
	bh=ohxuZfRqY8m3F8gv34lG3goWqha+k6zb1TIUdQH7hTk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fkGH/JVMW5u+Xp2+0/HIPRRcDpx7nx+ZLPkoOCSAIlDEiCl78kJKWX2ndNByJ1uXK
	 5k/hZfKq5x8+vIZT8r2o1XYMbfk+EGoMwgXbE0O4wJ8vEN/yspimhcp82tZU/nc6Hp
	 gmd/BZN5C911wFdtc4ORViDgxRXRwaCm1V+FiZmU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732232AbfCVLrw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 07:47:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:51118 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732042AbfCVLru (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 07:47:50 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2058B2075E;
        Fri, 22 Mar 2019 11:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553255269;
        bh=ohxuZfRqY8m3F8gv34lG3goWqha+k6zb1TIUdQH7hTk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C1O4bW9EA+/LgbYMurO8gLCDmjpx3vAWNSVY+c9ab7pbfz+ptaQom+VOHtQH/7m+1
         D9YuSNFRcmINoum+/NBo62IvJ3N6CPaj20fNEa9uCRexuW6GeOsq/fa80/KeRQHMcy
         Tz7HgCg5GaD3bJ+aFRmwrimstC/BEsXmnBGk2BZs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andrew Jones <drjones@redhat.com>,
        Christoffer Dall <christoffer.dall@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 020/183] KVM: arm/arm64: Reset the VCPU without preemption and vcpu state loaded
Date:   Fri, 22 Mar 2019 12:14:08 +0100
Message-Id: <20190322111243.218570826@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111241.819468003@linuxfoundation.org>
References: <20190322111241.819468003@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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



