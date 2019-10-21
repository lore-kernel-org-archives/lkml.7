Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 916DFCA9EB0
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 00:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C7A220656
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 00:04:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730818AbfJVAEx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 20:04:53 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38895 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730730AbfJVAEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 20:04:51 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iMgwy-0003vi-9L; Tue, 22 Oct 2019 01:18:56 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 73CCC1C047B;
        Tue, 22 Oct 2019 01:18:55 +0200 (CEST)
Date:   Mon, 21 Oct 2019 23:18:54 -0000
From:   "tip-bot2 for Leo Yan" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf tests bp_account: Add dedicated checking helper
 is_supported()
Cc:     Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Will Deacon <will@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191018085531.6348-2-leo.yan@linaro.org>
References: <20191018085531.6348-2-leo.yan@linaro.org>
MIME-Version: 1.0
Message-ID: <157169993489.29376.15623628756764296019.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     e533eadf6596451880f518949cbb964dbd6189ae
Gitweb:        https://git.kernel.org/tip/e533eadf6596451880f518949cbb964dbd6189ae
Author:        Leo Yan <leo.yan@linaro.org>
AuthorDate:    Fri, 18 Oct 2019 16:55:30 +08:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Sat, 19 Oct 2019 15:35:01 -03:00

perf tests bp_account: Add dedicated checking helper is_supported()

The arm architecture supports breakpoint accounting but it doesn't
support breakpoint overflow signal handling.  The current code uses the
same checking helper, thus it disables both testings (bp_account and
bp_signal) for arm platform.

For handling two testings separately, this patch adds a dedicated
checking helper is_supported() for breakpoint accounting testing, thus
it allows supporting breakpoint accounting testing on arm platform; the
old helper test__bp_signal_is_supported() is only used to checking for
breakpoint overflow signal testing.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Brajeswar Ghosh <brajeswar.linux@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Song Liu <songliubraving@fb.com>
Cc: Souptick Joarder <jrdr.linux@gmail.com>
Cc: Will Deacon <will@kernel.org>
Link: http://lore.kernel.org/lkml/20191018085531.6348-2-leo.yan@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/bp_account.c   | 16 ++++++++++++++++
 tools/perf/tests/builtin-test.c |  2 +-
 tools/perf/tests/tests.h        |  1 +
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/bp_account.c b/tools/perf/tests/bp_account.c
index 52ff7a4..d0b9353 100644
--- a/tools/perf/tests/bp_account.c
+++ b/tools/perf/tests/bp_account.c
@@ -188,3 +188,19 @@ int test__bp_accounting(struct test *test __maybe_unused, int subtest __maybe_un
 
 	return bp_accounting(wp_cnt, share);
 }
+
+bool test__bp_account_is_supported(void)
+{
+	/*
+	 * PowerPC and S390 do not support creation of instruction
+	 * breakpoints using the perf_event interface.
+	 *
+	 * Just disable the test for these architectures until these
+	 * issues are resolved.
+	 */
+#if defined(__powerpc__) || defined(__s390x__)
+	return false;
+#else
+	return true;
+#endif
+}
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 55774ba..8b286e9 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -121,7 +121,7 @@ static struct test generic_tests[] = {
 	{
 		.desc = "Breakpoint accounting",
 		.func = test__bp_accounting,
-		.is_supported = test__bp_signal_is_supported,
+		.is_supported = test__bp_account_is_supported,
 	},
 	{
 		.desc = "Watchpoint",
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 72912eb..9837b6e 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -111,6 +111,7 @@ int test__map_groups__merge_in(struct test *t, int subtest);
 int test__time_utils(struct test *t, int subtest);
 
 bool test__bp_signal_is_supported(void);
+bool test__bp_account_is_supported(void);
 bool test__wp_is_supported(void);
 
 #if defined(__arm__) || defined(__aarch64__)
