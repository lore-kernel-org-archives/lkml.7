Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F39C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9A2423407
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 14:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567089620;
	bh=Ho8Oc5u+JHX9vZ7HyWeX4jQAPj433FA+3BRHCamPKOM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FfwW7dTURK4Srm17BN/YBNUzl+8GzQWqHpO/SMAQZe8MnlAwt7sJaxaOGwJnoajbM
	 2w3eg5J2nuUoDixDVCj6eQMO5gHAe8phza1WMh1rWv01Ji5e8MKPkMG9DkAQbAun7g
	 IMlowafr52ES51m0f0QRKvw/ZhpH3UX9HEAJwM5o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728534AbfH2OkT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 10:40:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:44000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728109AbfH2OkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 10:40:17 -0400
Received: from quaco.ghostprotocols.net (unknown [179.97.35.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A66D023403;
        Thu, 29 Aug 2019 14:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567089615;
        bh=Ho8Oc5u+JHX9vZ7HyWeX4jQAPj433FA+3BRHCamPKOM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lRByh6/Ms4Iwf1W6i5XC4qR/uM5OncIW6yeazYsSNLjwIElmdRv//U0fsayJ9eYOe
         99UIbrOVwAsXgFvpHBoLNEV/F1eKMjAQyX1rpulp+11qZLM1E8BWO1V+oodpzjn56j
         uVRwBsp3uO30WmRyZfirILR/PiNmXP2yQ3l8wZMQ=
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>
Subject: [PATCH 11/37] perf top: Fix event group with more than two events
Date:   Thu, 29 Aug 2019 11:38:51 -0300
Message-Id: <20190829143917.29745-12-acme@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190829143917.29745-1-acme@kernel.org>
References: <20190829143917.29745-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Namhyung Kim <namhyung@kernel.org>

The event group feature links relevant hist entries among events so that
they can be displayed together.  During the link process, each hist
entry in non-leader events is connected to a hist entry in the leader
event.  This is done in order of events specified in the command line so
it assumes that events are linked in the order.

But 'perf top' can break the assumption since it does the link process
multiple times.  For example, a hist entry can be in the third event
only at first so it's linked after the leader.  Some time later, second
event has a hist entry for it and it'll be linked after the entry of the
third event.

This makes the code compilicated to deal with such unordered entries.
This patch simply unlink all the entries after it's printed so that they
can assume the correct order after the repeated link process.  Also it'd
be easy to deal with decaying old entries IMHO.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Reported-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190827231555.121411-2-namhyung@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-top.c |  6 ++++++
 tools/perf/util/hist.c   | 39 +++++++++++++++++++++------------------
 tools/perf/util/hist.h   |  1 +
 3 files changed, 28 insertions(+), 18 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 104dbb1095c5..c3f95440e99c 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -273,6 +273,12 @@ static void perf_top__resort_hists(struct perf_top *t)
 	evlist__for_each_entry(evlist, pos) {
 		struct hists *hists = evsel__hists(pos);
 
+		/*
+		 * unlink existing entries so that they can be linked
+		 * in a correct order in hists__match() below.
+		 */
+		hists__unlink(hists);
+
 		if (evlist->enabled) {
 			if (t->zero) {
 				hists__delete_entries(hists);
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index 33702675073c..e0b149673a88 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -2439,7 +2439,7 @@ void hists__match(struct hists *leader, struct hists *other)
 {
 	struct rb_root_cached *root;
 	struct rb_node *nd;
-	struct hist_entry *pos, *pair, *pos_pair, *tmp_pair;
+	struct hist_entry *pos, *pair;
 
 	if (symbol_conf.report_hierarchy) {
 		/* hierarchy report always collapses entries */
@@ -2456,24 +2456,8 @@ void hists__match(struct hists *leader, struct hists *other)
 		pos  = rb_entry(nd, struct hist_entry, rb_node_in);
 		pair = hists__find_entry(other, pos);
 
-		if (pair && list_empty(&pair->pairs.node)) {
-			list_for_each_entry_safe(pos_pair, tmp_pair, &pos->pairs.head, pairs.node) {
-				if (pos_pair->hists == other) {
-					/*
-					 * XXX maybe decayed entries can appear
-					 * here?  but then we would have use
-					 * after free, as decayed entries are
-					 * freed see hists__delete_entry
-					 */
-					BUG_ON(!pos_pair->dummy);
-					list_del_init(&pos_pair->pairs.node);
-					hist_entry__delete(pos_pair);
-					break;
-				}
-			}
-
+		if (pair)
 			hist_entry__add_pair(pair, pos);
-		}
 	}
 }
 
@@ -2558,6 +2542,25 @@ int hists__link(struct hists *leader, struct hists *other)
 	return 0;
 }
 
+int hists__unlink(struct hists *hists)
+{
+	struct rb_root_cached *root;
+	struct rb_node *nd;
+	struct hist_entry *pos;
+
+	if (hists__has(hists, need_collapse))
+		root = &hists->entries_collapsed;
+	else
+		root = hists->entries_in;
+
+	for (nd = rb_first_cached(root); nd; nd = rb_next(nd)) {
+		pos = rb_entry(nd, struct hist_entry, rb_node_in);
+		list_del_init(&pos->pairs.node);
+	}
+
+	return 0;
+}
+
 void hist__account_cycles(struct branch_stack *bs, struct addr_location *al,
 			  struct perf_sample *sample, bool nonany_branch_mode)
 {
diff --git a/tools/perf/util/hist.h b/tools/perf/util/hist.h
index 83d5fc15429c..7b9267ebebeb 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -217,6 +217,7 @@ void hists__calc_col_len(struct hists *hists, struct hist_entry *he);
 
 void hists__match(struct hists *leader, struct hists *other);
 int hists__link(struct hists *leader, struct hists *other);
+int hists__unlink(struct hists *hists);
 
 struct hists_evsel {
 	struct evsel evsel;
-- 
2.21.0

