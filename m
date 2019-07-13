Return-Path: <SRS0=/nvU=VK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FAEEC742D7
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 10:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCE672083B
	for <linux-kernel@archiver.kernel.org>; Sat, 13 Jul 2019 10:58:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="PlABL9m2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727754AbfGMK57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jul 2019 06:57:59 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44617 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbfGMK57 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 06:57:59 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x6DAvPCt3838264
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Sat, 13 Jul 2019 03:57:25 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x6DAvPCt3838264
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019061801; t=1563015446;
        bh=9FSHObF2QSFz47oCnmhPYTvWg8SJodez9gOW3yVagno=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=PlABL9m2+4xSMnz4Yj4Oih60hvce8KRsKivC5zX+JQ4bIZa8eskg2fDTSbdVVOmP3
         CcwS0VMtGymLCCrXpsk2ClvvZLi0N/uZjKrqU2Ilck6Uwz0o00HK5jDwgjDPijGQSt
         qrCp0IyFjcrPmAO3J4BHvp82Jiamu1aIctev3ZSij8IbaQvB8QSsPS/LAL8iEWLSnK
         8XTeAB4+6+fuMskJ6YUCkmBQM/NNE7cYi4XsIdaH0yGwlOj47x7D7XiRbtXI4bZjya
         RLDo8PTdz7LVmKmJVP5eQm1CoUNDuyipA9nNfYMXc5Lv4X/evor8fA5dYdA3koLpuh
         q8c8vtlmCkrlw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x6DAvOj83838261;
        Sat, 13 Jul 2019 03:57:24 -0700
Date:   Sat, 13 Jul 2019 03:57:24 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Leo Yan <tipbot@zytor.com>
Message-ID: <tip-f3c8d90757724982e5f07cd77d315eb64ca145ac@git.kernel.org>
Cc:     suzuki.poulose@arm.com, songliubraving@fb.com, hpa@zytor.com,
        eric.saint.etienne@oracle.com, alexey.budankov@linux.intel.com,
        namhyung@kernel.org, jolsa@kernel.org, tmricht@linux.ibm.com,
        mathieu.poirier@linaro.org, changbin.du@intel.com,
        adrian.hunter@intel.com, dave@stgolabs.net,
        linux-kernel@vger.kernel.org, mingo@kernel.org,
        alexander.shishkin@linux.intel.com, linux@rasmusvillemoes.dk,
        acme@redhat.com, ak@linux.intel.com, davem@davemloft.net,
        peterz@infradead.org, yao.jin@linux.intel.com, tglx@linutronix.de,
        alexios.zavras@intel.com, leo.yan@linaro.org,
        khlebnikov@yandex-team.ru
Reply-To: changbin.du@intel.com, mathieu.poirier@linaro.org,
          alexander.shishkin@linux.intel.com, linux@rasmusvillemoes.dk,
          adrian.hunter@intel.com, mingo@kernel.org, dave@stgolabs.net,
          linux-kernel@vger.kernel.org, songliubraving@fb.com,
          suzuki.poulose@arm.com, tmricht@linux.ibm.com, hpa@zytor.com,
          eric.saint.etienne@oracle.com, namhyung@kernel.org,
          jolsa@kernel.org, alexey.budankov@linux.intel.com,
          leo.yan@linaro.org, khlebnikov@yandex-team.ru,
          ak@linux.intel.com, davem@davemloft.net, acme@redhat.com,
          alexios.zavras@intel.com, peterz@infradead.org,
          yao.jin@linux.intel.com, tglx@linutronix.de
In-Reply-To: <20190702103420.27540-9-leo.yan@linaro.org>
References: <20190702103420.27540-9-leo.yan@linaro.org>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/urgent] perf session: Fix potential NULL pointer
 dereference found by the smatch tool
Git-Commit-ID: f3c8d90757724982e5f07cd77d315eb64ca145ac
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

Commit-ID:  f3c8d90757724982e5f07cd77d315eb64ca145ac
Gitweb:     https://git.kernel.org/tip/f3c8d90757724982e5f07cd77d315eb64ca145ac
Author:     Leo Yan <leo.yan@linaro.org>
AuthorDate: Tue, 2 Jul 2019 18:34:17 +0800
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Tue, 9 Jul 2019 09:33:55 -0300

perf session: Fix potential NULL pointer dereference found by the smatch tool

Based on the following report from Smatch, fix the potential
NULL pointer dereference check.

  tools/perf/util/session.c:1252
  dump_read() error: we previously assumed 'evsel' could be null
  (see line 1249)

  tools/perf/util/session.c
  1240 static void dump_read(struct perf_evsel *evsel, union perf_event *event)
  1241 {
  1242         struct read_event *read_event = &event->read;
  1243         u64 read_format;
  1244
  1245         if (!dump_trace)
  1246                 return;
  1247
  1248         printf(": %d %d %s %" PRIu64 "\n", event->read.pid, event->read.tid,
  1249                evsel ? perf_evsel__name(evsel) : "FAIL",
  1250                event->read.value);
  1251
  1252         read_format = evsel->attr.read_format;
                             ^^^^^^^

'evsel' could be NULL pointer, for this case this patch directly bails
out without dumping read_event.

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
Link: http://lkml.kernel.org/r/20190702103420.27540-9-leo.yan@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/session.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 54cf163347f7..2e61dd6a3574 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1249,6 +1249,9 @@ static void dump_read(struct perf_evsel *evsel, union perf_event *event)
 	       evsel ? perf_evsel__name(evsel) : "FAIL",
 	       event->read.value);
 
+	if (!evsel)
+		return;
+
 	read_format = evsel->attr.read_format;
 
 	if (read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)
