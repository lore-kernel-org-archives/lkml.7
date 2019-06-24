Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B7FEC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 19:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EC1020663
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 19:37:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730619AbfFXThk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 15:37:40 -0400
Received: from mga14.intel.com ([192.55.52.115]:47562 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728892AbfFXThV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 15:37:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jun 2019 12:37:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,413,1557212400"; 
   d="scan'208";a="172093776"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by orsmga002.jf.intel.com with ESMTP; 24 Jun 2019 12:37:20 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 507B230209E; Mon, 24 Jun 2019 12:37:20 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     jolsa@kernel.org, kan.liang@intel.com,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v1 1/4] perf stat: Make metric event lookup more robust
Date:   Mon, 24 Jun 2019 12:37:08 -0700
Message-Id: <20190624193711.35241-2-andi@firstfloor.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190624193711.35241-1-andi@firstfloor.org>
References: <20190624193711.35241-1-andi@firstfloor.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andi Kleen <ak@linux.intel.com>

After setting up metric groups through the event parser,
the metricgroup code looks them up again in the event list.

Make sure we only look up events that haven't been used
by some other metric. The data structures currently cannot
handle more than one metric per event. This avoids problems with
multiple events partially overlapping.

Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/util/stat-shadow.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/stat-shadow.c b/tools/perf/util/stat-shadow.c
index 027b09aaa4cf..3f8fd127d31e 100644
--- a/tools/perf/util/stat-shadow.c
+++ b/tools/perf/util/stat-shadow.c
@@ -304,7 +304,7 @@ static struct perf_evsel *perf_stat__find_event(struct perf_evlist *evsel_list,
 	struct perf_evsel *c2;
 
 	evlist__for_each_entry (evsel_list, c2) {
-		if (!strcasecmp(c2->name, name))
+		if (!strcasecmp(c2->name, name) && !c2->collect_stat)
 			return c2;
 	}
 	return NULL;
@@ -343,7 +343,8 @@ void perf_stat__collect_metric_expr(struct perf_evlist *evsel_list)
 			if (leader) {
 				/* Search in group */
 				for_each_group_member (oc, leader) {
-					if (!strcasecmp(oc->name, metric_names[i])) {
+					if (!strcasecmp(oc->name, metric_names[i]) &&
+						!oc->collect_stat) {
 						found = true;
 						break;
 					}
-- 
2.20.1

