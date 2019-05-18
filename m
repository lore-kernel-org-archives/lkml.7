Return-Path: <SRS0=//ty=TS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5793EC04AAF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 08:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29F43206BF
	for <linux-kernel@archiver.kernel.org>; Sat, 18 May 2019 08:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="fJ7jF0qn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729442AbfERIwt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 May 2019 04:52:49 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43975 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726056AbfERIws (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 May 2019 04:52:48 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4I8qXoH1732471
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 18 May 2019 01:52:33 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4I8qXoH1732471
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019041745; t=1558169554;
        bh=DWxHAETxtM8iPG1bUMXxRRL2P1sbeG4KK+Hp4+xPQVA=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=fJ7jF0qnriVvAAe0ezq3A3HqG92kJfJzYCbaCoZxJpSeUm4evnS0ZBs5X19uhOr2F
         fOG6pyUQTFRJEIj9o23I8pkgIs9pOfwQRL8mInUCezc4FgiEVtAilMkZYaZAeNuCed
         cQPBxrrTEkT/hRtlhwuSxok3jlzBlzl/YnRcoRocCNWs15KXxz+Vp7WDtU5dG5pCAC
         LHmJi97rs/4725xxxeWsUNIZy1nXkwrcWhCHYVLGNkj/XjGKRUCu+Kav8Xl88wOiz9
         lmo+95iKmR4JlZgksdNZdT8Rju6Smm7HKZMbeAdxXn6zGeu0+YLY+H968C06Usof2z
         sRI28d9wAzflQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4I8qWhY1732465;
        Sat, 18 May 2019 01:52:32 -0700
Date:   Sat, 18 May 2019 01:52:32 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-r0xhfhy5radmkhhcbcfs5izf@git.kernel.org>
Cc:     tglx@linutronix.de, acme@redhat.com, adrian.hunter@intel.com,
        hpa@zytor.com, jolsa@kernel.org, eranian@google.com,
        mingo@kernel.org, ak@linux.intel.com, peterz@infradead.org,
        kan.liang@linux.intel.com, alexander.shishkin@linux.intel.com,
        linux-kernel@vger.kernel.org, namhyung@kernel.org
Reply-To: acme@redhat.com, tglx@linutronix.de, jolsa@kernel.org,
          adrian.hunter@intel.com, hpa@zytor.com, eranian@google.com,
          mingo@kernel.org, ak@linux.intel.com, peterz@infradead.org,
          kan.liang@linux.intel.com, alexander.shishkin@linux.intel.com,
          namhyung@kernel.org, linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf record: Fix suggestion to get list of
 registers usable with --user-regs and --intr-regs
Git-Commit-ID: 8e5bc76f2ce39ffd48350d6dd9318d78d07b0bfa
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

Commit-ID:  8e5bc76f2ce39ffd48350d6dd9318d78d07b0bfa
Gitweb:     https://git.kernel.org/tip/8e5bc76f2ce39ffd48350d6dd9318d78d07b0bfa
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Mon, 13 May 2019 15:55:01 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 15 May 2019 16:36:46 -0300

perf record: Fix suggestion to get list of registers usable with --user-regs and --intr-regs

  $ perf record -h -I

   Usage: perf record [<options>] [<command>]
      or: perf record [<options>] -- <command> [<options>]

      -I, --intr-regs[=<any register>]
                            sample selected machine registers on interrupt, use -I ? to list register names

  $ m
  $ perf record -I ?
  Workload failed: No such file or directory
  $

  After:

  $ perf record -h -I

   Usage: perf record [<options>] [<command>]
      or: perf record [<options>] -- <command> [<options>]

      -I, --intr-regs[=<any register>]
                            sample selected machine registers on interrupt, use '-I?' to list register names

  $
  $ perf record -I?
  available registers: AX BX CX DX SI DI BP SP IP FLAGS CS SS R8 R9 R10 R11 R12 R13 R14 R15

   Usage: perf record [<options>] [<command>]
      or: perf record [<options>] -- <command> [<options>]

      -I, --intr-regs[=<any register>]
                            sample selected machine registers on interrupt, use '-I?' to list register names
  $

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Fixes: bcc84ec65ad1 ("perf record: Add ability to name registers to record")
Link: https://lkml.kernel.org/n/tip-r0xhfhy5radmkhhcbcfs5izf@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-record.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index c5e10552776a..d2b5a22b7249 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -2017,10 +2017,10 @@ static struct option __record_options[] = {
 		    "use per-thread mmaps"),
 	OPT_CALLBACK_OPTARG('I', "intr-regs", &record.opts.sample_intr_regs, NULL, "any register",
 		    "sample selected machine registers on interrupt,"
-		    " use -I ? to list register names", parse_regs),
+		    " use '-I?' to list register names", parse_regs),
 	OPT_CALLBACK_OPTARG(0, "user-regs", &record.opts.sample_user_regs, NULL, "any register",
 		    "sample selected machine registers on interrupt,"
-		    " use -I ? to list register names", parse_regs),
+		    " use '-I?' to list register names", parse_regs),
 	OPT_BOOLEAN(0, "running-time", &record.opts.running_time,
 		    "Record running/enabled time of read (:S) events"),
 	OPT_CALLBACK('k', "clockid", &record.opts,
