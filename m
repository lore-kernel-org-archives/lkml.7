Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6ECDC7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 21:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 909902145D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 21:25:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="HLU4n9Oo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbfGQVZL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 17:25:11 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47769 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727106AbfGQVZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 17:25:11 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6HLOTqG1695596
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 17 Jul 2019 14:24:29 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6HLOTqG1695596
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563398670;
        bh=SQHpuDf8cR6chiT2CewpSIM0+r0chrhuO4zppzGcQ5w=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=HLU4n9OoFSMpU99+eQPgILGx4SDdHM+AcqXkubYMF7Z1Muq3AxRePB/diqBYc50BT
         LAfP4Qt8X4IUlwM7VE31hs2q1yixAGrgkxQxepvpotC3Sd8bLy3UtUR9DDBzcM1iyb
         rAsJO9vnr+eCQQTCJ56cB6xgj9CU8WhWLs7kXbVxkFgztEFstEar1OvNABSacyZWFr
         ICBNOt62X6EJ4hnkzmu8z5olMvc8qtPqYq7iThmOGjpKTv0vdzqlyTTvYTQ8uGjhFp
         IKjgap39tTrVacEYfFZ4SU229S8BOU+lABp3XE2qnSwzdHHEjqKajAMxvEyIo3/v7W
         Ghirn6Wqa9daw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6HLOS961695588;
        Wed, 17 Jul 2019 14:24:28 -0700
Date:   Wed, 17 Jul 2019 14:24:28 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Peter Zijlstra <tipbot@zytor.com>
Message-ID: <tip-2fd37912cfb019228bf246215938e6f7619516a2@git.kernel.org>
Cc:     tglx@linutronix.de, rostedt@goodmis.org, luto@kernel.org,
        hpa@zytor.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org
Reply-To: mingo@kernel.org, peterz@infradead.org,
          linux-kernel@vger.kernel.org, tglx@linutronix.de,
          rostedt@goodmis.org, luto@kernel.org, hpa@zytor.com
In-Reply-To: <20190711114336.002429503@infradead.org>
References: <20190711114336.002429503@infradead.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/entry/64: Simplify idtentry a little
Git-Commit-ID: 2fd37912cfb019228bf246215938e6f7619516a2
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  2fd37912cfb019228bf246215938e6f7619516a2
Gitweb:     https://git.kernel.org/tip/2fd37912cfb019228bf246215938e6f7619516a2
Author:     Peter Zijlstra <peterz@infradead.org>
AuthorDate: Thu, 11 Jul 2019 13:40:57 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 17 Jul 2019 23:17:37 +0200

x86/entry/64: Simplify idtentry a little

There's a bunch of duplication in idtentry, namely the
.Lfrom_usermode_switch_stack is a paranoid=0 copy of the normal flow.

Make this explicit by creating a idtentry_part helper macro.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Acked-by: Andy Lutomirski <luto@kernel.org>
Cc: bp@alien8.de
Cc: torvalds@linux-foundation.org
Cc: hpa@zytor.com
Cc: dave.hansen@linux.intel.com
Cc: jgross@suse.com
Cc: zhe.he@windriver.com
Cc: joel@joelfernandes.org
Cc: devel@etsukata.com
Link: https://lkml.kernel.org/r/20190711114336.002429503@infradead.org

---
 arch/x86/entry/entry_64.S | 102 ++++++++++++++++++++++------------------------
 1 file changed, 48 insertions(+), 54 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 0ea4831a72a4..3db5fede743b 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -864,6 +864,52 @@ apicinterrupt IRQ_WORK_VECTOR			irq_work_interrupt		smp_irq_work_interrupt
  */
 #define CPU_TSS_IST(x) PER_CPU_VAR(cpu_tss_rw) + (TSS_ist + (x) * 8)
 
+.macro idtentry_part do_sym, has_error_code:req, paranoid:req, shift_ist=-1, ist_offset=0
+
+	.if \paranoid
+	call	paranoid_entry
+	/* returned flag: ebx=0: need swapgs on exit, ebx=1: don't need it */
+	.else
+	call	error_entry
+	.endif
+	UNWIND_HINT_REGS
+
+	.if \paranoid
+	.if \shift_ist != -1
+	TRACE_IRQS_OFF_DEBUG			/* reload IDT in case of recursion */
+	.else
+	TRACE_IRQS_OFF
+	.endif
+	.endif
+
+	movq	%rsp, %rdi			/* pt_regs pointer */
+
+	.if \has_error_code
+	movq	ORIG_RAX(%rsp), %rsi		/* get error code */
+	movq	$-1, ORIG_RAX(%rsp)		/* no syscall to restart */
+	.else
+	xorl	%esi, %esi			/* no error code */
+	.endif
+
+	.if \shift_ist != -1
+	subq	$\ist_offset, CPU_TSS_IST(\shift_ist)
+	.endif
+
+	call	\do_sym
+
+	.if \shift_ist != -1
+	addq	$\ist_offset, CPU_TSS_IST(\shift_ist)
+	.endif
+
+	.if \paranoid
+	/* this procedure expect "no swapgs" flag in ebx */
+	jmp	paranoid_exit
+	.else
+	jmp	error_exit
+	.endif
+
+.endm
+
 /**
  * idtentry - Generate an IDT entry stub
  * @sym:		Name of the generated entry point
@@ -934,47 +980,7 @@ ENTRY(\sym)
 .Lfrom_usermode_no_gap_\@:
 	.endif
 
-	.if \paranoid
-	call	paranoid_entry
-	.else
-	call	error_entry
-	.endif
-	UNWIND_HINT_REGS
-	/* returned flag: ebx=0: need swapgs on exit, ebx=1: don't need it */
-
-	.if \paranoid
-	.if \shift_ist != -1
-	TRACE_IRQS_OFF_DEBUG			/* reload IDT in case of recursion */
-	.else
-	TRACE_IRQS_OFF
-	.endif
-	.endif
-
-	movq	%rsp, %rdi			/* pt_regs pointer */
-
-	.if \has_error_code
-	movq	ORIG_RAX(%rsp), %rsi		/* get error code */
-	movq	$-1, ORIG_RAX(%rsp)		/* no syscall to restart */
-	.else
-	xorl	%esi, %esi			/* no error code */
-	.endif
-
-	.if \shift_ist != -1
-	subq	$\ist_offset, CPU_TSS_IST(\shift_ist)
-	.endif
-
-	call	\do_sym
-
-	.if \shift_ist != -1
-	addq	$\ist_offset, CPU_TSS_IST(\shift_ist)
-	.endif
-
-	/* these procedures expect "no swapgs" flag in ebx */
-	.if \paranoid
-	jmp	paranoid_exit
-	.else
-	jmp	error_exit
-	.endif
+	idtentry_part \do_sym, \has_error_code, \paranoid, \shift_ist, \ist_offset
 
 	.if \paranoid == 1
 	/*
@@ -983,21 +989,9 @@ ENTRY(\sym)
 	 * run in real process context if user_mode(regs).
 	 */
 .Lfrom_usermode_switch_stack_\@:
-	call	error_entry
-
-	movq	%rsp, %rdi			/* pt_regs pointer */
-
-	.if \has_error_code
-	movq	ORIG_RAX(%rsp), %rsi		/* get error code */
-	movq	$-1, ORIG_RAX(%rsp)		/* no syscall to restart */
-	.else
-	xorl	%esi, %esi			/* no error code */
+	idtentry_part \do_sym, \has_error_code, paranoid=0
 	.endif
 
-	call	\do_sym
-
-	jmp	error_exit
-	.endif
 _ASM_NOKPROBE(\sym)
 END(\sym)
 .endm
