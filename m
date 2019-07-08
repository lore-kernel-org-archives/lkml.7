Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58EFFC48BE7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 04:54:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37BB420659
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 04:54:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbfGHEyl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 00:54:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:24462 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727312AbfGHEyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 00:54:40 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x684piQf094737
        for <linux-kernel@vger.kernel.org>; Mon, 8 Jul 2019 00:54:39 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tkv8h4fwy-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 00:54:39 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <parth@linux.ibm.com>;
        Mon, 8 Jul 2019 05:54:37 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 8 Jul 2019 05:54:35 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x684sYcu20775088
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 8 Jul 2019 04:54:34 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0E1D54C044;
        Mon,  8 Jul 2019 04:54:34 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 02ED74C04E;
        Mon,  8 Jul 2019 04:54:33 +0000 (GMT)
Received: from localhost.in.ibm.com (unknown [9.124.35.94])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  8 Jul 2019 04:54:32 +0000 (GMT)
From:   Parth Shah <parth@linux.ibm.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        subhra.mazumdar@oracle.com
Subject: [RFC 0/2] Optimize the idle CPU search
Date:   Mon,  8 Jul 2019 10:24:30 +0530
X-Mailer: git-send-email 2.17.1
X-TM-AS-GCONF: 00
x-cbid: 19070804-0012-0000-0000-000003302CE3
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19070804-0013-0000-0000-000021698C2C
Message-Id: <20190708045432.18774-1-parth@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-08_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=694 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907080062
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When searching for an idle_sibling, scheduler first iterates to search for
an idle core and then for an idle CPU. By maintaining the idle CPU mask
while iterating through idle cores, we can mark non-idle CPUs for which
idle CPU search would not have to iterate through again. This is especially
true in a moderately load system

Optimize idle CPUs search by marking already found non idle CPUs during
idle core search. This reduces iteration count when searching for idle
CPUs, resulting in lower iteration count.

The results show that the time for `select_idle_cpu` decreases and there is
no regression on time search for `select_idle_core` and almost no
regression on schbench as well. With proper tuning schbench shows benefit
as well when idle_core search fails most times.

When doing this, rename locally used cpumask 'select_idle_mask' to
something else to use this existing mask for such optimization.

Patch set based on tip/core/core

Results
===========
IBM POWER9 system: 2-socket, 44 cores, 176 CPUs

Function latency (with tb tick):
(lower is better)
+--------------+----------+--------+-------------+--------+
| select_idle_ | Baseline | stddev |    Patch    | stddev |
+--------------+----------+--------+-------------+--------+
| core         |     2080 |   1307 | 1975(+5.3%) |   1286 |
| cpu          |      834 |    393 |    91(+89%) |     64 |
| sibling      |     0.96 |  0.003 |   0.89(+7%) |   0.02 |
+--------------+----------+--------+-------------+--------+

Schbench:
- schbench -m 44 -t 1
(lower is better)
+------+----------+--------+------------+--------+
| %ile | Baseline | stddev |   Patch    | stddev |
+------+----------+--------+------------+--------+
|   50 |      9.9 |      2 | 10(-1.01)  |    1.4 |
|   95 |      465 |    3.9 | 465(0%)    |      2 |
|   99 |      561 |     24 | 483(-1.0%) |     14 |
| 99.5 |      631 |     29 | 635(-0.6%) |     32 |
| 99.9 |      801 |     41 | 763(+4.7%) |    125 |
+------+----------+--------+------------+--------+

- 44 threads spread across cores to make select_idle_core return -1 most
  times
- schbench -m 44 -t 1
+-------+----------+--------+-----------+--------+
| %ile  | Baseline | stddev |   patch   | stddev |
+-------+----------+--------+-----------+--------+
|    50 |       10 |      9 | 12(-20%)  |      1 |
|    95 |      468 |      3 | 31(+93%)  |      1 |
|    99 |      577 |     16 | 477(+17%) |     38 |
| 99.95 |      647 |     26 | 482(+25%) |      2 |
| 99.99 |      835 |     61 | 492(+41%) |      2 |
+-------+----------+--------+-----------+--------+


Hackbench:
- 44 threads spread across cores to make select_idle_core return -1 most
  times
- perf bench sched messaging -g 1 -l 100000
(lower is better)
+----------+--------+--------------+--------+
| Baseline | stddev |    patch     | stddev |
+----------+--------+--------------+--------+
|   16.107 |   0.62 | 16.02(+0.5%) |   0.32 |
+----------+--------+--------------+--------+


Series:
- Patch 01: Rename select_idle_mask to reuse the name in next patch
- Patch 02: Optimize the wakeup fast path


Parth Shah (2):
  sched/fair: Rename select_idle_mask to iterator_mask
  sched/fair: Optimize idle CPU search

 kernel/sched/core.c |  3 +++
 kernel/sched/fair.c | 15 ++++++++++-----
 2 files changed, 13 insertions(+), 5 deletions(-)

-- 
2.17.1

