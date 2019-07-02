Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66CD9C5B578
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 02:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E94D21721
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 02:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1562034510;
	bh=DZsVK2DQCUnfnuRKldKCkEK4gm1f7fsG8FqBG3Ws5Ns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YFzhTreXe2G+qyNqQs1UaEAVIkjULuALNb0eqjHAaubsS1DkysUyaPFxuoYT8Sv7+
	 9w35073eGxHr5gi/efdmE2LLZY8RPgjMbAqvUoNIglbdfITeseb44dqD0FYVtr45ft
	 rDBetrFE5ygitpngc4rlAXanDFcbM9ajU5zcmSN0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727615AbfGBC22 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 22:28:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:40868 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727197AbfGBC21 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 22:28:27 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 33EF02173E;
        Tue,  2 Jul 2019 02:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562034505;
        bh=DZsVK2DQCUnfnuRKldKCkEK4gm1f7fsG8FqBG3Ws5Ns=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O7/XUF55ylUc2mK+hU8bzgIShXtLwkLkWTJLkthJY33GkZ3ZGnkyz/IeNdqzL7e7q
         atXmMPDQ2xCagIVBnaoW8kOLwccA1XYmQQ/MLe63V2WwEVs89bub60XGU7TGtuAgdj
         Rtxg092bAEAE0Kniv1LzEWLxDjNZqVYiqYBZSixs=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 37/43] tools lib: Move argv_{split,free} from tools/perf/util/
Date:   Mon,  1 Jul 2019 23:26:10 -0300
Message-Id: <20190702022616.1259-38-acme@kernel.org>
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

This came from the kernel lib/argv_split.c, so move it to
tools/lib/argv_split.c, to get it closer to the kernel structure.

We need to audit the usage of argv_split() to figure out if it is really
necessary to do have one allocation per argv[] entry, looking at one of
its users I guess that is not the case and we probably are even leaking
those allocations by not using argv_free() judiciously, for later.

With this we further remove stuff from tools/perf/util/, reducing the
perf specific codebase and encouraging other tools/ code to use these
routines so as to keep the style and constructs used with the kernel.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-j479s1ive9h75w5lfg16jroz@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/include/linux/string.h |   3 ++
 tools/lib/argv_split.c       | 100 +++++++++++++++++++++++++++++++++++
 tools/perf/MANIFEST          |   1 +
 tools/perf/util/Build        |   5 ++
 tools/perf/util/string.c     |  91 -------------------------------
 tools/perf/util/string2.h    |   2 -
 6 files changed, 109 insertions(+), 93 deletions(-)
 create mode 100644 tools/lib/argv_split.c

diff --git a/tools/include/linux/string.h b/tools/include/linux/string.h
index a76d4df10435..980cb9266718 100644
--- a/tools/include/linux/string.h
+++ b/tools/include/linux/string.h
@@ -7,6 +7,9 @@
 
 void *memdup(const void *src, size_t len);
 
+char **argv_split(const char *str, int *argcp);
+void argv_free(char **argv);
+
 int strtobool(const char *s, bool *res);
 
 /*
diff --git a/tools/lib/argv_split.c b/tools/lib/argv_split.c
new file mode 100644
index 000000000000..0a58ccf3f761
--- /dev/null
+++ b/tools/lib/argv_split.c
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Helper function for splitting a string into an argv-like array.
+ */
+
+#include <stdlib.h>
+#include <linux/kernel.h>
+#include <linux/ctype.h>
+#include <linux/string.h>
+
+static const char *skip_arg(const char *cp)
+{
+	while (*cp && !isspace(*cp))
+		cp++;
+
+	return cp;
+}
+
+static int count_argc(const char *str)
+{
+	int count = 0;
+
+	while (*str) {
+		str = skip_spaces(str);
+		if (*str) {
+			count++;
+			str = skip_arg(str);
+		}
+	}
+
+	return count;
+}
+
+/**
+ * argv_free - free an argv
+ * @argv - the argument vector to be freed
+ *
+ * Frees an argv and the strings it points to.
+ */
+void argv_free(char **argv)
+{
+	char **p;
+	for (p = argv; *p; p++) {
+		free(*p);
+		*p = NULL;
+	}
+
+	free(argv);
+}
+
+/**
+ * argv_split - split a string at whitespace, returning an argv
+ * @str: the string to be split
+ * @argcp: returned argument count
+ *
+ * Returns an array of pointers to strings which are split out from
+ * @str.  This is performed by strictly splitting on white-space; no
+ * quote processing is performed.  Multiple whitespace characters are
+ * considered to be a single argument separator.  The returned array
+ * is always NULL-terminated.  Returns NULL on memory allocation
+ * failure.
+ */
+char **argv_split(const char *str, int *argcp)
+{
+	int argc = count_argc(str);
+	char **argv = calloc(argc + 1, sizeof(*argv));
+	char **argvp;
+
+	if (argv == NULL)
+		goto out;
+
+	if (argcp)
+		*argcp = argc;
+
+	argvp = argv;
+
+	while (*str) {
+		str = skip_spaces(str);
+
+		if (*str) {
+			const char *p = str;
+			char *t;
+
+			str = skip_arg(str);
+
+			t = strndup(p, str-p);
+			if (t == NULL)
+				goto fail;
+			*argvp++ = t;
+		}
+	}
+	*argvp = NULL;
+
+out:
+	return argv;
+
+fail:
+	argv_free(argv);
+	return NULL;
+}
diff --git a/tools/perf/MANIFEST b/tools/perf/MANIFEST
index aac4c755d81b..6a5de44b2de9 100644
--- a/tools/perf/MANIFEST
+++ b/tools/perf/MANIFEST
@@ -7,6 +7,7 @@ tools/lib/traceevent
 tools/lib/api
 tools/lib/bpf
 tools/lib/subcmd
+tools/lib/argv_split.c
 tools/lib/ctype.c
 tools/lib/hweight.c
 tools/lib/rbtree.c
diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index b4dc6112138f..d3408a463060 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -20,6 +20,7 @@ perf-y += parse-events.o
 perf-y += perf_regs.o
 perf-y += path.o
 perf-y += print_binary.o
+perf-y += argv_split.o
 perf-y += rbtree.o
 perf-y += libstring.o
 perf-y += bitmap.o
@@ -209,6 +210,10 @@ $(OUTPUT)util/kallsyms.o: ../lib/symbol/kallsyms.c FORCE
 	$(call rule_mkdir)
 	$(call if_changed_dep,cc_o_c)
 
+$(OUTPUT)util/argv_split.o: ../lib/argv_split.c FORCE
+	$(call rule_mkdir)
+	$(call if_changed_dep,cc_o_c)
+
 $(OUTPUT)util/bitmap.o: ../lib/bitmap.c FORCE
 	$(call rule_mkdir)
 	$(call if_changed_dep,cc_o_c)
diff --git a/tools/perf/util/string.c b/tools/perf/util/string.c
index 9b7fbb0cbecd..52603876c548 100644
--- a/tools/perf/util/string.c
+++ b/tools/perf/util/string.c
@@ -69,97 +69,6 @@ s64 perf_atoll(const char *str)
 	return -1;
 }
 
-static const char *skip_arg(const char *cp)
-{
-	while (*cp && !isspace(*cp))
-		cp++;
-
-	return cp;
-}
-
-static int count_argc(const char *str)
-{
-	int count = 0;
-
-	while (*str) {
-		str = skip_spaces(str);
-		if (*str) {
-			count++;
-			str = skip_arg(str);
-		}
-	}
-
-	return count;
-}
-
-/**
- * argv_free - free an argv
- * @argv - the argument vector to be freed
- *
- * Frees an argv and the strings it points to.
- */
-void argv_free(char **argv)
-{
-	char **p;
-	for (p = argv; *p; p++) {
-		free(*p);
-		*p = NULL;
-	}
-
-	free(argv);
-}
-
-/**
- * argv_split - split a string at whitespace, returning an argv
- * @str: the string to be split
- * @argcp: returned argument count
- *
- * Returns an array of pointers to strings which are split out from
- * @str.  This is performed by strictly splitting on white-space; no
- * quote processing is performed.  Multiple whitespace characters are
- * considered to be a single argument separator.  The returned array
- * is always NULL-terminated.  Returns NULL on memory allocation
- * failure.
- */
-char **argv_split(const char *str, int *argcp)
-{
-	int argc = count_argc(str);
-	char **argv = calloc(argc + 1, sizeof(*argv));
-	char **argvp;
-
-	if (argv == NULL)
-		goto out;
-
-	if (argcp)
-		*argcp = argc;
-
-	argvp = argv;
-
-	while (*str) {
-		str = skip_spaces(str);
-
-		if (*str) {
-			const char *p = str;
-			char *t;
-
-			str = skip_arg(str);
-
-			t = strndup(p, str-p);
-			if (t == NULL)
-				goto fail;
-			*argvp++ = t;
-		}
-	}
-	*argvp = NULL;
-
-out:
-	return argv;
-
-fail:
-	argv_free(argv);
-	return NULL;
-}
-
 /* Character class matching */
 static bool __match_charclass(const char *pat, char c, const char **npat)
 {
diff --git a/tools/perf/util/string2.h b/tools/perf/util/string2.h
index 2696c3fcd780..708805f5573e 100644
--- a/tools/perf/util/string2.h
+++ b/tools/perf/util/string2.h
@@ -11,8 +11,6 @@ extern const char *graph_dotted_line;
 extern const char *dots;
 
 s64 perf_atoll(const char *str);
-char **argv_split(const char *str, int *argcp);
-void argv_free(char **argv);
 bool strglobmatch(const char *str, const char *pat);
 bool strglobmatch_nocase(const char *str, const char *pat);
 bool strlazymatch(const char *str, const char *pat);
-- 
2.20.1

