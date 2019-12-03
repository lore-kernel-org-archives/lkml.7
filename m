Return-Path: <SRS0=Tfva=ZZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6254C432C0
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 15:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8D5652068E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Dec 2019 15:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbfLCPwM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Dec 2019 10:52:12 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:28366 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726189AbfLCPwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Dec 2019 10:52:10 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xB3Fh5qS027827
        for <linux-kernel@vger.kernel.org>; Tue, 3 Dec 2019 10:52:08 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2wnsqtusuh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Tue, 03 Dec 2019 10:52:08 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <parth@linux.ibm.com>;
        Tue, 3 Dec 2019 15:52:06 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 3 Dec 2019 15:52:01 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xB3Fq0Si5111946
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Dec 2019 15:52:00 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C7D444C893;
        Tue,  3 Dec 2019 15:52:00 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 40B184C890;
        Tue,  3 Dec 2019 15:51:56 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.85.91.149])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue,  3 Dec 2019 15:51:55 +0000 (GMT)
Subject: Re: [RFC 3/3] Allow sched_{get,set}attr to change latency_tolerance
 of the task
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        mingo@redhat.com, vincent.guittot@linaro.org,
        patrick.bellasi@matbug.net, valentin.schneider@arm.com,
        pavel@ucw.cz, dhaval.giani@oracle.com, qperret@qperret.net,
        David.Laight@ACULAB.COM, morten.rasmussen@arm.com, pjt@google.com,
        tj@kernel.org, dietmar.eggemann@arm.com, viresh.kumar@linaro.org,
        rafael.j.wysocki@intel.com, daniel.lezcano@linaro.org
References: <20191125094618.30298-1-parth@linux.ibm.com>
 <20191125094618.30298-4-parth@linux.ibm.com>
 <20191203083915.yahl2qd3wnnkqxxs@e107158-lin.cambridge.arm.com>
From:   Parth Shah <parth@linux.ibm.com>
Date:   Tue, 3 Dec 2019 21:21:55 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <20191203083915.yahl2qd3wnnkqxxs@e107158-lin.cambridge.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19120315-0012-0000-0000-000003706DB5
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19120315-0013-0000-0000-000021AC2AE4
Message-Id: <cfb607c1-6be9-853d-cfad-6787f78fa6ad@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-03_04:2019-12-02,2019-12-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0 bulkscore=0
 adultscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1910280000 definitions=main-1912030120
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 12/3/19 2:09 PM, Qais Yousef wrote:
> On 11/25/19 15:16, Parth Shah wrote:
>> Introduce the latency_tolerance attribute to sched_attr and provide a
>> mechanism to change the value with the use of sched_setattr/sched_getattr
>> syscall.
>>
>> Also add new flag "SCHED_FLAG_LATENCY_TOLERANCE" to hint the change in
>> latency_tolerance of the task on every sched_setattr syscall.
>>
>> Signed-off-by: Parth Shah <parth@linux.ibm.com>
>> ---
>>  include/uapi/linux/sched.h       |  4 +++-
>>  include/uapi/linux/sched/types.h |  2 ++
>>  kernel/sched/core.c              | 15 +++++++++++++++
>>  kernel/sched/sched.h             |  1 +
>>  4 files changed, 21 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/uapi/linux/sched.h b/include/uapi/linux/sched.h
>> index b3105ac1381a..73db430d11b6 100644
>> --- a/include/uapi/linux/sched.h
>> +++ b/include/uapi/linux/sched.h
>> @@ -71,6 +71,7 @@ struct clone_args {
>>  #define SCHED_FLAG_KEEP_PARAMS		0x10
>>  #define SCHED_FLAG_UTIL_CLAMP_MIN	0x20
>>  #define SCHED_FLAG_UTIL_CLAMP_MAX	0x40
>> +#define SCHED_FLAG_LATENCY_TOLERANCE	0x80
>>  
>>  #define SCHED_FLAG_KEEP_ALL	(SCHED_FLAG_KEEP_POLICY | \
>>  				 SCHED_FLAG_KEEP_PARAMS)
>> @@ -82,6 +83,7 @@ struct clone_args {
>>  			 SCHED_FLAG_RECLAIM		| \
>>  			 SCHED_FLAG_DL_OVERRUN		| \
>>  			 SCHED_FLAG_KEEP_ALL		| \
>> -			 SCHED_FLAG_UTIL_CLAMP)
>> +			 SCHED_FLAG_UTIL_CLAMP		| \
>> +			 SCHED_FLAG_LATENCY_TOLERANCE)
>>  
>>  #endif /* _UAPI_LINUX_SCHED_H */
>> diff --git a/include/uapi/linux/sched/types.h b/include/uapi/linux/sched/types.h
>> index c852153ddb0d..960774ac0c70 100644
>> --- a/include/uapi/linux/sched/types.h
>> +++ b/include/uapi/linux/sched/types.h
>> @@ -118,6 +118,8 @@ struct sched_attr {
>>  	__u32 sched_util_min;
>>  	__u32 sched_util_max;
>>  
>> +	/* latency requirement hints */
>> +	__s32 sched_latency_tolerance;
>>  };
>>  
>>  #endif /* _UAPI_LINUX_SCHED_TYPES_H */
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index ea7abbf5c1bb..dfd36ec14404 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -4695,6 +4695,9 @@ static void __setscheduler_params(struct task_struct *p,
>>  	p->rt_priority = attr->sched_priority;
>>  	p->normal_prio = normal_prio(p);
>>  	set_load_weight(p, true);
>> +
>> +	/* Change latency tolerance of the task if !SCHED_FLAG_KEEP_PARAMS */
>> +	p->latency_tolerance = attr->sched_latency_tolerance;
>>  }
>>  
>>  /* Actually do priority change: must hold pi & rq lock. */
>> @@ -4852,6 +4855,13 @@ static int __sched_setscheduler(struct task_struct *p,
>>  			return retval;
>>  	}
>>  
>> +	if (attr->sched_flags & SCHED_FLAG_LATENCY_TOLERANCE) {
>> +		if (attr->sched_latency_tolerance > MAX_LATENCY_TOLERANCE)
>> +			return -EINVAL;
>> +		if (attr->sched_latency_tolerance < MIN_LATENCY_TOLERANCE)
>> +			return -EINVAL;
>> +	}
>> +
>>  	if (pi)
>>  		cpuset_read_lock();
>>  
>> @@ -4886,6 +4896,9 @@ static int __sched_setscheduler(struct task_struct *p,
>>  			goto change;
>>  		if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP)
>>  			goto change;
>> +		if (attr->sched_flags & SCHED_FLAG_LATENCY_TOLERANCE &&
>> +		    attr->sched_latency_tolerance != p->latency_tolerance)
>> +			goto change;
>>  
>>  		p->sched_reset_on_fork = reset_on_fork;
>>  		retval = 0;
>> @@ -5392,6 +5405,8 @@ SYSCALL_DEFINE4(sched_getattr, pid_t, pid, struct sched_attr __user *, uattr,
>>  	else
>>  		kattr.sched_nice = task_nice(p);
>>  
>> +	kattr.sched_latency_tolerance = p->latency_tolerance;
>> +
>>  #ifdef CONFIG_UCLAMP_TASK
>>  	kattr.sched_util_min = p->uclamp_req[UCLAMP_MIN].value;
>>  	kattr.sched_util_max = p->uclamp_req[UCLAMP_MAX].value;
>> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
>> index 0db2c1b3361e..bb181175954b 100644
>> --- a/kernel/sched/sched.h
>> +++ b/kernel/sched/sched.h
>> @@ -21,6 +21,7 @@
>>  #include <linux/sched/nohz.h>
>>  #include <linux/sched/numa_balancing.h>
>>  #include <linux/sched/prio.h>
>> +#include <linux/sched/latency_tolerance.h>
> 
> nit: keep in alphabatical order.

ok.

> 
> The series looks good to me except for the 2 minor nits. Thanks for taking care
> of this!

My pleasure. Infact, I'm trying to write patches around what Subhra posted
for reducing wakeup scans https://lkml.org/lkml/2019/8/30/829 and few ideas
from Peter's patch https://lkml.org/lkml/2018/5/30/632. Aim here is to
reduce scans for lower latency_tolerance tasks and will post out soon which
uses this feature.

> 
> Reviewed-by: Qais Yousef <qais.yousef@arm.com>

Thanks. Will add it.

> 
> Cheers
> 
> --
> Qais Yousef
> 
>>  #include <linux/sched/rt.h>
>>  #include <linux/sched/signal.h>
>>  #include <linux/sched/smt.h>
>> -- 
>> 2.17.2
>>

