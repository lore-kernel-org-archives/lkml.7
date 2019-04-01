Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0DB8C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8259208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:44:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbfDAQoq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 12:44:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:60092 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728255AbfDAQnp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 12:43:45 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1480921905;
        Mon,  1 Apr 2019 16:43:44 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hB02B-0004rI-7Q; Mon, 01 Apr 2019 12:43:43 -0400
Message-Id: <20190401164343.117437443@goodmis.org>
User-Agent: quilt/0.65
Date:   Mon, 01 Apr 2019 12:43:08 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>
Subject: [PATCH 03/15] tools lib traceevent: Implement a new API, tep_list_events_copy()
References: <20190401164305.359125441@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tzvetomir Stoyanov <tstoyanov@vmware.com>

Existing API tep_list_events() is not thread safe, it uses the internal
array sort_events to keep cache of the sorted events and reuses it. This
patch implements a new API, tep_list_events_copy(), which allocates new
sorted array each time it is called. It could be used when a sorted events
functionality is needed in thread safe use cases. It is up to the caller to
free the array.

Link: http://lore.kernel.org/linux-trace-devel/20181218133013.31094-1-tstoyanov@vmware.com

Signed-off-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/lib/traceevent/event-parse.c | 109 +++++++++++++++++++++++------
 tools/lib/traceevent/event-parse.h |   5 +-
 2 files changed, 91 insertions(+), 23 deletions(-)

diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index 666e23ded6ed..c00aebab3c33 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -5651,32 +5651,26 @@ static int events_system_cmp(const void *a, const void *b)
 	return events_id_cmp(a, b);
 }
 
-struct tep_event **tep_list_events(struct tep_handle *pevent, enum tep_event_sort_type sort_type)
+static struct tep_event **list_events_copy(struct tep_handle *tep)
 {
 	struct tep_event **events;
-	int (*sort)(const void *a, const void *b);
-
-	events = pevent->sort_events;
-
-	if (events && pevent->last_type == sort_type)
-		return events;
 
-	if (!events) {
-		events = malloc(sizeof(*events) * (pevent->nr_events + 1));
-		if (!events)
-			return NULL;
+	if (!tep)
+		return NULL;
 
-		memcpy(events, pevent->events, sizeof(*events) * pevent->nr_events);
-		events[pevent->nr_events] = NULL;
+	events = malloc(sizeof(*events) * (tep->nr_events + 1));
+	if (!events)
+		return NULL;
 
-		pevent->sort_events = events;
+	memcpy(events, tep->events, sizeof(*events) * tep->nr_events);
+	events[tep->nr_events] = NULL;
+	return events;
+}
 
-		/* the internal events are sorted by id */
-		if (sort_type == TEP_EVENT_SORT_ID) {
-			pevent->last_type = sort_type;
-			return events;
-		}
-	}
+static void list_events_sort(struct tep_event **events, int nr_events,
+			     enum tep_event_sort_type sort_type)
+{
+	int (*sort)(const void *a, const void *b);
 
 	switch (sort_type) {
 	case TEP_EVENT_SORT_ID:
@@ -5689,11 +5683,82 @@ struct tep_event **tep_list_events(struct tep_handle *pevent, enum tep_event_sor
 		sort = events_system_cmp;
 		break;
 	default:
+		sort = NULL;
+	}
+
+	if (sort)
+		qsort(events, nr_events, sizeof(*events), sort);
+}
+
+/**
+ * tep_list_events - Get events, sorted by given criteria.
+ * @tep: a handle to the tep context
+ * @sort_type: desired sort order of the events in the array
+ *
+ * Returns an array of pointers to all events, sorted by the given
+ * @sort_type criteria. The last element of the array is NULL. The returned
+ * memory must not be freed, it is managed by the library.
+ * The function is not thread safe.
+ */
+struct tep_event **tep_list_events(struct tep_handle *tep,
+				   enum tep_event_sort_type sort_type)
+{
+	struct tep_event **events;
+
+	if (!tep)
+		return NULL;
+
+	events = tep->sort_events;
+	if (events && tep->last_type == sort_type)
 		return events;
+
+	if (!events) {
+		events = list_events_copy(tep);
+		if (!events)
+			return NULL;
+
+		tep->sort_events = events;
+
+		/* the internal events are sorted by id */
+		if (sort_type == TEP_EVENT_SORT_ID) {
+			tep->last_type = sort_type;
+			return events;
+		}
 	}
 
-	qsort(events, pevent->nr_events, sizeof(*events), sort);
-	pevent->last_type = sort_type;
+	list_events_sort(events, tep->nr_events, sort_type);
+	tep->last_type = sort_type;
+
+	return events;
+}
+
+
+/**
+ * tep_list_events_copy - Thread safe version of tep_list_events()
+ * @tep: a handle to the tep context
+ * @sort_type: desired sort order of the events in the array
+ *
+ * Returns an array of pointers to all events, sorted by the given
+ * @sort_type criteria. The last element of the array is NULL. The returned
+ * array is newly allocated inside the function and must be freed by the caller
+ */
+struct tep_event **tep_list_events_copy(struct tep_handle *tep,
+					enum tep_event_sort_type sort_type)
+{
+	struct tep_event **events;
+
+	if (!tep)
+		return NULL;
+
+	events = list_events_copy(tep);
+	if (!events)
+		return NULL;
+
+	/* the internal events are sorted by id */
+	if (sort_type == TEP_EVENT_SORT_ID)
+		return events;
+
+	list_events_sort(events, tep->nr_events, sort_type);
 
 	return events;
 }
diff --git a/tools/lib/traceevent/event-parse.h b/tools/lib/traceevent/event-parse.h
index aec48f2aea8a..41159358abc2 100644
--- a/tools/lib/traceevent/event-parse.h
+++ b/tools/lib/traceevent/event-parse.h
@@ -544,7 +544,10 @@ void tep_event_info(struct trace_seq *s, struct tep_event *event,
 int tep_strerror(struct tep_handle *pevent, enum tep_errno errnum,
 		 char *buf, size_t buflen);
 
-struct tep_event **tep_list_events(struct tep_handle *pevent, enum tep_event_sort_type);
+struct tep_event **tep_list_events(struct tep_handle *tep,
+				   enum tep_event_sort_type);
+struct tep_event **tep_list_events_copy(struct tep_handle *tep,
+					enum tep_event_sort_type);
 struct tep_format_field **tep_event_common_fields(struct tep_event *event);
 struct tep_format_field **tep_event_fields(struct tep_event *event);
 
-- 
2.20.1


