Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C0A2C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 08:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FDAC218E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 08:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ltr3YEqu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbfCPIHp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 04:07:45 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41087 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726099AbfCPIHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 04:07:42 -0400
Received: by mail-pg1-f195.google.com with SMTP id k11so8000134pgb.8;
        Sat, 16 Mar 2019 01:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5EzK4LKKwccTvOLxoyZof2NFG0BikWOy/V1kU66U++U=;
        b=Ltr3YEquGxDqrP1xQoTaF+iHmOWssG2wCscXaIMUzKMLg1H5qJkk6lKokTmJ3tPLkB
         Wj3QievKtS6s5m03kFR9B5bmOPSc/dIusskzxgiCB1t3QLCxfmpImSStdKnCsTF2us93
         c3+8nObdOp8JwnU7QmEh0eNDK1b1eYK7PUZMPPqNqwb55z0C9aoM24Cln4D+UI1lmgiN
         dBl1+Hdsfo8QQXQqp8eXBZfTTSZ+yRUxiK1+8L9DFSJv42T9gt/oSzeRjvboWskl4ib4
         p7c2X8hq4nfS2KSkiY0y3gwm5mcTHWtmrxMrTyxPT2vBV5TtsoUvrZ8L/IXtAoMmH0F2
         XGOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5EzK4LKKwccTvOLxoyZof2NFG0BikWOy/V1kU66U++U=;
        b=uGCxZqGplUq1RExne0fkEmszzhUm29BK2itG62pQfm3na+NC1/Sdt5BzS6u/eavmzf
         Qb0xAZcIfWJAZVb2xHTtz3NDDOsCf4t+ayhFTwX8bnmNgqrPln8Cj5b4cK2+nAPFQMMC
         0IDj8f/jJEAbjv+pyb+OC+007vRsobvANJ9yQfbwANCIvMgEVBrQjiafIZ9lo+ePmnsc
         6wOLAc0HjJ61aPHJFEmNs1OdpuVrXZqtPjvQwtAPbuRDACkSzakmllFP9EpHWyLblNN5
         wkiPTwt6V79H6fzuhc8hDoArKwn2sAhx6CET/16dM+0hvQVMGz/KPfh7/Gs3j0tss6/h
         pTFA==
X-Gm-Message-State: APjAAAUoZYXF2BDmvf6oowK2i+dfw561cK9hoUPRnQ7lFx+Jr4y3TQ1h
        aPNasziyKrJ22QjsHQSHYmo=
X-Google-Smtp-Source: APXvYqw7VdmGv3UFGOFrubL8X09kTi6kttLLt38YYZjzD0L2euiPfqqhyNLON2MuLGgsMsuvBZtShg==
X-Received: by 2002:a65:48c1:: with SMTP id o1mr7269303pgs.94.1552723661940;
        Sat, 16 Mar 2019 01:07:41 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id y14sm10690975pgs.47.2019.03.16.01.07.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Mar 2019 01:07:41 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     namhyung@kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>, rostedt@goodmis.org,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 13/16] perf: free all counts in perf_evsel__exit
Date:   Sat, 16 Mar 2019 16:05:53 +0800
Message-Id: <20190316080556.3075-14-changbin.du@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190316080556.3075-1-changbin.du@gmail.com>
References: <20190316080556.3075-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure that we have freed all allocated counts for struct perf_evsel.

=================================================================
==7494==ERROR: LeakSanitizer: detected memory leaks

Direct leak of 48 byte(s) in 1 object(s) allocated from:
    #0 0x7f0333a89138 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xee138)
    #1 0x5625e5330a5e in zalloc util/util.h:23
    #2 0x5625e5330a9b in perf_counts__new util/counts.c:10
    #3 0x5625e5330ca0 in perf_evsel__alloc_counts util/counts.c:47
    #4 0x5625e520d8e5 in __perf_evsel__read_on_cpu util/evsel.c:1505
    #5 0x5625e517a985 in perf_evsel__read_on_cpu /home/work/linux/tools/perf/util/evsel.h:347
    #6 0x5625e517ad1a in test__openat_syscall_event tests/openat-syscall.c:47
    #7 0x5625e51528e6 in run_test tests/builtin-test.c:358
    #8 0x5625e5152baf in test_and_print tests/builtin-test.c:388
    #9 0x5625e51543fe in __cmd_test tests/builtin-test.c:583
    #10 0x5625e515572f in cmd_test tests/builtin-test.c:722
    #11 0x5625e51c3fb8 in run_builtin /home/changbin/work/linux/tools/perf/perf.c:302
    #12 0x5625e51c44f7 in handle_internal_command /home/changbin/work/linux/tools/perf/perf.c:354
    #13 0x5625e51c48fb in run_argv /home/changbin/work/linux/tools/perf/perf.c:398
    #14 0x5625e51c5069 in main /home/changbin/work/linux/tools/perf/perf.c:520
    #15 0x7f033214d09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x2409a)

Indirect leak of 72 byte(s) in 1 object(s) allocated from:
    #0 0x7f0333a89138 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xee138)
    #1 0x5625e532560d in zalloc util/util.h:23
    #2 0x5625e532566b in xyarray__new util/xyarray.c:10
    #3 0x5625e5330aba in perf_counts__new util/counts.c:15
    #4 0x5625e5330ca0 in perf_evsel__alloc_counts util/counts.c:47
    #5 0x5625e520d8e5 in __perf_evsel__read_on_cpu util/evsel.c:1505
    #6 0x5625e517a985 in perf_evsel__read_on_cpu /home/work/linux/tools/perf/util/evsel.h:347
    #7 0x5625e517ad1a in test__openat_syscall_event tests/openat-syscall.c:47
    #8 0x5625e51528e6 in run_test tests/builtin-test.c:358
    #9 0x5625e5152baf in test_and_print tests/builtin-test.c:388
    #10 0x5625e51543fe in __cmd_test tests/builtin-test.c:583
    #11 0x5625e515572f in cmd_test tests/builtin-test.c:722
    #12 0x5625e51c3fb8 in run_builtin /home/changbin/work/linux/tools/perf/perf.c:302
    #13 0x5625e51c44f7 in handle_internal_command /home/changbin/work/linux/tools/perf/perf.c:354
    #14 0x5625e51c48fb in run_argv /home/changbin/work/linux/tools/perf/perf.c:398
    #15 0x5625e51c5069 in main /home/changbin/work/linux/tools/perf/perf.c:520
    #16 0x7f033214d09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x2409a)

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 tools/perf/util/counts.c | 18 ++++++++++++++++++
 tools/perf/util/counts.h |  4 ++++
 tools/perf/util/evsel.c  |  2 ++
 tools/perf/util/stat.c   | 18 ------------------
 4 files changed, 24 insertions(+), 18 deletions(-)

diff --git a/tools/perf/util/counts.c b/tools/perf/util/counts.c
index 03032b410c29..c5715d08b1f9 100644
--- a/tools/perf/util/counts.c
+++ b/tools/perf/util/counts.c
@@ -53,3 +53,21 @@ void perf_evsel__free_counts(struct perf_evsel *evsel)
 	perf_counts__delete(evsel->counts);
 	evsel->counts = NULL;
 }
+
+int perf_evsel__alloc_prev_raw_counts(struct perf_evsel *evsel,
+				      int ncpus, int nthreads)
+{
+	struct perf_counts *counts;
+
+	counts = perf_counts__new(ncpus, nthreads);
+	if (counts)
+		evsel->prev_raw_counts = counts;
+
+	return counts ? 0 : -ENOMEM;
+}
+
+void perf_evsel__free_prev_raw_counts(struct perf_evsel *evsel)
+{
+	perf_counts__delete(evsel->prev_raw_counts);
+	evsel->prev_raw_counts = NULL;
+}
diff --git a/tools/perf/util/counts.h b/tools/perf/util/counts.h
index 0d1050ccc586..b8bdbff586bb 100644
--- a/tools/perf/util/counts.h
+++ b/tools/perf/util/counts.h
@@ -36,4 +36,8 @@ void perf_evsel__reset_counts(struct perf_evsel *evsel);
 int perf_evsel__alloc_counts(struct perf_evsel *evsel, int ncpus, int nthreads);
 void perf_evsel__free_counts(struct perf_evsel *evsel);
 
+int perf_evsel__alloc_prev_raw_counts(struct perf_evsel *evsel,
+				      int ncpus, int nthreads);
+void perf_evsel__free_prev_raw_counts(struct perf_evsel *evsel);
+
 #endif /* __PERF_COUNTS_H */
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 3bbf73e979c0..8e0fbe34e5d9 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1294,6 +1294,8 @@ void perf_evsel__exit(struct perf_evsel *evsel)
 	assert(evsel->evlist == NULL);
 	perf_evsel__free_fd(evsel);
 	perf_evsel__free_id(evsel);
+	perf_evsel__free_counts(evsel);
+	perf_evsel__free_prev_raw_counts(evsel);
 	perf_evsel__free_config_terms(evsel);
 	cgroup__put(evsel->cgrp);
 	cpu_map__put(evsel->cpus);
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 4d40515307b8..6a22842f76d2 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -136,24 +136,6 @@ static void perf_evsel__free_stat_priv(struct perf_evsel *evsel)
 	zfree(&evsel->stats);
 }
 
-static int perf_evsel__alloc_prev_raw_counts(struct perf_evsel *evsel,
-					     int ncpus, int nthreads)
-{
-	struct perf_counts *counts;
-
-	counts = perf_counts__new(ncpus, nthreads);
-	if (counts)
-		evsel->prev_raw_counts = counts;
-
-	return counts ? 0 : -ENOMEM;
-}
-
-static void perf_evsel__free_prev_raw_counts(struct perf_evsel *evsel)
-{
-	perf_counts__delete(evsel->prev_raw_counts);
-	evsel->prev_raw_counts = NULL;
-}
-
 static int perf_evsel__alloc_stats(struct perf_evsel *evsel, bool alloc_raw)
 {
 	int ncpus = perf_evsel__nr_cpus(evsel);
-- 
2.19.1

