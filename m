Return-Path: <SRS0=uyI7=RK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A8DC43381
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:45:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A31B52087C
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Mar 2019 17:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551980724;
	bh=mWx8YDUP4niVb/BnYCYqWQD0sMRBwav5+DpeBogzNc8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QTOJ9VHLbB263UHKahSK6+2AjWmyu2HTxJSy7iDjv3zZTpwK4EtK3Oq3sIrENtk3W
	 mxMKNHKqkvZdx8Q2eluLj1uSFkJ0yuvUTcA4ybv39K+Qn3QsttHvIEmOXMtPncuXwN
	 jUkYlF3P5T7PitGBRyI1l8eY87weSMqxXUfa8xTw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbfCGRpX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 12:45:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:37400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726180AbfCGRpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 12:45:22 -0500
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1E0E2087C;
        Thu,  7 Mar 2019 17:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551980720;
        bh=mWx8YDUP4niVb/BnYCYqWQD0sMRBwav5+DpeBogzNc8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2c0PWm7RpbtzPYhDeLGendf/8dpjhivedKHgGRPav+hZKJRB/mzjHoKF0083M5sUc
         /dQu6GTTlKtX9o9xKPww+Bl/cQlzDdO1Xv7qiPy8uYi8Ub5Gn1g2TmixVSOZKKGV+c
         TiobrOLca5eK7uzmpvXjAJ6UYyYDscDezN5+TQrA=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 08/35] perf db-export: Add calls parent_id to enable creation of call trees
Date:   Thu,  7 Mar 2019 14:44:06 -0300
Message-Id: <20190307174433.28819-9-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190307174433.28819-1-acme@kernel.org>
References: <20190307174433.28819-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

The call_path can be used to find the parent symbol for a call but not
the exact parent call. To do that add parent_id to the call_return
export. This enables the creation of a call tree from the exported data.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: https://lkml.kernel.org/n/tip-6j7tzdxo67cox6kan7k22oo6@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/db-export.c                      | 15 ++++++++++-----
 tools/perf/util/db-export.h                      |  3 ++-
 .../util/scripting-engines/trace-event-python.c  |  8 +++++---
 tools/perf/util/thread-stack.c                   | 16 ++++++++++++++--
 tools/perf/util/thread-stack.h                   |  6 ++++--
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
-- 
2.20.1

