Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7316BC2D0D2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 14:33:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 545B621D7E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 14:33:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbfLTOdT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 09:33:19 -0500
Received: from foss.arm.com ([217.140.110.172]:51206 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727815AbfLTOal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 09:30:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1304311FB;
        Fri, 20 Dec 2019 06:30:41 -0800 (PST)
Received: from e119886-lin.cambridge.arm.com (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 39E3A3F718;
        Fri, 20 Dec 2019 06:30:39 -0800 (PST)
From:   Andrew Murray <andrew.murray@arm.com>
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, kvmarm@lists.cs.columbia.edu,
        linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH v2 04/18] arm64: KVM: add SPE system registers to sys_reg_descs
Date:   Fri, 20 Dec 2019 14:30:11 +0000
Message-Id: <20191220143025.33853-5-andrew.murray@arm.com>
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

Add the Statistical Profiling Extension(SPE) Profiling Buffer controls
registers such that we can provide initial register values and use the
sys_regs structure as a store for our SPE context.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
[ Reword commit, remove access/reset handlers, defer kvm_arm_support_spe_v1 ]
Signed-off-by: Andrew Murray <andrew.murray@arm.com>
---
 arch/arm64/include/asm/kvm_host.h | 12 ++++++++++++
 arch/arm64/kvm/sys_regs.c         | 11 +++++++++++
 2 files changed, 23 insertions(+)

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index f5dcff912645..9eb85f14df90 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -145,6 +145,18 @@ enum vcpu_sysreg {
 	MDCCINT_EL1,	/* Monitor Debug Comms Channel Interrupt Enable Reg */
 	DISR_EL1,	/* Deferred Interrupt Status Register */
 
+	/* Statistical Profiling Extension Registers */
+	PMSCR_EL1,
+	PMSICR_EL1,
+	PMSIRR_EL1,
+	PMSFCR_EL1,
+	PMSEVFR_EL1,
+	PMSLATFR_EL1,
+	PMSIDR_EL1,
+	PMBLIMITR_EL1,
+	PMBPTR_EL1,
+	PMBSR_EL1,
+
 	/* Performance Monitors Registers */
 	PMCR_EL0,	/* Control Register */
 	PMSELR_EL0,	/* Event Counter Selection Register */
diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
index 46822afc57e0..955b157f9cc5 100644
--- a/arch/arm64/kvm/sys_regs.c
+++ b/arch/arm64/kvm/sys_regs.c
@@ -1506,6 +1506,17 @@ static const struct sys_reg_desc sys_reg_descs[] = {
 	{ SYS_DESC(SYS_FAR_EL1), access_vm_reg, reset_unknown, FAR_EL1 },
 	{ SYS_DESC(SYS_PAR_EL1), NULL, reset_unknown, PAR_EL1 },
 
+	{ SYS_DESC(SYS_PMSCR_EL1), NULL, reset_val, PMSCR_EL1, 0 },
+	{ SYS_DESC(SYS_PMSICR_EL1), NULL, reset_val, PMSICR_EL1, 0 },
+	{ SYS_DESC(SYS_PMSIRR_EL1), NULL, reset_val, PMSIRR_EL1, 0 },
+	{ SYS_DESC(SYS_PMSFCR_EL1), NULL, reset_val, PMSFCR_EL1, 0 },
+	{ SYS_DESC(SYS_PMSEVFR_EL1), NULL, reset_val, PMSEVFR_EL1, 0 },
+	{ SYS_DESC(SYS_PMSLATFR_EL1), NULL, reset_val, PMSLATFR_EL1, 0 },
+	{ SYS_DESC(SYS_PMSIDR_EL1), NULL, reset_val, PMSIDR_EL1, 0 },
+	{ SYS_DESC(SYS_PMBLIMITR_EL1), NULL, reset_val, PMBLIMITR_EL1, 0 },
+	{ SYS_DESC(SYS_PMBPTR_EL1), NULL, reset_val, PMBPTR_EL1, 0 },
+	{ SYS_DESC(SYS_PMBSR_EL1), NULL, reset_val, PMBSR_EL1, 0 },
+
 	{ SYS_DESC(SYS_PMINTENSET_EL1), access_pminten, reset_unknown, PMINTENSET_EL1 },
 	{ SYS_DESC(SYS_PMINTENCLR_EL1), access_pminten, NULL, PMINTENSET_EL1 },
 
-- 
2.21.0

