Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBEDCC7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 19:01:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB14B2182B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 19:01:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388702AbfGPTBH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 15:01:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:37976 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388625AbfGPTA7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 15:00:59 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6E090217F4;
        Tue, 16 Jul 2019 19:00:58 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hnSh7-0006EN-Dj; Tue, 16 Jul 2019 15:00:57 -0400
Message-Id: <20190716190057.315480748@goodmis.org>
User-Agent: quilt/0.65
Date:   Tue, 16 Jul 2019 15:00:19 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@redhat.com>,
        Cong Wang <xiyou.wangcong@gmail.com>
Subject: [for-next][PATCH 5/5] tracing: Make trace_get_fields() global
References: <20190716190014.840939538@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cong Wang <xiyou.wangcong@gmail.com>

trace_get_fields() is the only way to read tracepoint fields at
run time, as their fields are defined at compile-time with macros.
Make this function visible to all users and it will be used by
trace event injection code to calculate the size of a tracepoint
entry.
Link: http://lkml.kernel.org/r/20190525165802.25944-4-xiyou.wangcong@gmail.com

Cc: Ingo Molnar <mingo@redhat.com>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 include/linux/trace_events.h | 8 ++++++++
 kernel/trace/trace_events.c  | 8 --------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 5c6f2a6c8cd2..5150436783e8 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -318,6 +318,14 @@ trace_event_name(struct trace_event_call *call)
 		return call->name;
 }
 
+static inline struct list_head *
+trace_get_fields(struct trace_event_call *event_call)
+{
+	if (!event_call->class->get_fields)
+		return &event_call->class->fields;
+	return event_call->class->get_fields(event_call);
+}
+
 struct trace_array;
 struct trace_subsystem_dir;
 
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index edc72f3b080c..c7506bc81b75 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -70,14 +70,6 @@ static int system_refcount_dec(struct event_subsystem *system)
 #define while_for_each_event_file()		\
 	}
 
-static struct list_head *
-trace_get_fields(struct trace_event_call *event_call)
-{
-	if (!event_call->class->get_fields)
-		return &event_call->class->fields;
-	return event_call->class->get_fields(event_call);
-}
-
 static struct ftrace_event_field *
 __find_event_field(struct list_head *head, char *name)
 {
-- 
2.20.1


