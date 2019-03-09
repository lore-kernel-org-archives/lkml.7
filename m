Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A67AC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 19:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24E6220815
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 19:51:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbfCITvh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Mar 2019 14:51:37 -0500
Received: from terminus.zytor.com ([198.137.202.136]:36351 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726355AbfCITvh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Mar 2019 14:51:37 -0500
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x29JpToj3201148
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 9 Mar 2019 11:51:29 -0800
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x29JpTMx3201145;
        Sat, 9 Mar 2019 11:51:29 -0800
Date:   Sat, 9 Mar 2019 11:51:29 -0800
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-6j7tzdxo67cox6kan7k22oo6@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, jolsa@redhat.com, mingo@kernel.org,
        acme@redhat.com, hpa@zytor.com, tglx@linutronix.de,
        adrian.hunter@intel.com
Reply-To: adrian.hunter@intel.com, tglx@linutronix.de, mingo@kernel.org,
          hpa@zytor.com, acme@redhat.com, jolsa@redhat.com,
          linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf db-export: Add calls parent_id to enable
 creation of call trees
Git-Commit-ID: f435887ec0c941b97301bd6ed1f3e4b5200df409
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

Commit-ID:  f435887ec0c941b97301bd6ed1f3e4b5200df409
Gitweb:     https://git.kernel.org/tip/f435887ec0c941b97301bd6ed1f3e4b5200df409
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Thu, 28 Feb 2019 15:00:24 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Fri, 1 Mar 2019 14:50:47 -0300

perf db-export: Add calls parent_id to enable creation of call trees

The call_path can be used to find the parent symbol for a call but not
the exact parent call. To do that add parent_id to the call_return
export. This enables the creation of a call tree from the exported data.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: https://lkml.kernel.org/n/tip-6j7tzdxo67cox6kan7k22oo6@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/db-export.c                            | 15 ++++++++++-----
 tools/perf/util/db-export.h                            |  3 ++-
 tools/perf/util/scripting-engines/trace-event-python.c |  8 +++++---
 tools/perf/util/thread-stack.c                         | 16 ++++++++++++++--
 tools/perf/util/thread-stack.h                         |  6 ++++--
 5 files changed, 35 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
index de9b4769d06c..d7315a00c731 100644
--- a/tools/perf/util/db-export.c
+++ b/tools/perf/util/db-export.c
@@ -510,18 +510,23 @@ int db_export__call_path(struct db_export *dbe, struct call_path *cp)
 	return 0;
 }
 
-int db_export__call_return(struct db_export *dbe, struct call_return *cr)
+int db_export__call_return(struct db_export *dbe, struct call_return *cr,
+			   u64 *parent_db_id)
 {
 	int err;
 
-	if (cr->db_id)
-		return 0;
-
 	err = db_export__call_path(dbe, cr->cp);
 	if (err)
 		return err;
 
-	cr->db_id = ++dbe->call_return_last_db_id;
+	if (!cr->db_id)
+		cr->db_id = ++dbe->call_return_last_db_id;
+
+	if (parent_db_id) {
+		if (!*parent_db_id)
+			*parent_db_id = ++dbe->call_return_last_db_id;
+		cr->parent_db_id = *parent_db_id;
+	}
 
 	if (dbe->export_call_return)
 		return dbe->export_call_return(dbe, cr);
diff --git a/tools/perf/util/db-export.h b/tools/perf/util/db-export.h
index 67bc6b8ad2d6..4e2424c89df9 100644
--- a/tools/perf/util/db-export.h
+++ b/tools/perf/util/db-export.h
@@ -104,6 +104,7 @@ int db_export__sample(struct db_export *dbe, union perf_event *event,
 int db_export__branch_types(struct db_export *dbe);
 
 int db_export__call_path(struct db_export *dbe, struct call_path *cp);
-int db_export__call_return(struct db_export *dbe, struct call_return *cr);
+int db_export__call_return(struct db_export *dbe, struct call_return *cr,
+			   u64 *parent_db_id);
 
 #endif
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 0e17db41b49b..09604c6508f0 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -1173,7 +1173,7 @@ static int python_export_call_return(struct db_export *dbe,
 	u64 comm_db_id = cr->comm ? cr->comm->db_id : 0;
 	PyObject *t;
 
-	t = tuple_new(11);
+	t = tuple_new(12);
 
 	tuple_set_u64(t, 0, cr->db_id);
 	tuple_set_u64(t, 1, cr->thread->db_id);
@@ -1186,6 +1186,7 @@ static int python_export_call_return(struct db_export *dbe,
 	tuple_set_u64(t, 8, cr->return_ref);
 	tuple_set_u64(t, 9, cr->cp->parent->db_id);
 	tuple_set_s32(t, 10, cr->flags);
+	tuple_set_u64(t, 11, cr->parent_db_id);
 
 	call_object(tables->call_return_handler, t, "call_return_table");
 
@@ -1194,11 +1195,12 @@ static int python_export_call_return(struct db_export *dbe,
 	return 0;
 }
 
-static int python_process_call_return(struct call_return *cr, void *data)
+static int python_process_call_return(struct call_return *cr, u64 *parent_db_id,
+				      void *data)
 {
 	struct db_export *dbe = data;
 
-	return db_export__call_return(dbe, cr);
+	return db_export__call_return(dbe, cr, parent_db_id);
 }
 
 static void python_process_general_event(struct perf_sample *sample,
diff --git a/tools/perf/util/thread-stack.c b/tools/perf/util/thread-stack.c
index a8b45168513c..41942c2aaa18 100644
--- a/tools/perf/util/thread-stack.c
+++ b/tools/perf/util/thread-stack.c
@@ -49,6 +49,7 @@ enum retpoline_state_t {
  * @timestamp: timestamp (if known)
  * @ref: external reference (e.g. db_id of sample)
  * @branch_count: the branch count when the entry was created
+ * @db_id: id used for db-export
  * @cp: call path
  * @no_call: a 'call' was not seen
  * @trace_end: a 'call' but trace ended
@@ -59,6 +60,7 @@ struct thread_stack_entry {
 	u64 timestamp;
 	u64 ref;
 	u64 branch_count;
+	u64 db_id;
 	struct call_path *cp;
 	bool no_call;
 	bool trace_end;
@@ -280,12 +282,14 @@ static int thread_stack__call_return(struct thread *thread,
 		.comm = ts->comm,
 		.db_id = 0,
 	};
+	u64 *parent_db_id;
 
 	tse = &ts->stack[idx];
 	cr.cp = tse->cp;
 	cr.call_time = tse->timestamp;
 	cr.return_time = timestamp;
 	cr.branch_count = ts->branch_count - tse->branch_count;
+	cr.db_id = tse->db_id;
 	cr.call_ref = tse->ref;
 	cr.return_ref = ref;
 	if (tse->no_call)
@@ -295,7 +299,14 @@ static int thread_stack__call_return(struct thread *thread,
 	if (tse->non_call)
 		cr.flags |= CALL_RETURN_NON_CALL;
 
-	return crp->process(&cr, crp->data);
+	/*
+	 * The parent db_id must be assigned before exporting the child. Note
+	 * it is not possible to export the parent first because its information
+	 * is not yet complete because its 'return' has not yet been processed.
+	 */
+	parent_db_id = idx ? &(tse - 1)->db_id : NULL;
+
+	return crp->process(&cr, parent_db_id, crp->data);
 }
 
 static int __thread_stack__flush(struct thread *thread, struct thread_stack *ts)
@@ -484,7 +495,7 @@ void thread_stack__sample(struct thread *thread, int cpu,
 }
 
 struct call_return_processor *
-call_return_processor__new(int (*process)(struct call_return *cr, void *data),
+call_return_processor__new(int (*process)(struct call_return *cr, u64 *parent_db_id, void *data),
 			   void *data)
 {
 	struct call_return_processor *crp;
@@ -537,6 +548,7 @@ static int thread_stack__push_cp(struct thread_stack *ts, u64 ret_addr,
 	tse->no_call = no_call;
 	tse->trace_end = trace_end;
 	tse->non_call = false;
+	tse->db_id = 0;
 
 	return 0;
 }
diff --git a/tools/perf/util/thread-stack.h b/tools/perf/util/thread-stack.h
index b7c04e19ad41..9c45f947f5a9 100644
--- a/tools/perf/util/thread-stack.h
+++ b/tools/perf/util/thread-stack.h
@@ -55,6 +55,7 @@ enum {
  * @call_ref: external reference to 'call' sample (e.g. db_id)
  * @return_ref:  external reference to 'return' sample (e.g. db_id)
  * @db_id: id used for db-export
+ * @parent_db_id: id of parent call used for db-export
  * @flags: Call/Return flags
  */
 struct call_return {
@@ -67,6 +68,7 @@ struct call_return {
 	u64 call_ref;
 	u64 return_ref;
 	u64 db_id;
+	u64 parent_db_id;
 	u32 flags;
 };
 
@@ -79,7 +81,7 @@ struct call_return {
  */
 struct call_return_processor {
 	struct call_path_root *cpr;
-	int (*process)(struct call_return *cr, void *data);
+	int (*process)(struct call_return *cr, u64 *parent_db_id, void *data);
 	void *data;
 };
 
@@ -93,7 +95,7 @@ void thread_stack__free(struct thread *thread);
 size_t thread_stack__depth(struct thread *thread, int cpu);
 
 struct call_return_processor *
-call_return_processor__new(int (*process)(struct call_return *cr, void *data),
+call_return_processor__new(int (*process)(struct call_return *cr, u64 *parent_db_id, void *data),
 			   void *data);
 void call_return_processor__free(struct call_return_processor *crp);
 int thread_stack__process(struct thread *thread, struct comm *comm,
