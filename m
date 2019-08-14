Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90343C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 20:39:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A07D2083B
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 20:39:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729583AbfHNUjN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 16:39:13 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:60446 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727516AbfHNUjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 16:39:12 -0400
Received: from pps.filterd (m0134420.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x7EKV6Dm021596;
        Wed, 14 Aug 2019 20:39:06 GMT
Received: from g2t2352.austin.hpe.com (g2t2352.austin.hpe.com [15.233.44.25])
        by mx0b-002e3701.pphosted.com with ESMTP id 2ucqxt0kjb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 14 Aug 2019 20:39:06 +0000
Received: from stormcage.eag.rdlabs.hpecorp.net (stormcage.eag.rdlabs.hpecorp.net [128.162.236.70])
        by g2t2352.austin.hpe.com (Postfix) with ESMTP id AD68A63;
        Wed, 14 Aug 2019 20:39:05 +0000 (UTC)
Received: by stormcage.eag.rdlabs.hpecorp.net (Postfix, from userid 48777)
        id 7299F20131383; Wed, 14 Aug 2019 15:39:05 -0500 (CDT)
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
Subject: [PATCH v2 5/6] perf/util/machine: Replace MAX_NR_CPUS with nr_cpus_online
Date:   Wed, 14 Aug 2019 15:39:04 -0500
Message-Id: <20190814203904.204985-1-meyerk@stormcage.eag.rdlabs.hpecorp.net>
X-Mailer: git-send-email 2.12.3
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-08-14_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=942 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1908140187
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

nr_cpus_online, the number of CPUs online during a record session, can be
used as a dynamic alternative for MAX_NR_CPUS in __machine__synthesize_threads
and machine__set_current_tid.

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
 tools/perf/util/machine.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 5734460fc89e..d255634bac74 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2616,7 +2616,9 @@ int __machine__synthesize_threads(struct machine *machine, struct perf_tool *too
 
 pid_t machine__get_current_tid(struct machine *machine, int cpu)
 {
-	if (cpu < 0 || cpu >= MAX_NR_CPUS || !machine->current_tid)
+	int nr_cpus_online = machine->env->nr_cpus_online;
+
+	if (cpu < 0 || cpu >= nr_cpus_online || !machine->current_tid)
 		return -1;
 
 	return machine->current_tid[cpu];
@@ -2626,6 +2628,7 @@ int machine__set_current_tid(struct machine *machine, int cpu, pid_t pid,
 			     pid_t tid)
 {
 	struct thread *thread;
+	int nr_cpus_online = machine->env->nr_cpus_online;
 
 	if (cpu < 0)
 		return -EINVAL;
@@ -2633,16 +2636,15 @@ int machine__set_current_tid(struct machine *machine, int cpu, pid_t pid,
 	if (!machine->current_tid) {
 		int i;
 
-		machine->current_tid = calloc(MAX_NR_CPUS, sizeof(pid_t));
+		machine->current_tid = calloc(nr_cpus_online, sizeof(pid_t));
 		if (!machine->current_tid)
 			return -ENOMEM;
-		for (i = 0; i < MAX_NR_CPUS; i++)
+		for (i = 0; i < nr_cpus_online; i++)
 			machine->current_tid[i] = -1;
 	}
 
-	if (cpu >= MAX_NR_CPUS) {
+	if (cpu >= nr_cpus_online) {
 		pr_err("Requested CPU %d too large. ", cpu);
-		pr_err("Consider raising MAX_NR_CPUS\n");
 		return -EINVAL;
 	}
 
-- 
2.12.3

