Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3304C0650F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 17:49:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8787C2171F
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 17:49:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="aJEQo6nY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731730AbfG3Rtm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 13:49:42 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46651 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728318AbfG3Rtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 13:49:42 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6UHnYRV3320016
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Tue, 30 Jul 2019 10:49:34 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6UHnYRV3320016
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1564508975;
        bh=0Mla+09fEL/5fwCwDBzmxe/6IRLmgzWnYdNnIz5mo4U=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=aJEQo6nY9Stx0i3mDbbKd5ifhZ7UsH/lLuPI6QFbZFa0NvOvCZ5ZPok3ugH6b0OOh
         BuIN4QsI7j6YPeDUPj2OXrc8fplmECy9MnTGoy38L+T6Jw+OVKQuwI8Uf9wHkibGGB
         9AuE6euADkAiambNcZifZB8qlzCmRGTlGGHgkjWPygRW0y8fdOqUqak6GNJc+tV52l
         39fSHb0QcuSn/tXAtbKhpfQePwtPE70EKeCSlhJi4tw7JM2kFYUEJopx4UU6jwksxD
         WypmSO38otPgYqkiLPFTaC2CrtA+G/zBuqTzne48/J0d2+YaK9JNK6LnqitCrdJK3g
         TVxM5rubiCmBQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6UHnXbv3320013;
        Tue, 30 Jul 2019 10:49:33 -0700
Date:   Tue, 30 Jul 2019 10:49:33 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-1ibmz7ouv6llqxajy7m8igtd@git.kernel.org>
Cc:     tglx@linutronix.de, adrian.hunter@intel.com, acme@redhat.com,
        mingo@kernel.org, lclaudio@redhat.com, hpa@zytor.com,
        namhyung@kernel.org, jolsa@kernel.org, linux-kernel@vger.kernel.org
Reply-To: linux-kernel@vger.kernel.org, jolsa@kernel.org,
          namhyung@kernel.org, hpa@zytor.com, lclaudio@redhat.com,
          mingo@kernel.org, acme@redhat.com, adrian.hunter@intel.com,
          tglx@linutronix.de
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf trace: Add pointer to BPF object containing
 __augmented_syscalls__
Git-Commit-ID: c8c805707ed4c5d976210821da3242af8610a533
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

Commit-ID:  c8c805707ed4c5d976210821da3242af8610a533
Gitweb:     https://git.kernel.org/tip/c8c805707ed4c5d976210821da3242af8610a533
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 15 Jul 2019 16:58:23 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 29 Jul 2019 18:34:41 -0300

perf trace: Add pointer to BPF object containing __augmented_syscalls__

So that we can use it when looking for other components of that object
file, such as other programs to add to the BPF_MAP_TYPE_PROG_ARRAY and
use with bpf_tail_call().

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-1ibmz7ouv6llqxajy7m8igtd@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 4f0bbffee05f..6aa080845a84 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -96,6 +96,7 @@ struct trace {
 	struct perf_evlist	*evlist;
 	struct machine		*host;
 	struct thread		*current;
+	struct bpf_object	*bpf_obj;
 	struct cgroup		*cgroup;
 	u64			base_time;
 	FILE			*output;
@@ -3895,6 +3896,20 @@ int cmd_trace(int argc, const char **argv)
 
 	if (evsel) {
 		trace.syscalls.events.augmented = evsel;
+
+		evsel = perf_evlist__find_tracepoint_by_name(trace.evlist, "raw_syscalls:sys_enter");
+		if (evsel == NULL) {
+			pr_err("ERROR: raw_syscalls:sys_enter not found in the augmented BPF object\n");
+			goto out;
+		}
+
+		if (evsel->bpf_obj == NULL) {
+			pr_err("ERROR: raw_syscalls:sys_enter not associated to a BPF object\n");
+			goto out;
+		}
+
+		trace.bpf_obj = evsel->bpf_obj;
+
 		trace__set_bpf_map_filtered_pids(&trace);
 		trace__set_bpf_map_syscalls(&trace);
 	}
