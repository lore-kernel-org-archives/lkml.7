Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5411CC43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 14:32:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27C70206CB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 14:32:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728193AbfLTOca (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 09:32:30 -0500
Received: from foss.arm.com ([217.140.110.172]:51282 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727946AbfLTOay (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 09:30:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A33711D4;
        Fri, 20 Dec 2019 06:30:54 -0800 (PST)
Received: from e119886-lin.cambridge.arm.com (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 61B7D3F718;
        Fri, 20 Dec 2019 06:30:52 -0800 (PST)
From:   Andrew Murray <andrew.murray@arm.com>
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 10/18] arm64: KVM/debug: use EL1&0 stage 1 translation regime
Date:   Fri, 20 Dec 2019 14:30:17 +0000
Message-Id: <20191220143025.33853-11-andrew.murray@arm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191220143025.33853-1-andrew.murray@arm.com>
References: <20191220143025.33853-1-andrew.murray@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sudeep Holla <sudeep.holla@arm.com>

Now that we have all the save/restore mechanism in place, lets enable
the translation regime used by buffer from EL2 stage 1 to EL1 stage 1
on VHE systems.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
[ Reword commit, don't trap to EL2 ]
Signed-off-by: Andrew Murray <andrew.murray@arm.com>
---
 arch/arm64/kvm/hyp/switch.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/kvm/hyp/switch.c b/arch/arm64/kvm/hyp/switch.c
index 67b7c160f65b..6c153b79829b 100644
--- a/arch/arm64/kvm/hyp/switch.c
+++ b/arch/arm64/kvm/hyp/switch.c
@@ -100,6 +100,7 @@ static void activate_traps_vhe(struct kvm_vcpu *vcpu)
 
 	write_sysreg(val, cpacr_el1);
 
+	write_sysreg(vcpu->arch.mdcr_el2 | 3 << MDCR_EL2_E2PB_SHIFT, mdcr_el2);
 	write_sysreg(kvm_get_hyp_vector(), vbar_el1);
 }
 NOKPROBE_SYMBOL(activate_traps_vhe);
@@ -117,6 +118,7 @@ static void __hyp_text __activate_traps_nvhe(struct kvm_vcpu *vcpu)
 		__activate_traps_fpsimd32(vcpu);
 	}
 
+	write_sysreg(vcpu->arch.mdcr_el2 | 3 << MDCR_EL2_E2PB_SHIFT, mdcr_el2);
 	write_sysreg(val, cptr_el2);
 
 	if (cpus_have_const_cap(ARM64_WORKAROUND_1319367)) {
-- 
2.21.0

