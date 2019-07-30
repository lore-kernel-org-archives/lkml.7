Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E46C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 17:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E04302171F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 17:50:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="wE6CzO4e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731762AbfG3Ru2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 13:50:28 -0400
Received: from terminus.zytor.com ([198.137.202.136]:47251 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfG3Ru2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 13:50:28 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UHoKuu3320139
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 10:50:20 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UHoKuu3320139
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564509021;
        bh=shQOmNKW7WapmOpUCUbPQ7bkYTjmXjgSvFU/G4Qdiqo=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=wE6CzO4euE0LWYkcoIJXXdfC/b3wGTiJ7960bwzchRt4aXTDIZh4GcHJv1rJksyqb
         Ga1wnx2dR+kmQhxFjHz4whqYrKbzeGX889H6ZJov6/ZjgGgCAqu/3mLs9TvEmsr76T
         Tv07AcXD2SWRknYyryLJTk/G4KxxI63P4VVoJqhgaGqG83JAXPXUOswiuEuKbqBtwT
         B2qT25aDhQYkeR1CENtzSZYisMThufSjOY3PIoF5rc39/uRnI8t0tTuDqgR6il53N2
         nxc5ZKQWxkbwLtPDFMMf6afjN4AsnbPijTv9C4ZCPDQ+FOeYkrMcf5aGBvCPRKQfcG
         DlKOGCPHTdubg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UHoJWx3320133;
        Tue, 30 Jul 2019 10:50:19 -0700
Date:   Tue, 30 Jul 2019 10:50:19 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-3jt8knkuae9lt705r1lns202@git.kernel.org>
Cc:     tglx@linutronix.de, mingo@kernel.org, brendan.d.gregg@gmail.com,
        acme@redhat.com, jolsa@kernel.org, hpa@zytor.com,
        namhyung@kernel.org, lclaudio@redhat.com, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org
Reply-To: brendan.d.gregg@gmail.com, tglx@linutronix.de, mingo@kernel.org,
          linux-kernel@vger.kernel.org, namhyung@kernel.org,
          lclaudio@redhat.com, adrian.hunter@intel.com, jolsa@kernel.org,
          acme@redhat.com, hpa@zytor.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace: Look up maps just on the
 __augmented_syscalls__ BPF object
Git-Commit-ID: 5ca0b7f5004a5f1a35c1cb47894790ad98e34ed1
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

Commit-ID:  5ca0b7f5004a5f1a35c1cb47894790ad98e34ed1
Gitweb:     https://git.kernel.org/tip/5ca0b7f5004a5f1a35c1cb47894790ad98e34ed1
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 15 Jul 2019 17:03:10 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 18:34:41 -0300

perf trace: Look up maps just on the __augmented_syscalls__ BPF object

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
