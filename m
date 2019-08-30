Return-Path: <SRS0=2mSC=W2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0902DC3A59B
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 17:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D14F620659
	for <linux-kernel@archiver.kernel.org>; Fri, 30 Aug 2019 17:57:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VfcsN85j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728072AbfH3R5a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 30 Aug 2019 13:57:30 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:36118 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727883AbfH3R53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Aug 2019 13:57:29 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7UHt6ZN088774;
        Fri, 30 Aug 2019 17:55:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2019-08-05;
 bh=P+esqZlZhoTixDu4MiNwQEcjlm78p9B1JBsdoAW4q5o=;
 b=VfcsN85j7DI3n75Xw9Tyvq/bmGAy11lABRO/Ept4clOTo0z6gWyvTG1XYDjOfCE6c5J6
 VW4zSLBXcqBATNEdEwbysp7stGE9RTmPckglJh8BDMRnwvFMjqV042pvNirHGAv3dF8i
 xh4BjD+g30aG9HNzQjbbOq0/uhOa2sOfWVjatRpndeypdZe/wov9JofUJCd2aDD0B1zN
 3tzs5XZoZVWXNT/4bVJlePjYazZeJ/T15iUcyZHltjybXhA+GTOe0u6XGIyaXilgbKmS
 Ae7OQxOslK7gaLJYMOQ9exO+cU+suShnHQenbKnObMpWiIFGie0LKfuBbliSwrXo/sXx Ig== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2uq8fsg20u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Aug 2019 17:55:16 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x7UHrd3H017963;
        Fri, 30 Aug 2019 17:54:35 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2upxabkvrj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 30 Aug 2019 17:54:35 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x7UHsVdk018950;
        Fri, 30 Aug 2019 17:54:32 GMT
Received: from smazumda-Precision-T1600.us.oracle.com (/10.132.91.113)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 30 Aug 2019 10:54:31 -0700
From:   subhra mazumdar <subhra.mazumdar@oracle.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, tglx@linutronix.de,
        steven.sistare@oracle.com, dhaval.giani@oracle.com,
        daniel.lezcano@linaro.org, vincent.guittot@linaro.org,
        viresh.kumar@linaro.org, tim.c.chen@linux.intel.com,
        mgorman@techsingularity.net, parth@linux.ibm.com,
        patrick.bellasi@arm.com
Subject: [RFC PATCH 0/9] Task latency-nice
Date:   Fri, 30 Aug 2019 10:49:35 -0700
Message-Id: <20190830174944.21741-1-subhra.mazumdar@oracle.com>
X-Mailer: git-send-email 2.9.3
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9365 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=543
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1908300174
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9365 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=595 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1908300174
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce new per task property latency-nice for controlling scalability
in scheduler idle CPU search path. Valid latency-nice values are from 1 to
100 indicating 1% to 100% search of the LLC domain in select_idle_cpu. New
CPU cgroup file cpu.latency-nice is added as an interface to set and get.
All tasks in the same cgroup share the same latency-nice value. Using a
lower latency-nice value can help latency intolerant tasks e.g very short
running OLTP threads where full LLC search cost can be significant compared
to run time of the threads. The default latency-nice value is 5.

In addition to latency-nice, it also adds a new sched feature SIS_CORE to
be able to disable idle core search altogether which is costly and hurts
more than it helps in short running workloads.

Finally it also introduces a new per-cpu variable next_cpu to track
the limit of search so that every time search starts from where it ended.
This rotating search window over cpus in LLC domain ensures that idle
cpus are eventually found in case of high load.

Uperf pingpong on 2 socket, 44 core and 88 threads Intel x86 machine with
message size = 8k (higher is better):
threads baseline   latency-nice=5,SIS_CORE     latency-nice=5,NO_SIS_CORE 
8       64.66      64.38 (-0.43%)              64.79 (0.2%)
16      123.34     122.88 (-0.37%)             125.87 (2.05%)
32      215.18     215.55 (0.17%)              247.77 (15.15%)
48      278.56     321.6 (15.45%)              321.2 (15.3%)
64      259.99     319.45 (22.87%)             333.95 (28.44%)
128     431.1      437.69 (1.53%)              431.09 (0%)

subhra mazumdar (9):
  sched,cgroup: Add interface for latency-nice
  sched: add search limit as per latency-nice
  sched: add sched feature to disable idle core search
  sched: SIS_CORE to disable idle core search
  sched: Define macro for number of CPUs in core
  x86/smpboot: Optimize cpumask_weight_sibling macro for x86
  sched: search SMT before LLC domain
  sched: introduce per-cpu var next_cpu to track search limit
  sched: rotate the cpu search window for better spread

 arch/x86/include/asm/smp.h      |  1 +
 arch/x86/include/asm/topology.h |  1 +
 arch/x86/kernel/smpboot.c       | 17 ++++++++++++++++-
 include/linux/sched.h           |  1 +
 include/linux/topology.h        |  4 ++++
 kernel/sched/core.c             | 42 +++++++++++++++++++++++++++++++++++++++++
 kernel/sched/fair.c             | 34 +++++++++++++++++++++------------
 kernel/sched/features.h         |  1 +
 kernel/sched/sched.h            |  9 +++++++++
 9 files changed, 97 insertions(+), 13 deletions(-)

-- 
2.9.3

