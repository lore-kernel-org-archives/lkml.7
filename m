Return-Path: <SRS0=ecL9=TG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9227DC04AAA
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 08:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7085C2082F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 May 2019 08:21:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726775AbfEFIV0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 May 2019 04:21:26 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7171 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726657AbfEFIUq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 May 2019 04:20:46 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 510C3F015AB8680A8616;
        Mon,  6 May 2019 16:20:44 +0800 (CST)
Received: from euler.huawei.com (10.175.104.193) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Mon, 6 May 2019 16:20:41 +0800
From:   Wei Li <liwei391@huawei.com>
To:     <catalin.marinas@arm.com>, <will.deacon@arm.com>,
        <marc.zyngier@arm.com>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>
CC:     <julien.thierry@arm.com>, <Suzuki.Poulose@arm.com>,
        <sudeep.holla@arm.com>, <steve.capper@arm.com>,
        <lorenzo.pieralisi@arm.com>, <daniel.thompson@linaro.org>,
        <james.morse@arm.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] arm64: Add support for on-demand backtrace of other CPUs
Date:   Mon, 6 May 2019 16:25:41 +0800
Message-ID: <20190506082542.11357-3-liwei391@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190506082542.11357-1-liwei391@huawei.com>
References: <20190506082542.11357-1-liwei391@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.193]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To support backtracing of other CPUs in the system on lockups, add the
implementation of arch_trigger_cpumask_backtrace() for arm64.

In this patch, we add an arm64 NMI-like IPI based backtracer, referring
to the implementation on arm by Russell King and Chris Metcalf.

Signed-off-by: Wei Li <liwei391@huawei.com>
---
 arch/arm64/include/asm/hardirq.h |  2 +-
 arch/arm64/include/asm/irq.h     |  6 ++++++
 arch/arm64/kernel/smp.c          | 22 +++++++++++++++++++++-
 3 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/hardirq.h b/arch/arm64/include/asm/hardirq.h
index 89691c86640a..a5d94aa59c7c 100644
--- a/arch/arm64/include/asm/hardirq.h
+++ b/arch/arm64/include/asm/hardirq.h
@@ -24,7 +24,7 @@
 #include <asm/kvm_arm.h>
 #include <asm/sysreg.h>
 
-#define NR_IPI	7
+#define NR_IPI	8
 
 typedef struct {
 	unsigned int __softirq_pending;
diff --git a/arch/arm64/include/asm/irq.h b/arch/arm64/include/asm/irq.h
index b2b0c6405eb0..28471df488c0 100644
--- a/arch/arm64/include/asm/irq.h
+++ b/arch/arm64/include/asm/irq.h
@@ -13,5 +13,11 @@ static inline int nr_legacy_irqs(void)
 	return 0;
 }
 
+#ifdef CONFIG_SMP
+extern void arch_trigger_cpumask_backtrace(const cpumask_t *mask,
+					   bool exclude_self);
+#define arch_trigger_cpumask_backtrace arch_trigger_cpumask_backtrace
+#endif
+
 #endif /* !__ASSEMBLER__ */
 #endif
diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
index bd8fdf6fcd8e..7e862f9124f3 100644
--- a/arch/arm64/kernel/smp.c
+++ b/arch/arm64/kernel/smp.c
@@ -35,6 +35,7 @@
 #include <linux/smp.h>
 #include <linux/seq_file.h>
 #include <linux/irq.h>
+#include <linux/nmi.h>
 #include <linux/irqchip/arm-gic-v3.h>
 #include <linux/percpu.h>
 #include <linux/clockchips.h>
@@ -83,7 +84,8 @@ enum ipi_msg_type {
 	IPI_CPU_CRASH_STOP,
 	IPI_TIMER,
 	IPI_IRQ_WORK,
-	IPI_WAKEUP
+	IPI_WAKEUP,
+	IPI_CPU_BACKTRACE
 };
 
 #ifdef CONFIG_HOTPLUG_CPU
@@ -787,6 +789,7 @@ static const char *ipi_types[NR_IPI] __tracepoint_string = {
 	S(IPI_TIMER, "Timer broadcast interrupts"),
 	S(IPI_IRQ_WORK, "IRQ work interrupts"),
 	S(IPI_WAKEUP, "CPU wake-up interrupts"),
+	S(IPI_CPU_BACKTRACE, "Backtrace interrupts"),
 };
 
 static void smp_cross_call(const struct cpumask *target, unsigned int ipinr)
@@ -946,6 +949,12 @@ void handle_IPI(int ipinr, struct pt_regs *regs)
 		break;
 #endif
 
+	case IPI_CPU_BACKTRACE:
+		nmi_enter();
+		nmi_cpu_backtrace(regs);
+		nmi_exit();
+		break;
+
 	default:
 		pr_crit("CPU%u: Unknown IPI message 0x%x\n", cpu, ipinr);
 		break;
@@ -1070,4 +1079,15 @@ bool cpus_are_stuck_in_kernel(void)
 
 void ipi_gic_nmi_setup(void __iomem *base)
 {
+	gic_sgi_set_prio(base, IPI_CPU_BACKTRACE, GICD_INT_NMI_PRI);
+}
+
+static void raise_nmi(cpumask_t *mask)
+{
+	smp_cross_call(mask, IPI_CPU_BACKTRACE);
+}
+
+void arch_trigger_cpumask_backtrace(const cpumask_t *mask, bool exclude_self)
+{
+	nmi_trigger_cpumask_backtrace(mask, exclude_self, raise_nmi);
 }
-- 
2.17.1

