Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46F99C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2029821925
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 22:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbfCVWer (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 18:34:47 -0400
Received: from terminus.zytor.com ([198.137.202.136]:58291 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727764AbfCVWer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 18:34:47 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x2MMXwhT754170
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 22 Mar 2019 15:33:58 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x2MMXvJq754167;
        Fri, 22 Mar 2019 15:33:57 -0700
Date:   Fri, 22 Mar 2019 15:33:57 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Changbin Du <tipbot@zytor.com>
Message-ID: <tip-f97a8991d3b998e518f56794d879f645964de649@git.kernel.org>
Cc:     peterz@infradead.org, ast@kernel.org, tglx@linutronix.de,
        ak@linux.intel.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        daniel@iogearbox.net, rostedt@goodmis.org, changbin.du@gmail.com,
        acme@redhat.com, hpa@zytor.com, jolsa@kernel.org,
        namhyung@kernel.org
Reply-To: peterz@infradead.org, tglx@linutronix.de, ast@kernel.org,
          ak@linux.intel.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, daniel@iogearbox.net,
          hpa@zytor.com, acme@redhat.com, jolsa@kernel.org,
          rostedt@goodmis.org, changbin.du@gmail.com, namhyung@kernel.org
In-Reply-To: <20190316080556.3075-16-changbin.du@gmail.com>
References: <20190316080556.3075-16-changbin.du@gmail.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf tests: Fix memory leak by expr__find_other()
 in test__expr()
Git-Commit-ID: f97a8991d3b998e518f56794d879f645964de649
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

Commit-ID:  f97a8991d3b998e518f56794d879f645964de649
Gitweb:     https://git.kernel.org/tip/f97a8991d3b998e518f56794d879f645964de649
Author:     Changbin Du <changbin.du@gmail.com>
AuthorDate: Sat, 16 Mar 2019 16:05:55 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 19 Mar 2019 16:52:05 -0300

perf tests: Fix memory leak by expr__find_other() in test__expr()

  =================================================================
  ==7506==ERROR: LeakSanitizer: detected memory leaks

  Direct leak of 13 byte(s) in 3 object(s) allocated from:
      #0 0x7f03339d6070 in __interceptor_strdup (/usr/lib/x86_64-linux-gnu/libasan.so.5+0x3b070)
      #1 0x5625e53aaef0 in expr__find_other util/expr.y:221
      #2 0x5625e51bcd3f in test__expr tests/expr.c:52
      #3 0x5625e51528e6 in run_test tests/builtin-test.c:358
      #4 0x5625e5152baf in test_and_print tests/builtin-test.c:388
      #5 0x5625e51543fe in __cmd_test tests/builtin-test.c:583
      #6 0x5625e515572f in cmd_test tests/builtin-test.c:722
      #7 0x5625e51c3fb8 in run_builtin /home/changbin/work/linux/tools/perf/perf.c:302
      #8 0x5625e51c44f7 in handle_internal_command /home/changbin/work/linux/tools/perf/perf.c:354
      #9 0x5625e51c48fb in run_argv /home/changbin/work/linux/tools/perf/perf.c:398
      #10 0x5625e51c5069 in main /home/changbin/work/linux/tools/perf/perf.c:520
      #11 0x7f033214d09a in __libc_start_main (/lib/x86_64-linux-gnu/libc.so.6+0x2409a)

Signed-off-by: Changbin Du <changbin.du@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Fixes: 075167363f8b ("perf tools: Add a simple expression parser for JSON")
Link: http://lkml.kernel.org/r/20190316080556.3075-16-changbin.du@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/expr.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/expr.c b/tools/perf/tests/expr.c
index 01f0706995a9..9acc1e80b936 100644
--- a/tools/perf/tests/expr.c
+++ b/tools/perf/tests/expr.c
@@ -19,7 +19,7 @@ int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
 	const char *p;
 	const char **other;
 	double val;
-	int ret;
+	int i, ret;
 	struct parse_ctx ctx;
 	int num_other;
 
@@ -56,6 +56,9 @@ int test__expr(struct test *t __maybe_unused, int subtest __maybe_unused)
 	TEST_ASSERT_VAL("find other", !strcmp(other[1], "BAZ"));
 	TEST_ASSERT_VAL("find other", !strcmp(other[2], "BOZO"));
 	TEST_ASSERT_VAL("find other", other[3] == NULL);
+
+	for (i = 0; i < num_other; i++)
+		free((void *)other[i]);
 	free((void *)other);
 
 	return 0;
