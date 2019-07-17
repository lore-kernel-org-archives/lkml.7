Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 261F8C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 22:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1941217F4
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 22:51:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="kUEQ3Ahn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730921AbfGQWv2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 18:51:28 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59017 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727653AbfGQWv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 18:51:28 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6HMpJxH1721653
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 17 Jul 2019 15:51:19 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6HMpJxH1721653
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563403880;
        bh=GOQBT3w4J5fnpemQq/iIKrsLm4ko8CH0jRenLgLzJcQ=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=kUEQ3AhnWFSnG6+nt7/AqwcaPrjMerja+t04FQLLqh1rXFhbTD7BTH47auaDz/6Yi
         5Z/WpEjVB9agjns9zcPiZNhh4KVvzYH9NfweM9cPhZ36K18K1i/TRCVXKjfZZ5ZAX/
         1wwthpzflk4+CTdLWFR76vnRfIjhfbc+xtdPFzy2Pj0Lq2xTc0xq/hkEGd/faNfXCl
         oxMWENSEVVy9xtR5Wi0+RctREdKL4j3tuKhtPRgY2vmtD0vwbkLiEWPC2FWcJt2Wo1
         kMeV9fPcDKpTag37E786gh5/KMifLTsXasmmKfMBZEoSqkA4ef05Oj4UD6GLZ+d27Y
         dkoV/liPjBD1w==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6HMpIH81721650;
        Wed, 17 Jul 2019 15:51:18 -0700
Date:   Wed, 17 Jul 2019 15:51:18 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-fead24e52383c3f8eb25b5426d52b430b84a8194@git.kernel.org>
Cc:     adrian.hunter@intel.com, acme@redhat.com, namhyung@kernel.org,
        hpa@zytor.com, mingo@kernel.org, tglx@linutronix.de,
        jolsa@redhat.com, linux-kernel@vger.kernel.org
Reply-To: adrian.hunter@intel.com, acme@redhat.com, hpa@zytor.com,
          jolsa@redhat.com, mingo@kernel.org, tglx@linutronix.de,
          namhyung@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20190710085810.1650-2-adrian.hunter@intel.com>
References: <20190710085810.1650-2-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf db-export: Get rid of db_export__deferred()
Git-Commit-ID: fead24e52383c3f8eb25b5426d52b430b84a8194
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

Commit-ID:  fead24e52383c3f8eb25b5426d52b430b84a8194
Gitweb:     https://git.kernel.org/tip/fead24e52383c3f8eb25b5426d52b430b84a8194
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Wed, 10 Jul 2019 11:57:50 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 10 Jul 2019 12:07:40 -0300

perf db-export: Get rid of db_export__deferred()

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
 tools/perf/util/db-export.c                        | 61 +---------------------
 tools/perf/util/db-export.h                        |  2 -
 .../util/scripting-engines/trace-event-python.c    |  4 +-
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
@@ -1620,9 +1620,7 @@ error:
 
 static int python_flush_script(void)
 {
-	struct tables *tables = &tables_global;
-
-	return db_export__flush(&tables->dbe);
+	return 0;
 }
 
 /*
