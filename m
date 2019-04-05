Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BFFFC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D55A2186A
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 11:46:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730053AbfDELqC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 07:46:02 -0400
Received: from terminus.zytor.com ([198.137.202.136]:39055 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726124AbfDELqB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 07:46:01 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x35Bjb912737280
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 5 Apr 2019 04:45:37 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x35BjagN2737277;
        Fri, 5 Apr 2019 04:45:36 -0700
Date:   Fri, 5 Apr 2019 04:45:36 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Tzvetomir Stoyanov <tipbot@zytor.com>
Message-ID: <tip-80c5526c8544ae76cba31fb9702ab8accac1f0f3@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, rostedt@goodmis.org, hpa@zytor.com,
        namhyung@kernel.org, acme@redhat.com, jolsa@redhat.com,
        tstoyanov@vmware.com, tglx@linutronix.de,
        akpm@linux-foundation.org, mingo@kernel.org
Reply-To: rostedt@goodmis.org, hpa@zytor.com, namhyung@kernel.org,
          tstoyanov@vmware.com, acme@redhat.com, jolsa@redhat.com,
          tglx@linutronix.de, mingo@kernel.org, akpm@linux-foundation.org,
          linux-kernel@vger.kernel.org
In-Reply-To: <20190401164343.679629539@goodmis.org>
References: <20190401164343.679629539@goodmis.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] tools lib traceevent: Implement new traceevent APIs
 for accessing struct tep_handler fields
Git-Commit-ID: 80c5526c8544ae76cba31fb9702ab8accac1f0f3
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

Commit-ID:  80c5526c8544ae76cba31fb9702ab8accac1f0f3
Gitweb:     https://git.kernel.org/tip/80c5526c8544ae76cba31fb9702ab8accac1f0f3
Author:     Tzvetomir Stoyanov <tstoyanov@vmware.com>
AuthorDate: Mon, 1 Apr 2019 12:43:12 -0400
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 1 Apr 2019 15:18:09 -0300

tools lib traceevent: Implement new traceevent APIs for accessing struct tep_handler fields

As struct tep_handler definition is not exposed as part of libtraceevent
API, its fields cannot be accessed directly by the library users. This
patch implements new APIs, which can be used to access the struct
tep_handler fields:

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

Signed-off-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lore.kernel.org/linux-trace-devel/20190325145017.30246-4-tstoyanov@vmware.com
Link: http://lkml.kernel.org/r/20190401164343.679629539@goodmis.org
[ Renamed some newly added "pevent" to "tep" ]
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/event-parse-api.c | 106 +++++++++++++++++++++++++++++++--
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
