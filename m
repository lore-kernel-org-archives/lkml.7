Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A32CC10F0B
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D63B2147C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554221208;
	bh=1jg6GJY253MjL7FG3UZTbAhGKjrcGGANXiJpFsK/h2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=PozhwxmEQgMdKNQoK8z7fQonsGmFx1m0tmAlKKwhAOcGmbwXdMaN0nd7i1XARdWpu
	 iaIHfCtNjrAAa6mVM83GLf//lQbSFGon2w+1Wjf2UTsawCV3DO+QKnJ22q/ULASoFF
	 3EHYpBJiclKK3FsxN+6XJGSvyjkDFGU9TV/1Iqps=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731036AbfDBQGq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 12:06:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:44508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730698AbfDBQGo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 12:06:44 -0400
Received: from quaco.ghostprotocols.net (unknown [187.65.94.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9043520856;
        Tue,  2 Apr 2019 16:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554221203;
        bh=1jg6GJY253MjL7FG3UZTbAhGKjrcGGANXiJpFsK/h2M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MBgdQ0qYPn4NmMRFyScN+pmAX0fBCRODUEt8DaYvvuCSDGCaPCuEg8WJZGSoVi5aY
         wY6S8kDFzGZb1Y/l88jEbaAwMiZigoyZ7uBVZ0C0u6ibz6ooLYEOkZcnNrleyqbRqs
         fMuZO3ASBAvNDb821MTjhmCk7vHRta7HGhFPjEVE=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 13/44] tools lib traceevent: Implement a new API, tep_list_events_copy()
Date:   Tue,  2 Apr 2019 13:05:18 -0300
Message-Id: <20190402160549.13544-14-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190402160549.13544-1-acme@kernel.org>
References: <20190402160549.13544-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tzvetomir Stoyanov <tstoyanov@vmware.com>

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

