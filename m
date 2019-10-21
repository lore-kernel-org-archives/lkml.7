Return-Path: <SRS0=qxzQ=YP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69131CA9EAF
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 00:04:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38A6120656
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Oct 2019 00:04:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387432AbfJVAEC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 20:04:02 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38895 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387405AbfJVAEA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 20:04:00 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iMgxM-0004Cq-KF; Tue, 22 Oct 2019 01:19:20 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 98B111C04D6;
        Tue, 22 Oct 2019 01:19:15 +0200 (CEST)
Date:   Mon, 21 Oct 2019 23:19:15 -0000
From:   "tip-bot2 for Ian Rogers" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf annotate: Don't pipe objdump output through
 'expand' command
Cc:     Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        Stephane Eranian <eranian@google.com>,
        clang-built-linux@googlegroups.com, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20191010183649.23768-5-irogers@google.com>
References: <20191010183649.23768-5-irogers@google.com>
MIME-Version: 1.0
Message-ID: <157169995527.29376.14837671211016252895.tip-bot2@tip-bot2>
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

Commit-ID:     b34b45eef16d814a93a52f2e76db803bb38939a0
Gitweb:        https://git.kernel.org/tip/b34b45eef16d814a93a52f2e76db803bb38939a0
Author:        Ian Rogers <irogers@google.com>
AuthorDate:    Thu, 10 Oct 2019 11:36:48 -07:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 15 Oct 2019 08:39:42 -03:00

perf annotate: Don't pipe objdump output through 'expand' command

Avoiding a pipe allows objdump command failures to surface.  Move to the
caller of symbol__parse_objdump_line the call to strim that removes
leading and trailing tabs.  Add a new expand_tabs function that if a tab
is present allocate a new line in which tabs are expanded.  In
symbol__parse_objdump_line the line had no leading spaces, so simplify
the line_ip processing.

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Song Liu <songliubraving@fb.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: clang-built-linux@googlegroups.com
Link: http://lore.kernel.org/lkml/20191010183649.23768-5-irogers@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 95 +++++++++++++++++++++++++++++--------
 1 file changed, 76 insertions(+), 19 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 0e052e2..efc5bfe 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1492,35 +1492,24 @@ annotation_line__print(struct annotation_line *al, struct symbol *sym, u64 start
  */
 static int symbol__parse_objdump_line(struct symbol *sym,
 				      struct annotate_args *args,
-				      char *line, int *line_nr)
+				      char *parsed_line, int *line_nr)
 {
 	struct map *map = args->ms.map;
 	struct annotation *notes = symbol__annotation(sym);
 	struct disasm_line *dl;
-	char *parsed_line, *tmp, *tmp2;
+	char *tmp;
 	s64 line_ip, offset = -1;
 	regmatch_t match[2];
 
-	line_ip = -1;
-	parsed_line = strim(line);
-
 	/* /filename:linenr ? Save line number and ignore. */
 	if (regexec(&file_lineno, parsed_line, 2, match, 0) == 0) {
 		*line_nr = atoi(parsed_line + match[1].rm_so);
 		return 0;
 	}
 
-	tmp = skip_spaces(parsed_line);
-	if (*tmp) {
-		/*
-		 * Parse hexa addresses followed by ':'
-		 */
-		line_ip = strtoull(tmp, &tmp2, 16);
-		if (*tmp2 != ':' || tmp == tmp2 || tmp2[1] == '\0')
-			line_ip = -1;
-	}
-
-	if (line_ip != -1) {
+	/* Process hex address followed by ':'. */
+	line_ip = strtoull(parsed_line, &tmp, 16);
+	if (parsed_line != tmp && tmp[0] == ':' && tmp[1] != '\0') {
 		u64 start = map__rip_2objdump(map, sym->start),
 		    end = map__rip_2objdump(map, sym->end);
 
@@ -1528,7 +1517,7 @@ static int symbol__parse_objdump_line(struct symbol *sym,
 		if ((u64)line_ip < start || (u64)line_ip >= end)
 			offset = -1;
 		else
-			parsed_line = tmp2 + 1;
+			parsed_line = tmp + 1;
 	}
 
 	args->offset  = offset;
@@ -1854,6 +1843,67 @@ static int symbol__disassemble_bpf(struct symbol *sym __maybe_unused,
 }
 #endif // defined(HAVE_LIBBFD_SUPPORT) && defined(HAVE_LIBBPF_SUPPORT)
 
+/*
+ * Possibly create a new version of line with tabs expanded. Returns the
+ * existing or new line, storage is updated if a new line is allocated. If
+ * allocation fails then NULL is returned.
+ */
+static char *expand_tabs(char *line, char **storage, size_t *storage_len)
+{
+	size_t i, src, dst, len, new_storage_len, num_tabs;
+	char *new_line;
+	size_t line_len = strlen(line);
+
+	for (num_tabs = 0, i = 0; i < line_len; i++)
+		if (line[i] == '\t')
+			num_tabs++;
+
+	if (num_tabs == 0)
+		return line;
+
+	/*
+	 * Space for the line and '\0', less the leading and trailing
+	 * spaces. Each tab may introduce 7 additional spaces.
+	 */
+	new_storage_len = line_len + 1 + (num_tabs * 7);
+
+	new_line = malloc(new_storage_len);
+	if (new_line == NULL) {
+		pr_err("Failure allocating memory for tab expansion\n");
+		return NULL;
+	}
+
+	/*
+	 * Copy regions starting at src and expand tabs. If there are two
+	 * adjacent tabs then 'src == i', the memcpy is of size 0 and the spaces
+	 * are inserted.
+	 */
+	for (i = 0, src = 0, dst = 0; i < line_len && num_tabs; i++) {
+		if (line[i] == '\t') {
+			len = i - src;
+			memcpy(&new_line[dst], &line[src], len);
+			dst += len;
+			new_line[dst++] = ' ';
+			while (dst % 8 != 0)
+				new_line[dst++] = ' ';
+			src = i + 1;
+			num_tabs--;
+		}
+	}
+
+	/* Expand the last region. */
+	len = line_len + 1 - src;
+	memcpy(&new_line[dst], &line[src], len);
+	dst += len;
+	new_line[dst] = '\0';
+
+	free(*storage);
+	*storage = new_line;
+	*storage_len = new_storage_len;
+	return new_line;
+
+}
+
 static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 {
 	struct annotation_options *opts = args->options;
@@ -1916,7 +1966,7 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 	err = asprintf(&command,
 		 "%s %s%s --start-address=0x%016" PRIx64
 		 " --stop-address=0x%016" PRIx64
-		 " -l -d %s %s -C \"$1\" 2>/dev/null|expand",
+		 " -l -d %s %s -C \"$1\" 2>/dev/null",
 		 opts->objdump_path ?: "objdump",
 		 opts->disassembler_style ? "-M " : "",
 		 opts->disassembler_style ?: "",
@@ -1963,6 +2013,7 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 	nline = 0;
 	while (!feof(file)) {
 		const char *match;
+		char *expanded_line;
 
 		if (getline(&line, &line_len, file) < 0 || !line)
 			break;
@@ -1972,13 +2023,19 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 		if (match && match[strlen(symfs_filename)] == ':')
 			continue;
 
+		expanded_line = strim(line);
+		expanded_line = expand_tabs(expanded_line, &line, &line_len);
+		if (!expanded_line)
+			break;
+
 		/*
 		 * The source code line number (lineno) needs to be kept in
 		 * across calls to symbol__parse_objdump_line(), so that it
 		 * can associate it with the instructions till the next one.
 		 * See disasm_line__new() and struct disasm_line::line_nr.
 		 */
-		if (symbol__parse_objdump_line(sym, args, line, &lineno) < 0)
+		if (symbol__parse_objdump_line(sym, args, expanded_line,
+					       &lineno) < 0)
 			break;
 		nline++;
 	}
