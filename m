Return-Path: <SRS0=cgli=V4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76FF1C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 13:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49635206A2
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Jul 2019 13:44:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729624AbfGaNoJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Jul 2019 09:44:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:12446 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726907AbfGaNoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jul 2019 09:44:08 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6VDegYR132379
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 09:44:07 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2u3aupuvh0-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jul 2019 09:44:06 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <srikar@linux.vnet.ibm.com>;
        Wed, 31 Jul 2019 14:44:02 +0100
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 31 Jul 2019 14:43:58 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6VDhviY49348802
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Jul 2019 13:43:58 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D910A11C05B;
        Wed, 31 Jul 2019 13:43:57 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 44A8D11C054;
        Wed, 31 Jul 2019 13:43:56 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Wed, 31 Jul 2019 13:43:56 +0000 (GMT)
Date:   Wed, 31 Jul 2019 19:13:55 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Phil Auld <pauld@redhat.com>
Subject: Re: [PATCH 3/5] sched/fair: rework load_balance
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <1563523105-24673-1-git-send-email-vincent.guittot@linaro.org>
 <1563523105-24673-4-git-send-email-vincent.guittot@linaro.org>
 <20190726135852.GB7168@linux.vnet.ibm.com>
 <CAKfTPtA7UKL4NJHkMTx=MgohbXqO6kJCwamEjBX-zu3nNO1XLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAKfTPtA7UKL4NJHkMTx=MgohbXqO6kJCwamEjBX-zu3nNO1XLA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-TM-AS-GCONF: 00
x-cbid: 19073113-0008-0000-0000-000003029CBA
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19073113-0009-0000-0000-00002270427D
Message-Id: <20190731134355.GC11365@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-31_06:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907310141
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Vincent Guittot <vincent.guittot@linaro.org> [2019-07-26 16:42:53]:

> On Fri, 26 Jul 2019 at 15:59, Srikar Dronamraju
> <srikar@linux.vnet.ibm.com> wrote:
> > > @@ -7361,19 +7357,46 @@ static int detach_tasks(struct lb_env *env)
> > >               if (!can_migrate_task(p, env))
> > >                       goto next;
> > >
> > > -             load = task_h_load(p);
> > > +             if (env->src_grp_type == migrate_load) {
> > > +                     unsigned long load = task_h_load(p);
> > >
> > > -             if (sched_feat(LB_MIN) && load < 16 && !env->sd->nr_balance_failed)
> > > -                     goto next;
> > > +                     if (sched_feat(LB_MIN) &&
> > > +                         load < 16 && !env->sd->nr_balance_failed)
> > > +                             goto next;
> > > +
> > > +                     if ((load / 2) > env->imbalance)
> > > +                             goto next;
> >
> > I know this existed before too but if the load is exactly or around 2x of
> > env->imbalance, the resultant imbalance after the load balance operation
> > would still be around env->imbalance. We may lose some cache affinity too.
> >
> > Can we do something like.
> >                 if (2 * load > 3 * env->imbalance)
> >                         goto next;
> 
> TBH, I don't know what should be the best value and it's probably
> worth doing some investigation but i would prefer to do that as a
> separate patch to get a similar behavior in the overloaded case
> Why do you propose 3/2 instead of 2 ?
> 

If the imbalance is exactly or around load/2, then we still select the task to migrate
However after the migrate the imbalance will still be load/2.
- Can this lead to ping/pong?
- Did we lose out of cache though we didn't gain from an imbalance.

> > >
> > >
> > > -     if (sgs->sum_h_nr_running)
> > > -             sgs->load_per_task = sgs->group_load / sgs->sum_h_nr_running;
> > > +     sgs->group_capacity = group->sgc->capacity;
> > >
> > >       sgs->group_weight = group->group_weight;
> > >
> > > -     sgs->group_no_capacity = group_is_overloaded(env, sgs);
> > > -     sgs->group_type = group_classify(group, sgs);
> > > +     sgs->group_type = group_classify(env, group, sgs);
> > > +
> > > +     /* Computing avg_load makes sense only when group is overloaded */
> > > +     if (sgs->group_type != group_overloaded)
> > > +             sgs->avg_load = (sgs->group_load*SCHED_CAPACITY_SCALE) /
> > > +                             sgs->group_capacity;
> >
> > Mismatch in comment and code?
> 
> I may need to add more comments but at this step, the group should be
> either overloaded or fully busy but it can also be imbalanced.
> In case of a group fully busy or imbalanced (sgs->group_type !=
> group_overloaded), we haven't computed avg_load yet so we have to do
> so because:
> -In the case of fully_busy, we are going to be overloaded which the
> next step after fully busy when you are about to pull more load
> -In case of imbalance, we don't know the real state of the local group
> so we fall back to this default behavior
> 

We seem to be checking for avg_load when the group_type is group_overloaded.
But somehow I am don't see where sgs->avg_load is calculated for
group_overloaded case.

> >
> > We calculated avg_load for !group_overloaded case, but seem to be using for
> > group_overloaded cases too.
> 
> for group_overloaded case, we already computed it in update_sg_lb_stats()
> 


From update_sg_lb_stats()

	if (sgs->group_type != group_overloaded)
		sgs->avg_load = (sgs->group_load*SCHED_CAPACITY_SCALE) /
				sgs->group_capacity;

So we seem to be skipping calculation of avg_load for group_overloaded. No?


-- 
Thanks and Regards
Srikar Dronamraju

