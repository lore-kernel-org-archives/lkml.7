Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21CF6C76192
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 22:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF5EC21019
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 22:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="loawEx/O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730980AbfGQWwx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 18:52:53 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44673 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727653AbfGQWwx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 18:52:53 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6HMqhbX1721851
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 17 Jul 2019 15:52:44 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6HMqhbX1721851
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563403964;
        bh=W3OajX/nmC8OsYG1+gxP+Y0jR33P9AP17+i4pmjLMgA=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=loawEx/O/ivf6vzso/WeuY5Ma1yJAqZgAvwrDj1AMItAsC3v17RZkl9ZNhfr6Y1Zu
         jcs7pK+aTangSezXc8Wh1+ETv+rwXlUkdQzgPSdeempygk1g+Iub/30P3IjAroaWlr
         f1Fy8uVZK+45RuAm9EQaozMR5UT3OnCc8gzOykIEDoG7wotDvDwYskin3Eu0g3QpTI
         eqs0dfawIH5+tyoduPPn1icqOM4M9BWZWt7ml/7vaV0P3UgY+0EJ0Lg6iRIdETUZQS
         lA32SXM27+q7/f8QHQ0o3PQpIzVLBSSmHTzV8T4BNaAf1TsITfDqK+lcgscQSAhjjO
         ep2oKKnDBJ10g==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6HMqh5F1721848;
        Wed, 17 Jul 2019 15:52:43 -0700
Date:   Wed, 17 Jul 2019 15:52:43 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-ed5c0a16feb9f1a4347f109d5e9607f6f38688a0@git.kernel.org>
Cc:     jolsa@redhat.com, linux-kernel@vger.kernel.org, hpa@zytor.com,
        tglx@linutronix.de, mingo@kernel.org, adrian.hunter@intel.com,
        acme@redhat.com
Reply-To: jolsa@redhat.com, hpa@zytor.com, tglx@linutronix.de,
          mingo@kernel.org, linux-kernel@vger.kernel.org,
          adrian.hunter@intel.com, acme@redhat.com
In-Reply-To: <20190710085810.1650-4-adrian.hunter@intel.com>
References: <20190710085810.1650-4-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf db-export: Pass main_thread to
 db_export__thread()
Git-Commit-ID: ed5c0a16feb9f1a4347f109d5e9607f6f38688a0
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

Commit-ID:  ed5c0a16feb9f1a4347f109d5e9607f6f38688a0
Gitweb:     https://git.kernel.org/tip/ed5c0a16feb9f1a4347f109d5e9607f6f38688a0
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Wed, 10 Jul 2019 11:57:52 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 10 Jul 2019 12:11:04 -0300

perf db-export: Pass main_thread to db_export__thread()

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
