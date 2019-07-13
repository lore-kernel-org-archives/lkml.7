Return-Path: <SRS0=/nvU=VK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB506C742A7
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 04:41:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA55020989
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 04:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbfGMElt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jul 2019 00:41:49 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:42974 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725916AbfGMElt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 00:41:49 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 5150C65E17EAE6E29EF6;
        Sat, 13 Jul 2019 12:41:46 +0800 (CST)
Received: from HGHY2Y004646261.china.huawei.com (10.184.12.158) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Sat, 13 Jul 2019 12:41:39 +0800
From:   Zenghui Yu <yuzenghui@huawei.com>
To:     <marc.zyngier@arm.com>, <kvmarm@lists.cs.columbia.edu>,
        <linux-arm-kernel@lists.infradead.org>, <catalin.marinas@arm.com>,
        <will@kernel.org>
CC:     <james.morse@arm.com>, <julien.thierry@arm.com>,
        <suzuki.poulose@arm.com>, <mark.rutland@arm.com>,
        <linux-kernel@vger.kernel.org>, <amit.kachhap@arm.com>,
        <Dave.Martin@arm.com>, <wanghaibin.wang@huawei.com>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH] KVM: arm64: Update kvm_arm_exception_class and esr_class_str for new EC
Date:   Sat, 13 Jul 2019 04:40:54 +0000
Message-ID: <1562992854-972-1-git-send-email-yuzenghui@huawei.com>
X-Mailer: git-send-email 2.6.4.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.184.12.158]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We've added two ESR exception classes for new ARM hardware extensions:
ESR_ELx_EC_PAC and ESR_ELx_EC_SVE.

This patch updates "kvm_arm_exception_class" for these two EC, which the
new EC will be parsed in kvm_exit trace events (for guest's usage of
Pointer Authentication and Scalable Vector Extension).  The same updates
to "esr_class_str" for ESR_ELx_EC_PAC, by which we can get more accurate
debug info.  Trivial changes, update them in one go.

Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Dave Martin <Dave.Martin@arm.com>
Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
---
 arch/arm64/include/asm/kvm_arm.h | 7 ++++---
 arch/arm64/kernel/traps.c        | 1 +
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/kvm_arm.h b/arch/arm64/include/asm/kvm_arm.h
index a8b205e..ddf9d76 100644
--- a/arch/arm64/include/asm/kvm_arm.h
+++ b/arch/arm64/include/asm/kvm_arm.h
@@ -316,9 +316,10 @@
 
 #define kvm_arm_exception_class \
 	ECN(UNKNOWN), ECN(WFx), ECN(CP15_32), ECN(CP15_64), ECN(CP14_MR), \
-	ECN(CP14_LS), ECN(FP_ASIMD), ECN(CP10_ID), ECN(CP14_64), ECN(SVC64), \
-	ECN(HVC64), ECN(SMC64), ECN(SYS64), ECN(IMP_DEF), ECN(IABT_LOW), \
-	ECN(IABT_CUR), ECN(PC_ALIGN), ECN(DABT_LOW), ECN(DABT_CUR), \
+	ECN(CP14_LS), ECN(FP_ASIMD), ECN(CP10_ID), ECN(PAC), ECN(CP14_64), \
+	ECN(SVC64), ECN(HVC64), ECN(SMC64), ECN(SYS64), ECN(SVE), \
+	ECN(IMP_DEF), ECN(IABT_LOW), ECN(IABT_CUR), \
+	ECN(PC_ALIGN), ECN(DABT_LOW), ECN(DABT_CUR), \
 	ECN(SP_ALIGN), ECN(FP_EXC32), ECN(FP_EXC64), ECN(SERROR), \
 	ECN(BREAKPT_LOW), ECN(BREAKPT_CUR), ECN(SOFTSTP_LOW), \
 	ECN(SOFTSTP_CUR), ECN(WATCHPT_LOW), ECN(WATCHPT_CUR), \
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 8c03456..969e156 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -734,6 +734,7 @@ asmlinkage void __exception do_sysinstr(unsigned int esr, struct pt_regs *regs)
 	[ESR_ELx_EC_CP14_LS]		= "CP14 LDC/STC",
 	[ESR_ELx_EC_FP_ASIMD]		= "ASIMD",
 	[ESR_ELx_EC_CP10_ID]		= "CP10 MRC/VMRS",
+	[ESR_ELx_EC_PAC]		= "PAC",
 	[ESR_ELx_EC_CP14_64]		= "CP14 MCRR/MRRC",
 	[ESR_ELx_EC_ILL]		= "PSTATE.IL",
 	[ESR_ELx_EC_SVC32]		= "SVC (AArch32)",
-- 
1.8.3.1


