Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 653A6C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 20:24:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44F7D214DA
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 20:24:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728548AbfHSUYA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 16:24:00 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:7884 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728517AbfHSUX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 16:23:56 -0400
Received: from pps.filterd (m0134421.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7JKLOrq008379;
        Mon, 19 Aug 2019 20:23:50 GMT
Received: from g9t5009.houston.hpe.com (g9t5009.houston.hpe.com [15.241.48.73])
        by mx0b-002e3701.pphosted.com with ESMTP id 2ufy9phek9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Aug 2019 20:23:50 +0000
Received: from stormcage.eag.rdlabs.hpecorp.net (unknown [128.162.236.70])
        by g9t5009.houston.hpe.com (Postfix) with ESMTP id 0C87451;
        Mon, 19 Aug 2019 20:23:50 +0000 (UTC)
Received: by stormcage.eag.rdlabs.hpecorp.net (Postfix, from userid 48777)
        id C0F662014C81E; Mon, 19 Aug 2019 15:23:49 -0500 (CDT)
From:   Kyle Meyer <meyerk@hpe.com>
Cc:     Kyle Meyer <meyerk@hpe.com>, Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-kernel@vger.kernel.org,
        Russ Anderson <russ.anderson@hpe.com>,
        Kyle Meyer <kyle.meyer@hpe.com>
Subject: [PATCH v3 6/6] perf/util/header: Replace MAX_NR_CPUS with cpu__max_cpu
Date:   Mon, 19 Aug 2019 15:23:48 -0500
Message-Id: <20190819202348.88140-1-meyerk@stormcage.eag.rdlabs.hpecorp.net>
X-Mailer: git-send-email 2.12.3
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-19_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908190207
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function cpu__max_cpu returns the possible number of CPUs as defined in the
sysfs and can be used as an alternative for MAX_NR_CPUS in write_cache.
MAX_CACHES is replaced by cpu__max_cpu() * MAX_CACHE_LVL.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: Russ Anderson <russ.anderson@hpe.com>
Signed-off-by: Kyle Meyer <kyle.meyer@hpe.com>
---
 tools/perf/util/header.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index b04c2b6b28b3..16f422bd0acc 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -1121,16 +1121,17 @@ static int build_caches(struct cpu_cache_level caches[], u32 size, u32 *cntp)
 	return 0;
 }
 
-#define MAX_CACHES (MAX_NR_CPUS * 4)
+#define MAX_CACHE_LVL 4
 
 static int write_cache(struct feat_fd *ff,
 		       struct evlist *evlist __maybe_unused)
 {
-	struct cpu_cache_level caches[MAX_CACHES];
+	u32 max_caches = cpu__max_cpu() * MAX_CACHE_LVL;
+	struct cpu_cache_level caches[max_caches];
 	u32 cnt = 0, i, version = 1;
 	int ret;
 
-	ret = build_caches(caches, MAX_CACHES, &cnt);
+	ret = build_caches(caches, max_caches, &cnt);
 	if (ret)
 		goto out;
 
-- 
2.12.3

