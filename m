Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5369FC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 21:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 282462171F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 21:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563225170;
	bh=rZHBqbDGqCH06DNkgPdKYIJqvOnyCsLRw7dL24Sc1oA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lQc4jZ1BQ/jYXu0RoujN2Jza1xf/o5/ZqXvBIHFaVEPdcj8Geof0YPAlhMvhc5wOb
	 rb2p7muZrDVj4yl1X6xyTWdGHpTYBRRA8WQCsAXV3Z9WNxDMeLAG4Bmu6Qh0YnuR78
	 gMfCnvW5MhfoJeiiLSXT2n/nas+oVxqfDK2f9hpI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732965AbfGOVMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 17:12:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:43568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730207AbfGOVMs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 17:12:48 -0400
Received: from quaco.ghostprotocols.net (179-240-129-12.3g.claro.net.br [179.240.129.12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EFADF21738;
        Mon, 15 Jul 2019 21:12:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563225166;
        bh=rZHBqbDGqCH06DNkgPdKYIJqvOnyCsLRw7dL24Sc1oA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ENeBXWSD5CA1T3LCOfJRYqtCQa8zBSwEcTgdT6vLK81yocCV9DexJKHvJ2DQ7maQf
         8iVAxAfD8xH6A2fFzDMmlmUbrUo0TID8wzV3auFTt88NKb9oxBUZ4IaCjXIIYc604x
         SrOFmgfGn9fg/bcctJhWs+SmqXz76V9CnfA9rcVE=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 06/28] perf db-export: Pass main_thread to db_export__thread()
Date:   Mon, 15 Jul 2019 18:11:38 -0300
Message-Id: <20190715211200.10984-7-acme@kernel.org>
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

Calls to db_export__thread() already have main_thread so there is no
reason to get it again, instead pass it as a parameter. Note that one
difference in this approach is that the main thread is not created if it
does not exist. It is better if it is not created because:

   - If main_thread is being traced it will have been created already.

   - If it is not being traced, there will be no other information about
     it, and it will never get deleted because there will be no EXIT event.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190710085810.1650-4-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/db-export.c | 29 ++++++++---------------------
 tools/perf/util/db-export.h |  3 ++-
 2 files changed, 10 insertions(+), 22 deletions(-)

diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
index 8fab57f90cbc..14501236c046 100644
--- a/tools/perf/util/db-export.c
+++ b/tools/perf/util/db-export.c
@@ -59,9 +59,9 @@ int db_export__machine(struct db_export *dbe, struct machine *machine)
 }
 
 int db_export__thread(struct db_export *dbe, struct thread *thread,
-		      struct machine *machine, struct comm *comm)
+		      struct machine *machine, struct comm *comm,
+		      struct thread *main_thread)
 {
-	struct thread *main_thread;
 	u64 main_thread_db_id = 0;
 	int err;
 
@@ -70,28 +70,19 @@ int db_export__thread(struct db_export *dbe, struct thread *thread,
 
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
@@ -99,10 +90,6 @@ int db_export__thread(struct db_export *dbe, struct thread *thread,
 					  machine);
 
 	return 0;
-
-out_put:
-	thread__put(main_thread);
-	return err;
 }
 
 /*
@@ -324,7 +311,7 @@ int db_export__sample(struct db_export *dbe, union perf_event *event,
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
2.21.0

