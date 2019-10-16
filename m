Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 442AAC4360C
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 07:21:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1988920873
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 07:21:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404009AbfJPHVa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 03:21:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:3594 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726875AbfJPHVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 03:21:30 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9G7ILIB088116
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 03:21:28 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vnvpy4150-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 03:21:28 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <parth@linux.ibm.com>;
        Wed, 16 Oct 2019 08:21:26 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 16 Oct 2019 08:21:22 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9G7LLqU38011060
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Oct 2019 07:21:21 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 61456A4060;
        Wed, 16 Oct 2019 07:21:21 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9B9EDA405B;
        Wed, 16 Oct 2019 07:21:19 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.35.59])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 16 Oct 2019 07:21:19 +0000 (GMT)
Subject: Re: [PATCH v3 0/8] sched/fair: rework the CFS load balance
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org
Cc:     pauld@redhat.com, valentin.schneider@arm.com,
        srikar@linux.vnet.ibm.com, quentin.perret@arm.com,
        dietmar.eggemann@arm.com, Morten.Rasmussen@arm.com,
        hdanton@sina.com
References: <1568878421-12301-1-git-send-email-vincent.guittot@linaro.org>
From:   Parth Shah <parth@linux.ibm.com>
Date:   Wed, 16 Oct 2019 12:51:17 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1568878421-12301-1-git-send-email-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19101607-0016-0000-0000-000002B87903
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19101607-0017-0000-0000-000033199A37
Message-Id: <66c8f739-aecd-1e1c-0571-047ce7bafcc7@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-16_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910160067
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/19/19 1:03 PM, Vincent Guittot wrote:
> Several wrong task placement have been raised with the current load
> balance algorithm but their fixes are not always straight forward and
> end up with using biased values to force migrations. A cleanup and rework
> of the load balance will help to handle such UCs and enable to fine grain
> the behavior of the scheduler for other cases.
> 
> Patch 1 has already been sent separately and only consolidate asym policy
> in one place and help the review of the changes in load_balance.
> 
> Patch 2 renames the sum of h_nr_running in stats.
> 
> Patch 3 removes meaningless imbalance computation to make review of
> patch 4 easier.
> 
> Patch 4 reworks load_balance algorithm and fixes some wrong task placement
> but try to stay conservative.
> 
> Patch 5 add the sum of nr_running to monitor non cfs tasks and take that
> into account when pulling tasks.
> 
> Patch 6 replaces runnable_load by load now that the signal is only used
> when overloaded.
> 
> Patch 7 improves the spread of tasks at the 1st scheduling level.
> 
> Patch 8 uses utilization instead of load in all steps of misfit task
> path.
> 
> Patch 9 replaces runnable_load_avg by load_avg in the wake up path.
> 
> Patch 10 optimizes find_idlest_group() that was using both runnable_load
> and load. This has not been squashed with previous patch to ease the
> review.
> 
> Some benchmarks results based on 8 iterations of each tests:
> - small arm64 dual quad cores system
> 
>            tip/sched/core        w/ this patchset    improvement
> schedpipe      54981 +/-0.36%        55459 +/-0.31%   (+0.97%)
> 
> hackbench
> 1 groups       0.906 +/-2.34%        0.906 +/-2.88%   (+0.06%)
> 
> - large arm64 2 nodes / 224 cores system
> 
>            tip/sched/core        w/ this patchset    improvement
> schedpipe     125323 +/-0.98%       125624 +/-0.71%   (+0.24%)
> 
> hackbench -l (256000/#grp) -g #grp
> 1 groups      15.360 +/-1.76%       14.206 +/-1.40%   (+8.69%)
> 4 groups       5.822 +/-1.02%        5.508 +/-6.45%   (+5.38%)
> 16 groups      3.103 +/-0.80%        3.244 +/-0.77%   (-4.52%)
> 32 groups      2.892 +/-1.23%        2.850 +/-1.81%   (+1.47%)
> 64 groups      2.825 +/-1.51%        2.725 +/-1.51%   (+3.54%)
> 128 groups     3.149 +/-8.46%        3.053 +/-13.15%  (+3.06%)
> 256 groups     3.511 +/-8.49%        3.019 +/-1.71%  (+14.03%)
> 
> dbench
> 1 groups     329.677 +/-0.46%      329.771 +/-0.11%   (+0.03%)
> 4 groups     931.499 +/-0.79%      947.118 +/-0.94%   (+1.68%)
> 16 groups   1924.210 +/-0.89%     1947.849 +/-0.76%   (+1.23%)
> 32 groups   2350.646 +/-5.75%     2351.549 +/-6.33%   (+0.04%)
> 64 groups   2201.524 +/-3.35%     2192.749 +/-5.84%   (-0.40%)
> 128 groups  2206.858 +/-2.50%     2376.265 +/-7.44%   (+7.68%)
> 256 groups  1263.520 +/-3.34%     1633.143 +/-13.02% (+29.25%)
> 
> tip/sched/core sha1:
>   0413d7f33e60 ('sched/uclamp: Always use 'enum uclamp_id' for clamp_id values')
> [...]

I am quietly impressed with this patch series as it makes easy to
understand the behavior of the load balancer just by looking at the code.

I have tested v3 on IBM POWER9 system with following configuration:
- CPU(s):              176
- Thread(s) per core:  4
- Core(s) per socket:  22
- Socket(s):           2
- Model name:          POWER9, altivec supported
- NUMA node0 CPU(s):   0-87
- NUMA node8 CPU(s):   88-175

I see results in par with the baseline (tip/sched/core) with most of my
testings.

hackbench
=========
hackbench -l (256000/#grp) -g #grp (lower is better):
+--------+--------------------+-------------------+------------------+
| groups |     w/ patches     |     Baseline      | Performance gain |
+--------+--------------------+-------------------+------------------+
|      1 | 14.948 (+/- 0.10)  | 15.13 (+/- 0.47 ) | +1.20            |
|      4 | 5.938 (+/- 0.034)  | 6.085 (+/- 0.07)  | +2.4             |
|      8 | 6.594 (+/- 0.072)  | 6.223 (+/- 0.03)  | -5.9             |
|     16 | 5.916 (+/- 0.05)   | 5.559 (+/- 0.00)  | -6.4             |
|     32 | 5.288 (+/- 0.034)  | 5.23 (+/- 0.01)   | -1.1             |
|     64 | 5.147 (+/- 0.036)  | 5.193 (+/- 0.09)  | +0.8             |
|    128 | 5.368 (+/- 0.0245) | 5.446 (+/- 0.04)  | +1.4             |
|    256 | 5.637 (+/- 0.088)  | 5.596 (+/- 0.07)  | -0.7             |
|    512 | 5.78 (+/- 0.0637)  | 5.934 (+/- 0.06)  | +2.5             |
+--------+--------------------+-------------------+------------------+


dbench
========
dbench <grp> (Throughput: Higher is better):
+---------+---------------------+-----------------------+----------+
| groups  |     w/ patches      |        baseline       |    gain  |
+---------+---------------------+-----------------------+----------+
|       1 |    12.6419(+/-0.58) |    12.6511 (+/-0.277) |   -0.00  |
|       4 |    23.7712(+/-2.22) |    21.8526 (+/-0.844) |   +8.7   |
|       8 |    40.1333(+/-0.85) |    37.0623 (+/-3.283) |   +8.2   |
|      16 |   60.5529(+/-2.35)  |    60.0972 (+/-9.655) |   +0.7   |
|      32 |   98.2194(+/-1.69)  |    87.6701 (+/-10.72) |   +12.0  |
|      64 |   150.733(+/-9.91)  |    109.782 (+/-0.503) |   +37.3  |
|     128 |  173.443(+/-22.4)   |    130.006 (+/-21.84) |   +33.4  |
|     256 |  121.011(+/-15.2)   |    120.603 (+/-11.82) |   +0.3   |
|     512 |  10.9889(+/-0.39)   |    12.5518 (+/-1.030) |   -12    |
+---------+---------------------+-----------------------+----------+



I am happy with the results as it turns to be beneficial in most cases.
Still I will be doing testing for different scenarios and workloads.
BTW do you have any specific test case which might show different behavior
for SMT-4/8 systems with these patch set?


Thanks,
Parth

