Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77831C432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 10:39:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 557FC2070A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 10:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbfK0Kjs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 05:39:48 -0500
Received: from mx2.suse.de ([195.135.220.15]:55420 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727125AbfK0Kjo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 05:39:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id DD472B46D;
        Wed, 27 Nov 2019 10:39:42 +0000 (UTC)
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
Subject: [PATCH v2 rebase 16/34] powerpc/64s/exception: hdecrementer avoid touching the stack
Date:   Wed, 27 Nov 2019 11:38:52 +0100
Message-Id: <f7cee9fed0cb7a81c75bea283b031b13fb66c592.1574803685.git.msuchanek@suse.de>
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

The hdec interrupt handler is reported to sometimes fire in Linux if
KVM leaves it pending after a guest exists. This is harmless, so there
is a no-op handler for it.

The interrupt handler currently uses the regular kernel stack. Change
this to avoid touching the stack entirely.

This should be the last place where the regular Linux stack can be
accessed with asynchronous interrupts (including PMI) soft-masked.
It might be possible to take advantage of this invariant, e.g., to
context switch the kernel stack SLB entry without clearing MSR[EE].

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/time.h      |  1 -
 arch/powerpc/kernel/exceptions-64s.S | 25 ++++++++++++++++++++-----
 arch/powerpc/kernel/time.c           |  9 ---------
 3 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/include/asm/time.h b/arch/powerpc/include/asm/time.h
index 08dbe3e6831c..e0107495c4de 100644
--- a/arch/powerpc/include/asm/time.h
+++ b/arch/powerpc/include/asm/time.h
@@ -24,7 +24,6 @@ extern struct clock_event_device decrementer_clockevent;
 
 
 extern void generic_calibrate_decr(void);
-extern void hdec_interrupt(struct pt_regs *regs);
 
 /* Some sane defaults: 125 MHz timebase, 1GHz processor */
 extern unsigned long ppc_proc_freq;
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 9fa71d51ecf4..7a234e6d7bf5 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1491,6 +1491,8 @@ EXC_COMMON_BEGIN(decrementer_common)
 INT_DEFINE_BEGIN(hdecrementer)
 	IVEC=0x980
 	IHSRR=EXC_HV
+	ISTACK=0
+	IRECONCILE=0
 	IKVM_REAL=1
 	IKVM_VIRT=1
 INT_DEFINE_END(hdecrementer)
@@ -1502,11 +1504,24 @@ EXC_VIRT_BEGIN(hdecrementer, 0x4980, 0x80)
 	GEN_INT_ENTRY hdecrementer, virt=1
 EXC_VIRT_END(hdecrementer, 0x4980, 0x80)
 EXC_COMMON_BEGIN(hdecrementer_common)
-	GEN_COMMON hdecrementer
-	bl	save_nvgprs
-	addi	r3,r1,STACK_FRAME_OVERHEAD
-	bl	hdec_interrupt
-	b	ret_from_except
+	__GEN_COMMON_ENTRY hdecrementer
+	/*
+	 * Hypervisor decrementer interrupts not caught by the KVM test
+	 * shouldn't occur but are sometimes left pending on exit from a KVM
+	 * guest.  We don't need to do anything to clear them, as they are
+	 * edge-triggered.
+	 *
+	 * Be careful to avoid touching the kernel stack.
+	 */
+	ld	r10,PACA_EXGEN+EX_CTR(r13)
+	mtctr	r10
+	mtcrf	0x80,r9
+	ld	r9,PACA_EXGEN+EX_R9(r13)
+	ld	r10,PACA_EXGEN+EX_R10(r13)
+	ld	r11,PACA_EXGEN+EX_R11(r13)
+	ld	r12,PACA_EXGEN+EX_R12(r13)
+	ld	r13,PACA_EXGEN+EX_R13(r13)
+	HRFI_TO_KERNEL
 
 	GEN_KVM hdecrementer
 
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 968ae97382b4..e4572d67cc76 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -663,15 +663,6 @@ void timer_broadcast_interrupt(void)
 }
 #endif
 
-/*
- * Hypervisor decrementer interrupts shouldn't occur but are sometimes
- * left pending on exit from a KVM guest.  We don't need to do anything
- * to clear them, as they are edge-triggered.
- */
-void hdec_interrupt(struct pt_regs *regs)
-{
-}
-
 #ifdef CONFIG_SUSPEND
 static void generic_suspend_disable_irqs(void)
 {
-- 
2.23.0

