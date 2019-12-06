Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62AC3C43603
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 17:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4323F206DF
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 17:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbfLFRYn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 12:24:43 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:63934 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726287AbfLFRYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 12:24:43 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB6HNxkP096281
        for <linux-kernel@vger.kernel.org>; Fri, 6 Dec 2019 12:24:41 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2wq2tw9fjj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2019 12:24:41 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Fri, 6 Dec 2019 17:24:40 -0000
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 6 Dec 2019 17:24:36 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xB6HOa1U38011350
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 6 Dec 2019 17:24:36 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ED1624C046;
        Fri,  6 Dec 2019 17:24:35 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8F9E74C040;
        Fri,  6 Dec 2019 17:24:32 +0000 (GMT)
Received: from srikart450.in.ibm.com (unknown [9.102.3.236])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  6 Dec 2019 17:24:32 +0000 (GMT)
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Rik van Riel <riel@surriel.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2] sched/fair: Optimize select_idle_core
Date:   Fri,  6 Dec 2019 22:54:22 +0530
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
x-cbid: 19120617-0016-0000-0000-000002D25885
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19120617-0017-0000-0000-000033346416
Message-Id: <20191206172422.6578-1-srikar@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-06_05:2019-12-05,2019-12-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 malwarescore=0 mlxlogscore=999 clxscore=1015 bulkscore=0 impostorscore=0
 phishscore=0 spamscore=0 suspectscore=0 adultscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1912060144
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently we loop through all threads of a core to evaluate if the core is
idle or not. This is unnecessary. If a thread of a core is not idle, skip
evaluating other threads of a core. Also while clearing the cpumask, bits
of all CPUs of a core can be cleared in one-shot.

Collecting ticks on a Power 9 SMT 8 system around select_idle_core
while running schbench shows us

(units are in ticks, hence lesser is better)
Without patch
    N        Min     Max     Median         Avg      Stddev
x 130        151    1083        284   322.72308   144.41494


With patch
    N        Min     Max     Median         Avg      Stddev   Improvement
x 164         88     610        201   225.79268   106.78943        30.03%


Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
---
Changelog v1->v2:
Updated patch description with measurements made from a debug patch.

 kernel/sched/fair.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 69a81a5709ff..b9d628128cfc 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5872,10 +5872,12 @@ static int select_idle_core(struct task_struct *p, struct sched_domain *sd, int
 		bool idle = true;
 
 		for_each_cpu(cpu, cpu_smt_mask(core)) {
-			__cpumask_clear_cpu(cpu, cpus);
-			if (!available_idle_cpu(cpu))
+			if (!available_idle_cpu(cpu)) {
 				idle = false;
+				break;
+			}
 		}
+		cpumask_andnot(cpus, cpus, cpu_smt_mask(core));
 
 		if (idle)
 			return core;
-- 
2.18.1

