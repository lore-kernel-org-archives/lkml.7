Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CA44C46479
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 10:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BEDD20836
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 10:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gqUYj3Rg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727294AbfGBKff (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 06:35:35 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:43245 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbfGBKfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 06:35:34 -0400
Received: by mail-ot1-f66.google.com with SMTP id q10so6705019otk.10
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2019 03:35:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pR8OnU6ONKK8WXaF3q0PWRqZRj/gofETqCh57U/9pps=;
        b=gqUYj3RgcmbrGaA8NafweIqkT9dOdE8BbJZXI+ANioWM70cMuoNl7wgH8y7qyORqBP
         MrOo4umrodn+Q4qIgwxpFIBLrCit6U2wXsumMe5NX/NcBUN98yGQQgw5PDFKzGdWeAif
         T0HaRSKYOBlDUWYerXzXCwcJBErDmF66NK3NbzTASZBFJfCZTf681g3c3MMx3MB6Sj2z
         aiyeEui7Vl/tIxL9w8C53Q0o0E1fB5HdJ/7bmX1l7kvUuRXM4DO2+jhbXtB8R9UU3z2S
         68owNLcHSQeyp9OTm7P/ivHJg0HXEtVBw1yBkFt+UMw4KPPPxrzs/dm6pvWXMIepPWjA
         dwgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pR8OnU6ONKK8WXaF3q0PWRqZRj/gofETqCh57U/9pps=;
        b=ROuWLk4Fou3bNl6rXd9PTI5WRz7RznvmkLgjkuCKz5zPXsMCAwaJgiml1u7xTqT+bV
         1jPl9uqyh7Ta9ZB5MH1BBks81MBr2FIsZw75/P2BveWkhhy3+pSCMNbvYt4DKPhYo835
         F6nKTPFrI6O+Uzq52YHLXygxWM4TTo6aoBMjVig0j/WKBtFDH2jekiQnYbpKHsxsFXfC
         BSeP3Wk8ETany5ko73OUDEK9/SoSfjfqC+//B3oEX/FieTa+3vJeN0xwbb5Aak9GENGn
         Gh2sVo9oDG5LlqkP6wDi0djJKJLGF0oj/HNNymuUcbmUu1df/dVAlWupvNs9fdgIaoyW
         7sww==
X-Gm-Message-State: APjAAAWD1Fnw7bbhdubHAcSmso7FMB+7U03vn1zTXWCMH+bITfIPqsWo
        KipJo2pfp+xzBuCWg/ccZl1/lg==
X-Google-Smtp-Source: APXvYqyaOWCLuKdf554R9kmBO3xUVp5yD3JiE8Mhw7yip5LrQxZlFyTOL0TMpX2DA4AxZ+BEsBafBw==
X-Received: by 2002:a05:6830:14c:: with SMTP id j12mr22891677otp.181.1562063733986;
        Tue, 02 Jul 2019 03:35:33 -0700 (PDT)
Received: from localhost.localdomain (li964-79.members.linode.com. [45.33.10.79])
        by smtp.gmail.com with ESMTPSA id 61sm5139805otx.8.2019.07.02.03.35.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 03:35:33 -0700 (PDT)
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
Subject: [PATCH v1 06/11] perf hists: Smatch: Fix potential NULL pointer dereference
Date:   Tue,  2 Jul 2019 18:34:15 +0800
Message-Id: <20190702103420.27540-7-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190702103420.27540-1-leo.yan@linaro.org>
References: <20190702103420.27540-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on the following report from Smatch, fix the potential
NULL pointer dereference check.

  tools/perf/ui/browsers/hists.c:641
  hist_browser__run() error: we previously assumed 'hbt' could be
  null (see line 625)

  tools/perf/ui/browsers/hists.c:3088
  perf_evsel__hists_browse() error: we previously assumed
  'browser->he_selection' could be null (see line 2902)

  tools/perf/ui/browsers/hists.c:3272
  perf_evsel_menu__run() error: we previously assumed 'hbt' could be
  null (see line 3260)

This patch firstly validating the pointers before access them, so can
fix potential NULL pointer dereference.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/ui/browsers/hists.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 3421ecbdd3f0..2ba33040ddd8 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -638,7 +638,9 @@ int hist_browser__run(struct hist_browser *browser, const char *help,
 		switch (key) {
 		case K_TIMER: {
 			u64 nr_entries;
-			hbt->timer(hbt->arg);
+
+			if (hbt)
+				hbt->timer(hbt->arg);
 
 			if (hist_browser__has_filter(browser) ||
 			    symbol_conf.report_hierarchy)
@@ -2819,7 +2821,7 @@ static int perf_evsel__hists_browse(struct perf_evsel *evsel, int nr_events,
 {
 	struct hists *hists = evsel__hists(evsel);
 	struct hist_browser *browser = perf_evsel_browser__new(evsel, hbt, env, annotation_opts);
-	struct branch_info *bi;
+	struct branch_info *bi = NULL;
 #define MAX_OPTIONS  16
 	char *options[MAX_OPTIONS];
 	struct popup_action actions[MAX_OPTIONS];
@@ -3085,7 +3087,9 @@ static int perf_evsel__hists_browse(struct perf_evsel *evsel, int nr_events,
 			goto skip_annotation;
 
 		if (sort__mode == SORT_MODE__BRANCH) {
-			bi = browser->he_selection->branch_info;
+
+			if (browser->he_selection)
+				bi = browser->he_selection->branch_info;
 
 			if (bi == NULL)
 				goto skip_annotation;
@@ -3269,7 +3273,8 @@ static int perf_evsel_menu__run(struct perf_evsel_menu *menu,
 
 		switch (key) {
 		case K_TIMER:
-			hbt->timer(hbt->arg);
+			if (hbt)
+				hbt->timer(hbt->arg);
 
 			if (!menu->lost_events_warned &&
 			    menu->lost_events &&
-- 
2.17.1

