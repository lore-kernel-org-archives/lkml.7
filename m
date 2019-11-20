Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B26FFC432C0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 08:41:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86E44223B0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 08:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbfKTIlk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 03:41:40 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:7996 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726687AbfKTIlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 03:41:40 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAK8WRwj147694
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 03:41:39 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wact81wvd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 03:41:38 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <kjain@linux.ibm.com>;
        Wed, 20 Nov 2019 08:41:34 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 20 Nov 2019 08:41:30 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xAK8fTeS54919314
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Nov 2019 08:41:29 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E5AB0A4062;
        Wed, 20 Nov 2019 08:41:28 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BF583A4054;
        Wed, 20 Nov 2019 08:41:26 +0000 (GMT)
Received: from localhost.in.ibm.com (unknown [9.124.35.61])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 20 Nov 2019 08:41:26 +0000 (GMT)
From:   Kajol Jain <kjain@linux.ibm.com>
To:     acme@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        kjain@linux.ibm.com,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Subject: [PATCH] tools/perf/metricgroup: Fix printing event names of metric group with multiple events
Date:   Wed, 20 Nov 2019 14:10:59 +0530
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19112008-0020-0000-0000-0000038C3927
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19112008-0021-0000-0000-000021E2698F
Message-Id: <20191120084059.24458-1-kjain@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-20_02:2019-11-15,2019-11-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 suspectscore=1
 adultscore=0 mlxscore=0 bulkscore=0 clxscore=1011 spamscore=0
 malwarescore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-1911200079
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit f01642e4912b ("perf metricgroup: Support multiple
events for metricgroup") introduced support for multiple events
in a metric group. But with the current upstream, metric events
names are not printed properly

In power9 platform:
command:# ./perf stat --metric-only -M translation -C 0 -I 1000 sleep 2
     1.000208486
     2.000368863
     2.001400558

Similarly in skylake platform:
command:./perf stat --metric-only -M Power -I 1000
     1.000579994
     2.002189493

With current upstream version, issue is with event name comparison
logic in find_evsel_group(). Current logic is to compare events
belonging to a metric group to the events in perf_evlist.
Since the break statement is missing in the loop used for comparison
between metric group and perf_evlist events, the loop continues to
execute even after getting a pattern match, and end up in discarding
the matches.
Incase of single metric event belongs to metric group, its working fine,
because in case of single event once it compare all events it reaches to
end of perf_evlist.

Example for single metric event in power9 platform
command:# ./perf stat --metric-only  -M branches_per_inst -I 1000 sleep 1
     1.000094653                  0.2
     1.001337059                  0.0

Patch fixes the issue by making sure once we found all events
belongs to that metric event matched in find_evsel_group(), we
successfully break from that loop by adding corresponding condition.

With this patch:
In power9 platform:

command:# ./perf stat --metric-only -M translation -C 0 -I 1000 sleep 2
result:#           time derat_4k_miss_rate_percent  derat_4k_miss_ratio
     derat_miss_ratio derat_64k_miss_rate_percent derat_64k_miss_ratio
         dslb_miss_rate_percent islb_miss_rate_percent
     1.000135672                         0.0                  0.3
                  1.0                          0.0                  0.2
                 0.0                     0.0
     2.000380617                         0.0                  0.0
                                              0.0                  0.0
                0.0                     0.0

command:# ./perf stat --metric-only -M Power -I 1000

Similarly in skylake platform:
result:#           time    Turbo_Utilization    C3_Core_Residency
            C6_Core_Residency    C7_Core_Residency     C2_Pkg_Residency
             C3_Pkg_Residency     C6_Pkg_Residency     C7_Pkg_Residency
     1.000563580                  0.3                  0.0
                  2.6                44.2                 21.9
                  0.0                  0.0                  0.0
     2.002235027                  0.4                  0.0
                  2.7           43.0                 20.7
                  0.0                  0.0               0.0

Signed-off-by: Kajol Jain <kjain@linux.ibm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
---
 tools/perf/util/metricgroup.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index a7c0424dbda3..940a6e7a6854 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -103,8 +103,11 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
 		if (!strcmp(ev->name, ids[i])) {
 			if (!metric_events[i])
 				metric_events[i] = ev;
+			i++;
+			if (i == idnum)
+				break;
 		} else {
-			if (++i == idnum) {
+			if (i + 1 == idnum) {
 				/* Discard the whole match and start again */
 				i = 0;
 				memset(metric_events, 0,
@@ -124,7 +127,7 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
 		}
 	}
 
-	if (i != idnum - 1) {
+	if (i != idnum) {
 		/* Not whole match */
 		return NULL;
 	}
-- 
2.21.0

