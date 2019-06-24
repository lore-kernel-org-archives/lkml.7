Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE39DC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 19:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95F5520663
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 19:37:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730654AbfFXTho (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 15:37:44 -0400
Received: from mga01.intel.com ([192.55.52.88]:58846 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729421AbfFXThV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 15:37:21 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Jun 2019 12:37:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,413,1557212400"; 
   d="scan'208";a="169538638"
Received: from tassilo.jf.intel.com (HELO tassilo.localdomain) ([10.7.201.137])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Jun 2019 12:37:20 -0700
Received: by tassilo.localdomain (Postfix, from userid 1000)
        id 566AB302116; Mon, 24 Jun 2019 12:37:20 -0700 (PDT)
From:   Andi Kleen <andi@firstfloor.org>
To:     acme@kernel.org
Cc:     jolsa@kernel.org, kan.liang@intel.com,
        linux-kernel@vger.kernel.org, Andi Kleen <ak@linux.intel.com>
Subject: [PATCH v1 2/4] perf stat: Don't merge events in the same PMU
Date:   Mon, 24 Jun 2019 12:37:09 -0700
Message-Id: <20190624193711.35241-3-andi@firstfloor.org>
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

Event merging is mainly to collapse similar events in lots of
different duplicated PMUs.

It can break metric displaying. It's possible for two metrics
to have the same event, and when the two events happen in a row
the second wouldn't be displayed.  This would also not
show the second metric.

To avoid this don't merge events in the same PMU. This makes
sense, if we have multiple events in the same PMU there is
likely some reason for it (e.g. using multiple groups)
and we better not merge them.

While in theory it would be possible to construct metrics
that have events with the same name in different PMU no
current metrics have this problem.

This is the fix for perf stat -M UPI,IPC (needs also
another bug fix to completely work)

Fixes: 430daf2dc7af ("perf stat: Collapse identically ...")
Signed-off-by: Andi Kleen <ak@linux.intel.com>
---
 tools/perf/util/stat-display.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index a6b9de3e83fc..91d62fd6607f 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -555,7 +555,8 @@ static void collect_all_aliases(struct perf_stat_config *config, struct perf_evs
 		    alias->scale != counter->scale ||
 		    alias->cgrp != counter->cgrp ||
 		    strcmp(alias->unit, counter->unit) ||
-		    perf_evsel__is_clock(alias) != perf_evsel__is_clock(counter))
+		    perf_evsel__is_clock(alias) != perf_evsel__is_clock(counter) ||
+		    !strcmp(alias->pmu_name, counter->pmu_name))
 			break;
 		alias->merged_stat = true;
 		cb(config, alias, data, false);
-- 
2.20.1

