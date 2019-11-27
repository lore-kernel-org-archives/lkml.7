Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF53BC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 10:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7FA42071E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 10:40:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbfK0Kkh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 05:40:37 -0500
Received: from mx2.suse.de ([195.135.220.15]:56444 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727187AbfK0Kj6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 05:39:58 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B0279B473;
        Wed, 27 Nov 2019 10:39:56 +0000 (UTC)
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
Subject: [PATCH v2 rebase 25/34] powerpc/64s/exception: remove lite interrupt return
Date:   Wed, 27 Nov 2019 11:39:01 +0100
Message-Id: <b9834e87b23de901af0557bfc012df0e231e170f.1574803685.git.msuchanek@suse.de>
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

The difference between lite and regular returns is that the lite case
restores all NVGPRs, whereas lite skips that. This is quite clumsy
though, most interrupts want the NVGPRs saved for debugging, not to
modify in the caller, so the NVGPRs restore is not necessary most of
the time. Restore NVGPRs explicitly for one case that requires it,
and move everything else over to avoiding the restore unless the
interrupt return demands it (e.g., handling a signal).

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/entry_64.S       |  4 ----
 arch/powerpc/kernel/exceptions-64s.S | 21 +++++++++++----------
 2 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index b2e68f5ca8f7..00173cc904ef 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -452,10 +452,6 @@ _GLOBAL(fast_interrupt_return)
 
 	.balign IFETCH_ALIGN_BYTES
 _GLOBAL(interrupt_return)
-	REST_NVGPRS(r1)
-
-	.balign IFETCH_ALIGN_BYTES
-_GLOBAL(interrupt_return_lite)
 	ld	r4,_MSR(r1)
 	andi.	r0,r4,MSR_PR
 	beq	kernel_interrupt_return
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 269edd1460be..1bccc869ebd3 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1507,7 +1507,7 @@ EXC_COMMON_BEGIN(hardware_interrupt_common)
 	RUNLATCH_ON
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	do_IRQ
-	b	interrupt_return_lite
+	b	interrupt_return
 
 	GEN_KVM hardware_interrupt
 
@@ -1694,7 +1694,7 @@ EXC_COMMON_BEGIN(decrementer_common)
 	RUNLATCH_ON
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	timer_interrupt
-	b	interrupt_return_lite
+	b	interrupt_return
 
 	GEN_KVM decrementer
 
@@ -1785,7 +1785,7 @@ EXC_COMMON_BEGIN(doorbell_super_common)
 #else
 	bl	unknown_exception
 #endif
-	b	interrupt_return_lite
+	b	interrupt_return
 
 	GEN_KVM doorbell_super
 
@@ -2183,7 +2183,7 @@ EXC_COMMON_BEGIN(h_doorbell_common)
 #else
 	bl	unknown_exception
 #endif
-	b	interrupt_return_lite
+	b	interrupt_return
 
 	GEN_KVM h_doorbell
 
@@ -2213,7 +2213,7 @@ EXC_COMMON_BEGIN(h_virt_irq_common)
 	RUNLATCH_ON
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	do_IRQ
-	b	interrupt_return_lite
+	b	interrupt_return
 
 	GEN_KVM h_virt_irq
 
@@ -2260,7 +2260,7 @@ EXC_COMMON_BEGIN(performance_monitor_common)
 	RUNLATCH_ON
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	performance_monitor_exception
-	b	interrupt_return_lite
+	b	interrupt_return
 
 	GEN_KVM performance_monitor
 
@@ -3013,7 +3013,7 @@ do_hash_page:
         cmpdi	r3,0			/* see if __hash_page succeeded */
 
 	/* Success */
-	beq	interrupt_return_lite	/* Return from exception on success */
+	beq	interrupt_return	/* Return from exception on success */
 
 	/* Error */
 	blt-	13f
@@ -3027,10 +3027,11 @@ do_hash_page:
 handle_page_fault:
 11:	andis.  r0,r5,DSISR_DABRMATCH@h
 	bne-    handle_dabr_fault
+	bl	save_nvgprs
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	do_page_fault
 	cmpdi	r3,0
-	beq+	interrupt_return_lite
+	beq+	interrupt_return
 	mr	r5,r3
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	ld	r4,_DAR(r1)
@@ -3045,9 +3046,9 @@ handle_dabr_fault:
 	bl      do_break
 	/*
 	 * do_break() may have changed the NV GPRS while handling a breakpoint.
-	 * If so, we need to restore them with their updated values. Don't use
-	 * interrupt_return_lite here.
+	 * If so, we need to restore them with their updated values.
 	 */
+	REST_NVGPRS(r1)
 	b       interrupt_return
 
 
-- 
2.23.0

