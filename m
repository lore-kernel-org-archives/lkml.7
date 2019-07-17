Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 782DFC7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 23:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43B5E21783
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 23:03:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="f31SK2iB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731067AbfGQXDe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 19:03:34 -0400
Received: from terminus.zytor.com ([198.137.202.136]:34009 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727468AbfGQXDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 19:03:33 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6HN3NhL1723774
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 17 Jul 2019 16:03:24 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6HN3NhL1723774
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563404604;
        bh=uPAOdwprJAFOepW0GMIgklqSirBQC831nu83XqfJjj0=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=f31SK2iBz2htFZIpJuQQl4mRwUPQ0ppnkPboOQ0WTSnOIQ1YBU7aAAFczA+t7H134
         CVCG/eejXn0Jh4lS5wgOFerwcE1QPj28ezYoQXojEu2AbdxY7agRGN32DoIMav7wo0
         lb4T7ifoahtZ0rQh+ZvaJTJU7LLiW3kI8l1cXys4N5e9Xmy0gKJGRtWVPDVsOIrrX9
         hfuep7zHtpRbWKPlzbMT4ZShjW3mPwmN9z3cQC8ogCeftyAM3SURH2d7PvRSpr1lSm
         f8NG8VyjLjdBrciKDhDcuzeGG+vkoJmSZoD0LHed+EsUlCBzAgYnjTMvUq4CyYGvr5
         O/MH93TXiehjA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6HN3MaR1723771;
        Wed, 17 Jul 2019 16:03:22 -0700
Date:   Wed, 17 Jul 2019 16:03:22 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-b3694e6c0a05383891546c6e3cdef8659d50b653@git.kernel.org>
Cc:     adrian.hunter@intel.com, mingo@kernel.org, acme@redhat.com,
        hpa@zytor.com, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        jolsa@redhat.com
Reply-To: adrian.hunter@intel.com, mingo@kernel.org, hpa@zytor.com,
          acme@redhat.com, jolsa@redhat.com, tglx@linutronix.de,
          linux-kernel@vger.kernel.org
In-Reply-To: <20190710085810.1650-19-adrian.hunter@intel.com>
References: <20190710085810.1650-19-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf db-export: Factor out db_export__threads()
Git-Commit-ID: b3694e6c0a05383891546c6e3cdef8659d50b653
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

Commit-ID:  b3694e6c0a05383891546c6e3cdef8659d50b653
Gitweb:     https://git.kernel.org/tip/b3694e6c0a05383891546c6e3cdef8659d50b653
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Wed, 10 Jul 2019 11:58:07 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 10 Jul 2019 12:35:18 -0300

perf db-export: Factor out db_export__threads()

In preparation for exporting switch events, factor out
db_export__threads().

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190710085810.1650-19-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/db-export.c | 82 ++++++++++++++++++++++++++-------------------
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
 
