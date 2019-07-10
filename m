Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B8BC606B0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 09:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BBE82084B
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 09:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727984AbfGJJAp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 05:00:45 -0400
Received: from mga12.intel.com ([192.55.52.136]:35463 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727715AbfGJI7d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 04:59:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jul 2019 01:59:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,474,1557212400"; 
   d="scan'208";a="186102514"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.122])
  by fmsmga001.fm.intel.com with ESMTP; 10 Jul 2019 01:59:28 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 04/21] perf db-export: Export main_thread in db_export__sample()
Date:   Wed, 10 Jul 2019 11:57:53 +0300
Message-Id: <20190710085810.1650-5-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190710085810.1650-1-adrian.hunter@intel.com>
References: <20190710085810.1650-1-adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export main_thread in db_export__sample() because it makes the code
easier to understand, and prepares db_export__thread() for further
simplification.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/db-export.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
index 7ad596bef4a9..f6d062d8c5e1 100644
--- a/tools/perf/util/db-export.c
+++ b/tools/perf/util/db-export.c
@@ -70,16 +70,10 @@ int db_export__thread(struct db_export *dbe, struct thread *thread,
 	thread->db_id = ++dbe->thread_last_db_id;
 
 	if (main_thread) {
-		if (main_thread != thread) {
-			err = db_export__thread(dbe, main_thread, machine,
-						comm, main_thread);
+		if (main_thread != thread && comm) {
+			err = db_export__comm_thread(dbe, comm, thread);
 			if (err)
 				return err;
-			if (comm) {
-				err = db_export__comm_thread(dbe, comm, thread);
-				if (err)
-					return err;
-			}
 		}
 		main_thread_db_id = main_thread->db_id;
 	}
@@ -307,12 +301,24 @@ int db_export__sample(struct db_export *dbe, union perf_event *event,
 		return err;
 
 	main_thread = thread__main_thread(al->machine, thread);
-	if (main_thread)
+	if (main_thread) {
 		comm = machine__thread_exec_comm(al->machine, main_thread);
+		/*
+		 * A thread has a reference to the main thread, so export the
+		 * main thread first.
+		 */
+		err = db_export__thread(dbe, main_thread, al->machine, comm,
+					main_thread);
+		if (err)
+			goto out_put;
+	}
 
-	err = db_export__thread(dbe, thread, al->machine, comm, main_thread);
-	if (err)
-		goto out_put;
+	if (thread != main_thread) {
+		err = db_export__thread(dbe, thread, al->machine, comm,
+					main_thread);
+		if (err)
+			goto out_put;
+	}
 
 	if (comm) {
 		err = db_export__exec_comm(dbe, comm, main_thread);
-- 
2.17.1

