Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93B6AC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F0742229F
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:10:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730833AbfDJLFd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 07:05:33 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:58702 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730756AbfDJLFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 07:05:31 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hEB2m-00050z-Qr; Wed, 10 Apr 2019 13:05:28 +0200
Message-Id: <20190410103643.750954603@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 10 Apr 2019 12:27:56 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexander Potapenko <glider@google.com>
Subject: [RFC patch 02/41] x86/stacktrace: Remove the pointless ULONG_MAX
 marker
References: <20190410102754.387743324@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Terminating the last trace entry with ULONG_MAX is a completely pointless
exercise and none of the consumers can rely on it because it's
inconsistently implemented across architectures. In fact quite some of the
callers remove the entry and adjust stack_trace.nr_entries afterwards.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/stacktrace.c |   14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

--- a/arch/x86/kernel/stacktrace.c
+++ b/arch/x86/kernel/stacktrace.c
@@ -46,9 +46,6 @@ static void noinline __save_stack_trace(
 		if (!addr || save_stack_address(trace, addr, nosched))
 			break;
 	}
-
-	if (trace->nr_entries < trace->max_entries)
-		trace->entries[trace->nr_entries++] = ULONG_MAX;
 }
 
 /*
@@ -97,7 +94,7 @@ static int __always_inline
 		if (regs) {
 			/* Success path for user tasks */
 			if (user_mode(regs))
-				goto success;
+				return 0;
 
 			/*
 			 * Kernel mode registers on the stack indicate an
@@ -132,10 +129,6 @@ static int __always_inline
 	if (!(task->flags & (PF_KTHREAD | PF_IDLE)))
 		return -EINVAL;
 
-success:
-	if (trace->nr_entries < trace->max_entries)
-		trace->entries[trace->nr_entries++] = ULONG_MAX;
-
 	return 0;
 }
 
@@ -221,9 +214,6 @@ void save_stack_trace_user(struct stack_
 	/*
 	 * Trace user stack if we are not a kernel thread
 	 */
-	if (current->mm) {
+	if (current->mm)
 		__save_stack_trace_user(trace);
-	}
-	if (trace->nr_entries < trace->max_entries)
-		trace->entries[trace->nr_entries++] = ULONG_MAX;
 }


