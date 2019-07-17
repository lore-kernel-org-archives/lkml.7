Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F6EC7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 21:24:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA0AD2145D
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 21:24:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="ma+2um0M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728678AbfGQVY1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 17:24:27 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59447 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727205AbfGQVY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 17:24:26 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6HLNgmT1693733
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 17 Jul 2019 14:23:43 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6HLNgmT1693733
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563398623;
        bh=JsLVdgiLrC3UtF7lcpHUdpYtgT4oCkmIPUd7SCHWWsw=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=ma+2um0MN4MGIPOISijpjdlsofwE6h9N1fu7SRnKsAItfyeGhwwLlU1Tm8gUrpWNT
         l60NalbPwUucsDV+vwwXFSNVB48Q10ghykxZZBMZw3gUXjGth8uotypPNcT51CtgOG
         wSUiffdjZCXXq5lrZtg18soO3Oq799kzpjtEHTbqrBBP2ah91Khor9VbdbDeCheR2J
         IIT/4l0jDRnxvTnWdtCtPE0dIaJmBHOjQZgmO+nywnL5NCItRKBgmFKrrqSJH16+BM
         nLrmeKEKSz+s6VJR5wAvSuyRuy1MzK4r49tAVw6U7zK4nOK0UvPT4Pjkx9iHNYcRdQ
         +Mfo10T+ujPTQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6HLNgr51693730;
        Wed, 17 Jul 2019 14:23:42 -0700
Date:   Wed, 17 Jul 2019 14:23:42 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Peter Zijlstra <tipbot@zytor.com>
Message-ID: <tip-e67f1c11e5ea7fa47449a16325ecc997dbbf9bdf@git.kernel.org>
Cc:     mingo@kernel.org, luto@kernel.org, rostedt@goodmis.org,
        peterz@infradead.org, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, hpa@zytor.com
Reply-To: rostedt@goodmis.org, peterz@infradead.org, luto@kernel.org,
          mingo@kernel.org, hpa@zytor.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org
In-Reply-To: <20190711114335.945136187@infradead.org>
References: <20190711114335.945136187@infradead.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/entry/32: Simplify common_exception
Git-Commit-ID: e67f1c11e5ea7fa47449a16325ecc997dbbf9bdf
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

Commit-ID:  e67f1c11e5ea7fa47449a16325ecc997dbbf9bdf
Gitweb:     https://git.kernel.org/tip/e67f1c11e5ea7fa47449a16325ecc997dbbf9bdf
Author:     Peter Zijlstra <peterz@infradead.org>
AuthorDate: Thu, 11 Jul 2019 13:40:56 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 17 Jul 2019 23:17:37 +0200

x86/entry/32: Simplify common_exception

Adding one more option to SAVE_ALL can be used in common_exception to
simplify things. This also saves duplication later where page_fault will no
longer use common_exception.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
Cc: bp@alien8.de
Cc: torvalds@linux-foundation.org
Cc: hpa@zytor.com
Cc: dave.hansen@linux.intel.com
Cc: jgross@suse.com
Cc: zhe.he@windriver.com
Cc: joel@joelfernandes.org
Cc: devel@etsukata.com
Link: https://lkml.kernel.org/r/20190711114335.945136187@infradead.org

---
 arch/x86/entry/entry_32.S | 36 +++++++++++++-----------------------
 1 file changed, 13 insertions(+), 23 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 90b473297299..4d4b6100f0e8 100644
--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -294,9 +294,11 @@
 .Lfinished_frame_\@:
 .endm
 
-.macro SAVE_ALL pt_regs_ax=%eax switch_stacks=0
+.macro SAVE_ALL pt_regs_ax=%eax switch_stacks=0 skip_gs=0
 	cld
+.if \skip_gs == 0
 	PUSH_GS
+.endif
 	FIXUP_FRAME
 	pushl	%fs
 	pushl	%es
@@ -313,13 +315,13 @@
 	movl	%edx, %es
 	movl	$(__KERNEL_PERCPU), %edx
 	movl	%edx, %fs
+.if \skip_gs == 0
 	SET_KERNEL_GS %edx
-
+.endif
 	/* Switch to kernel stack if necessary */
 .if \switch_stacks > 0
 	SWITCH_TO_KERNEL_STACK
 .endif
-
 .endm
 
 .macro SAVE_ALL_NMI cr3_reg:req
@@ -1448,32 +1450,20 @@ END(page_fault)
 
 common_exception:
 	/* the function address is in %gs's slot on the stack */
-	FIXUP_FRAME
-	pushl	%fs
-	pushl	%es
-	pushl	%ds
-	pushl	%eax
-	movl	$(__USER_DS), %eax
-	movl	%eax, %ds
-	movl	%eax, %es
-	movl	$(__KERNEL_PERCPU), %eax
-	movl	%eax, %fs
-	pushl	%ebp
-	pushl	%edi
-	pushl	%esi
-	pushl	%edx
-	pushl	%ecx
-	pushl	%ebx
-	SWITCH_TO_KERNEL_STACK
+	SAVE_ALL switch_stacks=1 skip_gs=1
 	ENCODE_FRAME_POINTER
-	cld
 	UNWIND_ESPFIX_STACK
+
+	/* fixup %gs */
 	GS_TO_REG %ecx
 	movl	PT_GS(%esp), %edi		# get the function address
-	movl	PT_ORIG_EAX(%esp), %edx		# get the error code
-	movl	$-1, PT_ORIG_EAX(%esp)		# no syscall to restart
 	REG_TO_PTGS %ecx
 	SET_KERNEL_GS %ecx
+
+	/* fixup orig %eax */
+	movl	PT_ORIG_EAX(%esp), %edx		# get the error code
+	movl	$-1, PT_ORIG_EAX(%esp)		# no syscall to restart
+
 	TRACE_IRQS_OFF
 	movl	%esp, %eax			# pt_regs pointer
 	CALL_NOSPEC %edi
