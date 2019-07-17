Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A007FC7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 22:55:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6469321019
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 22:55:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="VQjvUhJY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730735AbfGQWzA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 18:55:00 -0400
Received: from terminus.zytor.com ([198.137.202.136]:37473 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727543AbfGQWy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 18:54:59 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6HMsqad1722270
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 17 Jul 2019 15:54:52 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6HMsqad1722270
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563404092;
        bh=bJRUU6A2LR0MUtymCwJ7tDboxDL4UGD+458Sulus8So=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=VQjvUhJY6yjznLgmbHnesu6Q+x8qduPOrM1K6j1/5lWxpcKxvRB+zPtnQPUtGryS5
         aWT8b8s4bQzLEGHAMjgml2B3kYqJTbMSQZzp+CFT3z/YBxvidR2Belitz2HRkfjCgh
         5yugXE7Ju49BtOdnFKxhSpeZuWf/0gtHvuRI385id/WWZogr9hdRybn1/MDFz9wQcK
         VIIBkzbxqycOcJjZkDpbmcc5+6KEZUszXfaPN8OKVKIWchA8K55k71oxgf4fuav70W
         7Mep2Se29q1vEEtfW0SlUT9St/A66EcJ59ZFeXPyJ5hT+yp1C8TDDtSdv/w7fLokyt
         RXnLnUl45bnIA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6HMsp5Q1722265;
        Wed, 17 Jul 2019 15:54:51 -0700
Date:   Wed, 17 Jul 2019 15:54:51 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-1ed119589834e25c130fdaa911ca8b0e3fd1cddf@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org,
        hpa@zytor.com, acme@redhat.com, jolsa@redhat.com,
        adrian.hunter@intel.com
Reply-To: tglx@linutronix.de, mingo@kernel.org,
          linux-kernel@vger.kernel.org, hpa@zytor.com, jolsa@redhat.com,
          acme@redhat.com, adrian.hunter@intel.com
In-Reply-To: <20190710085810.1650-7-adrian.hunter@intel.com>
References: <20190710085810.1650-7-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf db-export: Move export__comm_thread into
 db_export__sample()
Git-Commit-ID: 1ed119589834e25c130fdaa911ca8b0e3fd1cddf
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

Commit-ID:  1ed119589834e25c130fdaa911ca8b0e3fd1cddf
Gitweb:     https://git.kernel.org/tip/1ed119589834e25c130fdaa911ca8b0e3fd1cddf
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Wed, 10 Jul 2019 11:57:55 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 10 Jul 2019 12:12:45 -0300

perf db-export: Move export__comm_thread into db_export__sample()

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
