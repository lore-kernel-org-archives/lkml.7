Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF560ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 14:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D08C221479
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 14:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728376AbfJGOtq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 10:49:46 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44472 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728588AbfJGOtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 10:49:40 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iHUKF-00065n-5e; Mon, 07 Oct 2019 16:49:27 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E70521C08B0;
        Mon,  7 Oct 2019 16:49:17 +0200 (CEST)
Date:   Mon, 07 Oct 2019 14:49:17 -0000
From:   "tip-bot2 for Ian Rogers" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf tests: Avoid raising SEGV using an obvious
 NULL dereference
Cc:     Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        Wang Nan <wangnan0@huawei.com>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20190925195924.152834-2-irogers@google.com>
References: <20190925195924.152834-2-irogers@google.com>
MIME-Version: 1.0
Message-ID: <157045975781.9978.17507056715784418883.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     e3e2cf3d5b1fe800b032e14c0fdcd9a6fb20cf3b
Gitweb:        https://git.kernel.org/tip/e3e2cf3d5b1fe800b032e14c0fdcd9a6fb20cf3b
Author:        Ian Rogers <irogers@google.com>
AuthorDate:    Wed, 25 Sep 2019 12:59:24 -07:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Fri, 27 Sep 2019 09:26:14 -03:00

perf tests: Avoid raising SEGV using an obvious NULL dereference

An optimized build such as:

  make -C tools/perf CLANG=1 CC=clang EXTRA_CFLAGS="-O3

will turn the dereference operation into a ud2 instruction, raising a
SIGILL rather than a SIGSEGV. Use raise(..) for correctness and clarity.

Similar issues were addressed in Numfor Mbiziwo-Tiapo's patch:

  https://lkml.org/lkml/2019/7/8/1234

Committer testing:

Before:

  [root@quaco ~]# perf test hooks
  55: perf hooks                                            : Ok
  [root@quaco ~]# perf test -v hooks
  55: perf hooks                                            :
  --- start ---
  test child forked, pid 17092
  SIGSEGV is observed as expected, try to recover.
  Fatal error (SEGFAULT) in perf hook 'test'
  test child finished with 0
  ---- end ----
  perf hooks: Ok
  [root@quaco ~]#

After:

  [root@quaco ~]# perf test hooks
  55: perf hooks                                            : Ok
  [root@quaco ~]# perf test -v hooks
  55: perf hooks                                            :
  --- start ---
  test child forked, pid 17909
  SIGSEGV is observed as expected, try to recover.
  Fatal error (SEGFAULT) in perf hook 'test'
  test child finished with 0
  ---- end ----
  perf hooks: Ok
  [root@quaco ~]#

Fixes: a074865e60ed ("perf tools: Introduce perf hooks")
Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: Wang Nan <wangnan0@huawei.com>
Link: http://lore.kernel.org/lkml/20190925195924.152834-2-irogers@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/perf-hooks.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/perf/tests/perf-hooks.c b/tools/perf/tests/perf-hooks.c
index dbc2719..dd865e0 100644
--- a/tools/perf/tests/perf-hooks.c
+++ b/tools/perf/tests/perf-hooks.c
@@ -19,12 +19,11 @@ static void sigsegv_handler(int sig __maybe_unused)
 static void the_hook(void *_hook_flags)
 {
 	int *hook_flags = _hook_flags;
-	int *p = NULL;
 
 	*hook_flags = 1234;
 
 	/* Generate a segfault, test perf_hooks__recover */
-	*p = 0;
+	raise(SIGSEGV);
 }
 
 int test__perf_hooks(struct test *test __maybe_unused, int subtest __maybe_unused)
