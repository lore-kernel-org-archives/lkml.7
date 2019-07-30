Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA56C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 03:03:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A85120578
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 03:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564455819;
	bh=DoX7PPAUc7tLZQ4HkBj9LSvarCBetxJes8kxmAibDX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QpBHni9brKBwSzV9Xl2cUm7P5SmNDbPMl9R4cOFCinHtrLWC60Z0t7xlacdTF4P9O
	 ULgpm5DRa+09/2TxIfqZmyQBJ7s7vCna2qQLerCkG/ZrY02sNPDncSsmuuzMH93IqG
	 +nf3fxEaHqUKyEyRDy2VWtIE+vMVDMNHHln6r5+A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732069AbfG3C6s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 22:58:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:48134 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732053AbfG3C6o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 22:58:44 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B80CA21773;
        Tue, 30 Jul 2019 02:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564455522;
        bh=DoX7PPAUc7tLZQ4HkBj9LSvarCBetxJes8kxmAibDX8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DWQGKmtA8Nhm2BjgfTjenI/NISHezF30J1jtjZ9cPvEeioLEcItILPXr+bOL3y3/o
         9IR3YgOmke3rV8+GXo8T17vxkG+1BzlHVYSjDG1ksXqTysSNeKgu9MI3981VHv94FJ
         6nDoAsB86FVnxNY/fhfaJko1SYgKZXxaqM5Cmdzw=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Alexey Budankov <alexey.budankov@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 044/107] perf evsel: Rename perf_evsel__apply_filter() to evsel__apply_filter()
Date:   Mon, 29 Jul 2019 23:55:07 -0300
Message-Id: <20190730025610.22603-45-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190730025610.22603-1-acme@kernel.org>
References: <20190730025610.22603-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jiri Olsa <jolsa@kernel.org>

Rename perf_evsel__apply_filter() to evsel__apply_filter(), so we don't
have a name clash when we add perf_evsel__apply_filter() in libperf.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Alexey Budankov <alexey.budankov@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190721112506.12306-18-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evlist.c | 2 +-
 tools/perf/util/evsel.c  | 2 +-
 tools/perf/util/evsel.h  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 9461583c53d9..e71c3cc93924 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1158,7 +1158,7 @@ int perf_evlist__apply_filters(struct evlist *evlist, struct evsel **err_evsel)
 		 * filters only work for tracepoint event, which doesn't have cpu limit.
 		 * So evlist and evsel should always be same.
 		 */
-		err = perf_evsel__apply_filter(evsel, evsel->filter);
+		err = evsel__apply_filter(evsel, evsel->filter);
 		if (err) {
 			*err_evsel = evsel;
 			break;
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 855d286298eb..5aeb7260c8e1 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -1187,7 +1187,7 @@ static int perf_evsel__run_ioctl(struct evsel *evsel,
 	return 0;
 }
 
-int perf_evsel__apply_filter(struct evsel *evsel, const char *filter)
+int evsel__apply_filter(struct evsel *evsel, const char *filter)
 {
 	return perf_evsel__run_ioctl(evsel,
 				     PERF_EVENT_IOC_SET_FILTER,
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index c338ce14e8aa..35f7e7ff3c5e 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -294,7 +294,7 @@ int perf_evsel__set_filter(struct evsel *evsel, const char *filter);
 int perf_evsel__append_tp_filter(struct evsel *evsel, const char *filter);
 int perf_evsel__append_addr_filter(struct evsel *evsel,
 				   const char *filter);
-int perf_evsel__apply_filter(struct evsel *evsel, const char *filter);
+int evsel__apply_filter(struct evsel *evsel, const char *filter);
 int evsel__enable(struct evsel *evsel);
 int evsel__disable(struct evsel *evsel);
 
-- 
2.21.0

