Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D23E8C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 12:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC73E208C3
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 12:22:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404669AbfIFMWt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 08:22:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:20786 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728509AbfIFMWs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 08:22:48 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x86CMCxG050599
        for <linux-kernel@vger.kernel.org>; Fri, 6 Sep 2019 08:22:48 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uupbg28g8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 08:22:47 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <parth@linux.ibm.com>;
        Fri, 6 Sep 2019 13:22:45 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 6 Sep 2019 13:22:41 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x86CMeJf46072004
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 6 Sep 2019 12:22:40 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BF9DEA405F;
        Fri,  6 Sep 2019 12:22:40 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id ADFAAA405B;
        Fri,  6 Sep 2019 12:22:38 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.35.156])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  6 Sep 2019 12:22:38 +0000 (GMT)
Subject: Re: [RFC PATCH 1/9] sched,cgroup: Add interface for latency-nice
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     Tim Chen <tim.c.chen@linux.intel.com>,
        subhra mazumdar <subhra.mazumdar@oracle.com>,
        linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, tglx@linutronix.de, steven.sistare@oracle.com,
        dhaval.giani@oracle.com, daniel.lezcano@linaro.org,
        vincent.guittot@linaro.org, viresh.kumar@linaro.org,
        mgorman@techsingularity.net
References: <20190830174944.21741-1-subhra.mazumdar@oracle.com>
 <20190830174944.21741-2-subhra.mazumdar@oracle.com>
 <11aaa3a8-e6b9-cf1f-08bb-0f8e1b63942b@linux.intel.com>
 <c09bf5fc-8fc6-dddd-0a18-bd7d5f2136b5@linux.ibm.com> <87o8zz2gu3.fsf@arm.com>
From:   Parth Shah <parth@linux.ibm.com>
Date:   Fri, 6 Sep 2019 17:52:37 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <87o8zz2gu3.fsf@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19090612-4275-0000-0000-00000361F50D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19090612-4276-0000-0000-0000387440A1
Message-Id: <c159f942-1c5b-6957-ca8f-ef9b0a64e26e@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-06_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909060130
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/5/19 3:41 PM, Patrick Bellasi wrote:
> 
> On Thu, Sep 05, 2019 at 07:15:34 +0100, Parth Shah wrote...
> 
>> On 9/4/19 11:02 PM, Tim Chen wrote:
>>> On 8/30/19 10:49 AM, subhra mazumdar wrote:
>>>> Add Cgroup interface for latency-nice. Each CPU Cgroup adds a new file
>>>> "latency-nice" which is shared by all the threads in that Cgroup.
>>>
>>>
>>> Subhra,
>>>
>>> Thanks for posting the patchset.  Having a latency nice hint
>>> is useful beyond idle load balancing.  I can think of other
>>> application scenarios, like scheduling batch machine learning AVX 512
>>> processes with latency sensitive processes.  AVX512 limits the frequency
>>> of the CPU and it is best to avoid latency sensitive task on the
>>> same core with AVX512.  So latency nice hint allows the scheduler
>>> to have a criteria to determine the latency sensitivity of a task
>>> and arrange latency sensitive tasks away from AVX512 tasks.
>>>
>>
>>
>> Hi Tim and Subhra,
>>
>> This patchset seems to be interesting for my TurboSched patches as well
>> where I try to pack jitter tasks on fewer cores to get higher Turbo Frequencies.
>> Well, the problem I face is that we sometime end up putting multiple jitter tasks on a core
>> running some latency sensitive application which may see performance degradation.
>> So my plan was to classify such tasks to be latency sensitive thereby hinting the load
>> balancer to not put tasks on such cores.
>>
>> TurboSched: https://lkml.org/lkml/2019/7/25/296
>>
>>> You configure the latency hint on a cgroup basis.
>>> But I think not all tasks in a cgroup necessarily have the same
>>> latency sensitivity.
>>>
>>> For example, I can see that cgroup can be applied on a per user basis,
>>> and the user could run different tasks that have different latency sensitivity.
>>> We may also need a way to configure latency sensitivity on a per task basis instead on
>>> a per cgroup basis.
>>>
>>
>> AFAIU, the problem defined above intersects with my patches as well where the interface
>> is required to classify the jitter tasks. I have already tried few methods like
>> syscall and cgroup to classify such tasks and maybe something like that can be adopted
>> with these patchset as well.
> 
> Agree, these two patchest are definitively overlapping in terms of
> mechanisms and APIs to expose to userspace. You to guys seems to target
> different goals but the general approach should be:
> 
>  - expose a single and abstract concept to user-space
>    latency-nice or latency-tolerant as PaulT proposed at OSPM
> 

I agree. Both the patchset tries to classify a tasks for some purpose for better latency.
TurboSched requires the classification of whether the task is jitter and should not be given
enough resources/frequency. This is a boolean value.
Whereas, latency-nice is a range. So does that mean that a max-latency-nice task is a jitter?

I was thinking of not doing jitter packing on a core occupying
min-latency-nice (i.e, latency sensitive) task (until there are other busier cores).

Given this, we can expose a single per-task attribute to the user by a syscall, right?

>  - map this concept in kernel-space to different kind of bias, both at
>    wakeup time and load-balance time, and use both for RT and CFS tasks.
> 
> That's my understanding at least ;)
> 
> I guess we will have interesting discussions at the upcoming LPC to
> figure out a solution fitting all needs.

Definitely.

> 
>> Thanks,
>> Parth
> 
> Best,
> Patrick
> 

