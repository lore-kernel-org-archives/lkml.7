Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF482C43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 17:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B535520801
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 17:14:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730055AbfLEROF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Dec 2019 12:14:05 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59918 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726028AbfLEROF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Dec 2019 12:14:05 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB5H7s18093340
        for <linux-kernel@vger.kernel.org>; Thu, 5 Dec 2019 12:14:04 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wq1kk5pac-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2019 12:14:03 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <parth@linux.ibm.com>;
        Thu, 5 Dec 2019 17:14:00 -0000
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 5 Dec 2019 17:13:54 -0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xB5HDri218612324
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 5 Dec 2019 17:13:53 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BF1B0A4053;
        Thu,  5 Dec 2019 17:13:53 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 62F7EA4059;
        Thu,  5 Dec 2019 17:13:46 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.45.8])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  5 Dec 2019 17:13:45 +0000 (GMT)
Subject: Re: [RFC 0/3] Introduce per-task latency_tolerance for scheduler
 hints
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        patrick.bellasi@matbug.net, qais.yousef@arm.com, pavel@ucw.cz,
        dhaval.giani@oracle.com, qperret@qperret.net,
        David.Laight@ACULAB.COM, morten.rasmussen@arm.com, pjt@google.com,
        tj@kernel.org, viresh.kumar@linaro.org, rafael.j.wysocki@intel.com,
        daniel.lezcano@linaro.org
References: <20191125094618.30298-1-parth@linux.ibm.com>
 <450fc7e2-49d5-d809-281f-7d9a99d3e530@arm.com>
 <c26f7909-0e4e-a897-bf84-0aa9e5389a0d@arm.com>
 <838f233e-fa4c-d5a3-9b50-69e2e121edda@arm.com>
From:   Parth Shah <parth@linux.ibm.com>
Date:   Thu, 5 Dec 2019 22:43:44 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <838f233e-fa4c-d5a3-9b50-69e2e121edda@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19120517-0012-0000-0000-00000371B925
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19120517-0013-0000-0000-000021AD7EBD
Message-Id: <5c5b61fa-e8f7-5aa7-0fe0-91cb0d4736fb@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-05_05:2019-12-04,2019-12-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 adultscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=913 spamscore=0
 impostorscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-1912050144
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/5/19 7:33 PM, Dietmar Eggemann wrote:
> On 05/12/2019 11:49, Valentin Schneider wrote:
>>  
>> On 05/12/2019 09:24, Dietmar Eggemann wrote:
>>> On 25/11/2019 10:46, Parth Shah wrote:
>>>> This patch series is based on the discussion started as the "Usecases for
>>>> the per-task latency-nice attribute"[1]
>>>>
>>>> This patch series introduces a new per-task attribute latency_tolerance to
>>>> provide the scheduler hints about the latency requirements of the task.
>>>
>>> I forgot but is there a chance to have this as a per-taskgroup attribute
>>> as well?
>>>
>>
>> Peter argued we should go for task attributes first, and then
>> cgroup/taskgroups later on:
>>
>> https://lore.kernel.org/lkml/20190905083127.GA2332@hirez.programming.kicks-ass.net/
> 
> OK, I went through this thread again. So Google or we have to provide
> the missing per-taskgroup API via cpu controller's attributes (like for
> uclamp) for the EAS usecase.

I suppose many others (including myself) will also be interested in having
per-taskgroup attribute via CPU controller.

> 
> After reading:
> 
> https://lore.kernel.org/r/20190905114030.GL2349@hirez.programming.kicks-ass.net
> 
> IMHO the following mapping of the existing Android (binary)
> latency_sensitive per-taskgroup flag makes sense:
> 
> latency_sensitive=1 -> latency_tolerance*[-20 .. -1] (less tolerant,
> more sensitive)
> 
> latency_sensitive=0 -> latency_tolerance[0 .. 19] (more tolerant, less
> sensitive)
> 
> Default value is 0 so not latency_sensitive.
> 
> * Since we use [-20 .. 19] as values for latency_tolerance we could name
> it latency_nice. It's shorter ... ?

I kept choosing appropriate name and possible values for this new attribute
in the separate thread. https://lkml.org/lkml/2019/9/30/215
From which discussion, looking at Patrick's comment
https://lkml.org/lkml/2019/9/18/678 I thought of picking latency_tolerance
as the appropriate name.
Still will be happy to change as per the community needs.

Thanks,
parth

