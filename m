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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68DAFC388F3
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 21:43:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E0422146E
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 21:43:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GJuCBEcE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728303AbfI0Vnq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 17:43:46 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:37834 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725990AbfI0Vnq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 17:43:46 -0400
Received: by mail-pl1-f201.google.com with SMTP id p15so2423277plq.4
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 14:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=D8aBLTyIrZ2ICD8Hi8xvO4ekFBS+GlIKOznJGgCgK/4=;
        b=GJuCBEcENrSQSukgNVyUy1PfbvScVMqJLdJyhT0jtk5AACpZ72QbZXapBDmy5VEbjl
         YG8qxEgx9QFhuVI01IlKcfp19s6wFOTEAtrU0tWbKmIdtKhblnOeUba+3xAer7foCNMr
         RSTj0qPz692w1wpHLSPKgNAQ488nKfMCDoAyoUQizMSWcjh4H5i9zzpDb4yoi3dnnQa+
         0rdWUDRMkoxarvl8LL240gqQrGTR55BOagF57V5NZqxpIp/d+PcMWD6P3Vvr5FqzL/tn
         2/Y4x4cucdmmge5dBAJ43bqCXK1+iR6Pgh67qiRuRJwLSCY1NmYDUc4vwkQgAC3mmY/u
         QI3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=D8aBLTyIrZ2ICD8Hi8xvO4ekFBS+GlIKOznJGgCgK/4=;
        b=Pc3pCWJGyM3Eutj469krfrj8FRBv6V6Dj5B3cIUUTP6GW1dPQD3FmszWrpKykMx3CY
         IvV7ToNQm/t22sxqsTZeILFB5Kk6NVXGwtTwYr928H0GaG6aknb5SpY+tNw1Oyzodrge
         ayuR3T9FfbtcaO+Nhv0TFokEtjH4EOv6WOzXGmO0DBzlgjGpGmKBrdmJddz+IEwr1GvM
         tX0rSsaRTxX7ua7Mg2EjUmFUJVUGN6Yq+q4mpxs7sS1ZrnWNiSDfiAwjUkO4P5ScMCvz
         ti0BiDqUyu8kgLFDTWwdUU0KxhHqyzDGs/PzsDT2CuVOspo6A39wJo7JjpyzyrvpO2gZ
         pYYA==
X-Gm-Message-State: APjAAAU5TZY5EqnWPu8inoJ6QMCjMFo4WNtyWCPw1vjrufGDmMFP5yum
        QoQrWWaJfnDEtk4QFeZ7dUNKj/iUyERw
X-Google-Smtp-Source: APXvYqzGnRZGBVfAkAKfAxa17FuxLeyKyCCaYHxuF0fga1lsq+LXLIQtFV9Maii58dPu8DVPv2e6SvgAeuqa
X-Received: by 2002:a63:115c:: with SMTP id 28mr11390639pgr.69.1569620624933;
 Fri, 27 Sep 2019 14:43:44 -0700 (PDT)
Date:   Fri, 27 Sep 2019 14:43:41 -0700
In-Reply-To: <20190927211005.147176-1-irogers@google.com>
Message-Id: <20190927214341.170683-1-irogers@google.com>
Mime-Version: 1.0
References: <20190927211005.147176-1-irogers@google.com>
X-Mailer: git-send-email 2.23.0.444.g18eeb5a265-goog
Subject: [PATCH v2] perf tools: avoid sample_reg_masks being const + weak
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

Fix an issue when HAVE_PERF_REGS_SUPPORT isn't defined from patch v1.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/util/parse-regs-options.c | 8 ++++++--
 tools/perf/util/perf_regs.c          | 4 ----
 tools/perf/util/perf_regs.h          | 4 ++--
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/perf/util/parse-regs-options.c b/tools/perf/util/parse-regs-options.c
index ef46c2848808..e687497b3aac 100644
--- a/tools/perf/util/parse-regs-options.c
+++ b/tools/perf/util/parse-regs-options.c
@@ -13,7 +13,7 @@ static int
 __parse_regs(const struct option *opt, const char *str, int unset, bool intr)
 {
 	uint64_t *mode = (uint64_t *)opt->value;
-	const struct sample_reg *r;
+	const struct sample_reg *r = NULL;
 	char *s, *os = NULL, *p;
 	int ret = -1;
 	uint64_t mask;
@@ -46,19 +46,23 @@ __parse_regs(const struct option *opt, const char *str, int unset, bool intr)
 
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
-			if (!r->name) {
+#endif
+			if (!r || !r->name) {
 				ui__warning("Unknown register \"%s\", check man page or run \"perf record %s?\"\n",
 					    s, intr ? "-I" : "--user-regs=");
 				goto error;
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

