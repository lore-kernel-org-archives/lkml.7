Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4649DC606BF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 14:40:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A99621537
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 14:40:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uTgiMsbv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731852AbfGHOkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 10:40:05 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:37278 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728823AbfGHOkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 10:40:05 -0400
Received: by mail-ot1-f65.google.com with SMTP id s20so16435584otp.4
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 07:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=J3hRcly8D1YDeUmF8zVR4I01GOuIVsuQo8ZUqHIaHHQ=;
        b=uTgiMsbv1bumv5PNRDGIEcP1Ibp2JR5Gcza9xMsyQlRcIKKkKbvfvcdP7m410I2uFc
         LupcPK6OC5otRQMJHpKkH/gooaNP4QcYchJO/hOweKClf+7XfLXizmgb4hcfb5GxK31s
         NbbSUzR2DUUNw6NAPEzKac3VqfWAoCVv5XevizEt07CSfrE/8RMP5Lp0np7dCxR7SA3+
         RQbUaSrt9nOlyBz9d0G/xnpN0CcjeL6cQKAe1Pat9UQ2zAVN8k0eXmW3COs5r0m3GDnK
         mYz6R+pc5NesN39Q1byVWIY71GZUpg4FQRyVJgb3F8sm1l4Rj6+rZgD6GfOzALYGvWkl
         FUvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=J3hRcly8D1YDeUmF8zVR4I01GOuIVsuQo8ZUqHIaHHQ=;
        b=losF331uQHk51t/xXsRQGDVeHl63zD6SF+32K75c4dN86UwrpGetBHtKrURyeiCcmt
         Nsmpzo78e4+uKYhspQM1xy9MkDDCY0KXQQeooYR8guVzPiD++uNrRQodeUIybmB0HF5W
         iJa97SiBwUpTlOxuLEJ/AWxz5fcESUPQM6/wcJ0K7JBajOUkNBYUB6pdtB6Yp+3X6jKr
         8tjdYHgpHCOI7K8BOZogNqYmApzbznyMecV5+yL5xiRdtkhMxjlKOtzmxayg/S4ag4le
         Y480mYwnMLeit/dwJ+/8gcvg6mRvbd7XrjEoQMcUvNOVbMluwBY7AZMqjA55aK4+qDfh
         7kng==
X-Gm-Message-State: APjAAAW20ueNOAbPfp0yNVrk034QkbWyhtBOTGxDygsevr3xfxQGlkR+
        BHT67YHn+ZavAKGNa0IFHuM06g==
X-Google-Smtp-Source: APXvYqwJOE12S0nO+y8qmjGhE9hYBxzOAUnP/1QqoMxtTObe2IiXPu2B5/3kzcoq7vV+IPAbjlWWmA==
X-Received: by 2002:a05:6830:1617:: with SMTP id g23mr15083924otr.117.1562596804495;
        Mon, 08 Jul 2019 07:40:04 -0700 (PDT)
Received: from localhost.localdomain (li964-79.members.linode.com. [45.33.10.79])
        by smtp.gmail.com with ESMTPSA id x5sm6386021otb.6.2019.07.08.07.39.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 07:40:03 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 1/4] perf hists: Smatch: Fix potential NULL pointer dereference
Date:   Mon,  8 Jul 2019 22:39:34 +0800
Message-Id: <20190708143937.7722-2-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190708143937.7722-1-leo.yan@linaro.org>
References: <20190708143937.7722-1-leo.yan@linaro.org>
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
Acked-by: Jiri Olsa <jolsa@kernel.org>
---
 tools/perf/ui/browsers/hists.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 85581cfb9112..a94eb0755e8b 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -639,7 +639,11 @@ int hist_browser__run(struct hist_browser *browser, const char *help,
 		switch (key) {
 		case K_TIMER: {
 			u64 nr_entries;
-			hbt->timer(hbt->arg);
+
+			WARN_ON_ONCE(!hbt);
+
+			if (hbt)
+				hbt->timer(hbt->arg);
 
 			if (hist_browser__has_filter(browser) ||
 			    symbol_conf.report_hierarchy)
@@ -2821,7 +2825,7 @@ static int perf_evsel__hists_browse(struct perf_evsel *evsel, int nr_events,
 {
 	struct hists *hists = evsel__hists(evsel);
 	struct hist_browser *browser = perf_evsel_browser__new(evsel, hbt, env, annotation_opts);
-	struct branch_info *bi;
+	struct branch_info *bi = NULL;
 #define MAX_OPTIONS  16
 	char *options[MAX_OPTIONS];
 	struct popup_action actions[MAX_OPTIONS];
@@ -3087,7 +3091,9 @@ static int perf_evsel__hists_browse(struct perf_evsel *evsel, int nr_events,
 			goto skip_annotation;
 
 		if (sort__mode == SORT_MODE__BRANCH) {
-			bi = browser->he_selection->branch_info;
+
+			if (browser->he_selection)
+				bi = browser->he_selection->branch_info;
 
 			if (bi == NULL)
 				goto skip_annotation;
@@ -3271,7 +3277,8 @@ static int perf_evsel_menu__run(struct perf_evsel_menu *menu,
 
 		switch (key) {
 		case K_TIMER:
-			hbt->timer(hbt->arg);
+			if (hbt)
+				hbt->timer(hbt->arg);
 
 			if (!menu->lost_events_warned &&
 			    menu->lost_events &&
-- 
2.17.1

