Return-Path: <SRS0=b0IM=RT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75D31C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 08:07:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CFA5218E0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Mar 2019 08:07:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E+84NVUv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfCPIHM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Mar 2019 04:07:12 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40395 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726549AbfCPIHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Mar 2019 04:07:10 -0400
Received: by mail-pf1-f195.google.com with SMTP id y124so7904089pfy.7;
        Sat, 16 Mar 2019 01:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A6gvYp1N3jcgSFOabUpRlyP0f9TBpeTrmooFa8GaB1Q=;
        b=E+84NVUvbWdq2nP8esUw4ENPMHhdrPp1lDhRDDSVMuVG5QnMih4o9PSYKQe37ovQXp
         t96qouIoKpzti7QKx74lBQcJ6/RoLI4XPgFclxxQzC589/XgU+c8wwu/In6XDg1svZRb
         pGzZ8jAR64rxPKDy+Wips8GjFeNzhOpq9nR/q2J6N/ulR3BmAADAQbXFXrBsk8fqz5sQ
         0WFXy/+pXV7X82nGq5lvKo4y0bNdaeNXCl9ezxeN8w9ADVANzyqjMotnyo9PQNPhBPWx
         rnFsJhl36KnEEt9d3K/uMML8vjRn8NqgV9VmM24RAeO1hifONn/p5wchWq40cZ9BomOx
         pfvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A6gvYp1N3jcgSFOabUpRlyP0f9TBpeTrmooFa8GaB1Q=;
        b=i1mXsFjLQbpc8OdohtnLrR7d5wP1kbVTlocKINUZmRCWbPfMGzhjqCwIFPGYz4uc44
         L0cb7NnULtC56AXfk3WCir7TpTSEsTAwThFDzbU7SfN9H+LVDl7QxkgCyc03QLdzff1k
         9Q4cC3mv1O0iaUEpPot0QC98CxzheOgvmA1D1lfU8fQBSGzojD5FtA4Hikpw1agIhk/C
         Q43as6Apkpaj8wadk7XH1nGMkuNGC2iXYCIqFJb/wcgm8c/X+fWCAUgAgvc145QJI+jI
         JWOMH7/EOf7cf5/UhAELyarnEtw2N3DUf2r7wV8N9fjfPHMfINOnFnGgldDM4aZq7sFv
         oM5w==
X-Gm-Message-State: APjAAAUYZsQpEo6lYL9QNZh6B688MOtxJ+Lb5u+JiFS9jss2h6PN/jlG
        0dcXodjcIb5SpHQAdp5xWPM=
X-Google-Smtp-Source: APXvYqzPmt9hNJUIJPE94+CuJfHtLj88lQApaWksY1VvyVfkWOKnMQfX0h8uqPIr5x8NHfeS9vMOvw==
X-Received: by 2002:a17:902:7e0f:: with SMTP id b15mr8268857plm.124.1552723629321;
        Sat, 16 Mar 2019 01:07:09 -0700 (PDT)
Received: from localhost.localdomain ([104.238.181.70])
        by smtp.gmail.com with ESMTPSA id y14sm10690975pgs.47.2019.03.16.01.07.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 16 Mar 2019 01:07:08 -0700 (PDT)
From:   Changbin Du <changbin.du@gmail.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     namhyung@kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexei Starovoitov <ast@kernel.org>, rostedt@goodmis.org,
        Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 07/16] perf: top: fix heap-use-after-free issue
Date:   Sat, 16 Mar 2019 16:05:47 +0800
Message-Id: <20190316080556.3075-8-changbin.du@gmail.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190316080556.3075-1-changbin.du@gmail.com>
References: <20190316080556.3075-1-changbin.du@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The evlist should be destroyed before the perf session.

=================================================================
==27350==ERROR: AddressSanitizer: heap-use-after-free on address 0x62b000002e38 at pc 0x5611da276999 bp 0x7ffce8f1d1a0 sp 0x7ffce8f1d190
WRITE of size 8 at 0x62b000002e38 thread T0
    #0 0x5611da276998 in __list_del /home/work/linux/tools/include/linux/list.h:89
    #1 0x5611da276d4a in __list_del_entry /home/work/linux/tools/include/linux/list.h:102
    #2 0x5611da276e77 in list_del_init /home/work/linux/tools/include/linux/list.h:145
    #3 0x5611da2781cd in thread__put util/thread.c:130
    #4 0x5611da2cc0a8 in __thread__zput util/thread.h:68
    #5 0x5611da2d2dcb in hist_entry__delete util/hist.c:1148
    #6 0x5611da2cdf91 in hists__delete_entry util/hist.c:337
    #7 0x5611da2ce19e in hists__delete_entries util/hist.c:365
    #8 0x5611da2db2ab in hists__delete_all_entries util/hist.c:2639
    #9 0x5611da2db325 in hists_evsel__exit util/hist.c:2651
    #10 0x5611da1c5352 in perf_evsel__exit util/evsel.c:1304
    #11 0x5611da1c5390 in perf_evsel__delete util/evsel.c:1309
    #12 0x5611da1b35f0 in perf_evlist__purge util/evlist.c:124
    #13 0x5611da1b38e2 in perf_evlist__delete util/evlist.c:148
    #14 0x5611da069781 in cmd_top /home/changbin/work/linux/tools/perf/builtin-top.c:1645
    #15 0x5611da17d038 in run_builtin /home/changbin/work/linux/tools/perf/perf.c:302
    #16 0x5611da17d577 in handle_internal_command /home/changbin/work/linux/tools/perf/perf.c:354
    #17 0x5611da17d97b in run_argv /home/changbin/work/linux/tools/perf/perf.c:398
    #18 0x5611da17e0e9 in main /home/changbin/work/linux/tools/perf/perf.c:520
    #19 0x7fdcc970f09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x2409a)
    #20 0x5611d9ff35c9 in _start (/home/work/linux/tools/perf/perf+0x3e95c9)

0x62b000002e38 is located 11320 bytes inside of 27448-byte region [0x62b000000200,0x62b000006d38)
freed by thread T0 here:
    #0 0x7fdccb04ab70 in free (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xedb70)
    #1 0x5611da260df4 in perf_session__delete util/session.c:201
    #2 0x5611da063de5 in __cmd_top /home/changbin/work/linux/tools/perf/builtin-top.c:1300
    #3 0x5611da06973c in cmd_top /home/changbin/work/linux/tools/perf/builtin-top.c:1642
    #4 0x5611da17d038 in run_builtin /home/changbin/work/linux/tools/perf/perf.c:302
    #5 0x5611da17d577 in handle_internal_command /home/changbin/work/linux/tools/perf/perf.c:354
    #6 0x5611da17d97b in run_argv /home/changbin/work/linux/tools/perf/perf.c:398
    #7 0x5611da17e0e9 in main /home/changbin/work/linux/tools/perf/perf.c:520
    #8 0x7fdcc970f09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x2409a)

previously allocated by thread T0 here:
    #0 0x7fdccb04b138 in calloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xee138)
    #1 0x5611da26010c in zalloc util/util.h:23
    #2 0x5611da260824 in perf_session__new util/session.c:118
    #3 0x5611da0633a6 in __cmd_top /home/changbin/work/linux/tools/perf/builtin-top.c:1192
    #4 0x5611da06973c in cmd_top /home/changbin/work/linux/tools/perf/builtin-top.c:1642
    #5 0x5611da17d038 in run_builtin /home/changbin/work/linux/tools/perf/perf.c:302
    #6 0x5611da17d577 in handle_internal_command /home/changbin/work/linux/tools/perf/perf.c:354
    #7 0x5611da17d97b in run_argv /home/changbin/work/linux/tools/perf/perf.c:398
    #8 0x5611da17e0e9 in main /home/changbin/work/linux/tools/perf/perf.c:520
    #9 0x7fdcc970f09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x2409a)

SUMMARY: AddressSanitizer: heap-use-after-free /home/work/linux/tools/include/linux/list.h:89 in __list_del
Shadow bytes around the buggy address:
  0x0c567fff8570: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
  0x0c567fff8580: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
  0x0c567fff8590: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
  0x0c567fff85a0: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
  0x0c567fff85b0: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
=>0x0c567fff85c0: fd fd fd fd fd fd fd[fd]fd fd fd fd fd fd fd fd
  0x0c567fff85d0: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
  0x0c567fff85e0: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
  0x0c567fff85f0: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
  0x0c567fff8600: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
  0x0c567fff8610: fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd fd
Shadow byte legend (one shadow byte represents 8 application bytes):
  Addressable:           00
  Partially addressable: 01 02 03 04 05 06 07
  Heap left redzone:       fa
  Freed heap region:       fd
  Stack left redzone:      f1
  Stack mid redzone:       f2
  Stack right redzone:     f3
  Stack after return:      f5
  Stack use after scope:   f8
  Global redzone:          f9
  Global init order:       f6
  Poisoned by user:        f7
  Container overflow:      fc
  Array cookie:            ac
  Intra object redzone:    bb
  ASan internal:           fe
  Left alloca redzone:     ca
  Right alloca redzone:    cb
==27350==ABORTING

Signed-off-by: Changbin Du <changbin.du@gmail.com>
---
 tools/perf/builtin-top.c | 42 ++++++++++++++++++----------------------
 1 file changed, 19 insertions(+), 23 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 231a90daa958..614f278235fa 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1189,23 +1189,19 @@ static int __cmd_top(struct perf_top *top)
 	pthread_t thread, thread_process;
 	int ret;
 
-	top->session = perf_session__new(NULL, false, NULL);
-	if (top->session == NULL)
-		return -1;
-
 	if (!top->annotation_opts.objdump_path) {
 		ret = perf_env__lookup_objdump(&top->session->header.env,
 					       &top->annotation_opts.objdump_path);
 		if (ret)
-			goto out_delete;
+			return ret;
 	}
 
 	ret = callchain_param__setup_sample_type(&callchain_param);
 	if (ret)
-		goto out_delete;
+		return ret;
 
 	if (perf_session__register_idle_thread(top->session) < 0)
-		goto out_delete;
+		return ret;
 
 	if (top->nr_threads_synthesize > 1)
 		perf_set_multithreaded();
@@ -1227,13 +1223,18 @@ static int __cmd_top(struct perf_top *top)
 
 	if (perf_hpp_list.socket) {
 		ret = perf_env__read_cpu_topology_map(&perf_env);
-		if (ret < 0)
-			goto out_err_cpu_topo;
+		if (ret < 0) {
+			char errbuf[BUFSIZ];
+			const char *err = str_error_r(-ret, errbuf, sizeof(errbuf));
+
+			ui__error("Could not read the CPU topology map: %s\n", err);
+			return ret;
+		}
 	}
 
 	ret = perf_top__start_counters(top);
 	if (ret)
-		goto out_delete;
+		return ret;
 
 	top->session->evlist = top->evlist;
 	perf_session__set_id_hdr_size(top->session);
@@ -1252,7 +1253,7 @@ static int __cmd_top(struct perf_top *top)
 	ret = -1;
 	if (pthread_create(&thread_process, NULL, process_thread, top)) {
 		ui__error("Could not create process thread.\n");
-		goto out_delete;
+		return ret;
 	}
 
 	if (pthread_create(&thread, NULL, (use_browser > 0 ? display_thread_tui :
@@ -1296,19 +1297,7 @@ static int __cmd_top(struct perf_top *top)
 out_join_thread:
 	pthread_cond_signal(&top->qe.cond);
 	pthread_join(thread_process, NULL);
-out_delete:
-	perf_session__delete(top->session);
-	top->session = NULL;
-
 	return ret;
-
-out_err_cpu_topo: {
-	char errbuf[BUFSIZ];
-	const char *err = str_error_r(-ret, errbuf, sizeof(errbuf));
-
-	ui__error("Could not read the CPU topology map: %s\n", err);
-	goto out_delete;
-}
 }
 
 static int
@@ -1639,10 +1628,17 @@ int cmd_top(int argc, const char **argv)
 		signal(SIGWINCH, winch_sig);
 	}
 
+	top.session = perf_session__new(NULL, false, NULL);
+	if (top.session == NULL) {
+		status = -1;
+		goto out_delete_evlist;
+	}
+
 	status = __cmd_top(&top);
 
 out_delete_evlist:
 	perf_evlist__delete(top.evlist);
+	perf_session__delete(top.session);
 
 	return status;
 }
-- 
2.19.1

