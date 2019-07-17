Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A9F2C7618F
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 23:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A55221019
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 23:02:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="xVg1dDny"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730927AbfGQXCu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 19:02:50 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44473 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727657AbfGQXCt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 19:02:49 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6HN2fb81723479
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Wed, 17 Jul 2019 16:02:41 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6HN2fb81723479
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563404561;
        bh=wPcCAoWm2doK7gpHCiEd/1x7HQmt4DFRB1WvyWFTVk4=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=xVg1dDnypaOrkf2KdAljrCDhQRLU3g8NrHpUDZkYw51Tt+IyPDJfbwowFCOV6cQ2g
         EiUMUsB1yqXi359l8wYbyTWW74PWTMxElyyk4fcdE127UJOA4STk4+IRPtU1cwz8p4
         MOu+56AjXPVx0OMZYbQFt+AL5fQD07EcvGH9ju1Lzy3C3oBaEXb5Osk2iZgpJ7CPPI
         tjHGzAGanenHIkLNnRgVT8pquo8KaNQwsx4/blAetQAPHfSdSVSdGLtRKxySHE3l7g
         wEnhEsy7YI9ib5+MoKx+YqYCYM5KxbPav5yT617AeOUCHPcBboJLc4puWzUcvNb87B
         dXTqDvC6szhRQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6HN2eLb1723476;
        Wed, 17 Jul 2019 16:02:40 -0700
Date:   Wed, 17 Jul 2019 16:02:40 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-5bf83c29a0ad2e78683c318b607539dbadbf7a3b@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, acme@redhat.com, jolsa@redhat.com,
        hpa@zytor.com, tglx@linutronix.de, adrian.hunter@intel.com,
        mingo@kernel.org
Reply-To: linux-kernel@vger.kernel.org, tglx@linutronix.de,
          adrian.hunter@intel.com, acme@redhat.com, jolsa@redhat.com,
          hpa@zytor.com, mingo@kernel.org
In-Reply-To: <20190710085810.1650-18-adrian.hunter@intel.com>
References: <20190710085810.1650-18-adrian.hunter@intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf script: Add scripting operation
 process_switch()
Git-Commit-ID: 5bf83c29a0ad2e78683c318b607539dbadbf7a3b
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

Commit-ID:  5bf83c29a0ad2e78683c318b607539dbadbf7a3b
Gitweb:     https://git.kernel.org/tip/5bf83c29a0ad2e78683c318b607539dbadbf7a3b
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Wed, 10 Jul 2019 11:58:06 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 10 Jul 2019 12:34:09 -0300

perf script: Add scripting operation process_switch()

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
