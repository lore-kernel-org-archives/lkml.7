Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BE3BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:08:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CEA22192D
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 12:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553256513;
	bh=oMTMVl3dnmsXYYv7toVQF4/sdaSxxDcaHKH+qBroFkU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iUnWqsAyMzi/nOxEskr6vZScMUoMQh+/vQqi5wwWFmS9j45B/Cp+t4dYEe4w4/1ZW
	 u/cacDt6Vry0U1xr7b5HhMajiXpnUL+ABjkTXdpYvDgco8Lwfk9JIG4GJiY+wSoxsL
	 GjmYoihIlKBSZoLyaEREKieh421salJbICq7w+iM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389179AbfCVMIb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 08:08:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:46874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388269AbfCVMIa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 08:08:30 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8972321916;
        Fri, 22 Mar 2019 12:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553256509;
        bh=oMTMVl3dnmsXYYv7toVQF4/sdaSxxDcaHKH+qBroFkU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uv/v/JM+rVfty+heMMCAOMYeXMMxGzda5sD896ssW6YsA3R1fJiAcoTj/qsGEkKm7
         2apipfKY7idUOHXJ47xh364+Yaf8kKy3LisQRX4txW2I7CD9L/NRSmspNm/1lD0k0a
         L3GYdEL4IcijpCY0NZQgH2JO0WBrz796/dHGKtBs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Julien Thierry <julien.thierry@arm.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        James Morse <james.morse@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Will Deacon <will.deacon@arm.com>, linux-arch@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 4.19 232/280] arm64: Fix HCR.TGE status for NMI contexts
Date:   Fri, 22 Mar 2019 12:16:25 +0100
Message-Id: <20190322111337.497700154@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190322111306.356185024@linuxfoundation.org>
References: <20190322111306.356185024@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Julien Thierry <julien.thierry@arm.com>

commit 5870970b9a828d8693aa6d15742573289d7dbcd0 upstream.

When using VHE, the host needs to clear HCR_EL2.TGE bit in order
to interact with guest TLBs, switching from EL2&0 translation regime
to EL1&0.

However, some non-maskable asynchronous event could happen while TGE is
cleared like SDEI. Because of this address translation operations
relying on EL2&0 translation regime could fail (tlb invalidation,
userspace access, ...).

Fix this by properly setting HCR_EL2.TGE when entering NMI context and
clear it if necessary when returning to the interrupted context.

Signed-off-by: Julien Thierry <julien.thierry@arm.com>
Suggested-by: Marc Zyngier <marc.zyngier@arm.com>
Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>
Reviewed-by: James Morse <james.morse@arm.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: James Morse <james.morse@arm.com>
Cc: linux-arch@vger.kernel.org
Cc: stable@vger.kernel.org
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/arm64/include/asm/hardirq.h |   31 +++++++++++++++++++++++++++++++
 arch/arm64/kernel/irq.c          |    3 +++
 include/linux/hardirq.h          |    7 +++++++
 3 files changed, 41 insertions(+)

--- a/arch/arm64/include/asm/hardirq.h
+++ b/arch/arm64/include/asm/hardirq.h
@@ -17,8 +17,12 @@
 #define __ASM_HARDIRQ_H
 
 #include <linux/cache.h>
+#include <linux/percpu.h>
 #include <linux/threads.h>
+#include <asm/barrier.h>
 #include <asm/irq.h>
+#include <asm/kvm_arm.h>
+#include <asm/sysreg.h>
 
 #define NR_IPI	7
 
@@ -37,6 +41,33 @@ u64 smp_irq_stat_cpu(unsigned int cpu);
 
 #define __ARCH_IRQ_EXIT_IRQS_DISABLED	1
 
+struct nmi_ctx {
+	u64 hcr;
+};
+
+DECLARE_PER_CPU(struct nmi_ctx, nmi_contexts);
+
+#define arch_nmi_enter()							\
+	do {									\
+		if (is_kernel_in_hyp_mode()) {					\
+			struct nmi_ctx *nmi_ctx = this_cpu_ptr(&nmi_contexts);	\
+			nmi_ctx->hcr = read_sysreg(hcr_el2);			\
+			if (!(nmi_ctx->hcr & HCR_TGE)) {			\
+				write_sysreg(nmi_ctx->hcr | HCR_TGE, hcr_el2);	\
+				isb();						\
+			}							\
+		}								\
+	} while (0)
+
+#define arch_nmi_exit()								\
+	do {									\
+		if (is_kernel_in_hyp_mode()) {					\
+			struct nmi_ctx *nmi_ctx = this_cpu_ptr(&nmi_contexts);	\
+			if (!(nmi_ctx->hcr & HCR_TGE))				\
+				write_sysreg(nmi_ctx->hcr, hcr_el2);		\
+		}								\
+	} while (0)
+
 static inline void ack_bad_irq(unsigned int irq)
 {
 	extern unsigned long irq_err_count;
--- a/arch/arm64/kernel/irq.c
+++ b/arch/arm64/kernel/irq.c
@@ -33,6 +33,9 @@
 
 unsigned long irq_err_count;
 
+/* Only access this in an NMI enter/exit */
+DEFINE_PER_CPU(struct nmi_ctx, nmi_contexts);
+
 DEFINE_PER_CPU(unsigned long *, irq_stack_ptr);
 
 int arch_show_interrupts(struct seq_file *p, int prec)
--- a/include/linux/hardirq.h
+++ b/include/linux/hardirq.h
@@ -60,8 +60,14 @@ extern void irq_enter(void);
  */
 extern void irq_exit(void);
 
+#ifndef arch_nmi_enter
+#define arch_nmi_enter()	do { } while (0)
+#define arch_nmi_exit()		do { } while (0)
+#endif
+
 #define nmi_enter()						\
 	do {							\
+		arch_nmi_enter();				\
 		printk_nmi_enter();				\
 		lockdep_off();					\
 		ftrace_nmi_enter();				\
@@ -80,6 +86,7 @@ extern void irq_exit(void);
 		ftrace_nmi_exit();				\
 		lockdep_on();					\
 		printk_nmi_exit();				\
+		arch_nmi_exit();				\
 	} while (0)
 
 #endif /* LINUX_HARDIRQ_H */


