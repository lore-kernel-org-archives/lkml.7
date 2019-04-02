Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B17E5C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:07:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D363208E4
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 16:07:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554221236;
	bh=E80xm14D9MEgTMdtTS0YA5fr6ub/3EyxQ9cbl/oV9kA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=irgqtNW32A5U4UiTp6B2FmB6mkzfV8EdJZe4naDjdMNjiydk1quTmy0VZf+SAWybD
	 DYiGtXddkDkljTw4s3DhyyHu+LtvnHCTwQ5u8EgN2ykk1oL4Gok4skx25OnwEVZILI
	 aSwaz3S6s737N3246uM29oAYceSqMqBFAc0CfhnI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731304AbfDBQHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 12:07:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:45124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731198AbfDBQHM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 12:07:12 -0400
Received: from quaco.ghostprotocols.net (unknown [187.65.94.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B174720857;
        Tue,  2 Apr 2019 16:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554221230;
        bh=E80xm14D9MEgTMdtTS0YA5fr6ub/3EyxQ9cbl/oV9kA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Okey3+nAOaSxeNa3YSx5xSBfdc5HUUvEgOUjWMfMtgOijpeVj/4c7fyoR859cHJbl
         NO/f5g4w0DK7nT4Hcj6jHQ52aCna9iHebYAMZ5/HPNV23FrI6VOZOK11B+WVooe8Ud
         DnTafP46rrWymEf1RGjP9ThWQ6o3gWiYpJK25nMY=
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
Subject: [PATCH 21/44] tools tools, tools lib traceevent: Make traceevent APIs more consistent
Date:   Tue,  2 Apr 2019 13:05:26 -0300
Message-Id: <20190402160549.13544-22-acme@kernel.org>
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

Rename some traceevent APIs for consistency:

tep_pid_is_registered() to tep_is_pid_registered()
tep_file_bigendian() to tep_is_file_bigendian()

  to make the names and return values consistent with other tep_is_... APIs

tep_data_lat_fmt() to tep_data_latency_format()

  to make the name more descriptive

tep_host_bigendian() to tep_is_bigendian()
tep_set_host_bigendian() to tep_set_local_bigendian()
tep_is_host_bigendian() to tep_is_local_bigendian()

  "host" can be confused with VMs, and "local" is about the local
  machine. All tep_is_..._bigendian(struct tep_handle *tep) APIs return
  the saved data in the tep handle, while tep_is_bigendian() returns
  the running machine's endianness.

All tep_is_... functions are modified to return bool value, instead of int.

Signed-off-by: Tzvetomir Stoyanov <tstoyanov@vmware.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lkml.kernel.org/r/20190327141946.4353-2-tstoyanov@vmware.com
Link: http://lkml.kernel.org/r/20190401164344.288624897@goodmis.org
[ Removed some extra parenthesis around return statements ]
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/traceevent/event-parse-api.c | 40 +++++++++++++-------------
 tools/lib/traceevent/event-parse.c     | 26 ++++++++---------
 tools/lib/traceevent/event-parse.h     | 16 +++++------
 tools/lib/traceevent/plugin_kvm.c      |  4 +--
 tools/perf/util/trace-event-read.c     |  2 +-
 tools/perf/util/trace-event.c          |  4 +--
 6 files changed, 46 insertions(+), 46 deletions(-)

diff --git a/tools/lib/traceevent/event-parse-api.c b/tools/lib/traceevent/event-parse-api.c
index 002b3f73862b..f7184575f0d9 100644
--- a/tools/lib/traceevent/event-parse-api.c
+++ b/tools/lib/traceevent/event-parse-api.c
@@ -155,10 +155,10 @@ int tep_get_header_page_size(struct tep_handle *pevent)
 }
 
 /**
- * tep_get_header_timestamp_size - get size of the time stamp in the header page
+ * tep_get_header_timestamp_size - get size of the timestamp in the header page
  * @tep: a handle to the tep_handle
  *
- * This returns size of the time stamp in the header page
+ * This returns size of the timestamp in the header page
  * If @tep is NULL, 0 is returned.
  */
 int tep_get_header_timestamp_size(struct tep_handle *tep)
@@ -249,17 +249,17 @@ void tep_set_page_size(struct tep_handle *pevent, int _page_size)
 }
 
 /**
- * tep_file_bigendian - get if the file is in big endian order
+ * tep_is_file_bigendian - return the endian of the file
  * @pevent: a handle to the tep_handle
  *
- * This returns if the file is in big endian order
- * If @pevent is NULL, 0 is returned.
+ * This returns true if the file is in big endian order
+ * If @pevent is NULL, false is returned.
  */
-int tep_file_bigendian(struct tep_handle *pevent)
+bool tep_is_file_bigendian(struct tep_handle *pevent)
 {
 	if (pevent)
-		return pevent->file_bigendian;
-	return 0;
+		return pevent->file_bigendian == TEP_BIG_ENDIAN;
+	return false;
 }
 
 /**
@@ -276,27 +276,27 @@ void tep_set_file_bigendian(struct tep_handle *pevent, enum tep_endian endian)
 }
 
 /**
- * tep_is_host_bigendian - get if the order of the current host is big endian
+ * tep_is_local_bigendian - return the endian of the saved local machine
  * @pevent: a handle to the tep_handle
  *
- * This gets if the order of the current host is big endian
- * If @pevent is NULL, 0 is returned.
+ * This returns true if the saved local machine in @pevent is big endian.
+ * If @pevent is NULL, false is returned.
  */
-int tep_is_host_bigendian(struct tep_handle *pevent)
+bool tep_is_local_bigendian(struct tep_handle *pevent)
 {
 	if (pevent)
-		return pevent->host_bigendian;
+		return pevent->host_bigendian == TEP_BIG_ENDIAN;
 	return 0;
 }
 
 /**
- * tep_set_host_bigendian - set the order of the local host
+ * tep_set_local_bigendian - set the stored local machine endian order
  * @pevent: a handle to the tep_handle
  * @endian: non zero, if the local host has big endian order
  *
- * This sets the order of the local host
+ * This sets the endian order for the local machine.
  */
-void tep_set_host_bigendian(struct tep_handle *pevent, enum tep_endian endian)
+void tep_set_local_bigendian(struct tep_handle *pevent, enum tep_endian endian)
 {
 	if (pevent)
 		pevent->host_bigendian = endian;
@@ -306,14 +306,14 @@ void tep_set_host_bigendian(struct tep_handle *pevent, enum tep_endian endian)
  * tep_is_latency_format - get if the latency output format is configured
  * @pevent: a handle to the tep_handle
  *
- * This gets if the latency output format is configured
- * If @pevent is NULL, 0 is returned.
+ * This returns true if the latency output format is configured
+ * If @pevent is NULL, false is returned.
  */
-int tep_is_latency_format(struct tep_handle *pevent)
+bool tep_is_latency_format(struct tep_handle *pevent)
 {
 	if (pevent)
 		return pevent->latency_format;
-	return 0;
+	return false;
 }
 
 /**
diff --git a/tools/lib/traceevent/event-parse.c b/tools/lib/traceevent/event-parse.c
index 000ab7514be7..8836702122be 100644
--- a/tools/lib/traceevent/event-parse.c
+++ b/tools/lib/traceevent/event-parse.c
@@ -199,23 +199,23 @@ static const char *find_cmdline(struct tep_handle *pevent, int pid)
 }
 
 /**
- * tep_pid_is_registered - return if a pid has a cmdline registered
+ * tep_is_pid_registered - return if a pid has a cmdline registered
  * @pevent: handle for the pevent
  * @pid: The pid to check if it has a cmdline registered with.
  *
- * Returns 1 if the pid has a cmdline mapped to it
- * 0 otherwise.
+ * Returns true if the pid has a cmdline mapped to it
+ * false otherwise.
  */
-int tep_pid_is_registered(struct tep_handle *pevent, int pid)
+bool tep_is_pid_registered(struct tep_handle *pevent, int pid)
 {
 	const struct tep_cmdline *comm;
 	struct tep_cmdline key;
 
 	if (!pid)
-		return 1;
+		return true;
 
 	if (!pevent->cmdlines && cmdline_init(pevent))
-		return 0;
+		return false;
 
 	key.pid = pid;
 
@@ -223,8 +223,8 @@ int tep_pid_is_registered(struct tep_handle *pevent, int pid)
 		       sizeof(*pevent->cmdlines), cmdline_cmp);
 
 	if (comm)
-		return 1;
-	return 0;
+		return true;
+	return false;
 }
 
 /*
@@ -5172,7 +5172,7 @@ static void pretty_print(struct trace_seq *s, void *data, int size, struct tep_e
 }
 
 /**
- * tep_data_lat_fmt - parse the data for the latency format
+ * tep_data_latency_format - parse the data for the latency format
  * @pevent: a handle to the pevent
  * @s: the trace_seq to write to
  * @record: the record to read from
@@ -5181,8 +5181,8 @@ static void pretty_print(struct trace_seq *s, void *data, int size, struct tep_e
  * need rescheduling, in hard/soft interrupt, preempt count
  * and lock depth) and places it into the trace_seq.
  */
-void tep_data_lat_fmt(struct tep_handle *pevent,
-		      struct trace_seq *s, struct tep_record *record)
+void tep_data_latency_format(struct tep_handle *pevent,
+			     struct trace_seq *s, struct tep_record *record)
 {
 	static int check_lock_depth = 1;
 	static int check_migrate_disable = 1;
@@ -5532,7 +5532,7 @@ void tep_print_event_time(struct tep_handle *pevent, struct trace_seq *s,
 	}
 
 	if (pevent->latency_format) {
-		tep_data_lat_fmt(pevent, s, record);
+		tep_data_latency_format(pevent, s, record);
 	}
 
 	if (use_usec_format) {
@@ -6827,7 +6827,7 @@ struct tep_handle *tep_alloc(void)
 
 	if (pevent) {
 		pevent->ref_count = 1;
-		pevent->host_bigendian = tep_host_bigendian();
+		pevent->host_bigendian = tep_is_bigendian();
 	}
 
 	return pevent;
diff --git a/tools/lib/traceevent/event-parse.h b/tools/lib/traceevent/event-parse.h
index 3833d1384599..d473dc557978 100644
--- a/tools/lib/traceevent/event-parse.h
+++ b/tools/lib/traceevent/event-parse.h
@@ -412,7 +412,7 @@ void tep_set_flag(struct tep_handle *tep, int flag);
 void tep_clear_flag(struct tep_handle *tep, enum tep_flag flag);
 bool tep_check_flags(struct tep_handle *tep, enum tep_flag flags);
 
-static inline int tep_host_bigendian(void)
+static inline int tep_is_bigendian(void)
 {
 	unsigned char str[] = { 0x1, 0x2, 0x3, 0x4 };
 	unsigned int val;
@@ -440,7 +440,7 @@ int tep_register_function(struct tep_handle *pevent, char *name,
 			  unsigned long long addr, char *mod);
 int tep_register_print_string(struct tep_handle *pevent, const char *fmt,
 			      unsigned long long addr);
-int tep_pid_is_registered(struct tep_handle *pevent, int pid);
+bool tep_is_pid_registered(struct tep_handle *pevent, int pid);
 
 void tep_print_event_task(struct tep_handle *pevent, struct trace_seq *s,
 			  struct tep_event *event,
@@ -525,8 +525,8 @@ tep_find_event_by_name(struct tep_handle *pevent, const char *sys, const char *n
 struct tep_event *
 tep_find_event_by_record(struct tep_handle *pevent, struct tep_record *record);
 
-void tep_data_lat_fmt(struct tep_handle *pevent,
-		      struct trace_seq *s, struct tep_record *record);
+void tep_data_latency_format(struct tep_handle *pevent,
+			     struct trace_seq *s, struct tep_record *record);
 int tep_data_type(struct tep_handle *pevent, struct tep_record *rec);
 int tep_data_pid(struct tep_handle *pevent, struct tep_record *rec);
 int tep_data_preempt_count(struct tep_handle *pevent, struct tep_record *rec);
@@ -563,11 +563,11 @@ int tep_get_long_size(struct tep_handle *pevent);
 void tep_set_long_size(struct tep_handle *pevent, int long_size);
 int tep_get_page_size(struct tep_handle *pevent);
 void tep_set_page_size(struct tep_handle *pevent, int _page_size);
-int tep_file_bigendian(struct tep_handle *pevent);
+bool tep_is_file_bigendian(struct tep_handle *pevent);
 void tep_set_file_bigendian(struct tep_handle *pevent, enum tep_endian endian);
-int tep_is_host_bigendian(struct tep_handle *pevent);
-void tep_set_host_bigendian(struct tep_handle *pevent, enum tep_endian endian);
-int tep_is_latency_format(struct tep_handle *pevent);
+bool tep_is_local_bigendian(struct tep_handle *pevent);
+void tep_set_local_bigendian(struct tep_handle *pevent, enum tep_endian endian);
+bool tep_is_latency_format(struct tep_handle *pevent);
 void tep_set_latency_format(struct tep_handle *pevent, int lat);
 int tep_get_header_page_size(struct tep_handle *pevent);
 int tep_get_header_timestamp_size(struct tep_handle *tep);
diff --git a/tools/lib/traceevent/plugin_kvm.c b/tools/lib/traceevent/plugin_kvm.c
index 64b9c25a1fd3..688e5d97d7a7 100644
--- a/tools/lib/traceevent/plugin_kvm.c
+++ b/tools/lib/traceevent/plugin_kvm.c
@@ -389,8 +389,8 @@ static int kvm_mmu_print_role(struct trace_seq *s, struct tep_record *record,
 	 * We can only use the structure if file is of the same
 	 * endianness.
 	 */
-	if (tep_file_bigendian(event->pevent) ==
-	    tep_is_host_bigendian(event->pevent)) {
+	if (tep_is_file_bigendian(event->pevent) ==
+	    tep_is_local_bigendian(event->pevent)) {
 
 		trace_seq_printf(s, "%u q%u%s %s%s %spae %snxe %swp%s%s%s",
 				 role.level,
diff --git a/tools/perf/util/trace-event-read.c b/tools/perf/util/trace-event-read.c
index efe2f58cff4e..48d53d8e3e16 100644
--- a/tools/perf/util/trace-event-read.c
+++ b/tools/perf/util/trace-event-read.c
@@ -442,7 +442,7 @@ ssize_t trace_report(int fd, struct trace_event *tevent, bool __repipe)
 
 	tep_set_flag(pevent, TEP_NSEC_OUTPUT);
 	tep_set_file_bigendian(pevent, file_bigendian);
-	tep_set_host_bigendian(pevent, host_bigendian);
+	tep_set_local_bigendian(pevent, host_bigendian);
 
 	if (do_read(buf, 1) < 0)
 		goto out;
diff --git a/tools/perf/util/trace-event.c b/tools/perf/util/trace-event.c
index cbe0dd758e3a..01b9d89bf5bf 100644
--- a/tools/perf/util/trace-event.c
+++ b/tools/perf/util/trace-event.c
@@ -40,7 +40,7 @@ int trace_event__init(struct trace_event *t)
 
 static int trace_event__init2(void)
 {
-	int be = tep_host_bigendian();
+	int be = tep_is_bigendian();
 	struct tep_handle *pevent;
 
 	if (trace_event__init(&tevent))
@@ -49,7 +49,7 @@ static int trace_event__init2(void)
 	pevent = tevent.pevent;
 	tep_set_flag(pevent, TEP_NSEC_OUTPUT);
 	tep_set_file_bigendian(pevent, be);
-	tep_set_host_bigendian(pevent, be);
+	tep_set_local_bigendian(pevent, be);
 	tevent_initialized = true;
 	return 0;
 }
-- 
2.20.1

