Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C97C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:02:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7666C21872
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560279723;
	bh=JBnxFPe/t0YCFBRyVsZMvVvtGqq59d1RHZxU94+tnmI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jcC8wOk4rwaOWmGhduXcecZlsmxoD+slqsmV4TEBdP3XGbBVyJpEuxsr27LqC3doO
	 GEkeWqlbWy+nVYukgCRmN5cbj8VeqetsidQyUHVYcPAkfEtsTuzzZGG6gR7xBZJoq3
	 WHhMxGIsVuJ2+2wpLYkpfAbCf+M/qu24ts62Z8vs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392327AbfFKTCC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 15:02:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:38188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391025AbfFKTCB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 15:02:01 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 972A52184C;
        Tue, 11 Jun 2019 19:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560279720;
        bh=JBnxFPe/t0YCFBRyVsZMvVvtGqq59d1RHZxU94+tnmI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a4Xs0dGsjNrrGIRU1kCE4IXe44gQFR5IPTDmEqJbuipYSMclm0ZpIQY0FdM/1bwgE
         NZXAkxgeofP4UwUEzy9UB5E5SjYcHcohTWUwH0aOi5HagwGDbxO6BWk3cBdHswnDWB
         meRokaHpapjCzpOMzyw6RJe1dBkaNdeq/P87a/4E=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        yuzhoujian <yuzhoujian@didichuxing.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        David Ahern <dsahern@gmail.com>,
        Milian Wolff <milian.wolff@kdab.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Wang Nan <wangnan0@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 35/85] perf record: Add support to collect callchains from kernel or user space only
Date:   Tue, 11 Jun 2019 15:58:21 -0300
Message-Id: <20190611185911.11645-36-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190611185911.11645-1-acme@kernel.org>
References: <20190611185911.11645-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: yuzhoujian <yuzhoujian@didichuxing.com>

One can just record callchains in the kernel or user space with this new
options.

We can use it together with "--all-kernel" options.

This two options is used just like print_stack(sys) or print_ustack(usr)
for systemtap.

Shown below is the usage of this new option combined with "--all-kernel"
options:

1. Configure all used events to run in kernel space and just collect
   kernel callchains.

  $ perf record -a -g --all-kernel --kernel-callchains

2. Configure all used events to run in kernel space and just collect
   user callchains.

  $ perf record -a -g --all-kernel --user-callchains

Committer notes:

Improved documentation to state that asking for kernel callchains really
is asking for excluding user callchains, and vice versa.

Further mentioned that using both won't get both, but nothing, as both
will be excluded.

Signed-off-by: yuzhoujian <yuzhoujian@didichuxing.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Milian Wolff <milian.wolff@kdab.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lkml.kernel.org/r/1559222962-22891-1-git-send-email-ufo19890607@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/perf-record.txt | 11 +++++++++++
 tools/perf/builtin-record.c              |  4 ++++
 tools/perf/perf.h                        |  2 ++
 tools/perf/util/evsel.c                  |  4 ++++
 4 files changed, 21 insertions(+)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index de269430720a..15e0fa87241b 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -490,6 +490,17 @@ Configure all used events to run in kernel space.
 --all-user::
 Configure all used events to run in user space.
 
+--kernel-callchains::
+Collect callchains only from kernel space. I.e. this option sets
+perf_event_attr.exclude_callchain_user to 1.
+
+--user-callchains::
+Collect callchains only from user space. I.e. this option sets
+perf_event_attr.exclude_callchain_kernel to 1.
+
+Don't use both --kernel-callchains and --user-callchains at the same time or no
+callchains will be collected.
+
 --timestamp-filename
 Append timestamp to output file name.
 
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index e2c3a585a61e..dca55997934e 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -2191,6 +2191,10 @@ static struct option __record_options[] = {
 	OPT_BOOLEAN_FLAG(0, "all-user", &record.opts.all_user,
 			 "Configure all used events to run in user space.",
 			 PARSE_OPT_EXCLUSIVE),
+	OPT_BOOLEAN(0, "kernel-callchains", &record.opts.kernel_callchains,
+		    "collect kernel callchains"),
+	OPT_BOOLEAN(0, "user-callchains", &record.opts.user_callchains,
+		    "collect user callchains"),
 	OPT_STRING(0, "clang-path", &llvm_param.clang_path, "clang path",
 		   "clang binary to use for compiling BPF scriptlets"),
 	OPT_STRING(0, "clang-opt", &llvm_param.clang_opt, "clang options",
diff --git a/tools/perf/perf.h b/tools/perf/perf.h
index d59dee61b64d..711e009381ec 100644
--- a/tools/perf/perf.h
+++ b/tools/perf/perf.h
@@ -61,6 +61,8 @@ struct record_opts {
 	bool	     record_switch_events;
 	bool	     all_kernel;
 	bool	     all_user;
+	bool	     kernel_callchains;
+	bool	     user_callchains;
 	bool	     tail_synthesize;
 	bool	     overwrite;
 	bool	     ignore_missing_thread;
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index cc6e7a0dda92..9f3b58071863 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -680,6 +680,10 @@ static void __perf_evsel__config_callchain(struct perf_evsel *evsel,
 
 	attr->sample_max_stack = param->max_stack;
 
+	if (opts->kernel_callchains)
+		attr->exclude_callchain_user = 1;
+	if (opts->user_callchains)
+		attr->exclude_callchain_kernel = 1;
 	if (param->record_mode == CALLCHAIN_LBR) {
 		if (!opts->branch_stack) {
 			if (attr->exclude_user) {
-- 
2.20.1

