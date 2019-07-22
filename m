Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46D0EC7618F
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1D58221901
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 17:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563817172;
	bh=o2pJ2ql3GLs7R4yNfRt5r6LWFacFDDhF+mVB6InfhUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=JlP2/ssiadlbvVYA5m+TpwdKdJL6Cv8RkZfTJjHGBaeFKEojHCN4l/jeBL9OuG+Hk
	 C4bx9IKt+T8RSDX1QTph2qu0dl3W0xO8ui7UsTW/DOJFI0px68RzAWLkhRMhSK/nha
	 vbREseYAxVoNqfA1xhE3XX7fwD7WKyOF+3EUJBxY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729474AbfGVRja (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 13:39:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:45666 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728551AbfGVRj2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 13:39:28 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 275E721903;
        Mon, 22 Jul 2019 17:39:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563817168;
        bh=o2pJ2ql3GLs7R4yNfRt5r6LWFacFDDhF+mVB6InfhUM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FYMKjbr2c+td3rSRKaOihvGxvv4mbQAc+8nYU1X8ulgY/d5eaH4YxhZfguqorI0Km
         9HOjfJmYfo481ZSWG5x6oqA6GxPc8RceRyHJNGNxyzuaGid8dkxwhGPgiNGZ+egzF1
         XdUziJJaYDv5kwRbF8J4AtlmS9rn4cVaSr7hu6f0=
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
Subject: [PATCH 05/37] perf trace: Look up maps just on the __augmented_syscalls__ BPF object
Date:   Mon, 22 Jul 2019 14:38:07 -0300
Message-Id: <20190722173839.22898-6-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190722173839.22898-1-acme@kernel.org>
References: <20190722173839.22898-1-acme@kernel.org>
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

