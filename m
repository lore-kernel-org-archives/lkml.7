Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13173C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 21:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D023120449
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 21:14:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563225248;
	bh=LO3pygkBv4/4xP2YOxH+LsVsWNCYNFBIb+ycpqaDld8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Qyks89rUgeLniOM6Rn1gaibRxRkWh2JrxCUiKbu8ssJY1J+lYZv08/jA2+gay2zY1
	 77008xSR0ZY5TgjEsJdpqkmbgN+400M+HcgKZOl9XNag4LNHaepe+IQk+U8yxJ3QFL
	 teggy8D5nl/McvH5/xjSFwuv5uLlDhEsmoEnw0UQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733291AbfGOVOH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 17:14:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:44942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731486AbfGOVOG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 17:14:06 -0400
Received: from quaco.ghostprotocols.net (179-240-129-12.3g.claro.net.br [179.240.129.12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6797820665;
        Mon, 15 Jul 2019 21:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563225244;
        bh=LO3pygkBv4/4xP2YOxH+LsVsWNCYNFBIb+ycpqaDld8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zHmLHTR5AVLN6/Lhbkhz9EQlrOXDCGt5xuPBSPtuKHcin4uUYbKQHk0ONEhjIUbSd
         X7ok9VGIbuiGA5E3SYHDAENHm/+b9t19XDegHL7j32UXyo/GS2MTaLNmG1EkaIzAvk
         vXDcD5Zo0ZiKY+1tOmRnetjMJ2DixXhQ1zNsS88Y=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 22/28] perf db-export: Export switch events
Date:   Mon, 15 Jul 2019 18:11:54 -0300
Message-Id: <20190715211200.10984-23-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190715211200.10984-1-acme@kernel.org>
References: <20190715211200.10984-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Export details of switch events including the threads and their current
comms.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190710085810.1650-20-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/db-export.c                   | 89 +++++++++++++++++++
 tools/perf/util/db-export.h                   |  8 ++
 .../scripting-engines/trace-event-python.c    | 41 +++++++++
 3 files changed, 138 insertions(+)

diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
index e6a9c450133e..ffbb3e7d3288 100644
--- a/tools/perf/util/db-export.c
+++ b/tools/perf/util/db-export.c
@@ -519,3 +519,92 @@ int db_export__call_return(struct db_export *dbe, struct call_return *cr,
 
 	return 0;
 }
+
+static int db_export__pid_tid(struct db_export *dbe, struct machine *machine,
+			      pid_t pid, pid_t tid, u64 *db_id,
+			      struct comm **comm_ptr, bool *is_idle)
+{
+	struct thread *thread = machine__find_thread(machine, pid, tid);
+	struct thread *main_thread;
+	int err = 0;
+
+	if (!thread || !thread->comm_set)
+		goto out_put;
+
+	*is_idle = !thread->pid_ && !thread->tid;
+
+	main_thread = thread__main_thread(machine, thread);
+
+	err = db_export__threads(dbe, thread, main_thread, machine, comm_ptr);
+
+	*db_id = thread->db_id;
+
+	thread__put(main_thread);
+out_put:
+	thread__put(thread);
+
+	return err;
+}
+
+int db_export__switch(struct db_export *dbe, union perf_event *event,
+		      struct perf_sample *sample, struct machine *machine)
+{
+	bool out = event->header.misc & PERF_RECORD_MISC_SWITCH_OUT;
+	bool out_preempt = out &&
+		(event->header.misc & PERF_RECORD_MISC_SWITCH_OUT_PREEMPT);
+	int flags = out | (out_preempt << 1);
+	bool is_idle_a = false, is_idle_b = false;
+	u64 th_a_id = 0, th_b_id = 0;
+	u64 comm_out_id, comm_in_id;
+	struct comm *comm_a = NULL;
+	struct comm *comm_b = NULL;
+	u64 th_out_id, th_in_id;
+	u64 db_id;
+	int err;
+
+	err = db_export__machine(dbe, machine);
+	if (err)
+		return err;
+
+	err = db_export__pid_tid(dbe, machine, sample->pid, sample->tid,
+				 &th_a_id, &comm_a, &is_idle_a);
+	if (err)
+		return err;
+
+	if (event->header.type == PERF_RECORD_SWITCH_CPU_WIDE) {
+		pid_t pid = event->context_switch.next_prev_pid;
+		pid_t tid = event->context_switch.next_prev_tid;
+
+		err = db_export__pid_tid(dbe, machine, pid, tid, &th_b_id,
+					 &comm_b, &is_idle_b);
+		if (err)
+			return err;
+	}
+
+	/*
+	 * Do not export if both threads are unknown (i.e. not being traced),
+	 * or one is unknown and the other is the idle task.
+	 */
+	if ((!th_a_id || is_idle_a) && (!th_b_id || is_idle_b))
+		return 0;
+
+	db_id = ++dbe->context_switch_last_db_id;
+
+	if (out) {
+		th_out_id   = th_a_id;
+		th_in_id    = th_b_id;
+		comm_out_id = comm_a ? comm_a->db_id : 0;
+		comm_in_id  = comm_b ? comm_b->db_id : 0;
+	} else {
+		th_out_id   = th_b_id;
+		th_in_id    = th_a_id;
+		comm_out_id = comm_b ? comm_b->db_id : 0;
+		comm_in_id  = comm_a ? comm_a->db_id : 0;
+	}
+
+	if (dbe->export_context_switch)
+		return dbe->export_context_switch(dbe, db_id, machine, sample,
+						  th_out_id, comm_out_id,
+						  th_in_id, comm_in_id, flags);
+	return 0;
+}
diff --git a/tools/perf/util/db-export.h b/tools/perf/util/db-export.h
index f5f0865f07e1..ba1f62a5fe10 100644
--- a/tools/perf/util/db-export.h
+++ b/tools/perf/util/db-export.h
@@ -57,6 +57,11 @@ struct db_export {
 	int (*export_call_path)(struct db_export *dbe, struct call_path *cp);
 	int (*export_call_return)(struct db_export *dbe,
 				  struct call_return *cr);
+	int (*export_context_switch)(struct db_export *dbe, u64 db_id,
+				     struct machine *machine,
+				     struct perf_sample *sample,
+				     u64 th_out_id, u64 comm_out_id,
+				     u64 th_in_id, u64 comm_in_id, int flags);
 	struct call_return_processor *crp;
 	struct call_path_root *cpr;
 	u64 evsel_last_db_id;
@@ -69,6 +74,7 @@ struct db_export {
 	u64 sample_last_db_id;
 	u64 call_path_last_db_id;
 	u64 call_return_last_db_id;
+	u64 context_switch_last_db_id;
 };
 
 int db_export__init(struct db_export *dbe);
@@ -98,5 +104,7 @@ int db_export__branch_types(struct db_export *dbe);
 int db_export__call_path(struct db_export *dbe, struct call_path *cp);
 int db_export__call_return(struct db_export *dbe, struct call_return *cr,
 			   u64 *parent_db_id);
+int db_export__switch(struct db_export *dbe, union perf_event *event,
+		      struct perf_sample *sample, struct machine *machine);
 
 #endif
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 28167e938cef..25dc1d765553 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -113,6 +113,7 @@ struct tables {
 	PyObject		*call_path_handler;
 	PyObject		*call_return_handler;
 	PyObject		*synth_handler;
+	PyObject		*context_switch_handler;
 	bool			db_export_mode;
 };
 
@@ -1237,6 +1238,34 @@ static int python_export_call_return(struct db_export *dbe,
 	return 0;
 }
 
+static int python_export_context_switch(struct db_export *dbe, u64 db_id,
+					struct machine *machine,
+					struct perf_sample *sample,
+					u64 th_out_id, u64 comm_out_id,
+					u64 th_in_id, u64 comm_in_id, int flags)
+{
+	struct tables *tables = container_of(dbe, struct tables, dbe);
+	PyObject *t;
+
+	t = tuple_new(9);
+
+	tuple_set_u64(t, 0, db_id);
+	tuple_set_u64(t, 1, machine->db_id);
+	tuple_set_u64(t, 2, sample->time);
+	tuple_set_s32(t, 3, sample->cpu);
+	tuple_set_u64(t, 4, th_out_id);
+	tuple_set_u64(t, 5, comm_out_id);
+	tuple_set_u64(t, 6, th_in_id);
+	tuple_set_u64(t, 7, comm_in_id);
+	tuple_set_s32(t, 8, flags);
+
+	call_object(tables->context_switch_handler, t, "context_switch");
+
+	Py_DECREF(t);
+
+	return 0;
+}
+
 static int python_process_call_return(struct call_return *cr, u64 *parent_db_id,
 				      void *data)
 {
@@ -1300,6 +1329,16 @@ static void python_process_event(union perf_event *event,
 	}
 }
 
+static void python_process_switch(union perf_event *event,
+				  struct perf_sample *sample,
+				  struct machine *machine)
+{
+	struct tables *tables = &tables_global;
+
+	if (tables->db_export_mode)
+		db_export__switch(&tables->dbe, event, sample, machine);
+}
+
 static void get_handler_name(char *str, size_t size,
 			     struct perf_evsel *evsel)
 {
@@ -1515,6 +1554,7 @@ static void set_table_handlers(struct tables *tables)
 	SET_TABLE_HANDLER(sample);
 	SET_TABLE_HANDLER(call_path);
 	SET_TABLE_HANDLER(call_return);
+	SET_TABLE_HANDLER(context_switch);
 
 	/*
 	 * Synthesized events are samples but with architecture-specific data
@@ -1833,6 +1873,7 @@ struct scripting_ops python_scripting_ops = {
 	.flush_script		= python_flush_script,
 	.stop_script		= python_stop_script,
 	.process_event		= python_process_event,
+	.process_switch		= python_process_switch,
 	.process_stat		= python_process_stat,
 	.process_stat_interval	= python_process_stat_interval,
 	.generate_script	= python_generate_script,
-- 
2.21.0

