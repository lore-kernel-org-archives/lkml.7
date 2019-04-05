Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13FB6C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5D122186A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:43:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbfDELnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 07:43:06 -0400
Received: from terminus.zytor.com ([198.137.202.136]:54447 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbfDELnG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 07:43:06 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x35BgfhG2735231
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 5 Apr 2019 04:42:41 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x35BgfUc2735225;
        Fri, 5 Apr 2019 04:42:41 -0700
Date:   Fri, 5 Apr 2019 04:42:41 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Tzvetomir Stoyanov <tipbot@zytor.com>
Message-ID: <tip-6699ed712a97f70267e017f509126b890f6f6b28@git.kernel.org>
Cc:     mingo@kernel.org, rostedt@goodmis.org, namhyung@kernel.org,
        tglx@linutronix.de, jolsa@redhat.com, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, acme@redhat.com, tstoyanov@vmware.com,
        hpa@zytor.com
Reply-To: linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
          acme@redhat.com, hpa@zytor.com, tstoyanov@vmware.com,
          namhyung@kernel.org, tglx@linutronix.de, jolsa@redhat.com,
          mingo@kernel.org, rostedt@goodmis.org
In-Reply-To: <20190401164343.117437443@goodmis.org>
References: <20190401164343.117437443@goodmis.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] tools lib traceevent: Implement a new API,
 tep_list_events_copy()
Git-Commit-ID: 6699ed712a97f70267e017f509126b890f6f6b28
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  6699ed712a97f70267e017f509126b890f6f6b28
Gitweb:     https://git.kernel.org/tip/6699ed712a97f70267e017f509126b890f6f6b28
Author:     Tzvetomir Stoyanov <tstoyanov@vmware.com>
AuthorDate: Mon, 1 Apr 2019 12:43:08 -0400
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 1 Apr 2019 15:18:09 -0300

tools lib traceevent: Implement a new API, tep_list_events_copy()

Existing API tep_list_events() is not thread safe, it uses the internal
array sort_events to keep cache of the sorted events and reuses it. This
patch implements a new API, tep_list_events_copy(), which allocates new
sorted array each time it is called. It could be used when a sorted
events functionality is needed in thread safe use cases. It is up to the
caller to free the array.

Signed-off-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lore.kernel.org/linux-trace-devel/20181218133013.31094-1-tstoyanov@vmware.com
Link: http://lkml.kernel.org/r/20190401164343.117437443@goodmis.org
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/event-parse.c | 109 +++++++++++++++++++++++++++++--------
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
 
