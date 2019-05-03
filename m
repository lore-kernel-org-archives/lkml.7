Return-Path: <SRS0=RThv=TD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D81C43219
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 08:19:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD0B42075C
	for <linux-kernel@archiver.kernel.org>; Fri,  3 May 2019 08:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556871568;
	bh=t/K0JwCPEv4xf79o5IyVcF+mzwPd68sLTKmulz1Xywo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=c3rdEEX0L1ODEsG51+yxcLKetiwWN7nzGyUaX220UnRw4iBdHTBAGyeeduLc6Q/HT
	 bM1rexOwbhFNL0dHtGHD13Tgj6dku7EU3nx+9vIePFdp7ogafYJSi4GfOX+QxEehf9
	 SgYxR90JeHL0uzlrGZNl76ea4umDiHQZW6GMr/48=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbfECIT1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 May 2019 04:19:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35824 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727220AbfECITS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 May 2019 04:19:18 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 43042307EA8F;
        Fri,  3 May 2019 08:19:18 +0000 (UTC)
Received: from krava.brq.redhat.com (unknown [10.43.17.48])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 228E2F6E6;
        Fri,  3 May 2019 08:19:15 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Stanislav Fomichev <sdf@fomichev.me>,
        Song Liu <songliubraving@fb.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 12/12] perf script: Add --show-all-events option
Date:   Fri,  3 May 2019 10:18:41 +0200
Message-Id: <20190503081841.1908-13-jolsa@kernel.org>
In-Reply-To: <20190503081841.1908-1-jolsa@kernel.org>
References: <20190503081841.1908-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Fri, 03 May 2019 08:19:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding --show-all-events option to show all
side-bad events with single option, like:

  $ perf script --show-all-events
  swapper     0 [000]     0.000000: PERF_RECORD_MMAP -1/0: [0xffffffffa6000000(0xc00e41) @ 0xffffffffa6000000]: x [kernel.kallsyms]_text
  ...
  swapper     0 [000]     0.000000: PERF_RECORD_KSYMBOL addr ffffffffc01bc362 len 229 type 1 flags 0x0 name bpf_prog_7be49e3934a125ba
  swapper     0 [000]     0.000000: PERF_RECORD_BPF_EVENT type 1, flags 0, id 29
  ...
  swapper     0 [000]     0.000000: PERF_RECORD_FORK(1:1):(0:0)
  systemd     0 [000]     0.000000: PERF_RECORD_COMM: systemd:1/1
  ...
  swapper     0 [000] 63587.039518:          1 cycles:  ffffffffa60698b4 [unknown] ([kernel.kallsyms])
  swapper     0 [000] 63587.039522:          1 cycles:  ffffffffa60698b4 [unknown] ([kernel.kallsyms])

Link: http://lkml.kernel.org/n/tip-g7vmuwn6i7pa8cdpnxl9vsur@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/Documentation/perf-script.txt |  3 +++
 tools/perf/builtin-script.c              | 13 +++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index af8282782911..ddcd08bf0172 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -316,6 +316,9 @@ OPTIONS
 --show-bpf-events
 	Display bpf events i.e. events of type PERF_RECORD_KSYMBOL and PERF_RECORD_BPF_EVENT.
 
+--show-all-events
+	Display all side-band events i.e. enable all --show-*-events options.
+
 --demangle::
 	Demangle symbol names to human readable form. It's enabled by default,
 	disable with --no-demangle.
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 3a48a2627670..e7462dcab2c6 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1607,6 +1607,7 @@ struct perf_script {
 	bool			show_lost_events;
 	bool			show_round_events;
 	bool			show_bpf_events;
+	bool			show_all_events;
 	bool			allocated;
 	bool			per_event_dump;
 	struct cpu_map		*cpus;
@@ -2436,6 +2437,16 @@ static int __cmd_script(struct perf_script *script)
 
 	perf_stat__init_shadow_stats();
 
+	if (script->show_all_events) {
+		script->show_task_events	= true;
+		script->show_mmap_events	= true;
+		script->show_switch_events	= true;
+		script->show_namespace_events	= true;
+		script->show_lost_events	= true;
+		script->show_round_events	= true;
+		script->show_bpf_events		= true;
+	}
+
 	/* override event processing functions */
 	if (script->show_task_events) {
 		script->tool.comm = process_comm_event;
@@ -3481,6 +3492,8 @@ int cmd_script(int argc, const char **argv)
 		    "Show round events (if recorded)"),
 	OPT_BOOLEAN('\0', "show-bpf-events", &script.show_bpf_events,
 		    "Show bpf related events (if recorded)"),
+	OPT_BOOLEAN('\0', "show-all-events", &script.show_all_events,
+		    "Show all side-band events (if recorded)"),
 	OPT_BOOLEAN('\0', "per-event-dump", &script.per_event_dump,
 		    "Dump trace output to files named by the monitored events"),
 	OPT_BOOLEAN('f', "force", &symbol_conf.force, "don't complain, do it"),
-- 
2.20.1

