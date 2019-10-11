Return-Path: <SRS0=Osat=YE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E15BEECE58E
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3697218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Oct 2019 20:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570824390;
	bh=Ytqi3vr5NH3EPY/pcM1iQz7ZaiMgdSvbM02OXhfi070=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RrVHf7tpkIGd3FpV0kjl+vkyxXLlgIViC9PkBekQhnw5pVbn1N42C1WAoZK4Gn6EF
	 1uSecqnmQ/fhvuzq+fb0MM9Lut3zSuD+kkfeUTLWTth2lt9WBGayFQvfS5ODZgYBEy
	 0Ya8c2x3ALaVpTUzkDJd1rozNACuSIWSnmOwozlE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729111AbfJKUG3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Oct 2019 16:06:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:42848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728799AbfJKUG2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Oct 2019 16:06:28 -0400
Received: from quaco.ghostprotocols.net (189-94-137-67.3g.claro.net.br [189.94.137.67])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5BA2321A4A;
        Fri, 11 Oct 2019 20:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570824388;
        bh=Ytqi3vr5NH3EPY/pcM1iQz7ZaiMgdSvbM02OXhfi070=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kfBq5PmcqJ9oIcIIytRNnw45kG8/bGuYEKjm24DOEW76Gu3hNF0EB9NDjEfOgl++8
         ZYWKsZ6sGOLX3jk7dbjyUpSqCO19a306zZoyFgWCWsELUjby57qH+3Wje/i+Wt99qF
         qZVlz1ITnxTep617cWnHOg2Wks7T6cP3LHnkvTTU=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 01/69] perf env: Add routine to read the env->cpuid from the running machine
Date:   Fri, 11 Oct 2019 17:04:51 -0300
Message-Id: <20191011200559.7156-2-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191011200559.7156-1-acme@kernel.org>
References: <20191011200559.7156-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

In 'perf top' we use that cpuid when initializing the per arch
annotation init routines (e.g. x86__annotate_init()) and in that case
(live mode, 'perf top') we need to obtain it from the running machine,
not from a perf.data file header.

Provide a means to do that. Will be used by 'perf top' in a followup
patch.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-h2wb3sx7u7znx6lqfezrh7ca@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/env.c | 16 ++++++++++++++++
 tools/perf/util/env.h |  1 +
 2 files changed, 17 insertions(+)

diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index 3baca06786fb..2a91a10ccfcc 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -2,6 +2,7 @@
 #include "cpumap.h"
 #include "debug.h"
 #include "env.h"
+#include "util/header.h"
 #include <linux/ctype.h>
 #include <linux/zalloc.h>
 #include "bpf-event.h"
@@ -256,6 +257,21 @@ int perf_env__read_cpu_topology_map(struct perf_env *env)
 	return 0;
 }
 
+int perf_env__read_cpuid(struct perf_env *env)
+{
+	char cpuid[128];
+	int err = get_cpuid(cpuid, sizeof(cpuid));
+
+	if (err)
+		return err;
+
+	free(env->cpuid);
+	env->cpuid = strdup(cpuid);
+	if (env->cpuid == NULL)
+		return ENOMEM;
+	return 0;
+}
+
 static int perf_env__read_arch(struct perf_env *env)
 {
 	struct utsname uts;
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index db40906e2937..a3059dc1abe5 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -104,6 +104,7 @@ void perf_env__exit(struct perf_env *env);
 
 int perf_env__set_cmdline(struct perf_env *env, int argc, const char *argv[]);
 
+int perf_env__read_cpuid(struct perf_env *env);
 int perf_env__read_cpu_topology_map(struct perf_env *env);
 
 void cpu_cache_level__free(struct cpu_cache_level *cache);
-- 
2.21.0

