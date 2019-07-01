Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B69EC0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 09:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3F74213F2
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 09:58:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727904AbfGAJ6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 05:58:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49230 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727279AbfGAJ6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 05:58:07 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x619vIc4096007
        for <linux-kernel@vger.kernel.org>; Mon, 1 Jul 2019 05:58:06 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tfem5vadh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 05:58:05 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <parth@linux.ibm.com>;
        Mon, 1 Jul 2019 10:58:03 +0100
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Mon, 1 Jul 2019 10:57:58 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x619vvvL27000962
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 1 Jul 2019 09:57:57 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7C2E4A4053;
        Mon,  1 Jul 2019 09:57:57 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 94CFDA404D;
        Mon,  1 Jul 2019 09:57:55 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.35.174])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon,  1 Jul 2019 09:57:55 +0000 (GMT)
From:   Parth Shah <parth@linux.ibm.com>
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
Date:   Mon, 1 Jul 2019 15:27:54 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <59ab08d5-8b7c-00b9-230b-7c0b307a675f@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19070109-0016-0000-0000-0000028E13FE
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19070109-0017-0000-0000-000032EB9FB2
Message-Id: <be91602a-0243-e094-8c8f-ceed314d10ce@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-01_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907010123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/29/19 3:59 AM, Subhra Mazumdar wrote:
> 
> On 6/28/19 12:01 PM, Parth Shah wrote:
>>
>> On 6/27/19 6:59 AM, subhra mazumdar wrote:
>>> Use SIS_CORE to disable idle core search. For some workloads
>>> select_idle_core becomes a scalability bottleneck, removing it improves
>>> throughput. Also there are workloads where disabling it can hurt latency,
>>> so need to have an option.
>>>
>>> Signed-off-by: subhra mazumdar <subhra.mazumdar@oracle.com>
>>> ---
>>>   kernel/sched/fair.c | 8 +++++---
>>>   1 file changed, 5 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>> index c1ca88e..6a74808 100644
>>> --- a/kernel/sched/fair.c
>>> +++ b/kernel/sched/fair.c
>>> @@ -6280,9 +6280,11 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
>>>       if (!sd)
>>>           return target;
>>>
>>> -    i = select_idle_core(p, sd, target);
>>> -    if ((unsigned)i < nr_cpumask_bits)
>>> -        return i;
>>> +    if (sched_feat(SIS_CORE)) {
>>> +        i = select_idle_core(p, sd, target);
>>> +        if ((unsigned)i < nr_cpumask_bits)
>>> +            return i;
>>> +    }
>> This can have significant performance loss if disabled. The select_idle_core spreads
>> workloads quickly across the cores, hence disabling this leaves much of the work to
>> be offloaded to load balancer to move task across the cores. Latency sensitive
>> and long running multi-threaded workload should see the regression under this conditions.
> Yes in case of SPARC SMT8 I did notice that (see cover letter). That's why
> it is a feature that is ON by default, but can be turned OFF for specific
> workloads on x86 SMT2 that can benefit from it.
>> Also, systems like POWER9 has sd_llc as a pair of core only. So it
>> won't benefit from the limits and hence also hiding your code in select_idle_cpu
>> behind static keys will be much preferred.
> If it doesn't hurt then I don't see the point.
> 

So these is the result from POWER9 system with your patches:
System configuration: 2 Socket, 44 cores, 176 CPUs

Experiment setup: 
===========
=> Setup 1:
- 44 tasks doing just while(1), this is to make select_idle_core return -1 most times
- perf bench sched messaging -g 1 -l 1000000
+-----------+--------+--------------+--------+
| Baseline  | stddev |    Patch     | stddev |
+-----------+--------+--------------+--------+
|       135 |   3.21 | 158(-17.03%) |   4.69 |
+-----------+--------+--------------+--------+

=> Setup 2:
- schbench -m44 -t 1
+=======+==========+=========+=========+==========+                                                                                                                                                                                                                             
| %ile  | Baseline | stddev  |  patch  |  stddev  |                                                                                                                                                                                                                             
+=======+==========+=========+=========+==========+                                                                                                                                                                                                                             
|    50 |       10 |    3.49 |      10 |     2.29 |                                                                                                                                                                                                                             
+-------+----------+---------+---------+----------+                                                                                                                                                                                                                             
|    95 |      467 |    4.47 |     469 |     0.81 |                                                                                                                                                                                                                             
+-------+----------+---------+---------+----------+                                                                                                                                                                                                                             
|    99 |      571 |   21.32 |     584 |    18.69 |                                                                                                                                                                                                                             
+-------+----------+---------+---------+----------+                                                                                                                                                                                                                             
|  99.5 |      629 |   30.05 |     641 |    20.95 |                                                                                                                                                                                                                             
+-------+----------+---------+---------+----------+                                                                                                                                                                                                                             
|  99.9 |      780 |   40.38 |     773 |     44.2 |                                                                                                                                                                                                                             
+-------+----------+---------+---------+----------+

I guess it doesn't make much difference in schbench results but hackbench (perf bench)
seems to have an observable regression.


Best,
Parth

