Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45C9BC2D0C0
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 04:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1475824684
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 04:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576816428;
	bh=NA1SRINAE/YAWxAWacuWy+Luf/nRLxR0uO+m6U45Ots=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kg1nrrHRN4cw8N+awPELKtUaIeVSprV2XeEnCq0FB4vX4pLanXppZTOnsTWXHtKnz
	 NyBsG5SYNbcgP1IYhS0ZfXI8vR1bbeLdc6jpgkZcD+1IVqk+9/glplhfFb/EvcCcFd
	 Z7YaHu6lPW4mrGTUAJiT/lnWdhgyVzoNLadGkX8I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbfLTEdr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 23:33:47 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:38353 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727465AbfLTEdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 23:33:44 -0500
Received: by mail-pf1-f194.google.com with SMTP id x185so4510425pfc.5;
        Thu, 19 Dec 2019 20:33:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4wTOIHrS76ztlN3KfH9i8gs4zRLMioZUYiN9KHxWPxk=;
        b=slnS2jaYUlkQPUZ1q8RoXzN9vubzS0ajaJLZtdJqPURLpgUPOQD9tQRU3qZmUmPEQG
         4Oo3SrRjk00sEiH9u/Fp6xlmODtZVzGMdY9ajg+Jlqu1WiMONjGDy+lbNJAORW/rclV/
         krbFWfoV2KCxWzfE/Ao/a3cHD/0mVvSQ/ymSjx9ATVAoY06nvOKURYuImCaXmhN+ymmO
         XJKvCyWQaJT4KpoI+6cq/NOSQgOLlFJBDHqgahXO7F1Huv2SjDhYtajv2GR2tejMjxCh
         xMSf7+QDbGsa840z4EyPdsgkSQEilnIG0g6FtEE7IzbvgKnjvPGdPoXPnxPZd90lPTzR
         Xwig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=4wTOIHrS76ztlN3KfH9i8gs4zRLMioZUYiN9KHxWPxk=;
        b=MQr8zIpxQEndV65Y4FPjk4ajmXzpYYFfDfOlJjiGTyCyavdYuMacZg2YAHY6fm+jD5
         X90xC00+F+Rj54KQKK/Y8lTTeu6yrHJh6+m67wLIuDqlpl90WoDkmk1ITasGUY3Zjyw4
         zRP/a04MHNRBAE1gJzZs13KSFb5sHOZypzp4QfMKZYsHKNleDIU/e6S4WEYumcttK0al
         goZGGicQeXyrDYDMy8D/d94B0WpMh3GamE1U0BnVmJko5s80YrwZ8EjJUoKZSUB4XwtP
         aUJSjy4WmPMQA0A28mLuY4gJEIdfL8IpNs0smsAUteG1Y7OY3G0JiSVm6X7TKjTltjQA
         BkUw==
X-Gm-Message-State: APjAAAUs01dnMLY6QELZmOOx/FScWUvlIxi7scIPh99SH6bl8aYSYaNT
        cBABrS4f2JUF1fgb1HSlblo=
X-Google-Smtp-Source: APXvYqwM7uK+NhomQyg8Hqxg2IfC/Ynq0E0qc4l8iUDqy6ykn0n3LaDWTLDcrq6wEy9UARJgTvpvQg==
X-Received: by 2002:a63:e17:: with SMTP id d23mr12985131pgl.173.1576816423832;
        Thu, 19 Dec 2019 20:33:43 -0800 (PST)
Received: from gaurie.seo.corp.google.com ([2401:fa00:d:1:4eb0:a5ef:3975:7440])
        by smtp.gmail.com with ESMTPSA id z30sm11013982pfq.154.2019.12.19.20.33.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 20:33:43 -0800 (PST)
From:   Namhyung Kim <namhyung@kernel.org>
To:     Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 9/9] perf script: Add --show-cgroup-events option
Date:   Fri, 20 Dec 2019 13:32:53 +0900
Message-Id: <20191220043253.3278951-10-namhyung@kernel.org>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
In-Reply-To: <20191220043253.3278951-1-namhyung@kernel.org>
References: <20191220043253.3278951-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The --show-cgroup-events option is to print CGROUP events in the
output like others.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-script.txt |  3 ++
 tools/perf/builtin-script.c              | 41 ++++++++++++++++++++++++
 2 files changed, 44 insertions(+)

diff --git a/tools/perf/Documentation/perf-script.txt b/tools/perf/Documentation/perf-script.txt
index 2599b057e47b..3dd297600427 100644
--- a/tools/perf/Documentation/perf-script.txt
+++ b/tools/perf/Documentation/perf-script.txt
@@ -319,6 +319,9 @@ OPTIONS
 --show-bpf-events
 	Display bpf events i.e. events of type PERF_RECORD_KSYMBOL and PERF_RECORD_BPF_EVENT.
 
+--show-cgroup-events
+	Display cgroup events i.e. events of type PERF_RECORD_CGROUP.
+
 --demangle::
 	Demangle symbol names to human readable form. It's enabled by default,
 	disable with --no-demangle.
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index e2406b291c1c..3db4afc29430 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1681,6 +1681,7 @@ struct perf_script {
 	bool			show_lost_events;
 	bool			show_round_events;
 	bool			show_bpf_events;
+	bool			show_cgroup_events;
 	bool			allocated;
 	bool			per_event_dump;
 	struct evswitch		evswitch;
@@ -2199,6 +2200,41 @@ static int process_namespaces_event(struct perf_tool *tool,
 	return ret;
 }
 
+static int process_cgroup_event(struct perf_tool *tool,
+				union perf_event *event,
+				struct perf_sample *sample,
+				struct machine *machine)
+{
+	struct thread *thread;
+	struct perf_script *script = container_of(tool, struct perf_script, tool);
+	struct perf_session *session = script->session;
+	struct evsel *evsel = perf_evlist__id2evsel(session->evlist, sample->id);
+	int ret = -1;
+
+	thread = machine__findnew_thread(machine, sample->pid, sample->tid);
+	if (thread == NULL) {
+		pr_debug("problem processing CGROUP event, skipping it.\n");
+		return -1;
+	}
+
+	if (perf_event__process_cgroup(tool, event, sample, machine) < 0)
+		goto out;
+
+	if (!evsel->core.attr.sample_id_all) {
+		sample->cpu = 0;
+		sample->time = 0;
+	}
+	if (!filter_cpu(sample)) {
+		perf_sample__fprintf_start(sample, thread, evsel,
+					   PERF_RECORD_CGROUP, stdout);
+		perf_event__fprintf(event, stdout);
+	}
+	ret = 0;
+out:
+	thread__put(thread);
+	return ret;
+}
+
 static int process_fork_event(struct perf_tool *tool,
 			      union perf_event *event,
 			      struct perf_sample *sample,
@@ -2538,6 +2574,8 @@ static int __cmd_script(struct perf_script *script)
 		script->tool.context_switch = process_switch_event;
 	if (script->show_namespace_events)
 		script->tool.namespaces = process_namespaces_event;
+	if (script->show_cgroup_events)
+		script->tool.cgroup = process_cgroup_event;
 	if (script->show_lost_events)
 		script->tool.lost = process_lost_event;
 	if (script->show_round_events) {
@@ -3463,6 +3501,7 @@ int cmd_script(int argc, const char **argv)
 			.mmap2		 = perf_event__process_mmap2,
 			.comm		 = perf_event__process_comm,
 			.namespaces	 = perf_event__process_namespaces,
+			.cgroup		 = perf_event__process_cgroup,
 			.exit		 = perf_event__process_exit,
 			.fork		 = perf_event__process_fork,
 			.attr		 = process_attr,
@@ -3563,6 +3602,8 @@ int cmd_script(int argc, const char **argv)
 		    "Show context switch events (if recorded)"),
 	OPT_BOOLEAN('\0', "show-namespace-events", &script.show_namespace_events,
 		    "Show namespace events (if recorded)"),
+	OPT_BOOLEAN('\0', "show-cgroup-events", &script.show_cgroup_events,
+		    "Show cgroup events (if recorded)"),
 	OPT_BOOLEAN('\0', "show-lost-events", &script.show_lost_events,
 		    "Show lost events (if recorded)"),
 	OPT_BOOLEAN('\0', "show-round-events", &script.show_round_events,
-- 
2.24.1.735.g03f4e72817-goog

