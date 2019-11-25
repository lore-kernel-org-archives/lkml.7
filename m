Return-Path: <SRS0=OOqn=ZR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F794C432C0
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 09:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32E0F207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Nov 2019 09:46:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbfKYJqd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Nov 2019 04:46:33 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:21510 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727133AbfKYJqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Nov 2019 04:46:32 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xAP9gMOl016123
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 04:46:31 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wfjwkbk31-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2019 04:46:31 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <parth@linux.ibm.com>;
        Mon, 25 Nov 2019 09:46:29 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 25 Nov 2019 09:46:23 -0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xAP9kMhw55312450
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 25 Nov 2019 09:46:22 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0B3C5A4060;
        Mon, 25 Nov 2019 09:46:22 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3276EA405B;
        Mon, 25 Nov 2019 09:46:19 +0000 (GMT)
Received: from localhost.in.ibm.com (unknown [9.124.35.38])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 25 Nov 2019 09:46:19 +0000 (GMT)
From:   Parth Shah <parth@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        patrick.bellasi@matbug.net, valentin.schneider@arm.com,
        qais.yousef@arm.com, pavel@ucw.cz, dhaval.giani@oracle.com,
        qperret@qperret.net, David.Laight@ACULAB.COM,
        morten.rasmussen@arm.com, pjt@google.com, tj@kernel.org,
        dietmar.eggemann@arm.com, viresh.kumar@linaro.org,
        rafael.j.wysocki@intel.com, daniel.lezcano@linaro.org
Subject: [RFC 0/3] Introduce per-task latency_tolerance for scheduler hints
Date:   Mon, 25 Nov 2019 15:16:15 +0530
X-Mailer: git-send-email 2.17.2
X-TM-AS-GCONF: 00
x-cbid: 19112509-0012-0000-0000-0000036BE639
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19112509-0013-0000-0000-000021A78572
Message-Id: <20191125094618.30298-1-parth@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-11-25_02:2019-11-21,2019-11-25 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 clxscore=1011 impostorscore=0 mlxlogscore=606 spamscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 adultscore=0
 priorityscore=1501 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-1911250089
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series is based on the discussion started as the "Usecases for
the per-task latency-nice attribute"[1]

This patch series introduces a new per-task attribute latency_tolerance to
provide the scheduler hints about the latency requirements of the task.

Latency_tolerance is a ranged attribute of a task with the value ranging
from [-20, 19] both inclusive which makes it align with the task nice
value.

The value should provide scheduler hints about the relative latency
requirements of tasks, meaning the task with "latency_tolerance = -20"
should have lower latency than compared to those tasks with higher values.
Similarly a task with "latency_tolerance = 19" can have higher latency and
hence such tasks may bot care much about the latency numbers.

The default value is set to 0. The usecases defined in [1] can use this
range of [-20, 19] for latency_tolerance for the specific purpose. This
patch does not define any use cases for such attribute so that any change
in naming or range does not affect much to the other (future) patches using
this. The actual use of latency_tolerance during task wakeup and
load-balancing is yet to be coded for each of those usecases.

As per my view, this defined attribute can be used in following ways for a
some of the usecases:
1 Reduce search scan time for select_idle_cpu():
- Reduce search scans for finding idle CPU for a waking task with lower
  latency_tolerance values.

2 TurboSched:
- Classify the tasks with higher latency_tolerance values as a small
  background task given that its historic utilization is very low, for
  which the scheduler can search for more number of cores to do task
  packing.  A task with a latency_tolerance >= some threshold (e.g, >= +18)
  and util <= 12.5% can be background tasks.

3 Optimize AVX512 based workload:
- Bias scheduler to not put a task having latency_tolerance==-20 on a core
  occupying AVX512 based workload.

Series Organization:
======================
- Patch [1]: Add new attribute latency_tolerance to task_struct
- Patch [2]: Clone parent task's attribute on fork
- Patch [3]: Add support to sched_{set,get}attr syscall to modify
  	     latency_tolerance of the task

The patch series can be applied on tip/sched/core at
commit 57abff067a08 ("sched/fair: Rework find_idlest_group()")


References:
===========
[1]. Usecases for the per-task latency-nice attribute,
     https://lkml.org/lkml/2019/9/30/215
[2]. Task Latency-nice, "Subhra Mazumdar",
     https://lkml.org/lkml/2019/8/30/829



Parth Shah (3):
  Introduce latency-tolerance as an per-task attribute
  Propagate parent task's latency requirements to the child task
  Allow sched_{get,set}attr to change latency_tolerance of the task

 include/linux/sched.h                   |  3 +++
 include/linux/sched/latency_tolerance.h | 13 +++++++++++++
 include/uapi/linux/sched.h              |  4 +++-
 include/uapi/linux/sched/types.h        |  2 ++
 kernel/sched/core.c                     | 19 +++++++++++++++++++
 kernel/sched/sched.h                    |  1 +
 6 files changed, 41 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/sched/latency_tolerance.h

-- 
2.17.2

