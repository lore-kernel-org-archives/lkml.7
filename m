Return-Path: <SRS0=GGWy=XB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5FADC43331
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 12:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB8FC20854
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Sep 2019 12:31:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404684AbfIFMba (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Sep 2019 08:31:30 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34542 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731811AbfIFMba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 08:31:30 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x86CSlUr066000
        for <linux-kernel@vger.kernel.org>; Fri, 6 Sep 2019 08:31:29 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2uupbg2j0x-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 06 Sep 2019 08:31:29 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <parth@linux.ibm.com>;
        Fri, 6 Sep 2019 13:31:27 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 6 Sep 2019 13:31:23 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x86CVMRw46924002
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 6 Sep 2019 12:31:22 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 88B1EA4064;
        Fri,  6 Sep 2019 12:31:22 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 98E38A405C;
        Fri,  6 Sep 2019 12:31:20 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.35.156])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  6 Sep 2019 12:31:20 +0000 (GMT)
Subject: Re: [RFC PATCH 1/9] sched,cgroup: Add interface for latency-nice
To:     Patrick Bellasi <patrick.bellasi@arm.com>,
        Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
        steven.sistare@oracle.com, dhaval.giani@oracle.com,
        daniel.lezcano@linaro.org, vincent.guittot@linaro.org,
        viresh.kumar@linaro.org, tim.c.chen@linux.intel.com,
        mgorman@techsingularity.net
References: <20190830174944.21741-1-subhra.mazumdar@oracle.com>
 <20190830174944.21741-2-subhra.mazumdar@oracle.com>
 <20190905083127.GA2332@hirez.programming.kicks-ass.net>
 <87r24v2i14.fsf@arm.com>
From:   Parth Shah <parth@linux.ibm.com>
Date:   Fri, 6 Sep 2019 18:01:19 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <87r24v2i14.fsf@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19090612-0012-0000-0000-000003478165
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19090612-0013-0000-0000-00002181DB65
Message-Id: <242c8410-616c-51b2-7aad-4d92ac3a149f@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-06_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909060131
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/5/19 3:15 PM, Patrick Bellasi wrote:
> 
> On Thu, Sep 05, 2019 at 09:31:27 +0100, Peter Zijlstra wrote...
> 
>> On Fri, Aug 30, 2019 at 10:49:36AM -0700, subhra mazumdar wrote:
>>> Add Cgroup interface for latency-nice. Each CPU Cgroup adds a new file
>>> "latency-nice" which is shared by all the threads in that Cgroup.
>>
>> *sigh*, no. We start with a normal per task attribute, and then later,
>> if it is needed and makes sense, we add it to cgroups.
> 
> FWIW, to add on top of what Peter says, we used this same approach for
> uclamp and it proved to be a very effective way to come up with a good
> design. General principles have been:
> 
>  - a system wide API [1] (under /proc/sys/kernel/sched_*) defines
>    default values for all tasks affected by that feature.
>    This interface has to define also upper bounds for task specific
>    values. Thus, in the case of latency-nice, it should be set by
>    default to the MIN value, since that's the current mainline
>    behaviour: all tasks are latency sensitive.
> 
>  - a per-task API [2] (via the sched_setattr() syscall) can be used to
>    relax the system wide setting thus implementing a "nice" policy.
> 
>  - a per-taskgroup API [3] (via cpu controller's attributes) can be used
>    to relax the system-wide settings and restrict the per-task API.
> 
> The above features are worth to be added in that exact order.
> 
>> Also, your Changelog fails on pretty much every point. It doesn't
>> explain why, it doesn't describe anything and so on.
> 
> On the description side, I guess it's worth to mention somewhere to
> which scheduling classes this feature can be useful for. It's worth to
> mention that it can apply only to:
> 
>  - CFS tasks: for example, at wakeup time a task with an high
>    latency-nice should avoid to preempt a low latency-nice task.
>    Maybe by mapping the latency nice value into proper vruntime
>    normalization value?
> 

If I got this correct, does this also mean that a task's latency-nice
will be mapped to prio/nice.
i.e, task with min-latency-nice will have highest priority?

>  - RT tasks: for example, at wakeup time a task with an high
>    latency-nice value could avoid to preempt a CFS task.
> 

So, will this make CFS task to precede RT task?
and cause priority inversion?

> I'm sure there will be discussion about some of these features, that's
> why it's important in the proposal presentation to keep a well defined
> distinction among the "mechanisms and API" and how we use the new
> concept to "bias" some scheduler policies.
> 
>> From just reading the above, I would expect it to have the range
>> [-20,19] just like normal nice. Apparently this is not so.
> 
> Regarding the range for the latency-nice values, I guess we have two
> options:
> 
>   - [-20..19], which makes it similar to priorities
>   downside: we quite likely end up with a kernel space representation
>   which does not match the user-space one, e.g. look at
>   task_struct::prio.
> 
>   - [0..1024], which makes it more similar to a "percentage"
> 
> Being latency-nice a new concept, we are not constrained by POSIX and
> IMHO the [0..1024] scale is a better fit.
> 
> That will translate into:
> 
>   latency-nice=0 : default (current mainline) behaviour, all "biasing"
>   policies are disabled and we wakeup up as fast as possible
> 
>   latency-nice=1024 : maximum niceness, where for example we can imaging
>   to turn switch a CFS task to be SCHED_IDLE?
> 
> Best,
> Patrick
> 
> [1] commit e8f14172c6b1 ("sched/uclamp: Add system default clamps")
> [2] commit a509a7cd7974 ("sched/uclamp: Extend sched_setattr() to support utilization clamping")
> [3] 5 patches in today's tip/sched/core up to:
>     commit babbe170e053 ("sched/uclamp: Update CPU's refcount on TG's clamp changes")
> 

