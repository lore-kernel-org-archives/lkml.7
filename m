Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BACAECA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:41:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F2C02166E
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:41:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571665263;
	bh=muH0CLm37RWgXCw9tdoRkRQCcOWFtFZ43VskU7mzloU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0p2/xD2Z0cZR6x5de42zSP/qckMkSJswCAb5F6tKFPqvah0DcJlHhaO03ga2xs+d9
	 wb9EB80xaNK1zZam57qRYmAZRlZEYHNGZPnjiUidfi/2CtgGari0Y4yLA7QGPEs/c3
	 F59mOh6QdoFZr/xHey1GyrqnPJIqxnBib0kMwIx8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729610AbfJUNlB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 09:41:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:42790 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729593AbfJUNkz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 09:40:55 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B01B9217D7;
        Mon, 21 Oct 2019 13:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571665254;
        bh=muH0CLm37RWgXCw9tdoRkRQCcOWFtFZ43VskU7mzloU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jAjZ1tnHd7PmRwzO7RGhm/kKtMDdxMJIwn8rvCuNK3rudi6ZvzW2yj2d9qpisJVur
         KYXm7OunKNoxH2xTQlr6CQNNU05/PlFmkUbuSQ9a8pkkYb3IDmRurlkk6ncictTLOt
         sbT/XF8JR7O0eJeurk8Si9inD1bAAGRVDyZmWGVM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Leo Yan <leo.yan@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Brajeswar Ghosh <brajeswar.linux@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        Souptick Joarder <jrdr.linux@gmail.com>,
        Will Deacon <will@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 41/57] perf tests bp_account: Add dedicated checking helper is_supported()
Date:   Mon, 21 Oct 2019 10:38:18 -0300
Message-Id: <20191021133834.25998-42-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191021133834.25998-1-acme@kernel.org>
References: <20191021133834.25998-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leo Yan <leo.yan@linaro.org>

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
index 52ff7a462670..d0b935356274 100644
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
index 55774baffc2a..8b286e9b7549 100644
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
index 72912eb473cb..9837b6e93023 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -111,6 +111,7 @@ int test__map_groups__merge_in(struct test *t, int subtest);
 int test__time_utils(struct test *t, int subtest);
 
 bool test__bp_signal_is_supported(void);
+bool test__bp_account_is_supported(void);
 bool test__wp_is_supported(void);
 
 #if defined(__arm__) || defined(__aarch64__)
-- 
2.21.0

