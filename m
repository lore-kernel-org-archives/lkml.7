Return-Path: <SRS0=RGqN=Z6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42FF0C3F68F
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 06:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22638206D6
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 06:05:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbfLHGEj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 01:04:39 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:3420 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726475AbfLHGEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 01:04:38 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB85xMFD005502
        for <linux-kernel@vger.kernel.org>; Sun, 8 Dec 2019 01:04:37 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2wrt571xwf-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2019 01:04:37 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <parth@linux.ibm.com>;
        Sun, 8 Dec 2019 06:04:35 -0000
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 8 Dec 2019 06:04:31 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xB863njY16384268
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 8 Dec 2019 06:03:49 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7F69A11C052;
        Sun,  8 Dec 2019 06:04:30 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B1CDC11C04A;
        Sun,  8 Dec 2019 06:04:26 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.85.71.101])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun,  8 Dec 2019 06:04:26 +0000 (GMT)
From:   Parth Shah <parth@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        patrick.bellasi@matbug.net, valentin.schneider@arm.com,
        qais.yousef@arm.com, pavel@ucw.cz, dhaval.giani@oracle.com,
        qperret@qperret.net, David.Laight@ACULAB.COM, pjt@google.com,
        tj@kernel.org, dietmar.eggemann@arm.com
Subject: [PATCH v2 3/3] sched: Allow sched_{get,set}attr to change latency_tolerance of the task
Date:   Sun,  8 Dec 2019 11:34:10 +0530
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20191208060410.17814-1-parth@linux.ibm.com>
References: <20191208060410.17814-1-parth@linux.ibm.com>
X-TM-AS-GCONF: 00
x-cbid: 19120806-0012-0000-0000-00000372BB53
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19120806-0013-0000-0000-000021AE86CB
Message-Id: <20191208060410.17814-4-parth@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-08_01:2019-12-05,2019-12-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 spamscore=0 impostorscore=0 mlxlogscore=999 malwarescore=0
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912080054
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
Reviewed-by: Qais Yousef <qais.yousef@arm.com>
---
 include/uapi/linux/sched.h       |  4 +++-
 include/uapi/linux/sched/types.h | 19 +++++++++++++++++++
 kernel/sched/core.c              | 17 +++++++++++++++++
 tools/include/uapi/linux/sched.h |  4 +++-
 4 files changed, 42 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
index 25b4fa00bad1..a211d397e41d 100644
--- a/include/uapi/linux/sched.h
+++ b/include/uapi/linux/sched.h
@@ -101,6 +101,7 @@ struct clone_args {
 #define SCHED_FLAG_KEEP_PARAMS		0x10
 #define SCHED_FLAG_UTIL_CLAMP_MIN	0x20
 #define SCHED_FLAG_UTIL_CLAMP_MAX	0x40
+#define SCHED_FLAG_LATENCY_TOLERANCE	0x80
 
 #define SCHED_FLAG_KEEP_ALL	(SCHED_FLAG_KEEP_POLICY | \
 				 SCHED_FLAG_KEEP_PARAMS)
@@ -112,6 +113,7 @@ struct clone_args {
 			 SCHED_FLAG_RECLAIM		| \
 			 SCHED_FLAG_DL_OVERRUN		| \
 			 SCHED_FLAG_KEEP_ALL		| \
-			 SCHED_FLAG_UTIL_CLAMP)
+			 SCHED_FLAG_UTIL_CLAMP		| \
+			 SCHED_FLAG_LATENCY_TOLERANCE)
 
 #endif /* _UAPI_LINUX_SCHED_H */
diff --git a/include/uapi/linux/sched/types.h b/include/uapi/linux/sched/types.h
index c852153ddb0d..4f169c88517f 100644
--- a/include/uapi/linux/sched/types.h
+++ b/include/uapi/linux/sched/types.h
@@ -10,6 +10,7 @@ struct sched_param {
 
 #define SCHED_ATTR_SIZE_VER0	48	/* sizeof first published struct */
 #define SCHED_ATTR_SIZE_VER1	56	/* add: util_{min,max} */
+#define SCHED_ATTR_SIZE_VER2	60	/* add: latency_tolerance */
 
 /*
  * Extended scheduling parameters data structure.
@@ -96,6 +97,22 @@ struct sched_param {
  * on a CPU with a capacity big enough to fit the specified value.
  * A task with a max utilization value smaller than 1024 is more likely
  * scheduled on a CPU with no more capacity than the specified value.
+ *
+ * Latency Tolerance Attributes
+ * ===========================
+ *
+ * A subset of sched_attr attributes allows to specify the relative latency
+ * requirements of a task with respect to the other tasks running/queued in the
+ * system.
+ *
+ * @ sched_latency_tolerance	task's latency_tolerance value
+ *
+ * The latency_tolerance of a task can have any value in a range of
+ * [LATENCY_TOLERANCE_MIN..LATENCY_TOLERANCE_MAX].
+ *
+ * A task with latency_tolerance with the value of LATENCY_TOLERANCE_MIN can be
+ * taken for a task with lower latency requirements as opposed to the task with
+ * higher latency_tolerance.
  */
 struct sched_attr {
 	__u32 size;
@@ -118,6 +135,8 @@ struct sched_attr {
 	__u32 sched_util_min;
 	__u32 sched_util_max;
 
+	/* latency requirement hints */
+	__s32 sched_latency_tolerance;
 };
 
 #endif /* _UAPI_LINUX_SCHED_TYPES_H */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3f9359d0e326..bc8a260223f6 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4706,6 +4706,8 @@ static void __setscheduler_params(struct task_struct *p,
 	p->rt_priority = attr->sched_priority;
 	p->normal_prio = normal_prio(p);
 	set_load_weight(p, true);
+
+	p->latency_tolerance = attr->sched_latency_tolerance;
 }
 
 /* Actually do priority change: must hold pi & rq lock. */
@@ -4863,6 +4865,13 @@ static int __sched_setscheduler(struct task_struct *p,
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
 
@@ -4897,6 +4906,9 @@ static int __sched_setscheduler(struct task_struct *p,
 			goto change;
 		if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)
 			goto change;
+		if (attr->sched_flags & SCHED_FLAG_LATENCY_TOLERANCE &&
+		    attr->sched_latency_tolerance != p->latency_tolerance)
+			goto change;
 
 		p->sched_reset_on_fork = reset_on_fork;
 		retval = 0;
@@ -5145,6 +5157,9 @@ static int sched_copy_attr(struct sched_attr __user *uattr, struct sched_attr *a
 	    size < SCHED_ATTR_SIZE_VER1)
 		return -EINVAL;
 
+	if ((attr->sched_flags & SCHED_FLAG_LATENCY_TOLERANCE) &&
+	    size < SCHED_ATTR_SIZE_VER2)
+		return -EINVAL;
 	/*
 	 * XXX: Do we want to be lenient like existing syscalls; or do we want
 	 * to be strict and return an error on out-of-bounds values?
@@ -5374,6 +5389,8 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct sched_attr __user *, uattr,
 	else
 		kattr.sched_nice = task_nice(p);
 
+	kattr.sched_latency_tolerance = p->latency_tolerance;
+
 #ifdef CONFIG_UCLAMP_TASK
 	kattr.sched_util_min = p->uclamp_req[UCLAMP_MIN].value;
 	kattr.sched_util_max = p->uclamp_req[UCLAMP_MAX].value;
diff --git a/tools/include/uapi/linux/sched.h b/tools/include/uapi/linux/sched.h
index 99335e1f4a27..5ce62b1be196 100644
--- a/tools/include/uapi/linux/sched.h
+++ b/tools/include/uapi/linux/sched.h
@@ -97,6 +97,7 @@ struct clone_args {
 #define SCHED_FLAG_KEEP_PARAMS		0x10
 #define SCHED_FLAG_UTIL_CLAMP_MIN	0x20
 #define SCHED_FLAG_UTIL_CLAMP_MAX	0x40
+#define SCHED_FLAG_LATENCY_TOLERANCE	0X80
 
 #define SCHED_FLAG_KEEP_ALL	(SCHED_FLAG_KEEP_POLICY | \
 				 SCHED_FLAG_KEEP_PARAMS)
@@ -108,6 +109,7 @@ struct clone_args {
 			 SCHED_FLAG_RECLAIM		| \
 			 SCHED_FLAG_DL_OVERRUN		| \
 			 SCHED_FLAG_KEEP_ALL		| \
-			 SCHED_FLAG_UTIL_CLAMP)
+			 SCHED_FLAG_UTIL_CLAMP		| \
+			 SCHED_FLAG_LATENCY_TOLERANCE)
 
 #endif /* _UAPI_LINUX_SCHED_H */
-- 
2.17.2

