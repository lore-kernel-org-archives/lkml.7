Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 069A7C282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 10:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB0F72168B
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 10:36:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730793AbfEWKgO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 06:36:14 -0400
Received: from foss.arm.com ([217.140.101.70]:43142 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730658AbfEWKfr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 06:35:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BCCA415BF;
        Thu, 23 May 2019 03:35:46 -0700 (PDT)
Received: from usa.arm.com (e107155-lin.cambridge.arm.com [10.1.196.42])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A06F23F718;
        Thu, 23 May 2019 03:35:44 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Christoffer Dall <christoffer.dall@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        James Morse <james.morse@arm.com>,
        Suzuki K Pouloze <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Julien Thierry <julien.thierry@arm.com>
Subject: [PATCH v2 11/15] arm64: KVM/debug: trap all accesses to SPE controls at EL1
Date:   Thu, 23 May 2019 11:34:58 +0100
Message-Id: <20190523103502.25925-12-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190523103502.25925-1-sudeep.holla@arm.com>
References: <20190523103502.25925-1-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we have all the save/restore mechanism in place, lets enable
trapping of accesses to SPE profiling buffer controls at EL1 to EL2.
This will also change the translation regime used by buffer from EL2
stage 1 to EL1 stage 1 on VHE systems.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm64/kvm/hyp/switch.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
index 844f0dd7a7f0..881901825a85 100644
--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -110,6 +110,7 @@ static void activate_traps_vhe(struct kvm_vcpu *vcpu)
 
 	write_sysreg(val, cpacr_el1);
 
+	write_sysreg(vcpu->arch.mdcr_el2 | 2 << MDCR_EL2_E2PB_SHIFT, mdcr_el2);
 	write_sysreg(kvm_get_hyp_vector(), vbar_el1);
 }
 NOKPROBE_SYMBOL(activate_traps_vhe);
@@ -127,6 +128,7 @@ static void __hyp_text __activate_traps_nvhe(struct kvm_vcpu *vcpu)
 		__activate_traps_fpsimd32(vcpu);
 	}
 
+	write_sysreg(vcpu->arch.mdcr_el2 | 2 << MDCR_EL2_E2PB_SHIFT, mdcr_el2);
 	write_sysreg(val, cptr_el2);
 }
 
-- 
2.17.1

