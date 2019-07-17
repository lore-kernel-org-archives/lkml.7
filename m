Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1560DC7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 22:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6AA721019
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 22:52:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="N3s99tN8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729623AbfGQWwL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 18:52:11 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50851 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727653AbfGQWwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 18:52:11 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6HMq1j01721705
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 17 Jul 2019 15:52:01 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6HMq1j01721705
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563403921;
        bh=UpDARGQH1BITakFQV3CHB9vr/SxlkyLu27Ak4ECAG5s=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=N3s99tN8OGIFxWQ/CoJ6HKHyZNG2ezWV/V+c0SJbds92fd3c6ov55AKsdPdfpyIsc
         59K8iHlA0X5NwwG7P4X9dklee9BeHlHD9laQPjVdt0kK1g8ySaBDmzg5/slGh2NF2C
         dprTawXqv7Pns5TJm+3Iww1eSFnfiU6uEzCDSl6WXuhRC7wEmxCNjxEOB2EKi6tKfg
         Sp+kjwWEip774x4KBvXFzPk/pKcdTr7s0mhx1V07xtc6+9eyb3UGM+mdDT/vEe1qUb
         tjUf51AV740GRj4fP8ZawdChT2ZwFopLA1pDjnnkbHmIJ0Wqe/jQFnD4OQzazJJgA4
         UeaIiT97XRYMA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6HMq0F81721702;
        Wed, 17 Jul 2019 15:52:00 -0700
Date:   Wed, 17 Jul 2019 15:52:00 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-208032fef13b68cf1eefc945dafb82efc88c6b8f@git.kernel.org>
Cc:     hpa@zytor.com, acme@redhat.com, jolsa@redhat.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org,
        adrian.hunter@intel.com
Reply-To: linux-kernel@vger.kernel.org, acme@redhat.com, jolsa@redhat.com,
          adrian.hunter@intel.com, mingo@kernel.org, hpa@zytor.com,
          tglx@linutronix.de
In-Reply-To: <20190710085810.1650-3-adrian.hunter@intel.com>
References: <20190710085810.1650-3-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf db-export: Rename db_export__comm() to
 db_export__exec_comm()
Git-Commit-ID: 208032fef13b68cf1eefc945dafb82efc88c6b8f
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

Commit-ID:  208032fef13b68cf1eefc945dafb82efc88c6b8f
Gitweb:     https://git.kernel.org/tip/208032fef13b68cf1eefc945dafb82efc88c6b8f
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Wed, 10 Jul 2019 11:57:51 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 10 Jul 2019 12:10:27 -0300

perf db-export: Rename db_export__comm() to db_export__exec_comm()

Rename db_export__comm() to db_export__exec_comm() to better reflect
what it does and add explanatory comments.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190710085810.1650-3-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/db-export.c | 22 +++++++++++++++++++---
 tools/perf/util/db-export.h |  4 ++--
 2 files changed, 21 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
index 34cf197fe74f..8fab57f90cbc 100644
--- a/tools/perf/util/db-export.c
+++ b/tools/perf/util/db-export.c
@@ -105,8 +105,14 @@ out_put:
 	return err;
 }
 
-int db_export__comm(struct db_export *dbe, struct comm *comm,
-		    struct thread *main_thread)
+/*
+ * Export the "exec" comm. The "exec" comm is the program / application command
+ * name at the time it first executes. It is used to group threads for the same
+ * program. Note that the main thread pid (or thread group id tgid) cannot be
+ * used because it does not change when a new program is exec'ed.
+ */
+int db_export__exec_comm(struct db_export *dbe, struct comm *comm,
+			 struct thread *main_thread)
 {
 	int err;
 
@@ -121,6 +127,16 @@ int db_export__comm(struct db_export *dbe, struct comm *comm,
 			return err;
 	}
 
+	/*
+	 * Record the main thread for this comm. Note that the main thread can
+	 * have many "exec" comms because there will be a new one every time it
+	 * exec's. An "exec" comm however will only ever have 1 main thread.
+	 * That is different to any other threads for that same program because
+	 * exec() will effectively kill them, so the relationship between the
+	 * "exec" comm and non-main threads is 1-to-1. That is why
+	 * db_export__comm_thread() is called here for the main thread, but it
+	 * is called for non-main threads when they are exported.
+	 */
 	return db_export__comm_thread(dbe, comm, main_thread);
 }
 
@@ -313,7 +329,7 @@ int db_export__sample(struct db_export *dbe, union perf_event *event,
 		goto out_put;
 
 	if (comm) {
-		err = db_export__comm(dbe, comm, main_thread);
+		err = db_export__exec_comm(dbe, comm, main_thread);
 		if (err)
 			goto out_put;
 		es.comm_db_id = comm->db_id;
diff --git a/tools/perf/util/db-export.h b/tools/perf/util/db-export.h
index 261cfece8dee..148a657b1887 100644
--- a/tools/perf/util/db-export.h
+++ b/tools/perf/util/db-export.h
@@ -76,8 +76,8 @@ int db_export__evsel(struct db_export *dbe, struct perf_evsel *evsel);
 int db_export__machine(struct db_export *dbe, struct machine *machine);
 int db_export__thread(struct db_export *dbe, struct thread *thread,
 		      struct machine *machine, struct comm *comm);
-int db_export__comm(struct db_export *dbe, struct comm *comm,
-		    struct thread *main_thread);
+int db_export__exec_comm(struct db_export *dbe, struct comm *comm,
+			 struct thread *main_thread);
 int db_export__comm_thread(struct db_export *dbe, struct comm *comm,
 			   struct thread *thread);
 int db_export__dso(struct db_export *dbe, struct dso *dso,
