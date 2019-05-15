Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF5B1C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 13:45:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7ADAC2070D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 13:45:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727765AbfEONpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 09:45:49 -0400
Received: from alexa-out-blr-02.qualcomm.com ([103.229.18.198]:36379 "EHLO
        alexa-out-blr.qualcomm.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726794AbfEONpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 09:45:49 -0400
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by alexa-out-blr.qualcomm.com with ESMTP/TLS/AES256-SHA; 15 May 2019 19:13:55 +0530
X-IronPort-AV: E=McAfee;i="5900,7806,9257"; a="9504431"
Received: from blr-ubuntu-104.qualcomm.com ([10.79.43.231])
  by ironmsg01-blr.qualcomm.com with ESMTP; 15 May 2019 19:13:55 +0530
Received: by blr-ubuntu-104.qualcomm.com (Postfix, from userid 346745)
        id 71DF93BB0; Wed, 15 May 2019 19:13:54 +0530 (IST)
From:   Arun KS <arunks@codeaurora.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Arun KS <arunks@codeaurora.org>,
        James Morse <james.morse@arm.com>,
        Jun Yao <yaojun8558363@gmail.com>,
        Steve Capper <steve.capper@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] arm64: Fix size of __early_cpu_boot_status
Date:   Wed, 15 May 2019 19:13:19 +0530
Message-Id: <1557927822-21111-1-git-send-email-arunks@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__early_cpu_boot_status is of type int. Fix up the calls to
update_early_cpu_boot_status, to use a w register.

Signed-off-by: Arun KS <arunks@codeaurora.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
---
 arch/arm64/include/asm/smp.h | 2 +-
 arch/arm64/kernel/head.S     | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/include/asm/smp.h b/arch/arm64/include/asm/smp.h
index 18553f3..59e80ab 100644
--- a/arch/arm64/include/asm/smp.h
+++ b/arch/arm64/include/asm/smp.h
@@ -96,7 +96,7 @@ struct secondary_data {
 };
 
 extern struct secondary_data secondary_data;
-extern long __early_cpu_boot_status;
+extern int __early_cpu_boot_status;
 extern void secondary_entry(void);
 
 extern void arch_send_call_function_single_ipi(int cpu);
diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index fcae3f8..c7175fb 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -778,7 +778,7 @@ ENTRY(__enable_mmu)
 	ubfx	x2, x2, #ID_AA64MMFR0_TGRAN_SHIFT, 4
 	cmp	x2, #ID_AA64MMFR0_TGRAN_SUPPORTED
 	b.ne	__no_granule_support
-	update_early_cpu_boot_status 0, x2, x3
+	update_early_cpu_boot_status 0, x2, w3
 	adrp	x2, idmap_pg_dir
 	phys_to_ttbr x1, x1
 	phys_to_ttbr x2, x2
@@ -810,7 +810,7 @@ ENTRY(__cpu_secondary_check52bitva)
 	cbnz	x0, 2f
 
 	update_early_cpu_boot_status \
-		CPU_STUCK_IN_KERNEL | CPU_STUCK_REASON_52_BIT_VA, x0, x1
+		CPU_STUCK_IN_KERNEL | CPU_STUCK_REASON_52_BIT_VA, x0, w1
 1:	wfe
 	wfi
 	b	1b
@@ -822,7 +822,7 @@ ENDPROC(__cpu_secondary_check52bitva)
 __no_granule_support:
 	/* Indicate that this CPU can't boot and is stuck in the kernel */
 	update_early_cpu_boot_status \
-		CPU_STUCK_IN_KERNEL | CPU_STUCK_REASON_NO_GRAN, x1, x2
+		CPU_STUCK_IN_KERNEL | CPU_STUCK_REASON_NO_GRAN, x1, w2
 1:
 	wfe
 	wfi
-- 
1.9.1

