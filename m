Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A3FC31E4C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 14:09:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C43EC2173C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 14:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728804AbfFNOJg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 10:09:36 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:48062 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728616AbfFNOJd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 10:09:33 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id E1D6B358CEDAD55C03A2;
        Fri, 14 Jun 2019 22:09:29 +0800 (CST)
Received: from localhost.localdomain (10.67.212.75) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Fri, 14 Jun 2019 22:09:23 +0800
From:   John Garry <john.garry@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <tmricht@linux.ibm.com>,
        <brueckner@linux.ibm.com>, <kan.liang@linux.intel.com>,
        <ben@decadent.org.uk>, <mathieu.poirier@linaro.org>,
        <mark.rutland@arm.com>, <will.deacon@arm.com>
CC:     <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <zhangshaokun@hisilicon.com>, "John Garry" <john.garry@huawei.com>
Subject: [PATCH v2 2/5] perf pmu: Support more complex PMU event aliasing
Date:   Fri, 14 Jun 2019 22:08:00 +0800
Message-ID: <1560521283-73314-3-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1560521283-73314-1-git-send-email-john.garry@huawei.com>
References: <1560521283-73314-1-git-send-email-john.garry@huawei.com>
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
we can match by hisi_scclX and ddrcY. Tokens in Unit field are 
delimited by ','.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 tools/perf/util/pmu.c | 39 ++++++++++++++++++++++++++++++++++-----
 1 file changed, 34 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 7e7299fee550..bc71c60589b5 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -700,6 +700,39 @@ struct pmu_events_map *perf_pmu__find_map(struct perf_pmu *pmu)
 	return map;
 }
 
+static bool pmu_uncore_alias_match(const char *pmu_name, const char *name)
+{
+	char *tmp, *tok, *str;
+	bool res;
+
+	str = strdup(pmu_name);
+	if (!str)
+		return false;
+
+	/*
+	 * uncore alias may be from different PMU with common
+	 * prefix or matching tokens.
+	 */
+	tok = strtok_r(str, ",", &tmp);
+	if (strncmp(pmu_name, tok, strlen(tok))) {
+		res = false;
+		goto out;
+	}
+
+	for (; tok; name += strlen(tok), tok = strtok_r(NULL, ",", &tmp)) {
+		name = strstr(name, tok);
+		if (!name) {
+			res = false;
+			goto out;
+		}
+	}
+
+	res = true;
+out:
+	free(str);
+	return res;
+}
+
 /*
  * From the pmu_events_map, find the table of PMU events that corresponds
  * to the current running CPU. Then, add all PMU events from that table
@@ -730,12 +763,8 @@ static void pmu_add_cpu_aliases(struct list_head *head, struct perf_pmu *pmu)
 			break;
 		}
 
-		/*
-		 * uncore alias may be from different PMU
-		 * with common prefix
-		 */
 		if (pmu_is_uncore(name) &&
-		    !strncmp(pname, name, strlen(pname)))
+		    pmu_uncore_alias_match(pname, name))
 			goto new_alias;
 
 		if (strcmp(pname, name))
-- 
2.17.1

