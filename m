Return-Path: <SRS0=IBEs=VB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DE5DC06513
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 11:36:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40566218A3
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jul 2019 11:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727609AbfGDLgL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jul 2019 07:36:11 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:34136 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727548AbfGDLgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jul 2019 07:36:11 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x64BRWBs094304
        for <linux-kernel@vger.kernel.org>; Thu, 4 Jul 2019 07:36:10 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2thfss2b9m-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2019 07:36:10 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <parth@linux.ibm.com>;
        Thu, 4 Jul 2019 12:36:07 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 4 Jul 2019 12:36:03 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x64Ba2KX48955544
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 4 Jul 2019 11:36:02 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B6595AE051;
        Thu,  4 Jul 2019 11:36:02 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A835BAE04D;
        Thu,  4 Jul 2019 11:35:56 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.61.157])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  4 Jul 2019 11:35:56 +0000 (GMT)
Subject: Re: [RESEND PATCH v3 0/7] Improve scheduler scalability for fast path
To:     Subhra Mazumdar <subhra.mazumdar@oracle.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
        steven.sistare@oracle.com, dhaval.giani@oracle.com,
        daniel.lezcano@linaro.org, vincent.guittot@linaro.org,
        viresh.kumar@linaro.org, tim.c.chen@linux.intel.com,
        mgorman@techsingularity.net, Paul Turner <pjt@google.com>,
        riel@surriel.com, morten.rasmussen@arm.com
References: <20190627012919.4341-1-subhra.mazumdar@oracle.com>
 <20190701090204.GQ3402@hirez.programming.kicks-ass.net>
 <20190701135552.kb4os6bxxhh2lyw6@e110439-lin>
 <81b2288a-579d-8dd1-f179-d672cf1edd68@oracle.com>
 <20190702085437.gzu7ilubbi5jx6sp@e110439-lin>
 <384db1d1-e2e3-9a5c-568c-c7441706700f@oracle.com>
From:   Parth Shah <parth@linux.ibm.com>
Date:   Thu, 4 Jul 2019 17:05:55 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <384db1d1-e2e3-9a5c-568c-c7441706700f@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19070411-0012-0000-0000-0000032F395D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19070411-0013-0000-0000-000021688FC9
Message-Id: <95bf6b30-f28f-33a0-229f-3fd2da262aa2@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-04_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907040149
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 7/3/19 9:22 AM, Subhra Mazumdar wrote:
> 
> On 7/2/19 1:54 AM, Patrick Bellasi wrote:
>> Wondering if searching and preempting needs will ever be conflicting?
>> I guess the winning point is that we don't commit behaviors to
>> userspace, but just abstract concepts which are turned into biases.
>>
>> I don't see conflicts right now: if you are latency tolerant that
>> means you can spend more time to try finding a better CPU (e.g. we can
>> use the energy model to compare multiple CPUs) _and/or_ give the
>> current task a better chance to complete by delaying its preemption.
> OK
>>
>>> Otherwise sounds like a good direction to me. For the searching aspect, can
>>> we map latency nice values to the % of cores we search in select_idle_cpu?
>>> Thus the search cost can be controlled by latency nice value.
>> I guess that's worth a try, only caveat I see is that it's turning the
>> bias into something very platform specific. Meaning, the same
>> latency-nice value on different machines can have very different
>> results.
>>
>> Would not be better to try finding a more platform independent mapping?
>>
>> Maybe something time bounded, e.g. the higher the latency-nice the more
>> time we can spend looking for CPUs?
> The issue I see is suppose we have a range of latency-nice values, then it
> should cover the entire range of search (one core to all cores). As Peter
> said some workloads will want to search the LLC fully. If we have absolute
> time, the map of latency-nice values range to them will be arbitrary. If
> you have something in mind let me know, may be I am thinking differently.
>>
>>> But the issue is if more latency tolerant workloads set to less
>>> search, we still need some mechanism to achieve good spread of
>>> threads.
>> I don't get this example: why more latency tolerant workloads should
>> require less search?
> I guess I got the definition of "latency tolerant" backwards.
>>
>>> Can we keep the sliding window mechanism in that case?
>> Which one? Sorry did not went through the patches, can you briefly
>> resume the idea?
> If a workload has set it to low latency tolerant, then the search will be
> less. That can lead to localization of threads on a few CPUs as we are not
> searching the entire LLC even if there are idle CPUs available. For this
> I had introduced a per-CPU variable (for the target CPU) to track the
> boundary of search so that every time it will start from the boundary, thus
> sliding the window. So even if we are searching very little the search
> window keeps shifting and gives us a good spread. This is orthogonal to the
> latency-nice thing.

Can it be done something like turning off searching for an idle core if the wakee
task is latency tolerant(more latency-nice)? We search for idle core to get faster
resource allocation, thus such tasks don't need to find idle core and can
directly jump to finding idle CPUs.
This can include sliding windows mechanism along, but as I commented previously, it
imposes task ping-pong problem as sliding window gets away from target_cpu. So maybe
we can first search the core with target_cpu and if no idle CPUs found then bail
to this sliding window mechanism.
Just an thought.

Best,
Parth


>>
>>> Also will latency nice do anything for select_idle_core and
>>> select_idle_smt?
>> I guess principle the same bias can be used at different levels, maybe
>> with different mappings.
> Doing it for select_idle_core will have the issue that the dynamic flag
> (whether an idle core is present or not) can only be updated by threads
> which are doing the full search.
> 
> Thanks,
> Subhra
> 
>> In the mobile world use-case we will likely use it only to switch from
>> select_idle_sibling to the energy aware slow path. And perhaps to see
>> if we can bias the wakeup preemption granularity.
>>
>> Best,
>> Patrick
>>
> 

