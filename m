Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F8CC06513
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 12:35:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A955B2082E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 12:35:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727752AbfGDMfE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 08:35:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:4960 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727632AbfGDMfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 08:35:04 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x64CHk9q027494
        for <linux-kernel@vger.kernel.org>; Thu, 4 Jul 2019 08:35:02 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2thgacjy2c-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 08:35:02 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <parth@linux.ibm.com>;
        Thu, 4 Jul 2019 13:35:00 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 4 Jul 2019 13:34:55 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x64CYsgI50528482
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 4 Jul 2019 12:34:54 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B566DAE053;
        Thu,  4 Jul 2019 12:34:54 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8C6CDAE05A;
        Thu,  4 Jul 2019 12:34:50 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.61.157])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  4 Jul 2019 12:34:50 +0000 (GMT)
Subject: Re: [PATCH v3 5/7] sched: SIS_CORE to disable idle core search
To:     Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, tglx@linutronix.de,
        steven.sistare@oracle.com, dhaval.giani@oracle.com,
        daniel.lezcano@linaro.org, vincent.guittot@linaro.org,
        viresh.kumar@linaro.org, tim.c.chen@linux.intel.com,
        mgorman@techsingularity.net
References: <20190627012919.4341-1-subhra.mazumdar@oracle.com>
 <20190627012919.4341-6-subhra.mazumdar@oracle.com>
 <0e0f3347-c262-2917-76d7-88dddf4e9122@linux.ibm.com>
 <59ab08d5-8b7c-00b9-230b-7c0b307a675f@oracle.com>
 <be91602a-0243-e094-8c8f-ceed314d10ce@linux.ibm.com>
 <12402fea-7b87-8c4d-9485-53f973c38654@oracle.com>
From:   Parth Shah <parth@linux.ibm.com>
Date:   Thu, 4 Jul 2019 18:04:49 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <12402fea-7b87-8c4d-9485-53f973c38654@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19070412-0020-0000-0000-000003503AA4
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19070412-0021-0000-0000-000021A3D776
Message-Id: <aac9f826-ab73-2754-4a7b-7d948f1edf92@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-04_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907040157
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/2/19 2:07 AM, Subhra Mazumdar wrote:
> 
>>>> Also, systems like POWER9 has sd_llc as a pair of core only. So it
>>>> won't benefit from the limits and hence also hiding your code in select_idle_cpu
>>>> behind static keys will be much preferred.
>>> If it doesn't hurt then I don't see the point.
>>>
>> So these is the result from POWER9 system with your patches:
>> System configuration: 2 Socket, 44 cores, 176 CPUs
>>
>> Experiment setup:
>> ===========
>> => Setup 1:
>> - 44 tasks doing just while(1), this is to make select_idle_core return -1 most times
>> - perf bench sched messaging -g 1 -l 1000000
>> +-----------+--------+--------------+--------+
>> | Baseline  | stddev |    Patch     | stddev |
>> +-----------+--------+--------------+--------+
>> |       135 |   3.21 | 158(-17.03%) |   4.69 |
>> +-----------+--------+--------------+--------+
>>
>> => Setup 2:
>> - schbench -m44 -t 1
>> +=======+==========+=========+=========+==========+
>> | %ile  | Baseline | stddev  |  patch  |  stddev  |
>> +=======+==========+=========+=========+==========+
>> |    50 |       10 |    3.49 |      10 |     2.29 |
>> +-------+----------+---------+---------+----------+
>> |    95 |      467 |    4.47 |     469 |     0.81 |
>> +-------+----------+---------+---------+----------+
>> |    99 |      571 |   21.32 |     584 |    18.69 |
>> +-------+----------+---------+---------+----------+
>> |  99.5 |      629 |   30.05 |     641 |    20.95 |
>> +-------+----------+---------+---------+----------+
>> |  99.9 |      780 |   40.38 |     773 |     44.2 |
>> +-------+----------+---------+---------+----------+
>>
>> I guess it doesn't make much difference in schbench results but hackbench (perf bench)
>> seems to have an observable regression.
>>
>>
>> Best,
>> Parth
>>
> If POWER9 sd_llc has only 2 cores, the behavior shouldn't change much with
> the select_idle_cpu changes as the limits are 1 and 2 core. Previously the
> lower bound was 4 cpus and upper bound calculated by the prop. Now it is
> 1 core (4 cpus on SMT4) and upper bound 2 cores. Could it be the extra
> computation of cpumask_weight causing the regression rather than the
> sliding window itself (one way to check this would be hardcode 4 in place
> of topology_sibling_weight)? Or is it the L1 cache coherency? I am a bit
> suprised because SPARC SMT8 which has more cores in sd_llc and L1 cache per
> core showed improvement with Hackbench.
> 

Same experiment with hackbench and with perf analysis shows increase in L1
cache miss rate with these patches
(Lower is better)
                          Baseline(%)   Patch(%)   
 ----------------------- ------------- ----------- 
  Total Cache miss rate         17.01   19(-11%)   
  L1 icache miss rate            5.45   6.7(-22%) 



So is is possible for idle_cpu search to try checking target_cpu first and
then goto sliding window if not found.
Below diff works as expected in IBM POWER9 system and resolves the problem
of far wakeup upto large extent.

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ff2e9b5c3ac5..fae035ce1162 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6161,6 +6161,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
        u64 time, cost;
        s64 delta;
        int cpu, limit, floor, target_tmp, nr = INT_MAX;
+       struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
 
        this_sd = rcu_dereference(*this_cpu_ptr(&sd_llc));
        if (!this_sd)
@@ -6198,16 +6199,22 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
 
        time = local_clock();
 
-       for_each_cpu_wrap(cpu, sched_domain_span(sd), target_tmp) {
+       cpumask_and(cpus, sched_domain_span(sd), &p->cpus_allowed);
+       for_each_cpu_wrap(cpu, cpu_smt_mask(target), target) {
+               __cpumask_clear_cpu(cpu, cpus);
+               if (available_idle_cpu(cpu))
+                       goto idle_cpu_exit;
+       }
+
+       for_each_cpu_wrap(cpu, cpus, target_tmp) {
                per_cpu(next_cpu, target) = cpu;
                if (!--nr)
                        return -1;
-               if (!cpumask_test_cpu(cpu, &p->cpus_allowed))
-                       continue;
                if (available_idle_cpu(cpu))
                        break;
        }
 
+idle_cpu_exit:
        time = local_clock() - time;
        cost = this_sd->avg_scan_cost;
        delta = (s64)(time - cost) / 8;



Best,
Parth

