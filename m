Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C15C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 10:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DAAF2071E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 10:39:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfK0Kjm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 05:39:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:54738 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727105AbfK0Kjk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 05:39:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 50CD1B286;
        Wed, 27 Nov 2019 10:39:38 +0000 (UTC)
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
Subject: [PATCH v2 rebase 13/34] powerpc/64s/exception: remove confusing IEARLY option
Date:   Wed, 27 Nov 2019 11:38:49 +0100
Message-Id: <600cea04cfa1744cc132d1ee9951a83592f9df94.1574803685.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1574803684.git.msuchanek@suse.de>
References: <cover.1574803684.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicholas Piggin <npiggin@gmail.com>

Replace IEARLY=1 and IEARLY=2 with IBRANCH_COMMON, which controls if
the entry code branches to a common handler; and IREALMODE_COMMON,
which controls whether the common handler should remain in real mode.

These special cases no longer avoid loading the SRR registers, there
is no point as most of them load the registers immediately anyway.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/exceptions-64s.S | 48 ++++++++++++++--------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 7db76e7be0aa..716a95ba814f 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -174,7 +174,8 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 #define IDAR		.L_IDAR_\name\()
 #define IDSISR		.L_IDSISR_\name\()
 #define ISET_RI		.L_ISET_RI_\name\()
-#define IEARLY		.L_IEARLY_\name\()
+#define IBRANCH_TO_COMMON	.L_IBRANCH_TO_COMMON_\name\()
+#define IREALMODE_COMMON	.L_IREALMODE_COMMON_\name\()
 #define IMASK		.L_IMASK_\name\()
 #define IKVM_SKIP	.L_IKVM_SKIP_\name\()
 #define IKVM_REAL	.L_IKVM_REAL_\name\()
@@ -218,8 +219,15 @@ do_define_int n
 	.ifndef ISET_RI
 		ISET_RI=1
 	.endif
-	.ifndef IEARLY
-		IEARLY=0
+	.ifndef IBRANCH_TO_COMMON
+		IBRANCH_TO_COMMON=1
+	.endif
+	.ifndef IREALMODE_COMMON
+		IREALMODE_COMMON=0
+	.else
+		.if ! IBRANCH_TO_COMMON
+			.error "IREALMODE_COMMON=1 but IBRANCH_TO_COMMON=0"
+		.endif
 	.endif
 	.ifndef IMASK
 		IMASK=0
@@ -353,6 +361,11 @@ END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,948)
  */
 
 .macro GEN_BRANCH_TO_COMMON name, virt
+	.if IREALMODE_COMMON
+	LOAD_HANDLER(r10, \name\()_common)
+	mtctr	r10
+	bctr
+	.else
 	.if \virt
 #ifndef CONFIG_RELOCATABLE
 	b	\name\()_common_virt
@@ -366,6 +379,7 @@ END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,948)
 	mtctr	r10
 	bctr
 	.endif
+	.endif
 .endm
 
 .macro GEN_INT_ENTRY name, virt, ool=0
@@ -421,11 +435,6 @@ END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,948)
 	stw	r10,IAREA+EX_DSISR(r13)
 	.endif
 
-	.if IEARLY == 2
-	/* nothing more */
-	.elseif IEARLY
-	BRANCH_TO_C000(r11, \name\()_common)
-	.else
 	.if IHSRR == EXC_HV_OR_STD
 	BEGIN_FTR_SECTION
 	mfspr	r11,SPRN_HSRR0		/* save HSRR0 */
@@ -441,6 +450,8 @@ END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,948)
 	mfspr	r11,SPRN_SRR0		/* save SRR0 */
 	mfspr	r12,SPRN_SRR1		/* and SRR1 */
 	.endif
+
+	.if IBRANCH_TO_COMMON
 	GEN_BRANCH_TO_COMMON \name \virt
 	.endif
 
@@ -926,6 +937,7 @@ INT_DEFINE_BEGIN(machine_check_early)
 	IVEC=0x200
 	IAREA=PACA_EXMC
 	IVIRT=0 /* no virt entry point */
+	IREALMODE_COMMON=1
 	/*
 	 * MSR_RI is not enabled, because PACA_EXMC is being used, so a
 	 * nested machine check corrupts it. machine_check_common enables
@@ -933,7 +945,6 @@ INT_DEFINE_BEGIN(machine_check_early)
 	 */
 	ISET_RI=0
 	ISTACK=0
-	IEARLY=1
 	IDAR=1
 	IDSISR=1
 	IRECONCILE=0
@@ -973,9 +984,6 @@ TRAMP_REAL_BEGIN(machine_check_fwnmi)
 	EXCEPTION_RESTORE_REGS EXC_STD
 
 EXC_COMMON_BEGIN(machine_check_early_common)
-	mfspr	r11,SPRN_SRR0
-	mfspr	r12,SPRN_SRR1
-
 	/*
 	 * Switch to mc_emergency stack and handle re-entrancy (we limit
 	 * the nested MCE upto level 4 to avoid stack overflow).
@@ -1822,7 +1830,7 @@ EXC_COMMON_BEGIN(emulation_assist_common)
 INT_DEFINE_BEGIN(hmi_exception_early)
 	IVEC=0xe60
 	IHSRR=EXC_HV
-	IEARLY=1
+	IREALMODE_COMMON=1
 	ISTACK=0
 	IRECONCILE=0
 	IKUAP=0 /* We don't touch AMR here, we never go to virtual mode */
@@ -1842,8 +1850,6 @@ EXC_REAL_END(hmi_exception, 0xe60, 0x20)
 EXC_VIRT_NONE(0x4e60, 0x20)
 
 EXC_COMMON_BEGIN(hmi_exception_early_common)
-	mfspr	r11,SPRN_HSRR0		/* Save HSRR0 */
-	mfspr	r12,SPRN_HSRR1		/* Save HSRR1 */
 	mr	r10,r1			/* Save r1 */
 	ld	r1,PACAEMERGSP(r13)	/* Use emergency stack for realmode */
 	subi	r1,r1,INT_FRAME_SIZE	/* alloc stack frame		*/
@@ -2169,29 +2175,23 @@ EXC_VIRT_NONE(0x5400, 0x100)
 INT_DEFINE_BEGIN(denorm_exception)
 	IVEC=0x1500
 	IHSRR=EXC_HV
-	IEARLY=2
+	IBRANCH_TO_COMMON=0
 	IKVM_REAL=1
 INT_DEFINE_END(denorm_exception)
 
 EXC_REAL_BEGIN(denorm_exception, 0x1500, 0x100)
 	GEN_INT_ENTRY denorm_exception, virt=0
 #ifdef CONFIG_PPC_DENORMALISATION
-	mfspr	r10,SPRN_HSRR1
-	andis.	r10,r10,(HSRR1_DENORM)@h /* denorm? */
+	andis.	r10,r12,(HSRR1_DENORM)@h /* denorm? */
 	bne+	denorm_assist
 #endif
-	mfspr	r11,SPRN_HSRR0
-	mfspr	r12,SPRN_HSRR1
 	GEN_BRANCH_TO_COMMON denorm_exception, virt=0
 EXC_REAL_END(denorm_exception, 0x1500, 0x100)
 #ifdef CONFIG_PPC_DENORMALISATION
 EXC_VIRT_BEGIN(denorm_exception, 0x5500, 0x100)
 	GEN_INT_ENTRY denorm_exception, virt=1
-	mfspr	r10,SPRN_HSRR1
-	andis.	r10,r10,(HSRR1_DENORM)@h /* denorm? */
+	andis.	r10,r12,(HSRR1_DENORM)@h /* denorm? */
 	bne+	denorm_assist
-	mfspr	r11,SPRN_HSRR0
-	mfspr	r12,SPRN_HSRR1
 	GEN_BRANCH_TO_COMMON denorm_exception, virt=1
 EXC_VIRT_END(denorm_exception, 0x5500, 0x100)
 #else
-- 
2.23.0

