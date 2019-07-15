Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88B13C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 21:13:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5805021721
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 21:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563225215;
	bh=28Yv58TYiFdiUP3XiLAwNwy6/UbZfSMt3fqBx2TAsuY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eGD/nVJdVEkXkL1BM1780W3gNe6lYPmjVm6Lb8JwxYAZRiFH+Y5m6OK3zOYEbvzDZ
	 bspVnTd0SrGLsLPdN4gBHjROk4omOeElL/Mo0AWyL07y4qwRKBPaM972W5YYX7PKR/
	 ZurokDevEvE18l1YxQC1qY5T+A9P6Pe9EtYKqEOM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733189AbfGOVNd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 17:13:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:44448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731109AbfGOVNc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 17:13:32 -0400
Received: from quaco.ghostprotocols.net (179-240-129-12.3g.claro.net.br [179.240.129.12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 364E220449;
        Mon, 15 Jul 2019 21:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563225211;
        bh=28Yv58TYiFdiUP3XiLAwNwy6/UbZfSMt3fqBx2TAsuY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P2uw70ZJc3QW52Dj9TC8Y5CfZuCl38e3WiZBIArw8rrQr9EDWS/AasVp9vREafK0c
         1uAvbiv5rfnRIQPJpEVnu9bLmrSnefwhZyNzt+5yRowYYyBvu2/8vSzqrmbo7TJY6C
         WnGuSJYU0syiicdLO2KSICrIDfRwlyq/PxTejtYM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 15/28] perf db-export: Also export thread's current comm
Date:   Mon, 15 Jul 2019 18:11:47 -0300
Message-Id: <20190715211200.10984-16-acme@kernel.org>
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

Currently, the initial comm of the main thread is exported. Export also
a thread's current comm. That better supports the tracing of
multi-threaded applications that set different comms for different
threads to make it easier to distinguish them.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190710085810.1650-13-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/db-export.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/perf/util/db-export.c b/tools/perf/util/db-export.c
index b1e581c13963..5057fdd7f62d 100644
--- a/tools/perf/util/db-export.c
+++ b/tools/perf/util/db-export.c
@@ -299,6 +299,7 @@ int db_export__sample(struct db_export *dbe, union perf_event *event,
 	};
 	struct thread *main_thread;
 	struct comm *comm = NULL;
+	struct comm *curr_comm;
 	int err;
 
 	err = db_export__evsel(dbe, evsel);
@@ -350,6 +351,13 @@ int db_export__sample(struct db_export *dbe, union perf_event *event,
 		}
 	}
 
+	curr_comm = thread__comm(thread);
+	if (curr_comm) {
+		err = db_export__comm(dbe, curr_comm, thread);
+		if (err)
+			goto out_put;
+	}
+
 	es.db_id = ++dbe->sample_last_db_id;
 
 	err = db_ids_from_al(dbe, al, &es.dso_db_id, &es.sym_db_id, &es.offset);
-- 
2.21.0

