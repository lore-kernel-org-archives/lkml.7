Return-Path: <SRS0=RGqN=Z6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6B45C43603
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 05:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C19B5206D6
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Dec 2019 05:52:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726465AbfLHFwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 00:52:38 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:14472 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725268AbfLHFwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 00:52:38 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB85l0cW122346
        for <linux-kernel@vger.kernel.org>; Sun, 8 Dec 2019 00:52:36 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2wrt571q79-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2019 00:52:36 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <parth@linux.ibm.com>;
        Sun, 8 Dec 2019 05:52:34 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com (9.149.109.196)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Sun, 8 Dec 2019 05:52:29 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xB85qSHj45547766
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 8 Dec 2019 05:52:28 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 151E64C040;
        Sun,  8 Dec 2019 05:52:28 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A5EF74C044;
        Sun,  8 Dec 2019 05:52:23 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.71.101])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun,  8 Dec 2019 05:52:23 +0000 (GMT)
Subject: Re: [RFC 3/3] Allow sched_{get,set}attr to change latency_tolerance
 of the task
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Qais Yousef <qais.yousef@arm.com>, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        patrick.bellasi@matbug.net, valentin.schneider@arm.com,
        pavel@ucw.cz, dhaval.giani@oracle.com, qperret@qperret.net,
        David.Laight@ACULAB.COM, morten.rasmussen@arm.com, pjt@google.com,
        tj@kernel.org, viresh.kumar@linaro.org, rafael.j.wysocki@intel.com,
        daniel.lezcano@linaro.org
References: <20191125094618.30298-1-parth@linux.ibm.com>
 <20191125094618.30298-4-parth@linux.ibm.com>
 <20191203083915.yahl2qd3wnnkqxxs@e107158-lin.cambridge.arm.com>
 <cfb607c1-6be9-853d-cfad-6787f78fa6ad@linux.ibm.com>
 <ffe4f4de-d433-91be-00ce-20b625807f20@arm.com>
 <09e9a3e1-9c43-a541-01e6-e1b429a63a6f@arm.com>
From:   Parth Shah <parth@linux.ibm.com>
Date:   Sun, 8 Dec 2019 11:22:22 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <09e9a3e1-9c43-a541-01e6-e1b429a63a6f@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19120805-0028-0000-0000-000003C67394
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19120805-0029-0000-0000-000024899C17
Message-Id: <a7b1d996-a21a-c6ca-6281-243b3163bc37@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-07_08:2019-12-05,2019-12-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 adultscore=0 spamscore=0 impostorscore=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912080053
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/6/19 9:34 PM, Dietmar Eggemann wrote:
> 
> 
> On 05.12.19 10:24, Dietmar Eggemann wrote:
>> On 03/12/2019 16:51, Parth Shah wrote:
>>>  
>>> On 12/3/19 2:09 PM, Qais Yousef wrote:
>>>> On 11/25/19 15:16, Parth Shah wrote:
>>
>> [...]
>>
>>>>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>>>>> index ea7abbf5c1bb..dfd36ec14404 100644
>>>>> --- a/kernel/sched/core.c
>>>>> +++ b/kernel/sched/core.c
>>>>> @@ -4695,6 +4695,9 @@ static void __setscheduler_params(struct task_struct *p,
>>>>>  	p->rt_priority = attr->sched_priority;
>>>>>  	p->normal_prio = normal_prio(p);
>>>>>  	set_load_weight(p, true);
>>>>> +
>>>>> +	/* Change latency tolerance of the task if !SCHED_FLAG_KEEP_PARAMS */
>>
>> IMHO, this comment seems to be gratuitous.
>>
>>>>> +	p->latency_tolerance = attr->sched_latency_tolerance;
>>>>>  }
>>
>> [...]
>>
> 
> This also would require some changes to UAPI
> (include/uapi/linux/sched.h, include/uapi/linux/sched/types.h), see
> commit a509a7cd7974 ("sched/uclamp: Extend sched_setattr() to support
> utilization clamping") and tools headers UAPI
> (tools/include/uapi/linux/sched.h), see commit c093de6bd3c5 ("tools
> headers UAPI: Sync sched.h with the kernel").
> 

Ok. Will add it. Thanks

