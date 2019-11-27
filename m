Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8036C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:21:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B80D2154A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574889703;
	bh=nfS1Bvz/Gc6ID7OsOKV+BI/hrTRDWNcVHNNvsdEfMWI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ldv/lKh0qpybCh8wwfZKBKytk1/BckNOFehTGd8/BQnrpkcp8uRyC8sugtywxy1OC
	 Rm3M0sodQ3SXCSvzaiiF5cT/jeJnYhb6yi1yCKf2L9kdvhBc6Rm/C9qSenKijlGc68
	 bJQ/ulnafUX0CD/Lx0jBK22Gj8Mp2eMn78xv1v3Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730860AbfK0VVm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 16:21:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:32834 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731750AbfK0VGw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 16:06:52 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD5462086A;
        Wed, 27 Nov 2019 21:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574888812;
        bh=nfS1Bvz/Gc6ID7OsOKV+BI/hrTRDWNcVHNNvsdEfMWI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xXWDDGOaVN6OqHSF3xjcsmZmpHp/I6syUppfUuAS05+mkoIcbJDeLKeoEsBzLPxEA
         QFQ1a4+Z+UWUWvnzFEW7e0buhy5vnMNLJ73eOJj/DYj3igovFVokxE1jfVoJu13vlu
         zdjjSrq9HLqpN4KKMH0I4RVjF+ubBq2096CVyn2E=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>
Subject: [PATCH 4.19 277/306] x86/entry/32: Fix FIXUP_ESPFIX_STACK with user CR3
Date:   Wed, 27 Nov 2019 21:32:07 +0100
Message-Id: <20191127203135.043436214@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127203114.766709977@linuxfoundation.org>
References: <20191127203114.766709977@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andy Lutomirski <luto@kernel.org>

commit 4a13b0e3e10996b9aa0b45a764ecfe49f6fcd360 upstream.

UNWIND_ESPFIX_STACK needs to read the GDT, and the GDT mapping that
can be accessed via %fs is not mapped in the user pagetables.  Use
SGDT to find the cpu_entry_area mapping and read the espfix offset
from that instead.

Reported-and-tested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/entry/entry_32.S |   21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

--- a/arch/x86/entry/entry_32.S
+++ b/arch/x86/entry/entry_32.S
@@ -315,7 +315,8 @@
 
 .macro CHECK_AND_APPLY_ESPFIX
 #ifdef CONFIG_X86_ESPFIX32
-#define GDT_ESPFIX_SS PER_CPU_VAR(gdt_page) + (GDT_ENTRY_ESPFIX_SS * 8)
+#define GDT_ESPFIX_OFFSET (GDT_ENTRY_ESPFIX_SS * 8)
+#define GDT_ESPFIX_SS PER_CPU_VAR(gdt_page) + GDT_ESPFIX_OFFSET
 
 	ALTERNATIVE	"jmp .Lend_\@", "", X86_BUG_ESPFIX
 
@@ -1056,12 +1057,26 @@ ENDPROC(entry_INT80_32)
  * We can't call C functions using the ESPFIX stack. This code reads
  * the high word of the segment base from the GDT and swiches to the
  * normal stack and adjusts ESP with the matching offset.
+ *
+ * We might be on user CR3 here, so percpu data is not mapped and we can't
+ * access the GDT through the percpu segment.  Instead, use SGDT to find
+ * the cpu_entry_area alias of the GDT.
  */
 #ifdef CONFIG_X86_ESPFIX32
 	/* fixup the stack */
-	mov	GDT_ESPFIX_SS + 4, %al /* bits 16..23 */
-	mov	GDT_ESPFIX_SS + 7, %ah /* bits 24..31 */
+	pushl	%ecx
+	subl	$2*4, %esp
+	sgdt	(%esp)
+	movl	2(%esp), %ecx				/* GDT address */
+	/*
+	 * Careful: ECX is a linear pointer, so we need to force base
+	 * zero.  %cs is the only known-linear segment we have right now.
+	 */
+	mov	%cs:GDT_ESPFIX_OFFSET + 4(%ecx), %al	/* bits 16..23 */
+	mov	%cs:GDT_ESPFIX_OFFSET + 7(%ecx), %ah	/* bits 24..31 */
 	shl	$16, %eax
+	addl	$2*4, %esp
+	popl	%ecx
 	addl	%esp, %eax			/* the adjusted stack pointer */
 	pushl	$__KERNEL_DS
 	pushl	%eax


