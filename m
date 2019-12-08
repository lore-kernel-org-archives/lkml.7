Return-Path: <SRS0=RGqN=Z6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D29C43603
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 06:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1406206D6
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 06:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbfLHGEe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 01:04:34 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44196 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725268AbfLHGEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 01:04:33 -0500
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB85xGJL032730
        for <linux-kernel@vger.kernel.org>; Sun, 8 Dec 2019 01:04:32 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wr7s7g7hy-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2019 01:04:31 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <parth@linux.ibm.com>;
        Sun, 8 Dec 2019 06:04:28 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 8 Dec 2019 06:04:22 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xB864LkV47513818
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 8 Dec 2019 06:04:21 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AE00411C04A;
        Sun,  8 Dec 2019 06:04:21 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C772911C04C;
        Sun,  8 Dec 2019 06:04:17 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.85.71.101])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun,  8 Dec 2019 06:04:17 +0000 (GMT)
From:   Parth Shah <parth@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        patrick.bellasi@matbug.net, valentin.schneider@arm.com,
        qais.yousef@arm.com, pavel@ucw.cz, dhaval.giani@oracle.com,
        qperret@qperret.net, David.Laight@ACULAB.COM, pjt@google.com,
        tj@kernel.org, dietmar.eggemann@arm.com
Subject: [PATCH v2 1/3] sched: Introduce latency-tolerance as a per-task attribute
Date:   Sun,  8 Dec 2019 11:34:08 +0530
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20191208060410.17814-1-parth@linux.ibm.com>
References: <20191208060410.17814-1-parth@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19120806-0020-0000-0000-000003957198
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19120806-0021-0000-0000-000021ECA8B3
Message-Id: <20191208060410.17814-2-parth@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-08_01:2019-12-05,2019-12-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 phishscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 mlxlogscore=999 malwarescore=0 suspectscore=1 spamscore=0
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912080054
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Latency-tolerance indicates the latency requirements of a task with respect
to the other tasks in the system. The value of the attribute can be within
the range of [-20, 19] both inclusive to be in-line with the values just
like task nice values.

latency_tolerance = -20 indicates the task to have the least latency as
compared to the tasks having latency_tolerance = +19.

The latency_tolerance may affect only the CFS SCHED_CLASS by getting
latency requirements from the userspace.

Signed-off-by: Parth Shah <parth@linux.ibm.com>
Reviewed-by: Qais Yousef <qais.yousef@arm.com>
---
 include/linux/sched.h |  1 +
 kernel/sched/sched.h  | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 84b26d38c929..d5f907d7a91a 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -676,6 +676,7 @@ struct task_struct {
 	int				static_prio;
 	int				normal_prio;
 	unsigned int			rt_priority;
+	int				latency_tolerance;
 
 	const struct sched_class	*sched_class;
 	struct sched_entity		se;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 280a3c735935..3d68aaad02cc 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -101,6 +101,24 @@ extern long calc_load_fold_active(struct rq *this_rq, long adjust);
  */
 #define NS_TO_JIFFIES(TIME)	((unsigned long)(TIME) / (NSEC_PER_SEC / HZ))
 
+/*
+ * Latency tolerance is meant to provide scheduler hints about the relative
+ * latency requirements of a task with respect to other tasks.
+ * Thus a task with latency_tolerance == 19 can be hinted as the task with no
+ * latency requirements, in contrast to the task with latency_tolerance == -20
+ * which should be given priority in terms of lower latency.
+ */
+#define MAX_LATENCY_TOLERANCE	19
+#define MIN_LATENCY_TOLERANCE	-20
+
+#define LATENCY_TOLERANCE_WIDTH	\
+	(MAX_LATENCY_TOLERANCE - MIN_LATENCY_TOLERANCE + 1)
+
+/*
+ * Default tasks should be treated as a task with latency_tolerance = 0.
+ */
+#define DEFAULT_LATENCY_TOLERANCE	0
+
 /*
  * Increase resolution of nice-level calculations for 64-bit architectures.
  * The extra resolution improves shares distribution and load balancing of
-- 
2.17.2

