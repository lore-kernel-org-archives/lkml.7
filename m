Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5494FC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 08:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30C0121848
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 08:37:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388478AbfISIhX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 04:37:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49636 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387617AbfISIhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 04:37:23 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x8J8WuFV057213
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 04:37:21 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2v44b5vcej-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 04:37:21 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <parth@linux.ibm.com>;
        Thu, 19 Sep 2019 09:37:19 +0100
Received: from b06avi18878370.portsmouth.uk.ibm.com (9.149.26.194)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 19 Sep 2019 09:37:14 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x8J8bDK325559440
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Sep 2019 08:37:14 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D842CA405C;
        Thu, 19 Sep 2019 08:37:13 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 42C38A405B;
        Thu, 19 Sep 2019 08:37:11 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.35.217])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 19 Sep 2019 08:37:11 +0000 (GMT)
Subject: Re: Usecases for the per-task latency-nice attribute
To:     Tim Chen <tim.c.chen@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        subhra mazumdar <subhra.mazumdar@oracle.com>,
        Valentin Schneider <valentin.schneider@arm.com>
Cc:     mingo@redhat.com, morten.rasmussen@arm.com,
        dietmar.eggemann@arm.com, pjt@google.com,
        vincent.guittot@linaro.org, quentin.perret@arm.com,
        dhaval.giani@oracle.com, daniel.lezcano@linaro.org, tj@kernel.org,
        rafael.j.wysocki@intel.com, qais.yousef@arm.com
References: <3e5c3f36-b806-5bcc-e666-14dc759a2d7b@linux.ibm.com>
 <426c0513-4354-e085-5a5d-8073ab035030@linux.intel.com>
From:   Parth Shah <parth@linux.ibm.com>
Date:   Thu, 19 Sep 2019 14:07:10 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <426c0513-4354-e085-5a5d-8073ab035030@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19091908-0028-0000-0000-0000039FE73C
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19091908-0029-0000-0000-00002461ED75
Message-Id: <707610a5-3344-f0ac-5536-73c9565bc1c7@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-19_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1909190082
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/18/19 10:46 PM, Tim Chen wrote:
> On 9/18/19 5:41 AM, Parth Shah wrote:
>> Hello everyone,
>>
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
> 
> Thanks for starting the discussion.
> 
> 
>>
>> -------------------
>> **Usecases**
>> -------------------
>>
>> $> TurboSched
>> ====================
>> TurboSched [2] tries to minimize the number of active cores in a socket by
>> packing an un-important and low-utilization (named jitter) task on an
>> already active core and thus refrains from waking up of a new core if
>> possible. This requires tagging of tasks from the userspace hinting which
>> tasks are un-important and thus waking-up a new core to minimize the
>> latency is un-necessary for such tasks.
>> As per the discussion on the posted RFC, it will be appropriate to use the
>> task latency property where a task with the highest latency-nice value can
>> be packed.
>> But for this specific use-cases, having just a binary value to know which
>> task is latency-sensitive and which not is sufficient enough, but having a
>> range is also a good way to go where above some threshold the task can be
>> packed.
>>
>>
> 
> $> Separating AVX512 tasks and latency sensitive tasks on separate cores
> -------------------------------------------------------------------------
> Another usecase we are considering is to segregate those workload that will pull down
> core cpu frequency (e.g. AVX512) from workload that are latency sensitive.
> There are certain tasks that need to provide a fast response time (latency sensitive)
> and they are best scheduled on cpu that has a lighter load and not have other
> tasks running on the sibling cpu that could pull down the cpu core frequency.
> 
> Some users are running machine learning batch tasks with AVX512, and have observed
> that these tasks affect the tasks needing a fast response.  They have to
> rely on manual CPU affinity to separate these tasks.  With appropriate
> latency hint on task, the scheduler can be taught to separate them.
> 

Thanks for listing out your usecase.

This is interesting. If scheduler has the knowledge of AVX512 tasks then
with these interface the scheduler can refrain from picking such core
occupying AVX512 tasks for the task with "latency-nice = -19".

So I guess for this specific use-case, the value for such per-task
attribute should have range (most probably [-19,20]) and the name
"latency-nice" also suits the need.

Do you have any specific values in mind for such attr?


Thanks,
Parth

