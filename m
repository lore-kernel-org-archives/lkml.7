Return-Path: <SRS0=54v9=YS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B99A3CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 12:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 87D9021D71
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Oct 2019 12:04:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502563AbfJYMEE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Oct 2019 08:04:04 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53086 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2436494AbfJYMED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Oct 2019 08:04:03 -0400
Received: from pps.filterd (m0127361.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9PC2SXJ016312
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 08:04:03 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vucdsjnuu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2019 08:02:56 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <parth@linux.ibm.com>;
        Fri, 25 Oct 2019 13:00:41 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 25 Oct 2019 13:00:38 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9PC0bFW17367244
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Oct 2019 12:00:37 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EABE7A4051;
        Fri, 25 Oct 2019 12:00:36 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5CBF8A4057;
        Fri, 25 Oct 2019 12:00:35 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.35.242])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 25 Oct 2019 12:00:35 +0000 (GMT)
Subject: Re: [PATCH] sched/fair: Make sched-idle cpu selection consistent
 throughout
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel@vger.kernel.org
References: <5eba2fb4af9ebc7396101bb9bd6c8aa9c8af0710.1571899508.git.viresh.kumar@linaro.org>
 <7d3a1549-a99c-ae42-6074-8ed2ecd7074f@linux.ibm.com>
 <20191025081108.6gaprbwm5fvokun6@vireshk-i7>
From:   Parth Shah <parth@linux.ibm.com>
Date:   Fri, 25 Oct 2019 17:30:34 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20191025081108.6gaprbwm5fvokun6@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19102512-4275-0000-0000-000003777F6C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19102512-4276-0000-0000-0000388AAD04
Message-Id: <3c8f52ac-4302-5152-2d57-2fe912e1ff9b@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-25_07:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910250114
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/25/19 1:41 PM, Viresh Kumar wrote:
> On 25-10-19, 12:13, Parth Shah wrote:
>> Hi Viresh,
>>
>> On 10/24/19 12:15 PM, Viresh Kumar wrote:
>>> There are instances where we keep searching for an idle CPU despite
>>> having a sched-idle cpu already (in find_idlest_group_cpu(),
>>> select_idle_smt() and select_idle_cpu() and then there are places where
>>> we don't necessarily do that and return a sched-idle cpu as soon as we
>>> find one (in select_idle_sibling()). This looks a bit inconsistent and
>>> it may be worth having the same policy everywhere.
>>>
>>> On the other hand, choosing a sched-idle cpu over a idle one shall be
>>> beneficial from performance point of view as well, as we don't need to
>>> get the cpu online from a deep idle state which is quite a time
>>> consuming process and delays the scheduling of the newly wakeup task.
>>>
>>> This patch tries to simplify code around sched-idle cpu selection and
>>> make it consistent throughout.
>>>
>>> FWIW, tests were done with the help of rt-app (8 SCHED_OTHER and 5
>>> SCHED_IDLE tasks, not bound to any cpu) on ARM platform (octa-core), and
>>> no significant difference in scheduling latency of SCHED_OTHER tasks was
>>> found.
>>>
>>> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
>>> ---
>>
>> [...]
>>
>>> @@ -5755,13 +5749,11 @@ static int select_idle_smt(struct task_struct *p, int target)
>>>  	for_each_cpu(cpu, cpu_smt_mask(target)) {
>>>  		if (!cpumask_test_cpu(cpu, p->cpus_ptr))
>>>  			continue;
>>> -		if (available_idle_cpu(cpu))
>>> +		if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
>>>  			return cpu;
>>
>> I guess this is a correct approach, but just wondering what if we still
>> keep searching for a sched_idle CPU even though we have found an
>> available_idle CPU?
> 
> I do believe selecting a sched-idle CPU should almost always be better
> (performance wise), unless we have a strong argument against it. And
> anyway, the load balancer will get triggered at a later point of time
> and will pull away these newly wakeup tasks to idle CPUs. The
> advantage we get out of it is that the tasks get serviced a bit
> earlier when they first get queued.
> 
> It is really up to the maintainers to see what kind of policy do we
> want to adapt here and not a choice I can make :)
> 

yeah, I agree. I will favor selecting sched-idle first for smaller domains
like SMT but would leave on experts.
BTW, if sched-idle is given priority then maybe...
> @@ -5818,13 +5810,11 @@ static int select_idle_cpu(struct task_struct *p,
> struct sched_domain *sd, int t
>
>  	for_each_cpu_wrap(cpu, sched_domain_span(sd), target) {
>  		if (!--nr)
> -			return si_cpu;
> +			return -1;
>  		if (!cpumask_test_cpu(cpu, p->cpus_ptr))
>  			continue;
> -		if (available_idle_cpu(cpu))
> +		if (available_idle_cpu(cpu) || sched_idle_cpu(cpu))
>  			break;
...here too can be optimized I guess.


Thanks,
Parth

