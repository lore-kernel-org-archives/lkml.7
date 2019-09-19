Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A19DFC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 16:42:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 760DC20882
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 16:42:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732762AbfISQl7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 12:41:59 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:15932 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732225AbfISQl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 12:41:59 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8JGerYx075415
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 12:41:58 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2v4ch3tcm5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 12:41:57 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <parth@linux.ibm.com>;
        Thu, 19 Sep 2019 17:41:55 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 19 Sep 2019 17:41:50 +0100
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8JGfnjY49414152
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Sep 2019 16:41:49 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 81E1A42049;
        Thu, 19 Sep 2019 16:41:49 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D25924203F;
        Thu, 19 Sep 2019 16:41:41 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.70.125])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 19 Sep 2019 16:41:41 +0000 (GMT)
Subject: Re: Usecases for the per-task latency-nice attribute
To:     Valentin Schneider <valentin.schneider@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        subhra mazumdar <subhra.mazumdar@oracle.com>,
        tim.c.chen@linux.intel.com, mingo@redhat.com,
        morten.rasmussen@arm.com, dietmar.eggemann@arm.com, pjt@google.com,
        vincent.guittot@linaro.org, quentin.perret@arm.com,
        dhaval.giani@oracle.com, daniel.lezcano@linaro.org, tj@kernel.org,
        rafael.j.wysocki@intel.com, qais.yousef@arm.com,
        Patrick Bellasi <patrick.bellasi@matbug.net>
References: <3e5c3f36-b806-5bcc-e666-14dc759a2d7b@linux.ibm.com>
 <87woe51ydd.fsf@arm.com> <77457d5b-185e-1548-4a5c-9b911b036cec@arm.com>
From:   Parth Shah <parth@linux.ibm.com>
Date:   Thu, 19 Sep 2019 22:11:40 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <77457d5b-185e-1548-4a5c-9b911b036cec@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19091916-0016-0000-0000-000002AE2BA1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19091916-0017-0000-0000-0000330EDC6B
Message-Id: <dc0712e4-f66f-a92b-fbf9-a3a84cf982a6@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-19_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909190147
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/18/19 9:12 PM, Valentin Schneider wrote:
> On 18/09/2019 15:18, Patrick Bellasi wrote:
>>> 1. Name: What should be the name for such attr for all the possible usecases?
>>> =============
>>> Latency nice is the proposed name as of now where the lower value indicates
>>> that the task doesn't care much for the latency
>>
>> If by "lower value" you mean -19 (in the proposed [-20,19] range), then
>> I think the meaning should be the opposite.
>>
>> A -19 latency-nice task is a task which is not willing to give up
>> latency. For those tasks for example we want to reduce the wake-up
>> latency at maximum.
>>
>> This will keep its semantic aligned to that of process niceness values
>> which range from -20 (most favourable to the process) to 19 (least
>> favourable to the process).
>>
> 
> I don't want to start a bikeshedding session here, but I agree with Parth
> on the interpretation of the values.
> 
> I've always read niceness values as
> -20 (least nice to the system / other processes)
> +19 (most nice to the system / other processes)
> 
> So following this trend I'd see for latency-nice:


So jotting down separately, in case if we think to have "latency-nice"
terminology, then we might need to select one of the 2 interpretation:

1).
> -20 (least nice to latency, i.e. sacrifice latency for throughput)
> +19 (most nice to latency, i.e. sacrifice throughput for latency)
> 

2).
-20 (least nice to other task in terms of sacrificing latency, i.e.
latency-sensitive)
+19 (most nice to other tasks in terms of sacrificing latency, i.e.
latency-forgoing)


> However...
> 
>>> But there seems to be a bit of confusion on whether we want biasing as well
>>> (latency-biased) or something similar, in which case "latency-nice" may
>>> confuse the end-user.
>>
>> AFAIU PeterZ point was "just" that if we call it "-nice" it has to
>> behave as "nice values" to avoid confusions to users. But, if we come up
>> with a different naming maybe we will have more freedom.
>>
> 
> ...just getting rid of the "-nice" would leave us free not to have to
> interpret the values as "nice to / not nice to" :)
> 
>> Personally, I like both "latency-nice" or "latency-tolerant", where:
>>
>>  - latency-nice:
>>    should have a better understanding based on pre-existing concepts
>>
>>  - latency-tolerant:
>>    decouples a bit its meaning from the niceness thus giving maybe a bit
>>    more freedom in its complete definition and perhaps avoid any
>>    possible interpretation confusion like the one I commented above.
>>
>> Fun fact: there was also the latency-nasty proposal from PaulMK :)
>>
> 
> [...]
> 
>>
>> $> Wakeup path tunings
>> ==========================
>>
>> Some additional possible use-cases was already discussed in [3]:
>>
>>  - dynamically tune the policy of a task among SCHED_{OTHER,BATCH,IDLE}
>>    depending on crossing certain pre-configured threshold of latency
>>    niceness.
>>   
>>  - dynamically bias the vruntime updates we do in place_entity()
>>    depending on the actual latency niceness of a task.
>>   
>>    PeterZ thinks this is dangerous but that we can "(carefully) fumble a
>>    bit there."
>>   
>>  - bias the decisions we take in check_preempt_tick() still depending
>>    on a relative comparison of the current and wakeup task latency
>>    niceness values.
> 
> Aren't we missing the point about tweaking the sched domain scans (which
> AFAIR was the original point for latency-nice)?
> 
> Something like default value is current behaviour and
> - Being less latency-sensitive means increasing the scans (e.g. trending
>   towards only going through the slow wakeup-path at the extreme setting)
> - Being more latency-sensitive means reducing the scans (e.g. trending
>   towards a fraction of the domain scanned in the fast-path at the extreme
>   setting).
> 

Correct. But I was pondering upon the values required for this case.
Is having just a range from [-20,19] even for larger system sufficient enough?

>>
> 
> $> Load balance tuning
> ======================
> 
> Already mentioned these in [4]:
> 
> - Increase (reduce) nr_balance_failed threshold when trying to active
>   balance a latency-sensitive (non-latency-sensitive) task.
> 
> - Increase (decrease) sched_migration_cost factor in task_hot() for
>   latency-sensitive (non-latency-sensitive) tasks.
> 

Thanks for listing down your ideas.

These are pretty useful optimization in general. But one may wonder if we
reduce the search scans for idle-core in wake-up path and by-chance selects
the busy core, then one would expect load balancer to move the task to idle
core.

If I got it correct, the in such cases, the sched_migration_cost should be
carefully increased, right?


>>> References:
>>> ===========
>>> [1]. https://lkml.org/lkml/2019/8/30/829
>>> [2]. https://lkml.org/lkml/2019/7/25/296
>>
>>   [3]. Message-ID: <20190905114709.GM2349@hirez.programming.kicks-ass.net>
>>        https://lore.kernel.org/lkml/20190905114709.GM2349@hirez.programming.kicks-ass.net/
>>
> 
> [4]: https://lkml.kernel.org/r/3d3306e4-3a78-5322-df69-7665cf01cc43@arm.com
> 
>>
>> Best,
>> Patrick
>>

Thanks,
Parth

