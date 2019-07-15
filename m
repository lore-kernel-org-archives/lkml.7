Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A89C76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 21:14:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF6502171F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 21:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563225244;
	bh=LKNMMfodpYpVFg0B0jSCVUOxTxTaQTJXyp5JbQO5ek4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iF0kYc9n6vf+q00vteHJBCzA5ZgDHvj3TTR/50cW4+UofhuyG2dbcylbv+cP0kyb5
	 Aq/kPxvdGCwIS3iyOxdRDqBac1+HubHi6HQZbTiWWCf24lnN2iRZ7ATSnWu5xAde+j
	 uwauRp3Ft01bxAdm+DyXYCD+YS57haE5v7o2uXxY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733277AbfGOVOC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 17:14:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:44868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731486AbfGOVOA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 17:14:00 -0400
Received: from quaco.ghostprotocols.net (179-240-129-12.3g.claro.net.br [179.240.129.12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B054F20449;
        Mon, 15 Jul 2019 21:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563225239;
        bh=LKNMMfodpYpVFg0B0jSCVUOxTxTaQTJXyp5JbQO5ek4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UIAFkHAniTygiSeoJNlHNlryAuRfENc+o3/OvLu5klpxlOO6ZSIo1uV5JV9Iy8aG/
         PowWs4pl9pHRcttrIvYJrIh4Mk/ZByB+k1kOQU3XbREpn0Q3ewcFKeYvTnGWUIxVlI
         G52raIddGvQuCgCRawzC+T7rW6L1OevuWhHjQ1+s=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 21/28] perf db-export: Factor out db_export__threads()
Date:   Mon, 15 Jul 2019 18:11:53 -0300
Message-Id: <20190715211200.10984-22-acme@kernel.org>
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

In preparation for exporting switch events, factor out
db_export__threads().

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190710085810.1650-19-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/db-export.c | 82 ++++++++++++++++++++++---------------
 1 file changed, 48 insertions(+), 34 deletions(-)

diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
index 5057fdd7f62d..e6a9c450133e 100644
--- a/tools/perf/util/db-export.c
+++ b/tools/perf/util/db-export.c
@@ -286,50 +286,32 @@ int db_export__branch_type(struct db_export *dbe, u32 branch_type,
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
 
@@ -340,23 +322,55 @@ int db_export__sample(struct db_export *dbe, union perf_event *event,
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
2.21.0

