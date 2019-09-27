Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD245C4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 21:11:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8086205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 21:11:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bFOi3DrN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbfI0VLw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 17:11:52 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:45370 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbfI0VLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 17:11:51 -0400
Received: by mail-pg1-f201.google.com with SMTP id x31so4348310pgl.12
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 14:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=dkFsjRwg8uc0hi8W20VO7PaEv8qpaPdYdvJejf9CiKI=;
        b=bFOi3DrNtqylr4NjyGI5UsRPjqQcj0J1WOWruVBZ3tfvSYDX6P106qu2x/fP1XcgLf
         qgX0KBTfJIMKVjwcpnI8rr8ABdAcKi2CZHi4aDhWkTC52pz03GcG9fVzfWslC/l2HT9O
         JbdUz6g/Jq/piGZUE98guSykYD6wXgV58DT33uAiFADB/LgwChL4SGahUeM2WLyP6JbE
         CsmSGSMvHkrNZzKb9CAIs2n9CgB9Ej1ZA60gJOh3vHJpJi7UeSYaLn86/WgYb2jFnqVX
         Of+Wm1zkklGJjWHhfCY8QIpivuov9sxTXtQCUe+VcMQmgYOg9lXpat4BMW/RY1WchktQ
         EVsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=dkFsjRwg8uc0hi8W20VO7PaEv8qpaPdYdvJejf9CiKI=;
        b=UpELGW8KXAsb+LvbTVDyyrWyamH/61i2TtIDG4XhS8qagOSmrb2+gb0eBq7hhzxtVF
         EgUnNqsuduejs/I79rVIOibIR8nfEJn/SqzLWPyT2imbvqRRt7DyDLe3XYHV3g1CMhqJ
         F/3lTJ6YXNphnYN52PM347KR3LmqtuT4fpT6FueiT5Xhzr/CI3/lXxyt/hk29u6XoVcO
         wVfufj1Zz3e9M7v461INn4LdgTn4n/6xOpCcgt7vb+2RjBR/j9N00rkzoczp6aIRWMTj
         0Ns7ziu5/on5vMmZfGc+J1USGz3DC/IIaM2wpTw4jFbRDJcKILMNcoU5X+L3zMXjuxix
         ybBA==
X-Gm-Message-State: APjAAAUIkq5D/XKqhr3aqQW1avIsrG5WWcuL2AlK3k5l2/HnIRJ5rO5D
        7T7QSXtRvr5LEvLCm1r1b2CPlpCnvTLZ
X-Google-Smtp-Source: APXvYqypzR/oeNVcLfIgdE0ndV/3k8MguWNoNB2Ozs8nN/yhc7wLoeQFH9DKpu8IV0BN77iiqb1dltq4JnvW
X-Received: by 2002:a63:e24:: with SMTP id d36mr11442670pgl.143.1569618709454;
 Fri, 27 Sep 2019 14:11:49 -0700 (PDT)
Date:   Fri, 27 Sep 2019 14:10:05 -0700
Message-Id: <20190927211005.147176-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.23.0.444.g18eeb5a265-goog
Subject: [PATCH] perf tools: avoid sample_reg_masks being const + weak
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Being const + weak breaks with some compilers that constant-propagate
from the weak symbol. This behavior is outside of the specification, but
in LLVM is chosen to match GCC's behavior.

LLVM's implementation was set in this patch:
https://github.com/llvm/llvm-project/commit/f49573d1eedcf1e44893d5a062ac1b72c8419646
A const + weak symbol is set to be weak_odr:
https://llvm.org/docs/LangRef.html
ODR is one definition rule, and given there is one constant definition
constant-propagation is possible. It is possible to get this code to
miscompile with LLVM when applying link time optimization. As compilers
become more aggressive, this is likely to break in more instances.

Move the definition of sample_reg_masks to the conditional part of
perf_regs.h and guard usage with HAVE_PERF_REGS_SUPPORT. This avoids the
weak symbol.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-regs-options.c | 4 ++++
 tools/perf/util/perf_regs.c          | 4 ----
 tools/perf/util/perf_regs.h          | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/parse-regs-options.c b/tools/perf/util/parse-regs-options.c
index ef46c2848808..a6a776597df8 100644
--- a/tools/perf/util/parse-regs-options.c
+++ b/tools/perf/util/parse-regs-options.c
@@ -46,18 +46,22 @@ __parse_regs(const struct option *opt, const char *str, int unset, bool intr)
 
 			if (!strcmp(s, "?")) {
 				fprintf(stderr, "available registers: ");
+#ifdef HAVE_PERF_REGS_SUPPORT
 				for (r = sample_reg_masks; r->name; r++) {
 					if (r->mask & mask)
 						fprintf(stderr, "%s ", r->name);
 				}
+#endif
 				fputc('\n', stderr);
 				/* just printing available regs */
 				return -1;
 			}
+#ifdef HAVE_PERF_REGS_SUPPORT
 			for (r = sample_reg_masks; r->name; r++) {
 				if ((r->mask & mask) && !strcasecmp(s, r->name))
 					break;
 			}
+#endif
 			if (!r->name) {
 				ui__warning("Unknown register \"%s\", check man page or run \"perf record %s?\"\n",
 					    s, intr ? "-I" : "--user-regs=");
diff --git a/tools/perf/util/perf_regs.c b/tools/perf/util/perf_regs.c
index 2774cec1f15f..5ee47ae1509c 100644
--- a/tools/perf/util/perf_regs.c
+++ b/tools/perf/util/perf_regs.c
@@ -3,10 +3,6 @@
 #include "perf_regs.h"
 #include "event.h"
 
-const struct sample_reg __weak sample_reg_masks[] = {
-	SMPL_REG_END
-};
-
 int __weak arch_sdt_arg_parse_op(char *old_op __maybe_unused,
 				 char **new_op __maybe_unused)
 {
diff --git a/tools/perf/util/perf_regs.h b/tools/perf/util/perf_regs.h
index 47fe34e5f7d5..e014c2c038f4 100644
--- a/tools/perf/util/perf_regs.h
+++ b/tools/perf/util/perf_regs.h
@@ -15,8 +15,6 @@ struct sample_reg {
 #define SMPL_REG2(n, b) { .name = #n, .mask = 3ULL << (b) }
 #define SMPL_REG_END { .name = NULL }
 
-extern const struct sample_reg sample_reg_masks[];
-
 enum {
 	SDT_ARG_VALID = 0,
 	SDT_ARG_SKIP,
@@ -27,6 +25,8 @@ uint64_t arch__intr_reg_mask(void);
 uint64_t arch__user_reg_mask(void);
 
 #ifdef HAVE_PERF_REGS_SUPPORT
+extern const struct sample_reg sample_reg_masks[];
+
 #include <perf_regs.h>
 
 #define DWARF_MINIMAL_REGS ((1ULL << PERF_REG_IP) | (1ULL << PERF_REG_SP))
-- 
2.23.0.444.g18eeb5a265-goog

