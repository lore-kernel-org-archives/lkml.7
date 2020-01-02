Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CBE0C3276D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 07:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0373921D7D
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 07:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbgABH12 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 02:27:28 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8210 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726078AbgABH11 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 02:27:27 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3D513B76395E18A7A3FD;
        Thu,  2 Jan 2020 15:27:25 +0800 (CST)
Received: from euler.huawei.com (10.175.104.193) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Thu, 2 Jan 2020 15:27:16 +0800
From:   Wei Li <liwei391@huawei.com>
To:     <acme@kernel.org>, <mark.rutland@arm.com>,
        <alexander.shishkin@linux.intel.com>, <jolsa@redhat.com>,
        <namhyung@kernel.org>, <adrian.hunter@intel.com>
CC:     <peterz@infradead.org>, <mingo@redhat.com>,
        <linux-kernel@vger.kernel.org>, <huawei.libin@huawei.com>
Subject: [PATCH] perf tools: intel-pt: fix endless record after being terminated
Date:   Thu, 2 Jan 2020 15:42:11 +0800
Message-ID: <20200102074211.19901-1-liwei391@huawei.com>
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

If the intel_pt event is disabled, we don't enable it again here.

Before the patch:
huawei@huawei-2288H-V5:~/linux-5.5-rc4/tools/perf$ ./perf record -e \
intel_pt//u -p 46803
^C^C^C^C^C^C

After the patch:
huawei@huawei-2288H-V5:~/linux-5.5-rc4/tools/perf$ ./perf record -e \
intel_pt//u -p 48591
^C[ perf record: Woken up 0 times to write data ]
Warning:
AUX data lost 504 times out of 4816!

[ perf record: Captured and wrote 2024.405 MB perf.data ]

Signed-off-by: Wei Li <liwei391@huawei.com>
---
 tools/perf/arch/x86/util/intel-pt.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index 20df442fdf36..1e96afcd8646 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -1173,9 +1173,13 @@ static int intel_pt_read_finish(struct auxtrace_record *itr, int idx)
 	struct evsel *evsel;
 
 	evlist__for_each_entry(ptr->evlist, evsel) {
-		if (evsel->core.attr.type == ptr->intel_pt_pmu->type)
-			return perf_evlist__enable_event_idx(ptr->evlist, evsel,
-							     idx);
+		if (evsel->core.attr.type == ptr->intel_pt_pmu->type) {
+			if (evsel->disabled)
+				return 0;
+			else
+				return perf_evlist__enable_event_idx(
+						ptr->evlist, evsel, idx);
+		}
 	}
 	return -EINVAL;
 }
-- 
2.17.1

