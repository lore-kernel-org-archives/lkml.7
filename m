Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3542CC04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 13:22:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12A9220815
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 13:22:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727675AbfEPNWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 09:22:36 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:45592 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726623AbfEPNWb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 09:22:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E88219F6;
        Thu, 16 May 2019 06:22:30 -0700 (PDT)
Received: from e121650-lin.cambridge.arm.com (e121650-lin.cambridge.arm.com [10.1.196.108])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 009623F703;
        Thu, 16 May 2019 06:22:28 -0700 (PDT)
From:   Raphael Gault <raphael.gault@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, catalin.marinas@arm.com,
        will.deacon@arm.com, acme@kernel.org, mark.rutland@arm.com,
        Raphael Gault <raphael.gault@arm.com>
Subject: [PATCH 4/6] arm64: pmu: Add hook to handle pmu-related undefined instructions
Date:   Thu, 16 May 2019 14:21:46 +0100
Message-Id: <20190516132148.10085-5-raphael.gault@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190516132148.10085-1-raphael.gault@arm.com>
References: <20190516132148.10085-1-raphael.gault@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to prevent the userspace processes which are trying to access
the registers from the pmu registers on a big.LITTLE environment we
introduce a hook to handle undefined instructions.

The goal here is to prevent the process to be interrupted by a signal
when the error is caused by the task being scheduled while accessing
a counter, causing the counter access to be invalid. As we are not able
to know efficiently the number of counters available physically on both
pmu in that context we consider that any faulting access to a counter
which is architecturally correct should not cause a SIGILL signal if
the permissions are set accordingly.

Signed-off-by: Raphael Gault <raphael.gault@arm.com>
---
 arch/arm64/kernel/perf_event.c | 68 ++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index e6316f99f66b..760c947b58dd 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -19,9 +19,11 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#include <asm/cpu.h>
 #include <asm/irq_regs.h>
 #include <asm/perf_event.h>
 #include <asm/sysreg.h>
+#include <asm/traps.h>
 #include <asm/virt.h>
 
 #include <linux/acpi.h>
@@ -993,6 +995,72 @@ static int armv8pmu_probe_pmu(struct arm_pmu *cpu_pmu)
 	return probe.present ? 0 : -ENODEV;
 }
 
+static bool is_evcntr(u32 sys_reg)
+{
+	u32 CRn, Op0, Op1, CRm;
+
+	CRn = sys_reg_CRn(sys_reg);
+	CRm = sys_reg_CRm(sys_reg);
+	Op0 = sys_reg_Op0(sys_reg);
+	Op1 = sys_reg_Op1(sys_reg);
+
+	return (CRn == 0xE &&
+		(CRm & 0xc) == 0x8 &&
+		Op1 == 0x3 &&
+		Op0 == 0x3);
+}
+
+static int emulate_pmu(struct pt_regs *regs, u32 insn)
+{
+	u32 sys_reg, rt;
+	u32 pmuserenr;
+
+	sys_reg = (u32)aarch64_insn_decode_immediate(AARCH64_INSN_IMM_16, insn) << 5;
+	rt = aarch64_insn_decode_register(AARCH64_INSN_REGTYPE_RT, insn);
+	pmuserenr = read_sysreg(pmuserenr_el0);
+
+	if ((pmuserenr & (ARMV8_PMU_USERENR_ER|ARMV8_PMU_USERENR_CR)) !=
+	    (ARMV8_PMU_USERENR_ER|ARMV8_PMU_USERENR_CR))
+		return -EINVAL;
+
+	if (sys_reg != SYS_PMXEVCNTR_EL0 &&
+	    !is_evcntr(sys_reg))
+		return -EINVAL;
+
+	/*
+	 * We put 0 in the target register if we
+	 * are reading from pmu register. If we are
+	 * writing, we do nothing.
+	 */
+	if ((insn & 0xfff00000) == 0xd5300000)
+		pt_regs_write_reg(regs, rt, 0);
+	else if (sys_reg != SYS_PMSELR_EL0)
+		return -EINVAL;
+
+	arm64_skip_faulting_instruction(regs, 4);
+	return 0;
+}
+
+/*
+ * This hook will only be triggered by mrs
+ * instructions on PMU registers. This is mandatory
+ * in order to have a consistent behaviour even on
+ * big.LITTLE systems.
+ */
+static struct undef_hook pmu_hook = {
+	.instr_mask = 0xffff8800,
+	.instr_val  = 0xd53b8800,
+	.fn = emulate_pmu,
+};
+
+static int __init enable_pmu_emulation(void)
+{
+	register_undef_hook(&pmu_hook);
+	return 0;
+}
+
+core_initcall(enable_pmu_emulation);
+
 static int armv8_pmu_init(struct arm_pmu *cpu_pmu)
 {
 	int ret = armv8pmu_probe_pmu(cpu_pmu);
-- 
2.17.1

