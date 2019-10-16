Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA010ECE588
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 07:21:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E61620872
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 07:21:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731440AbfJPHVr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 03:21:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38856 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726875AbfJPHVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 03:21:46 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9G7GfHd045940
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 03:21:45 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vnx1u1j2q-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 03:21:44 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <parth@linux.ibm.com>;
        Wed, 16 Oct 2019 08:21:42 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 16 Oct 2019 08:21:38 +0100
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9G7LbkG50069576
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Oct 2019 07:21:37 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C1D03A405B;
        Wed, 16 Oct 2019 07:21:37 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0ADF7A4054;
        Wed, 16 Oct 2019 07:21:36 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.35.59])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 16 Oct 2019 07:21:35 +0000 (GMT)
Subject: Re: [PATCH v3 04/10] sched/fair: rework load_balance
To:     Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org
Cc:     pauld@redhat.com, valentin.schneider@arm.com,
        srikar@linux.vnet.ibm.com, quentin.perret@arm.com,
        dietmar.eggemann@arm.com, Morten.Rasmussen@arm.com,
        hdanton@sina.com
References: <1568878421-12301-1-git-send-email-vincent.guittot@linaro.org>
 <1568878421-12301-5-git-send-email-vincent.guittot@linaro.org>
From:   Parth Shah <parth@linux.ibm.com>
Date:   Wed, 16 Oct 2019 12:51:34 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <1568878421-12301-5-git-send-email-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19101607-0008-0000-0000-00000322794E
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19101607-0009-0000-0000-00004A41918C
Message-Id: <17c4e175-d580-a43d-1278-b7a54c697544@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-16_02:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910160067
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/19/19 1:03 PM, Vincent Guittot wrote:

[...]

> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/fair.c | 585 ++++++++++++++++++++++++++++++++++------------------
>  1 file changed, 380 insertions(+), 205 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 017aad0..d33379c 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -7078,11 +7078,26 @@ static unsigned long __read_mostly max_load_balance_interval = HZ/10;
> 
>  enum fbq_type { regular, remote, all };
> 
> +/*
> + * group_type describes the group of CPUs at the moment of the load balance.
> + * The enum is ordered by pulling priority, with the group with lowest priority
> + * first so the groupe_type can be simply compared when selecting the busiest
> + * group. see update_sd_pick_busiest().
> + */
>  enum group_type {
> -	group_other = 0,
> +	group_has_spare = 0,
> +	group_fully_busy,
>  	group_misfit_task,
> +	group_asym_packing,
>  	group_imbalanced,
> -	group_overloaded,
> +	group_overloaded
> +};
> +
> +enum migration_type {
> +	migrate_load = 0,
> +	migrate_util,
> +	migrate_task,
> +	migrate_misfit
>  };
> 
>  #define LBF_ALL_PINNED	0x01
> @@ -7115,7 +7130,7 @@ struct lb_env {
>  	unsigned int		loop_max;
> 
>  	enum fbq_type		fbq_type;
> -	enum group_type		src_grp_type;
> +	enum migration_type	balance_type;
>  	struct list_head	tasks;
>  };
> 
> @@ -7347,7 +7362,7 @@ static int detach_tasks(struct lb_env *env)
>  {
>  	struct list_head *tasks = &env->src_rq->cfs_tasks;
>  	struct task_struct *p;
> -	unsigned long load;
> +	unsigned long util, load;
>  	int detached = 0;
> 
>  	lockdep_assert_held(&env->src_rq->lock);
> @@ -7380,19 +7395,53 @@ static int detach_tasks(struct lb_env *env)
>  		if (!can_migrate_task(p, env))
>  			goto next;
> 
> -		load = task_h_load(p);
> +		switch (env->balance_type) {
> +		case migrate_load:
> +			load = task_h_load(p);
> 
> -		if (sched_feat(LB_MIN) && load < 16 && !env->sd->nr_balance_failed)
> -			goto next;
> +			if (sched_feat(LB_MIN) &&
> +			    load < 16 && !env->sd->nr_balance_failed)
> +				goto next;
> 
> -		if ((load / 2) > env->imbalance)
> -			goto next;
> +			if ((load / 2) > env->imbalance)
> +				goto next;
> +
> +			env->imbalance -= load;
> +			break;
> +
> +		case migrate_util:
> +			util = task_util_est(p);
> +
> +			if (util > env->imbalance)

Can you please explain what would happen for
`if (util/2 > env->imbalance)` ?
just like when migrating load, even util shouldn't be migrated if
env->imbalance is just near the utilization of the task being moved, isn't it?

> +				goto next;
> +
> +			env->imbalance -= util;
> +			break;
> +[ ... ]

Thanks,
Parth

