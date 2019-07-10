Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE25AC73C7C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 08:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDAB820861
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 08:59:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbfGJI7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 04:59:54 -0400
Received: from mga12.intel.com ([192.55.52.136]:35491 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727838AbfGJI7v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 04:59:51 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2019 01:59:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,474,1557212400"; 
   d="scan'208";a="186102586"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.122])
  by fmsmga001.fm.intel.com with ESMTP; 10 Jul 2019 01:59:49 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 18/21] perf db-export: Factor out db_export__threads()
Date:   Wed, 10 Jul 2019 11:58:07 +0300
Message-Id: <20190710085810.1650-19-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190710085810.1650-1-adrian.hunter@intel.com>
References: <20190710085810.1650-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for exporting switch events, factor out
db_export__threads().

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/db-export.c | 82 ++++++++++++++++++++++---------------
 1 file changed, 48 insertions(+), 34 deletions(-)

diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
index 2220a60ad29e..2efc08b74176 100644
--- a/tools/perf/util/db-export.c
+++ b/tools/perf/util/db-export.c
@@ -285,50 +285,32 @@ int db_export__branch_type(struct db_export *dbe, u32 branch_type,
 	return 0;
 }
 
-int db_export__sample(struct db_export *dbe, union perf_event *event,
-		      struct perf_sample *sample, struct perf_evsel *evsel,
-		      struct addr_location *al)
+static int db_export__threads(struct db_export *dbe, struct thread *thread,
+			      struct thread *main_thread,
+			      struct machine *machine, struct comm **comm_ptr)
 {
-	struct thread *thread = al->thread;
-	struct export_sample es = {
-		.event = event,
-		.sample = sample,
-		.evsel = evsel,
-		.al = al,
-	};
-	struct thread *main_thread;
 	struct comm *comm = NULL;
 	struct comm *curr_comm;
 	int err;
 
-	err = db_export__evsel(dbe, evsel);
-	if (err)
-		return err;
-
-	err = db_export__machine(dbe, al->machine);
-	if (err)
-		return err;
-
-	main_thread = thread__main_thread(al->machine, thread);
 	if (main_thread) {
 		/*
 		 * A thread has a reference to the main thread, so export the
 		 * main thread first.
 		 */
-		err = db_export__thread(dbe, main_thread, al->machine,
-					main_thread);
+		err = db_export__thread(dbe, main_thread, machine, main_thread);
 		if (err)
-			goto out_put;
+			return err;
 		/*
 		 * Export comm before exporting the non-main thread because
 		 * db_export__comm_thread() can be called further below.
 		 */
-		comm = machine__thread_exec_comm(al->machine, main_thread);
+		comm = machine__thread_exec_comm(machine, main_thread);
 		if (comm) {
 			err = db_export__exec_comm(dbe, comm, main_thread);
 			if (err)
-				goto out_put;
-			es.comm_db_id = comm->db_id;
+				return err;
+			*comm_ptr = comm;
 		}
 	}
 
@@ -339,23 +321,55 @@ int db_export__sample(struct db_export *dbe, union perf_event *event,
 		 */
 		bool export_comm_thread = comm && !thread->db_id;
 
-		err = db_export__thread(dbe, thread, al->machine, main_thread);
+		err = db_export__thread(dbe, thread, machine, main_thread);
 		if (err)
-			goto out_put;
+			return err;
 
 		if (export_comm_thread) {
 			err = db_export__comm_thread(dbe, comm, thread);
 			if (err)
-				goto out_put;
+				return err;
 		}
 	}
 
 	curr_comm = thread__comm(thread);
-	if (curr_comm) {
-		err = db_export__comm(dbe, curr_comm, thread);
-		if (err)
-			goto out_put;
-	}
+	if (curr_comm)
+		return db_export__comm(dbe, curr_comm, thread);
+
+	return 0;
+}
+
+int db_export__sample(struct db_export *dbe, union perf_event *event,
+		      struct perf_sample *sample, struct perf_evsel *evsel,
+		      struct addr_location *al)
+{
+	struct thread *thread = al->thread;
+	struct export_sample es = {
+		.event = event,
+		.sample = sample,
+		.evsel = evsel,
+		.al = al,
+	};
+	struct thread *main_thread;
+	struct comm *comm = NULL;
+	int err;
+
+	err = db_export__evsel(dbe, evsel);
+	if (err)
+		return err;
+
+	err = db_export__machine(dbe, al->machine);
+	if (err)
+		return err;
+
+	main_thread = thread__main_thread(al->machine, thread);
+
+	err = db_export__threads(dbe, thread, main_thread, al->machine, &comm);
+	if (err)
+		goto out_put;
+
+	if (comm)
+		es.comm_db_id = comm->db_id;
 
 	es.db_id = ++dbe->sample_last_db_id;
 
-- 
2.17.1

