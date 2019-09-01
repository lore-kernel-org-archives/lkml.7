Return-Path: <SRS0=SHWF=W4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 117E7C3A5A4
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 12:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBEEF23711
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Sep 2019 12:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567340714;
	bh=26v+nufNwawHP+s2WlN9BNW1cG3ZnWNv47yZpxwCWy0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=E0qeyXO7TiD2cYRREBOko0IFRqSUhVH0woN9Equ+T4NB1nC3dlBCpg14kc/nZYUpy
	 nwoOASpUw0s6BuifeS9TcSDY276/9g4iNpjSBaCOBds8JjZH0drrLT28KPEJgmeeFp
	 v0YDMd4PUKMZZPYh93YcwPMohWT8/lL7Ag1optgM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729230AbfIAMZO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Sep 2019 08:25:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:42492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729217AbfIAMZK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Sep 2019 08:25:10 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B05352342E;
        Sun,  1 Sep 2019 12:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567340708;
        bh=26v+nufNwawHP+s2WlN9BNW1cG3ZnWNv47yZpxwCWy0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yubFHQLQSUX8QfYOLZMx68aTmKC7/eiakBPmYxUJeWwapRzywDgkrI0vbFYkfZrAw
         brnirDM2YfcXf9WeBwVRS/LPj1uoNCnf6oLFcqxOH/X3gwekHT0hUnQjFJFSwCclDW
         xlj5YjAe3aEcuHqMHiRG362vqDf0uz3AoBWgS7zE=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 32/47] perf tools: Remove needless thread.h include directives
Date:   Sun,  1 Sep 2019 09:23:11 -0300
Message-Id: <20190901122326.5793-33-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190901122326.5793-1-acme@kernel.org>
References: <20190901122326.5793-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

Now that thread.h isn't included by any other header, we can check where
it is really needed, i.e. we can remove it and be sure that it isn't
being obtained indirectly.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-kh333ivjbw05wsggckpziu86@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-annotate.c   | 1 -
 tools/perf/builtin-stat.c       | 1 -
 tools/perf/builtin-top.c        | 1 -
 tools/perf/tests/hists_filter.c | 1 -
 tools/perf/tests/hists_link.c   | 1 -
 tools/perf/util/arm-spe.c       | 1 -
 tools/perf/util/probe-event.c   | 1 -
 tools/perf/util/probe-file.c    | 1 -
 tools/perf/util/s390-cpumsf.c   | 1 -
 9 files changed, 9 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 738471a0a549..7135b77a18e7 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -24,7 +24,6 @@
 #include "util/event.h"
 #include <subcmd/parse-options.h>
 #include "util/parse-events.h"
-#include "util/thread.h"
 #include "util/sort.h"
 #include "util/hist.h"
 #include "util/dso.h"
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index fa4212dac9bb..7e17bf9f700a 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -54,7 +54,6 @@
 #include "util/stat.h"
 #include "util/header.h"
 #include "util/cpumap.h"
-#include "util/thread.h"
 #include "util/thread_map.h"
 #include "util/counts.h"
 #include "util/group.h"
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 0f0d96262d14..eb941213fa0c 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -32,7 +32,6 @@
 #include "util/map.h"
 #include "util/session.h"
 #include "util/symbol.h"
-#include "util/thread.h"
 #include "util/thread_map.h"
 #include "util/top.h"
 #include "util/util.h"
diff --git a/tools/perf/tests/hists_filter.c b/tools/perf/tests/hists_filter.c
index 41dede2f40d8..618b51ffcc01 100644
--- a/tools/perf/tests/hists_filter.c
+++ b/tools/perf/tests/hists_filter.c
@@ -7,7 +7,6 @@
 #include "util/event.h"
 #include "util/evlist.h"
 #include "util/machine.h"
-#include "util/thread.h"
 #include "util/parse-events.h"
 #include "tests/tests.h"
 #include "tests/hists_common.h"
diff --git a/tools/perf/tests/hists_link.c b/tools/perf/tests/hists_link.c
index 012fe8ac0b24..8be4d0b61e3a 100644
--- a/tools/perf/tests/hists_link.c
+++ b/tools/perf/tests/hists_link.c
@@ -6,7 +6,6 @@
 #include "evsel.h"
 #include "evlist.h"
 #include "machine.h"
-#include "thread.h"
 #include "parse-events.h"
 #include "hists_common.h"
 #include <errno.h>
diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index d7c3fbb3694f..6bee59946c4f 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -20,7 +20,6 @@
 #include "evlist.h"
 #include "machine.h"
 #include "session.h"
-#include "thread.h"
 #include "debug.h"
 #include "auxtrace.h"
 #include "arm-spe.h"
diff --git a/tools/perf/util/probe-event.c b/tools/perf/util/probe-event.c
index 5d12a78c8ac8..e90faa6bb5aa 100644
--- a/tools/perf/util/probe-event.c
+++ b/tools/perf/util/probe-event.c
@@ -31,7 +31,6 @@
 #include "map.h"
 #include "map_groups.h"
 #include "symbol.h"
-#include "thread.h"
 #include <api/fs/fs.h>
 #include "trace-event.h"	/* For __maybe_unused */
 #include "probe-event.h"
diff --git a/tools/perf/util/probe-file.c b/tools/perf/util/probe-file.c
index 10d2ab179c71..adc949e8314f 100644
--- a/tools/perf/util/probe-file.c
+++ b/tools/perf/util/probe-file.c
@@ -20,7 +20,6 @@
 #include "cache.h"
 #include "color.h"
 #include "symbol.h"
-#include "thread.h"
 #include <api/fs/tracing_path.h>
 #include "probe-event.h"
 #include "probe-file.h"
diff --git a/tools/perf/util/s390-cpumsf.c b/tools/perf/util/s390-cpumsf.c
index 2ba4baa2c52f..24a99909d8b3 100644
--- a/tools/perf/util/s390-cpumsf.c
+++ b/tools/perf/util/s390-cpumsf.c
@@ -158,7 +158,6 @@
 #include "machine.h"
 #include "session.h"
 #include "tool.h"
-#include "thread.h"
 #include "debug.h"
 #include "auxtrace.h"
 #include "s390-cpumsf.h"
-- 
2.21.0

