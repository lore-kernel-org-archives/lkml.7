Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EDC9C04A6B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 13:20:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07F1B216F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 13:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1557321648;
	bh=5xvsEecyHgVztrApRFhCWAVd1tx19w6gyuVzUhfdaaw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=S/HiobI52AtlaKqH+cU1hXoBxu1RPpSAiKYBAus1rYjd/iFUMev7HwD1S1tMLg0Ws
	 Ef7deYsSGXCUs5tO/MeKKIskn2tQAcLFW4VTy4AXkthrXE5WyKhticje4BlYcLd8nn
	 foIWbYEhc7TbUHXvgXZD1r5vp5L9qPe23RXk5pgU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728934AbfEHNUr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 May 2019 09:20:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43260 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727989AbfEHNUo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 May 2019 09:20:44 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2121C308620F;
        Wed,  8 May 2019 13:20:44 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-49.brq.redhat.com [10.40.204.49])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 92AFA10027D5;
        Wed,  8 May 2019 13:20:41 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Stanislav Fomichev <sdf@fomichev.me>,
        Song Liu <songliubraving@fb.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 09/12] perf tests: Add map_groups__merge_in test
Date:   Wed,  8 May 2019 15:20:07 +0200
Message-Id: <20190508132010.14512-10-jolsa@kernel.org>
In-Reply-To: <20190508132010.14512-1-jolsa@kernel.org>
References: <20190508132010.14512-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.42]); Wed, 08 May 2019 13:20:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adding map_groups__merge_in to test map_groups__merge_in
function usage - merging kcore maps into existing eBPF
maps.

Link: http://lkml.kernel.org/n/tip-dj6v01kbt4upvkw3hccmc3vp@git.kernel.org
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/tests/Build          |   1 +
 tools/perf/tests/builtin-test.c |   4 ++
 tools/perf/tests/map_groups.c   | 120 ++++++++++++++++++++++++++++++++
 tools/perf/tests/tests.h        |   1 +
 tools/perf/util/map_groups.h    |   2 +
 tools/perf/util/symbol.c        |   2 +-
 6 files changed, 129 insertions(+), 1 deletion(-)
 create mode 100644 tools/perf/tests/map_groups.c

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
-- 
2.20.1

