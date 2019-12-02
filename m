Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02347C432C3
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 10:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2F13217F9
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 10:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1575281717;
	bh=6MlcXxaJfgaJQcnBKUBXs5O1jviM5mFyCx9pCC+U65o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=gffjYsYM0qDA2697WxrhpTj+4oE68aBeGgMx44cdDRpYnKvnbRHW/SmDJBkg/nfho
	 WQe5A1zmCVSaUkoCN4IqYKNNeq34EeMomsHepVP05ZHRbNL3FRLcG/Wa9HdqkuWwpl
	 7j2+fJetjL8Xci0mkODiONfNk8C4iimAwEXzGAYA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727646AbfLBKPR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 05:15:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:60198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727494AbfLBKPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 05:15:16 -0500
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7643A217D9;
        Mon,  2 Dec 2019 10:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575281715;
        bh=6MlcXxaJfgaJQcnBKUBXs5O1jviM5mFyCx9pCC+U65o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R/+Bb55JIvGogNXtB6+FqG8o2Gv2z72MZ3i8YIearNtjudK3MwB+yGnWxPEN32Gy+
         HkioOubqW7S4CQVfK8fpOUapnEX97uLWbZzBsAYlL8taNOlZ+Iz68E+IcwnKa93LIZ
         uHjs81oEAFY6K9TKTfFzA/Ms9Zp0Gz/nTAkx6X5w=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Frank Rowand <frowand.list@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Tim Bird <Tim.Bird@sony.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Tom Zanussi <tom.zanussi@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH v4 10/22] tracing: Apply soft-disabled and filter to tracepoints printk
Date:   Mon,  2 Dec 2019 19:15:10 +0900
Message-Id: <157528171025.22451.6307080440684347405.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <157528159833.22451.14878731055438721716.stgit@devnote2>
References: <157528159833.22451.14878731055438721716.stgit@devnote2>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apply soft-disabled and the filter rule of the trace events to
the printk output of tracepoints (a.k.a. tp_printk kernel parameter)
as same as trace buffer output.

Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 kernel/trace/trace.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 02a23a6e5e00..1a910d173230 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2604,6 +2604,7 @@ static DEFINE_MUTEX(tracepoint_printk_mutex);
 static void output_printk(struct trace_event_buffer *fbuffer)
 {
 	struct trace_event_call *event_call;
+	struct trace_event_file *file;
 	struct trace_event *event;
 	unsigned long flags;
 	struct trace_iterator *iter = tracepoint_print_iter;
@@ -2617,6 +2618,12 @@ static void output_printk(struct trace_event_buffer *fbuffer)
 	    !event_call->event.funcs->trace)
 		return;
 
+	file = fbuffer->trace_file;
+	if (test_bit(EVENT_FILE_FL_SOFT_DISABLED_BIT, &file->flags) ||
+	    (unlikely(file->flags & EVENT_FILE_FL_FILTERED) &&
+	     !filter_match_preds(file->filter, fbuffer->entry)))
+		return;
+
 	event = &fbuffer->trace_file->event_call->event;
 
 	spin_lock_irqsave(&tracepoint_iter_lock, flags);

