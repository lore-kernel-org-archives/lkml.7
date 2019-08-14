Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D38C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:43:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DAF82184E
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 18:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565808194;
	bh=59A965NaqewnSBFbtxkOVGqh2eGU5ziOsVA0+IqmPDc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qDUL+QTR/gdEMbHjf9DYlaRe6/eH7ulR8cTGn4vpqYfEAb7ZnTdkUyJ8hgSZNJaO+
	 VI6nsTy1105XHkB+yEZ+0cfRO3lxy31Ov2z3JE70HwNiq3tOvZ8QKMWFJxx7ysTpnr
	 iLHx9aHFLunBXDqWtEOJDPuLpHDcWBh2khaeyuKw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729209AbfHNSnN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 14:43:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:53874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728334AbfHNSnN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 14:43:13 -0400
Received: from quaco.ghostprotocols.net (unknown [177.195.212.110])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E31CB2084F;
        Wed, 14 Aug 2019 18:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565808192;
        bh=59A965NaqewnSBFbtxkOVGqh2eGU5ziOsVA0+IqmPDc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l5cQtB7S3+7i+FNH78Jat1C7RyJXslWJvK4ok2xy2rJEpp/TSTSuzgASbacRIu03k
         cH8zyhtJgOovYZ4c5JhZTJeF/wTU+59FAv5ZbYOzUbfY42Gy6LA1p7CrSPqU0ZFwSL
         veOBVW7jidCMDpDQmFsa9uKldBc5jnmBNwMMhvGw=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 10/28] perf hist: Remove dummy entries when finding real ones.
Date:   Wed, 14 Aug 2019 15:40:33 -0300
Message-Id: <20190814184051.3125-11-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190814184051.3125-1-acme@kernel.org>
References: <20190814184051.3125-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

When he have an event group we have multiple struct hist instances, one
per evsel, and in each of these hists we may have hist_entries that
point to the same thing being observed, say a symbol, i.e. if we're
looking at instructions and cycles, then we'll have one hist_entry in
the "instructions" evsel and another in the "cycles" evsel.

We need to link those to then show one column for each. When we're
looking at some other pair of events, say instructions and cache misses,
we may have just the "instructions" hist entry and not one for "cache
misses", as instructions not necessarily generate cache misses, as the
logic expects one hist_entry per evsel, we end up adding "dummy"
hist_entries.

This is enough for 'perf report', that does this matching operation
(hists__match()) just once after processing all events, but for 'perf
top', we do this at each refresh, so we may finally find events matching
and then we need to trow away the dummies and link with the real events.

So if we find a match, traverse the link of matches and trow away
dummies for that hists.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-dwvtjqqifsbsczeb35q6mqkk@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/hist.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index d923a5bb7b48..8efbf58dc3d0 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -2436,7 +2436,7 @@ void hists__match(struct hists *leader, struct hists *other)
 {
 	struct rb_root_cached *root;
 	struct rb_node *nd;
-	struct hist_entry *pos, *pair;
+	struct hist_entry *pos, *pair, *pos_pair, *tmp_pair;
 
 	if (symbol_conf.report_hierarchy) {
 		/* hierarchy report always collapses entries */
@@ -2453,8 +2453,24 @@ void hists__match(struct hists *leader, struct hists *other)
 		pos  = rb_entry(nd, struct hist_entry, rb_node_in);
 		pair = hists__find_entry(other, pos);
 
-		if (pair && list_empty(&pair->pairs.node))
+		if (pair && list_empty(&pair->pairs.node)) {
+			list_for_each_entry_safe(pos_pair, tmp_pair, &pos->pairs.head, pairs.node) {
+				if (pos_pair->hists == other) {
+					/*
+					 * XXX maybe decayed entries can appear
+					 * here?  but then we would have use
+					 * after free, as decayed entries are
+					 * freed see hists__delete_entry
+					 */
+					BUG_ON(!pos_pair->dummy);
+					list_del_init(&pos_pair->pairs.node);
+					hist_entry__delete(pos_pair);
+					break;
+				}
+			}
+
 			hist_entry__add_pair(pair, pos);
+		}
 	}
 }
 
-- 
2.21.0

