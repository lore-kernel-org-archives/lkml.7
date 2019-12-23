Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82492C2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 06:08:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58951208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 06:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577081324;
	bh=NA1SRINAE/YAWxAWacuWy+Luf/nRLxR0uO+m6U45Ots=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qj+5Hfs7cXSaqva/qd6CIXQjWXYcoET4pFf1x6zueXVbmGvzoRpJc47w+ud5FYMpn
	 +3B+aLmBSPIi7Y7tKaBTl8fft3biy21/4ASnh3rn8wZprND4P9TjGHx6E4ujyhqLbt
	 DzbFf/tOvF0HPSUTynCMSfpJz9OoyCwMihTYsDLg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726933AbfLWGIn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 01:08:43 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:34375 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726897AbfLWGIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 01:08:39 -0500
Received: by mail-pg1-f194.google.com with SMTP id r11so8300649pgf.1;
        Sun, 22 Dec 2019 22:08:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4wTOIHrS76ztlN3KfH9i8gs4zRLMioZUYiN9KHxWPxk=;
        b=VRhfFQGNlPaf7r6rXbjt5CkZzqAuOvKRCJKHlgWpRUHKGzk5dh5+ZiGXV9AjH6Ktgx
         JQHfRpHRwZzWlbzg2M/5Z08CK5LqjpBMJlCfNBfhyahhvXm6bOp89zhLsmreVjJ5pJEa
         LjIwMJM7ZnjEJE9HK2kX+obOvxDeEz9MFHur2g6/fYQWsyoPF9QI+dPGLyBWxpgDSYCo
         g/NfdKS35ovMWhR6vRPteKM6Q/V/dXOvIJ07bBOFLYr2E/mgjvYHbCLNTx08hD4HnrJf
         yyO/I9gVHyqCL5646/aCQvmK2aK/2XGDj0xy02381e73tzig1wZSDWG28MyyOJiL+hly
         jNng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=4wTOIHrS76ztlN3KfH9i8gs4zRLMioZUYiN9KHxWPxk=;
        b=CYqFTKf/pXYnJH4WsUY1bna73DZIlNb9fxnI8TaWJwVWfsFH4kiQ+izFZXtTB8rgak
         3Wr2R5o5clD+cHuc8Rx5hlaqQqh48YGwg2CPJN5IS5GOwC1MILueq4rdYvIC1/SXYGsI
         mBhtU6S1zD8UB2nFoN0ZB6QR0mCjZhK3T4FH4TzMV0UFZ+6rFMSgdj+uKxQ9uZUjy9vL
         hbFErYATTkr1bmizB98aVakDwOwpCtDkiodl6NlChMesPFLp+ZXC7NibNG6zVbv1+nLl
         0SXf8U4VUVGscvWxr2D/bYBxMw5oJqNh205pEL6tg7WG+YloR2hYbK3DXzz8SJd29NTH
         LPlg==
X-Gm-Message-State: APjAAAXXa6ZNNxeYNnLVcIIX/oEDcIvmFN2IEBsv2gMaRW1mynE3fXeb
        jSIeyowbauQjqyH0WLSV2v4=
X-Google-Smtp-Source: APXvYqzTdmWuH+bETIdcdf3sETXajF999GYY/DzAp4mb7X2f/E/a1ZHQ2V1wd9zju5+LnPbKyEX2/A==
X-Received: by 2002:aa7:9aa5:: with SMTP id x5mr30998929pfi.131.1577081318540;
        Sun, 22 Dec 2019 22:08:38 -0800 (PST)
Received: from gaurie.seo.corp.google.com ([2401:fa00:d:1:4eb0:a5ef:3975:7440])
        by smtp.gmail.com with ESMTPSA id p185sm22978212pfg.61.2019.12.22.22.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Dec 2019 22:08:38 -0800 (PST)
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
Date:   Mon, 23 Dec 2019 15:07:59 +0900
Message-Id: <20191223060759.841176-10-namhyung@kernel.org>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
In-Reply-To: <20191223060759.841176-1-namhyung@kernel.org>
References: <20191223060759.841176-1-namhyung@kernel.org>
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

