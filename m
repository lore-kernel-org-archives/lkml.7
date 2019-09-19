Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D68C49ED7
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 07:02:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF4E721907
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 07:02:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731914AbfISHCX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 03:02:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46142 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731882AbfISHCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 03:02:23 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8J6vZcR078666
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 03:02:21 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2v44b5s5qw-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 03:02:21 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <parth@linux.ibm.com>;
        Thu, 19 Sep 2019 08:02:19 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 19 Sep 2019 08:02:14 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8J72D5t57737276
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Sep 2019 07:02:13 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 64EB6AE05F;
        Thu, 19 Sep 2019 07:02:13 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 15BF6AE057;
        Thu, 19 Sep 2019 07:02:08 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.95.39])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 19 Sep 2019 07:02:07 +0000 (GMT)
Subject: Re: Usecases for the per-task latency-nice attribute
To:     Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        subhra mazumdar <subhra.mazumdar@oracle.com>,
        tim.c.chen@linux.intel.com,
        Valentin Schneider <valentin.schneider@arm.com>,
        mingo@redhat.com, morten.rasmussen@arm.com,
        dietmar.eggemann@arm.com, pjt@google.com,
        vincent.guittot@linaro.org, quentin.perret@arm.com,
        dhaval.giani@oracle.com, daniel.lezcano@linaro.org, tj@kernel.org,
        rafael.j.wysocki@intel.com, qais.yousef@arm.com,
        Patrick Bellasi <patrick.bellasi@matbug.net>
References: <3e5c3f36-b806-5bcc-e666-14dc759a2d7b@linux.ibm.com>
 <87woe51ydd.fsf@arm.com>
From:   Parth Shah <parth@linux.ibm.com>
Date:   Thu, 19 Sep 2019 12:31:57 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <87woe51ydd.fsf@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19091907-0016-0000-0000-000002ADF118
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19091907-0017-0000-0000-0000330E9E81
Message-Id: <e39eccde-434a-dbc8-e093-554ce2cbfdc6@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-19_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909190065
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/18/19 7:48 PM, Patrick Bellasi wrote:
> 
> On Wed, Sep 18, 2019 at 13:41:04 +0100, Parth Shah wrote...
> 
>> Hello everyone,
> 
> Hi Parth,
> thanks for staring this discussion.
> 
> [ + patrick.bellasi@matbug.net ] my new email address, since with
> @arm.com I will not be reachable anymore starting next week.
> 

Noted. I will send new version with the summary of all the discussion and
add more people to CC. Will change your mail in that, thanks for notifying me.

>> As per the discussion in LPC2019, new per-task property like latency-nice
>> can be useful in certain scenarios. The scheduler can take proper decision
>> by knowing latency requirement of a task from the end-user itself.
>>
>> There has already been an effort from Subhra for introducing Task
>> latency-nice [1] values and have seen several possibilities where this type of
>> interface can be used.
>>
>> From the best of my understanding of the discussion on the mail thread and
>> in the LPC2019, it seems that there are two dilemmas;
>>
>> 1. Name: What should be the name for such attr for all the possible usecases?
>> =============
>> Latency nice is the proposed name as of now where the lower value indicates
>> that the task doesn't care much for the latency
> 
> If by "lower value" you mean -19 (in the proposed [-20,19] range), then
> I think the meaning should be the opposite.
> 

Oops, my bad. i wanted to tell higher value but somehow missed that
latency-nice should be the opposite to the latency sensitivity.

But in the further scope of the discussion, I mean -19 to be the least
value (latency sensitive) and +20 to be the greatest value(does not care
for latency) if range is [-19,20]

> A -19 latency-nice task is a task which is not willing to give up
> latency. For those tasks for example we want to reduce the wake-up
> latency at maximum.
> 
> This will keep its semantic aligned to that of process niceness values
> which range from -20 (most favourable to the process) to 19 (least
> favourable to the process).

Totally agreed upon.

> 
>> and we can spend some more time in the kernel to decide a better
>> placement of a task (to save time, energy, etc.)
> 
> Tasks with an high latency-nice value (e.g. 19) are "less sensible to
> latency". These are tasks we wanna optimize mainly for throughput and
> thus, for example, we can spend some more time to find out a better task
> placement at wakeup time.
> 
> Does that makes sense?

Correct. Task placement is one way to optimize which can benefit to both
the server and embedded world by saving power without compromising much on
performance.

> 
>> But there seems to be a bit of confusion on whether we want biasing as well
>> (latency-biased) or something similar, in which case "latency-nice" may
>> confuse the end-user.
> 
> AFAIU PeterZ point was "just" that if we call it "-nice" it has to
> behave as "nice values" to avoid confusions to users. But, if we come up
> with a different naming maybe we will have more freedom.
> 
> Personally, I like both "latency-nice" or "latency-tolerant", where:
> 
>  - latency-nice:
>    should have a better understanding based on pre-existing concepts
> 
>  - latency-tolerant:
>    decouples a bit its meaning from the niceness thus giving maybe a bit
>    more freedom in its complete definition and perhaps avoid any
>    possible interpretation confusion like the one I commented above.
> 
> Fun fact: there was also the latency-nasty proposal from PaulMK :)
> 

Cool. In that sense, latency-tolerant seems to be more flexible covering
multiple functionality that a scheduler can provide with such userspace hints.


>> 2. Value: What should be the range of possible values supported by this new
>> attr?
>> ==============
>> The possible values of such task attribute still need community attention.
>> Do we need a range of values or just binary/ternary values are sufficient?
>> Also signed or unsigned and so the length of the variable (u64, s32,
>> etc)?
> 
> AFAIR, the proposal on the table are essentially two:
> 
>  A) use a [-20,19] range
> 
>     Which has similarities with the niceness concept and gives a minimal
>     continuous range. This can be on hand for things like scaling the
>     vruntime normalization [3]
> 
>  B) use some sort of "profile tagging"
>     e.g. background, latency-sensible, etc...
>     
>     If I correctly got what PaulT was proposing toward the end of the
>     discussion at LPC.
> 

If I got it right, then for option B, we can have this attr to be used as a
latency_flag just like per-process flags (e.g. PF_IDLE). If so, then we can
piggyback on the p->flags itself, hence I will prefer the range unless we
have multiple usecases which can not get best out of the range.

> This last option deserves better exploration.
> 
> At first glance I'm more for option A, I see a range as something that:
> 
>   - gives us a bit of flexibility in terms of the possible internal
>     usages of the actual value
> 
>   - better supports some kind of linear/proportional mapping
> 
>   - still supports a "profile tagging" by (possible) exposing to
>     user-space some kind of system wide knobs defining threshold that
>     maps the continuous value into a "profile"
>     e.g. latency-nice >= 15: use SCHED_BATCH
> 

+1, good listing to support range for latency-<whatever>

>     In the following discussion I'll call "threshold based profiling"
>     this approach.
> 
> 
>> This mail is to initiate the discussion regarding the possible usecases of
>> such per task attribute and to come up with a specific name and value for
>> the same.
>>
>> Hopefully, interested one should plot out their usecase for which this new
>> attr can potentially help in solving or optimizing it.
> 
> +1
> 
>> Well, to start with, here is my usecase.
>>
>> -------------------
>> **Usecases**
>> -------------------
>>
>> $> TurboSched
>> ====================
>> TurboSched [2] tries to minimize the number of active cores in a socket by
>> packing an un-important and low-utilization (named jitter) task on an
>              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> We should really come up with a different name, since jitters clashes
> with other RT related concepts.
> 

I agree, based on LPC discussion and comments from tglx, I am happy to
rename it to whatever feels functionally correct and non-confusing to end-user.

> Maybe we don't even need a name at all, the other two attributes you
> specify are good enough to identify those tasks: they are just "small
> background" tasks.
> 
>   small      : because on their small util_est value
>   background : because of their high latency-nice value
> 

Correct. If we have latency-nice hints + utilization then we can classify
those tasks for task packing.

>> already active core and thus refrains from waking up of a new core if
>> possible. This requires tagging of tasks from the userspace hinting which
>> tasks are un-important and thus waking-up a new core to minimize the
>> latency is un-necessary for such tasks.
>> As per the discussion on the posted RFC, it will be appropriate to use the
>> task latency property where a task with the highest latency-nice value can
>> be packed.
> 
> We should better defined here what you mean with "highest" latency-nice
> value, do you really mean the top of the range, e.g. 19?
> 

yes, I mean +19 (or +20 whichever is higher) here which does not care for
latency.

> Or...
> 
>> But for this specific use-cases, having just a binary value to know which
>> task is latency-sensitive and which not is sufficient enough, but having a
>> range is also a good way to go where above some threshold the task can be
>> packed.
> 
> ... yes, maybe we can reason about a "threshold based profiling" where
> something like for example:
> 
>    /proc/sys/kernel/sched_packing_util_max    : 200
>    /proc/sys/kernel/sched_packing_latency_min : 17
> 
> means that a task with latency-nice >= 17 and util_est <= 200 will be packed?
> 

yes, something like that.

> 
> $> Wakeup path tunings
> ==========================
> 
> Some additional possible use-cases was already discussed in [3]:
> 
>  1. dynamically tune the policy of a task among SCHED_{OTHER,BATCH,IDLE}
>    depending on crossing certain pre-configured threshold of latency
>    niceness.
>   
>  2. dynamically bias the vruntime updates we do in place_entity()
>    depending on the actual latency niceness of a task.
>   
>    PeterZ thinks this is dangerous but that we can "(carefully) fumble a
>    bit there."
>   
>  3. bias the decisions we take in check_preempt_tick() still depending
>    on a relative comparison of the current and wakeup task latency
>    niceness values.
> 

Nice. Thanks for listing out the usecases.

I guess latency_flags will be difficult to use for usecase 2 and 3, but
range will work for all the three usecases.

>> References:
>> ===========
>> [1]. https://lkml.org/lkml/2019/8/30/829
>> [2]. https://lkml.org/lkml/2019/7/25/296
> 
>   [3]. Message-ID: <20190905114709.GM2349@hirez.programming.kicks-ass.net>
>        https://lore.kernel.org/lkml/20190905114709.GM2349@hirez.programming.kicks-ass.net/
> 
> 
> Best,
> Patrick
> 

Thanks,
Parth

