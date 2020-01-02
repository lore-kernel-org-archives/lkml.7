Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18849C2D0DD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 07:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D6113217F4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 07:31:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbgABH07 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 02:26:59 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8209 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726078AbgABH06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 02:26:58 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D8213B520C4810FCD4B7;
        Thu,  2 Jan 2020 15:26:55 +0800 (CST)
Received: from euler.huawei.com (10.175.104.193) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.439.0; Thu, 2 Jan 2020 15:26:49 +0800
From:   Wei Li <liwei391@huawei.com>
To:     <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <suzuki.poulose@arm.com>,
        <mathieu.poirier@linaro.org>, <ilubashe@akamai.com>
CC:     <peterz@infradead.org>, <mingo@redhat.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <huawei.libin@huawei.com>
Subject: [RFC PATCH] perf tools: cs-etm: fix endless record after being terminated
Date:   Thu, 2 Jan 2020 15:41:44 +0800
Message-ID: <20200102074144.10407-1-liwei391@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.104.193]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In __cmd_record(), when receiving SIGINT(ctrl + c), a done flag will
be set and the event list will be disabled by evlist__disable() once.

While in auxtrace_record.read_finish(), the related events will be
enabled again, if they are continuous, the recording seems to be endless.

If the cs_etm event is disabled, we don't enable it again here.

Note: This patch is NOT tested since i don't have such a machine with
coresight feature, but the code seems buggy same as arm-spe and intel-pt.

Signed-off-by: Wei Li <liwei391@huawei.com>
---
 tools/perf/arch/arm/util/cs-etm.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index ede040cf82ad..1893a0e3b1e1 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -865,9 +865,13 @@ static int cs_etm_read_finish(struct auxtrace_record *itr, int idx)
 	struct evsel *evsel;
 
 	evlist__for_each_entry(ptr->evlist, evsel) {
-		if (evsel->core.attr.type == ptr->cs_etm_pmu->type)
-			return perf_evlist__enable_event_idx(ptr->evlist,
-							     evsel, idx);
+		if (evsel->core.attr.type == ptr->cs_etm_pmu->type) {
+			if (evsel->disabled)
+				return 0;
+			else
+				return perf_evlist__enable_event_idx(
+						ptr->evlist, evsel, idx);
+		}
 	}
 
 	return -EINVAL;
-- 
2.17.1

