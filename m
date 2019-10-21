Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A057BCA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:39:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69A932184C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571665163;
	bh=U1kW4rdyp2b7QyM7JeuaGWPn5+6mk5O/NbHdTpN5HEU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=BUHVFl4IyPnkwHrR5JWaaLES8XWIkIWtriGmYuet7qO9s+GQDFUeZz1To44Jk4bNy
	 IY0RPo+/zpxF9a90yugt5u360IJKFG+vPY7GaRaHbrWW2aJuHrFdYnAJ88fBEWIiZS
	 XVjIZrrYeiG6vcdlXr8pv3oG78LEyAjGRk+Xqi9k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729213AbfJUNjW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 09:39:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:40816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729166AbfJUNjR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 09:39:17 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E40FF21929;
        Mon, 21 Oct 2019 13:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571665156;
        bh=U1kW4rdyp2b7QyM7JeuaGWPn5+6mk5O/NbHdTpN5HEU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U1YADSV0F08pSlXvf2A+6RAbuSwckwM5n2DXj0IOKOHrioYHOUuA4sSi+ZRIWijbt
         SSmtmmqzdOcu8I+R4n912omf5g/rC5XbznT3b+WjSfG7qp1lirDgIBj5uvGAk4dD7v
         +p7HkjxRM9IkDfO1BjM/N+GqeneaaupC3KKEvZBU=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        Stephane Eranian <eranian@google.com>,
        clang-built-linux@googlegroups.com
Subject: [PATCH 10/57] perf annotate: Don't pipe objdump output through 'expand' command
Date:   Mon, 21 Oct 2019 10:37:47 -0300
Message-Id: <20191021133834.25998-11-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191021133834.25998-1-acme@kernel.org>
References: <20191021133834.25998-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ian Rogers <irogers@google.com>

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
 tools/perf/util/annotate.c | 95 ++++++++++++++++++++++++++++++--------
 1 file changed, 76 insertions(+), 19 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 0e052e253835..efc5bfef790a 100644
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
-- 
2.21.0

