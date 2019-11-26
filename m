Return-Path: <SRS0=8t7v=ZS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 472B7C432C0
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 20:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 155A82084B
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Nov 2019 20:16:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbfKZUOO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Nov 2019 15:14:14 -0500
Received: from mx2.suse.de ([195.135.220.15]:46022 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726033AbfKZUOL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Nov 2019 15:14:11 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 61FFCB12B;
        Tue, 26 Nov 2019 20:14:08 +0000 (UTC)
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
Subject: [PATCH v2 06/35] powerpc/64s/exception: Remove old INT_ENTRY macro
Date:   Tue, 26 Nov 2019 21:13:20 +0100
Message-Id: <baff592123801e2a0bb26daa0e2fc84cad6bb23c.1574798487.git.msuchanek@suse.de>
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

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/exceptions-64s.S | 68 ++++++++++++----------------
 1 file changed, 30 insertions(+), 38 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index b5decc9a0cbf..ba2dcd91aaaf 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -482,13 +482,13 @@ END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,948)
  * - Fall through and continue executing in real, unrelocated mode.
  *   This is done if early=2.
  */
-.macro INT_HANDLER name, vec, ool=0, early=0, virt=0, hsrr=0, area=PACA_EXGEN, ri=1, dar=0, dsisr=0, bitmask=0, kvm=0
+.macro GEN_INT_ENTRY name, virt, ool=0
 	SET_SCRATCH0(r13)			/* save r13 */
 	GET_PACA(r13)
-	std	r9,\area\()+EX_R9(r13)		/* save r9 */
+	std	r9,IAREA+EX_R9(r13)		/* save r9 */
 	OPT_GET_SPR(r9, SPRN_PPR, CPU_FTR_HAS_PPR)
 	HMT_MEDIUM
-	std	r10,\area\()+EX_R10(r13)	/* save r10 - r12 */
+	std	r10,IAREA+EX_R10(r13)		/* save r10 - r12 */
 	OPT_GET_SPR(r10, SPRN_CFAR, CPU_FTR_CFAR)
 	.if \ool
 	.if !\virt
@@ -502,47 +502,47 @@ END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,948)
 	.endif
 	.endif
 
-	OPT_SAVE_REG_TO_PACA(\area\()+EX_PPR, r9, CPU_FTR_HAS_PPR)
-	OPT_SAVE_REG_TO_PACA(\area\()+EX_CFAR, r10, CPU_FTR_CFAR)
+	OPT_SAVE_REG_TO_PACA(IAREA+EX_PPR, r9, CPU_FTR_HAS_PPR)
+	OPT_SAVE_REG_TO_PACA(IAREA+EX_CFAR, r10, CPU_FTR_CFAR)
 	INTERRUPT_TO_KERNEL
-	SAVE_CTR(r10, \area\())
+	SAVE_CTR(r10, IAREA)
 	mfcr	r9
-	.if \kvm
-		KVMTEST \name \hsrr \vec
+	.if (!\virt && IKVM_REAL) || (\virt && IKVM_VIRT)
+		KVMTEST \name IHSRR IVEC
 	.endif
-	.if \bitmask
+	.if IMASK
 		lbz	r10,PACAIRQSOFTMASK(r13)
-		andi.	r10,r10,\bitmask
+		andi.	r10,r10,IMASK
 		/* Associate vector numbers with bits in paca->irq_happened */
-		.if \vec == 0x500 || \vec == 0xea0
+		.if IVEC == 0x500 || IVEC == 0xea0
 		li	r10,PACA_IRQ_EE
-		.elseif \vec == 0x900
+		.elseif IVEC == 0x900
 		li	r10,PACA_IRQ_DEC
-		.elseif \vec == 0xa00 || \vec == 0xe80
+		.elseif IVEC == 0xa00 || IVEC == 0xe80
 		li	r10,PACA_IRQ_DBELL
-		.elseif \vec == 0xe60
+		.elseif IVEC == 0xe60
 		li	r10,PACA_IRQ_HMI
-		.elseif \vec == 0xf00
+		.elseif IVEC == 0xf00
 		li	r10,PACA_IRQ_PMI
 		.else
 		.abort "Bad maskable vector"
 		.endif
 
-		.if \hsrr == EXC_HV_OR_STD
+		.if IHSRR == EXC_HV_OR_STD
 		BEGIN_FTR_SECTION
 		bne	masked_Hinterrupt
 		FTR_SECTION_ELSE
 		bne	masked_interrupt
 		ALT_FTR_SECTION_END_IFSET(CPU_FTR_HVMODE | CPU_FTR_ARCH_206)
-		.elseif \hsrr
+		.elseif IHSRR
 		bne	masked_Hinterrupt
 		.else
 		bne	masked_interrupt
 		.endif
 	.endif
 
-	std	r11,\area\()+EX_R11(r13)
-	std	r12,\area\()+EX_R12(r13)
+	std	r11,IAREA+EX_R11(r13)
+	std	r12,IAREA+EX_R12(r13)
 
 	/*
 	 * DAR/DSISR, SCRATCH0 must be read before setting MSR[RI],
@@ -550,47 +550,39 @@ END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,948)
 	 * not recoverable if they are live.
 	 */
 	GET_SCRATCH0(r10)
-	std	r10,\area\()+EX_R13(r13)
-	.if \dar == 1
-	.if \hsrr
+	std	r10,IAREA+EX_R13(r13)
+	.if IDAR == 1
+	.if IHSRR
 	mfspr	r10,SPRN_HDAR
 	.else
 	mfspr	r10,SPRN_DAR
 	.endif
-	std	r10,\area\()+EX_DAR(r13)
+	std	r10,IAREA+EX_DAR(r13)
 	.endif
-	.if \dsisr == 1
-	.if \hsrr
+	.if IDSISR == 1
+	.if IHSRR
 	mfspr	r10,SPRN_HDSISR
 	.else
 	mfspr	r10,SPRN_DSISR
 	.endif
-	stw	r10,\area\()+EX_DSISR(r13)
+	stw	r10,IAREA+EX_DSISR(r13)
 	.endif
 
-	.if \early == 2
+	.if IEARLY == 2
 	/* nothing more */
-	.elseif \early
+	.elseif IEARLY
 	mfctr	r10			/* save ctr, even for !RELOCATABLE */
 	BRANCH_TO_C000(r11, \name\()_common)
 	.elseif !\virt
-	INT_SAVE_SRR_AND_JUMP \name\()_common, \hsrr, \ri
+	INT_SAVE_SRR_AND_JUMP \name\()_common, IHSRR, ISET_RI
 	.else
-	INT_VIRT_SAVE_SRR_AND_JUMP \name\()_common, \hsrr
+	INT_VIRT_SAVE_SRR_AND_JUMP \name\()_common, IHSRR
 	.endif
 	.if \ool
 	.popsection
 	.endif
 .endm
 
-.macro GEN_INT_ENTRY name, virt, ool=0
-	.if ! \virt
-		INT_HANDLER \name, IVEC, \ool, IEARLY, \virt, IHSRR, IAREA, ISET_RI, IDAR, IDSISR, IMASK, IKVM_REAL
-	.else
-		INT_HANDLER \name, IVEC, \ool, IEARLY, \virt, IHSRR, IAREA, ISET_RI, IDAR, IDSISR, IMASK, IKVM_VIRT
-	.endif
-.endm
-
 /*
  * On entry r13 points to the paca, r9-r13 are saved in the paca,
  * r9 contains the saved CR, r11 and r12 contain the saved SRR0 and
-- 
2.23.0

