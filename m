Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 205F0C73C7C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 09:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F361D2084B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 09:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727971AbfGJJAo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 05:00:44 -0400
Received: from mga12.intel.com ([192.55.52.136]:35466 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727711AbfGJI7d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 04:59:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2019 01:59:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,474,1557212400"; 
   d="scan'208";a="186102510"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.122])
  by fmsmga001.fm.intel.com with ESMTP; 10 Jul 2019 01:59:26 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 03/21] perf db-export: Pass main_thread to db_export__thread()
Date:   Wed, 10 Jul 2019 11:57:52 +0300
Message-Id: <20190710085810.1650-4-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190710085810.1650-1-adrian.hunter@intel.com>
References: <20190710085810.1650-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Calls to db_export__thread() already have main_thread so there is no
reason to get it again, instead pass it as a parameter. Note that one
difference in this approach is that the main thread is not created if it
does not exist. It is better if it is not created because:
   - If main_thread is being traced it will have been created already.
   - If it is not being traced, there will be no other information about
it, and it will never get deleted because there will be no EXIT event.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/db-export.c | 29 ++++++++---------------------
 tools/perf/util/db-export.h |  3 ++-
 2 files changed, 10 insertions(+), 22 deletions(-)

diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
index bb696559cd9a..7ad596bef4a9 100644
--- a/tools/perf/util/db-export.c
+++ b/tools/perf/util/db-export.c
@@ -58,9 +58,9 @@ int db_export__machine(struct db_export *dbe, struct machine *machine)
 }
 
 int db_export__thread(struct db_export *dbe, struct thread *thread,
-		      struct machine *machine, struct comm *comm)
+		      struct machine *machine, struct comm *comm,
+		      struct thread *main_thread)
 {
-	struct thread *main_thread;
 	u64 main_thread_db_id = 0;
 	int err;
 
@@ -69,28 +69,19 @@ int db_export__thread(struct db_export *dbe, struct thread *thread,
 
 	thread->db_id = ++dbe->thread_last_db_id;
 
-	if (thread->pid_ != -1) {
-		if (thread->pid_ == thread->tid) {
-			main_thread = thread;
-		} else {
-			main_thread = machine__findnew_thread(machine,
-							      thread->pid_,
-							      thread->pid_);
-			if (!main_thread)
-				return -ENOMEM;
+	if (main_thread) {
+		if (main_thread != thread) {
 			err = db_export__thread(dbe, main_thread, machine,
-						comm);
+						comm, main_thread);
 			if (err)
-				goto out_put;
+				return err;
 			if (comm) {
 				err = db_export__comm_thread(dbe, comm, thread);
 				if (err)
-					goto out_put;
+					return err;
 			}
 		}
 		main_thread_db_id = main_thread->db_id;
-		if (main_thread != thread)
-			thread__put(main_thread);
 	}
 
 	if (dbe->export_thread)
@@ -98,10 +89,6 @@ int db_export__thread(struct db_export *dbe, struct thread *thread,
 					  machine);
 
 	return 0;
-
-out_put:
-	thread__put(main_thread);
-	return err;
 }
 
 /*
@@ -323,7 +310,7 @@ int db_export__sample(struct db_export *dbe, union perf_event *event,
 	if (main_thread)
 		comm = machine__thread_exec_comm(al->machine, main_thread);
 
-	err = db_export__thread(dbe, thread, al->machine, comm);
+	err = db_export__thread(dbe, thread, al->machine, comm, main_thread);
 	if (err)
 		goto out_put;
 
diff --git a/tools/perf/util/db-export.h b/tools/perf/util/db-export.h
index 148a657b1887..6e267321594c 100644
--- a/tools/perf/util/db-export.h
+++ b/tools/perf/util/db-export.h
@@ -75,7 +75,8 @@ void db_export__exit(struct db_export *dbe);
 int db_export__evsel(struct db_export *dbe, struct perf_evsel *evsel);
 int db_export__machine(struct db_export *dbe, struct machine *machine);
 int db_export__thread(struct db_export *dbe, struct thread *thread,
-		      struct machine *machine, struct comm *comm);
+		      struct machine *machine, struct comm *comm,
+		      struct thread *main_thread);
 int db_export__exec_comm(struct db_export *dbe, struct comm *comm,
 			 struct thread *main_thread);
 int db_export__comm_thread(struct db_export *dbe, struct comm *comm,
-- 
2.17.1

