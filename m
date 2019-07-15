Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8E51C76191
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 21:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D38020665
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 21:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563225194;
	bh=XnorXM6JvtfSi9usCoB2dmMYKLPx1fRcQK6cIGTisKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UQOiXEBVLl4gCataUQSD/9ubcuD7P0V4SXupE530Wvny/3zecXf7Wjzq1sv05ugMW
	 cSvbd1SRBpKH5xYtoMGBWh5HCqu/G0+i/zG1HBxX32W0HYMxGiTb7flcdoLN7fp8ig
	 9mhl9kUOtnnWQYRTiOse2os4d1eTsjfvrOTpaHmg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733094AbfGOVNN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 17:13:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:44050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730207AbfGOVNL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 17:13:11 -0400
Received: from quaco.ghostprotocols.net (179-240-129-12.3g.claro.net.br [179.240.129.12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5872F20693;
        Mon, 15 Jul 2019 21:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563225190;
        bh=XnorXM6JvtfSi9usCoB2dmMYKLPx1fRcQK6cIGTisKA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A4LUOt7+mZHf2oyB9zS/O9IT5lkltgXxLFplxvBaP3ia7BomGcEOY1xFtafiOrYte
         I8NsIoDRGa8NGa9BH3/ZZlaLsB424S5FoJQkapzsinEw6bP4V0bROvAuv95bjCon+O
         S3/phY+fdvkWAUv/fdZdib1uIUZ3Y7wRPugNRNk8=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 11/28] perf db-export: Export comm details
Date:   Mon, 15 Jul 2019 18:11:43 -0300
Message-Id: <20190715211200.10984-12-acme@kernel.org>
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
 
-- 
2.21.0

