Return-Path: <SRS0=vU+5=XP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D94DC4CEC9
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 14:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 210612080F
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Sep 2019 14:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568989746;
	bh=8W2d7317UQ2+3SdCKUKlB36N6OP2BIBPxbxn0TIEPek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=y/j289UhhrQ7bB1HqMMXL/o3SSm8fP7MbC0HosiLpcs3+1HZGEUAYFJwNl7Srmx7D
	 D/wAFDIjesSFB3XbAGfpSAwcGkFEvDNN5MwqwMahi4ektUyi+MNyyyIjuohP5/bZql
	 5XJHnXPWfgTTlkDq+Kv38LTD9m27irCsqXsg+zLY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390274AbfITO3C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Sep 2019 10:29:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:39366 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389164AbfITO0h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Sep 2019 10:26:37 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 83098208C3;
        Fri, 20 Sep 2019 14:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568989596;
        bh=8W2d7317UQ2+3SdCKUKlB36N6OP2BIBPxbxn0TIEPek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PYIx07k7Muh/Vxk/ashkNEM5wicBaI57+00kch7IflF38uHWzSebPy104lLwbNrsz
         YlxWT8uUTQaw/vAsLHIVXvGBb+KR41a9vjL/dliU2RXiZYXFZzqUIVkNCppg3IlOrC
         Hrl0sTCilk4WXSnypgHZat7amX7RlJzATGEQ8LO4=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 16/31] perf callchain: Remove needless event.h include
Date:   Fri, 20 Sep 2019 11:25:27 -0300
Message-Id: <20190920142542.12047-17-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190920142542.12047-1-acme@kernel.org>
References: <20190920142542.12047-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

All we need is a bunch of struct forward declarations and then add
event.h to the only place that was getting it indirectly via
callchain.h.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-qq2xhyuxcvx5vmxha9otjd8d@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/powerpc/util/skip-callchain-idx.c | 1 +
 tools/perf/util/callchain.h                       | 5 ++++-
 tools/perf/util/evsel_fprintf.c                   | 1 +
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/perf/arch/powerpc/util/skip-callchain-idx.c b/tools/perf/arch/powerpc/util/skip-callchain-idx.c
index fc9c2f5fcd52..3018a054526a 100644
--- a/tools/perf/arch/powerpc/util/skip-callchain-idx.c
+++ b/tools/perf/arch/powerpc/util/skip-callchain-idx.c
@@ -13,6 +13,7 @@
 #include "util/callchain.h"
 #include "util/debug.h"
 #include "util/dso.h"
+#include "util/event.h" // struct ip_callchain
 #include "util/map.h"
 #include "util/symbol.h"
 
diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.h
index b042ceef4114..83398e5bbe4b 100644
--- a/tools/perf/util/callchain.h
+++ b/tools/perf/util/callchain.h
@@ -4,12 +4,15 @@
 
 #include <linux/list.h>
 #include <linux/rbtree.h>
-#include "event.h"
 #include "map_symbol.h"
 #include "branch.h"
 
+struct addr_location;
 struct evsel;
+struct ip_callchain;
 struct map;
+struct perf_sample;
+struct thread;
 
 #define HELP_PAD "\t\t\t\t"
 
diff --git a/tools/perf/util/evsel_fprintf.c b/tools/perf/util/evsel_fprintf.c
index 496fec01f5d1..a8cbdf4c2753 100644
--- a/tools/perf/util/evsel_fprintf.c
+++ b/tools/perf/util/evsel_fprintf.c
@@ -4,6 +4,7 @@
 #include <stdbool.h>
 #include <traceevent/event-parse.h>
 #include "evsel.h"
+#include "util/event.h"
 #include "callchain.h"
 #include "map.h"
 #include "strlist.h"
-- 
2.21.0

