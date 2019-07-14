Return-Path: <SRS0=2uMJ=VL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D8ACC71142
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 01:18:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E1892084B
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jul 2019 01:18:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LEjRHErO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728192AbfGNBSK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jul 2019 21:18:10 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35154 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727983AbfGNBSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jul 2019 21:18:09 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6E1EoEl079200;
        Sun, 14 Jul 2019 01:16:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=gnStV7SBtyBELVgdhWru5ZF/zwLQRRjtxakJR6QK8O4=;
 b=LEjRHErOUwlLHTSiY35a9/RWgVlntWcQEXHjz41W6JsOj1fltQqrqIidgrzVOp4pHh+6
 oJu2jP99ATK1ItUm55tSIWIDhSwIHgyzB4bxR/Zc/4n+rKDgdQuhBLFUY/r5dXvReqwO
 nN7pTUZnim4bbV2ABiPjxnAcdiy/GJiEAGM2Ex0a7BhIrXp0T1dhvQGKBaJbrCYfEeP0
 cVsN29inpLK7+vPi/6/hm3e9V6fbHTFnga8rFqbvjw5JfWd/MlGFE0pZujhYy2RgoyYq
 aSCy24tFdUiGBZN8lzBaCN5NcOhfcfj3PorxoraCvWgelXEsOHh0kvu9Unsu9BOq4sz2 yQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2tq7xqhu07-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 14 Jul 2019 01:16:19 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6E1EJt4138593;
        Sun, 14 Jul 2019 01:16:18 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2tq4dstp55-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 14 Jul 2019 01:16:18 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6E1GAde016937;
        Sun, 14 Jul 2019 01:16:10 GMT
Received: from Subhras-MacBook-Pro.local (/103.87.143.145)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 13 Jul 2019 18:16:10 -0700
Subject: Re: [PATCH v3 5/7] sched: SIS_CORE to disable idle core search
To:     Parth Shah <parth@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, tglx@linutronix.de,
        steven.sistare@oracle.com, dhaval.giani@oracle.com,
        daniel.lezcano@linaro.org, vincent.guittot@linaro.org,
        viresh.kumar@linaro.org, tim.c.chen@linux.intel.com,
        mgorman@techsingularity.net
References: <20190627012919.4341-1-subhra.mazumdar@oracle.com>
 <20190627012919.4341-6-subhra.mazumdar@oracle.com>
 <0e0f3347-c262-2917-76d7-88dddf4e9122@linux.ibm.com>
 <59ab08d5-8b7c-00b9-230b-7c0b307a675f@oracle.com>
 <be91602a-0243-e094-8c8f-ceed314d10ce@linux.ibm.com>
 <12402fea-7b87-8c4d-9485-53f973c38654@oracle.com>
 <aac9f826-ab73-2754-4a7b-7d948f1edf92@linux.ibm.com>
From:   Subhra Mazumdar <subhra.mazumdar@oracle.com>
Message-ID: <b3c238bc-c094-bbdf-5273-0de9e55f7a15@oracle.com>
Date:   Sun, 14 Jul 2019 06:46:01 +0530
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:60.0)
 Gecko/20100101 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <aac9f826-ab73-2754-4a7b-7d948f1edf92@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9317 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907140013
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9317 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907140014
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/4/19 6:04 PM, Parth Shah wrote:
> Same experiment with hackbench and with perf analysis shows increase in L1
> cache miss rate with these patches
> (Lower is better)
>                            Baseline(%)   Patch(%)
>   ----------------------- ------------- -----------
>    Total Cache miss rate         17.01   19(-11%)
>    L1 icache miss rate            5.45   6.7(-22%)
>
>
>
> So is is possible for idle_cpu search to try checking target_cpu first and
> then goto sliding window if not found.
> Below diff works as expected in IBM POWER9 system and resolves the problem
> of far wakeup upto large extent.
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index ff2e9b5c3ac5..fae035ce1162 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6161,6 +6161,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
>          u64 time, cost;
>          s64 delta;
>          int cpu, limit, floor, target_tmp, nr = INT_MAX;
> +       struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
>   
>          this_sd = rcu_dereference(*this_cpu_ptr(&sd_llc));
>          if (!this_sd)
> @@ -6198,16 +6199,22 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
>   
>          time = local_clock();
>   
> -       for_each_cpu_wrap(cpu, sched_domain_span(sd), target_tmp) {
> +       cpumask_and(cpus, sched_domain_span(sd), &p->cpus_allowed);
> +       for_each_cpu_wrap(cpu, cpu_smt_mask(target), target) {
> +               __cpumask_clear_cpu(cpu, cpus);
> +               if (available_idle_cpu(cpu))
> +                       goto idle_cpu_exit;
> +       }
> +
> +       for_each_cpu_wrap(cpu, cpus, target_tmp) {
>                  per_cpu(next_cpu, target) = cpu;
>                  if (!--nr)
>                          return -1;
> -               if (!cpumask_test_cpu(cpu, &p->cpus_allowed))
> -                       continue;
>                  if (available_idle_cpu(cpu))
>                          break;
>          }
>   
> +idle_cpu_exit:
>          time = local_clock() - time;
>          cost = this_sd->avg_scan_cost;
>          delta = (s64)(time - cost) / 8;
>
>
>
> Best,
> Parth
How about calling select_idle_smt before select_idle_cpu from
select_idle_sibling? That should have the same effect.
