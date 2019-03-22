Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E688C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23482218D4
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:34:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbfCVWeD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 18:34:03 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56499 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727522AbfCVWeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 18:34:03 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2MMXFQ7754128
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 22 Mar 2019 15:33:15 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2MMXEtC754125;
        Fri, 22 Mar 2019 15:33:14 -0700
Date:   Fri, 22 Mar 2019 15:33:14 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Changbin Du <tipbot@zytor.com>
Message-ID: <tip-93faa52e8371f0291ee1ff4994edae2b336b6233@git.kernel.org>
Cc:     namhyung@kernel.org, daniel@iogearbox.net, peterz@infradead.org,
        hpa@zytor.com, tglx@linutronix.de, changbin.du@gmail.com,
        ast@kernel.org, rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        mingo@kernel.org, acme@redhat.com, jolsa@kernel.org
Reply-To: tglx@linutronix.de, hpa@zytor.com, peterz@infradead.org,
          namhyung@kernel.org, daniel@iogearbox.net, jolsa@kernel.org,
          acme@redhat.com, mingo@kernel.org, rostedt@goodmis.org,
          linux-kernel@vger.kernel.org, changbin.du@gmail.com,
          ast@kernel.org
In-Reply-To: <20190316080556.3075-15-changbin.du@gmail.com>
References: <20190316080556.3075-15-changbin.du@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf tests: Fix a memory leak of cpu_map object
 in the openat_syscall_event_on_all_cpus test
Git-Commit-ID: 93faa52e8371f0291ee1ff4994edae2b336b6233
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

Commit-ID:  93faa52e8371f0291ee1ff4994edae2b336b6233
Gitweb:     https://git.kernel.org/tip/93faa52e8371f0291ee1ff4994edae2b336b6233
Author:     Changbin Du <changbin.du@gmail.com>
AuthorDate: Sat, 16 Mar 2019 16:05:54 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 19 Mar 2019 16:52:05 -0300

perf tests: Fix a memory leak of cpu_map object in the openat_syscall_event_on_all_cpus test

  =================================================================
  ==7497==ERROR: LeakSanitizer: detected memory leaks

  Direct leak of 40 byte(s) in 1 object(s) allocated from:
      #0 0x7f0333a88f30 in __interceptor_malloc (/usr/lib/x86_64-linux-gnu/libasan.so.5+0xedf30)
      #1 0x5625e5326213 in cpu_map__trim_new util/cpumap.c:45
      #2 0x5625e5326703 in cpu_map__read util/cpumap.c:103
      #3 0x5625e53267ef in cpu_map__read_all_cpu_map util/cpumap.c:120
      #4 0x5625e5326915 in cpu_map__new util/cpumap.c:135
      #5 0x5625e517b355 in test__openat_syscall_event_on_all_cpus tests/openat-syscall-all-cpus.c:36
      #6 0x5625e51528e6 in run_test tests/builtin-test.c:358
      #7 0x5625e5152baf in test_and_print tests/builtin-test.c:388
      #8 0x5625e51543fe in __cmd_test tests/builtin-test.c:583
      #9 0x5625e515572f in cmd_test tests/builtin-test.c:722
      #10 0x5625e51c3fb8 in run_builtin /home/changbin/work/linux/tools/perf/perf.c:302
      #11 0x5625e51c44f7 in handle_internal_command /home/changbin/work/linux/tools/perf/perf.c:354
      #12 0x5625e51c48fb in run_argv /home/changbin/work/linux/tools/perf/perf.c:398
      #13 0x5625e51c5069 in main /home/changbin/work/linux/tools/perf/perf.c:520
      #14 0x7f033214d09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x2409a)

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Fixes: f30a79b012e5 ("perf tools: Add reference counting for cpu_map object")
Link: http://lkml.kernel.org/r/20190316080556.3075-15-changbin.du@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/openat-syscall-all-cpus.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/openat-syscall-all-cpus.c b/tools/perf/tests/openat-syscall-all-cpus.c
index c531e6deb104..493ecb611540 100644
--- a/tools/perf/tests/openat-syscall-all-cpus.c
+++ b/tools/perf/tests/openat-syscall-all-cpus.c
@@ -45,7 +45,7 @@ int test__openat_syscall_event_on_all_cpus(struct test *test __maybe_unused, int
 	if (IS_ERR(evsel)) {
 		tracing_path__strerror_open_tp(errno, errbuf, sizeof(errbuf), "syscalls", "sys_enter_openat");
 		pr_debug("%s\n", errbuf);
-		goto out_thread_map_delete;
+		goto out_cpu_map_delete;
 	}
 
 	if (perf_evsel__open(evsel, cpus, threads) < 0) {
@@ -119,6 +119,8 @@ out_close_fd:
 	perf_evsel__close_fd(evsel);
 out_evsel_delete:
 	perf_evsel__delete(evsel);
+out_cpu_map_delete:
+	cpu_map__put(cpus);
 out_thread_map_delete:
 	thread_map__put(threads);
 	return err;
