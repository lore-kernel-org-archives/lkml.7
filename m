Return-Path: <SRS0=FHjv=VA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B6BDC5B57D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 00:37:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04FF8218A5
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jul 2019 00:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="aJc93AKB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbfGCAhx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 20:37:53 -0400
Received: from mx0a-00190b01.pphosted.com ([67.231.149.131]:15000 "EHLO
        mx0a-00190b01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727025AbfGCAhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 20:37:53 -0400
Received: from pps.filterd (m0050093.ppops.net [127.0.0.1])
        by m0050093.ppops.net-00190b01. (8.16.0.27/8.16.0.27) with SMTP id x630BlWH004278;
        Wed, 3 Jul 2019 01:11:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=jan2016.eng;
 bh=Wx+VqX0G/B6f6OxzVjnoXtU/3HHWXnxmAKOKaEK5PZc=;
 b=aJc93AKBWszGJ6JGlYGN5/LjbzB6ZqhTGlH0q54AKoFVrZa4bB5AxxJvp4DKNF5jV+4O
 q8dWI94GvA95Fo2Hl+P3GdVTtjh6NEqhcc6SYHM3sYoltAJOKT4w9epTkkUMx+48QvXI
 ojK3lENbnX6kTAEqIJrlMVBZKKa7Jn/XxWX/lbpjZPS4AakqVFT57mMobGinTbOYCD66
 YxWvMnjjtNtwMczOST/oH+nwL7CO3dmvL3i2tWrRdXZf+X8Apf/5tNjfLGUEA6r/cWIp
 vNGF+LMAL7CHaoFWp3uVtHGb/lBY9KO2uZJplHC1hdo9Bd991MMvvKACl6/Fh94Jdjzh Tw== 
Received: from prod-mail-ppoint1 (prod-mail-ppoint1.akamai.com [184.51.33.18] (may be forged))
        by m0050093.ppops.net-00190b01. with ESMTP id 2tg2tkusct-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 03 Jul 2019 01:11:54 +0100
Received: from pps.filterd (prod-mail-ppoint1.akamai.com [127.0.0.1])
        by prod-mail-ppoint1.akamai.com (8.16.0.27/8.16.0.27) with SMTP id x6302Nbm018809;
        Tue, 2 Jul 2019 20:11:53 -0400
Received: from email.msg.corp.akamai.com ([172.27.123.34])
        by prod-mail-ppoint1.akamai.com with ESMTP id 2te3awgjft-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 02 Jul 2019 20:11:50 -0400
Received: from USMA1EX-DAG1MB5.msg.corp.akamai.com (172.27.123.105) by
 usma1ex-dag3mb2.msg.corp.akamai.com (172.27.123.59) with Microsoft SMTP
 Server (TLS) id 15.0.1473.3; Tue, 2 Jul 2019 20:10:50 -0400
Received: from USMA1EX-CAS1.msg.corp.akamai.com (172.27.123.30) by
 usma1ex-dag1mb5.msg.corp.akamai.com (172.27.123.105) with Microsoft SMTP
 Server (TLS) id 15.0.1473.3; Tue, 2 Jul 2019 20:10:49 -0400
Received: from igorcastle.kendall.corp.akamai.com (172.29.170.135) by
 USMA1EX-CAS1.msg.corp.akamai.com (172.27.123.30) with Microsoft SMTP Server
 id 15.0.1473.3 via Frontend Transport; Tue, 2 Jul 2019 20:10:49 -0400
Received: by igorcastle.kendall.corp.akamai.com (Postfix, from userid 29659)
        id A555F61E44; Tue,  2 Jul 2019 20:10:47 -0400 (EDT)
From:   Igor Lubashev <ilubashe@akamai.com>
To:     <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        "James Morris" <jmorris@namei.org>,
        Igor Lubashev <ilubashe@akamai.com>
Subject: [PATCH 2/3] perf: Use CAP_SYS_ADMIN with perf_event_paranoid checks
Date:   Tue, 2 Jul 2019 20:10:04 -0400
Message-ID: <1562112605-6235-3-git-send-email-ilubashe@akamai.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1562112605-6235-1-git-send-email-ilubashe@akamai.com>
References: <1562112605-6235-1-git-send-email-ilubashe@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-02_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907020268
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-02_12:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907030001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kernel is using CAP_SYS_ADMIN instead of euid==0 to override
perf_event_paranoid check. Make perf do the same.

Signed-off-by: Igor Lubashev <ilubashe@akamai.com>
---
 tools/perf/arch/arm/util/cs-etm.c    | 3 ++-
 tools/perf/arch/arm64/util/arm-spe.c | 3 ++-
 tools/perf/arch/x86/util/intel-bts.c | 3 ++-
 tools/perf/arch/x86/util/intel-pt.c  | 2 +-
 tools/perf/util/evsel.c              | 2 +-
 5 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 911426721170..e004ba7ad957 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -17,6 +17,7 @@
 #include "../../perf.h"
 #include "../../util/auxtrace.h"
 #include "../../util/cpumap.h"
+#include "../../util/event.h"
 #include "../../util/evlist.h"
 #include "../../util/evsel.h"
 #include "../../util/pmu.h"
@@ -106,7 +107,7 @@ static int cs_etm_recording_options(struct auxtrace_record *itr,
 	struct perf_pmu *cs_etm_pmu = ptr->cs_etm_pmu;
 	struct perf_evsel *evsel, *cs_etm_evsel = NULL;
 	const struct cpu_map *cpus = evlist->cpus;
-	bool privileged = (geteuid() == 0 || perf_event_paranoid() < 0);
+	bool privileged = perf_event_paranoid_check(-1);
 
 	ptr->evlist = evlist;
 	ptr->snapshot_mode = opts->auxtrace_snapshot_mode;
diff --git a/tools/perf/arch/arm64/util/arm-spe.c b/tools/perf/arch/arm64/util/arm-spe.c
index 5ccfce87e693..f5ec6953c69c 100644
--- a/tools/perf/arch/arm64/util/arm-spe.c
+++ b/tools/perf/arch/arm64/util/arm-spe.c
@@ -11,6 +11,7 @@
 #include <time.h>
 
 #include "../../util/cpumap.h"
+#include "../../util/event.h"
 #include "../../util/evsel.h"
 #include "../../util/evlist.h"
 #include "../../util/session.h"
@@ -65,7 +66,7 @@ static int arm_spe_recording_options(struct auxtrace_record *itr,
 			container_of(itr, struct arm_spe_recording, itr);
 	struct perf_pmu *arm_spe_pmu = sper->arm_spe_pmu;
 	struct perf_evsel *evsel, *arm_spe_evsel = NULL;
-	bool privileged = geteuid() == 0 || perf_event_paranoid() < 0;
+	bool privileged = perf_event_paranoid_check(-1);
 	struct perf_evsel *tracking_evsel;
 	int err;
 
diff --git a/tools/perf/arch/x86/util/intel-bts.c b/tools/perf/arch/x86/util/intel-bts.c
index e6d4d9591c79..fe7cecdb494d 100644
--- a/tools/perf/arch/x86/util/intel-bts.c
+++ b/tools/perf/arch/x86/util/intel-bts.c
@@ -11,6 +11,7 @@
 #include <linux/log2.h>
 
 #include "../../util/cpumap.h"
+#include "../../util/event.h"
 #include "../../util/evsel.h"
 #include "../../util/evlist.h"
 #include "../../util/session.h"
@@ -107,7 +108,7 @@ static int intel_bts_recording_options(struct auxtrace_record *itr,
 	struct perf_pmu *intel_bts_pmu = btsr->intel_bts_pmu;
 	struct perf_evsel *evsel, *intel_bts_evsel = NULL;
 	const struct cpu_map *cpus = evlist->cpus;
-	bool privileged = geteuid() == 0 || perf_event_paranoid() < 0;
+	bool privileged = perf_event_paranoid_check(-1);
 
 	btsr->evlist = evlist;
 	btsr->snapshot_mode = opts->auxtrace_snapshot_mode;
diff --git a/tools/perf/arch/x86/util/intel-pt.c b/tools/perf/arch/x86/util/intel-pt.c
index 1869f62a10cd..44d2194fdab3 100644
--- a/tools/perf/arch/x86/util/intel-pt.c
+++ b/tools/perf/arch/x86/util/intel-pt.c
@@ -557,7 +557,7 @@ static int intel_pt_recording_options(struct auxtrace_record *itr,
 	bool have_timing_info, need_immediate = false;
 	struct perf_evsel *evsel, *intel_pt_evsel = NULL;
 	const struct cpu_map *cpus = evlist->cpus;
-	bool privileged = geteuid() == 0 || perf_event_paranoid() < 0;
+	bool privileged = perf_event_paranoid_check(-1);
 	u64 tsc_bit;
 	int err;
 
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 4a5947625c5c..ce28d890d6bf 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -277,7 +277,7 @@ struct perf_evsel *perf_evsel__new_idx(struct perf_event_attr *attr, int idx)
 
 static bool perf_event_can_profile_kernel(void)
 {
-	return geteuid() == 0 || perf_event_paranoid() == -1;
+	return perf_event_paranoid_check(-1);
 }
 
 struct perf_evsel *perf_evsel__new_cycles(bool precise)
-- 
2.7.4

