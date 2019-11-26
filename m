Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA94BC432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 20:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BF9220835
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 20:14:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727436AbfKZUOi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 15:14:38 -0500
Received: from mx2.suse.de ([195.135.220.15]:47314 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726593AbfKZUOc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 15:14:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 62252AB92;
        Tue, 26 Nov 2019 20:14:29 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Oleg Nesterov <oleg@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Nicholas Piggin <npiggin@gmail.com>,
        Allison Randal <allison@lohutok.net>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Michal Suchanek <msuchanek@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Breno Leitao <leitao@debian.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Claudio Carvalho <cclaudio@linux.ibm.com>,
        Russell Currey <ruscur@russell.cc>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Firoz Khan <firoz.khan@linaro.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Nicolai Stange <nstange@suse.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Diana Craciun <diana.craciun@nxp.com>,
        Daniel Axtens <dja@axtens.net>,
        Michael Neuling <mikey@neuling.org>,
        Gustavo Romero <gromero@linux.ibm.com>,
        Mathieu Malaterre <malat@debian.org>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        David Howells <dhowells@redhat.com>,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>,
        Jagadeesh Pagadala <jagdsh.linux@gmail.com>,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 20/35] powerpc/64s/exception: only test KVM in SRR interrupts when PR KVM is supported
Date:   Tue, 26 Nov 2019 21:13:34 +0100
Message-Id: <f6e39de66993346635d422bf8090a3a0988dddb0.1574798487.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1574798487.git.msuchanek@suse.de>
References: <cover.1574798487.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicholas Piggin <npiggin@gmail.com>

Apart from SRESET, MCE, and syscall (hcall variant), the SRR type
interrupts are not escalated to hypervisor mode, so delivered to the OS.

When running PR KVM, the OS is the hypervisor, and the guest runs with
MSR[PR]=1, so these interrupts must test if a guest was running when
interrupted. These tests are required at the real-mode entry points
because the PR KVM host runs with LPCR[AIL]=0.

In HV KVM and nested HV KVM, the guest always receives these interrupts,
so there is no need for the host to make this test. So remove the tests
if PR KVM is not configured.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/exceptions-64s.S | 65 ++++++++++++++++++++++++++--
 1 file changed, 62 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 2f50587392aa..38bc66b95516 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -214,9 +214,36 @@ do_define_int n
 #ifdef CONFIG_KVM_BOOK3S_64_HANDLER
 #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
 /*
- * If hv is possible, interrupts come into to the hv version
- * of the kvmppc_interrupt code, which then jumps to the PR handler,
- * kvmppc_interrupt_pr, if the guest is a PR guest.
+ * All interrupts which set HSRR registers, as well as SRESET and MCE and
+ * syscall when invoked with "sc 1" switch to MSR[HV]=1 (HVMODE) to be taken,
+ * so they all generally need to test whether they were taken in guest context.
+ *
+ * Note: SRESET and MCE may also be sent to the guest by the hypervisor, and be
+ * taken with MSR[HV]=0.
+ *
+ * Interrupts which set SRR registers (with the above exceptions) do not
+ * elevate to MSR[HV]=1 mode, though most can be taken when running with
+ * MSR[HV]=1  (e.g., bare metal kernel and userspace). So these interrupts do
+ * not need to test whether a guest is running because they get delivered to
+ * the guest directly, including nested HV KVM guests.
+ *
+ * The exception is PR KVM, where the guest runs with MSR[PR]=1 and the host
+ * runs with MSR[HV]=0, so the host takes all interrupts on behalf of the
+ * guest. PR KVM runs with LPCR[AIL]=0 which causes interrupts to always be
+ * delivered to the real-mode entry point, therefore such interrupts only test
+ * KVM in their real mode handlers, and only when PR KVM is possible.
+ *
+ * Interrupts that are taken in MSR[HV]=0 and escalate to MSR[HV]=1 are always
+ * delivered in real-mode when the MMU is in hash mode because the MMU
+ * registers are not set appropriately to translate host addresses. In nested
+ * radix mode these can be delivered in virt-mode as the host translations are
+ * used implicitly (see: effective LPID, effective PID).
+ */
+
+/*
+ * If an interrupt is taken while a guest is running, it is immediately routed
+ * to KVM to handle. If both HV and PR KVM arepossible, KVM interrupts go first
+ * to kvmppc_interrupt_hv, which handles the PR guest case.
  */
 #define kvmppc_interrupt kvmppc_interrupt_hv
 #else
@@ -1258,8 +1285,10 @@ INT_DEFINE_BEGIN(data_access)
 	IVEC=0x300
 	IDAR=1
 	IDSISR=1
+#ifdef CONFIG_KVM_BOOK3S_PR_POSSIBLE
 	IKVM_SKIP=1
 	IKVM_REAL=1
+#endif
 INT_DEFINE_END(data_access)
 
 EXC_REAL_BEGIN(data_access, 0x300, 0x80)
@@ -1306,8 +1335,10 @@ INT_DEFINE_BEGIN(data_access_slb)
 	IAREA=PACA_EXSLB
 	IRECONCILE=0
 	IDAR=1
+#ifdef CONFIG_KVM_BOOK3S_PR_POSSIBLE
 	IKVM_SKIP=1
 	IKVM_REAL=1
+#endif
 INT_DEFINE_END(data_access_slb)
 
 EXC_REAL_BEGIN(data_access_slb, 0x380, 0x80)
@@ -1357,7 +1388,9 @@ INT_DEFINE_BEGIN(instruction_access)
 	IISIDE=1
 	IDAR=1
 	IDSISR=1
+#ifdef CONFIG_KVM_BOOK3S_PR_POSSIBLE
 	IKVM_REAL=1
+#endif
 INT_DEFINE_END(instruction_access)
 
 EXC_REAL_BEGIN(instruction_access, 0x400, 0x80)
@@ -1396,7 +1429,9 @@ INT_DEFINE_BEGIN(instruction_access_slb)
 	IRECONCILE=0
 	IISIDE=1
 	IDAR=1
+#ifdef CONFIG_KVM_BOOK3S_PR_POSSIBLE
 	IKVM_REAL=1
+#endif
 INT_DEFINE_END(instruction_access_slb)
 
 EXC_REAL_BEGIN(instruction_access_slb, 0x480, 0x80)
@@ -1488,7 +1523,9 @@ INT_DEFINE_BEGIN(alignment)
 	IVEC=0x600
 	IDAR=1
 	IDSISR=1
+#ifdef CONFIG_KVM_BOOK3S_PR_POSSIBLE
 	IKVM_REAL=1
+#endif
 INT_DEFINE_END(alignment)
 
 EXC_REAL_BEGIN(alignment, 0x600, 0x100)
@@ -1518,7 +1555,9 @@ EXC_COMMON_BEGIN(alignment_common)
  */
 INT_DEFINE_BEGIN(program_check)
 	IVEC=0x700
+#ifdef CONFIG_KVM_BOOK3S_PR_POSSIBLE
 	IKVM_REAL=1
+#endif
 INT_DEFINE_END(program_check)
 
 EXC_REAL_BEGIN(program_check, 0x700, 0x100)
@@ -1581,7 +1620,9 @@ EXC_COMMON_BEGIN(program_check_common)
 INT_DEFINE_BEGIN(fp_unavailable)
 	IVEC=0x800
 	IRECONCILE=0
+#ifdef CONFIG_KVM_BOOK3S_PR_POSSIBLE
 	IKVM_REAL=1
+#endif
 INT_DEFINE_END(fp_unavailable)
 
 EXC_REAL_BEGIN(fp_unavailable, 0x800, 0x100)
@@ -1643,7 +1684,9 @@ END_FTR_SECTION_IFSET(CPU_FTR_TM)
 INT_DEFINE_BEGIN(decrementer)
 	IVEC=0x900
 	IMASK=IRQS_DISABLED
+#ifdef CONFIG_KVM_BOOK3S_PR_POSSIBLE
 	IKVM_REAL=1
+#endif
 INT_DEFINE_END(decrementer)
 
 EXC_REAL_BEGIN(decrementer, 0x900, 0x80)
@@ -1728,7 +1771,9 @@ EXC_COMMON_BEGIN(hdecrementer_common)
 INT_DEFINE_BEGIN(doorbell_super)
 	IVEC=0xa00
 	IMASK=IRQS_DISABLED
+#ifdef CONFIG_KVM_BOOK3S_PR_POSSIBLE
 	IKVM_REAL=1
+#endif
 INT_DEFINE_END(doorbell_super)
 
 EXC_REAL_BEGIN(doorbell_super, 0xa00, 0x100)
@@ -1919,7 +1964,9 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
  */
 INT_DEFINE_BEGIN(single_step)
 	IVEC=0xd00
+#ifdef CONFIG_KVM_BOOK3S_PR_POSSIBLE
 	IKVM_REAL=1
+#endif
 INT_DEFINE_END(single_step)
 
 EXC_REAL_BEGIN(single_step, 0xd00, 0x100)
@@ -2208,7 +2255,9 @@ EXC_VIRT_NONE(0x4ee0, 0x20)
 INT_DEFINE_BEGIN(performance_monitor)
 	IVEC=0xf00
 	IMASK=IRQS_PMI_DISABLED
+#ifdef CONFIG_KVM_BOOK3S_PR_POSSIBLE
 	IKVM_REAL=1
+#endif
 INT_DEFINE_END(performance_monitor)
 
 EXC_REAL_BEGIN(performance_monitor, 0xf00, 0x20)
@@ -2237,7 +2286,9 @@ EXC_COMMON_BEGIN(performance_monitor_common)
 INT_DEFINE_BEGIN(altivec_unavailable)
 	IVEC=0xf20
 	IRECONCILE=0
+#ifdef CONFIG_KVM_BOOK3S_PR_POSSIBLE
 	IKVM_REAL=1
+#endif
 INT_DEFINE_END(altivec_unavailable)
 
 EXC_REAL_BEGIN(altivec_unavailable, 0xf20, 0x20)
@@ -2291,7 +2342,9 @@ END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
 INT_DEFINE_BEGIN(vsx_unavailable)
 	IVEC=0xf40
 	IRECONCILE=0
+#ifdef CONFIG_KVM_BOOK3S_PR_POSSIBLE
 	IKVM_REAL=1
+#endif
 INT_DEFINE_END(vsx_unavailable)
 
 EXC_REAL_BEGIN(vsx_unavailable, 0xf40, 0x20)
@@ -2344,7 +2397,9 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX)
  */
 INT_DEFINE_BEGIN(facility_unavailable)
 	IVEC=0xf60
+#ifdef CONFIG_KVM_BOOK3S_PR_POSSIBLE
 	IKVM_REAL=1
+#endif
 INT_DEFINE_END(facility_unavailable)
 
 EXC_REAL_BEGIN(facility_unavailable, 0xf60, 0x20)
@@ -2434,8 +2489,10 @@ EXC_VIRT_NONE(0x5200, 0x100)
 
 INT_DEFINE_BEGIN(instruction_breakpoint)
 	IVEC=0x1300
+#ifdef CONFIG_KVM_BOOK3S_PR_POSSIBLE
 	IKVM_SKIP=1
 	IKVM_REAL=1
+#endif
 INT_DEFINE_END(instruction_breakpoint)
 
 EXC_REAL_BEGIN(instruction_breakpoint, 0x1300, 0x100)
@@ -2606,7 +2663,9 @@ EXC_VIRT_NONE(0x5600, 0x100)
 
 INT_DEFINE_BEGIN(altivec_assist)
 	IVEC=0x1700
+#ifdef CONFIG_KVM_BOOK3S_PR_POSSIBLE
 	IKVM_REAL=1
+#endif
 INT_DEFINE_END(altivec_assist)
 
 EXC_REAL_BEGIN(altivec_assist, 0x1700, 0x100)
-- 
2.23.0

