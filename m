Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16461C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 21:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1F9A21738
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 21:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563225174;
	bh=OCKxl0xDpTjevvmq9JicqRJ/WvDx56jxS1/xx74xirg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=H6C4PnMQlsCyx2VQsq2/AZseIfsjHwElZQeb2EEnVqZLV0L9YcQN/+P231hBVg67q
	 QysFgczRXrtvAg+p0TCQG+C3u3ZeFSPSCmiv3idaRWtRNdpo1l6d7c2fqS/uvrhTC2
	 0ZfYNJ6e9y6v/xw4Fanynknt64MwOCYkieY2BT84=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732994AbfGOVMw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 17:12:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:43652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730207AbfGOVMw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 17:12:52 -0400
Received: from quaco.ghostprotocols.net (179-240-129-12.3g.claro.net.br [179.240.129.12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9829121721;
        Mon, 15 Jul 2019 21:12:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563225171;
        bh=OCKxl0xDpTjevvmq9JicqRJ/WvDx56jxS1/xx74xirg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aftClrSXQmOwje1CciOYW0cw5y1d22bRgn7zi4ca4MSGdmqwlJmhx2S+PkZN7Ssye
         7Ve0Z8eIDo2s5xn5aWXUv39hGUlc8w4QiHUEGG0qHKRtr4YHLemlsb7FvTr7ZdZ9ne
         IF6bdMa06eFTiPb+hMce8LVtX6vmg2CLK74G53vc=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 07/28] perf db-export: Export main_thread in db_export__sample()
Date:   Mon, 15 Jul 2019 18:11:39 -0300
Message-Id: <20190715211200.10984-8-acme@kernel.org>
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

Export main_thread in db_export__sample() because it makes the code
easier to understand, and prepares db_export__thread() for further
simplification.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190710085810.1650-5-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/db-export.c | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
index 14501236c046..63f9edf65eee 100644
--- a/tools/perf/util/db-export.c
+++ b/tools/perf/util/db-export.c
@@ -71,16 +71,10 @@ int db_export__thread(struct db_export *dbe, struct thread *thread,
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
@@ -308,12 +302,24 @@ int db_export__sample(struct db_export *dbe, union perf_event *event,
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
2.21.0

