Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE104C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 08:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68A3B204EC
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 08:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Ff9IMOWC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728090AbfE3IMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 04:12:22 -0400
Received: from terminus.zytor.com ([198.137.202.136]:42721 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726945AbfE3IMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 04:12:21 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x4U8Bw1Q2904341
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 30 May 2019 01:11:58 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x4U8Bw1Q2904341
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019051801; t=1559203919;
        bh=p5xNmtbFJvBEltG9xZyreVPp91RIwVxEioSCRnhH2Rw=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Ff9IMOWCiBzhOn7JaugHGoZGmtGFGMxBkXp2NpyGSaZEuaNbdvqFncjILwsVQOT2r
         zDI37AdNyTzIsUEziBe0tK+qtpykGKco5gJ2bO7N+H3H0x5+mZH1sWTeQb0VvwLLWY
         DroawXBi30dePa9hMxGoE0tU+ug7LUgSn51e9/Uy4NqiZUUNY879pUd1bOW35C/Xa+
         /+m/gao7xGT/6yifYmWArSwIJaKag9l2yBkXbEhmDzVtr5rZB3GEanVZGQP1taqbEV
         y+9MkyhPyaAOoUcjUYDwAdB4ZVQ6Rcx/r24K7pmM/Kt+7qVR+mrY18bhUoG8cO2sRp
         Yt626qJT8JDwg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x4U8BwhW2904338;
        Thu, 30 May 2019 01:11:58 -0700
Date:   Thu, 30 May 2019 01:11:58 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Jiri Olsa <tipbot@zytor.com>
Message-ID: <tip-4f600bcf657d4d0476d0d96cb38077a72b8fb2af@git.kernel.org>
Cc:     alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        songliubraving@fb.com, adrian.hunter@intel.com,
        linux-kernel@vger.kernel.org, jolsa@kernel.org, ak@linux.intel.com,
        sdf@google.com, acme@redhat.com, mingo@kernel.org,
        tglx@linutronix.de, peterz@infradead.org, hpa@zytor.com
Reply-To: adrian.hunter@intel.com, songliubraving@fb.com,
          namhyung@kernel.org, alexander.shishkin@linux.intel.com,
          hpa@zytor.com, peterz@infradead.org, tglx@linutronix.de,
          acme@redhat.com, mingo@kernel.org, sdf@google.com,
          ak@linux.intel.com, jolsa@kernel.org,
          linux-kernel@vger.kernel.org
In-Reply-To: <20190508132010.14512-10-jolsa@kernel.org>
References: <20190508132010.14512-10-jolsa@kernel.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tests: Add map_groups__merge_in test
Git-Commit-ID: 4f600bcf657d4d0476d0d96cb38077a72b8fb2af
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

Commit-ID:  4f600bcf657d4d0476d0d96cb38077a72b8fb2af
Gitweb:     https://git.kernel.org/tip/4f600bcf657d4d0476d0d96cb38077a72b8fb2af
Author:     Jiri Olsa <jolsa@kernel.org>
AuthorDate: Wed, 8 May 2019 15:20:07 +0200
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 28 May 2019 18:37:44 -0300

perf tests: Add map_groups__merge_in test

Add map_groups__merge_in test to test the map_groups__merge_in function
usage - merging kcore maps into existing eBPF maps.

Committer testing:

  # perf test merge
  59: map_groups__merge_in                                  : Ok
  # perf test -v merge
  59: map_groups__merge_in                                  :
  --- start ---
  test child forked, pid 8349
  test child finished with 0
  ---- end ----
  map_groups__merge_in: Ok
  #

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Song Liu <songliubraving@fb.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stanislav Fomichev <sdf@google.com>
Link: http://lkml.kernel.org/r/20190508132010.14512-10-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/Build          |   1 +
 tools/perf/tests/builtin-test.c |   4 ++
 tools/perf/tests/map_groups.c   | 120 ++++++++++++++++++++++++++++++++++++++++
 tools/perf/tests/tests.h        |   1 +
 tools/perf/util/map_groups.h    |   2 +
 tools/perf/util/symbol.c        |   2 +-
 6 files changed, 129 insertions(+), 1 deletion(-)

diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index 0b2b8305c965..4afb6319ed51 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -50,6 +50,7 @@ perf-y += perf-hooks.o
 perf-y += clang.o
 perf-y += unit_number__scnprintf.o
 perf-y += mem2node.o
+perf-y += map_groups.o
 
 $(OUTPUT)tests/llvm-src-base.c: tests/bpf-script-example.c tests/Build
 	$(call rule_mkdir)
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 9852b5d624a5..941c5456d625 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -289,6 +289,10 @@ static struct test generic_tests[] = {
 		.desc = "mem2node",
 		.func = test__mem2node,
 	},
+	{
+		.desc = "map_groups__merge_in",
+		.func = test__map_groups__merge_in,
+	},
 	{
 		.func = NULL,
 	},
diff --git a/tools/perf/tests/map_groups.c b/tools/perf/tests/map_groups.c
new file mode 100644
index 000000000000..70d96acc6dcf
--- /dev/null
+++ b/tools/perf/tests/map_groups.c
@@ -0,0 +1,120 @@
+#include <linux/compiler.h>
+#include <linux/kernel.h>
+#include "tests.h"
+#include "map.h"
+#include "map_groups.h"
+#include "dso.h"
+#include "debug.h"
+
+struct map_def {
+	const char *name;
+	u64 start;
+	u64 end;
+};
+
+static int check_maps(struct map_def *merged, unsigned int size, struct map_groups *mg)
+{
+	struct map *map;
+	unsigned int i = 0;
+
+	map = map_groups__first(mg);
+	while (map) {
+		TEST_ASSERT_VAL("wrong map start",  map->start == merged[i].start);
+		TEST_ASSERT_VAL("wrong map end",    map->end == merged[i].end);
+		TEST_ASSERT_VAL("wrong map name",  !strcmp(map->dso->name, merged[i].name));
+		TEST_ASSERT_VAL("wrong map refcnt", refcount_read(&map->refcnt) == 2);
+
+		i++;
+		map = map_groups__next(map);
+
+		TEST_ASSERT_VAL("less maps expected", (map && i < size) || (!map && i == size));
+	}
+
+	return TEST_OK;
+}
+
+int test__map_groups__merge_in(struct test *t __maybe_unused, int subtest __maybe_unused)
+{
+	struct map_groups mg;
+	unsigned int i;
+	struct map_def bpf_progs[] = {
+		{ "bpf_prog_1", 200, 300 },
+		{ "bpf_prog_2", 500, 600 },
+		{ "bpf_prog_3", 800, 900 },
+	};
+	struct map_def merged12[] = {
+		{ "kcore1",     100,  200 },
+		{ "bpf_prog_1", 200,  300 },
+		{ "kcore1",     300,  500 },
+		{ "bpf_prog_2", 500,  600 },
+		{ "kcore1",     600,  800 },
+		{ "bpf_prog_3", 800,  900 },
+		{ "kcore1",     900, 1000 },
+	};
+	struct map_def merged3[] = {
+		{ "kcore1",      100,  200 },
+		{ "bpf_prog_1",  200,  300 },
+		{ "kcore1",      300,  500 },
+		{ "bpf_prog_2",  500,  600 },
+		{ "kcore1",      600,  800 },
+		{ "bpf_prog_3",  800,  900 },
+		{ "kcore1",      900, 1000 },
+		{ "kcore3",     1000, 1100 },
+	};
+	struct map *map_kcore1, *map_kcore2, *map_kcore3;
+	int ret;
+
+	map_groups__init(&mg, NULL);
+
+	for (i = 0; i < ARRAY_SIZE(bpf_progs); i++) {
+		struct map *map;
+
+		map = dso__new_map(bpf_progs[i].name);
+		TEST_ASSERT_VAL("failed to create map", map);
+
+		map->start = bpf_progs[i].start;
+		map->end   = bpf_progs[i].end;
+		map_groups__insert(&mg, map);
+		map__put(map);
+	}
+
+	map_kcore1 = dso__new_map("kcore1");
+	TEST_ASSERT_VAL("failed to create map", map_kcore1);
+
+	map_kcore2 = dso__new_map("kcore2");
+	TEST_ASSERT_VAL("failed to create map", map_kcore2);
+
+	map_kcore3 = dso__new_map("kcore3");
+	TEST_ASSERT_VAL("failed to create map", map_kcore3);
+
+	/* kcore1 map overlaps over all bpf maps */
+	map_kcore1->start = 100;
+	map_kcore1->end   = 1000;
+
+	/* kcore2 map hides behind bpf_prog_2 */
+	map_kcore2->start = 550;
+	map_kcore2->end   = 570;
+
+	/* kcore3 map hides behind bpf_prog_3, kcore1 and adds new map */
+	map_kcore3->start = 880;
+	map_kcore3->end   = 1100;
+
+	ret = map_groups__merge_in(&mg, map_kcore1);
+	TEST_ASSERT_VAL("failed to merge map", !ret);
+
+	ret = check_maps(merged12, ARRAY_SIZE(merged12), &mg);
+	TEST_ASSERT_VAL("merge check failed", !ret);
+
+	ret = map_groups__merge_in(&mg, map_kcore2);
+	TEST_ASSERT_VAL("failed to merge map", !ret);
+
+	ret = check_maps(merged12, ARRAY_SIZE(merged12), &mg);
+	TEST_ASSERT_VAL("merge check failed", !ret);
+
+	ret = map_groups__merge_in(&mg, map_kcore3);
+	TEST_ASSERT_VAL("failed to merge map", !ret);
+
+	ret = check_maps(merged3, ARRAY_SIZE(merged3), &mg);
+	TEST_ASSERT_VAL("merge check failed", !ret);
+	return TEST_OK;
+}
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 399f18ca71a3..e5e3a57cd373 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -107,6 +107,7 @@ const char *test__clang_subtest_get_desc(int subtest);
 int test__clang_subtest_get_nr(void);
 int test__unit_number__scnprint(struct test *test, int subtest);
 int test__mem2node(struct test *t, int subtest);
+int test__map_groups__merge_in(struct test *t, int subtest);
 
 bool test__bp_signal_is_supported(void);
 bool test__wp_is_supported(void);
diff --git a/tools/perf/util/map_groups.h b/tools/perf/util/map_groups.h
index 4dcda33e0fdf..5f25efa6d6bc 100644
--- a/tools/perf/util/map_groups.h
+++ b/tools/perf/util/map_groups.h
@@ -88,4 +88,6 @@ int map_groups__fixup_overlappings(struct map_groups *mg, struct map *map, FILE
 
 struct map *map_groups__find_by_name(struct map_groups *mg, const char *name);
 
+int map_groups__merge_in(struct map_groups *kmaps, struct map *new_map);
+
 #endif // __PERF_MAP_GROUPS_H
diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
index 29780fcd049c..f4540f8bbed1 100644
--- a/tools/perf/util/symbol.c
+++ b/tools/perf/util/symbol.c
@@ -1170,7 +1170,7 @@ static int kcore_mapfn(u64 start, u64 len, u64 pgoff, void *data)
  * Merges map into map_groups by splitting the new map
  * within the existing map regions.
  */
-static int map_groups__merge_in(struct map_groups *kmaps, struct map *new_map)
+int map_groups__merge_in(struct map_groups *kmaps, struct map *new_map)
 {
 	struct map *old_map;
 	LIST_HEAD(merged);
