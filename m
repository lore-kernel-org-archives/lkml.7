Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E72C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 728632064A
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553907569;
	bh=BARagYluGP3C9HORMpnlfhRnLa2R19Yu7Zz0HvuoSXg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Qxbi8XBLQQOX+EFg0rYZIBzTt9d8bXhTOZZOSPxa9KLWJS1fjNnZiqt/o4eOUixzQ
	 sn498SfA6EIITeY3gKd3EMM/60tqHMhh2Zw9LGQgfLfJCgKfo+L7HQmiZfIELsqt54
	 /kJyL6A5Xt0RJ44fpbYEzLFtd9b0nuVHRgHGGHgQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732137AbfC3A72 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 20:59:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:37354 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731724AbfC3A5S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 20:57:18 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C0CCA217F5;
        Sat, 30 Mar 2019 00:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553907436;
        bh=BARagYluGP3C9HORMpnlfhRnLa2R19Yu7Zz0HvuoSXg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IodWZBI8SloKMo6Nfeb8M2IwxbdxyL0Ze+Drbv7EPkC+p8gM8JGLKfg8XpjANER4P
         aS3SAKzvywFIDWa+Ft3nqnS2xWaLD2iqrZdfX/9DHci4zY5mEJrMQkKgXLWMw6Dzpk
         6F1lJnVYWWW+iYUPDTpo8CVloG8pYEODEOIhp+3w=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Changbin Du <changbin.du@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 14/21] perf tests: Fix a memory leak of cpu_map object in the openat_syscall_event_on_all_cpus test
Date:   Fri, 29 Mar 2019 20:56:42 -0400
Message-Id: <20190330005649.28475-14-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330005649.28475-1-sashal@kernel.org>
References: <20190330005649.28475-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changbin Du <changbin.du@gmail.com>

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
index 2006485a2859..3848d5ab378d 100644
--- a/tools/perf/tests/openat-syscall-all-cpus.c
+++ b/tools/perf/tests/openat-syscall-all-cpus.c
@@ -35,7 +35,7 @@ int test__openat_syscall_event_on_all_cpus(void)
 	if (IS_ERR(evsel)) {
 		tracing_path__strerror_open_tp(errno, errbuf, sizeof(errbuf), "syscalls", "sys_enter_openat");
 		pr_debug("%s\n", errbuf);
-		goto out_thread_map_delete;
+		goto out_cpu_map_delete;
 	}
 
 	if (perf_evsel__open(evsel, cpus, threads) < 0) {
@@ -109,6 +109,8 @@ int test__openat_syscall_event_on_all_cpus(void)
 	perf_evsel__close_fd(evsel, 1, threads->nr);
 out_evsel_delete:
 	perf_evsel__delete(evsel);
+out_cpu_map_delete:
+	cpu_map__put(cpus);
 out_thread_map_delete:
 	thread_map__put(threads);
 	return err;
-- 
2.19.1

