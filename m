Return-Path: <SRS0=/nvU=VK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF2C2C742A7
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 10:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95B952083B
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 10:54:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Uz6WznF0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727744AbfGMKy3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jul 2019 06:54:29 -0400
Received: from terminus.zytor.com ([198.137.202.136]:56857 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbfGMKy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 06:54:28 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6DArqGN3837520
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 13 Jul 2019 03:53:52 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6DArqGN3837520
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563015233;
        bh=brBw1TcqNDd2+ZyA8bk3dciFCBKSN99IkRUlTDmJYgQ=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=Uz6WznF0u3VC4peo+u4edIawbxTyGcFB8ebeJOwHZ18kHH+cjMX0dh4oCy8FFMn1E
         1jOZSPpRxNb64Hsorix+ftb2ac3AtZE+aqVX2gYAMHoGPd/6yyuYfmHBlyImQ39Mf0
         zlAtImJwLOYelKvYiZNkfnhCxYdtscw2+FIy8rzhdmclGwwTMp5o4Qv5wUlXKHlTF1
         z7DuOYbaEjO8FiXqG084znsQ7RM6GETmqlW16f3PU/4JOt1I/i1OjpgI5WGYJUrdos
         Z06BLv1Ki7PZEWOJaL4gc48vFyexvjp1QVHBZPcyLXAt7uC9FWSr8N5vzJO3E3Fjqr
         HbaPR0PCWEliA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6DArpEa3837517;
        Sat, 13 Jul 2019 03:53:51 -0700
Date:   Sat, 13 Jul 2019 03:53:51 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Leo Yan <tipbot@zytor.com>
Message-ID: <tip-111442cfc8abdeaa7ec1407f07ef7b3e5f76654e@git.kernel.org>
Cc:     songliubraving@fb.com, tmricht@linux.ibm.com, davem@davemloft.net,
        linux@rasmusvillemoes.dk, alexander.shishkin@linux.intel.com,
        leo.yan@linaro.org, ak@linux.intel.com,
        alexey.budankov@linux.intel.com, changbin.du@intel.com,
        acme@redhat.com, linux-kernel@vger.kernel.org,
        yao.jin@linux.intel.com, mathieu.poirier@linaro.org,
        namhyung@kernel.org, dave@stgolabs.net, adrian.hunter@intel.com,
        alexios.zavras@intel.com, mingo@kernel.org,
        eric.saint.etienne@oracle.com, peterz@infradead.org, hpa@zytor.com,
        khlebnikov@yandex-team.ru, suzuki.poulose@arm.com,
        tglx@linutronix.de, jolsa@kernel.org
Reply-To: mathieu.poirier@linaro.org, yao.jin@linux.intel.com,
          linux-kernel@vger.kernel.org, acme@redhat.com,
          changbin.du@intel.com, alexey.budankov@linux.intel.com,
          ak@linux.intel.com, leo.yan@linaro.org,
          alexander.shishkin@linux.intel.com, linux@rasmusvillemoes.dk,
          davem@davemloft.net, tmricht@linux.ibm.com,
          songliubraving@fb.com, jolsa@kernel.org, tglx@linutronix.de,
          suzuki.poulose@arm.com, khlebnikov@yandex-team.ru, hpa@zytor.com,
          eric.saint.etienne@oracle.com, peterz@infradead.org,
          mingo@kernel.org, alexios.zavras@intel.com,
          adrian.hunter@intel.com, dave@stgolabs.net, namhyung@kernel.org
In-Reply-To: <20190702103420.27540-4-leo.yan@linaro.org>
References: <20190702103420.27540-4-leo.yan@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf top: Fix potential NULL pointer dereference
 detected by the smatch tool
Git-Commit-ID: 111442cfc8abdeaa7ec1407f07ef7b3e5f76654e
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  111442cfc8abdeaa7ec1407f07ef7b3e5f76654e
Gitweb:     https://git.kernel.org/tip/111442cfc8abdeaa7ec1407f07ef7b3e5f76654e
Author:     Leo Yan <leo.yan@linaro.org>
AuthorDate: Tue, 2 Jul 2019 18:34:12 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 9 Jul 2019 09:33:54 -0300

perf top: Fix potential NULL pointer dereference detected by the smatch tool

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
---
 tools/perf/builtin-top.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 6d40a4ef58c5..b46b3c9f57a0 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -101,7 +101,7 @@ static void perf_top__resize(struct perf_top *top)
 
 static int perf_top__parse_source(struct perf_top *top, struct hist_entry *he)
 {
-	struct perf_evsel *evsel = hists_to_evsel(he->hists);
+	struct perf_evsel *evsel;
 	struct symbol *sym;
 	struct annotation *notes;
 	struct map *map;
@@ -110,6 +110,8 @@ static int perf_top__parse_source(struct perf_top *top, struct hist_entry *he)
 	if (!he || !he->ms.sym)
 		return -1;
 
+	evsel = hists_to_evsel(he->hists);
+
 	sym = he->ms.sym;
 	map = he->ms.map;
 
@@ -226,7 +228,7 @@ static void perf_top__record_precise_ip(struct perf_top *top,
 static void perf_top__show_details(struct perf_top *top)
 {
 	struct hist_entry *he = top->sym_filter_entry;
-	struct perf_evsel *evsel = hists_to_evsel(he->hists);
+	struct perf_evsel *evsel;
 	struct annotation *notes;
 	struct symbol *symbol;
 	int more;
@@ -234,6 +236,8 @@ static void perf_top__show_details(struct perf_top *top)
 	if (!he)
 		return;
 
+	evsel = hists_to_evsel(he->hists);
+
 	symbol = he->ms.sym;
 	notes = symbol__annotation(symbol);
 
