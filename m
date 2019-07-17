Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A87BC7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 22:56:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DEC6C21019
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 22:56:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="C9qEIpHi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729649AbfGQW4Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 18:56:25 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46343 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727543AbfGQW4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 18:56:25 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6HMuGnt1722425
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 17 Jul 2019 15:56:16 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6HMuGnt1722425
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563404177;
        bh=AVWrYEl5S9hl7u60NF74TJiIhaKeHbjJyAGLJRI8468=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=C9qEIpHiv6mx+B8b1Y9B8oIoVkv8BypR5x7uZOmJp2J/qBZ6VzcSQKLkaYNjqon7E
         wnBzhijeFuP3GilhRzb8CKWw1KqN//56uc68po4bE8QmfLoVgdWf4TqCFvmPTAKEJ0
         w5K0FQXrcFPYmuJ7XpefNx4KZA6SWt1PQzGOXjT+RQOl/s4OH7Gico5/d7WGbMYXqo
         DNdXWvEY3W66/sUscCxAfMQA2985sGji8VB/Au1p+LBTC6Ogqa0tLUxTXB8MCypNQo
         2Y8HOdhs/cHVprxw0+UtcCQVy88WHLOT6ECyBh6dzH7AT8nqlhCFAaQwTsRUVyLO0i
         P5iR89lOgxnow==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6HMuFTR1722422;
        Wed, 17 Jul 2019 15:56:15 -0700
Date:   Wed, 17 Jul 2019 15:56:15 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-8ebf5cc0f6ce469d65ba2e8ce519dae34f0b3f50@git.kernel.org>
Cc:     tglx@linutronix.de, acme@redhat.com, adrian.hunter@intel.com,
        mingo@kernel.org, jolsa@redhat.com, hpa@zytor.com,
        linux-kernel@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org, hpa@zytor.com, jolsa@redhat.com,
          acme@redhat.com, mingo@kernel.org, adrian.hunter@intel.com,
          tglx@linutronix.de
In-Reply-To: <20190710085810.1650-9-adrian.hunter@intel.com>
References: <20190710085810.1650-9-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf db-export: Export comm details
Git-Commit-ID: 8ebf5cc0f6ce469d65ba2e8ce519dae34f0b3f50
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

Commit-ID:  8ebf5cc0f6ce469d65ba2e8ce519dae34f0b3f50
Gitweb:     https://git.kernel.org/tip/8ebf5cc0f6ce469d65ba2e8ce519dae34f0b3f50
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Wed, 10 Jul 2019 11:57:57 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 10 Jul 2019 12:13:08 -0300

perf db-export: Export comm details

In preparation for exporting the current comm for a thread, export comm
thread id, start time and exec flag.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190710085810.1650-9-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/db-export.c                            | 2 +-
 tools/perf/util/db-export.h                            | 3 ++-
 tools/perf/util/scripting-engines/trace-event-python.c | 8 ++++++--
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
index 2c3a4ad68428..b0504d3eb130 100644
--- a/tools/perf/util/db-export.c
+++ b/tools/perf/util/db-export.c
@@ -95,7 +95,7 @@ int db_export__exec_comm(struct db_export *dbe, struct comm *comm,
 	comm->db_id = ++dbe->comm_last_db_id;
 
 	if (dbe->export_comm) {
-		err = dbe->export_comm(dbe, comm);
+		err = dbe->export_comm(dbe, comm, main_thread);
 		if (err)
 			return err;
 	}
diff --git a/tools/perf/util/db-export.h b/tools/perf/util/db-export.h
index 811a678a910d..29f7c3b035a7 100644
--- a/tools/perf/util/db-export.h
+++ b/tools/perf/util/db-export.h
@@ -43,7 +43,8 @@ struct db_export {
 	int (*export_machine)(struct db_export *dbe, struct machine *machine);
 	int (*export_thread)(struct db_export *dbe, struct thread *thread,
 			     u64 main_thread_db_id, struct machine *machine);
-	int (*export_comm)(struct db_export *dbe, struct comm *comm);
+	int (*export_comm)(struct db_export *dbe, struct comm *comm,
+			   struct thread *thread);
 	int (*export_comm_thread)(struct db_export *dbe, u64 db_id,
 				  struct comm *comm, struct thread *thread);
 	int (*export_dso)(struct db_export *dbe, struct dso *dso,
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index c9837f0f0fd6..28167e938cef 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -1011,15 +1011,19 @@ static int python_export_thread(struct db_export *dbe, struct thread *thread,
 	return 0;
 }
 
-static int python_export_comm(struct db_export *dbe, struct comm *comm)
+static int python_export_comm(struct db_export *dbe, struct comm *comm,
+			      struct thread *thread)
 {
 	struct tables *tables = container_of(dbe, struct tables, dbe);
 	PyObject *t;
 
-	t = tuple_new(2);
+	t = tuple_new(5);
 
 	tuple_set_u64(t, 0, comm->db_id);
 	tuple_set_string(t, 1, comm__str(comm));
+	tuple_set_u64(t, 2, thread->db_id);
+	tuple_set_u64(t, 3, comm->start);
+	tuple_set_s32(t, 4, comm->exec);
 
 	call_object(tables->comm_handler, t, "comm_table");
 
