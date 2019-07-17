Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81E22C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 21:25:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51CD1217F4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 21:25:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="gLZ3gPix"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbfGQVZn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 17:25:43 -0400
Received: from terminus.zytor.com ([198.137.202.136]:40301 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727106AbfGQVZm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 17:25:42 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6HLPFgo1695719
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 17 Jul 2019 14:25:15 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6HLPFgo1695719
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563398716;
        bh=fhvasD3ub/xpN9kaf9j0SNbPN0spouR0F9llQrkMpMA=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=gLZ3gPixva02oyOdr+UNN66I7gzbeJ1rrpeTfUvlaNiHdyJzaNUSJY6bSZdZGQYV2
         MRWuar18fxpF7mwrCh27+46gCAZPaWhLpEIKXYCyVcY1fqsyUpzHs9TU1u/Zo4ql9t
         KHbR/Ljbb4QFZe/hhJla1UBPIOoeitA/gJgg1aKJ5Go0EbCkm/c90Hendxc4mRgCJl
         Lp8NGZZRc5jt14jZ47gFlavmHXbz0ihKRhn+TWGeo9rWvXIuDvgPyPibQGpJHbcZXK
         xkMWO//c01qI+MQkVIVg8Gxyvbd0A/ug418LO3qNjceXF4JLoAaCSSqKVgZMSjyKaD
         CTxU8B54dxyAQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6HLPFA11695710;
        Wed, 17 Jul 2019 14:25:15 -0700
Date:   Wed, 17 Jul 2019 14:25:15 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Peter Zijlstra <tipbot@zytor.com>
Message-ID: <tip-4234653e882740cbf6625eeee294e388b3176583@git.kernel.org>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org, hpa@zytor.com,
        mingo@kernel.org, rostedt@goodmis.org, tglx@linutronix.de,
        luto@kernel.org
Reply-To: tglx@linutronix.de, rostedt@goodmis.org, mingo@kernel.org,
          hpa@zytor.com, linux-kernel@vger.kernel.org,
          peterz@infradead.org, luto@kernel.org
In-Reply-To: <20190711114336.059780563@infradead.org>
References: <20190711114336.059780563@infradead.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/urgent] x86/entry/64: Update comments and sanity tests for
 create_gap
Git-Commit-ID: 4234653e882740cbf6625eeee294e388b3176583
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

Commit-ID:  4234653e882740cbf6625eeee294e388b3176583
Gitweb:     https://git.kernel.org/tip/4234653e882740cbf6625eeee294e388b3176583
Author:     Peter Zijlstra <peterz@infradead.org>
AuthorDate: Thu, 11 Jul 2019 13:40:58 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Wed, 17 Jul 2019 23:17:38 +0200

x86/entry/64: Update comments and sanity tests for create_gap

Commit 2700fefdb2d9 ("x86_64: Add gap to int3 to allow for call
emulation") forgot to update the comment, do so now.

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
Link: https://lkml.kernel.org/r/20190711114336.059780563@infradead.org

---
 arch/x86/entry/entry_64.S | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 3db5fede743b..95ae05f0edf2 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -913,15 +913,16 @@ apicinterrupt IRQ_WORK_VECTOR			irq_work_interrupt		smp_irq_work_interrupt
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
