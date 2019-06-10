Return-Path: <SRS0=f7FU=UJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7A36C282DD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 10:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C69962082E
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Jun 2019 10:01:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389180AbfFJKBS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Jun 2019 06:01:18 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:56598 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388056AbfFJKBN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jun 2019 06:01:13 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 1ECBB6C34D3F6266CAEF;
        Mon, 10 Jun 2019 18:01:11 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.439.0; Mon, 10 Jun 2019 18:00:52 +0800
From:   John Garry <john.garry@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <tmricht@linux.ibm.com>,
        <brueckner@linux.ibm.com>, <kan.liang@linux.intel.com>,
        <ben@decadent.org.uk>, <mathieu.poirier@linaro.org>,
        <mark.rutland@arm.com>, <will.deacon@arm.com>
CC:     <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <zhangshaokun@hisilicon.com>, <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 2/5] perf pmu: Support more complex PMU event aliasing
Date:   Mon, 10 Jun 2019 17:59:29 +0800
Message-ID: <1560160772-210844-3-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1560160772-210844-1-git-send-email-john.garry@huawei.com>
References: <1560160772-210844-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.212.75]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The jevent "Unit" field is used for uncore PMU alias definition.

The form uncore_pmu_example_X is supported, where "X" is a wildcard,
to support multiple instances of the same PMU in a system.

Unfortunately this format not suitable for all uncore PMUs; take the Hisi
DDRC uncore PMU for example, where the name is in the form
hisi_scclX_ddrcY.

For the current jevent parsing, we would be required to hardcode an uncore
alias translation for each possible value of X. This is not scalable.

Instead, add support for "Unit" field in the form "hisi_sccl,ddrc", where
we can match by hisi_scclX and ddrcY. Tokens in Unit field
are delimited by ','.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 tools/perf/util/pmu.c | 45 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 40 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 036047f56efa..f00cae750086 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -700,6 +700,44 @@ struct pmu_events_map *perf_pmu__find_map(struct perf_pmu *pmu)
 	return map;
 }
 
+static bool pmu_uncore_alias_match(const char *pmu_name, const char *name)
+{
+	/*
+	 * uncore alias may be from different PMU
+	 * with common prefix
+	 */
+	if (!strncmp(pmu_name, name, strlen(pmu_name)))
+		return true;
+
+	/* match strings with delimiter, ',' */
+	while (1) {
+		const char *delimiter;
+		char token[256] = {};
+		const char *found_token;
+		int token_len;
+
+		delimiter = strchr(pmu_name, ',');
+		if (delimiter) {
+			token_len = delimiter - pmu_name;
+		} else {
+			token_len = strlen(pmu_name);
+		}
+
+		memcpy(token, pmu_name, token_len);
+
+		found_token = strstr(name, token);
+		if (!found_token)
+			return false;
+
+		/* No more delimiters, so we must be a match */
+		if (!delimiter)
+			return true;
+
+		pmu_name += token_len + 1;
+		name = found_token + token_len;
+	}
+}
+
 /*
  * From the pmu_events_map, find the table of PMU events that corresponds
  * to the current running CPU. Then, add all PMU events from that table
@@ -730,12 +768,9 @@ static void pmu_add_cpu_aliases(struct list_head *head, struct perf_pmu *pmu)
 			break;
 		}
 
-		/*
-		 * uncore alias may be from different PMU
-		 * with common prefix
-		 */
+
 		if (pmu_is_uncore(name) &&
-		    !strncmp(pname, name, strlen(pname)))
+		    pmu_uncore_alias_match(pname, name))
 			goto new_alias;
 
 		if (strcmp(pname, name))
-- 
2.17.1

