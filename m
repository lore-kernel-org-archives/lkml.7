Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31E1ECA9ECB
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:34:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F25812067B
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 05:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395224AbfJRFeR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 01:34:17 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:45996 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727399AbfJRFeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 01:34:17 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9I5WWhK042797
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 01:34:16 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vq5n8jvma-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 01:34:16 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-kernel@vger.kernel.org> from <parth@linux.ibm.com>;
        Fri, 18 Oct 2019 06:34:13 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp01.uk.ibm.com (192.168.101.131) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 18 Oct 2019 06:34:09 +0100
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x9I5Y8Q451183716
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Oct 2019 05:34:08 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8E36A42041;
        Fri, 18 Oct 2019 05:34:08 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CA68742042;
        Fri, 18 Oct 2019 05:34:06 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.35.142])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 18 Oct 2019 05:34:06 +0000 (GMT)
Subject: Re: [PATCH v3 04/10] sched/fair: rework load_balance
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Hillf Danton <hdanton@sina.com>
References: <1568878421-12301-1-git-send-email-vincent.guittot@linaro.org>
 <1568878421-12301-5-git-send-email-vincent.guittot@linaro.org>
 <17c4e175-d580-a43d-1278-b7a54c697544@linux.ibm.com>
 <CAKfTPtB-12oAe5ssxrp4aO35qC9H_EWK=UcuqEDXSucKEWngzA@mail.gmail.com>
From:   Parth Shah <parth@linux.ibm.com>
Date:   Fri, 18 Oct 2019 11:04:06 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
In-Reply-To: <CAKfTPtB-12oAe5ssxrp4aO35qC9H_EWK=UcuqEDXSucKEWngzA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 19101805-4275-0000-0000-000003732F30
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19101805-4276-0000-0000-0000388649FE
Message-Id: <ea65955f-8b90-f739-1ede-db2b0e56ce8d@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-18_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910180052
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/16/19 5:26 PM, Vincent Guittot wrote:
> On Wed, 16 Oct 2019 at 09:21, Parth Shah <parth@linux.ibm.com> wrote:
>>
>>
>>
>> On 9/19/19 1:03 PM, Vincent Guittot wrote:
>>
>> [...]
>>
>>> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
>>> ---
>>>  kernel/sched/fair.c | 585 ++++++++++++++++++++++++++++++++++------------------
>>>  1 file changed, 380 insertions(+), 205 deletions(-)
>>>
>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>> index 017aad0..d33379c 100644
>>> --- a/kernel/sched/fair.c
>>> +++ b/kernel/sched/fair.c
>>> @@ -7078,11 +7078,26 @@ static unsigned long __read_mostly max_load_balance_interval = HZ/10;
>>>
>>>  enum fbq_type { regular, remote, all };
>>>
>>> +/*
>>> + * group_type describes the group of CPUs at the moment of the load balance.
>>> + * The enum is ordered by pulling priority, with the group with lowest priority
>>> + * first so the groupe_type can be simply compared when selecting the busiest
>>> + * group. see update_sd_pick_busiest().
>>> + */
>>>  enum group_type {
>>> -     group_other = 0,
>>> +     group_has_spare = 0,
>>> +     group_fully_busy,
>>>       group_misfit_task,
>>> +     group_asym_packing,
>>>       group_imbalanced,
>>> -     group_overloaded,
>>> +     group_overloaded
>>> +};
>>> +
>>> +enum migration_type {
>>> +     migrate_load = 0,
>>> +     migrate_util,
>>> +     migrate_task,
>>> +     migrate_misfit
>>>  };
>>>
>>>  #define LBF_ALL_PINNED       0x01
>>> @@ -7115,7 +7130,7 @@ struct lb_env {
>>>       unsigned int            loop_max;
>>>
>>>       enum fbq_type           fbq_type;
>>> -     enum group_type         src_grp_type;
>>> +     enum migration_type     balance_type;
>>>       struct list_head        tasks;
>>>  };
>>>
>>> @@ -7347,7 +7362,7 @@ static int detach_tasks(struct lb_env *env)
>>>  {
>>>       struct list_head *tasks = &env->src_rq->cfs_tasks;
>>>       struct task_struct *p;
>>> -     unsigned long load;
>>> +     unsigned long util, load;
>>>       int detached = 0;
>>>
>>>       lockdep_assert_held(&env->src_rq->lock);
>>> @@ -7380,19 +7395,53 @@ static int detach_tasks(struct lb_env *env)
>>>               if (!can_migrate_task(p, env))
>>>                       goto next;
>>>
>>> -             load = task_h_load(p);
>>> +             switch (env->balance_type) {
>>> +             case migrate_load:
>>> +                     load = task_h_load(p);
>>>
>>> -             if (sched_feat(LB_MIN) && load < 16 && !env->sd->nr_balance_failed)
>>> -                     goto next;
>>> +                     if (sched_feat(LB_MIN) &&
>>> +                         load < 16 && !env->sd->nr_balance_failed)
>>> +                             goto next;
>>>
>>> -             if ((load / 2) > env->imbalance)
>>> -                     goto next;
>>> +                     if ((load / 2) > env->imbalance)
>>> +                             goto next;
>>> +
>>> +                     env->imbalance -= load;
>>> +                     break;
>>> +
>>> +             case migrate_util:
>>> +                     util = task_util_est(p);
>>> +
>>> +                     if (util > env->imbalance)
>>
>> Can you please explain what would happen for
>> `if (util/2 > env->imbalance)` ?
>> just like when migrating load, even util shouldn't be migrated if
>> env->imbalance is just near the utilization of the task being moved, isn't it?
> 
> I have chosen uti and not util/2 to be conservative because
> migrate_util is used to fill spare capacity.
> With `if (util/2 > env->imbalance)`, we can more easily overload the
> local group or pick too much utilization from the overloaded group.
> 

fair enough. I missed the point that unlike migrate_load, with
migrate_util, env->imbalance is just spare capacity of the local group.

Thanks,
Parth

>>
>>> +                             goto next;
>>> +
>>> +                     env->imbalance -= util;
>>> +                     break;
>>> +[ ... ]
>>
>> Thanks,
>> Parth
>>

