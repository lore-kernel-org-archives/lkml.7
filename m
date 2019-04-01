Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC946C4360F
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4DFB208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:44:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728875AbfDAQoS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 12:44:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:60166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728764AbfDAQnq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 12:43:46 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B939921917;
        Mon,  1 Apr 2019 16:43:45 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hB02C-0004wk-Su; Mon, 01 Apr 2019 12:43:44 -0400
Message-Id: <20190401164344.785896189@goodmis.org>
User-Agent: quilt/0.65
Date:   Mon, 01 Apr 2019 12:43:19 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>
Subject: [PATCH 14/15] tools/perf,tools/lib/traceevent: Rename "pevent" member of struct
 tep_event_filter to "tep"
References: <20190401164305.359125441@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tzvetomir Stoyanov <tstoyanov@vmware.com>

The member "pevent" of the struct tep_event_filter is renamed to "tep".
This makes the struct consistent with the chosen naming convention:
tep (trace event parser), instead of the old pevent.

Link: http://lore.kernel.org/linux-trace-devel/20190401132111.13727-4-tstoyanov@vmware.com

Signed-off-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/lib/traceevent/event-parse.h  |  2 +-
 tools/lib/traceevent/parse-filter.c | 14 +++++++-------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/lib/traceevent/event-parse.h b/tools/lib/traceevent/event-parse.h
index de7ace173e75..642f68ab5fb2 100644
--- a/tools/lib/traceevent/event-parse.h
+++ b/tools/lib/traceevent/event-parse.h
@@ -717,7 +717,7 @@ struct tep_filter_type {
 #define TEP_FILTER_ERROR_BUFSZ  1024
 
 struct tep_event_filter {
-	struct tep_handle	*pevent;
+	struct tep_handle	*tep;
 	int			filters;
 	struct tep_filter_type	*event_filters;
 	char			error_buffer[TEP_FILTER_ERROR_BUFSZ];
diff --git a/tools/lib/traceevent/parse-filter.c b/tools/lib/traceevent/parse-filter.c
index 123358209297..6a4d5d1dd1cd 100644
--- a/tools/lib/traceevent/parse-filter.c
+++ b/tools/lib/traceevent/parse-filter.c
@@ -154,7 +154,7 @@ add_filter_type(struct tep_event_filter *filter, int id)
 
 	filter_type = &filter->event_filters[i];
 	filter_type->event_id = id;
-	filter_type->event = tep_find_event(filter->pevent, id);
+	filter_type->event = tep_find_event(filter->tep, id);
 	filter_type->filter = NULL;
 
 	filter->filters++;
@@ -175,7 +175,7 @@ struct tep_event_filter *tep_filter_alloc(struct tep_handle *tep)
 		return NULL;
 
 	memset(filter, 0, sizeof(*filter));
-	filter->pevent = tep;
+	filter->tep = tep;
 	tep_ref(tep);
 
 	return filter;
@@ -1257,7 +1257,7 @@ static void filter_init_error_buf(struct tep_event_filter *filter)
 enum tep_errno tep_filter_add_filter_str(struct tep_event_filter *filter,
 					 const char *filter_str)
 {
-	struct tep_handle *pevent = filter->pevent;
+	struct tep_handle *pevent = filter->tep;
 	struct event_list *event;
 	struct event_list *events = NULL;
 	const char *filter_start;
@@ -1377,7 +1377,7 @@ int tep_filter_strerror(struct tep_event_filter *filter, enum tep_errno err,
 		return 0;
 	}
 
-	return tep_strerror(filter->pevent, err, buf, buflen);
+	return tep_strerror(filter->tep, err, buf, buflen);
 }
 
 /**
@@ -1440,7 +1440,7 @@ void tep_filter_reset(struct tep_event_filter *filter)
 
 void tep_filter_free(struct tep_event_filter *filter)
 {
-	tep_unref(filter->pevent);
+	tep_unref(filter->tep);
 
 	tep_filter_reset(filter);
 
@@ -1462,7 +1462,7 @@ static int copy_filter_type(struct tep_event_filter *filter,
 	/* Can't assume that the pevent's are the same */
 	sys = filter_type->event->system;
 	name = filter_type->event->name;
-	event = tep_find_event_by_name(filter->pevent, sys, name);
+	event = tep_find_event_by_name(filter->tep, sys, name);
 	if (!event)
 		return -1;
 
@@ -1872,7 +1872,7 @@ int tep_event_filtered(struct tep_event_filter *filter, int event_id)
 enum tep_errno tep_filter_match(struct tep_event_filter *filter,
 				struct tep_record *record)
 {
-	struct tep_handle *pevent = filter->pevent;
+	struct tep_handle *pevent = filter->tep;
 	struct tep_filter_type *filter_type;
 	int event_id;
 	int ret;
-- 
2.20.1


