Return-Path: <SRS0=xe0T=ZQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DBF0C432C0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 18:31:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D293207DD
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Nov 2019 18:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574620269;
	bh=eqAsjzVaq3nzz88L4tDGzUcHuWo/o7A+dwamYmqayTY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=VZlrpTJwEfnfSUqECWMCDY9wv6tqTWhkCiDqNe8KBLMWCnVS5feK/NxWc5l49No3E
	 baviqRWMfB2XVHY8Av1dh+XsdHLmBQvfAKHl7C0XgeT6d0Ms7qNcQ91Ovo8WxxoAdp
	 G3edtEACUeI48FtdWqk+v7gN5Kdxw99hxcGl/bPM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbfKXS24 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Nov 2019 13:28:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:60826 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726833AbfKXS2z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Nov 2019 13:28:55 -0500
Received: from localhost (c-67-180-165-146.hsd1.ca.comcast.net [67.180.165.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C73A207DD;
        Sun, 24 Nov 2019 18:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574620135;
        bh=eqAsjzVaq3nzz88L4tDGzUcHuWo/o7A+dwamYmqayTY=;
        h=From:To:Cc:Subject:Date:From;
        b=GwBimmHc9vpYKYOOilmm0x0n59Q4OL4AlMOqoRGltmUA/ddJvPhW5PZZwUYASrUMe
         GsYV4S5d3Q4mBYOjajS9Ki3dPGCbmFQCKKX8SZvE3cjgp/OqLgo6P5O8gk1FE3WTHd
         YxyBRkJelceyQHcG3zIhpAoWOtN1rvgF+mCII1Wc=
From:   Andy Lutomirski <luto@kernel.org>
To:     Borislav Petkov <bp@alien8.de>, x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH] x86/entry/32: Fix FIXUP_ESPFIX_STACK with user CR3
Date:   Sun, 24 Nov 2019 10:28:52 -0800
Message-Id: <6bd718e0465dcc8a97e7b2aa75fd762f34e2fd6d.1574620037.git.luto@kernel.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UNWIND_ESPFIX_STACK needs to read the GDT, and the GDT mapping that
can be accessed via %fs is not mapped in the user pagetables.  Use
SGDT to find the cpu_entry_area mapping and read the espfix offset
from that instead.

Reported-and-tested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/entry/entry_32.S | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/arch/x86/entry/entry_32.S b/arch/x86/entry/entry_32.S
index 0b8c93136650..f07baf0388bc 100644
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
-- 
2.23.0

