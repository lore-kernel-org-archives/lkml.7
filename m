Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 238BFC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 07:32:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF03E2339E
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 07:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566977537;
	bh=E+F9n1syQhuZ6qIp/cX7DwFmea596WfShoJ5d/M0m0U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SOMit+NZHf+wLX+t8PgDnN/hLJkOI/Ib0PRr1DdJffdYRkcHspspygCsggXwu2pja
	 CrvmYhVIx9AZ8jxmakpkcxIefCTfYDp5WQcGFNTVAXqXNJ4vSYbmztKOGEitQ0pXOd
	 GAQXnCZoAxQTkW3JpNa9dYaT8LTkPdl9wYZlV/ns=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbfH1HcQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 03:32:16 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33034 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726787AbfH1HcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 03:32:08 -0400
Received: by mail-pl1-f194.google.com with SMTP id go14so829156plb.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 00:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FeXB35pth7EIpVyjFwmwkZef0YndbpA01R3AGIkaTh0=;
        b=gr/yqJSzBHucNCxHepu8Kao+CyxyV40CqTuZQrLj3Pjap/nD0/OcrlEaM+GE1lS41S
         yLk5eYcX5Pvkfq7sOOeuRIIETTI/IdOgMqOH+IXmHzFVsLpoHMj8b1fIe1WCwq3fzNRH
         i1Xlpdv5cWgjMzmI9a5Jy/ZwM2eu9wfQsFl8vUerG6z/oBWoHn7zh+ejEDJF9q+/Ny1l
         4FtLvzX0gmEVfMtKzmUVmEdFN+LBWfyf+Gzwi+QcBh9aey7j8tlXmScfZqG9qh2AHtNt
         cavXNw0lLMVY76FqianAVv+zzA2FgngkbCSTG9tD61OPva6fMjlu6aV5MnZk+4yhHniV
         ss9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=FeXB35pth7EIpVyjFwmwkZef0YndbpA01R3AGIkaTh0=;
        b=jeotB6cNC7GELWFBrtLihGWITEbEe5bNLhTFA8ioChHZ6ibvMACRwgvEfS0bofPCnd
         dazYXjqjlNGWUCyFbbqC1P+FZuSbFVofEwFYMDsuDWi9wfXp8lBNBQaHUvtnuDKDOh0B
         tFJhU3RkvJUcC7O2VgRJQsedj560dkBKIZHQNcZmMXY5uYlxJiRMKeKYYRqYJcMPJ/ln
         EFJ37/9UTQpwNLbH61IR0Gz5BgpAqCSaoFt6e5LzauX04l1ZTu4K2DXoi8B3iu4t+14q
         nVFLae/zjL4GFiTbezfVeK18pw7HS7mjYXBf40ooWtVpxc3LjzXwy8UpiAH9pOofJwWX
         H9rA==
X-Gm-Message-State: APjAAAVqajh5gaZ5FM3s5se3TnEGyIJVHNSp8BED2NDKVGhEIlvpmmil
        CZvVf1wNLq9P7W1gJMCvjJQ=
X-Google-Smtp-Source: APXvYqyrAxpbm5OpL5goKbaCJb2pEgObzDsuKsHlTNX/f3uoCEBqgKpc6ViJuJ9fUZ1fKu7zXgYcVA==
X-Received: by 2002:a17:902:e613:: with SMTP id cm19mr2709646plb.299.1566977527428;
        Wed, 28 Aug 2019 00:32:07 -0700 (PDT)
Received: from gaurie.seo.corp.google.com ([2401:fa00:d:0:1034:ec6b:8056:9e93])
        by smtp.gmail.com with ESMTPSA id v145sm1677054pfc.31.2019.08.28.00.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 00:32:06 -0700 (PDT)
From:   Namhyung Kim <namhyung@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Stephane Eranian <eranian@google.com>
Subject: [PATCH 8/9] perf top: Add --all-cgroups option
Date:   Wed, 28 Aug 2019 16:31:29 +0900
Message-Id: <20190828073130.83800-9-namhyung@kernel.org>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
In-Reply-To: <20190828073130.83800-1-namhyung@kernel.org>
References: <20190828073130.83800-1-namhyung@kernel.org>
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
index 5970723cd55a..f07b43c12461 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1242,6 +1242,8 @@ static int __cmd_top(struct perf_top *top)
 
 	if (opts->record_namespaces)
 		top->tool.namespace_events = true;
+	if (opts->record_cgroup)
+		top->tool.cgroup_events = true;
 
 	ret = perf_event__synthesize_bpf_events(top->session, perf_event__process,
 						&top->session->machines.host,
@@ -1249,6 +1251,11 @@ static int __cmd_top(struct perf_top *top)
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
@@ -1537,6 +1544,8 @@ int cmd_top(int argc, const char **argv)
 			"number of thread to run event synthesize"),
 	OPT_BOOLEAN(0, "namespaces", &opts->record_namespaces,
 		    "Record namespaces events"),
+	OPT_BOOLEAN(0, "all-cgroups", &opts->record_cgroup,
+		    "Record cgroup events"),
 	OPTS_EVSWITCH(&top.evswitch),
 	OPT_END()
 	};
-- 
2.23.0.187.g17f5b7556c-goog

