Return-Path: <SRS0=zSVa=VM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE7E4C7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 21:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4FC320665
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jul 2019 21:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563225238;
	bh=7nJkBRuvAnsAE/Z0YA/8nBjnwPcGgbZa4jU8ZS4VS14=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uGA6XWzf3Sz2mhK7Mml9i46lnEsqW5hw1FQrrpuCeMzDvXxvVSH4YleDb7yXCNO7u
	 j96Fuy5ibH/FqiJ+myruWu2ZLkGtD8y4NIhFci5CFCpTiNcyOPKsbYFY9ozSIuFPTM
	 DeWrraRLoLaXoMgtlJCcvJPzAFHXcFq2ZDt0kqkE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733265AbfGOVN5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jul 2019 17:13:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:44790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731555AbfGOVNz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jul 2019 17:13:55 -0400
Received: from quaco.ghostprotocols.net (179-240-129-12.3g.claro.net.br [179.240.129.12])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0590321721;
        Mon, 15 Jul 2019 21:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563225235;
        bh=7nJkBRuvAnsAE/Z0YA/8nBjnwPcGgbZa4jU8ZS4VS14=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kc9BCNxT9O0VbO0WRckJ0CDs2C/HNyJPz+Zth1MXJuNTYoU8IWnBRJyLTdqXVKKDN
         9245YZ97OXIStOrcUJiByv0lnbYlJnGwOFuUWhfES7xWn9LJ61UWD2i9sgEFChaA30
         7oJ+AoNOjIrqOUmCVrWSy5YuimFiDVd0M+woqG6U=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 20/28] perf script: Add scripting operation process_switch()
Date:   Mon, 15 Jul 2019 18:11:52 -0300
Message-Id: <20190715211200.10984-21-acme@kernel.org>
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

Add scripting operation process_switch() to process switch events.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190710085810.1650-18-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c   | 8 +++++++-
 tools/perf/util/trace-event.h | 3 +++
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 79367087bd18..8f24865596af 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2289,6 +2289,12 @@ static int process_switch_event(struct perf_tool *tool,
 	if (perf_event__process_switch(tool, event, sample, machine) < 0)
 		return -1;
 
+	if (scripting_ops && scripting_ops->process_switch)
+		scripting_ops->process_switch(event, sample, machine);
+
+	if (!script->show_switch_events)
+		return 0;
+
 	thread = machine__findnew_thread(machine, sample->pid,
 					 sample->tid);
 	if (thread == NULL) {
@@ -2467,7 +2473,7 @@ static int __cmd_script(struct perf_script *script)
 		script->tool.mmap = process_mmap_event;
 		script->tool.mmap2 = process_mmap2_event;
 	}
-	if (script->show_switch_events)
+	if (script->show_switch_events || (scripting_ops && scripting_ops->process_switch))
 		script->tool.context_switch = process_switch_event;
 	if (script->show_namespace_events)
 		script->tool.namespaces = process_namespaces_event;
diff --git a/tools/perf/util/trace-event.h b/tools/perf/util/trace-event.h
index d9b0a942090a..c7002fe11673 100644
--- a/tools/perf/util/trace-event.h
+++ b/tools/perf/util/trace-event.h
@@ -81,6 +81,9 @@ struct scripting_ops {
 			       struct perf_sample *sample,
 			       struct perf_evsel *evsel,
 			       struct addr_location *al);
+	void (*process_switch)(union perf_event *event,
+			       struct perf_sample *sample,
+			       struct machine *machine);
 	void (*process_stat)(struct perf_stat_config *config,
 			     struct perf_evsel *evsel, u64 tstamp);
 	void (*process_stat_interval)(u64 tstamp);
-- 
2.21.0

