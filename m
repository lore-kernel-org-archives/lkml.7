Return-Path: <SRS0=SZ1Q=SM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D84FC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:07:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 477AD222B6
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Apr 2019 11:07:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729582AbfDJLHf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Apr 2019 07:07:35 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:58992 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731145AbfDJLGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Apr 2019 07:06:17 -0400
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hEB3X-0005Ex-RN; Wed, 10 Apr 2019 13:06:16 +0200
Message-Id: <20190410103646.846832787@linutronix.de>
User-Agent: quilt/0.65
Date:   Wed, 10 Apr 2019 12:28:30 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        Andy Lutomirski <luto@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Alexander Potapenko <glider@google.com>
Subject: [RFC patch 36/41] tracing: Simplify stacktrace retrieval in histograms
References: <20190410102754.387743324@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The indirection through struct stack_trace is not necessary at all. Use the
storage array based interface.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace_events_hist.c |   12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -5186,7 +5186,6 @@ static void event_hist_trigger(struct ev
 	u64 var_ref_vals[TRACING_MAP_VARS_MAX];
 	char compound_key[HIST_KEY_SIZE_MAX];
 	struct tracing_map_elt *elt = NULL;
-	struct stack_trace stacktrace;
 	struct hist_field *key_field;
 	u64 field_contents;
 	void *key = NULL;
@@ -5198,14 +5197,9 @@ static void event_hist_trigger(struct ev
 		key_field = hist_data->fields[i];
 
 		if (key_field->flags & HIST_FIELD_FL_STACKTRACE) {
-			stacktrace.max_entries = HIST_STACKTRACE_DEPTH;
-			stacktrace.entries = entries;
-			stacktrace.nr_entries = 0;
-			stacktrace.skip = HIST_STACKTRACE_SKIP;
-
-			memset(stacktrace.entries, 0, HIST_STACKTRACE_SIZE);
-			save_stack_trace(&stacktrace);
-
+			memset(entries, 0, HIST_STACKTRACE_SIZE);
+			stack_trace_save(entries, HIST_STACKTRACE_DEPTH,
+					 HIST_STACKTRACE_SKIP);
 			key = entries;
 		} else {
 			field_contents = key_field->fn(key_field, elt, rbe, rec);


