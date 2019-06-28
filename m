Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75FC2C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 18:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5492F2063F
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 18:37:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbfF1ShN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 14:37:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36112 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726658AbfF1ShM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 14:37:12 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5SIXM1U111075
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 14:37:12 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tdqe81y31-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 14:37:11 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <parth@linux.ibm.com>;
        Fri, 28 Jun 2019 19:37:09 +0100
Received: from b06avi18626390.portsmouth.uk.ibm.com (9.149.26.192)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 28 Jun 2019 19:37:05 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5SIaslx38928874
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jun 2019 18:36:54 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 15DCCA4040;
        Fri, 28 Jun 2019 18:37:04 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 25102A4053;
        Fri, 28 Jun 2019 18:37:00 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.62.39])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 28 Jun 2019 18:36:59 +0000 (GMT)
Subject: Re: [PATCH v3 3/7] sched: rotate the cpu search window for better
 spread
To:     subhra mazumdar <subhra.mazumdar@oracle.com>,
        linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, tglx@linutronix.de,
        steven.sistare@oracle.com, dhaval.giani@oracle.com,
        daniel.lezcano@linaro.org, vincent.guittot@linaro.org,
        viresh.kumar@linaro.org, tim.c.chen@linux.intel.com,
        mgorman@techsingularity.net
References: <20190627012919.4341-1-subhra.mazumdar@oracle.com>
 <20190627012919.4341-4-subhra.mazumdar@oracle.com>
From:   Parth Shah <parth@linux.ibm.com>
Date:   Sat, 29 Jun 2019 00:06:58 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20190627012919.4341-4-subhra.mazumdar@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19062818-0020-0000-0000-0000034E7455
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19062818-0021-0000-0000-000021A1F685
Message-Id: <f8b185ca-ae3e-8c54-5381-e9104be4954c@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-28_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906280209
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Subhra,

I ran your patch series on IBM POWER systems and this is what I have observed.

On 6/27/19 6:59 AM, subhra mazumdar wrote:
> Rotate the cpu search window for better spread of threads. This will ensure
> an idle cpu will quickly be found if one exists.
> 
> Signed-off-by: subhra mazumdar <subhra.mazumdar@oracle.com>
> ---
>  kernel/sched/fair.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index b58f08f..c1ca88e 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6188,7 +6188,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
>  	u64 avg_cost, avg_idle;
>  	u64 time, cost;
>  	s64 delta;
> -	int cpu, limit, floor, nr = INT_MAX;
> +	int cpu, limit, floor, target_tmp, nr = INT_MAX;
> 
>  	this_sd = rcu_dereference(*this_cpu_ptr(&sd_llc));
>  	if (!this_sd)
> @@ -6219,9 +6219,15 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
>  		}
>  	}
> 
> +	if (per_cpu(next_cpu, target) != -1)
> +		target_tmp = per_cpu(next_cpu, target);
> +	else
> +		target_tmp = target;
> +
>  	time = local_clock();
> 
> -	for_each_cpu_wrap(cpu, sched_domain_span(sd), target) {
> +	for_each_cpu_wrap(cpu, sched_domain_span(sd), target_tmp) {
> +		per_cpu(next_cpu, target) = cpu;

This leads to a problem of cache hotness.
AFAIU, in most cases, `target = prev_cpu` of the task being woken up and
selecting an idle CPU nearest to the prev_cpu is favorable.
But since this doesn't keep track of last idle cpu per task, it fails to find the
nearest possible idle CPU in cases when the task is being woken up after other
scheduled task.

Consider below scenario:
=======================
- System: 44 cores, 88 CPUs
- 44 CPU intensive tasks pinned to any CPU in each core. This makes 'select_idle_core' return -1;
- Consider below shown timeline:
- Task T1 runs for time 0-5 on CPU0
- Then task T2 runs for time 6-10 on CPU0
- T1 wakes at time 7, with target=0, and setting
  per_cpu(next_cpu,0)= 4 (let's say cpu 0-3 are busy at the time)
- So T1 runs for time 7-12 on CPU4.
- Meanwhile, T2 wakes at time 11, with target=0, but per_cpu(next_cpu, 0) is 4. So starts
  searching from CPU4 and ends up at CPU 8 or so even though CPU0 is free at that time.
- This goes on further far away from the prev_cpu on each such iteration unless it wraps around after 44 CPUs.


              ^T1           T1$   ^T2          T2$
CPU 0          |             |     |            |      
       -----------------------------------------------------------------------------
               0             5     6            10                       time----->

                                       ^T1                T1$
CPU 4                                   |                  |
       -----------------------------------------------------------------------------
                                        7                  12            time----->

                                                      ^T2          T2$
CPU 8                                                  |            |
       -----------------------------------------------------------------------------
                                                       11                time------>

Symbols: ^Tn: Task Tn wake-up,  Tn$: task Tn sleeps

Above example indicates the both the task T1 and T2 suffers from cache hotness in further iterations.


>  		if (!--nr)
>  			return -1;
>  		if (!cpumask_test_cpu(cpu, &p->cpus_allowed))
> 


Best
Parth

