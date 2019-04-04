Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA39CC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 01:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8DFFB21872
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 01:37:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726709AbfDDBhx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 21:37:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:36072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726193AbfDDBhp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 21:37:45 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8984214AF;
        Thu,  4 Apr 2019 01:37:44 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hBrK4-0004zJ-2v; Wed, 03 Apr 2019 21:37:44 -0400
Message-Id: <20190404013743.975193729@goodmis.org>
User-Agent: quilt/0.65
Date:   Wed, 03 Apr 2019 21:37:27 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Subject: [for-next][PATCH 06/19] tracing: Use tracing error_log with trace event filters
References: <20190404013721.023858792@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Zanussi <tom.zanussi@linux.intel.com>

Use tracing_log_err() from the new tracing error_log mechanism to send
filter parse errors to tracing/error_log.

With this change, users will be able to see filter errors by looking
at tracing/error_log.

The same errors will also be available in the filter file, as
expected.

Link: http://lkml.kernel.org/r/1d942c419941539a11d78a6810fc5740a99b2974.1554072478.git.tom.zanussi@linux.intel.com

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Acked-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Tom Zanussi <tom.zanussi@linux.intel.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_filter.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 05a66493a164..290d42c59101 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -66,7 +66,8 @@ static const char * ops[] = { OPS };
 	C(INVALID_FILTER,	"Meaningless filter expression"),	\
 	C(IP_FIELD_ONLY,	"Only 'ip' field is supported for function trace"), \
 	C(INVALID_VALUE,	"Invalid value (did you forget quotes)?"), \
-	C(NO_FILTER,		"No filter found"),
+	C(ERRNO,		"Error"),				\
+	C(NO_FILTER,		"No filter found")
 
 #undef C
 #define C(a, b)		FILT_ERR_##a
@@ -76,7 +77,7 @@ enum { ERRORS };
 #undef C
 #define C(a, b)		b
 
-static char *err_text[] = { ERRORS };
+static const char *err_text[] = { ERRORS };
 
 /* Called after a '!' character but "!=" and "!~" are not "not"s */
 static bool is_not(const char *str)
@@ -947,8 +948,14 @@ static void append_filter_err(struct filter_parse_error *pe,
 	if (pe->lasterr > 0) {
 		trace_seq_printf(s, "\n%*s", pos, "^");
 		trace_seq_printf(s, "\nparse_error: %s\n", err_text[pe->lasterr]);
+		tracing_log_err("event filter parse error",
+				filter->filter_string, err_text,
+				pe->lasterr, pe->lasterr_pos);
 	} else {
 		trace_seq_printf(s, "\nError: (%d)\n", pe->lasterr);
+		tracing_log_err("event filter parse error",
+				filter->filter_string, err_text,
+				FILT_ERR_ERRNO, 0);
 	}
 	trace_seq_putc(s, 0);
 	buf = kmemdup_nul(s->buffer, s->seq.len, GFP_KERNEL);
-- 
2.20.1


