Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1382BC2D0DD
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 07:26:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7F72215A4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 07:26:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727635AbgABH0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 02:26:47 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:48658 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726078AbgABH0r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 02:26:47 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5C13057D9FC402064E4E;
        Thu,  2 Jan 2020 15:26:44 +0800 (CST)
Received: from euler.huawei.com (10.175.104.193) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.439.0; Thu, 2 Jan 2020 15:26:35 +0800
From:   Wei Li <liwei391@huawei.com>
To:     <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <suzuki.poulose@arm.com>,
        <mathieu.poirier@linaro.org>, <ilubashe@akamai.com>
CC:     <peterz@infradead.org>, <mingo@redhat.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <huawei.libin@huawei.com>
Subject: [PATCH] perf tools: arm-spe: fix endless record after being terminated
Date:   Thu, 2 Jan 2020 15:40:34 +0800
Message-ID: <20200102074034.38650-1-liwei391@huawei.com>
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

If the arm_spe event is disabled, we don't enable it again here.

Before the patch:
[root@localhost ~]# ./perf record -e arm_spe_0/ts_enable=1,pct_enable=1,\
pa_enable=1,load_filter=1,jitter=1,store_filter=1,min_latency=0/ -p 5387
^C^C^C^C^C^C

After the patch:
[root@localhost ~]# ./perf record -e arm_spe_0/ts_enable=1,pct_enable=1,\
pa_enable=1,load_filter=1,jitter=1,store_filter=1,min_latency=0/ -p 5387
^C[ perf record: Woken up 0 times to write data ]
Warning:
AUX data lost 255 times out of 789!

[ perf record: Captured and wrote 1020.719 MB perf.data ]

Signed-off-by: Wei Li <liwei391@huawei.com>
---
 tools/perf/arch/arm64/util/arm-spe.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index eba6541ec0f1..d1ff278a8ab2 100644
--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -165,9 +165,13 @@ static int arm_spe_read_finish(struct auxtrace_record *itr, int idx)
 	struct evsel *evsel;
 
 	evlist__for_each_entry(sper->evlist, evsel) {
-		if (evsel->core.attr.type == sper->arm_spe_pmu->type)
-			return perf_evlist__enable_event_idx(sper->evlist,
-							     evsel, idx);
+		if (evsel->core.attr.type == sper->arm_spe_pmu->type) {
+			if (evsel->disabled)
+				return 0;
+			else
+				return perf_evlist__enable_event_idx(
+						sper->evlist, evsel, idx);
+		}
 	}
 	return -EINVAL;
 }
-- 
2.17.1

