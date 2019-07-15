Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4B38C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 21:13:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 988B120693
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 21:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563225185;
	bh=2nyEbbMLq+5epXoZ+IX5M6h4ff9MnigwGJoSS7Z2K04=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ye49+2FYgd4+JvhpkQJg9qAb4zZpZN0JFuGBm5xGHVWQ0KXkLNtMbTZ26r3XgIyyL
	 nGxkAPS/Og9WO31PN8QRxykBeXT++q4FLDtWmof2CphCx0v1pdYJzviDfnmvYLt9XG
	 3UeIo+2UVT34wQm8tDvh+tvtDY/cCRlN0omsiMX4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733046AbfGOVNE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 17:13:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:43866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730207AbfGOVNC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 17:13:02 -0400
Received: from quaco.ghostprotocols.net (179-240-129-12.3g.claro.net.br [179.240.129.12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB1AF21738;
        Mon, 15 Jul 2019 21:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563225181;
        bh=2nyEbbMLq+5epXoZ+IX5M6h4ff9MnigwGJoSS7Z2K04=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GK6QA2/dQblqIN3aYR0QnBBCDMk1C1VfFczuipox/h9ZhR4x+BZYyeM+RiUHi91lf
         O2E71tTChEQdqa23B43rjt4SfnS1CJbr2bBs0/khWcXrcbVwQNT8/QYL7Z/9c0jhS4
         wCJYzSPGRLuB/e4LWFL4DbLxJ0phYZDavY5mVcSM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 09/28] perf db-export: Move export__comm_thread into db_export__sample()
Date:   Mon, 15 Jul 2019 18:11:41 -0300
Message-Id: <20190715211200.10984-10-acme@kernel.org>
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

Move call to db_export__comm_thread() from db_export__thread() into
db_export__sample() because it makes the code easier to understand, and
add explanatory comments.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190710085810.1650-7-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/db-export.c | 35 +++++++++++++++++++++--------------
 tools/perf/util/db-export.h |  3 +--
 2 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
index 99ad759561de..78f62a733b9d 100644
--- a/tools/perf/util/db-export.c
+++ b/tools/perf/util/db-export.c
@@ -59,25 +59,17 @@ int db_export__machine(struct db_export *dbe, struct machine *machine)
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
@@ -303,15 +295,19 @@ int db_export__sample(struct db_export *dbe, union perf_event *event,
 
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
@@ -321,10 +317,21 @@ int db_export__sample(struct db_export *dbe, union perf_event *event,
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
2.21.0

