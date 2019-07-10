Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F51C73C7C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 09:00:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A66D2084B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 09:00:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbfGJI7m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 04:59:42 -0400
Received: from mga12.intel.com ([192.55.52.136]:35469 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727744AbfGJI7g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 04:59:36 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2019 01:59:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,474,1557212400"; 
   d="scan'208";a="186102533"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.122])
  by fmsmga001.fm.intel.com with ESMTP; 10 Jul 2019 01:59:34 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 08/21] perf db-export: Export comm details
Date:   Wed, 10 Jul 2019 11:57:57 +0300
Message-Id: <20190710085810.1650-9-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190710085810.1650-1-adrian.hunter@intel.com>
References: <20190710085810.1650-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for exporting the current comm for a thread, export comm
thread id, start time and exec flag.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/db-export.c                            | 2 +-
 tools/perf/util/db-export.h                            | 3 ++-
 tools/perf/util/scripting-engines/trace-event-python.c | 8 ++++++--
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
index aad322a90863..7d181f2f1e75 100644
--- a/tools/perf/util/db-export.c
+++ b/tools/perf/util/db-export.c
@@ -94,7 +94,7 @@ int db_export__exec_comm(struct db_export *dbe, struct comm *comm,
 	comm->db_id = ++dbe->comm_last_db_id;
 
 	if (dbe->export_comm) {
-		err = dbe->export_comm(dbe, comm);
+		err = dbe->export_comm(dbe, comm, main_thread);
 		if (err)
 			return err;
 	}
diff --git a/tools/perf/util/db-export.h b/tools/perf/util/db-export.h
index 811a678a910d..29f7c3b035a7 100644
--- a/tools/perf/util/db-export.h
+++ b/tools/perf/util/db-export.h
@@ -43,7 +43,8 @@ struct db_export {
 	int (*export_machine)(struct db_export *dbe, struct machine *machine);
 	int (*export_thread)(struct db_export *dbe, struct thread *thread,
 			     u64 main_thread_db_id, struct machine *machine);
-	int (*export_comm)(struct db_export *dbe, struct comm *comm);
+	int (*export_comm)(struct db_export *dbe, struct comm *comm,
+			   struct thread *thread);
 	int (*export_comm_thread)(struct db_export *dbe, u64 db_id,
 				  struct comm *comm, struct thread *thread);
 	int (*export_dso)(struct db_export *dbe, struct dso *dso,
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index c9837f0f0fd6..28167e938cef 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -1011,15 +1011,19 @@ static int python_export_thread(struct db_export *dbe, struct thread *thread,
 	return 0;
 }
 
-static int python_export_comm(struct db_export *dbe, struct comm *comm)
+static int python_export_comm(struct db_export *dbe, struct comm *comm,
+			      struct thread *thread)
 {
 	struct tables *tables = container_of(dbe, struct tables, dbe);
 	PyObject *t;
 
-	t = tuple_new(2);
+	t = tuple_new(5);
 
 	tuple_set_u64(t, 0, comm->db_id);
 	tuple_set_string(t, 1, comm__str(comm));
+	tuple_set_u64(t, 2, thread->db_id);
+	tuple_set_u64(t, 3, comm->start);
+	tuple_set_s32(t, 4, comm->exec);
 
 	call_object(tables->comm_handler, t, "comm_table");
 
-- 
2.17.1

