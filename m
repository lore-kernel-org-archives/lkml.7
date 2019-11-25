Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A386C432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 09:47:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52B1F2082C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 09:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbfKYJrO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 04:47:14 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:21898 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727133AbfKYJrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 04:47:14 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAP9lDxl086555
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 04:47:13 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wfjqxv424-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 04:47:12 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <parth@linux.ibm.com>;
        Mon, 25 Nov 2019 09:46:34 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 25 Nov 2019 09:46:29 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xAP9kS2G55050384
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Nov 2019 09:46:28 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 42DF6A4064;
        Mon, 25 Nov 2019 09:46:28 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6DA9EA405C;
        Mon, 25 Nov 2019 09:46:25 +0000 (GMT)
Received: from localhost.in.ibm.com (unknown [9.124.35.38])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 25 Nov 2019 09:46:25 +0000 (GMT)
From:   Parth Shah <parth@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        patrick.bellasi@matbug.net, valentin.schneider@arm.com,
        qais.yousef@arm.com, pavel@ucw.cz, dhaval.giani@oracle.com,
        qperret@qperret.net, David.Laight@ACULAB.COM,
        morten.rasmussen@arm.com, pjt@google.com, tj@kernel.org,
        dietmar.eggemann@arm.com, viresh.kumar@linaro.org,
        rafael.j.wysocki@intel.com, daniel.lezcano@linaro.org
Subject: [RFC 2/3] Propagate parent task's latency requirements to the child task
Date:   Mon, 25 Nov 2019 15:16:17 +0530
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20191125094618.30298-1-parth@linux.ibm.com>
References: <20191125094618.30298-1-parth@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19112509-0016-0000-0000-000002CBECD7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19112509-0017-0000-0000-0000332DBF73
Message-Id: <20191125094618.30298-3-parth@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-25_02:2019-11-21,2019-11-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=1
 bulkscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0 mlxscore=0
 clxscore=1015 mlxlogscore=726 spamscore=0 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1911250090
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clone parent task's latency_tolerance attribute to the forked child task.

Reset the latency_tolerance value to default value when the child task is
set to sched_reset_on_fork.

Signed-off-by: Parth Shah <parth@linux.ibm.com>
---
 kernel/sched/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7880f4f64d0e..ea7abbf5c1bb 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2853,6 +2853,9 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 	 */
 	p->prio = current->normal_prio;
 
+	/* Propagate the parent's latency requirements to the child as well */
+	p->latency_tolerance = current->latency_tolerance;
+
 	uclamp_fork(p);
 
 	/*
@@ -2869,6 +2872,7 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 		p->prio = p->normal_prio = __normal_prio(p);
 		set_load_weight(p, false);
 
+		p->latency_tolerance = DEFAULT_LATENCY_TOLERANCE;
 		/*
 		 * We don't need the reset flag anymore after the fork. It has
 		 * fulfilled its duty:
-- 
2.17.2

