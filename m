Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C93E7C4321A
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 18:48:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2AC620645
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 18:48:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726941AbfF1SsF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 14:48:05 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34128 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726702AbfF1SsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 14:48:05 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5SIkkjc144298
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 14:48:02 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2tdn2x7uq1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 14:48:01 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <parth@linux.ibm.com>;
        Fri, 28 Jun 2019 19:47:59 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp05.uk.ibm.com (192.168.101.135) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 28 Jun 2019 19:47:54 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x5SIlrwt49676454
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jun 2019 18:47:53 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A0C64A4040;
        Fri, 28 Jun 2019 18:47:53 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 546EBA4051;
        Fri, 28 Jun 2019 18:47:50 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.62.39])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 28 Jun 2019 18:47:50 +0000 (GMT)
Subject: Re: [PATCH v3 1/7] sched: limit cpu search in select_idle_cpu
To:     subhra mazumdar <subhra.mazumdar@oracle.com>,
        linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, tglx@linutronix.de,
        steven.sistare@oracle.com, dhaval.giani@oracle.com,
        daniel.lezcano@linaro.org, vincent.guittot@linaro.org,
        viresh.kumar@linaro.org, tim.c.chen@linux.intel.com,
        mgorman@techsingularity.net
References: <20190627012919.4341-1-subhra.mazumdar@oracle.com>
 <20190627012919.4341-2-subhra.mazumdar@oracle.com>
From:   Parth Shah <parth@linux.ibm.com>
Date:   Sat, 29 Jun 2019 00:17:49 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20190627012919.4341-2-subhra.mazumdar@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19062818-0020-0000-0000-0000034E74BA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19062818-0021-0000-0000-000021A1F6EE
Message-Id: <68baf89b-6d77-4eff-3aac-f96b72f98bae@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-06-28_09:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1906280212
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/27/19 6:59 AM, subhra mazumdar wrote:
> Put upper and lower limit on cpu search of select_idle_cpu. The lower limit
> is amount of cpus in a core while upper limit is twice that. This ensures
> for any architecture we will usually search beyond a core. The upper limit
> also helps in keeping the search cost low and constant.
> 
> Signed-off-by: subhra mazumdar <subhra.mazumdar@oracle.com>
> ---
>  kernel/sched/fair.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index f35930f..b58f08f 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6188,7 +6188,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
>  	u64 avg_cost, avg_idle;
>  	u64 time, cost;
>  	s64 delta;
> -	int cpu, nr = INT_MAX;
> +	int cpu, limit, floor, nr = INT_MAX;
> 
>  	this_sd = rcu_dereference(*this_cpu_ptr(&sd_llc));
>  	if (!this_sd)
> @@ -6206,10 +6206,17 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
> 
>  	if (sched_feat(SIS_PROP)) {
>  		u64 span_avg = sd->span_weight * avg_idle;
> -		if (span_avg > 4*avg_cost)
> +		floor = cpumask_weight(topology_sibling_cpumask(target));
> +		if (floor < 2)
> +			floor = 2;
> +		limit = floor << 1;

Is upper limit an experimental value only or it has any arch specific significance?
Because, AFAIU, systems like POWER9 might have benefit for searching for 4-cores
due to its different cache model. So it can be tuned for arch specific builds then.

Also variable names can be changed for better readability.
floor -> weight_clamp_min
limit -> weight_clamp_max
or something similar


> +		if (span_avg > floor*avg_cost) {
>  			nr = div_u64(span_avg, avg_cost);
> -		else
> -			nr = 4;
> +			if (nr > limit)
> +				nr = limit;
> +		} else {
> +			nr = floor;
> +		}
>  	}
> 
>  	time = local_clock();
> 


Best,
Parth

