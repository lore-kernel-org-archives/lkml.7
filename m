Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10126C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 12:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D900E20854
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 12:45:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404437AbfIFMpk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 08:45:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56002 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2392676AbfIFMpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 08:45:40 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x86CiZn9041123
        for <linux-kernel@vger.kernel.org>; Fri, 6 Sep 2019 08:45:38 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uumu16hk8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 08:45:38 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <parth@linux.ibm.com>;
        Fri, 6 Sep 2019 13:45:36 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 6 Sep 2019 13:45:32 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x86CjVAI49807552
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 6 Sep 2019 12:45:31 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 20EABA4064;
        Fri,  6 Sep 2019 12:45:31 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EEEAFA4054;
        Fri,  6 Sep 2019 12:45:28 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.35.156])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  6 Sep 2019 12:45:28 +0000 (GMT)
Subject: Re: [RFC PATCH 1/9] sched,cgroup: Add interface for latency-nice
To:     Patrick Bellasi <patrick.bellasi@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>
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
 <87d0ge3n85.fsf@arm.com>
From:   Parth Shah <parth@linux.ibm.com>
Date:   Fri, 6 Sep 2019 18:15:28 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <87d0ge3n85.fsf@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19090612-0020-0000-0000-0000036885B8
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19090612-0021-0000-0000-000021BDFEE6
Message-Id: <3bb17e15-5492-b78c-20a8-5989519f20e2@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-06_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909060134
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/5/19 6:37 PM, Patrick Bellasi wrote:
> 
> On Thu, Sep 05, 2019 at 12:46:37 +0100, Valentin Schneider wrote...
> 
>> On 05/09/2019 12:18, Patrick Bellasi wrote:
>>>> There's a few things wrong there; I really feel that if we call it nice,
>>>> it should be like nice. Otherwise we should call it latency-bias and not
>>>> have the association with nice to confuse people.
>>>>
>>>> Secondly; the default should be in the middle of the range. Naturally
>>>> this would be a signed range like nice [-(x+1),x] for some x. but if you
>>>> want [0,1024], then the default really should be 512, but personally I
>>>> like 0 better as a default, in which case we need negative numbers.
>>>>
>>>> This is important because we want to be able to bias towards less
>>>> importance to (tail) latency as well as more importantance to (tail)
>>>> latency.
>>>>
>>>> Specifically, Oracle wants to sacrifice (some) latency for throughput.
>>>> Facebook OTOH seems to want to sacrifice (some) throughput for latency.
>>>
>>> Right, we have this dualism to deal with and current mainline behaviour
>>> is somehow in the middle.
>>>
>>> BTW, the FB requirement is the same we have in Android.
>>> We want some CFS tasks to have very small latency and a low chance
>>> to be preempted by the wake-up of less-important "background" tasks.
>>>
>>> I'm not totally against the usage of a signed range, but I'm thinking
>>> that since we are introducing a new (non POSIX) concept we can get the
>>> chance to make it more human friendly.
>>>
>>> Give the two extremes above, would not be much simpler and intuitive to
>>> have 0 implementing the FB/Android (no latency) case and 1024 the
>>> (max latency) Oracle case?
>>>
>>
>> For something like latency-<whatever>, I don't see the point of having
>> such a wide range. The nice range is probably more than enough - and before
>> even bothering about the range, we should probably agree on what the range
>> should represent.
>>
>> If it's niceness, I read it as: positive latency-nice value means we're
>> nice to latency, means we reduce it. So the further up you go, the more you
>> restrict your wakeup scan. I think it's quite easy to map that into the
>> code: current behaviour at 0, with a decreasing scan mask size as we go
>> towards +19. I don't think anyone needs 512 steps to tune this.
>>
>> I don't know what logic we'd follow for negative values though. Maybe
>> latency-nice -20 means always going through the slowpath, but what of the
>> intermediate values?
> 
> Yep, I think so fare we are all converging towards the idea to use the
> a signed range. Regarding the range itself, yes: 1024 looks very
> oversized, but +-20 is still something which leave room for a bit of
> flexibility and it also better matches the idea that we don't want to
> "enumerate behaviours" but just expose a knob. To map certain "bias" we
> could benefit from a slightly larger range.
> 
>> AFAICT this RFC only looks at wakeups, but I guess latency-nice can be
> 
> For the wakeup path there is also the TurboSched proposal by Parth:
> 
>    Message-ID: <20190725070857.6639-1-parth@linux.ibm.com> 
>    https://lore.kernel.org/lkml/20190725070857.6639-1-parth@linux.ibm.com/
> 
> we should keep in mind.
> 
>> applied elsewhere (e.g. load-balance, something like task_hot() and its
>> use of sysctl_sched_migration_cost).
> 
> For LB can you come up with some better description of what usages you
> see could benefit from a "per task" or "per task-group" latency niceness?
> 

I guess there is some usecase in case of thermal throttling.
If a task is heating up the core then in ideal scenarios POWER systems throttle
down to rated frequency.
In such case, if the task is latency sensitive (min latency nice), we can move the
task around the chip to heat up the chip uniformly allowing me to gain more performance
with sustained higher frequency.
With this, we will require the help from active load balancer and latency-nice
classification on per task and/or group basis.

Hopefully, this might be useful for other arch as well, right?

> Best,
> Patrick
> 

Thanks,
Parth

