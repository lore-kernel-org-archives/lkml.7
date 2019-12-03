Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B8A1C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 15:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 549592073C
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 15:47:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbfLCPr1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 10:47:27 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49150 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725997AbfLCPr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 10:47:26 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB3FhX50110151
        for <linux-kernel@vger.kernel.org>; Tue, 3 Dec 2019 10:47:25 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2wnp8rpcmj-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 10:47:25 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <parth@linux.ibm.com>;
        Tue, 3 Dec 2019 15:47:23 -0000
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 3 Dec 2019 15:47:18 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xB3FlHbE40304664
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Dec 2019 15:47:17 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CC7864C882;
        Tue,  3 Dec 2019 15:47:17 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 532584C87F;
        Tue,  3 Dec 2019 15:47:13 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.91.149])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  3 Dec 2019 15:47:12 +0000 (GMT)
Subject: Re: [RFC 1/3] Introduce latency-tolerance as an per-task attribute
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, vincent.guittot@linaro.org,
        patrick.bellasi@matbug.net, valentin.schneider@arm.com,
        pavel@ucw.cz, dhaval.giani@oracle.com, qperret@qperret.net,
        David.Laight@ACULAB.COM, morten.rasmussen@arm.com, pjt@google.com,
        tj@kernel.org, dietmar.eggemann@arm.com, viresh.kumar@linaro.org,
        rafael.j.wysocki@intel.com, daniel.lezcano@linaro.org
References: <20191125094618.30298-1-parth@linux.ibm.com>
 <20191125094618.30298-2-parth@linux.ibm.com>
 <20191203083654.3ctttimdiujdt7tl@e107158-lin.cambridge.arm.com>
From:   Parth Shah <parth@linux.ibm.com>
Date:   Tue, 3 Dec 2019 21:17:11 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20191203083654.3ctttimdiujdt7tl@e107158-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19120315-0028-0000-0000-000003C427E1
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19120315-0029-0000-0000-00002487428C
Message-Id: <59044b60-a7d8-9508-4975-06afdcfd33cd@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-03_04:2019-12-02,2019-12-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 clxscore=1015 impostorscore=0 bulkscore=0 adultscore=0
 spamscore=0 phishscore=0 mlxscore=0 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912030120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/3/19 2:06 PM, Qais Yousef wrote:
> On 11/25/19 15:16, Parth Shah wrote:
>> Latency-tolerance indicates the latency requirements of a task with respect
>> to the other tasks in the system. The value of the attribute can be within
>> the range of [-20, 19] both inclusive to be in-line with the values just
>> like task nice values.
>>
>> latency_tolerance = -20 indicates the task to have the least latency as
>> compared to the tasks having latency_tolerance = +19.
>>
>> The latency_tolerance may affect only the CFS SCHED_CLASS by getting
>> latency requirements from the userspace.
>>
>> Signed-off-by: Parth Shah <parth@linux.ibm.com>
>> ---
>>  include/linux/sched.h                   |  3 +++
>>  include/linux/sched/latency_tolerance.h | 13 +++++++++++++
>>  2 files changed, 16 insertions(+)
>>  create mode 100644 include/linux/sched/latency_tolerance.h
>>
>> diff --git a/include/linux/sched.h b/include/linux/sched.h
>> index 2c2e56bd8913..bcc1c1d0856d 100644
>> --- a/include/linux/sched.h
>> +++ b/include/linux/sched.h
>> @@ -25,6 +25,7 @@
>>  #include <linux/resource.h>
>>  #include <linux/latencytop.h>
>>  #include <linux/sched/prio.h>
>> +#include <linux/sched/latency_tolerance.h>
>>  #include <linux/sched/types.h>
>>  #include <linux/signal_types.h>
>>  #include <linux/mm_types_task.h>
>> @@ -666,6 +667,8 @@ struct task_struct {
>>  #endif
>>  	int				on_rq;
>>  
>> +	int				latency_tolerance;
>> +
>>  	int				prio;
>>  	int				static_prio;
>>  	int				normal_prio;
>> diff --git a/include/linux/sched/latency_tolerance.h b/include/linux/sched/latency_tolerance.h
>> new file mode 100644
>> index 000000000000..7a00abe05bc4
>> --- /dev/null
>> +++ b/include/linux/sched/latency_tolerance.h
>> @@ -0,0 +1,13 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef _LINUX_SCHED_LATENCY_TOLERANCE_H
>> +#define _LINUX_SCHED_LATENCY_TOLERANCE_H
> 
> nit: Add some description here explaining what latency tolerance is please. You
> copy paste some text from your cover letter :)

Sure. Will add some text here.

> 
> --
> Qais Youesf
> 
>> +
>> +#define MAX_LATENCY_TOLERANCE	19
>> +#define MIN_LATENCY_TOLERANCE	-20
>> +
>> +#define LATENCY_TOLERANCE_WIDTH	\
>> +	(MAX_LATENCY_TOLERANCE - MIN_LATENCY_TOLERANCE + 1)
>> +
>> +#define DEFAULT_LATENCY_TOLERANCE	0
>> +
>> +#endif /* _LINUX_SCHED_LATENCY_TOLERANCE_H */
>> -- 
>> 2.17.2
>>

