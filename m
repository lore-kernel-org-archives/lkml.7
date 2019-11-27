Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03FACC432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 10:39:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBBC62070A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 10:39:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfK0KjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 05:39:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:54524 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726204AbfK0KjV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 05:39:21 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A6830B31C;
        Wed, 27 Nov 2019 10:39:19 +0000 (UTC)
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
Subject: [PATCH v2 rebase 01/34] powerpc/64s/exception: Introduce INT_DEFINE parameter block for code generation
Date:   Wed, 27 Nov 2019 11:38:37 +0100
Message-Id: <1183b3557ef23d7b8d00243f0b828e47ba40a013.1574803684.git.msuchanek@suse.de>
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

The code generation macro arguments are difficult to read, and
defaults can't easily be used.

This introduces a block where parameters can be set for interrupt
handler code generation by the subsequent macros, and adds the first
generation macro for interrupt entry.

One interrupt handler is converted to the new macros to demonstrate
the change, the rest will be coverted all at once.

No generated code change.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/exceptions-64s.S | 77 ++++++++++++++++++++++++++--
 1 file changed, 73 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 46508b148e16..0be6d8c34536 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -193,6 +193,61 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 	mtctr	reg;							\
 	bctr
 
+/*
+ * Interrupt code generation macros
+ */
+#define IVEC		.L_IVEC_\name\()
+#define IHSRR		.L_IHSRR_\name\()
+#define IAREA		.L_IAREA_\name\()
+#define IDAR		.L_IDAR_\name\()
+#define IDSISR		.L_IDSISR_\name\()
+#define ISET_RI		.L_ISET_RI_\name\()
+#define IEARLY		.L_IEARLY_\name\()
+#define IMASK		.L_IMASK_\name\()
+#define IKVM_REAL	.L_IKVM_REAL_\name\()
+#define IKVM_VIRT	.L_IKVM_VIRT_\name\()
+
+#define INT_DEFINE_BEGIN(n)						\
+.macro int_define_ ## n name
+
+#define INT_DEFINE_END(n)						\
+.endm ;									\
+int_define_ ## n n ;							\
+do_define_int n
+
+.macro do_define_int name
+	.ifndef IVEC
+		.error "IVEC not defined"
+	.endif
+	.ifndef IHSRR
+		IHSRR=EXC_STD
+	.endif
+	.ifndef IAREA
+		IAREA=PACA_EXGEN
+	.endif
+	.ifndef IDAR
+		IDAR=0
+	.endif
+	.ifndef IDSISR
+		IDSISR=0
+	.endif
+	.ifndef ISET_RI
+		ISET_RI=1
+	.endif
+	.ifndef IEARLY
+		IEARLY=0
+	.endif
+	.ifndef IMASK
+		IMASK=0
+	.endif
+	.ifndef IKVM_REAL
+		IKVM_REAL=0
+	.endif
+	.ifndef IKVM_VIRT
+		IKVM_VIRT=0
+	.endif
+.endm
+
 .macro INT_KVM_HANDLER name, vec, hsrr, area, skip
 	TRAMP_KVM_BEGIN(\name\()_kvm)
 	KVM_HANDLER \vec, \hsrr, \area, \skip
@@ -474,7 +529,7 @@ END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,948)
 	 */
 	GET_SCRATCH0(r10)
 	std	r10,\area\()+EX_R13(r13)
-	.if \dar
+	.if \dar == 1
 	.if \hsrr
 	mfspr	r10,SPRN_HDAR
 	.else
@@ -482,7 +537,7 @@ END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,948)
 	.endif
 	std	r10,\area\()+EX_DAR(r13)
 	.endif
-	.if \dsisr
+	.if \dsisr == 1
 	.if \hsrr
 	mfspr	r10,SPRN_HDSISR
 	.else
@@ -506,6 +561,14 @@ END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,948)
 	.endif
 .endm
 
+.macro GEN_INT_ENTRY name, virt, ool=0
+	.if ! \virt
+		INT_HANDLER \name, IVEC, \ool, IEARLY, \virt, IHSRR, IAREA, ISET_RI, IDAR, IDSISR, IMASK, IKVM_REAL
+	.else
+		INT_HANDLER \name, IVEC, \ool, IEARLY, \virt, IHSRR, IAREA, ISET_RI, IDAR, IDSISR, IMASK, IKVM_VIRT
+	.endif
+.endm
+
 /*
  * On entry r13 points to the paca, r9-r13 are saved in the paca,
  * r9 contains the saved CR, r11 and r12 contain the saved SRR0 and
@@ -1143,12 +1206,18 @@ END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
 	bl	unrecoverable_exception
 	b	.
 
+INT_DEFINE_BEGIN(data_access)
+	IVEC=0x300
+	IDAR=1
+	IDSISR=1
+	IKVM_REAL=1
+INT_DEFINE_END(data_access)
 
 EXC_REAL_BEGIN(data_access, 0x300, 0x80)
-	INT_HANDLER data_access, 0x300, ool=1, dar=1, dsisr=1, kvm=1
+	GEN_INT_ENTRY data_access, virt=0, ool=1
 EXC_REAL_END(data_access, 0x300, 0x80)
 EXC_VIRT_BEGIN(data_access, 0x4300, 0x80)
-	INT_HANDLER data_access, 0x300, virt=1, dar=1, dsisr=1
+	GEN_INT_ENTRY data_access, virt=1
 EXC_VIRT_END(data_access, 0x4300, 0x80)
 INT_KVM_HANDLER data_access, 0x300, EXC_STD, PACA_EXGEN, 1
 EXC_COMMON_BEGIN(data_access_common)
-- 
2.23.0

