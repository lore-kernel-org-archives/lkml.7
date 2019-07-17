Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C08BC76192
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 22:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24CD421019
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 22:58:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="nJp3Rl6x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731149AbfGQW6c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 18:58:32 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43727 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727653AbfGQW6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 18:58:31 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6HMwM0P1722867
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 17 Jul 2019 15:58:22 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6HMwM0P1722867
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563404303;
        bh=0XJp/+EmtjziKDpYMlfxoRS6N+SabMI2Vqh8e3V4euM=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=nJp3Rl6xtO7n0cjI6BKGUn1VH5NArEJTNPc3DIIyJMPVNizpH5OD0vxpYUqE/3S5X
         j2lmXxIJPWwf2QZk0uhVCBiSYI1lAtFU9i/1YpiNKbrtDU7t8xEcPmUFtz8pAtO0Rk
         c7w9nNu/GDPRepXL/UnohRgS3t+iIgY9hP1JbgfnU3C+KLYOTV3+CjMKYkc1xpFEfm
         aAij7RxIwmKF+rqh5EOr+Y/89WobNBzPc6t/rmHG+8l9hwjgYIWnhH+wN8T0N8uF5b
         s6N5vimiDz7dfMPSw5qmBhhiU5DSJd/4gdukTlYi9xaPQUgIEvT471BVBWdoBnqOXQ
         MXWI0OBAJoPWQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6HMwL101722864;
        Wed, 17 Jul 2019 15:58:21 -0700
Date:   Wed, 17 Jul 2019 15:58:21 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-80859c947a1eb170927d03e713abf7550a3d8766@git.kernel.org>
Cc:     jolsa@redhat.com, acme@redhat.com, tglx@linutronix.de,
        mingo@kernel.org, linux-kernel@vger.kernel.org,
        adrian.hunter@intel.com, hpa@zytor.com
Reply-To: adrian.hunter@intel.com, hpa@zytor.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, jolsa@redhat.com, acme@redhat.com,
          tglx@linutronix.de
In-Reply-To: <20190710085810.1650-12-adrian.hunter@intel.com>
References: <20190710085810.1650-12-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf db-export: Factor out db_export__comm()
Git-Commit-ID: 80859c947a1eb170927d03e713abf7550a3d8766
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

Commit-ID:  80859c947a1eb170927d03e713abf7550a3d8766
Gitweb:     https://git.kernel.org/tip/80859c947a1eb170927d03e713abf7550a3d8766
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Wed, 10 Jul 2019 11:58:00 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 10 Jul 2019 12:13:51 -0300

perf db-export: Factor out db_export__comm()

In preparation for exporting the current comm for a thread, factor out
db_export__comm().

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190710085810.1650-12-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/db-export.c | 30 +++++++++++++++++++++++-------
 tools/perf/util/db-export.h |  2 ++
 2 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
index b0504d3eb130..b1e581c13963 100644
--- a/tools/perf/util/db-export.c
+++ b/tools/perf/util/db-export.c
@@ -78,6 +78,26 @@ int db_export__thread(struct db_export *dbe, struct thread *thread,
 	return 0;
 }
 
+static int __db_export__comm(struct db_export *dbe, struct comm *comm,
+			     struct thread *thread)
+{
+	comm->db_id = ++dbe->comm_last_db_id;
+
+	if (dbe->export_comm)
+		return dbe->export_comm(dbe, comm, thread);
+
+	return 0;
+}
+
+int db_export__comm(struct db_export *dbe, struct comm *comm,
+		    struct thread *thread)
+{
+	if (comm->db_id)
+		return 0;
+
+	return __db_export__comm(dbe, comm, thread);
+}
+
 /*
  * Export the "exec" comm. The "exec" comm is the program / application command
  * name at the time it first executes. It is used to group threads for the same
@@ -92,13 +112,9 @@ int db_export__exec_comm(struct db_export *dbe, struct comm *comm,
 	if (comm->db_id)
 		return 0;
 
-	comm->db_id = ++dbe->comm_last_db_id;
-
-	if (dbe->export_comm) {
-		err = dbe->export_comm(dbe, comm, main_thread);
-		if (err)
-			return err;
-	}
+	err = __db_export__comm(dbe, comm, main_thread);
+	if (err)
+		return err;
 
 	/*
 	 * Record the main thread for this comm. Note that the main thread can
diff --git a/tools/perf/util/db-export.h b/tools/perf/util/db-export.h
index 29f7c3b035a7..f5f0865f07e1 100644
--- a/tools/perf/util/db-export.h
+++ b/tools/perf/util/db-export.h
@@ -77,6 +77,8 @@ int db_export__evsel(struct db_export *dbe, struct perf_evsel *evsel);
 int db_export__machine(struct db_export *dbe, struct machine *machine);
 int db_export__thread(struct db_export *dbe, struct thread *thread,
 		      struct machine *machine, struct thread *main_thread);
+int db_export__comm(struct db_export *dbe, struct comm *comm,
+		    struct thread *thread);
 int db_export__exec_comm(struct db_export *dbe, struct comm *comm,
 			 struct thread *main_thread);
 int db_export__comm_thread(struct db_export *dbe, struct comm *comm,
