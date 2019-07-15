Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CA58C76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 21:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 419F720665
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 21:12:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563225159;
	bh=g0oBtFeTzQvbyU14ujgg9Hz2a4C1P3KDyKJCKPW5bM0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QXjNsWfVvtI1SEORitmwL/F2Vk9syF0b7GyHoqeO14Ep39qXbiXHPk7neDyHEp2Rt
	 tvmRKNyglNnBO5fqsdhNvvabfUEeEleFzJjh8l2POUpO+BewoVeFLKNlwtOS2ALoZn
	 LFSQ8uCmT49Nh8ky+BxhHT1pkAZ5QSfBgyhHSoqI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732834AbfGOVMi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 17:12:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:43420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730409AbfGOVMh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 17:12:37 -0400
Received: from quaco.ghostprotocols.net (179-240-129-12.3g.claro.net.br [179.240.129.12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4051C21721;
        Mon, 15 Jul 2019 21:12:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563225156;
        bh=g0oBtFeTzQvbyU14ujgg9Hz2a4C1P3KDyKJCKPW5bM0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b1QAXIOHqVGUO1vT+yJQmY93//S5QZv9dKSv3EGsf/6bcRMLylhtXt7bIdrdxQOWD
         yQ8198tAxHJh/ydhyC4k+bw6rZUPUp675n5lgiUEuXJ+MzpNZrQ6YRMBKLX/kyOk1O
         yzUCRu1TbDUYG4ox8GM1rMwLaijHTBN5XWEjzTUI=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 04/28] perf db-export: Get rid of db_export__deferred()
Date:   Mon, 15 Jul 2019 18:11:36 -0300
Message-Id: <20190715211200.10984-5-acme@kernel.org>
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

db_export__deferred() deferred the export of comms if the comm string
had not been "set" (changed from :<pid>) however that problem was fixed
a long time ago by commit e803cf97a4f9 ("perf record: Synthesize COMM
event for a command line workload"), so get rid of
db_export__deferred().

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: http://lkml.kernel.org/r/20190710085810.1650-2-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/db-export.c                   | 61 +------------------
 tools/perf/util/db-export.h                   |  2 -
 .../scripting-engines/trace-event-python.c    |  4 +-
 3 files changed, 2 insertions(+), 65 deletions(-)

diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
index 2394c7506abe..34cf197fe74f 100644
--- a/tools/perf/util/db-export.c
+++ b/tools/perf/util/db-export.c
@@ -20,70 +20,14 @@
 #include "db-export.h"
 #include <linux/zalloc.h>
 
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
-		list_del_init(&de->node);
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
-		list_del_init(&de->node);
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
@@ -172,10 +116,7 @@ int db_export__comm(struct db_export *dbe, struct comm *comm,
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
2.21.0

