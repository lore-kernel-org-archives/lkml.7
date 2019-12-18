Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD761C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 07:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D35F24676
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 07:09:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726797AbfLRHJD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 02:09:03 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:7709 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726770AbfLRHJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 02:09:02 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 2DAED86B10199297F637;
        Wed, 18 Dec 2019 15:09:01 +0800 (CST)
Received: from huawei.com (10.175.102.38) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Wed, 18 Dec 2019
 15:08:51 +0800
From:   Tan Xiaojun <tanxiaojun@huawei.com>
To:     <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <ak@linux.intel.com>,
        <adrian.hunter@intel.com>, <yao.jin@linux.intel.com>,
        <tmricht@linux.ibm.com>, <brueckner@linux.ibm.com>,
        <songliubraving@fb.com>, <gregkh@linuxfoundation.org>,
        <kim.phillips@arm.com>, <James.Clark@arm.com>,
        <jeremy.linton@arm.com>
CC:     <gengdongjiu@huawei.com>, <wxf.wang@hisilicon.com>,
        <liwei391@huawei.com>, <tanxiaojun@huawei.com>,
        <liuqi115@hisilicon.com>, <huawei.libin@huawei.com>,
        <linux-kernel@vger.kernel.org>, <linux-perf-users@vger.kernel.org>
Subject: [PATCH 6/6] perf tools: arm-spe: fix record hang after being terminated
Date:   Wed, 18 Dec 2019 15:54:55 +0800
Message-ID: <20191218075455.5106-7-tanxiaojun@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191218075455.5106-1-tanxiaojun@huawei.com>
References: <20191218075455.5106-1-tanxiaojun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.38]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Li <liwei391@huawei.com>

If the spe event is terminated, we don't enable it again here.

Signed-off-by: Wei Li <liwei391@huawei.com>
Tested-by: Qi Liu <liuqi115@hisilicon.com>
---
 tools/perf/arch/arm64/util/arm-spe.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index eba6541ec0f1..629badda724d 100644
--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -165,9 +165,13 @@ static int arm_spe_read_finish(struct auxtrace_record *itr, int idx)
 	struct evsel *evsel;
 
 	evlist__for_each_entry(sper->evlist, evsel) {
-		if (evsel->core.attr.type == sper->arm_spe_pmu->type)
-			return perf_evlist__enable_event_idx(sper->evlist,
-							     evsel, idx);
+		if (evsel->core.attr.type == sper->arm_spe_pmu->type) {
+			if (evsel->terminated)
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

