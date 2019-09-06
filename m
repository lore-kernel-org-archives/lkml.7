Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1407CC00307
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 17:10:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E321E20578
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 17:10:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395103AbfIFRKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 13:10:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37790 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733096AbfIFRKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 13:10:22 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x86H7DMK074642
        for <linux-kernel@vger.kernel.org>; Fri, 6 Sep 2019 13:10:21 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uusdmdy48-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 13:10:20 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <parth@linux.ibm.com>;
        Fri, 6 Sep 2019 18:10:18 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 6 Sep 2019 18:10:13 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x86HACop42008614
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 6 Sep 2019 17:10:12 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7642811C04A;
        Fri,  6 Sep 2019 17:10:12 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6F88311C064;
        Fri,  6 Sep 2019 17:10:08 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.102.0.23])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  6 Sep 2019 17:10:08 +0000 (GMT)
Subject: Re: [RFC PATCH 1/9] sched,cgroup: Add interface for latency-nice
To:     Valentin Schneider <valentin.schneider@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
        steven.sistare@oracle.com, dhaval.giani@oracle.com,
        daniel.lezcano@linaro.org, vincent.guittot@linaro.org,
        viresh.kumar@linaro.org, tim.c.chen@linux.intel.com,
        mgorman@techsingularity.net
References: <20190830174944.21741-1-subhra.mazumdar@oracle.com>
 <20190830174944.21741-2-subhra.mazumdar@oracle.com>
 <20190905083127.GA2332@hirez.programming.kicks-ass.net>
 <87r24v2i14.fsf@arm.com>
 <20190905104616.GD2332@hirez.programming.kicks-ass.net>
 <87imq72dpc.fsf@arm.com> <df69627e-8aa0-e2cb-044e-fb392f34efa5@arm.com>
 <87d0ge3n85.fsf@arm.com> <3bb17e15-5492-b78c-20a8-5989519f20e2@linux.ibm.com>
 <75e782c7-121d-a0ea-7fbf-efb0c83f50e6@arm.com>
From:   Parth Shah <parth@linux.ibm.com>
Date:   Fri, 6 Sep 2019 22:40:07 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <75e782c7-121d-a0ea-7fbf-efb0c83f50e6@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19090617-0008-0000-0000-00000311F001
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19090617-0009-0000-0000-00004A304E1F
Message-Id: <f4d28328-973c-4b94-334d-a68c958f6cc4@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-06_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909060182
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/6/19 7:43 PM, Valentin Schneider wrote:
> On 06/09/2019 13:45, Parth Shah wrote:> 
>> I guess there is some usecase in case of thermal throttling.
>> If a task is heating up the core then in ideal scenarios POWER systems throttle
>> down to rated frequency.
>> In such case, if the task is latency sensitive (min latency nice), we can move the
>> task around the chip to heat up the chip uniformly allowing me to gain more performance
>> with sustained higher frequency.
>> With this, we will require the help from active load balancer and latency-nice
>> classification on per task and/or group basis.
>>
>> Hopefully, this might be useful for other arch as well, right?
>>
> 
> Most of the functionality is already there, we're only really missing thermal
> pressure awareness. There was [1] but it seems to have died.
> 
> 
> At least with CFS load balancing, if thermal throttling is correctly
> reflected as a CPU capacity reduction you will tend to move things away from
> that CPU, since load is balanced over capacities.
> 

Right, CPU capacity can solve the problem of indicating the thermal throttle to the scheduler.
AFAIU, the patchset from Thara changes CPU capacity to reflect Thermal headroom of the CPU.
This is a nice mitigation but,
1. Sometimes a single task is responsible for the Thermal heatup of the core, reducing the
   CPU capacity of all the CPUs in the core is not optimal when just moving such single
   task to other core can allow us to remain within thermal headroom. This is important
   for the servers especially where there are upto 8 threads.
2. Given the implementation in the patches and its integration with EAS, it seems difficult
   to adapt to servers, where CPU capacity itself is in doubt.
   https://lkml.org/lkml/2019/5/15/1402

> 
> For active balance, we actually already have a condition that moves a task
> to a less capacity-pressured CPU (although it is somewhat specific). So if
> thermal pressure follows that task (e.g. it's doing tons of vector/float),
> it will be rotated around.

Agree. But this should break in certain conditions like when we have multiple tasks
in a core with almost equal utilization among which one is just doing vector operations.
LB can pick and move any task with equal probability if the capacity is reduced here.

> 
> However there should be a point made on latency vs throughput. If you
> care about latency you probably do not want to active balance your task. If

Can you please elaborate on why not to consider active balance for latency sensitive tasks?
Because, sometimes finding a thermally cool core is beneficial when Turbo frequency
range is around 20% above rated ones.

> you care about throughput, it should be specified in some way (util-clamp
> says hello!).
> 

yes I do care for latency and throughput both. :-)
but I'm wondering how uclamp can solve the problem for throughput.
If I make the thermally hot tasks to appear bigger than other tasks then reducing
CPU capacity can allow such tasks to move around the chip.
But this will require the utilization value to be relatively large compared to the other
tasks in the core. Or other task's uclamp.max can be lowered to make such task rotate.
If I got it right, then this will be a difficult UCLAMP usecase from user perspective, right?
I feel like I'm missing something here.

> It sort of feels like you'd want an extension of misfit migration (salesman
> hat goes on from here) - misfit moves tasks that are CPU bound (IOW their
> util is >= 80% of the CPU capacity) to CPUs of higher capacity. It's only
> enabled for systems with asymmetric capacities, but could be enabled globally
> for "dynamically-created asymmetric capacities" (IOW RT/IRQ/thermal pressure
> on SMP systems).> On top of that, if we make misfit consider e.g. uclamp.min (I don't think
> that's already the case), then you have your throughput knob to have *some* 
> designated tasks move away from (thermal & else) pressure. 
> 
> 
> [1]: https://lore.kernel.org/lkml/1555443521-579-1-git-send-email-thara.gopinath@linaro.org/
> 

Thanks,
Parth

