Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C98CC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D80E42342F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567089608;
	bh=1NOdeN1idrHUmxsuQuE/fvfi1gw2l4pmxnqq1FSrz+g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=wdRsvBuK0E3vz1EaV8lQQb/OLZAXaqGBBZRqUAJX1XeaXZL9oA90wnp07MTWSx/K2
	 fWunO9YdL6oDBc+bZAcQi+XxskpEsMZoy8/Zj4SicetQ1A3tSSNraGEh6ne/PAzveN
	 +uCQKfD0B0ttRrsOYS374lHG8PsLSVByZqOqvQao=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728460AbfH2OkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 10:40:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:43702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728437AbfH2OkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 10:40:06 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 25E112341B;
        Thu, 29 Aug 2019 14:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567089605;
        bh=1NOdeN1idrHUmxsuQuE/fvfi1gw2l4pmxnqq1FSrz+g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iN8iTljqw+9LcrSKmScTh2s1VcLgTeoTTZfxsmbsZeVz0e4bSZtGO5HoiggJnsR4J
         /Vd7odTe+dCrMy8nTRQbHi/ziyPbOKWRj4g1Klh5cPfs1XGpTWdq/bTNq8UQ3mjypX
         tgoy3BXAX35ijpcJYDAJzuKy/ktbf3/GKgN0Cssg=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 07/37] perf tools: Remove needless util.h include from builtin.h
Date:   Thu, 29 Aug 2019 11:38:47 -0300
Message-Id: <20190829143917.29745-8-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190829143917.29745-1-acme@kernel.org>
References: <20190829143917.29745-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

And fix up places where util.h is needed but was obtained indirectly via
builtin.h.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-a01ig3c4t76ye5wkqmtgk9qn@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-buildid-cache.c | 1 +
 tools/perf/builtin.h               | 2 --
 tools/perf/perf.c                  | 1 +
 3 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-buildid-cache.c b/tools/perf/builtin-buildid-cache.c
index 10457b10e568..7dde3ef0398f 100644
--- a/tools/perf/builtin-buildid-cache.c
+++ b/tools/perf/builtin-buildid-cache.c
@@ -25,6 +25,7 @@
 #include "util/session.h"
 #include "util/symbol.h"
 #include "util/time-utils.h"
+#include "util/util.h"
 #include "util/probe-file.h"
 
 static int build_id_cache__kcore_buildid(const char *proc_dir, char *sbuildid)
diff --git a/tools/perf/builtin.h b/tools/perf/builtin.h
index 999fe9170122..14a2db622a7b 100644
--- a/tools/perf/builtin.h
+++ b/tools/perf/builtin.h
@@ -2,8 +2,6 @@
 #ifndef BUILTIN_H
 #define BUILTIN_H
 
-#include "util/util.h"
-
 extern const char perf_usage_string[];
 extern const char perf_more_info_string[];
 
diff --git a/tools/perf/perf.c b/tools/perf/perf.c
index d4e4d53e8b44..34763a9b873d 100644
--- a/tools/perf/perf.c
+++ b/tools/perf/perf.c
@@ -18,6 +18,7 @@
 #include "util/bpf-loader.h"
 #include "util/debug.h"
 #include "util/event.h"
+#include "util/util.h"
 #include <api/fs/fs.h>
 #include <api/fs/tracing_path.h>
 #include <errno.h>
-- 
2.21.0

