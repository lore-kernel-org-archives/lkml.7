Return-Path: <SRS0=QHyQ=ZU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC26C432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 13:41:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87C5B21787
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Nov 2019 13:41:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574948483;
	bh=Aa0oECrVA5qBTToYuctnSt1O62ukTrqomeZqD9+P00k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kbUVetV4IB2jt/rAmLsuQhDo+jhZYLQ4h+guI6YD2yurf1qUfDwU7PVacaAqaNHiX
	 gwJ7z7skO4URp74Imy8OaxjEfCE/GEizolHi/gz24I9dkING6IOwlqcJHj2EgvXlPO
	 IgWZshsrt6r0rFfxfjwEBhS2MeimTJhc8xf9Xi4M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727247AbfK1NlW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Nov 2019 08:41:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:37862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727040AbfK1NlU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Nov 2019 08:41:20 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D297A217D7;
        Thu, 28 Nov 2019 13:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574948479;
        bh=Aa0oECrVA5qBTToYuctnSt1O62ukTrqomeZqD9+P00k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EdsYGujnD70lhqgh6bRzgXx1e1w53iyDqGWT8DtJgToIVA5kjuNKj97ETxVs3DeQN
         7jaPAqBZEn3ZjQ7ZbQGar66itT0SWdjYoP++8VPi8no/252RBd0Vn76EP4u7ONb9eR
         /CFQOCU/n+A+3Oqv49ujSS+LEfuWs7Zg9LoNHrjI=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>
Subject: [PATCH 14/22] perf tests: Rename tests/map_groups.c to tests/maps.c
Date:   Thu, 28 Nov 2019 10:40:19 -0300
Message-Id: <20191128134027.23726-15-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191128134027.23726-1-acme@kernel.org>
References: <20191128134027.23726-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

One more step in mergint the maps and map_groups structs.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-bw6aagubqxc47m54k2maezfu@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/Build                    | 2 +-
 tools/perf/tests/builtin-test.c           | 4 ++--
 tools/perf/tests/{map_groups.c => maps.c} | 2 +-
 tools/perf/tests/tests.h                  | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)
 rename tools/perf/tests/{map_groups.c => maps.c} (97%)

diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index 5b9b0a813916..a3c595fba943 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -52,7 +52,7 @@ perf-y += perf-hooks.o
 perf-y += clang.o
 perf-y += unit_number__scnprintf.o
 perf-y += mem2node.o
-perf-y += map_groups.o
+perf-y += maps.o
 perf-y += time-utils-test.o
 
 $(OUTPUT)tests/llvm-src-base.c: tests/bpf-script-example.c tests/Build
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 3a4b9837b54d..7115aa32a51e 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -297,8 +297,8 @@ static struct test generic_tests[] = {
 		.func = test__time_utils,
 	},
 	{
-		.desc = "map_groups__merge_in",
-		.func = test__map_groups__merge_in,
+		.desc = "maps__merge_in",
+		.func = test__maps__merge_in,
 	},
 	{
 		.func = NULL,
diff --git a/tools/perf/tests/map_groups.c b/tools/perf/tests/maps.c
similarity index 97%
rename from tools/perf/tests/map_groups.c
rename to tools/perf/tests/maps.c
index 7febd02069ae..edcbc70ff9d6 100644
--- a/tools/perf/tests/map_groups.c
+++ b/tools/perf/tests/maps.c
@@ -33,7 +33,7 @@ static int check_maps(struct map_def *merged, unsigned int size, struct maps *ma
 	return TEST_OK;
 }
 
-int test__map_groups__merge_in(struct test *t __maybe_unused, int subtest __maybe_unused)
+int test__maps__merge_in(struct test *t __maybe_unused, int subtest __maybe_unused)
 {
 	struct maps maps;
 	unsigned int i;
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index f2b9bb024746..25aea387e2bf 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -107,7 +107,7 @@ const char *test__clang_subtest_get_desc(int subtest);
 int test__clang_subtest_get_nr(void);
 int test__unit_number__scnprint(struct test *test, int subtest);
 int test__mem2node(struct test *t, int subtest);
-int test__map_groups__merge_in(struct test *t, int subtest);
+int test__maps__merge_in(struct test *t, int subtest);
 int test__time_utils(struct test *t, int subtest);
 
 bool test__bp_signal_is_supported(void);
-- 
2.21.0

