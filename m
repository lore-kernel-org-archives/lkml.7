Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D5BC48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 22:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D4EA216FD
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 22:53:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="f3nz/c44"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfFZWxJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 18:53:09 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:39838 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726431AbfFZWxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 18:53:08 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5QMmotN100217;
        Wed, 26 Jun 2019 22:52:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=Hr9zrauEoxTgJRtfOsjDwjRXBC+R8YyRKtKA9BE3nsY=;
 b=f3nz/c4405CBB873NZXddM+6lqJC+Hmhfi6xf1or1cwZc+svmT9KO8AiigUWJvH8N5qU
 YhOwVFHD2tPMbXcLiol0DdCR9PKNU+BLi+ummnCYB2kPHpGVhRNo5LtGSVgdP8TfMOt/
 BEgh0w6pHK8pOTHmoqKC/7Y3ueD2MIxTc+iqPbkStJZ0VHn7pwO2J6qjdJIYSn/qUxP+
 0f9V8QQuYmO/7w6TSZ8sSbiw1EFGCfrJvvc3DifgPVNada3UF6wi/+/nrjsRdbfy1tvL
 0M11lcUIdrPHifqaTfu/4KA1X2DmOHeQwyAVp3EwzR7JQzFfEWYrtzUJvmpDTwRePj5r Xg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2t9brtd1ab-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jun 2019 22:52:29 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5QMpXkx012606;
        Wed, 26 Jun 2019 22:52:28 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2t9accxudm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jun 2019 22:52:28 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5QMqPeD024166;
        Wed, 26 Jun 2019 22:52:26 GMT
Received: from smazumda-Precision-T1600.us.oracle.com (/10.132.91.175)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 26 Jun 2019 15:52:24 -0700
From:   subhra mazumdar <subhra.mazumdar@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, tglx@linutronix.de,
        prakash.sangappa@oracle.com, dhaval.giani@oracle.com,
        daniel.lezcano@linaro.org, vincent.guittot@linaro.org,
        viresh.kumar@linaro.org, tim.c.chen@linux.intel.com,
        mgorman@techsingularity.net
Subject: [RFC PATCH 0/3] Scheduler Soft Affinity
Date:   Wed, 26 Jun 2019 15:47:15 -0700
Message-Id: <20190626224718.21973-1-subhra.mazumdar@oracle.com>
X-Mailer: git-send-email 2.9.3
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9300 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=769
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906260261
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9300 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=822 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906260262
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When multiple instances of workloads are consolidated in same host it is
good practice to partition them for best performance. For e.g give a NUMA
node parition to each instance. Currently Linux kernel provides two
interfaces to hard parition: sched_setaffinity system call or cpuset.cpus
cgroup. But this doesn't allow one instance to burst out of its partition
and use available CPUs from other partitions when they are idle. Running
all instances free range without any affinity, on the other hand, suffers
from cache coherence overhead across sockets (NUMA nodes) when all
instances are busy.

To achieve the best of both worlds, one potential way is to use AutoNUMA
balancer which migrates memory and threads to align them on same NUMA node
when all instances are busy. But it doesn't work if memory is spread across
NUMA nodes, has high reaction time due to periodic scanning mechanism and
can't handle sub-NUMA levels. Some motivational experiments were done with
2 DB instances running on a 2 socket x86 Intel system with 22 cores per
socket. 'numactl -m' was used to bind the memory of each instance to one
NUMA node, the idea was to have AutoNUMA migrate only threads as memory is
pinned. But AutoNUMA ON vs OFF didn't make any difference in performance.
Also it was found that AutoNUMA still migrated pages across NUMA nodes, so
numactl only controls the initial allocation of memory and AutoNUMA is free
to migrate them later. Following are the vmstats for different number of
users running TPC-C in each DB instance with numactl and AutoNUMA ON. With
AutnoNUMA OFF the page migrations were of course zero.

users (2x16)            
numa_hint_faults        1672485
numa_hint_faults_local  1158283
numa_pages_migrated     373670
    
users (2x24)            
numa_hint_faults        2267425
numa_hint_faults_local  1548501
numa_pages_migrated     586473
    
    
users (2x32)            
numa_hint_faults        1916625
numa_hint_faults_local  1499772
numa_pages_migrated     229581

Given the above drawbacks, the most logical way to achieve the desired
behavior is via the task scheduler. A new interface is added, a new system
call sched_setaffinity2 in this case, to specify the set of soft affinity
CPUs. It takes an extra paremeter to specify hard or soft affinity, where
hard behaves same as existing sched_setaffinity. I am open to using other
interfaces like cgroup or anything else I might not have considered. Also
this patchset only allows it for CFS class threads as for RT class the
preferential search latency may not be tolerated. But nothing in theory
stops us from implementing soft affinity for RT class too. Finally it
also adds new scheduler tunables to tune the "softness" of soft affinity
as different workload may have different optimal points. This is done
using two tunables sched_allowed and sched_preferred, where if the ratio
of CPU utilization of the prefrred set and allowed set crosses the ratio
sched_allowed:sched_preferred, scheduler will use the entire allowed set
instead of the preferred set in the first level of search in
select_task_rq_fair. The default value is 100:1.

Following are the performance results of running 2 and 1 instance(s) of
Hackbench and Oracle DB on 2 socket Intel x86 system with 22 cores per
socket with the default tunable settings. For 2 instance case DB shows
substantial improvement over no affinity but Hackbench shows negligible
improvement. For 1 instance case DB performance is close to no affinity,
but Hackbench has significant regression. Hard affinity numbers are also
added for comparison. The load in each Hackbench and DB instance is varied
by varying the number of groups and users respectively. %gain is w.r.t
no affinity.

(100:1)
Hackbench   %gain with soft affinity        %gain with hard affinity
2*4	    1.12			    1.3
2*8	    1.67			    1.35
2*16	    1.3				    1.12
2*32        0.31			    0.61
1*4	    -18				    -58
1*8	    -24				    -59
1*16	    -33				    -72
1*32	    -38				    -83

DB	    %gain with soft affinity	    %gain with hard affinity
2*16	    4.26			    4.1
2*24	    5.43			    7.17
2*32	    6.31			    6.22
1*16	    -0.02			    0.62
1*24	    0.12			    -26.1
1*32	    -1.48			    -8.65

The experiments were repeated with sched_allowed:sched_preferred set to
5:4 to have "softer" soft affinity. Following numbers show it preserves the
(negligible) improvement for 2 instance Hackbench case but reduces the
regression for 1 instance significantly. For DB this setting doesn't work
well as the improvements for 2 instance case goes away. This also shows
different workloads have different optimal setting.

(5:4)
Hackbench   %gain with soft affinity
2*4	    1.43
2*8	    1.36
2*16	    1.01
2*32	    1.45
1*4	    -2.55
1*8	    -5.06
1*16	    -8
1*32	    -7.32
                                                                           
DB          %gain with soft affinity
2*16	    0.46
2*24	    3.68
2*32	    -3.34
1*16	    0.08
1*24	    1.6
1*32	    -1.29

Finally I measured the overhead of soft affinity when it is NOT used by
comparing it with baseline kernel in case of no affinity and hard affinity
with Hackbench. The following is the improvement of soft affinity kernel
w.r.t baseline, but really numbers are in noise margin. This shows soft
affinity has no overhead when not used.

Hackbench   %diff of no affinity	%diff of hard affinity
2*4	    0.11			0.31
2*8	    0.13			0.55
2*16	    0.61			0.90
2*32	    0.86			1.01
1*4	    0.48			0.43
1*8	    0.45			0.33
1*16	    0.61			0.64
1*32	    0.11			0.63

A final set of experiments were done (numbers not shown) having the memory
of each DB instance spread evenly across both NUMA nodes. This showed
similar improvements with soft affinity for 2 instance case, thus proving
the improvement is due to saving LLC coherence overhead.

subhra mazumdar (3):
  sched: Introduce new interface for scheduler soft affinity
  sched: change scheduler to give preference to soft affinity CPUs
  sched: introduce tunables to control soft affinity

 arch/x86/entry/syscalls/syscall_64.tbl |   1 +
 include/linux/sched.h                  |   5 +-
 include/linux/sched/sysctl.h           |   2 +
 include/linux/syscalls.h               |   3 +
 include/uapi/asm-generic/unistd.h      |   4 +-
 include/uapi/linux/sched.h             |   3 +
 init/init_task.c                       |   2 +
 kernel/compat.c                        |   2 +-
 kernel/rcu/tree_plugin.h               |   3 +-
 kernel/sched/core.c                    | 167 ++++++++++++++++++++++++++++-----
 kernel/sched/fair.c                    | 154 ++++++++++++++++++++++--------
 kernel/sched/sched.h                   |   2 +
 kernel/sysctl.c                        |  14 +++
 13 files changed, 297 insertions(+), 65 deletions(-)

-- 
2.9.3

