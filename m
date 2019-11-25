Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 783C1C432C3
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 09:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45CBD207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 09:46:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbfKYJqy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 04:46:54 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:3342 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727133AbfKYJqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 04:46:53 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAP9kokZ081045
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 04:46:52 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wf267hdjt-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 04:46:52 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <parth@linux.ibm.com>;
        Mon, 25 Nov 2019 09:46:38 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 25 Nov 2019 09:46:32 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xAP9jqHm47251824
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Nov 2019 09:45:52 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6330AA4062;
        Mon, 25 Nov 2019 09:46:31 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9048EA405F;
        Mon, 25 Nov 2019 09:46:28 +0000 (GMT)
Received: from localhost.in.ibm.com (unknown [9.124.35.38])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 25 Nov 2019 09:46:28 +0000 (GMT)
From:   Parth Shah <parth@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        patrick.bellasi@matbug.net, valentin.schneider@arm.com,
        qais.yousef@arm.com, pavel@ucw.cz, dhaval.giani@oracle.com,
        qperret@qperret.net, David.Laight@ACULAB.COM,
        morten.rasmussen@arm.com, pjt@google.com, tj@kernel.org,
        dietmar.eggemann@arm.com, viresh.kumar@linaro.org,
        rafael.j.wysocki@intel.com, daniel.lezcano@linaro.org
Subject: [RFC 3/3] Allow sched_{get,set}attr to change latency_tolerance of the task
Date:   Mon, 25 Nov 2019 15:16:18 +0530
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20191125094618.30298-1-parth@linux.ibm.com>
References: <20191125094618.30298-1-parth@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19112509-0016-0000-0000-000002CBECE1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19112509-0017-0000-0000-0000332DBF79
Message-Id: <20191125094618.30298-4-parth@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-25_02:2019-11-21,2019-11-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 mlxscore=0 adultscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 suspectscore=1 phishscore=0 bulkscore=0 priorityscore=1501 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-1910280000
 definitions=main-1911250090
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce the latency_tolerance attribute to sched_attr and provide a
mechanism to change the value with the use of sched_setattr/sched_getattr
syscall.

Also add new flag "SCHED_FLAG_LATENCY_TOLERANCE" to hint the change in
latency_tolerance of the task on every sched_setattr syscall.

Signed-off-by: Parth Shah <parth@linux.ibm.com>
---
 include/uapi/linux/sched.h       |  4 +++-
 include/uapi/linux/sched/types.h |  2 ++
 kernel/sched/core.c              | 15 +++++++++++++++
 kernel/sched/sched.h             |  1 +
 4 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
index b3105ac1381a..73db430d11b6 100644
--- a/include/uapi/linux/sched.h
+++ b/include/uapi/linux/sched.h
@@ -71,6 +71,7 @@ struct clone_args {
 #define SCHED_FLAG_KEEP_PARAMS		0x10
 #define SCHED_FLAG_UTIL_CLAMP_MIN	0x20
 #define SCHED_FLAG_UTIL_CLAMP_MAX	0x40
+#define SCHED_FLAG_LATENCY_TOLERANCE	0x80
 
 #define SCHED_FLAG_KEEP_ALL	(SCHED_FLAG_KEEP_POLICY | \
 				 SCHED_FLAG_KEEP_PARAMS)
@@ -82,6 +83,7 @@ struct clone_args {
 			 SCHED_FLAG_RECLAIM		| \
 			 SCHED_FLAG_DL_OVERRUN		| \
 			 SCHED_FLAG_KEEP_ALL		| \
-			 SCHED_FLAG_UTIL_CLAMP)
+			 SCHED_FLAG_UTIL_CLAMP		| \
+			 SCHED_FLAG_LATENCY_TOLERANCE)
 
 #endif /* _UAPI_LINUX_SCHED_H */
diff --git a/include/uapi/linux/sched/types.h b/include/uapi/linux/sched/types.h
index c852153ddb0d..960774ac0c70 100644
--- a/include/uapi/linux/sched/types.h
+++ b/include/uapi/linux/sched/types.h
@@ -118,6 +118,8 @@ struct sched_attr {
 	__u32 sched_util_min;
 	__u32 sched_util_max;
 
+	/* latency requirement hints */
+	__s32 sched_latency_tolerance;
 };
 
 #endif /* _UAPI_LINUX_SCHED_TYPES_H */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ea7abbf5c1bb..dfd36ec14404 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4695,6 +4695,9 @@ static void __setscheduler_params(struct task_struct *p,
 	p->rt_priority = attr->sched_priority;
 	p->normal_prio = normal_prio(p);
 	set_load_weight(p, true);
+
+	/* Change latency tolerance of the task if !SCHED_FLAG_KEEP_PARAMS */
+	p->latency_tolerance = attr->sched_latency_tolerance;
 }
 
 /* Actually do priority change: must hold pi & rq lock. */
@@ -4852,6 +4855,13 @@ static int __sched_setscheduler(struct task_struct *p,
 			return retval;
 	}
 
+	if (attr->sched_flags & SCHED_FLAG_LATENCY_TOLERANCE) {
+		if (attr->sched_latency_tolerance > MAX_LATENCY_TOLERANCE)
+			return -EINVAL;
+		if (attr->sched_latency_tolerance < MIN_LATENCY_TOLERANCE)
+			return -EINVAL;
+	}
+
 	if (pi)
 		cpuset_read_lock();
 
@@ -4886,6 +4896,9 @@ static int __sched_setscheduler(struct task_struct *p,
 			goto change;
 		if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)
 			goto change;
+		if (attr->sched_flags & SCHED_FLAG_LATENCY_TOLERANCE &&
+		    attr->sched_latency_tolerance != p->latency_tolerance)
+			goto change;
 
 		p->sched_reset_on_fork = reset_on_fork;
 		retval = 0;
@@ -5392,6 +5405,8 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct sched_attr __user *, uattr,
 	else
 		kattr.sched_nice = task_nice(p);
 
+	kattr.sched_latency_tolerance = p->latency_tolerance;
+
 #ifdef CONFIG_UCLAMP_TASK
 	kattr.sched_util_min = p->uclamp_req[UCLAMP_MIN].value;
 	kattr.sched_util_max = p->uclamp_req[UCLAMP_MAX].value;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 0db2c1b3361e..bb181175954b 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -21,6 +21,7 @@
 #include <linux/sched/nohz.h>
 #include <linux/sched/numa_balancing.h>
 #include <linux/sched/prio.h>
+#include <linux/sched/latency_tolerance.h>
 #include <linux/sched/rt.h>
 #include <linux/sched/signal.h>
 #include <linux/sched/smt.h>
-- 
2.17.2

