Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 642CAC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 23:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3780820856
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 23:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566947762;
	bh=azKINZRxAxKEn/RsP2ULdeQIY62nFc53h6EH2owEATE=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=GkQl9wdztvrl+krhpeJqkHJgASnQJKD0S8Ly3/T0ZOotGK7jD0zQYCCoXH3CsGUyM
	 NJGG4zh13gmbveC35ksvUa+YIgxZNQ7Fgaw/KgM3CssDcvVq5be3WoHCWnc9knFO9s
	 Rlzb74uPA25c6HfhqtfvkyiD1A0I+fjN9jhgJiIA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726342AbfH0XQB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 19:16:01 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:42709 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbfH0XQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 19:16:00 -0400
Received: by mail-pf1-f195.google.com with SMTP id i30so361557pfk.9
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 16:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+C3bks66h8FMyrio7f9pyOh5hCYbxHHGQJQS9xo6UoU=;
        b=a+AJtp8dk9nnTw/1TgkdefE1GMzxe+Ps3l+QxyuG9OhqOTnMJFkfopIAsvoDSERlXU
         4RWSDW1XCrZMaRli7COilKMiBTwNnMR7YxiOqNaRlO5fsY49cgSntDzfe2rVgWG5cTKz
         AQJIhrqAWCnn+KmVEzRkUgjKH472ysIndJFhUWzF+A4UtLY3iVVLurUzZEy4K6fgtQlI
         VUKFP1ZX5ET56f0NoIeJCIO2WT+LrWwp21rEH4V+x7dB28McaUTJ7gk8PH2lqZy61rk4
         RyTny2KUsJiiCk50IZCplWDqN2je9Rj5Z0uTkO6DtK0Zv2cSDQwX+w37ggfZEy8Lfj+L
         L+/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=+C3bks66h8FMyrio7f9pyOh5hCYbxHHGQJQS9xo6UoU=;
        b=RrIoZaxgLWBjOpYEPWkJygjFC5EL7trsCRWF4Ac1ityk2Jatu+xcRu0bAtvWwLcLuF
         qQCMn8qs+F9ZKlzeIW6WEvNRvpqg5/pTCNVl+v/ISYNE/+891AIppXMrt0MdmCcn3URB
         SqADkZjh/2vawL1383YrW3jNgrUdzlB4dU4wh2XOcNGu75wkzbyazsApG+jALrbOY58O
         jEDpYE1LkC/fgx/e6VdkRG+WiKby/LJdP5TVldwoN4m+Sl/7z/a2+xNbgA5lYsNUJvl3
         Me8E3fGthpZJ9fviXt3xEDU3SvIuYbz88u3MJn3hmzGQoxiCpz0ATQlYRlN18Kwpacgs
         NOFQ==
X-Gm-Message-State: APjAAAWLMDok+YB8oEyhIO1gcaWHKn+0z7X2sCdJKD39sySru8BUCVS2
        gPKRVRcQv3PNNKWvyBuQFTE=
X-Google-Smtp-Source: APXvYqwQPdZ2EcOyMqp26OkN2sBQhfk8zPcJaIsp8GsX4zfAWUTxP17s0uerAJ0KYzXZvgreTpKNhg==
X-Received: by 2002:a65:458d:: with SMTP id o13mr842235pgq.34.1566947760006;
        Tue, 27 Aug 2019 16:16:00 -0700 (PDT)
Received: from gaurie.seo.corp.google.com ([2401:fa00:d:0:1034:ec6b:8056:9e93])
        by smtp.gmail.com with ESMTPSA id a10sm411624pfl.159.2019.08.27.16.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 16:15:59 -0700 (PDT)
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Jiri Olsa <jolsa@redhat.com>
Subject: [PATCH 1/2] perf top: Decay all events in the evlist
Date:   Wed, 28 Aug 2019 08:15:54 +0900
Message-Id: <20190827231555.121411-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently perf top only decays entries in a selected evsel.  I don't
know whether it's intended (maybe due to performance reason?) but
anyway it might show incorrect output when event group is used since
users will see leader event is decayed but others are not.

This patch moves the decay code into evlist__resort_hists() so that
stdio and tui code shared the logic.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-top.c | 38 +++++++++++++-------------------------
 1 file changed, 13 insertions(+), 25 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 5970723cd55a..9d3059d2029d 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -264,13 +264,23 @@ static void perf_top__show_details(struct perf_top *top)
 	pthread_mutex_unlock(&notes->lock);
 }
 
-static void evlist__resort_hists(struct evlist *evlist)
+static void evlist__resort_hists(struct perf_top *t)
 {
+	struct evlist *evlist = t->evlist;
 	struct evsel *pos;
 
 	evlist__for_each_entry(evlist, pos) {
 		struct hists *hists = evsel__hists(pos);
 
+		if (evlist->enabled) {
+			if (t->zero) {
+				hists__delete_entries(hists);
+			} else {
+				hists__decay_entries(hists, t->hide_user_symbols,
+						     t->hide_kernel_symbols);
+			}
+		}
+
 		hists__collapse_resort(hists, NULL);
 
 		/* Non-group events are considered as leader */
@@ -319,16 +329,7 @@ static void perf_top__print_sym_table(struct perf_top *top)
 		return;
 	}
 
-	if (top->evlist->enabled) {
-		if (top->zero) {
-			hists__delete_entries(hists);
-		} else {
-			hists__decay_entries(hists, top->hide_user_symbols,
-					     top->hide_kernel_symbols);
-		}
-	}
-
-	evlist__resort_hists(top->evlist);
+	evlist__resort_hists(top);
 
 	hists__output_recalc_col_len(hists, top->print_entries - printed);
 	putchar('\n');
@@ -576,24 +577,11 @@ static bool perf_top__handle_keypress(struct perf_top *top, int c)
 static void perf_top__sort_new_samples(void *arg)
 {
 	struct perf_top *t = arg;
-	struct evsel *evsel = t->sym_evsel;
-	struct hists *hists;
 
 	if (t->evlist->selected != NULL)
 		t->sym_evsel = t->evlist->selected;
 
-	hists = evsel__hists(evsel);
-
-	if (t->evlist->enabled) {
-		if (t->zero) {
-			hists__delete_entries(hists);
-		} else {
-			hists__decay_entries(hists, t->hide_user_symbols,
-					     t->hide_kernel_symbols);
-		}
-	}
-
-	evlist__resort_hists(t->evlist);
+	evlist__resort_hists(t);
 
 	if (t->lost || t->drop)
 		pr_warning("Too slow to read ring buffer (change period (-c/-F) or limit CPUs (-C)\n");
-- 
2.23.0.187.g17f5b7556c-goog

