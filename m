Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C574C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 19:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BE3C2189D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 19:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728685AbfH2TCB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 15:02:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51358 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727437AbfH2TB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 15:01:58 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i3Pg7-00055c-Bk; Thu, 29 Aug 2019 21:01:51 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id CDD7C1C07C3;
        Thu, 29 Aug 2019 21:01:50 +0200 (CEST)
Date:   Thu, 29 Aug 2019 19:01:50 -0000
From:   "tip-bot2 for Namhyung Kim" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf top: Fix event group with more than two events
Cc:     Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
In-Reply-To: <20190827231555.121411-2-namhyung@kernel.org>
References: <20190827231555.121411-2-namhyung@kernel.org>
MIME-Version: 1.0
Message-ID: <156710531069.10538.8108779182336952593.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     be5863b7d9281bbb932542d16b7d758357fde267
Gitweb:        https://git.kernel.org/tip/be5863b7d9281bbb932542d16b7d758357fde267
Author:        Namhyung Kim <namhyung@kernel.org>
AuthorDate:    Wed, 28 Aug 2019 08:15:55 +09:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Wed, 28 Aug 2019 18:15:03 -03:00

perf top: Fix event group with more than two events

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
 tools/perf/builtin-top.c |  6 ++++++-
 tools/perf/util/hist.c   | 39 +++++++++++++++++++++------------------
 tools/perf/util/hist.h   |  1 +-
 3 files changed, 28 insertions(+), 18 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 104dbb1..c3f9544 100644
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
index 3370267..e0b1496 100644
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
index 83d5fc1..7b9267e 100644
--- a/tools/perf/util/hist.h
+++ b/tools/perf/util/hist.h
@@ -217,6 +217,7 @@ void hists__calc_col_len(struct hists *hists, struct hist_entry *he);
 
 void hists__match(struct hists *leader, struct hists *other);
 int hists__link(struct hists *leader, struct hists *other);
+int hists__unlink(struct hists *hists);
 
 struct hists_evsel {
 	struct evsel evsel;
