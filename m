Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E8E3C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 05:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58312214D8
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 05:13:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbfLMFNk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 00:13:40 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:16336 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725385AbfLMFNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 00:13:40 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBD5CPOs134972
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 00:13:38 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2wuswrr59q-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2019 00:13:38 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Fri, 13 Dec 2019 05:13:36 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 13 Dec 2019 05:13:33 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xBD5DWFl52559926
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Dec 2019 05:13:32 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4EBDAAE057;
        Fri, 13 Dec 2019 05:13:32 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 66F6EAE051;
        Fri, 13 Dec 2019 05:13:30 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Fri, 13 Dec 2019 05:13:30 +0000 (GMT)
Date:   Fri, 13 Dec 2019 10:43:29 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Cheng Jian <cj.chengjian@huawei.com>
Cc:     mingo@kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org, chenwandun@huawei.com,
        xiexiuqi@huawei.com, liwei391@huawei.com, huawei.libin@huawei.com,
        bobo.shaobowang@huawei.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org
Subject: Re: [PATCH v2] sched/fair: Optimize select_idle_cpu
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20191213024530.28052-1-cj.chengjian@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20191213024530.28052-1-cj.chengjian@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
x-cbid: 19121305-0012-0000-0000-00000374545D
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19121305-0013-0000-0000-000021B032A7
Message-Id: <20191213051329.GB23839@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-12_08:2019-12-12,2019-12-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 clxscore=1015 priorityscore=1501 adultscore=0
 impostorscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 spamscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912130043
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Cheng Jian <cj.chengjian@huawei.com> [2019-12-13 10:45:30]:

> Fixes: 1ad3aaf3fcd2 ("sched/core: Implement new approach to scale select_idle_cpu()")
> Signed-off-by: Cheng Jian <cj.chengjian@huawei.com>
> ---
>  kernel/sched/fair.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 08a233e97a01..d48244388ce9 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5828,6 +5828,7 @@ static inline int select_idle_smt(struct task_struct *p, int target)
>   */
>  static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int target)
>  {
> +	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
>  	struct sched_domain *this_sd;
>  	u64 avg_cost, avg_idle;
>  	u64 time, cost;
> @@ -5859,11 +5860,11 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, int t
>  
>  	time = cpu_clock(this);
>  
> -	for_each_cpu_wrap(cpu, sched_domain_span(sd), target) {
> +	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
> +
> +	for_each_cpu_wrap(cpu, cpus, target) {
>  		if (!--nr)
>  			return si_cpu;
> -		if (!cpumask_test_cpu(cpu, p->cpus_ptr))
> -			continue;
>  		if (available_idle_cpu(cpu))
>  			break;
>  		if (si_cpu == -1 && sched_idle_cpu(cpu))
Looks good to me.

Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>

-- 
Thanks and Regards
Srikar Dronamraju

