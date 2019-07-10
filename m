Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F7A0C73C7C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 09:00:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1BFE20844
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 09:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727729AbfGJI7f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 04:59:35 -0400
Received: from mga12.intel.com ([192.55.52.136]:35463 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726580AbfGJI7d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 04:59:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2019 01:59:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,474,1557212400"; 
   d="scan'208";a="186102502"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.122])
  by fmsmga001.fm.intel.com with ESMTP; 10 Jul 2019 01:59:23 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 01/21] perf db-export: Get rid of db_export__deferred()
Date:   Wed, 10 Jul 2019 11:57:50 +0300
Message-Id: <20190710085810.1650-2-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190710085810.1650-1-adrian.hunter@intel.com>
References: <20190710085810.1650-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

db_export__deferred() deferred the export of comms if the comm string had
not been "set" (changed from :<pid>) however that problem was fixed a long
time ago by commit e803cf97a4f9 ("perf record: Synthesize COMM event for a
command line workload"), so get rid of db_export__deferred().

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/db-export.c                   | 61 +------------------
 tools/perf/util/db-export.h                   |  2 -
 .../scripting-engines/trace-event-python.c    |  4 +-
 3 files changed, 2 insertions(+), 65 deletions(-)

diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
index 2182f552aac6..f36970018df3 100644
--- a/tools/perf/util/db-export.c
+++ b/tools/perf/util/db-export.c
@@ -19,70 +19,14 @@
 #include "call-path.h"
 #include "db-export.h"
 
-struct deferred_export {
-	struct list_head node;
-	struct comm *comm;
-};
-
-static int db_export__deferred(struct db_export *dbe)
-{
-	struct deferred_export *de;
-	int err;
-
-	while (!list_empty(&dbe->deferred)) {
-		de = list_entry(dbe->deferred.next, struct deferred_export,
-				node);
-		err = dbe->export_comm(dbe, de->comm);
-		list_del(&de->node);
-		free(de);
-		if (err)
-			return err;
-	}
-
-	return 0;
-}
-
-static void db_export__free_deferred(struct db_export *dbe)
-{
-	struct deferred_export *de;
-
-	while (!list_empty(&dbe->deferred)) {
-		de = list_entry(dbe->deferred.next, struct deferred_export,
-				node);
-		list_del(&de->node);
-		free(de);
-	}
-}
-
-static int db_export__defer_comm(struct db_export *dbe, struct comm *comm)
-{
-	struct deferred_export *de;
-
-	de = zalloc(sizeof(struct deferred_export));
-	if (!de)
-		return -ENOMEM;
-
-	de->comm = comm;
-	list_add_tail(&de->node, &dbe->deferred);
-
-	return 0;
-}
-
 int db_export__init(struct db_export *dbe)
 {
 	memset(dbe, 0, sizeof(struct db_export));
-	INIT_LIST_HEAD(&dbe->deferred);
 	return 0;
 }
 
-int db_export__flush(struct db_export *dbe)
-{
-	return db_export__deferred(dbe);
-}
-
 void db_export__exit(struct db_export *dbe)
 {
-	db_export__free_deferred(dbe);
 	call_return_processor__free(dbe->crp);
 	dbe->crp = NULL;
 }
@@ -171,10 +115,7 @@ int db_export__comm(struct db_export *dbe, struct comm *comm,
 	comm->db_id = ++dbe->comm_last_db_id;
 
 	if (dbe->export_comm) {
-		if (main_thread->comm_set)
-			err = dbe->export_comm(dbe, comm);
-		else
-			err = db_export__defer_comm(dbe, comm);
+		err = dbe->export_comm(dbe, comm);
 		if (err)
 			return err;
 	}
diff --git a/tools/perf/util/db-export.h b/tools/perf/util/db-export.h
index e8a64028a386..261cfece8dee 100644
--- a/tools/perf/util/db-export.h
+++ b/tools/perf/util/db-export.h
@@ -68,11 +68,9 @@ struct db_export {
 	u64 sample_last_db_id;
 	u64 call_path_last_db_id;
 	u64 call_return_last_db_id;
-	struct list_head deferred;
 };
 
 int db_export__init(struct db_export *dbe);
-int db_export__flush(struct db_export *dbe);
 void db_export__exit(struct db_export *dbe);
 int db_export__evsel(struct db_export *dbe, struct perf_evsel *evsel);
 int db_export__machine(struct db_export *dbe, struct machine *machine);
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 112bed65232f..c9837f0f0fd6 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -1620,9 +1620,7 @@ static int python_start_script(const char *script, int argc, const char **argv)
 
 static int python_flush_script(void)
 {
-	struct tables *tables = &tables_global;
-
-	return db_export__flush(&tables->dbe);
+	return 0;
 }
 
 /*
-- 
2.17.1

