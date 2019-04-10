Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05160C10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:09:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE73D2229F
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730455AbfDJLJa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 07:09:30 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:58793 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730925AbfDJLFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 07:05:46 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hEB32-00055S-QE; Wed, 10 Apr 2019 13:05:44 +0200
Message-Id: <20190410103644.853527514@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 10 Apr 2019 12:28:08 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexander Potapenko <glider@google.com>
Subject: [RFC patch 14/41] latency_top: Remove the ULONG_MAX stack trace
 hackery
References: <20190410102754.387743324@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No architecture terminates the stack trace with ULONG_MAX anymore. The
consumer terminates on the first zero entry or at the number of entries, so
no functional change.

Remove the cruft.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 fs/proc/base.c      |    3 +--
 kernel/latencytop.c |   12 ++++++------
 2 files changed, 7 insertions(+), 8 deletions(-)

--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -489,10 +489,9 @@ static int lstats_show_proc(struct seq_f
 				   lr->count, lr->time, lr->max);
 			for (q = 0; q < LT_BACKTRACEDEPTH; q++) {
 				unsigned long bt = lr->backtrace[q];
+
 				if (!bt)
 					break;
-				if (bt == ULONG_MAX)
-					break;
 				seq_printf(m, " %ps", (void *)bt);
 			}
 			seq_putc(m, '\n');
--- a/kernel/latencytop.c
+++ b/kernel/latencytop.c
@@ -120,8 +120,8 @@ account_global_scheduler_latency(struct
 				break;
 			}
 
-			/* 0 and ULONG_MAX entries mean end of backtrace: */
-			if (record == 0 || record == ULONG_MAX)
+			/* 0 entry marks end of backtrace: */
+			if (!record)
 				break;
 		}
 		if (same) {
@@ -210,8 +210,8 @@ void __sched
 				break;
 			}
 
-			/* 0 and ULONG_MAX entries mean end of backtrace: */
-			if (record == 0 || record == ULONG_MAX)
+			/* 0 entry is end of backtrace */
+			if (!record)
 				break;
 		}
 		if (same) {
@@ -252,10 +252,10 @@ static int lstats_show(struct seq_file *
 				   lr->count, lr->time, lr->max);
 			for (q = 0; q < LT_BACKTRACEDEPTH; q++) {
 				unsigned long bt = lr->backtrace[q];
+
 				if (!bt)
 					break;
-				if (bt == ULONG_MAX)
-					break;
+
 				seq_printf(m, " %ps", (void *)bt);
 			}
 			seq_puts(m, "\n");


