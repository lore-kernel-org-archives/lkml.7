Return-Path: <SRS0=RGqN=Z6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 417BFC43603
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 06:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 15417206D6
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 06:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726406AbfLHGE1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 01:04:27 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34072 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725268AbfLHGE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 01:04:27 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB85xNbf059632
        for <linux-kernel@vger.kernel.org>; Sun, 8 Dec 2019 01:04:25 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wrt1wt1at-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2019 01:04:25 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <parth@linux.ibm.com>;
        Sun, 8 Dec 2019 06:04:23 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 8 Dec 2019 06:04:18 -0000
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xB864HRt35455162
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 8 Dec 2019 06:04:17 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 64E5C11C04C;
        Sun,  8 Dec 2019 06:04:17 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 656A911C04A;
        Sun,  8 Dec 2019 06:04:13 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.85.71.101])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun,  8 Dec 2019 06:04:13 +0000 (GMT)
From:   Parth Shah <parth@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        patrick.bellasi@matbug.net, valentin.schneider@arm.com,
        qais.yousef@arm.com, pavel@ucw.cz, dhaval.giani@oracle.com,
        qperret@qperret.net, David.Laight@ACULAB.COM, pjt@google.com,
        tj@kernel.org, dietmar.eggemann@arm.com
Subject: [PATCH v2 0/3] Introduce per-task latency_tolerance for scheduler hints
Date:   Sun,  8 Dec 2019 11:34:07 +0530
X-Mailer: git-send-email 2.17.2
X-TM-AS-GCONF: 00
x-cbid: 19120806-0020-0000-0000-000003957195
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19120806-0021-0000-0000-000021ECA8B0
Message-Id: <20191208060410.17814-1-parth@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-08_01:2019-12-05,2019-12-08 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 phishscore=0 clxscore=1015 bulkscore=0 priorityscore=1501
 malwarescore=0 suspectscore=0 impostorscore=0 mlxscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912080054
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the 2nd revision of the patch set to introduce latency_tolerance as
a per task attribute.

The previous version can be found at:
v1: https://lkml.org/lkml/2019/11/25/151

Changes in this revision are:
v1 -> v2:
- Addressed comments from Qais Yousef
- As per suggestion from Dietmar, moved content from newly created
  include/linux/sched/latency_tolerance.h to kernel/sched/sched.h
- Extend sched_setattr() to support latency_tolerance in tools headers UAPI


This patch series introduces a new per-task attribute latency_tolerance to
provide the scheduler hints about the latency requirements of the task [1].

Latency_tolerance is a ranged attribute of a task with the value ranging
from [-20, 19] both inclusive which makes it align with the task nice
value.

The value should provide scheduler hints about the relative latency
requirements of tasks, meaning the task with "latency_tolerance = -20"
should have lower latency than compared to those tasks with higher values.
Similarly a task with "latency_tolerance = 19" can have higher latency and
hence such tasks may not care much about latency.

The default value is set to 0. The usecases discussed below can use this
range of [-20, 19] for latency_tolerance for the specific purpose. This
patch does not implement any use cases for such attribute so that any
change in naming or range does not affect much to the other (future)
patches using this. The actual use of latency_tolerance during task wakeup
and load-balancing is yet to be coded for each of those usecases.

As per my view, this defined attribute can be used in following ways for a
some of the usecases:
1 Reduce search scan time for select_idle_cpu():
- Reduce search scans for finding idle CPU for a waking task with lower
  latency_tolerance values.

2 TurboSched:
- Classify the tasks with higher latency_tolerance values as a small
  background task given that its historic utilization is very low, for
  which the scheduler can search for more number of cores to do task
  packing.  A task with a latency_tolerance >= some_threshold (e.g, >= +18)
  and util <= 12.5% can be background tasks.

3 Optimize AVX512 based workload:
- Bias scheduler to not put a task having (latency_tolerance == -20) on a
  core occupying AVX512 based workload.

Series Organization:
====================
- Patch 1: Add new attribute latency_tolerance to task_struct.
- Patch 2: Clone parent task's attribute to the child task on fork
- Patch 3: Add support for sched_{set,get}attr syscall to modify
  	     latency_tolerance of the task

Patch 1 is kept separate for review purposes and may be merged to patch 3.

Though, the comment https://lkml.org/lkml/2019/12/6/276 from Dietmar
suggests using latency_nice as the shorter name instead of currently the
proposed name, this patch series still uses latency_tolerance as the task
attribute, but will change the name to the desired name on further
comments.


The patch series can be applied on tip/sched/core at the
commit de881a341c41 ("Merge branch 'sched/rt' into sched/core, to pick up commit")


References:
============
[1]. Usecases for the per-task latency-nice attribute,
     https://lkml.org/lkml/2019/9/30/215
[2]. Task Latency-nice, "Subhra Mazumdar",
     https://lkml.org/lkml/2019/8/30/829


Parth Shah (3):
  sched: Introduce latency-tolerance as a per-task attribute
  sched/core: Propagate parent task's latency requirements to the child
    task
  sched: Allow sched_{get,set}attr to change latency_tolerance of the
    task

 include/linux/sched.h            |  1 +
 include/uapi/linux/sched.h       |  4 +++-
 include/uapi/linux/sched/types.h | 19 +++++++++++++++++++
 kernel/sched/core.c              | 21 +++++++++++++++++++++
 kernel/sched/sched.h             | 18 ++++++++++++++++++
 tools/include/uapi/linux/sched.h |  4 +++-
 6 files changed, 65 insertions(+), 2 deletions(-)

-- 
2.17.2

