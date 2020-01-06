Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7BAAC33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 16:08:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93E94214D8
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 16:08:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578326884;
	bh=hgaHiT4Crc/EJVHqxNiiiW60LLA6D9fq4ygzo1r7s/s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RM2iAhN2ArfQBUjHHA4gElnrcf5VEzRr4d7zzVkHhgmLsTGSjR9+xb3S7Jiey+Yei
	 8fiL5NtDZVvOQRsR/NDvCxLDqUiecL3pFSxBC3cG95tqQy/yvGOw9KEVjKD5SGKw9N
	 bxpFwJEz/9TcoqnSF47X75wUb/9otDEQX2d2sdQk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727207AbgAFQID (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 11:08:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:46178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727165AbgAFQH7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 11:07:59 -0500
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D9F12081E;
        Mon,  6 Jan 2020 16:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578326879;
        bh=hgaHiT4Crc/EJVHqxNiiiW60LLA6D9fq4ygzo1r7s/s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FUVFXVj4uAn56hVvm8EpFEEQYRr0xGgC6Z4xCKD+C67Wk/C8288Y+OIdKWDuaU4Nu
         oGI9XROpqFbBj9kDimVSqv6BxFqxtTx+jXrrOF+3Ubx4krnXFdFi12+m7c6e+L658A
         aD497BuJGaVLXsdyUUm6vXxi2QOl9XoDqtnHEduo=
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
Subject: [PATCH 12/20] perf report/top: Improve toggle callchain menu option
Date:   Mon,  6 Jan 2020 13:06:57 -0300
Message-Id: <20200106160705.10899-13-acme@kernel.org>
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

Taking into account the current status of the callchain, i.e. if folded,
show "Expand", otherwise "Collapse", also show the name of the entry
that will be affected and mention the hotkeys for expanding/collapsing
all callchains below the main entry, the one that appears with/without
callchains.

Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-03arm6poo8463k5tfcfp7gkk@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/hists.c | 54 ++++++++++++++++++++++++++++++++--
 tools/perf/util/sort.c         |  3 +-
 tools/perf/util/sort.h         |  2 ++
 3 files changed, 54 insertions(+), 5 deletions(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 1b5a5990dddb..a4413d983216 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -391,6 +391,52 @@ static void hist_entry__init_have_children(struct hist_entry *he)
 	he->init_have_children = true;
 }
 
+static bool hist_browser__selection_has_children(struct hist_browser *browser)
+{
+	struct hist_entry *he = browser->he_selection;
+	struct map_symbol *ms = browser->selection;
+
+	if (!he || !ms)
+		return false;
+
+	if (ms == &he->ms)
+	       return he->has_children;
+
+	return container_of(ms, struct callchain_list, ms)->has_children;
+}
+
+static bool hist_browser__selection_unfolded(struct hist_browser *browser)
+{
+	struct hist_entry *he = browser->he_selection;
+	struct map_symbol *ms = browser->selection;
+
+	if (!he || !ms)
+		return false;
+
+	if (ms == &he->ms)
+	       return he->unfolded;
+
+	return container_of(ms, struct callchain_list, ms)->unfolded;
+}
+
+static char *hist_browser__selection_sym_name(struct hist_browser *browser, char *bf, size_t size)
+{
+	struct hist_entry *he = browser->he_selection;
+	struct map_symbol *ms = browser->selection;
+	struct callchain_list *callchain_entry;
+
+	if (!he || !ms)
+		return NULL;
+
+	if (ms == &he->ms) {
+	       hist_entry__sym_snprintf(he, bf, size, 0);
+	       return bf + 4; // skip the level, e.g. '[k] '
+	}
+
+	callchain_entry = container_of(ms, struct callchain_list, ms);
+	return callchain_list__sym_name(callchain_entry, bf, size, browser->show_dso);
+}
+
 static bool hist_browser__toggle_fold(struct hist_browser *browser)
 {
 	struct hist_entry *he = browser->he_selection;
@@ -2535,12 +2581,14 @@ static int do_toggle_callchain(struct hist_browser *browser, struct popup_action
 
 static int add_callchain_toggle_opt(struct hist_browser *browser, struct popup_action *act, char **optstr)
 {
-	struct hist_entry *he = browser->he_selection;
+	char sym_name[512];
 
-        if (!he->has_children)
+        if (!hist_browser__selection_has_children(browser))
                 return 0;
 
-	if (asprintf(optstr, "Expand/Collapse callchain") < 0)
+	if (asprintf(optstr, "%s [%s] callchain (one level, same as '+' hotkey, use 'e'/'c' for the whole main level entry)",
+		     hist_browser__selection_unfolded(browser) ? "Collapse" : "Expand",
+		     hist_browser__selection_sym_name(browser, sym_name, sizeof(sym_name))) < 0)
 		return 0;
 
 	act->fn = do_toggle_callchain;
diff --git a/tools/perf/util/sort.c b/tools/perf/util/sort.c
index 9fcba2872130..ab0cfd790ad0 100644
--- a/tools/perf/util/sort.c
+++ b/tools/perf/util/sort.c
@@ -324,8 +324,7 @@ static int _hist_entry__sym_snprintf(struct map_symbol *ms,
 	return ret;
 }
 
-static int hist_entry__sym_snprintf(struct hist_entry *he, char *bf,
-				    size_t size, unsigned int width)
+int hist_entry__sym_snprintf(struct hist_entry *he, char *bf, size_t size, unsigned int width)
 {
 	return _hist_entry__sym_snprintf(&he->ms, he->ip,
 					 he->level, bf, size, width);
diff --git a/tools/perf/util/sort.h b/tools/perf/util/sort.h
index 5aff9542d9b7..6c862d62d052 100644
--- a/tools/perf/util/sort.h
+++ b/tools/perf/util/sort.h
@@ -164,6 +164,8 @@ static __pure inline bool hist_entry__has_callchains(struct hist_entry *he)
 	return he->callchain_size != 0;
 }
 
+int hist_entry__sym_snprintf(struct hist_entry *he, char *bf, size_t size, unsigned int width);
+
 static inline bool hist_entry__has_pairs(struct hist_entry *he)
 {
 	return !list_empty(&he->pairs.node);
-- 
2.21.1

