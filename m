Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F05C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:04:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB22621883
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 19:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560279896;
	bh=JoBDITOzsUeAVXcmHQ2oOTmpx8aYoN/GqDhn0GvFB30=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ng1M8cyAwoFFQrtujX4t1NbQM7pbVxqYHNHB8BG1Mx4kROFu0plGscb7Hg7UnI3+/
	 rMQVgtwsKDw203F11uFontwi+hW73zvliTJJ1lpdE1w8pLHnjHUn2Yt8VZASSqqnPk
	 hw8Tyf3sisVUmfNUUk3O2R0JdeXi66+FYUL1MDEc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407371AbfFKTEz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 15:04:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:41110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407324AbfFKTEx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 15:04:53 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E77E52183F;
        Tue, 11 Jun 2019 19:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560279892;
        bh=JoBDITOzsUeAVXcmHQ2oOTmpx8aYoN/GqDhn0GvFB30=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PQYp0z+buaz8ZJcbOVl45b5dhHKpLErNeMGk9krS2ecTY0pV8QMCRXeG5WEq5/6KQ
         ga9Dsxep6OWI5Om6oyXlN5hd01MPHsr0854sQRg/8AsHBVZ4JJz6bv2K1zSzeEiGM6
         2n4g6g+MoR12C63AyN4OR6CcHRbBq95lSv1h3ONI=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jin Yao <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>
Subject: [PATCH 80/85] perf tests: Add a test for time-utils
Date:   Tue, 11 Jun 2019 15:59:06 -0300
Message-Id: <20190611185911.11645-81-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190611185911.11645-1-acme@kernel.org>
References: <20190611185911.11645-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Hunter <adrian.hunter@intel.com>

Test time ranges work as expected.

Committer testing:

  $ perf test "time utils"
  59: time utils                                            : Ok
  $ perf test -v "time utils"
  59: time utils                                            :
  --- start ---
  test child forked, pid 31711

  parse_nsec_time("0")
  0

  parse_nsec_time("1")
  1000000000

  parse_nsec_time("0.000000001")
  1

  parse_nsec_time("1.000000001")
  1000000001

  parse_nsec_time("123456.123456")
  123456123456000

  parse_nsec_time("1234567.123456789")
  1234567123456789

  parse_nsec_time("18446744073.709551615")
  18446744073709551615

  perf_time__parse_str("1234567.123456789,1234567.123456789")
  start time 1234567123456789, end time 1234567123456789

  perf_time__parse_str("1234567.123456789,1234567.123456790")
  start time 1234567123456789, end time 1234567123456790

  perf_time__parse_str("1234567.123456789,")
  start time 1234567123456789, end time 0

  perf_time__parse_str(",1234567.123456789")
  start time 0, end time 1234567123456789

  perf_time__parse_str("0,1234567.123456789")
  start time 0, end time 1234567123456789

  perf_time__parse_for_ranges("1234567.123456789,1234567.123456790")
  start time 1234567123456789, end time 1234567123456790

  perf_time__parse_for_ranges("10%/1")
  first_sample_time 7654321000000000 last_sample_time 7654321000000100
  start time 0: 7654321000000000, end time 0: 7654321000000009

  perf_time__parse_for_ranges("10%/2")
  first_sample_time 7654321000000000 last_sample_time 7654321000000100
  start time 0: 7654321000000010, end time 0: 7654321000000019

  perf_time__parse_for_ranges("10%/1,10%/2")
  first_sample_time 11223344000000000 last_sample_time 11223344000000100
  start time 0: 11223344000000000, end time 0: 11223344000000009
  start time 1: 11223344000000010, end time 1: 11223344000000019

  perf_time__parse_for_ranges("10%/1,10%/3,10%/10")
  first_sample_time 11223344000000000 last_sample_time 11223344000000100
  start time 0: 11223344000000000, end time 0: 11223344000000009
  start time 1: 11223344000000020, end time 1: 11223344000000029
  start time 2: 11223344000000090, end time 2: 11223344000000100

  test child finished with 0
  ---- end ----
  time utils: Ok
  $

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190604130017.31207-19-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/Build             |   1 +
 tools/perf/tests/builtin-test.c    |   4 +
 tools/perf/tests/tests.h           |   1 +
 tools/perf/tests/time-utils-test.c | 234 +++++++++++++++++++++++++++++
 4 files changed, 240 insertions(+)
 create mode 100644 tools/perf/tests/time-utils-test.c

diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index 4afb6319ed51..e3ba63cef01e 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -51,6 +51,7 @@ perf-y += clang.o
 perf-y += unit_number__scnprintf.o
 perf-y += mem2node.o
 perf-y += map_groups.o
+perf-y += time-utils-test.o
 
 $(OUTPUT)tests/llvm-src-base.c: tests/bpf-script-example.c tests/Build
 	$(call rule_mkdir)
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 941c5456d625..cd72ff0f7658 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -289,6 +289,10 @@ static struct test generic_tests[] = {
 		.desc = "mem2node",
 		.func = test__mem2node,
 	},
+	{
+		.desc = "time utils",
+		.func = test__time_utils,
+	},
 	{
 		.desc = "map_groups__merge_in",
 		.func = test__map_groups__merge_in,
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index e5e3a57cd373..72912eb473cb 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -108,6 +108,7 @@ int test__clang_subtest_get_nr(void);
 int test__unit_number__scnprint(struct test *test, int subtest);
 int test__mem2node(struct test *t, int subtest);
 int test__map_groups__merge_in(struct test *t, int subtest);
+int test__time_utils(struct test *t, int subtest);
 
 bool test__bp_signal_is_supported(void);
 bool test__wp_is_supported(void);
diff --git a/tools/perf/tests/time-utils-test.c b/tools/perf/tests/time-utils-test.c
new file mode 100644
index 000000000000..7504046b111c
--- /dev/null
+++ b/tools/perf/tests/time-utils-test.c
@@ -0,0 +1,234 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/compiler.h>
+#include <linux/time64.h>
+#include <inttypes.h>
+#include <string.h>
+#include "time-utils.h"
+#include "evlist.h"
+#include "session.h"
+#include "debug.h"
+#include "tests.h"
+
+static bool test__parse_nsec_time(const char *str, u64 expected)
+{
+	u64 ptime;
+	int err;
+
+	pr_debug("\nparse_nsec_time(\"%s\")\n", str);
+
+	err = parse_nsec_time(str, &ptime);
+	if (err) {
+		pr_debug("error %d\n", err);
+		return false;
+	}
+
+	if (ptime != expected) {
+		pr_debug("Failed. ptime %" PRIu64 " expected %" PRIu64 "\n",
+			 ptime, expected);
+		return false;
+	}
+
+	pr_debug("%" PRIu64 "\n", ptime);
+
+	return true;
+}
+
+static bool test__perf_time__parse_str(const char *ostr, u64 start, u64 end)
+{
+	struct perf_time_interval ptime;
+	int err;
+
+	pr_debug("\nperf_time__parse_str(\"%s\")\n", ostr);
+
+	err = perf_time__parse_str(&ptime, ostr);
+	if (err) {
+		pr_debug("Error %d\n", err);
+		return false;
+	}
+
+	if (ptime.start != start || ptime.end != end) {
+		pr_debug("Failed. Expected %" PRIu64 " to %" PRIu64 "\n",
+			 start, end);
+		return false;
+	}
+
+	return true;
+}
+
+#define TEST_MAX 64
+
+struct test_data {
+	const char *str;
+	u64 first;
+	u64 last;
+	struct perf_time_interval ptime[TEST_MAX];
+	int num;
+	u64 skip[TEST_MAX];
+	u64 noskip[TEST_MAX];
+};
+
+static bool test__perf_time__parse_for_ranges(struct test_data *d)
+{
+	struct perf_evlist evlist = {
+		.first_sample_time = d->first,
+		.last_sample_time = d->last,
+	};
+	struct perf_session session = { .evlist = &evlist };
+	struct perf_time_interval *ptime = NULL;
+	int range_size, range_num;
+	bool pass = false;
+	int i, err;
+
+	pr_debug("\nperf_time__parse_for_ranges(\"%s\")\n", d->str);
+
+	if (strchr(d->str, '%'))
+		pr_debug("first_sample_time %" PRIu64 " last_sample_time %" PRIu64 "\n",
+			 d->first, d->last);
+
+	err = perf_time__parse_for_ranges(d->str, &session, &ptime, &range_size,
+					  &range_num);
+	if (err) {
+		pr_debug("error %d\n", err);
+		goto out;
+	}
+
+	if (range_size < d->num || range_num != d->num) {
+		pr_debug("bad size: range_size %d range_num %d expected num %d\n",
+			 range_size, range_num, d->num);
+		goto out;
+	}
+
+	for (i = 0; i < d->num; i++) {
+		if (ptime[i].start != d->ptime[i].start ||
+		    ptime[i].end != d->ptime[i].end) {
+			pr_debug("bad range %d expected %" PRIu64 " to %" PRIu64 "\n",
+				 i, d->ptime[i].start, d->ptime[i].end);
+			goto out;
+		}
+	}
+
+	if (perf_time__ranges_skip_sample(ptime, d->num, 0)) {
+		pr_debug("failed to keep 0\n");
+		goto out;
+	}
+
+	for (i = 0; i < TEST_MAX; i++) {
+		if (d->skip[i] &&
+		    !perf_time__ranges_skip_sample(ptime, d->num, d->skip[i])) {
+			pr_debug("failed to skip %" PRIu64 "\n", d->skip[i]);
+			goto out;
+		}
+		if (d->noskip[i] &&
+		    perf_time__ranges_skip_sample(ptime, d->num, d->noskip[i])) {
+			pr_debug("failed to keep %" PRIu64 "\n", d->noskip[i]);
+			goto out;
+		}
+	}
+
+	pass = true;
+out:
+	free(ptime);
+	return pass;
+}
+
+int test__time_utils(struct test *t __maybe_unused, int subtest __maybe_unused)
+{
+	bool pass = true;
+
+	pass &= test__parse_nsec_time("0", 0);
+	pass &= test__parse_nsec_time("1", 1000000000ULL);
+	pass &= test__parse_nsec_time("0.000000001", 1);
+	pass &= test__parse_nsec_time("1.000000001", 1000000001ULL);
+	pass &= test__parse_nsec_time("123456.123456", 123456123456000ULL);
+	pass &= test__parse_nsec_time("1234567.123456789", 1234567123456789ULL);
+	pass &= test__parse_nsec_time("18446744073.709551615",
+				      0xFFFFFFFFFFFFFFFFULL);
+
+	pass &= test__perf_time__parse_str("1234567.123456789,1234567.123456789",
+					   1234567123456789ULL, 1234567123456789ULL);
+	pass &= test__perf_time__parse_str("1234567.123456789,1234567.123456790",
+					   1234567123456789ULL, 1234567123456790ULL);
+	pass &= test__perf_time__parse_str("1234567.123456789,",
+					   1234567123456789ULL, 0);
+	pass &= test__perf_time__parse_str(",1234567.123456789",
+					   0, 1234567123456789ULL);
+	pass &= test__perf_time__parse_str("0,1234567.123456789",
+					   0, 1234567123456789ULL);
+
+	{
+		u64 b = 1234567123456789ULL;
+		struct test_data d = {
+			.str   = "1234567.123456789,1234567.123456790",
+			.ptime = { {b, b + 1}, },
+			.num = 1,
+			.skip = { b - 1, b + 2, },
+			.noskip = { b, b + 1, },
+		};
+
+		pass &= test__perf_time__parse_for_ranges(&d);
+	}
+
+	{
+		u64 b = 7654321ULL * NSEC_PER_SEC;
+		struct test_data d = {
+			.str    = "10%/1",
+			.first  = b,
+			.last   = b + 100,
+			.ptime  = { {b, b + 9}, },
+			.num    = 1,
+			.skip   = { b - 1, b + 10, },
+			.noskip = { b, b + 9, },
+		};
+
+		pass &= test__perf_time__parse_for_ranges(&d);
+	}
+
+	{
+		u64 b = 7654321ULL * NSEC_PER_SEC;
+		struct test_data d = {
+			.str    = "10%/2",
+			.first  = b,
+			.last   = b + 100,
+			.ptime  = { {b + 10, b + 19}, },
+			.num    = 1,
+			.skip   = { b + 9, b + 20, },
+			.noskip = { b + 10, b + 19, },
+		};
+
+		pass &= test__perf_time__parse_for_ranges(&d);
+	}
+
+	{
+		u64 b = 11223344ULL * NSEC_PER_SEC;
+		struct test_data d = {
+			.str    = "10%/1,10%/2",
+			.first  = b,
+			.last   = b + 100,
+			.ptime  = { {b, b + 9}, {b + 10, b + 19}, },
+			.num    = 2,
+			.skip   = { b - 1, b + 20, },
+			.noskip = { b, b + 8, b + 9, b + 10, b + 11, b + 12, b + 19, },
+		};
+
+		pass &= test__perf_time__parse_for_ranges(&d);
+	}
+
+	{
+		u64 b = 11223344ULL * NSEC_PER_SEC;
+		struct test_data d = {
+			.str    = "10%/1,10%/3,10%/10",
+			.first  = b,
+			.last   = b + 100,
+			.ptime  = { {b, b + 9}, {b + 20, b + 29}, { b + 90, b + 100}, },
+			.num    = 3,
+			.skip   = { b - 1, b + 10, b + 19, b + 30, b + 89, b + 101 },
+			.noskip = { b, b + 9, b + 20, b + 29, b + 90, b + 100},
+		};
+
+		pass &= test__perf_time__parse_for_ranges(&d);
+	}
+
+	pr_debug("\n");
+
+	return pass ? 0 : TEST_FAIL;
+}
-- 
2.20.1

