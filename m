Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7C1DC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 07:32:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F35D233A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 07:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566977542;
	bh=mpswMW0aglCPtQUR2ikfSkLwGAcU8bpRJl64Mrvh0jw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UCIj51puDcDm0G7XPkI/2ObYwqKNBltOfDbpumiOaTt2bqXPneiCZGYEVrZzpI+DU
	 3uof+NDAo94LBnaW08x4kRnxGlYFnai26rD0+y7Izzs4k6crwHFJfsThBmhF1aYO1n
	 5x6LjZNTyk2BPvlK3KUYVh7pS6oBUf4b6uwZ5fYs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbfH1HcV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 03:32:21 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:44170 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726820AbfH1HcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 03:32:11 -0400
Received: by mail-pl1-f194.google.com with SMTP id t14so803076plr.11
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 00:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=908RHXqoFIdDyUK9BmX+x3cPuKJ/6DHA6wfIqO4h7YA=;
        b=LHp33Ib2+T38e0IXjQ/JWzQfzu4cT2ZtxVmnuwcL9q5tVuYzQWni9xdV5MqwM6dOf+
         zMsG6qzfi7rQZ+6DMdcWUtjJFnp/CR9IVHDgoeA00k4jYpkSKeAtY3kX6H5Tuz7DEBXO
         G9ks+0/sk9ZqzK7LDSdpVQ/Og+otkQ5lBFpr6N7v9mQAgu9sBFFhjsUKsFJf88uQOHXC
         bDcPcEdDvdy+skzUkqs2uvcmOLRD/xuqsM/DN794ptjx/Bm5VtOx5drMMDgf7FSXSAe5
         4ME88/X3gpKM2yOTvTOZzjKFIPlPy6WlyYK3V0iHlmCSffuBVlDTFjf5LKcOSgX3A9NN
         UaMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=908RHXqoFIdDyUK9BmX+x3cPuKJ/6DHA6wfIqO4h7YA=;
        b=Q3TBBsDz6DO5VVURE0yJTt2+IK/XInS1mWVfeVRYr+E1JWj7n9LptX6RLxZLpgS93K
         l0Zyaa76/z+V+DT85/ANHbFEkaO/eKYzMP9NyzAPAkRr+4gkvqu72/YvFJbqxS46i887
         CpMGIPVplptxy3IDKCRx8xzj0x+iflBCvnbO9aIEGID1EnWGN7WYMFlBsNOFTCYDOqH3
         PVVdF8HLtEOolDkBqXpXQfyEioFvA9/RwIfRftFL6NSPWYp9C1A1yj3DlsPgPdKzyjHc
         BSyyZXPPXTQBxazx577Yv4WBaks2WFdty0IZKSO5zTZ5Aed+h7OApALDex1F5/dPbj9V
         0giw==
X-Gm-Message-State: APjAAAVRAksU0igHFaav8d6Zn1weZkG2ZnuFmV7L7UmB7gfcU0W2YayY
        rWH/txJ7vK9I2jdVlsNVaGo=
X-Google-Smtp-Source: APXvYqypPismMJSUbw7BXBcfjzFmXHqsBc0ww91dPuRmH1z+bOz9fjUlQN4OKJGhnV06etKV6JeEsw==
X-Received: by 2002:a17:902:b406:: with SMTP id x6mr2837482plr.114.1566977530016;
        Wed, 28 Aug 2019 00:32:10 -0700 (PDT)
Received: from gaurie.seo.corp.google.com ([2401:fa00:d:0:1034:ec6b:8056:9e93])
        by smtp.gmail.com with ESMTPSA id v145sm1677054pfc.31.2019.08.28.00.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 00:32:09 -0700 (PDT)
From:   Namhyung Kim <namhyung@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>
Subject: [PATCH 9/9] perf script: Add --show-cgroup-events option
Date:   Wed, 28 Aug 2019 16:31:30 +0900
Message-Id: <20190828073130.83800-10-namhyung@kernel.org>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
In-Reply-To: <20190828073130.83800-1-namhyung@kernel.org>
References: <20190828073130.83800-1-namhyung@kernel.org>
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
index 51e7e6d0eee6..9017889084bd 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -1629,6 +1629,7 @@ struct perf_script {
 	bool			show_lost_events;
 	bool			show_round_events;
 	bool			show_bpf_events;
+	bool			show_cgroup_events;
 	bool			allocated;
 	bool			per_event_dump;
 	struct evswitch		evswitch;
@@ -2146,6 +2147,41 @@ static int process_namespaces_event(struct perf_tool *tool,
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
@@ -2485,6 +2521,8 @@ static int __cmd_script(struct perf_script *script)
 		script->tool.context_switch = process_switch_event;
 	if (script->show_namespace_events)
 		script->tool.namespaces = process_namespaces_event;
+	if (script->show_cgroup_events)
+		script->tool.cgroup = process_cgroup_event;
 	if (script->show_lost_events)
 		script->tool.lost = process_lost_event;
 	if (script->show_round_events) {
@@ -3410,6 +3448,7 @@ int cmd_script(int argc, const char **argv)
 			.mmap2		 = perf_event__process_mmap2,
 			.comm		 = perf_event__process_comm,
 			.namespaces	 = perf_event__process_namespaces,
+			.cgroup		 = perf_event__process_cgroup,
 			.exit		 = perf_event__process_exit,
 			.fork		 = perf_event__process_fork,
 			.attr		 = process_attr,
@@ -3510,6 +3549,8 @@ int cmd_script(int argc, const char **argv)
 		    "Show context switch events (if recorded)"),
 	OPT_BOOLEAN('\0', "show-namespace-events", &script.show_namespace_events,
 		    "Show namespace events (if recorded)"),
+	OPT_BOOLEAN('\0', "show-cgroup-events", &script.show_cgroup_events,
+		    "Show cgroup events (if recorded)"),
 	OPT_BOOLEAN('\0', "show-lost-events", &script.show_lost_events,
 		    "Show lost events (if recorded)"),
 	OPT_BOOLEAN('\0', "show-round-events", &script.show_round_events,
-- 
2.23.0.187.g17f5b7556c-goog

