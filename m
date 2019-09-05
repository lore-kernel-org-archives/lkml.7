Return-Path: <SRS0=AnJR=XA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0891BC3A5A5
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 06:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA6262173B
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Sep 2019 06:38:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731639AbfIEGiB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Sep 2019 02:38:01 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:31152 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731109AbfIEGiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Sep 2019 02:38:00 -0400
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x856bepA113732
        for <linux-kernel@vger.kernel.org>; Thu, 5 Sep 2019 02:37:59 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2utswfypm0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2019 02:37:59 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <parth@linux.ibm.com>;
        Thu, 5 Sep 2019 07:37:57 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 5 Sep 2019 07:37:52 +0100
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x856bpWm51249216
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 5 Sep 2019 06:37:51 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 140C3AE053;
        Thu,  5 Sep 2019 06:37:51 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 22805AE051;
        Thu,  5 Sep 2019 06:37:48 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.51.47])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu,  5 Sep 2019 06:37:47 +0000 (GMT)
Subject: Re: [RFC PATCH 9/9] sched: rotate the cpu search window for better
 spread
To:     subhra mazumdar <subhra.mazumdar@oracle.com>,
        linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, tglx@linutronix.de,
        steven.sistare@oracle.com, dhaval.giani@oracle.com,
        daniel.lezcano@linaro.org, vincent.guittot@linaro.org,
        viresh.kumar@linaro.org, tim.c.chen@linux.intel.com,
        mgorman@techsingularity.net, patrick.bellasi@arm.com
References: <20190830174944.21741-1-subhra.mazumdar@oracle.com>
 <20190830174944.21741-10-subhra.mazumdar@oracle.com>
From:   Parth Shah <parth@linux.ibm.com>
Date:   Thu, 5 Sep 2019 12:07:47 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20190830174944.21741-10-subhra.mazumdar@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19090506-0028-0000-0000-00000397F1B2
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19090506-0029-0000-0000-0000245A458B
Message-Id: <0931a2e0-0fbf-be64-d6c0-cba7745bb152@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-09-05_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1909050068
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/30/19 11:19 PM, subhra mazumdar wrote:
> Rotate the cpu search window for better spread of threads. This will ensure
> an idle cpu will quickly be found if one exists.
> 
> Signed-off-by: subhra mazumdar <subhra.mazumdar@oracle.com>
> ---
>  kernel/sched/fair.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 94dd4a32..7419b47 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6188,7 +6188,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
>  	u64 avg_cost, avg_idle;
>  	u64 time, cost;
>  	s64 delta;
> -	int cpu, floor, nr = INT_MAX;
> +	int cpu, floor, target_tmp, nr = INT_MAX;
>  
>  	this_sd = rcu_dereference(*this_cpu_ptr(&sd_llc));
>  	if (!this_sd)
> @@ -6213,9 +6213,15 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
>  			nr = floor;
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

Is it possible that two simultaneous select_idle_cpu call have the same target value?

>  		if (!--nr)
>  			return -1;
>  		if (!cpumask_test_cpu(cpu, &p->cpus_allowed))
> 

