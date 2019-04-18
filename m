Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 223B6C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:33:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E160C20643
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555612411;
	bh=mxAQzm1jcGjNZhRBYLNA2ZrH0pakSkliB3g4qnZrpOA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=i5XxAbKos2RyvInnEgU4xD7YDmSl12ju5GRGJiP9uC2EzMfHK3h99kl8qjOEGaoHz
	 28XlHajJyNN/gaxtWW3HOhF/P8lIhXGnS1a29z6pBS8WX+haCIWbN4t391iat4ZI4Q
	 IjiO85E7V20wRrmgvtLF5/i4eNuHRysHu8lDxeow=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390047AbfDRSda (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:33:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:54270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390112AbfDRR73 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 13:59:29 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 877B1218FC;
        Thu, 18 Apr 2019 17:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610369;
        bh=mxAQzm1jcGjNZhRBYLNA2ZrH0pakSkliB3g4qnZrpOA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NNYXkQVxRlL0MPHlhRWImktVwBxA3+rUx3rvB+Yi46OeJR7d3DcRkz4ZFPJWaSGEd
         kn32xvcHSzcHflFMJ950PhHlZcbcY1cefIumoV9I0/sFGRcukQClh/5pb1I41qMZ+i
         NpCjzCGRYZQgL2UPLDRYtS0ATDZNiV22ZBHcsrjA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Changbin Du <changbin.du@gmail.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 035/110] perf tests: Fix a memory leak of cpu_map object in the openat_syscall_event_on_all_cpus test
Date:   Thu, 18 Apr 2019 19:56:24 +0200
Message-Id: <20190418160441.866051620@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160437.484158340@linuxfoundation.org>
References: <20190418160437.484158340@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 93faa52e8371f0291ee1ff4994edae2b336b6233 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
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
@@ -119,6 +119,8 @@ int test__openat_syscall_event_on_all_cpus(struct test *test __maybe_unused, int
 	perf_evsel__close_fd(evsel);
 out_evsel_delete:
 	perf_evsel__delete(evsel);
+out_cpu_map_delete:
+	cpu_map__put(cpus);
 out_thread_map_delete:
 	thread_map__put(threads);
 	return err;
-- 
2.19.1



