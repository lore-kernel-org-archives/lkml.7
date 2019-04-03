Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22BD4C4360F
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:23:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAC412075E
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 15:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbfDCPXT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 11:23:19 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:41630 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725959AbfDCPXT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 11:23:19 -0400
Received: from DGGEMS406-HUB.china.huawei.com (unknown [10.3.19.206])
        by Forcepoint Email with ESMTP id 12AAE4FDD608E969D7C1;
        Wed,  3 Apr 2019 23:23:17 +0800 (CST)
Received: from euler.huawei.com (10.175.104.193) by
 DGGEMS406-HUB.china.huawei.com (10.3.19.206) with Microsoft SMTP Server id
 14.3.408.0; Wed, 3 Apr 2019 23:23:09 +0800
From:   Wei Li <liwei391@huawei.com>
To:     <julien.thierry@arm.com>, <marc.zyngier@arm.com>,
        <rostedt@goodmis.org>
CC:     <mark.rutland@arm.com>, <suzuki.poulose@arm.com>,
        <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <mingo@redhat.com>, <james.morse@arm.com>, <yuzenghui@huawei.com>,
        <wanghaibin.wang@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <guohanjun@huawei.com>,
        <huawei.libin@huawei.com>
Subject: [RFC PATCH] arm64: irqflags: fix incomplete save & restore
Date:   Wed, 3 Apr 2019 23:28:54 +0800
Message-ID: <20190403152854.27741-1-liwei391@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.193]
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To support the arm64 pseudo nmi, function arch_local_irq_save() and
arch_local_irq_restore() now operate ICC_PMR_EL1 insead of daif.
But i found the logic of the save and restore may be suspicious:

arch_local_irq_save():
daif.i_on	pmr_on	->	flag.i_on
1			0		|	0
1			1		|	1
0			1		|	0		--[1]
0			0		|	0

arch_local_irq_restore():
daif.i_on	pmr_on	<-	flag.i_on
x			0		|	0
x			1		|	1

As we see, the condintion [1] will never be restored honestly. When doing
function_graph trace at gic_handle_irq(), calling local_irq_save() and
local_irq_restore() in trace_graph_entry() will just go into this
condintion. Therefore the irq can never be processed and leading to hang.

In this patch, we do the save & restore exactly, and make sure the
arch_irqs_disabled_flags() returns correctly.

Fix: commit 4a503217ce37 ("arm64: irqflags: Use ICC_PMR_EL1 for interrupt masking")
Signed-off-by: Wei Li <liwei391@huawei.com>
---
 arch/arm64/include/asm/irqflags.h | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/include/asm/irqflags.h b/arch/arm64/include/asm/irqflags.h
index 43d8366c1e87..7bc6a79f31c4 100644
--- a/arch/arm64/include/asm/irqflags.h
+++ b/arch/arm64/include/asm/irqflags.h
@@ -76,8 +76,7 @@ static inline unsigned long arch_local_save_flags(void)
 	 * The asm is logically equivalent to:
 	 *
 	 * if (system_uses_irq_prio_masking())
-	 *	flags = (daif_bits & PSR_I_BIT) ?
-	 *			GIC_PRIO_IRQOFF :
+	 *	flags = (daif_bits << 32) |
 	 *			read_sysreg_s(SYS_ICC_PMR_EL1);
 	 * else
 	 *	flags = daif_bits;
@@ -87,11 +86,11 @@ static inline unsigned long arch_local_save_flags(void)
 			"nop\n"
 			"nop",
 			"mrs_s	%0, " __stringify(SYS_ICC_PMR_EL1) "\n"
-			"ands	%1, %1, " __stringify(PSR_I_BIT) "\n"
-			"csel	%0, %0, %2, eq",
+			"lsl	%1, %1, #32\n"
+			"orr	%0, %0, %1",
 			ARM64_HAS_IRQ_PRIO_MASKING)
 		: "=&r" (flags), "+r" (daif_bits)
-		: "r" ((unsigned long) GIC_PRIO_IRQOFF)
+		:
 		: "memory");
 
 	return flags;
@@ -119,8 +118,8 @@ static inline void arch_local_irq_restore(unsigned long flags)
 			"msr_s	" __stringify(SYS_ICC_PMR_EL1) ", %0\n"
 			"dsb	sy",
 			ARM64_HAS_IRQ_PRIO_MASKING)
-		: "+r" (flags)
 		:
+		: "r" ((int)flags)
 		: "memory");
 }
 
@@ -130,12 +129,14 @@ static inline int arch_irqs_disabled_flags(unsigned long flags)
 
 	asm volatile(ALTERNATIVE(
 			"and	%w0, %w1, #" __stringify(PSR_I_BIT) "\n"
+			"nop\n"
 			"nop",
+			"and	%w0, %w2, #" __stringify(PSR_I_BIT) "\n"
 			"cmp	%w1, #" __stringify(GIC_PRIO_IRQOFF) "\n"
-			"cset	%w0, ls",
+			"cinc	%w0, %w0, ls",
 			ARM64_HAS_IRQ_PRIO_MASKING)
 		: "=&r" (res)
-		: "r" ((int) flags)
+		: "r" ((int) flags), "r" (flags >> 32)
 		: "memory");
 
 	return res;
-- 
2.17.1

