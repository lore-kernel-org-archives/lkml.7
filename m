Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EB55C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 18:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E987720B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 18:37:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YYf8do1f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727015AbfJJShK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 14:37:10 -0400
Received: from mail-ua1-f74.google.com ([209.85.222.74]:54908 "EHLO
        mail-ua1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbfJJShJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 14:37:09 -0400
Received: by mail-ua1-f74.google.com with SMTP id t16so1830272uae.21
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 11:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=YaqmLQ2AmG5MkjwG1uKGGWEDcM1jBGJgalQWwTdiOWs=;
        b=YYf8do1f3iDFNkLZ4hwmKU/E4AYkle+bLps/g2ay7y0gnfk52HT8FdnOkfK6ICbEDM
         VZH9NkYoicUnW7n7dxiKmzVzOOU4CWfoxzRQ5y3vJjItnQoxXO3M7uzEoklc3jKsW0OH
         07zq5qmuyadRYb4BNSV0lPHqkOy2ejfsSnZ/ezxTLrp8twFkIPIWJobmZwTE4RYvTvTY
         3GzdmgJxYamPqkHnJ6x/iA+WBKtnCBihDnKKulB5nNbXvShPztZ1nutDNl6rgxq+CJZa
         OOi0dyBp/6rlZiDL8j/jVHfUDfYWHk+VwQFKKRTAFJKgui48SkDeuVGh8kSki2yqGvqW
         WbNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YaqmLQ2AmG5MkjwG1uKGGWEDcM1jBGJgalQWwTdiOWs=;
        b=P/MXCsFxa3Lt6zp+C88pY+tiWTpLYPv+IKWaK97vUSCiIWK/Rt4GfIr9wmYNoKykrW
         3cDEUk5yHm46wjXY3VFWIHhTO7BQp1VIBEWdNAPmDgXGMyOV2RdsFkCt5rwnOvslHpA3
         vWXpRUy01Vt8t2fSBN4xw19V5qzAUQUbJCaKhIqWvWO5qcOFn5ug4+8QLiauqsSRQ/j6
         ayYLludUq28gc3cYAbNCcBhSizIhh54muCgFgglYAmVW60KwsDII3Q7KHYlle+53WiBL
         +ipWGWYHcbdsUjaPHTplw0r0i44O9kgq+2/38yo36CxSPlKnaDdjyz/HVLGq+X+1sljE
         8ZbA==
X-Gm-Message-State: APjAAAW9f3lbMG+Z1b1tfqbxQUqES6Q+IT07qLvPr/rB+hg9JNzOobXt
        78G1F3bJxMffiX5vu5U/jomtX89pPVPE
X-Google-Smtp-Source: APXvYqzoASvBJv0R7BfZg5hWRZdTJFX9HCQxa/zym0o2mcryfQ0WJXyukLIlWVCMGByCb7Wx8GGG0HKGUMF4
X-Received: by 2002:a05:6122:2bb:: with SMTP id 27mr6331211vkq.66.1570732626969;
 Thu, 10 Oct 2019 11:37:06 -0700 (PDT)
Date:   Thu, 10 Oct 2019 11:36:45 -0700
In-Reply-To: <20191010183649.23768-1-irogers@google.com>
Message-Id: <20191010183649.23768-2-irogers@google.com>
Mime-Version: 1.0
References: <20191010183649.23768-1-irogers@google.com>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
Subject: [PATCH 1/5] perf annotate: avoid reallocation in objdump parsing
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        Song Liu <songliubraving@fb.com>, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Objdump output is parsed using getline which allocates memory for the
read. Getline will realloc if the memory is too small, but currently the
line is always freed after the call.
Simplify parse_objdump_line by performing the reading in symbol__disassemble.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/annotate.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index e830eadfca2a..1487849a191a 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1485,24 +1485,17 @@ annotation_line__print(struct annotation_line *al, struct symbol *sym, u64 start
  * means that it's not a disassembly line so should be treated differently.
  * The ops.raw part will be parsed further according to type of the instruction.
  */
-static int symbol__parse_objdump_line(struct symbol *sym, FILE *file,
+static int symbol__parse_objdump_line(struct symbol *sym,
 				      struct annotate_args *args,
-				      int *line_nr)
+				      char *line, int *line_nr)
 {
 	struct map *map = args->ms.map;
 	struct annotation *notes = symbol__annotation(sym);
 	struct disasm_line *dl;
-	char *line = NULL, *parsed_line, *tmp, *tmp2;
-	size_t line_len;
+	char *parsed_line, *tmp, *tmp2;
 	s64 line_ip, offset = -1;
 	regmatch_t match[2];
 
-	if (getline(&line, &line_len, file) < 0)
-		return -1;
-
-	if (!line)
-		return -1;
-
 	line_ip = -1;
 	parsed_line = strim(line);
 
@@ -1539,7 +1532,6 @@ static int symbol__parse_objdump_line(struct symbol *sym, FILE *file,
 	args->ms.sym  = sym;
 
 	dl = disasm_line__new(args);
-	free(line);
 	(*line_nr)++;
 
 	if (dl == NULL)
@@ -1855,6 +1847,8 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 	int lineno = 0;
 	int nline;
 	pid_t pid;
+	char *line;
+	size_t line_len;
 	int err = dso__disassemble_filename(dso, symfs_filename, sizeof(symfs_filename));
 
 	if (err)
@@ -1943,18 +1937,26 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 		goto out_free_command;
 	}
 
+	/* Storage for getline. */
+	line = NULL;
+	line_len = 0;
+
 	nline = 0;
 	while (!feof(file)) {
+		if (getline(&line, &line_len, file) < 0 || !line)
+			break;
+
 		/*
 		 * The source code line number (lineno) needs to be kept in
 		 * across calls to symbol__parse_objdump_line(), so that it
 		 * can associate it with the instructions till the next one.
 		 * See disasm_line__new() and struct disasm_line::line_nr.
 		 */
-		if (symbol__parse_objdump_line(sym, file, args, &lineno) < 0)
+		if (symbol__parse_objdump_line(sym, args, line, &lineno) < 0)
 			break;
 		nline++;
 	}
+	free(line);
 
 	if (nline == 0)
 		pr_err("No output from %s\n", command);
-- 
2.23.0.581.g78d2f28ef7-goog

