Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F0E9C00523
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 06:59:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59B432073A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 06:59:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbgAHG7H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 01:59:07 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:13910 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725944AbgAHG7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 01:59:06 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0086vHo3114663
        for <linux-kernel@vger.kernel.org>; Wed, 8 Jan 2020 01:59:05 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xb8p15y42-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 01:59:05 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <kjain@linux.ibm.com>;
        Wed, 8 Jan 2020 06:59:03 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 8 Jan 2020 06:59:00 -0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0086wwD444892438
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 8 Jan 2020 06:58:58 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 98D4442059;
        Wed,  8 Jan 2020 06:58:58 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8F79042045;
        Wed,  8 Jan 2020 06:58:55 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.199.48.19])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed,  8 Jan 2020 06:58:55 +0000 (GMT)
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
Subject: [PATCH] tools/perf/metricgroup: Fix printing event names of metric group with multiple events incase of overlapping events
Date:   Wed,  8 Jan 2020 12:28:44 +0530
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20010806-4275-0000-0000-0000039598C3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20010806-4276-0000-0000-000038A98538
Message-Id: <20200108065844.4030-1-kjain@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.572
 definitions=2020-01-08_01:2020-01-07,2020-01-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 impostorscore=0 mlxscore=0 clxscore=1015 phishscore=0 spamscore=0
 priorityscore=1501 suspectscore=1 bulkscore=0 adultscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-2001080059
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit f01642e4912b ("perf metricgroup: Support multiple
events for metricgroup") introduced support for multiple events
in a metric group. But with the current upstream, metric events
names are not printed properly incase we try to run multiple
metric groups with overlapping event.

With current upstream version, incase of overlapping metric events
issue is, we always start our comparision logic from start.
So, the events which already matched with some metric group also
take part in comparision logic. Because of that when we have overlapping
events, we end up matching current metric group event with already matched
one.

For example, in skylake machine we have metric event CoreIPC and
Instructions. Both of them need 'inst_retired.any' event value.
As events in Instructions is subset of events in CoreIPC, they
endup in pointing to same 'inst_retired.any' value.

In skylake platform:

command:# ./perf stat -M CoreIPC,Instructions  -C 0 sleep 1

 Performance counter stats for 'CPU(s) 0':

     1,254,992,790      inst_retired.any          # 1254992790.0
						    Instructions
                                                  #      1.3 CoreIPC
       977,172,805      cycles
     1,254,992,756      inst_retired.any

       1.000802596 seconds time elapsed

command:# sudo ./perf stat -M UPI,IPC sleep 1

   Performance counter stats for 'sleep 1':

           948,650      uops_retired.retire_slots
           866,182      inst_retired.any          #      0.7 IPC
           866,182      inst_retired.any
         1,175,671      cpu_clk_unhalted.thread

Patch fixes the issue by adding a static variable 'iterator_perf_evlist'
to keep track of events which already matched with some group. It points
to event in perf_evlist from where next match should start. Because we
need to make sure, we match correct set of events belongs to
corresponding metric group.

With this patch:
In skylake platform:

command:# ./perf stat -M CoreIPC,Instructions  -C 0 sleep 1

 Performance counter stats for 'CPU(s) 0':

       149,481,533      inst_retired.any          #      0.8 CoreIPC
       186,244,218      cycles
       149,479,362      inst_retired.any          # 149479362.0
							Instructions

       1.001655885 seconds time elapsed

command:# ./perf stat -M UPI,IPC sleep 1
 Performance counter stats for 'CPU(s) 0':

        16,858,849      uops_retired.retire_slots #      1.3 UPI
        12,529,178      inst_retired.any
        12,529,558      inst_retired.any          #      0.3 IPC
        39,936,071      cpu_clk_unhalted.thread

       1.001413978 seconds time elapsed


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
 tools/perf/util/metricgroup.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index 35e151b8359b..58889b0496fb 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -90,16 +90,21 @@ struct egroup {
 	const char *metric_unit;
 };
 
+static int iterator_perf_evlist;
+
 static struct evsel *find_evsel_group(struct evlist *perf_evlist,
 				      const char **ids,
 				      int idnum,
 				      struct evsel **metric_events)
 {
 	struct evsel *ev;
-	int i = 0;
+	int i = 0, j = 0;
 	bool leader_found;
 
 	evlist__for_each_entry (perf_evlist, ev) {
+		j++;
+		if (j <= iterator_perf_evlist)
+			continue;
 		if (!strcmp(ev->name, ids[i])) {
 			if (!metric_events[i])
 				metric_events[i] = ev;
@@ -146,6 +151,7 @@ static struct evsel *find_evsel_group(struct evlist *perf_evlist,
 			}
 		}
 	}
+	iterator_perf_evlist = j;
 
 	return metric_events[0];
 }
-- 
2.21.0

