Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EAD1C43381
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 02:27:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DAB620833
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 02:27:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728843AbfDBC1p (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 22:27:45 -0400
Received: from foss.arm.com ([217.140.101.70]:43504 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726269AbfDBC1p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 22:27:45 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC830EBD;
        Mon,  1 Apr 2019 19:27:44 -0700 (PDT)
Received: from a075553-lin.blr.arm.com (a075553-lin.blr.arm.com [10.162.0.144])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2C9523F59C;
        Mon,  1 Apr 2019 19:27:39 -0700 (PDT)
From:   Amit Daniel Kachhap <amit.kachhap@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Christoffer Dall <christoffer.dall@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Jones <drjones@redhat.com>,
        Dave Martin <Dave.Martin@arm.com>,
        Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>,
        kvmarm@lists.cs.columbia.edu,
        Kristina Martsenko <kristina.martsenko@arm.com>,
        linux-kernel@vger.kernel.org,
        Amit Daniel Kachhap <amit.kachhap@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry@arm.com>
Subject: [PATCH v8 2/9] KVM: arm64: Support runtime sysreg visibility filtering
Date:   Tue,  2 Apr 2019 07:57:10 +0530
Message-Id: <1554172037-4516-3-git-send-email-amit.kachhap@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554172037-4516-1-git-send-email-amit.kachhap@arm.com>
References: <1554172037-4516-1-git-send-email-amit.kachhap@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Martin <Dave.Martin@arm.com>

Some optional features of the Arm architecture add new system
registers that are not present in the base architecture.

Where these features are optional for the guest, the visibility of
these registers may need to depend on some runtime configuration,
such as a flag passed to KVM_ARM_VCPU_INIT.

For example, ZCR_EL1 and ID_AA64ZFR0_EL1 need to be hidden if SVE
is not enabled for the guest, even though these registers may be
present in the hardware and visible to the host at EL2.

Adding special-case checks all over the place for individual
registers is going to get messy as the number of conditionally-
visible registers grows.

In order to help solve this problem, this patch adds a new sysreg
method visibility() that can be used to hook in any needed runtime
visibility checks.  This method can currently return
REG_HIDDEN_USER to inhibit enumeration and ioctl access to the
register for userspace, and REG_HIDDEN_GUEST to inhibit runtime
access by the guest using MSR/MRS.  Wrappers are added to allow
these flags to be conveniently queried.

This approach allows a conditionally modified view of individual
system registers such as the CPU ID registers, in addition to
completely hiding register where appropriate.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 arch/arm64/kvm/sys_regs.c | 24 +++++++++++++++++++++---
 arch/arm64/kvm/sys_regs.h | 25 +++++++++++++++++++++++++
 2 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index a5d14b5..c86a7b0 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1927,6 +1927,12 @@ static void perform_access(struct kvm_vcpu *vcpu,
 {
 	trace_kvm_sys_access(*vcpu_pc(vcpu), params, r);
 
+	/* Check for regs disabled by runtime config */
+	if (sysreg_hidden_from_guest(vcpu, r)) {
+		kvm_inject_undefined(vcpu);
+		return;
+	}
+
 	/*
 	 * Not having an accessor means that we have configured a trap
 	 * that we don't know how to handle. This certainly qualifies
@@ -2438,6 +2444,10 @@ int kvm_arm_sys_reg_get_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg
 	if (!r)
 		return get_invariant_sys_reg(reg->id, uaddr);
 
+	/* Check for regs disabled by runtime config */
+	if (sysreg_hidden_from_user(vcpu, r))
+		return -ENOENT;
+
 	if (r->get_user)
 		return (r->get_user)(vcpu, r, reg, uaddr);
 
@@ -2459,6 +2469,10 @@ int kvm_arm_sys_reg_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg
 	if (!r)
 		return set_invariant_sys_reg(reg->id, uaddr);
 
+	/* Check for regs disabled by runtime config */
+	if (sysreg_hidden_from_user(vcpu, r))
+		return -ENOENT;
+
 	if (r->set_user)
 		return (r->set_user)(vcpu, r, reg, uaddr);
 
@@ -2515,7 +2529,8 @@ static bool copy_reg_to_user(const struct sys_reg_desc *reg, u64 __user **uind)
 	return true;
 }
 
-static int walk_one_sys_reg(const struct sys_reg_desc *rd,
+static int walk_one_sys_reg(const struct kvm_vcpu *vcpu,
+			    const struct sys_reg_desc *rd,
 			    u64 __user **uind,
 			    unsigned int *total)
 {
@@ -2526,6 +2541,9 @@ static int walk_one_sys_reg(const struct sys_reg_desc *rd,
 	if (!(rd->reg || rd->get_user))
 		return 0;
 
+	if (sysreg_hidden_from_user(vcpu, rd))
+		return 0;
+
 	if (!copy_reg_to_user(rd, uind))
 		return -EFAULT;
 
@@ -2554,9 +2572,9 @@ static int walk_sys_regs(struct kvm_vcpu *vcpu, u64 __user *uind)
 		int cmp = cmp_sys_reg(i1, i2);
 		/* target-specific overrides generic entry. */
 		if (cmp <= 0)
-			err = walk_one_sys_reg(i1, &uind, &total);
+			err = walk_one_sys_reg(vcpu, i1, &uind, &total);
 		else
-			err = walk_one_sys_reg(i2, &uind, &total);
+			err = walk_one_sys_reg(vcpu, i2, &uind, &total);
 
 		if (err)
 			return err;
diff --git a/arch/arm64/kvm/sys_regs.h b/arch/arm64/kvm/sys_regs.h
index 3b1bc7f..2be9950 100644
--- a/arch/arm64/kvm/sys_regs.h
+++ b/arch/arm64/kvm/sys_regs.h
@@ -64,8 +64,15 @@ struct sys_reg_desc {
 			const struct kvm_one_reg *reg, void __user *uaddr);
 	int (*set_user)(struct kvm_vcpu *vcpu, const struct sys_reg_desc *rd,
 			const struct kvm_one_reg *reg, void __user *uaddr);
+
+	/* Return mask of REG_* runtime visibility overrides */
+	unsigned int (*visibility)(const struct kvm_vcpu *vcpu,
+				   const struct sys_reg_desc *rd);
 };
 
+#define REG_HIDDEN_USER		(1 << 0) /* hidden from userspace ioctls */
+#define REG_HIDDEN_GUEST	(1 << 1) /* hidden from guest */
+
 static inline void print_sys_reg_instr(const struct sys_reg_params *p)
 {
 	/* Look, we even formatted it for you to paste into the table! */
@@ -102,6 +109,24 @@ static inline void reset_val(struct kvm_vcpu *vcpu, const struct sys_reg_desc *r
 	__vcpu_sys_reg(vcpu, r->reg) = r->val;
 }
 
+static inline bool sysreg_hidden_from_guest(const struct kvm_vcpu *vcpu,
+					    const struct sys_reg_desc *r)
+{
+	if (likely(!r->visibility))
+		return false;
+
+	return r->visibility(vcpu, r) & REG_HIDDEN_GUEST;
+}
+
+static inline bool sysreg_hidden_from_user(const struct kvm_vcpu *vcpu,
+					   const struct sys_reg_desc *r)
+{
+	if (likely(!r->visibility))
+		return false;
+
+	return r->visibility(vcpu, r) & REG_HIDDEN_USER;
+}
+
 static inline int cmp_sys_reg(const struct sys_reg_desc *i1,
 			      const struct sys_reg_desc *i2)
 {
-- 
2.7.4

