Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD318C76186
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 02:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3CFA206DD
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 02:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564455402;
	bh=o2pJ2ql3GLs7R4yNfRt5r6LWFacFDDhF+mVB6InfhUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=x/86S7dITwBWXD7kq52xQWrFVVTtkPJFf8pzCO1G1e+vStBgsFb1Ro8mU2l/foJX0
	 JuaFKufMHlbO+AqcLhVto9axJaNVgl/sW+fByN56lwdpqNn2iUq1xUOnA94OQC/cBt
	 rAy+dF/QqT76MmO9z+iWNT6G4b6vLqv+SNWZq+ZE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731589AbfG3C4l (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 22:56:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:46236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731536AbfG3C4f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 22:56:35 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF249206DD;
        Tue, 30 Jul 2019 02:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564455395;
        bh=o2pJ2ql3GLs7R4yNfRt5r6LWFacFDDhF+mVB6InfhUM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BNzZGxx1hoUgESSQI44EioEb+JyP0E/qCs29C/35gu5eNL28Wsg9DoFZAIJAU8dXS
         33yFBvV2qmFjNnJIAqMsGcSn8daKnPMcWEUETGB9C/nuzjNGBUBzKSfS2o4HfEWXvF
         V3tyblRcElYfF4NNWQjt+77VA5wZq1Stp/i9F9t0=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Brendan Gregg <brendan.d.gregg@gmail.com>,
        =?UTF-8?q?Luis=20Cl=C3=A1udio=20Gon=C3=A7alves?= 
        <lclaudio@redhat.com>
Subject: [PATCH 005/107] perf trace: Look up maps just on the __augmented_syscalls__ BPF object
Date:   Mon, 29 Jul 2019 23:54:28 -0300
Message-Id: <20190730025610.22603-6-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190730025610.22603-1-acme@kernel.org>
References: <20190730025610.22603-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

We can conceivably have multiple BPF object files for other purposes, so
better look just on the BPF object containing the __augmented_syscalls__
map for all things augmented_syscalls related.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Brendan Gregg <brendan.d.gregg@gmail.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-3jt8knkuae9lt705r1lns202@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 6aa080845a84..bfd739a321d1 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3669,28 +3669,22 @@ static int trace__parse_cgroups(const struct option *opt, const char *str, int u
 	return 0;
 }
 
-static struct bpf_map *bpf__find_map_by_name(const char *name)
+static struct bpf_map *trace__find_bpf_map_by_name(struct trace *trace, const char *name)
 {
-	struct bpf_object *obj, *tmp;
-
-	bpf_object__for_each_safe(obj, tmp) {
-		struct bpf_map *map = bpf_object__find_map_by_name(obj, name);
-		if (map)
-			return map;
-
-	}
+	if (trace->bpf_obj == NULL)
+		return NULL;
 
-	return NULL;
+	return bpf_object__find_map_by_name(trace->bpf_obj, name);
 }
 
 static void trace__set_bpf_map_filtered_pids(struct trace *trace)
 {
-	trace->filter_pids.map = bpf__find_map_by_name("pids_filtered");
+	trace->filter_pids.map = trace__find_bpf_map_by_name(trace, "pids_filtered");
 }
 
 static void trace__set_bpf_map_syscalls(struct trace *trace)
 {
-	trace->syscalls.map = bpf__find_map_by_name("syscalls");
+	trace->syscalls.map = trace__find_bpf_map_by_name(trace, "syscalls");
 }
 
 static int trace__config(const char *var, const char *value, void *arg)
@@ -3924,7 +3918,7 @@ int cmd_trace(int argc, const char **argv)
 	err = -1;
 
 	if (map_dump_str) {
-		trace.dump.map = bpf__find_map_by_name(map_dump_str);
+		trace.dump.map = trace__find_bpf_map_by_name(&trace, map_dump_str);
 		if (trace.dump.map == NULL) {
 			pr_err("ERROR: BPF map \"%s\" not found\n", map_dump_str);
 			goto out;
-- 
2.21.0

