Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50ED5C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 23:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1221121841
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 23:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="VJi0V1wq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731339AbfGQXEQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 19:04:16 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34567 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727468AbfGQXEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 19:04:16 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6HN47ft1725415
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 17 Jul 2019 16:04:08 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6HN47ft1725415
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563404648;
        bh=3q+Nsd6L8JcjTGJBOqbYA+qwSRCld5x7hUMHLiDU/YM=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=VJi0V1wqva6ft3VM9qvQD22waeqIxaAoGgA2+58cByVL5zykWEdXbjA6U9/mE9UK2
         EVA9dP/m9GoGlH5+69CqCYL5izxnS6WaCprArBkF+5sTdhiKrZAyo/I+x1yggvli+/
         LpfykiIzNa/UnIK1CNy12qr4yFp2N7XtxjinE5tHGebQxXDFINZ4odJ5wCGJrnEiIc
         6T0eGl26t+87HXbc0/VoOFAhsO60oTQHFHHKxMrHFdrZ3Tk9Kpis5hNhg1W3g4Gvf+
         BHy0gVT9HiApQgC4MyqaW2dr07YWn+soB/WB4g4HB1wj2hxSUui57VX16Ilg4gjuMi
         oKxW0n9RRj5cg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6HN47IZ1725412;
        Wed, 17 Jul 2019 16:04:07 -0700
Date:   Wed, 17 Jul 2019 16:04:07 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-abde8722d9b0a317935506d9824e26f1aef6c24a@git.kernel.org>
Cc:     jolsa@redhat.com, acme@redhat.com, mingo@kernel.org,
        tglx@linutronix.de, adrian.hunter@intel.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Reply-To: jolsa@redhat.com, mingo@kernel.org, acme@redhat.com,
          tglx@linutronix.de, linux-kernel@vger.kernel.org, hpa@zytor.com,
          adrian.hunter@intel.com
In-Reply-To: <20190710085810.1650-20-adrian.hunter@intel.com>
References: <20190710085810.1650-20-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf db-export: Export switch events
Git-Commit-ID: abde8722d9b0a317935506d9824e26f1aef6c24a
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

Commit-ID:  abde8722d9b0a317935506d9824e26f1aef6c24a
Gitweb:     https://git.kernel.org/tip/abde8722d9b0a317935506d9824e26f1aef6c24a
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Wed, 10 Jul 2019 11:58:08 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 10 Jul 2019 12:35:38 -0300

perf db-export: Export switch events

Export details of switch events including the threads and their current
comms.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190710085810.1650-20-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/db-export.c                        | 89 ++++++++++++++++++++++
 tools/perf/util/db-export.h                        |  8 ++
 .../util/scripting-engines/trace-event-python.c    | 41 ++++++++++
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
