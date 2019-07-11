Return-Path: <SRS0=G0tX=VI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37C7CC74A52
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 11:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1038521019
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jul 2019 11:52:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ruAoBF9j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728680AbfGKLwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jul 2019 07:52:25 -0400
Received: from merlin.infradead.org ([205.233.59.134]:54796 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728654AbfGKLwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jul 2019 07:52:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=x60GWs4sK6p0XR7SzYSe69WcN7OXzbqKI26dyMms13s=; b=ruAoBF9jPrLRrjqLp7Aci8Garf
        AHZRrBVDVjQ7cyjXtMMHg0XY6OiYLdyQM+r1TVdyKX1n1ehOoAGVEc8z+O9NoY0ZmAg+LQ/1u+DIt
        EqhPFJ+pFbcmlGL1cBoFMcsIClXVnhEfK65GR5oX81vF9nZ8ZYhEIya9TXo3e9w8E1tgeYY39NjJg
        3msDyZCf0jVONPbutxloso5PzAfMWoG63CNiU7EL1xIfNZesd21HBzX5vob7XEZ6b7XQxGhBax3UZ
        6k6PvqbSFAZ93Qbru0fzxhFi3C8ZZyjobPAgT05Ag0P3XzeQfQWDKxyov9MULAue2j2SVSnk87cyw
        WAwEx/+Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hlXc3-0003MC-Rs; Thu, 11 Jul 2019 11:51:48 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id F0A1320B53B63; Thu, 11 Jul 2019 13:51:44 +0200 (CEST)
Message-Id: <20190711114336.059780563@infradead.org>
User-Agent: quilt/0.65
Date:   Thu, 11 Jul 2019 13:40:58 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     tglx@linutronix.de, bp@alien8.de, mingo@kernel.org,
        rostedt@goodmis.org, luto@kernel.org, torvalds@linux-foundation.org
Cc:     hpa@zytor.com, dave.hansen@linux.intel.com, jgross@suse.com,
        linux-kernel@vger.kernel.org, zhe.he@windriver.com,
        joel@joelfernandes.org, devel@etsukata.com, peterz@infradead.org
Subject: [PATCH v3 4/6] x86/entry/64: Update comments and sanity tests for create_gap
References: <20190711114054.406765395@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 2700fefdb2d9 ("x86_64: Add gap to int3 to allow for call
emulation") forgot to update the comment, do so now.

Acked-by: Andy Lutomirski <luto@kernel.org>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/entry/entry_64.S |   17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -913,15 +913,16 @@ apicinterrupt IRQ_WORK_VECTOR			irq_work
 /**
  * idtentry - Generate an IDT entry stub
  * @sym:		Name of the generated entry point
- * @do_sym: 		C function to be called
- * @has_error_code: 	True if this IDT vector has an error code on the stack
- * @paranoid: 		non-zero means that this vector may be invoked from
+ * @do_sym:		C function to be called
+ * @has_error_code:	True if this IDT vector has an error code on the stack
+ * @paranoid:		non-zero means that this vector may be invoked from
  *			kernel mode with user GSBASE and/or user CR3.
  *			2 is special -- see below.
  * @shift_ist:		Set to an IST index if entries from kernel mode should
- *             		decrement the IST stack so that nested entries get a
+ *			decrement the IST stack so that nested entries get a
  *			fresh stack.  (This is for #DB, which has a nasty habit
- *             		of recursing.)
+ *			of recursing.)
+ * @create_gap:		create a 6-word stack gap when coming from kernel mode.
  *
  * idtentry generates an IDT stub that sets up a usable kernel context,
  * creates struct pt_regs, and calls @do_sym.  The stub has the following
@@ -951,10 +952,14 @@ ENTRY(\sym)
 	UNWIND_HINT_IRET_REGS offset=\has_error_code*8
 
 	/* Sanity check */
-	.if \shift_ist != -1 && \paranoid == 0
+	.if \shift_ist != -1 && \paranoid != 1
 	.error "using shift_ist requires paranoid=1"
 	.endif
 
+	.if \create_gap && \paranoid
+	.error "using create_gap requires paranoid=0"
+	.endif
+
 	ASM_CLAC
 
 	.if \has_error_code == 0


