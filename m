Return-Path: <SRS0=/BZh=RY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D21C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3586521917
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Mar 2019 18:54:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553194453;
	bh=bmBvl8Owh1QUKPpMvSAHZBuJCi3LGd+QRqua22nE+cw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VDOdwujA2YbvoQDc74Pem8bwkPRQYb17gMxDYA1uoOyysVFWqm18k0HSKkwLB1ybC
	 jlvpu/+Qow+//6lJ1LK16LpduHiaIJkJtd5Dq7o7WK8YaCZdTvfezEL8ol4EZzjyTv
	 /6VuQgBAhSbRE/TS01ged/0GJTcchkqCl/gWo19k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729066AbfCUSyL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Mar 2019 14:54:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:45874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728882AbfCUSyI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Mar 2019 14:54:08 -0400
Received: from quaco.ghostprotocols.net (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40D782196F;
        Thu, 21 Mar 2019 18:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553194447;
        bh=bmBvl8Owh1QUKPpMvSAHZBuJCi3LGd+QRqua22nE+cw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c7Lw3zo7N1pofBcc7mGsQGFgXE3sFc/Wq6eU/4+nfg7mTFjmKoiK8CE/HInNoI4yK
         I8rl/BseEsAMzFXLRU6vmz7iwLo8NNnzSrvXgJewh1wWqdpN7UOA5qS2oDCJK1lzPn
         7Ry8mYzPnmhZqxXD7IgHHp+qTxJuegkdVpxTMYMQ=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 24/44] perf tests: Fix memory leak by expr__find_other() in test__expr()
Date:   Thu, 21 Mar 2019 15:51:22 -0300
Message-Id: <20190321185142.11441-25-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190321185142.11441-1-acme@kernel.org>
References: <20190321185142.11441-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Changbin Du <changbin.du@gmail.com>

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
-- 
2.20.1

