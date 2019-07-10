Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7737C73C7C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 09:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8994F2084B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 09:00:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727997AbfGJJAs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 05:00:48 -0400
Received: from mga12.intel.com ([192.55.52.136]:35463 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727709AbfGJI7d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 04:59:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2019 01:59:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,474,1557212400"; 
   d="scan'208";a="186102505"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.122])
  by fmsmga001.fm.intel.com with ESMTP; 10 Jul 2019 01:59:25 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 02/21] perf db-export: Rename db_export__comm() to db_export__exec_comm()
Date:   Wed, 10 Jul 2019 11:57:51 +0300
Message-Id: <20190710085810.1650-3-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190710085810.1650-1-adrian.hunter@intel.com>
References: <20190710085810.1650-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename db_export__comm() to db_export__exec_comm() to better reflect
what it does and add explanatory comments.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/db-export.c | 22 +++++++++++++++++++---
 tools/perf/util/db-export.h |  4 ++--
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
index f36970018df3..bb696559cd9a 100644
--- a/tools/perf/util/db-export.c
+++ b/tools/perf/util/db-export.c
@@ -104,8 +104,14 @@ int db_export__thread(struct db_export *dbe, struct thread *thread,
 	return err;
 }
 
-int db_export__comm(struct db_export *dbe, struct comm *comm,
-		    struct thread *main_thread)
+/*
+ * Export the "exec" comm. The "exec" comm is the program / application command
+ * name at the time it first executes. It is used to group threads for the same
+ * program. Note that the main thread pid (or thread group id tgid) cannot be
+ * used because it does not change when a new program is exec'ed.
+ */
+int db_export__exec_comm(struct db_export *dbe, struct comm *comm,
+			 struct thread *main_thread)
 {
 	int err;
 
@@ -120,6 +126,16 @@ int db_export__comm(struct db_export *dbe, struct comm *comm,
 			return err;
 	}
 
+	/*
+	 * Record the main thread for this comm. Note that the main thread can
+	 * have many "exec" comms because there will be a new one every time it
+	 * exec's. An "exec" comm however will only ever have 1 main thread.
+	 * That is different to any other threads for that same program because
+	 * exec() will effectively kill them, so the relationship between the
+	 * "exec" comm and non-main threads is 1-to-1. That is why
+	 * db_export__comm_thread() is called here for the main thread, but it
+	 * is called for non-main threads when they are exported.
+	 */
 	return db_export__comm_thread(dbe, comm, main_thread);
 }
 
@@ -312,7 +328,7 @@ int db_export__sample(struct db_export *dbe, union perf_event *event,
 		goto out_put;
 
 	if (comm) {
-		err = db_export__comm(dbe, comm, main_thread);
+		err = db_export__exec_comm(dbe, comm, main_thread);
 		if (err)
 			goto out_put;
 		es.comm_db_id = comm->db_id;
diff --git a/tools/perf/util/db-export.h b/tools/perf/util/db-export.h
index 261cfece8dee..148a657b1887 100644
--- a/tools/perf/util/db-export.h
+++ b/tools/perf/util/db-export.h
@@ -76,8 +76,8 @@ int db_export__evsel(struct db_export *dbe, struct perf_evsel *evsel);
 int db_export__machine(struct db_export *dbe, struct machine *machine);
 int db_export__thread(struct db_export *dbe, struct thread *thread,
 		      struct machine *machine, struct comm *comm);
-int db_export__comm(struct db_export *dbe, struct comm *comm,
-		    struct thread *main_thread);
+int db_export__exec_comm(struct db_export *dbe, struct comm *comm,
+			 struct thread *main_thread);
 int db_export__comm_thread(struct db_export *dbe, struct comm *comm,
 			   struct thread *thread);
 int db_export__dso(struct db_export *dbe, struct dso *dso,
-- 
2.17.1

