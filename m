Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33204C73C7C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 08:59:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10DD620693
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 08:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727746AbfGJI7g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 04:59:36 -0400
Received: from mga12.intel.com ([192.55.52.136]:35466 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727719AbfGJI7d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 04:59:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2019 01:59:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,474,1557212400"; 
   d="scan'208";a="186102526"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.122])
  by fmsmga001.fm.intel.com with ESMTP; 10 Jul 2019 01:59:31 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 06/21] perf db-export: Move export__comm_thread into db_export__sample()
Date:   Wed, 10 Jul 2019 11:57:55 +0300
Message-Id: <20190710085810.1650-7-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190710085810.1650-1-adrian.hunter@intel.com>
References: <20190710085810.1650-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move call to db_export__comm_thread() from db_export__thread() into
db_export__sample() because it makes the code easier to understand, and
add explanatory comments.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/db-export.c | 35 +++++++++++++++++++++--------------
 tools/perf/util/db-export.h |  3 +--
 2 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
index 972e1313388f..31986c8c4ad2 100644
--- a/tools/perf/util/db-export.c
+++ b/tools/perf/util/db-export.c
@@ -58,25 +58,17 @@ int db_export__machine(struct db_export *dbe, struct machine *machine)
 }
 
 int db_export__thread(struct db_export *dbe, struct thread *thread,
-		      struct machine *machine, struct comm *comm,
-		      struct thread *main_thread)
+		      struct machine *machine, struct thread *main_thread)
 {
 	u64 main_thread_db_id = 0;
-	int err;
 
 	if (thread->db_id)
 		return 0;
 
 	thread->db_id = ++dbe->thread_last_db_id;
 
-	if (main_thread) {
-		if (main_thread != thread && comm) {
-			err = db_export__comm_thread(dbe, comm, thread);
-			if (err)
-				return err;
-		}
+	if (main_thread)
 		main_thread_db_id = main_thread->db_id;
-	}
 
 	if (dbe->export_thread)
 		return dbe->export_thread(dbe, thread, main_thread_db_id,
@@ -302,15 +294,19 @@ int db_export__sample(struct db_export *dbe, union perf_event *event,
 
 	main_thread = thread__main_thread(al->machine, thread);
 	if (main_thread) {
-		comm = machine__thread_exec_comm(al->machine, main_thread);
 		/*
 		 * A thread has a reference to the main thread, so export the
 		 * main thread first.
 		 */
-		err = db_export__thread(dbe, main_thread, al->machine, comm,
+		err = db_export__thread(dbe, main_thread, al->machine,
 					main_thread);
 		if (err)
 			goto out_put;
+		/*
+		 * Export comm before exporting the non-main thread because
+		 * db_export__comm_thread() can be called further below.
+		 */
+		comm = machine__thread_exec_comm(al->machine, main_thread);
 		if (comm) {
 			err = db_export__exec_comm(dbe, comm, main_thread);
 			if (err)
@@ -320,10 +316,21 @@ int db_export__sample(struct db_export *dbe, union perf_event *event,
 	}
 
 	if (thread != main_thread) {
-		err = db_export__thread(dbe, thread, al->machine, comm,
-					main_thread);
+		/*
+		 * For a non-main thread, db_export__comm_thread() must be
+		 * called only if thread has not previously been exported.
+		 */
+		bool export_comm_thread = comm && !thread->db_id;
+
+		err = db_export__thread(dbe, thread, al->machine, main_thread);
 		if (err)
 			goto out_put;
+
+		if (export_comm_thread) {
+			err = db_export__comm_thread(dbe, comm, thread);
+			if (err)
+				goto out_put;
+		}
 	}
 
 	es.db_id = ++dbe->sample_last_db_id;
diff --git a/tools/perf/util/db-export.h b/tools/perf/util/db-export.h
index 6e267321594c..811a678a910d 100644
--- a/tools/perf/util/db-export.h
+++ b/tools/perf/util/db-export.h
@@ -75,8 +75,7 @@ void db_export__exit(struct db_export *dbe);
 int db_export__evsel(struct db_export *dbe, struct perf_evsel *evsel);
 int db_export__machine(struct db_export *dbe, struct machine *machine);
 int db_export__thread(struct db_export *dbe, struct thread *thread,
-		      struct machine *machine, struct comm *comm,
-		      struct thread *main_thread);
+		      struct machine *machine, struct thread *main_thread);
 int db_export__exec_comm(struct db_export *dbe, struct comm *comm,
 			 struct thread *main_thread);
 int db_export__comm_thread(struct db_export *dbe, struct comm *comm,
-- 
2.17.1

