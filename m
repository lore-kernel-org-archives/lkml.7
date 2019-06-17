Return-Path: <SRS0=xALZ=UQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A7DFC31E5B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:20:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E40A12085A
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Jun 2019 19:20:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="DDJgwB3H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbfFQTUZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Jun 2019 15:20:25 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49989 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbfFQTUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jun 2019 15:20:25 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x5HJImg33560134
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 17 Jun 2019 12:18:49 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x5HJImg33560134
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1560799129;
        bh=7wI/ikdKnBYv/SWaRsXMhROK0r1jkKwCAtWKM3yoWLs=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=DDJgwB3HSst3++Q5omiGxrXuk1h9Z+0m/K5oqNwbKQ4s8I5oIoTKvvR5PO9+b6Yc/
         vZrDBm7vhl3Tzg/a2sDYfOONO0i7jvx1R+Z9StMA9a//3xUPWngY6SSUj7KaY8VZ/C
         AC5a9wZjTUaeFyGYkHonu+rNOzDND1OFM9mwxejz5F3sC/2ldDDO1TEE59mmW86dos
         e6WZVhEP7tEWe5jVpH3UQlWVpwM163nzxSgNUNkAqwlqgeqPaOvj0IM74MRwhiK2nx
         LQcEhFBxmA8psuDaGDwyZNuSMiuHrALh24KKDM1PkkKuJJ/laphdPzu28QtQvfqf0p
         xVZkG+BpjERAg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x5HJImaV3560127;
        Mon, 17 Jun 2019 12:18:48 -0700
Date:   Mon, 17 Jun 2019 12:18:48 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for yuzhoujian <tipbot@zytor.com>
Message-ID: <tip-53651b28cfb637ef604abc189d877948d1af39bb@git.kernel.org>
Cc:     peterz@infradead.org, tglx@linutronix.de,
        yuzhoujian@didichuxing.com, adrian.hunter@intel.com,
        dsahern@gmail.com, linux-kernel@vger.kernel.org,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        milian.wolff@kdab.com, jolsa@kernel.org, acme@redhat.com,
        mingo@kernel.org, hpa@zytor.com, wangnan0@huawei.com
Reply-To: yuzhoujian@didichuxing.com, peterz@infradead.org,
          tglx@linutronix.de, dsahern@gmail.com, adrian.hunter@intel.com,
          linux-kernel@vger.kernel.org, alexander.shishkin@linux.intel.com,
          namhyung@kernel.org, milian.wolff@kdab.com, jolsa@kernel.org,
          acme@redhat.com, mingo@kernel.org, hpa@zytor.com,
          wangnan0@huawei.com
In-Reply-To: <1559222962-22891-1-git-send-email-ufo19890607@gmail.com>
References: <1559222962-22891-1-git-send-email-ufo19890607@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf record: Add support to collect callchains from
 kernel or user space only
Git-Commit-ID: 53651b28cfb637ef604abc189d877948d1af39bb
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

Commit-ID:  53651b28cfb637ef604abc189d877948d1af39bb
Gitweb:     https://git.kernel.org/tip/53651b28cfb637ef604abc189d877948d1af39bb
Author:     yuzhoujian <yuzhoujian@didichuxing.com>
AuthorDate: Thu, 30 May 2019 14:29:22 +0100
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Mon, 10 Jun 2019 15:50:01 -0300

perf record: Add support to collect callchains from kernel or user space only

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
