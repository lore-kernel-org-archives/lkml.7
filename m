Return-Path: <SRS0=5y3R=YD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F329C4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 18:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51267222C4
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Oct 2019 18:37:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Si0K657W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727110AbfJJShV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Oct 2019 14:37:21 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:41340 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727072AbfJJShT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Oct 2019 14:37:19 -0400
Received: by mail-pl1-f201.google.com with SMTP id q3so4390992pll.8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2019 11:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+OGMGqzbdua1JvnmjrGnKHeEWLFeUVoFJYkCdgpO3Hs=;
        b=Si0K657WqBNfzzombtJEqYD9VASpxzIMXDMNjaDeOBy+RFG8/Qs3Tg14berZ88Prc6
         4/N0N1BREZ9QFWp8wbVHkoGaJV+OVR6ATaEEDg7KBX7OvaZRD9UU9bz/nQ1VpOqA0n9S
         8eeR7yZLFH/UxhfUaLWSXFy3bVaweMOTegE6mMYZm5r9NkLVC6Vcuo7rTgoA0LaZP3a8
         bJ3TT0Egwz3NhuZdAm29i1aDTbUY8//zvlI3xJWGZEiM7+T17U3VxRUWA3O9uHzRP+9Q
         Ezq12OvlSBrdzwd3LudIJKZU1sx1AEJrYYG412E7LL5XmThm65Zwzz5L9NZJuPiylBLQ
         Gs1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+OGMGqzbdua1JvnmjrGnKHeEWLFeUVoFJYkCdgpO3Hs=;
        b=Qpv7U/D1ynz9ytRyCbLAqwPZzllzmIB9oeiqFQz9zExtUEdrypy3qVppoxjzhPnsX5
         MOu3G/UrWUdqlJ7ZkmphAvotJleYGfV+8ovCmR3bYCp4WzhI7/ARB8R+cihOIqSVyCdw
         03WRprZg80A/XeMZDbDAMuWZbCsX8SFABba+d6J7ONr4dnSvzM8TyUWZ9cofpCRI71Iz
         mEqXEqm5cYk0nc7wXdMF5jy1/sejfwesvyEa6Gj8hRwkhfthy07pxQS1JtQ8QzMQEmWI
         koOBQXssukRcWBwLw0GCYWPpZJlYAG3EQk+eY95uZI0Yeq5T2D6eOc33kQPbQNEJYeOF
         tYFA==
X-Gm-Message-State: APjAAAVFRQJjCDjhydHSjw6khml//jgTsMg8KTSWKg4FHWVbcyY1G8ym
        nPkFOXnyQhQmLZUo8i1GhJaI9vkdtxAl
X-Google-Smtp-Source: APXvYqyWLLZ50q7uviVNuXVKErM04P/Vd9axLWq91lNhBhfrDYvxqRIQHOHYYFeL8sr76Jo1J8Kk+RO5fw7K
X-Received: by 2002:a63:6a46:: with SMTP id f67mr12116929pgc.87.1570732637239;
 Thu, 10 Oct 2019 11:37:17 -0700 (PDT)
Date:   Thu, 10 Oct 2019 11:36:49 -0700
In-Reply-To: <20191010183649.23768-1-irogers@google.com>
Message-Id: <20191010183649.23768-6-irogers@google.com>
Mime-Version: 1.0
References: <20191010183649.23768-1-irogers@google.com>
X-Mailer: git-send-email 2.23.0.581.g78d2f28ef7-goog
Subject: [PATCH 5/5] perf annotate: fix objdump --no-show-raw-insn flag
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

Remove redirection of objdump's stderr to /dev/null to help diagnose
failures.
Fix the '--no-show-raw' flag to be '--no-show-raw-insn' which binutils
is permissive and allows, but fails with LLVM objdump.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/annotate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 3d5b9236576a..2a71c90a4921 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1944,13 +1944,13 @@ static int symbol__disassemble(struct symbol *sym, struct annotate_args *args)
 	err = asprintf(&command,
 		 "%s %s%s --start-address=0x%016" PRIx64
 		 " --stop-address=0x%016" PRIx64
-		 " -l -d %s %s -C \"$1\" 2>/dev/null",
+		 " -l -d %s %s -C \"$1\"",
 		 opts->objdump_path ?: "objdump",
 		 opts->disassembler_style ? "-M " : "",
 		 opts->disassembler_style ?: "",
 		 map__rip_2objdump(map, sym->start),
 		 map__rip_2objdump(map, sym->end),
-		 opts->show_asm_raw ? "" : "--no-show-raw",
+		 opts->show_asm_raw ? "" : "--no-show-raw-insn",
 		 opts->annotate_src ? "-S" : "");
 
 	if (err < 0) {
-- 
2.23.0.581.g78d2f28ef7-goog

