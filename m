Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D58DAC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:06:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B03FE218D2
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731106AbfDJLGG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 07:06:06 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:58894 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731071AbfDJLGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 07:06:02 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hEB3H-0005AD-H8; Wed, 10 Apr 2019 13:05:59 +0200
Message-Id: <20190410103645.862294081@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 10 Apr 2019 12:28:19 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexander Potapenko <glider@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        linux-mm@kvack.org
Subject: [RFC patch 25/41] mm/kasan: Simplify stacktrace handling
References: <20190410102754.387743324@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the indirection through struct stack_trace by using the storage
array based interfaces.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andrey Ryabinin <aryabinin@virtuozzo.com>
Cc: Alexander Potapenko <glider@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: kasan-dev@googlegroups.com
Cc: linux-mm@kvack.org
---
 mm/kasan/common.c |   30 ++++++++++++------------------
 mm/kasan/report.c |    7 ++++---
 2 files changed, 16 insertions(+), 21 deletions(-)

--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -48,34 +48,28 @@ static inline int in_irqentry_text(unsig
 		 ptr < (unsigned long)&__softirqentry_text_end);
 }
 
-static inline void filter_irq_stacks(struct stack_trace *trace)
+static inline unsigned int filter_irq_stacks(unsigned long *entries,
+					     unsigned int nr_entries)
 {
-	int i;
+	unsigned int i;
 
-	if (!trace->nr_entries)
-		return;
-	for (i = 0; i < trace->nr_entries; i++)
-		if (in_irqentry_text(trace->entries[i])) {
+	for (i = 0; i < nr_entries; i++) {
+		if (in_irqentry_text(entries[i])) {
 			/* Include the irqentry function into the stack. */
-			trace->nr_entries = i + 1;
-			break;
+			return i + 1;
 		}
+	}
+	return nr_entries;
 }
 
 static inline depot_stack_handle_t save_stack(gfp_t flags)
 {
 	unsigned long entries[KASAN_STACK_DEPTH];
-	struct stack_trace trace = {
-		.nr_entries = 0,
-		.entries = entries,
-		.max_entries = KASAN_STACK_DEPTH,
-		.skip = 0
-	};
+	unsigned int nent;
 
-	save_stack_trace(&trace);
-	filter_irq_stacks(&trace);
-
-	return depot_save_stack(&trace, flags);
+	nent = stack_trace_save(entries, ARRAY_SIZE(entries), 0);
+	nent = filter_irq_stacks(entries, nent);
+	return stack_depot_save(entries, nent, flags);
 }
 
 static inline void set_track(struct kasan_track *track, gfp_t flags)
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -100,10 +100,11 @@ static void print_track(struct kasan_tra
 {
 	pr_err("%s by task %u:\n", prefix, track->pid);
 	if (track->stack) {
-		struct stack_trace trace;
+		unsigned long *entries;
+		unsigned int nent;
 
-		depot_fetch_stack(track->stack, &trace);
-		print_stack_trace(&trace, 0);
+		nent = stack_depot_fetch(track->stack, &entries);
+		stack_trace_print(entries, nent, 0);
 	} else {
 		pr_err("(stack is not available)\n");
 	}


