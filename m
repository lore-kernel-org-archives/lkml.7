Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFE94C06511
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 10:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8871D20836
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 10:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g07M7EfA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbfGBKfL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 06:35:11 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:35778 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfGBKfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 06:35:10 -0400
Received: by mail-oi1-f194.google.com with SMTP id a127so12617977oii.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 03:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=utMbP5r99vkrLRwFC9XJUF/q6Xmj0kpzfxPbj/zmwoc=;
        b=g07M7EfAimyBJUBTxRPreg/5uLOzsLgF+3r66hneNUCiDvvGk5WbVUCT/5bnUBY+wb
         FYofzKOxyhyHecehXrTFZp66JEf6ROxWUQ5wu2s+QCMytOkRacbVx59muNBI6eDLNZpa
         lnexdzYvCRMZQQHS0nzPHi9N/5iQCdz5m5FyE9VEXnXVl11RMplHf2yRET+rU7XTH5As
         Wy97HMCtEc0ir9AQEiywnG/ejR25uR4vQuPE+R2b2XrppBnvm3nq3qKb6Np/8Av7daH/
         NJZ9kpbNTrdJVQsVpvesG5D+brZpx2D9s7NMI4g0A3BDoy+T5Rk0y41vDwNsooeaUCFW
         ZwWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=utMbP5r99vkrLRwFC9XJUF/q6Xmj0kpzfxPbj/zmwoc=;
        b=IwNfer62tqDFk1Hvlr/OrFxXEKNnNniFp1KEijs7OEN0727JcPkgZIAZDfiDMpDlfT
         VyEZJbaJbBAqlcrFE0moxnhTtTna6am9QhUAnTRftzo8dj2U+70IcVTynW0/3FR5XROj
         6juP21uoeXpFBBrtPYhbo45PQkYljO0yqUPCsUHwiJ1m6Va433EmStU1vwP+MPyupOyp
         zz5TA3Ybv24kAuVXw4DbL04jmbEAwBf2h1pA88PIzP2MaEdypf1Sm/oMiy+5iLdsN7QA
         Y3y1OpQDpVXf4CbJAi+/9PDW6pRUV56W+RZCVpA/eXi7M0ADkS7ggcY2n5F4p68fXGVx
         XdEA==
X-Gm-Message-State: APjAAAVSzzZYf0rjXghSKzLNik1AtCkRtrR76atbPv3wOU3CP36wlb1o
        /i1RbBGBMkMqPFF869uTcK01JQ==
X-Google-Smtp-Source: APXvYqz27DHhsloV2s8JFprH1yJgfKfeYbRlyI8A/LXKmBzUKXKTnkrUL+uycpLRiZ2UmcR06WtYkA==
X-Received: by 2002:aca:338b:: with SMTP id z133mr2465469oiz.97.1562063709968;
        Tue, 02 Jul 2019 03:35:09 -0700 (PDT)
Received: from localhost.localdomain (li964-79.members.linode.com. [45.33.10.79])
        by smtp.gmail.com with ESMTPSA id 61sm5139805otx.8.2019.07.02.03.35.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 03:35:09 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Andi Kleen <ak@linux.intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Jin Yao <yao.jin@linux.intel.com>,
        Song Liu <songliubraving@fb.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Changbin Du <changbin.du@intel.com>,
        Eric Saint-Etienne <eric.saint.etienne@oracle.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 03/11] perf top: Smatch: Fix potential NULL pointer dereference
Date:   Tue,  2 Jul 2019 18:34:12 +0800
Message-Id: <20190702103420.27540-4-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190702103420.27540-1-leo.yan@linaro.org>
References: <20190702103420.27540-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on the following report from Smatch, fix the potential
NULL pointer dereference check.

  tools/perf/builtin-top.c:109
  perf_top__parse_source() warn: variable dereferenced before check 'he'
  (see line 103)

  tools/perf/builtin-top.c:233
  perf_top__show_details() warn: variable dereferenced before check 'he'
  (see line 228)

tools/perf/builtin-top.c
101 static int perf_top__parse_source(struct perf_top *top, struct hist_entry *he)
102 {
103         struct perf_evsel *evsel = hists_to_evsel(he->hists);
                                                      ^^^^
104         struct symbol *sym;
105         struct annotation *notes;
106         struct map *map;
107         int err = -1;
108
109         if (!he || !he->ms.sym)
110                 return -1;

This patch moves the values assignment after validating pointer 'he'.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/builtin-top.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 12b6b15a9675..13234c322981 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -100,7 +100,7 @@ static void perf_top__resize(struct perf_top *top)
 
 static int perf_top__parse_source(struct perf_top *top, struct hist_entry *he)
 {
-	struct perf_evsel *evsel = hists_to_evsel(he->hists);
+	struct perf_evsel *evsel;
 	struct symbol *sym;
 	struct annotation *notes;
 	struct map *map;
@@ -109,6 +109,8 @@ static int perf_top__parse_source(struct perf_top *top, struct hist_entry *he)
 	if (!he || !he->ms.sym)
 		return -1;
 
+	evsel = hists_to_evsel(he->hists);
+
 	sym = he->ms.sym;
 	map = he->ms.map;
 
@@ -225,7 +227,7 @@ static void perf_top__record_precise_ip(struct perf_top *top,
 static void perf_top__show_details(struct perf_top *top)
 {
 	struct hist_entry *he = top->sym_filter_entry;
-	struct perf_evsel *evsel = hists_to_evsel(he->hists);
+	struct perf_evsel *evsel;
 	struct annotation *notes;
 	struct symbol *symbol;
 	int more;
@@ -233,6 +235,8 @@ static void perf_top__show_details(struct perf_top *top)
 	if (!he)
 		return;
 
+	evsel = hists_to_evsel(he->hists);
+
 	symbol = he->ms.sym;
 	notes = symbol__annotation(symbol);
 
-- 
2.17.1

