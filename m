Return-Path: <SRS0=G/Om=ZT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F57C432C3
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:13:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDE6D2086A
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Nov 2019 21:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574889213;
	bh=u8OllIDv3yRMJ9j8X65aPhaHYNuwoOxjnb0WOQlmxDU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KX7SgROXefHa3RkE2rYo/ShPBKxYsM0xt8kC1kpVj5V8453qjphfMXRHNUaGKHG7p
	 qlEaSmF0iS0zWIxNa1U7/yYelg01cPHT/z1/32feBuji/Vh+QZli986ZhitP/QlA6V
	 LU3KsZDn/3sg02uVb6Zp2Gv7SezMnjp5v+dG4+Vo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732980AbfK0VNc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Nov 2019 16:13:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:45562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387440AbfK0VNX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Nov 2019 16:13:23 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5A6002154A;
        Wed, 27 Nov 2019 21:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574889202;
        bh=u8OllIDv3yRMJ9j8X65aPhaHYNuwoOxjnb0WOQlmxDU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x1yogHmrei2qR6zuApIZslt9uz7D4cHr6yEVOPvzfBxWcWLVSpcuyndLikDzQFlhH
         cjDEfRrTdUpytVQ0NU8ZpVKFuzW96slaXrebzzStgGKp+7BkL6lwfcEPJeIhkKVT2M
         y6b741pnM+suQEOlAC8AfTpPYJKPnSvdVZTmpijg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>
Subject: [PATCH 5.4 27/66] x86/entry/32: Fix FIXUP_ESPFIX_STACK with user CR3
Date:   Wed, 27 Nov 2019 21:32:22 +0100
Message-Id: <20191127202659.813744898@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191127202632.536277063@linuxfoundation.org>
References: <20191127202632.536277063@linuxfoundation.org>
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
@@ -415,7 +415,8 @@
 
 .macro CHECK_AND_APPLY_ESPFIX
 #ifdef CONFIG_X86_ESPFIX32
-#define GDT_ESPFIX_SS PER_CPU_VAR(gdt_page) + (GDT_ENTRY_ESPFIX_SS * 8)
+#define GDT_ESPFIX_OFFSET (GDT_ENTRY_ESPFIX_SS * 8)
+#define GDT_ESPFIX_SS PER_CPU_VAR(gdt_page) + GDT_ESPFIX_OFFSET
 
 	ALTERNATIVE	"jmp .Lend_\@", "", X86_BUG_ESPFIX
 
@@ -1147,12 +1148,26 @@ ENDPROC(entry_INT80_32)
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


