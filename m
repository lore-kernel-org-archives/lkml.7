Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85A20C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 16:18:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C1E021530
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 16:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1561133897;
	bh=Mrv5d4L6GpLmh9F0FUyQptMTn0Gxhp7LA7u3J632MP8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jB3YzygIx6ZX4Q7PPWazRgHUDtTuoqf+abkV/emWHW2aLGfDHl+sEb086c6EaP4Mp
	 PYRTnUJiBbcD4zHT++jZ/bB47dlp+NHJd1FUrC8KAO1qvCLHBv7UhAQARdgAhXv4Mb
	 Rat2T0bFZf2c2caxaCt0lbTlmJ/TjSDCSyy7sUG8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbfFUQSP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 12:18:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:51098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726032AbfFUQSP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 12:18:15 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9532321537;
        Fri, 21 Jun 2019 16:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561133894;
        bh=Mrv5d4L6GpLmh9F0FUyQptMTn0Gxhp7LA7u3J632MP8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GhvgU2voDUZdcZOflmn8YIMEKaBu4N3oD/SkcJBQkfRArMGUIgR358jZDuRcO7+BI
         /gEg97oKME4WiDDT/oY4PMIJPq6NYdOqjhdlnPGJvKmMHGEFuHmRqx9eZoI71nizj8
         SYv6Ons+jNKnY3aY+O4h+fn4dEHEjNYOSfxeaumU=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Tom Zanussi <tom.zanussi@linux.intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [RFC PATCH 01/11] tracing: Apply soft-disabled and filter to tracepoints printk
Date:   Sat, 22 Jun 2019 01:18:10 +0900
Message-Id: <156113389044.28344.5247768340761003322.stgit@devnote2>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <156113387975.28344.16009584175308192243.stgit@devnote2>
References: <156113387975.28344.16009584175308192243.stgit@devnote2>
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
index 77b9c4ca5faa..4a6154f8abdb 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2502,6 +2502,7 @@ static DEFINE_MUTEX(tracepoint_printk_mutex);
 static void output_printk(struct trace_event_buffer *fbuffer)
 {
 	struct trace_event_call *event_call;
+	struct trace_event_file *file;
 	struct trace_event *event;
 	unsigned long flags;
 	struct trace_iterator *iter = tracepoint_print_iter;
@@ -2515,6 +2516,12 @@ static void output_printk(struct trace_event_buffer *fbuffer)
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

