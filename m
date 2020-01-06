Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F650C33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 16:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FE6C24676
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 16:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578326902;
	bh=1dtFPI0xTgg3vRqQHwHkdJuFx/UPVAIvC5B1KR3o97A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xDeKRmBv810T7L8H409S2KwBng3Wr+KWDBtT49K6ktJ+ATaW36VdRGh5IJU60mS0f
	 m1Jes44kZNZomPWhp+KIj6OQHjed4y93Yx3ui9lDJ76e2i7EVd3qFZGa7GfYNSWhlN
	 C9ws5ScQV/psrL/xne05POBbgdP9Hb45fq3PI4+k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbgAFQIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 11:08:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:46912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727266AbgAFQIR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 11:08:17 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D35A920848;
        Mon,  6 Jan 2020 16:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578326896;
        bh=1dtFPI0xTgg3vRqQHwHkdJuFx/UPVAIvC5B1KR3o97A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y/9R1AYy2rgn5V8hIch6Me6mM0JPEgjSirXp2bEp4DBPJi5YvrG2spzBoVBAgAgo6
         aNPp//ZY6GgVd01Sx2o7PuC2NFrTf+o7YeWGBRWagiUIiZLq8Fp9TZqvCwJ9Yvjw+Y
         uyyh7QfxED1Wkk+IwYLc5B+AHZCG77gvNK2DZPgc=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 17/20] perf report/top: Allow pressing hotkeys in the options popup menu
Date:   Mon,  6 Jan 2020 13:07:02 -0300
Message-Id: <20200106160705.10899-18-acme@kernel.org>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200106160705.10899-1-acme@kernel.org>
References: <20200106160705.10899-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

When the users presses ENTER in the main 'perf report/top' screen a
popup menu is presented, in it some hotkeys are suggested as
alternatives to using the menu, or for additional features.

At that point the user may try those hotkeys, so allow for that by
recording the key used and exiting, the caller then can check for that
possibility and process the hotkey.

I.e. try pressing ENTER, and then 'k' to exit and zoom into the kernel
map, using ESC then zooms out, etc.

Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-ujfq3fw44kf6qrtfajl5dcsp@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/hists.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index c44b508f9e06..8776b1cb29b7 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -2995,12 +2995,13 @@ static int perf_evsel__hists_browse(struct evsel *evsel, int nr_events,
 	while (1) {
 		struct thread *thread = NULL;
 		struct map *map = NULL;
-		int choice = 0;
+		int choice;
 		int socked_id = -1;
 
-		nr_options = 0;
-
-		key = hist_browser__run(browser, helpline, warn_lost_event, 0);
+		key = 0; // reset key
+do_hotkey:		 // key came straight from options ui__popup_menu()
+		choice = nr_options = 0;
+		key = hist_browser__run(browser, helpline, warn_lost_event, key);
 
 		if (browser->he_selection != NULL) {
 			thread = hist_browser__selected_thread(browser);
@@ -3279,10 +3280,13 @@ static int perf_evsel__hists_browse(struct evsel *evsel, int nr_events,
 		do {
 			struct popup_action *act;
 
-			choice = ui__popup_menu(nr_options, options, NULL);
-			if (choice == -1 || choice >= nr_options)
+			choice = ui__popup_menu(nr_options, options, &key);
+			if (choice == -1)
 				break;
 
+			if (choice == nr_options)
+				goto do_hotkey;
+
 			act = &actions[choice];
 			key = act->fn(browser, act);
 		} while (key == 1);
-- 
2.21.1

