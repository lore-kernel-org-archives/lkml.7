Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1D7AC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 18:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9312820B7C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 18:37:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OwXUXE5Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbfJJShQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 14:37:16 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:46342 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727040AbfJJShO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 14:37:14 -0400
Received: by mail-pf1-f202.google.com with SMTP id f2so5406471pfk.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 11:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=xR9Hy/PtpZZvM1f3o0+fyrvu2Chu4oRVLAVkvfu//jI=;
        b=OwXUXE5QduWZYg2DBS2zxKLQo4LfBQLij/AZXT3qyuWWqYYrZZwkFR7JUKUK98gTPT
         Myvgjm4HrXIuB7FSbAW/yy+kQj8gPCWFF6stZPqodBdyWqfp7zHKwm7rYFatJ6SWsaCl
         pWeuFGlI2G9VgEv8+c9LAfgOTXISh2n+3Vm9akwow5AeUYvjCiyokE/xZ1jXlbi/MK3f
         LKUtWxW8RlmAhxelwQCB/5Z0CRj9oy6XtcodJpUDapZI5eXtV+seeTG/DQU6uOEFieU2
         7salevjDgsjKlHiGfyDzjL9BaUioF8QhCCnyD9xWLLG4mR4pJ/E/uNToIgaP9rlId75l
         yLbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xR9Hy/PtpZZvM1f3o0+fyrvu2Chu4oRVLAVkvfu//jI=;
        b=hciy7KLEOWfVVWN77b8Sjp34ZVOzWofAA/kySqxHV03TUMsLNqT0P69Zd+JmUE/YSj
         mZxk4xXzqo1qjmK2jC50O6xlliDEKB20szNcAybLKdHhn2Y+zHogwIQz8QUUwutTaQbl
         nDc+OjZkVHPCdM59GiwvK9VyKT2de3B/+9Niu45cz2QVaJYz+FSu6w0Z9GN0Etle+k59
         A23N0MU9Yzvf9c+szQphzeyXNWs5vISLzPT+PBwugEvvdQRQ8NDHDBSa+tvh+j7m9Oja
         5/kTmTGw5OwLlyeMrh6AvfDT/zxZYK8S2qM3F+URL7q54hdpQs+b8RI12cbbKKfJgVaQ
         SrhQ==
X-Gm-Message-State: APjAAAVYRXWi6kjkN5vMYtGBAQLDP4xo0IMl1UnDPUpKI5A5tk82CVs/
        NWCtr6y+ZSsp1eqq0DIS0DxtAwLbU24U
X-Google-Smtp-Source: APXvYqy0Q6zXUuujp5P10iPqC8FDqPlyXXbh2u57l01QXOyim5yqLovBWp+VQ4WLPgw6lsNoyL9szl28advj
X-Received: by 2002:a63:1002:: with SMTP id f2mr12904242pgl.207.1570732632340;
 Thu, 10 Oct 2019 11:37:12 -0700 (PDT)
Date:   Thu, 10 Oct 2019 11:36:47 -0700
In-Reply-To: <20191010183649.23768-1-irogers@google.com>
Message-Id: <20191010183649.23768-4-irogers@google.com>
Mime-Version: 1.0
References: <20191010183649.23768-1-irogers@google.com>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
Subject: [PATCH 3/5] perf annotate: don't pipe objdump output through grep
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

Simplify the objdump command by not piping the output of objdump through
grep. Instead, drop lines that match the grep pattern during the reading
loop.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/annotate.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index fc12c5cfe112..0a7a6f3c55f4 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1894,7 +1894,7 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 	err = asprintf(&command,
 		 "%s %s%s --start-address=0x%016" PRIx64
 		 " --stop-address=0x%016" PRIx64
-		 " -l -d %s %s -C \"$1\" 2>/dev/null|grep -v \"$1:\"|expand",
+		 " -l -d %s %s -C \"$1\" 2>/dev/null|expand",
 		 opts->objdump_path ?: "objdump",
 		 opts->disassembler_style ? "-M " : "",
 		 opts->disassembler_style ?: "",
@@ -1940,9 +1940,16 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 
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
2.23.0.581.g78d2f28ef7-goog

