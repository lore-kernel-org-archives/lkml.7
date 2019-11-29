Return-Path: <SRS0=nTU8=ZV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5341EC432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 06:03:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FCC721835
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Nov 2019 06:03:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727277AbfK2GDn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Nov 2019 01:03:43 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48080 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbfK2GDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Nov 2019 01:03:07 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iaZMr-0008Ok-NR; Fri, 29 Nov 2019 07:03:01 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id CE4921C210E;
        Fri, 29 Nov 2019 07:02:53 +0100 (CET)
Date:   Fri, 29 Nov 2019 06:02:53 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf script: Move map__fprintf_srccode() to near
 its only user
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <tip-8cw846pudpxo0xdkvi9qnvrh@git.kernel.org>
References: <tip-8cw846pudpxo0xdkvi9qnvrh@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157500737372.21853.9455650845251179371.tip-bot2@tip-bot2>
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

Commit-ID:     540a63ea30c86b2785769b9ae713efbfa7547fde
Gitweb:        https://git.kernel.org/tip/540a63ea30c86b2785769b9ae713efbfa7547fde
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Fri, 22 Nov 2019 12:39:06 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 26 Nov 2019 11:07:45 -03:00

perf script: Move map__fprintf_srccode() to near its only user

No need to have it elsewhere.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-8cw846pudpxo0xdkvi9qnvrh@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-script.c | 42 ++++++++++++++++++++++++++++++++++-
 tools/perf/util/map.c       | 45 +------------------------------------
 tools/perf/util/map.h       |  5 +----
 3 files changed, 42 insertions(+), 50 deletions(-)

diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index f86c5cc..7b2f092 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -932,6 +932,48 @@ static int grab_bb(u8 *buffer, u64 start, u64 end,
 	return len;
 }
 
+static int map__fprintf_srccode(struct map *map, u64 addr, FILE *fp, struct srccode_state *state)
+{
+	char *srcfile;
+	int ret = 0;
+	unsigned line;
+	int len;
+	char *srccode;
+
+	if (!map || !map->dso)
+		return 0;
+	srcfile = get_srcline_split(map->dso,
+				    map__rip_2objdump(map, addr),
+				    &line);
+	if (!srcfile)
+		return 0;
+
+	/* Avoid redundant printing */
+	if (state &&
+	    state->srcfile &&
+	    !strcmp(state->srcfile, srcfile) &&
+	    state->line == line) {
+		free(srcfile);
+		return 0;
+	}
+
+	srccode = find_sourceline(srcfile, line, &len);
+	if (!srccode)
+		goto out_free_line;
+
+	ret = fprintf(fp, "|%-8d %.*s", line, len, srccode);
+
+	if (state) {
+		state->srcfile = srcfile;
+		state->line = line;
+	}
+	return ret;
+
+out_free_line:
+	free(srcfile);
+	return ret;
+}
+
 static int print_srccode(struct thread *thread, u8 cpumode, uint64_t addr)
 {
 	struct addr_location al;
diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index 744bfba..b59944e 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -433,51 +433,6 @@ int map__fprintf_srcline(struct map *map, u64 addr, const char *prefix,
 	return ret;
 }
 
-int map__fprintf_srccode(struct map *map, u64 addr,
-			 FILE *fp,
-			 struct srccode_state *state)
-{
-	char *srcfile;
-	int ret = 0;
-	unsigned line;
-	int len;
-	char *srccode;
-
-	if (!map || !map->dso)
-		return 0;
-	srcfile = get_srcline_split(map->dso,
-				    map__rip_2objdump(map, addr),
-				    &line);
-	if (!srcfile)
-		return 0;
-
-	/* Avoid redundant printing */
-	if (state &&
-	    state->srcfile &&
-	    !strcmp(state->srcfile, srcfile) &&
-	    state->line == line) {
-		free(srcfile);
-		return 0;
-	}
-
-	srccode = find_sourceline(srcfile, line, &len);
-	if (!srccode)
-		goto out_free_line;
-
-	ret = fprintf(fp, "|%-8d %.*s", line, len, srccode);
-
-	if (state) {
-		state->srcfile = srcfile;
-		state->line = line;
-	}
-	return ret;
-
-out_free_line:
-	free(srcfile);
-	return ret;
-}
-
-
 void srccode_state_free(struct srccode_state *state)
 {
 	zfree(&state->srcfile);
diff --git a/tools/perf/util/map.h b/tools/perf/util/map.h
index 5e88998..1f110b5 100644
--- a/tools/perf/util/map.h
+++ b/tools/perf/util/map.h
@@ -138,11 +138,6 @@ char *map__srcline(struct map *map, u64 addr, struct symbol *sym);
 int map__fprintf_srcline(struct map *map, u64 addr, const char *prefix,
 			 FILE *fp);
 
-struct srccode_state;
-
-int map__fprintf_srccode(struct map *map, u64 addr,
-			 FILE *fp, struct srccode_state *state);
-
 int map__load(struct map *map);
 struct symbol *map__find_symbol(struct map *map, u64 addr);
 struct symbol *map__find_symbol_by_name(struct map *map, const char *name);
