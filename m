Return-Path: <SRS0=facv=24=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC0DEC33C9B
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 13:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A4C5E2051A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jan 2020 13:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578404159;
	bh=NA1SRINAE/YAWxAWacuWy+Luf/nRLxR0uO+m6U45Ots=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YovobQeHC5pRjY8+JRQttrh8O8IvVYnC50jamSU1sTylkIEyhN0Q+vqNtSypn4CHK
	 gKdKeox5SuXKghHTeX9Ygrd3y8ixLNqn4P/+6DOXlU0oFG/E6E7Hys1OCBvEuEY3KB
	 Fku+2yK4e74ejG5AabC8J9b5yG2UFwzVTsBCKBtA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728307AbgAGNf6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 08:35:58 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38555 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728291AbgAGNfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 08:35:55 -0500
Received: by mail-pf1-f196.google.com with SMTP id x185so28623001pfc.5;
        Tue, 07 Jan 2020 05:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4wTOIHrS76ztlN3KfH9i8gs4zRLMioZUYiN9KHxWPxk=;
        b=DK1RRGZ6+F0r13BqGpMCz6Pu98WI7dNO5BNklZ3n/ef9iloc10egRlswnm05l8MD35
         QEIwr/Dys/BMPlt1KgsaRS0zrDsJ087JSA47NgMZtKnZumWlF2xR3HvKSI7LJ4WDAv/e
         SA/GauV9G767x7KOB11J47fOfVsG1Ge21oyg3GOwlL3gjDmTHpYyDBUPowXYiyvk03iz
         i3/US3CHYWLXe5VBMsMaU0yeoJgFMGql1Qdu3KU+4Tj9wv8ZO8S0mZBOlyZbhVRiy/eo
         pPQsh4EgaCHWMcGxNJhhJm6lSvN+vmFpXBvfdcWBek5EKC0Je2/MxmAX8WsePzdr4F+T
         anWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=4wTOIHrS76ztlN3KfH9i8gs4zRLMioZUYiN9KHxWPxk=;
        b=nwD0DLLxcYuYeTaR8+dFT9aDdcsRmQj32juct48sDhp+ph4hdJK3RrXr5Sl+/RqeoL
         +UiW6Yx4bghccYWxkkq6mnd4ARfF5iXdIlhKBlyseSb6k23zlVN22vKcAeKpQkQIYZqR
         CKhFpNzu42DsQ3iGNMkIfb3tk0/2AmIIv0VH1qP18ra+WL5yDbz3Yt2ymN0QkG+D0uSc
         NgZvkeQwQQIiGOJyzXHex+xXxsxx2RbKguddzFderfdDwoNmfdQWnOyYRQYHcouMfNU3
         DtS7GT2WhROTv5+lzEnWQugX5jYMPZSx10uJwQQaQ53ifaiA2OH27Zn0Z1K83EBEpNx8
         699A==
X-Gm-Message-State: APjAAAVocQoJU2NOBJ4YegIgWknhmLOKwC2Fg+Eo4u7/0qaa2ZL64Lx6
        C4wbJm4WXfMnTw/ZWRgqLgc=
X-Google-Smtp-Source: APXvYqyb2jTFCiUMcddJ10y9QK5iHNRPF83RuLGqPIdKmroDDQ0SXO/1FWkCY7o165xA6AB8XZZ5jQ==
X-Received: by 2002:aa7:92c2:: with SMTP id k2mr90391734pfa.93.1578404154560;
        Tue, 07 Jan 2020 05:35:54 -0800 (PST)
Received: from gaurie.seo.corp.google.com ([2401:fa00:d:1:4eb0:a5ef:3975:7440])
        by smtp.gmail.com with ESMTPSA id p17sm80358484pfn.31.2020.01.07.05.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 05:35:54 -0800 (PST)
From:   Namhyung Kim <namhyung@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Stephane Eranian <eranian@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 9/9] perf script: Add --show-cgroup-events option
Date:   Tue,  7 Jan 2020 22:35:01 +0900
Message-Id: <20200107133501.327117-10-namhyung@kernel.org>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
In-Reply-To: <20200107133501.327117-1-namhyung@kernel.org>
References: <20200107133501.327117-1-namhyung@kernel.org>
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

