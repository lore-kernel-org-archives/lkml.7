Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4790C5B578
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 02:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7369E2184E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 02:28:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562034501;
	bh=tIomsXKG3r8CfZK9jgMo11Xyz/N+kCfADAtMFsQdlqA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Pbc7pV6LqhfdWG1tU7jOX1+BDUsrnsNk+dCJKhG2M9a3Ldsb4fVHDS7/V9TWCvT/b
	 b9YVUxXD5N9wDNTQEv6gDlSvR7UXSxj2womVLgl1lQdim1/mD7/LUzYXsQM13uGF5s
	 t5qL2NEuiA81j2IRhiP7azqBNCUQLTFH0/ZBTsNM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727577AbfGBC2T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 22:28:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:40736 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727174AbfGBC2S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 22:28:18 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A614521841;
        Tue,  2 Jul 2019 02:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562034497;
        bh=tIomsXKG3r8CfZK9jgMo11Xyz/N+kCfADAtMFsQdlqA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YbLBhs0HcdY4Be/MUTgt9gowafoVBtV+dNyqMQqN3AICZxcToyBzorn9DU/zFQunx
         pKd/AXkYkqEcunC5tOdom0Tt/MqCeR/ChbtQUhDTaI5J8/aGpdNGi7Q5QMylbajKPl
         EumPFpau6cgYRZK3RtwKVxlzPBqFDCzjW4HwejhM=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 34/43] perf tools: Ditch rtrim(), use strim() from tools/lib
Date:   Mon,  1 Jul 2019 23:26:07 -0300
Message-Id: <20190702022616.1259-35-acme@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190702022616.1259-1-acme@kernel.org>
References: <20190702022616.1259-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Cleaning up a bit more tools/perf/util/ by using things we got from the
kernel and have in tools/lib/

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-7hluuoveryoicvkclshzjf1k@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/hists.c     |  3 ++-
 tools/perf/util/annotate.c         |  3 ++-
 tools/perf/util/header.c           |  6 +++---
 tools/perf/util/pmu.c              |  2 +-
 tools/perf/util/python-ext-sources |  1 +
 tools/perf/util/srcline.c          |  3 ++-
 tools/perf/util/string.c           | 23 -----------------------
 tools/perf/util/string2.h          |  2 --
 tools/perf/util/thread_map.c       |  3 ++-
 9 files changed, 13 insertions(+), 33 deletions(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 10243408f3dc..33e67aa91347 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -2071,7 +2071,8 @@ static int hist_browser__fprintf_hierarchy_entry(struct hist_browser *browser,
 		advance_hpp(&hpp, ret);
 	}
 
-	printed += fprintf(fp, "%s\n", rtrim(s));
+	strim(s);
+	printed += fprintf(fp, "%s\n", s);
 
 	if (he->leaf && folded_sign == '-') {
 		printed += hist_browser__fprintf_callchain(browser, he, fp,
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 783e2628cc8e..2d08c4b62c63 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -35,6 +35,7 @@
 #include <pthread.h>
 #include <linux/bitops.h>
 #include <linux/kernel.h>
+#include <linux/string.h>
 #include <bpf/libbpf.h>
 
 /* FIXME: For the HE_COLORSET */
@@ -1495,7 +1496,7 @@ static int symbol__parse_objdump_line(struct symbol *sym, FILE *file,
 		return -1;
 
 	line_ip = -1;
-	parsed_line = rtrim(line);
+	parsed_line = strim(line);
 
 	/* /filename:linenr ? Save line number and ignore. */
 	if (regexec(&file_lineno, parsed_line, 2, match, 0) == 0) {
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 1eb15f7517b0..bf26dc85eaaa 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1048,7 +1048,7 @@ static int cpu_cache_level__read(struct cpu_cache_level *cache, u32 cpu, u16 lev
 		return -1;
 
 	cache->type[len] = 0;
-	cache->type = rtrim(cache->type);
+	cache->type = strim(cache->type);
 
 	scnprintf(file, PATH_MAX, "%s/size", path);
 	if (sysfs__read_str(file, &cache->size, &len)) {
@@ -1057,7 +1057,7 @@ static int cpu_cache_level__read(struct cpu_cache_level *cache, u32 cpu, u16 lev
 	}
 
 	cache->size[len] = 0;
-	cache->size = rtrim(cache->size);
+	cache->size = strim(cache->size);
 
 	scnprintf(file, PATH_MAX, "%s/shared_cpu_list", path);
 	if (sysfs__read_str(file, &cache->map, &len)) {
@@ -1067,7 +1067,7 @@ static int cpu_cache_level__read(struct cpu_cache_level *cache, u32 cpu, u16 lev
 	}
 
 	cache->map[len] = 0;
-	cache->map = rtrim(cache->map);
+	cache->map = strim(cache->map);
 	return 0;
 }
 
diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 38dc0c6e28b8..8139a1f3ed39 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -395,7 +395,7 @@ static int perf_pmu__new_alias(struct list_head *list, char *dir, char *name, FI
 	buf[ret] = 0;
 
 	/* Remove trailing newline from sysfs file */
-	rtrim(buf);
+	strim(buf);
 
 	return __perf_pmu__new_alias(list, dir, name, NULL, buf, NULL, NULL, NULL,
 				     NULL, NULL, NULL);
diff --git a/tools/perf/util/python-ext-sources b/tools/perf/util/python-ext-sources
index 648bcd80b475..2237bac9fadb 100644
--- a/tools/perf/util/python-ext-sources
+++ b/tools/perf/util/python-ext-sources
@@ -16,6 +16,7 @@ util/namespaces.c
 ../lib/bitmap.c
 ../lib/find_bit.c
 ../lib/hweight.c
+../lib/string.c
 ../lib/vsprintf.c
 util/thread_map.c
 util/util.c
diff --git a/tools/perf/util/srcline.c b/tools/perf/util/srcline.c
index 10ca1533937e..1824cabe3512 100644
--- a/tools/perf/util/srcline.c
+++ b/tools/perf/util/srcline.c
@@ -5,6 +5,7 @@
 #include <string.h>
 
 #include <linux/kernel.h>
+#include <linux/string.h>
 
 #include "util/dso.h"
 #include "util/util.h"
@@ -464,7 +465,7 @@ static struct inline_node *addr2inlines(const char *dso_name, u64 addr,
 		char *srcline;
 		struct symbol *inline_sym;
 
-		rtrim(funcname);
+		strim(funcname);
 
 		if (getline(&filename, &filelen, fp) == -1)
 			goto out;
diff --git a/tools/perf/util/string.c b/tools/perf/util/string.c
index 99a555ea4a9f..93a5340424df 100644
--- a/tools/perf/util/string.c
+++ b/tools/perf/util/string.c
@@ -318,29 +318,6 @@ char *strxfrchar(char *s, char from, char to)
 	return s;
 }
 
-/**
- * rtrim - Removes trailing whitespace from @s.
- * @s: The string to be stripped.
- *
- * Note that the first trailing whitespace is replaced with a %NUL-terminator
- * in the given string @s. Returns @s.
- */
-char *rtrim(char *s)
-{
-	size_t size = strlen(s);
-	char *end;
-
-	if (!size)
-		return s;
-
-	end = s + size - 1;
-	while (end >= s && isspace(*end))
-		end--;
-	*(end + 1) = '\0';
-
-	return s;
-}
-
 char *asprintf_expr_inout_ints(const char *var, bool in, size_t nints, int *ints)
 {
 	/*
diff --git a/tools/perf/util/string2.h b/tools/perf/util/string2.h
index 5bc3fea52cdc..6da835ad8f5b 100644
--- a/tools/perf/util/string2.h
+++ b/tools/perf/util/string2.h
@@ -23,8 +23,6 @@ static inline bool strisglob(const char *str)
 int strtailcmp(const char *s1, const char *s2);
 char *strxfrchar(char *s, char from, char to);
 
-char *rtrim(char *s);
-
 char *asprintf_expr_inout_ints(const char *var, bool in, size_t nints, int *ints);
 
 static inline char *asprintf_expr_in_ints(const char *var, size_t nints, int *ints)
diff --git a/tools/perf/util/thread_map.c b/tools/perf/util/thread_map.c
index 5d467d8ae9ab..281bf06f10f2 100644
--- a/tools/perf/util/thread_map.c
+++ b/tools/perf/util/thread_map.c
@@ -12,6 +12,7 @@
 #include "strlist.h"
 #include <string.h>
 #include <api/fs/fs.h>
+#include <linux/string.h>
 #include "asm/bug.h"
 #include "thread_map.h"
 #include "util.h"
@@ -392,7 +393,7 @@ static int get_comm(char **comm, pid_t pid)
 		 * mark the end of the string.
 		 */
 		(*comm)[size] = 0;
-		rtrim(*comm);
+		strim(*comm);
 	}
 
 	free(path);
-- 
2.20.1

