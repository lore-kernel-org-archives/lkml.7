Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63019C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34271208E4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:45:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728957AbfDAQo7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 12:44:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:60224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728686AbfDAQnp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 12:43:45 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1D092171F;
        Mon,  1 Apr 2019 16:43:44 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.92)
        (envelope-from <rostedt@goodmis.org>)
        id 1hB02B-0004tM-PX; Mon, 01 Apr 2019 12:43:43 -0400
Message-Id: <20190401164343.679629539@goodmis.org>
User-Agent: quilt/0.65
Date:   Mon, 01 Apr 2019 12:43:12 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tzvetomir Stoyanov <tstoyanov@vmware.com>
Subject: [PATCH 07/15] tools/lib/traceevent: Implement new traceevent APIs for accessing
 struct tep_handler fields
References: <20190401164305.359125441@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tzvetomir Stoyanov <tstoyanov@vmware.com>

As struct tep_handler definition is not exposed as part of libtraceevent API, its fields
cannot be accessed directly by the library users. This patch implements new APIs, which
can be used to access the struct tep_handler fields:

tep_get_event()        - retrieves an event pointer at a specific index
tep_get_first_event()  - is modified to use tep_get_event()
tep_clear_flag()       - clears a tep handle flag
tep_test_flag()        - test if a given flag is set
tep_get_header_timestamp_size() - returns the size of the timestamp stored
                         in the header.
tep_get_cpus()         - returns the number of CPUs
tep_is_old_format()    - returns true if data was created by an
                         older kernel with the old data format
tep_set_print_raw()    - have the output print in the raw format
tep_set_test_filters() - debugging utility for testing tep filters

Link: http://lore.kernel.org/linux-trace-devel/20190325145017.30246-4-tstoyanov@vmware.com

Signed-off-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
[ Renamed some newly added "pevent" to "tep" ]
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 tools/lib/traceevent/event-parse-api.c | 106 ++++++++++++++++++++++++-
 tools/lib/traceevent/event-parse.h     |   6 ++
 2 files changed, 108 insertions(+), 4 deletions(-)

diff --git a/tools/lib/traceevent/event-parse-api.c b/tools/lib/traceevent/event-parse-api.c
index 3716a9142aef..2ac8b44854ce 100644
--- a/tools/lib/traceevent/event-parse-api.c
+++ b/tools/lib/traceevent/event-parse-api.c
@@ -8,6 +8,22 @@
 #include "event-parse-local.h"
 #include "event-utils.h"
 
+/**
+ * tep_get_event - returns the event with the given index
+ * @tep: a handle to the tep_handle
+ * @index: index of the requested event, in the range 0 .. nr_events
+ *
+ * This returns pointer to the element of the events array with the given index
+ * If @tep is NULL, or @index is not in the range 0 .. nr_events, NULL is returned.
+ */
+struct tep_event *tep_get_event(struct tep_handle *tep, int index)
+{
+	if (tep && tep->events && index < tep->nr_events)
+		return tep->events[index];
+
+	return NULL;
+}
+
 /**
  * tep_get_first_event - returns the first event in the events array
  * @tep: a handle to the tep_handle
@@ -17,10 +33,7 @@
  */
 struct tep_event *tep_get_first_event(struct tep_handle *tep)
 {
-	if (tep && tep->events)
-		return tep->events[0];
-
-	return NULL;
+	return tep_get_event(tep, 0);
 }
 
 /**
@@ -51,6 +64,34 @@ void tep_set_flag(struct tep_handle *tep, int flag)
 		tep->flags |= flag;
 }
 
+/**
+ * tep_clear_flag - clear event parser flag
+ * @tep: a handle to the tep_handle
+ * @flag: flag to be cleared
+ *
+ * This clears a tep flag
+ */
+void tep_clear_flag(struct tep_handle *tep, enum tep_flag flag)
+{
+	if (tep)
+		tep->flags &= ~flag;
+}
+
+/**
+ * tep_test_flag - check the state of event parser flag
+ * @tep: a handle to the tep_handle
+ * @flag: flag to be checked
+ *
+ * This returns the state of the requested tep flag.
+ * Returns: true if the flag is set, false otherwise.
+ */
+bool tep_test_flag(struct tep_handle *tep, enum tep_flag flag)
+{
+	if (tep)
+		return (tep->flags & flag);
+	return false;
+}
+
 unsigned short tep_data2host2(struct tep_handle *pevent, unsigned short data)
 {
 	unsigned short swap;
@@ -113,6 +154,20 @@ int tep_get_header_page_size(struct tep_handle *pevent)
 	return 0;
 }
 
+/**
+ * tep_get_header_timestamp_size - get size of the time stamp in the header page
+ * @tep: a handle to the tep_handle
+ *
+ * This returns size of the time stamp in the header page
+ * If @tep is NULL, 0 is returned.
+ */
+int tep_get_header_timestamp_size(struct tep_handle *tep)
+{
+	if (tep)
+		return tep->header_page_ts_size;
+	return 0;
+}
+
 /**
  * tep_get_cpus - get the number of CPUs
  * @pevent: a handle to the tep_handle
@@ -273,3 +328,46 @@ void tep_set_latency_format(struct tep_handle *pevent, int lat)
 	if (pevent)
 		pevent->latency_format = lat;
 }
+
+/**
+ * tep_is_old_format - get if an old kernel is used
+ * @tep: a handle to the tep_handle
+ *
+ * This returns true, if an old kernel is used to generate the tracing events or
+ * false if a new kernel is used. Old kernels did not have header page info.
+ * If @tep is NULL, false is returned.
+ */
+bool tep_is_old_format(struct tep_handle *tep)
+{
+	if (tep)
+		return !!(tep->old_format);
+	return false;
+}
+
+/**
+ * tep_set_print_raw - set a flag to force print in raw format
+ * @tep: a handle to the tep_handle
+ * @print_raw: the new value of the print_raw flag
+ *
+ * This sets a flag to force print in raw format
+ */
+void tep_set_print_raw(struct tep_handle *tep, int print_raw)
+{
+	if (tep)
+		tep->print_raw = print_raw;
+}
+
+/**
+ * tep_set_test_filters - set a flag to test a filter string
+ * @tep: a handle to the tep_handle
+ * @test_filters: the new value of the test_filters flag
+ *
+ * This sets a flag to test a filter string. If this flag is set, when
+ * tep_filter_add_filter_str() API as called,it will print the filter string
+ * instead of adding it.
+ */
+void tep_set_test_filters(struct tep_handle *tep, int test_filters)
+{
+	if (tep)
+		tep->test_filters = test_filters;
+}
diff --git a/tools/lib/traceevent/event-parse.h b/tools/lib/traceevent/event-parse.h
index 41159358abc2..be082f9692f1 100644
--- a/tools/lib/traceevent/event-parse.h
+++ b/tools/lib/traceevent/event-parse.h
@@ -409,6 +409,8 @@ void tep_print_plugins(struct trace_seq *s,
 typedef char *(tep_func_resolver_t)(void *priv,
 				    unsigned long long *addrp, char **modp);
 void tep_set_flag(struct tep_handle *tep, int flag);
+void tep_clear_flag(struct tep_handle *tep, enum tep_flag flag);
+bool tep_check_flags(struct tep_handle *tep, enum tep_flag flags);
 
 static inline int tep_host_bigendian(void)
 {
@@ -568,6 +570,10 @@ void tep_set_host_bigendian(struct tep_handle *pevent, enum tep_endian endian);
 int tep_is_latency_format(struct tep_handle *pevent);
 void tep_set_latency_format(struct tep_handle *pevent, int lat);
 int tep_get_header_page_size(struct tep_handle *pevent);
+int tep_get_header_timestamp_size(struct tep_handle *tep);
+bool tep_is_old_format(struct tep_handle *tep);
+void tep_set_print_raw(struct tep_handle *tep, int print_raw);
+void tep_set_test_filters(struct tep_handle *tep, int test_filters);
 
 struct tep_handle *tep_alloc(void);
 void tep_free(struct tep_handle *pevent);
-- 
2.20.1


