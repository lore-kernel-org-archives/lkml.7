Return-Path: <SRS0=NvuC=VQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C4E5C76195
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:01:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E63BE218C9
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jul 2019 04:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563508864;
	bh=ph2Z+/2HkFD1e0+2qCkiIDRQNVc3eTu28TAQv8mOx90=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rGFekSGXhAA0vg4pNoGZq3cWX9U+I5sDkP0cSal66ylcCYGFr/d1YE0+eF4dXKv69
	 2hgszq1AyseNlZ0pjoe3gboC3QsREC3JGrg8+muabbGMhLD0ZR+k46+MCfMQ1u60B2
	 2l7Sga31QqS4EHNo0m8Fr+rwLJ2w3ZdA3JhlHrBE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729305AbfGSEBD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jul 2019 00:01:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:60782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728347AbfGSEAz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jul 2019 00:00:55 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F331521873;
        Fri, 19 Jul 2019 04:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563508854;
        bh=ph2Z+/2HkFD1e0+2qCkiIDRQNVc3eTu28TAQv8mOx90=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mfNl9RHU8XtACDWUM4G5M+moYaB3YQCaDyxNlCf9C/ZRW0MVjAV//Lu3G+sAM5dVM
         JgEKEKbetRC9LsHK5U03+Q3bSSa4h2cozP4eAnBMwU5IwUHGvsLAM2j07PHvvjr7Ih
         FUI1Dys+wSLAbuucLYbNM5t+5l2nCFPk5UDcjfTk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>, Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Alexios Zavras <alexios.zavras@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Changbin Du <changbin.du@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Eric Saint-Etienne <eric.saint.etienne@oracle.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Song Liu <songliubraving@fb.com>,
        Suzuki Poulouse <suzuki.poulose@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thomas Richter <tmricht@linux.ibm.com>,
        linux-arm-kernel@lists.infradead.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.2 125/171] perf top: Fix potential NULL pointer dereference detected by the smatch tool
Date:   Thu, 18 Jul 2019 23:55:56 -0400
Message-Id: <20190719035643.14300-125-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190719035643.14300-1-sashal@kernel.org>
References: <20190719035643.14300-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leo Yan <leo.yan@linaro.org>

[ Upstream commit 111442cfc8abdeaa7ec1407f07ef7b3e5f76654e ]

Based on the following report from Smatch, fix the potential NULL
pointer dereference check.

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
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Alexios Zavras <alexios.zavras@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Changbin Du <changbin.du@intel.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Eric Saint-Etienne <eric.saint.etienne@oracle.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Konstantin Khlebnikov <khlebnikov@yandex-team.ru>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Song Liu <songliubraving@fb.com>
Cc: Suzuki Poulouse <suzuki.poulose@arm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Cc: linux-arm-kernel@lists.infradead.org
Link: http://lkml.kernel.org/r/20190702103420.27540-4-leo.yan@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/builtin-top.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 466621cd1017..8a9ff4b11df0 100644
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
2.20.1

