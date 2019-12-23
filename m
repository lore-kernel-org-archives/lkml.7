Return-Path: <SRS0=RKSG=2N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C83C2D0C0
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 06:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECEBC208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Dec 2019 06:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1577081321;
	bh=YmXCrgCwEwY8/QrWk0sPDC4MZVmbjP+WKJ3cPBUsN08=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=q6hml83wPkjTs+U2ob4lja/sSbPfDgBTO3DTiOstXOu7mmKc2EvFwqj06UIDbE//G
	 Ge0qJovcWWDP9hMFDsGE6BZ3Cxbuq43IstydQxg+sU9pHY4CAMC/rZCtXLggd+efcf
	 1BIbg8Z2Fm8tJgIhm4elObGvrmADhvUdRH8QrakY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbfLWGIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Dec 2019 01:08:39 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:39844 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726826AbfLWGIg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Dec 2019 01:08:36 -0500
Received: by mail-pj1-f67.google.com with SMTP id t101so7013487pjb.4;
        Sun, 22 Dec 2019 22:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0xnigVaaCqW8/KBuzAXnuhlbsCoW2U384fK9hdVaYC0=;
        b=ngvZThXXSJf6z7N4LgY5xftRi5MmZ64sWtiQoBWr64nJbVMqw6h9KlIvgtfnBy4rZh
         T5LmycSdz4/zi/Z4cHg2IvGWhHljeO0h2y8/B99LQOTCrBddhMRqfy/h8dJJrDiOr70S
         joV1327Z4kGYl0ucpjNMwnQL1oD3qoDEGb/9kS2/A7ZlPYqTdHzWHdoWVs+c+65uQwlY
         5D6PBkc0+Tbee+qjc7WT27cml6jWqhqpMeDjLJnemuOGYeX7Cc1bokfhfixlgx2vxyxi
         0Vg8ZsUzU8q6wUdhXG4W9Bbyy0O/8l7JGXZySc8I79O70pOq/L2Rte11AnQe6q3fE4eZ
         abBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=0xnigVaaCqW8/KBuzAXnuhlbsCoW2U384fK9hdVaYC0=;
        b=tFTuYLY5CHtCGmH0rCcJxeftjhK8/bIqpHowAZ9b1zF44/OgMvuak6p9xVzqzJLvhy
         W/y27qnmiwv0kLJT8jcGpl+6nZeRYByajX1SXLMiTIPqtgHwTnMo+xHjPBT+yMGU7Ilk
         nBRGAl7tu84Vd8FsA6XkKePPgjm+6p8HPLaRi3J4mFnT/kFwvZRoAyPu/Niv99op+S3W
         qMol4+w5pfJZhZBdCYGHAoXsjt1OJUJECpbIJCDMog15EE+9kfL3+SrTo6zSMJHRuujs
         eihNnnxDd776VqWBlA9s7nfBEuEq04s6YNN7WeeKVUKZN9i0tPoeNp/EdpS6ZM3v+u4R
         nZzA==
X-Gm-Message-State: APjAAAXZC5JPs9twQ4m+FIHHV8XbX8tYxDa1UaEBjNp1e7SHR3PUjtoh
        APKCwk4ewPHFVL7njTUtD30=
X-Google-Smtp-Source: APXvYqySX+D81sqvnx2YRx4HAYR5b0v2HlJp9aSRAbfEoKsxVl64O+Dy6jg19bm441Fw0yz8gMbAZg==
X-Received: by 2002:a17:902:d705:: with SMTP id w5mr19997106ply.68.1577081315569;
        Sun, 22 Dec 2019 22:08:35 -0800 (PST)
Received: from gaurie.seo.corp.google.com ([2401:fa00:d:1:4eb0:a5ef:3975:7440])
        by smtp.gmail.com with ESMTPSA id p185sm22978212pfg.61.2019.12.22.22.08.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Dec 2019 22:08:34 -0800 (PST)
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
Subject: [PATCH 8/9] perf top: Add --all-cgroups option
Date:   Mon, 23 Dec 2019 15:07:58 +0900
Message-Id: <20191223060759.841176-9-namhyung@kernel.org>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
In-Reply-To: <20191223060759.841176-1-namhyung@kernel.org>
References: <20191223060759.841176-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The --all-cgroups option is to enable cgroup profiling support.  It
tells kernel to record CGROUP events in the ring buffer so that perf
report can identify task/cgroup association later.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/Documentation/perf-top.txt | 4 ++++
 tools/perf/builtin-top.c              | 9 +++++++++
 2 files changed, 13 insertions(+)

diff --git a/tools/perf/Documentation/perf-top.txt b/tools/perf/Documentation/perf-top.txt
index 5596129a71cf..c75507f50071 100644
--- a/tools/perf/Documentation/perf-top.txt
+++ b/tools/perf/Documentation/perf-top.txt
@@ -266,6 +266,10 @@ Default is to monitor all CPUS.
 	Record events of type PERF_RECORD_NAMESPACES and display it with the
 	'cgroup_id' sort key.
 
+--cgroup::
+	Record events of type PERF_RECORD_CGROUP and display it with the
+	'cgroup' sort key.
+
 --switch-on EVENT_NAME::
 	Only consider events after this event is found.
 
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index dc80044bc46f..1aaa1b34feca 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1244,6 +1244,8 @@ static int __cmd_top(struct perf_top *top)
 
 	if (opts->record_namespaces)
 		top->tool.namespace_events = true;
+	if (opts->record_cgroup)
+		top->tool.cgroup_events = true;
 
 	ret = perf_event__synthesize_bpf_events(top->session, perf_event__process,
 						&top->session->machines.host,
@@ -1251,6 +1253,11 @@ static int __cmd_top(struct perf_top *top)
 	if (ret < 0)
 		pr_debug("Couldn't synthesize BPF events: Pre-existing BPF programs won't have symbols resolved.\n");
 
+	ret = perf_event__synthesize_cgroups(&top->tool, perf_event__process,
+					     &top->session->machines.host);
+	if (ret < 0)
+		pr_debug("Couldn't synthesize cgroup events.\n");
+
 	machine__synthesize_threads(&top->session->machines.host, &opts->target,
 				    top->evlist->core.threads, false,
 				    top->nr_threads_synthesize);
@@ -1539,6 +1546,8 @@ int cmd_top(int argc, const char **argv)
 			"number of thread to run event synthesize"),
 	OPT_BOOLEAN(0, "namespaces", &opts->record_namespaces,
 		    "Record namespaces events"),
+	OPT_BOOLEAN(0, "all-cgroups", &opts->record_cgroup,
+		    "Record cgroup events"),
 	OPTS_EVSWITCH(&top.evswitch),
 	OPT_END()
 	};
-- 
2.24.1.735.g03f4e72817-goog

