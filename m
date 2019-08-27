Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4487EC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 23:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 124BD20856
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 23:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566947766;
	bh=9jMpmqKYdS6wxNelbrfMFKsuc8MlK4oRw4YXwrh8W8A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bh1KThz20i2RicMivWme+EfdZtNOFatlc2MZECbw/Z+c3UunwnUiX6FCLOqFPRrXd
	 BPmp6L8Q0zgnpdTsWh4rHIRHxRBWp5RKtnbFuXY8qSTTBQDmKog6Z/JgwAswV9mhEO
	 NNXKZW4k3Pt+t1BmZ4UhVPuy+RebrGamuo0yAgJM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbfH0XQF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 19:16:05 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:34943 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbfH0XQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 19:16:03 -0400
Received: by mail-pl1-f193.google.com with SMTP id gn20so277106plb.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 16:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q4+SA5PuF2L2C1z7Pk2rFeuDa5r87TSCdNqKzP/FHYs=;
        b=FRFD5j1ZbNMCjzpMcf2CyTX4GtUdzR11z9CXlUw/YmLUNVFOm8b5Vk5ZOtm5aX6Yxk
         OF8a9BeiDBKFeR3PCqrUMf9yPnqjXby1qQEFkxgXMBv60kNGAwBjyFU72uMM20CuNOqp
         OKxZdys9ciYVvj4WewKJPIkxDTiW1KWCTyscxyjeuYK9MQveyH40P/EknJ8AJIg/Nxiw
         tPIDhsTtKXLHypNz1d9Wr3QUNAfkWTULeReMm8nXtY75eXTGpeZ1IcfvTwZNGbwHfMPF
         f3VwD5zFqhLjCVTDx/056gZTi3RJ+utOcM9poj2lMnQhdbrfgBBu/9V2qlPRPH643nrL
         H9qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Q4+SA5PuF2L2C1z7Pk2rFeuDa5r87TSCdNqKzP/FHYs=;
        b=KjTJbPq6BjKiJggYUhobo919lrUW7wIAot+5I2R8UPdl9/ZBEAxre/waUWQYN0KmOy
         cBYTD+olyc1TmoK8x2YPNOA+IDHwVEwfeJf0ysNBHNKXN6M3mKwKVv1A39I3uGw0a8/C
         eP90kWpyezDhr4qFYm8qQMVfSlUMG8ZE5SgErpX7gVhKJSt2oz15oMl4hvSG+2NeiRJ5
         z9iNdBmc69++7S0gnkC7dwVl1M0hKwdaXgpC5fQFYfYjZRtgC6ECZ6kt9EaqLWr/YlAA
         VbG+ccAeIsdHVDzVySk4HEKzIiuVx4ffv94hsUd4P2gxDVYQdKQHI6cJuQMZCwur5YP1
         bVMA==
X-Gm-Message-State: APjAAAXOc7+JQcV2vvzQfJZk5zVjq1dcuZQIQi3OFW6T9ZC6BsRa2/iA
        Z3oU/RXt/To2mv/E9QADhIw=
X-Google-Smtp-Source: APXvYqx3ES2+v7wddOdGpkdqCH9XAtzUSfRgRFn2ibcze6Uc+szWjQmHe3RYWaLIea3uGLpl7zALMw==
X-Received: by 2002:a17:902:d883:: with SMTP id b3mr1409423plz.323.1566947762105;
        Tue, 27 Aug 2019 16:16:02 -0700 (PDT)
Received: from gaurie.seo.corp.google.com ([2401:fa00:d:0:1034:ec6b:8056:9e93])
        by smtp.gmail.com with ESMTPSA id a10sm411624pfl.159.2019.08.27.16.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2019 16:16:01 -0700 (PDT)
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, Jiri Olsa <jolsa@redhat.com>
Subject: [PATCH 2/2] perf top: Fix event group with more than two events
Date:   Wed, 28 Aug 2019 08:15:55 +0900
Message-Id: <20190827231555.121411-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.23.0.187.g17f5b7556c-goog
In-Reply-To: <20190827231555.121411-1-namhyung@kernel.org>
References: <20190827231555.121411-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The event group feature links relevant hist entries among events so
that they can be displayed together.  During the link process, each
hist entry in non-leader events is connected to a hist entry in the
leader event.  This is done in order of events specified in the
command line so it assumes that events are linked in the order.

But perf top can break the assumption since it does the link process
multiple times.  For example, a hist entry can be in the third event
only at first so it's linked after the leader.  Some time later,
second event has a hist entry for it and it'll be linked after the
entry of the third event.

This makes the code compilicated to deal with such unordered entries.
This patch simply unlink all the entries after it's printed so that
they can assume the correct order after the repeated link process.
Also it'd be easy to deal with decaying old entries IMHO.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-top.c |  6 ++++++
 tools/perf/util/hist.c   | 39 +++++++++++++++++++++------------------
 tools/perf/util/hist.h   |  1 +
 3 files changed, 28 insertions(+), 18 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 9d3059d2029d..b871dd72e4bd 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -272,6 +272,12 @@ static void evlist__resort_hists(struct perf_top *t)
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
index 8efbf58dc3d0..47401210e087 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -2436,7 +2436,7 @@ void hists__match(struct hists *leader, struct hists *other)
 {
 	struct rb_root_cached *root;
 	struct rb_node *nd;
-	struct hist_entry *pos, *pair, *pos_pair, *tmp_pair;
+	struct hist_entry *pos, *pair;
 
 	if (symbol_conf.report_hierarchy) {
 		/* hierarchy report always collapses entries */
@@ -2453,24 +2453,8 @@ void hists__match(struct hists *leader, struct hists *other)
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
 
@@ -2555,6 +2539,25 @@ int hists__link(struct hists *leader, struct hists *other)
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
2.23.0.187.g17f5b7556c-goog

