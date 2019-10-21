Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE4DCA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E10020679
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 13:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571665155;
	bh=JZUa/Ib4Pxv1sMHgAyxzLYmnWBZvmTVHtdwt5MakaiM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FSs2VOptl7Kg/cGhCSUs3/F5+gIjkwfMnnMOc2EZuZ7E8ph8SHs7DoZvB5mDqmg4Z
	 PKQv+/U89ISNpUQA2vkEWZTg4dZDH5XzqZ5cH3fsFf8exKQtDuejrhvV6Ox322WDP9
	 JOtcuceO7D/OsMivApW6dozhYmx7pWXb7RN4hoHg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729182AbfJUNjO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 09:39:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:40710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728076AbfJUNjM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 09:39:12 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0A305222D2;
        Mon, 21 Oct 2019 13:39:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571665152;
        bh=JZUa/Ib4Pxv1sMHgAyxzLYmnWBZvmTVHtdwt5MakaiM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j/HgQYS+pWrdAGbvVwJWlpANwXM+w5R3tcVKH8kwn1bbDZkDWnSkBFp/ZvyCPHidz
         yvAg1+l1ny2skYIdpWjOIolKK+nweHU1FX1wA46BocrdITqNL2z4VLHVCjwvhZwvr8
         a6oGyVZBbFbwGK1ZrHOTiOV0rEPXSoGy0Rxs/p3M=
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
Subject: [PATCH 09/57] perf annotate: Don't pipe objdump output through 'grep' command
Date:   Mon, 21 Oct 2019 10:37:46 -0300
Message-Id: <20191021133834.25998-10-acme@kernel.org>
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

Simplify the objdump command by not piping the output of objdump through
grep. Instead, drop lines that match the grep pattern during the reading
loop.

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
Link: http://lore.kernel.org/lkml/20191010183649.23768-4-irogers@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 9835666db5a7..0e052e253835 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1916,7 +1916,7 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 	err = asprintf(&command,
 		 "%s %s%s --start-address=0x%016" PRIx64
 		 " --stop-address=0x%016" PRIx64
-		 " -l -d %s %s -C \"$1\" 2>/dev/null|grep -v \"$1:\"|expand",
+		 " -l -d %s %s -C \"$1\" 2>/dev/null|expand",
 		 opts->objdump_path ?: "objdump",
 		 opts->disassembler_style ? "-M " : "",
 		 opts->disassembler_style ?: "",
@@ -1962,9 +1962,16 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 
 	nline = 0;
 	while (!feof(file)) {
+		const char *match;
+
 		if (getline(&line, &line_len, file) < 0 || !line)
 			break;
 
+		/* Skip lines containing "filename:" */
+		match = strstr(line, symfs_filename);
+		if (match && match[strlen(symfs_filename)] == ':')
+			continue;
+
 		/*
 		 * The source code line number (lineno) needs to be kept in
 		 * across calls to symbol__parse_objdump_line(), so that it
-- 
2.21.0

