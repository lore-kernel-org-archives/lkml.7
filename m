Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC1B8C282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 20:42:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8901320692
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 20:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbgAHUmU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 15:42:20 -0500
Received: from mga14.intel.com ([192.55.52.115]:42991 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726426AbgAHUmU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 15:42:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Jan 2020 12:42:20 -0800
X-IronPort-AV: E=Sophos;i="5.69,411,1571727600"; 
   d="scan'208";a="223036740"
Received: from rchatre-mobl.amr.corp.intel.com (HELO [10.24.14.130]) ([10.24.14.130])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 08 Jan 2020 12:42:20 -0800
Subject: Re: [bug report] resctrl high memory comsumption
To:     Fenghua Yu <fenghua.yu@intel.com>,
        Shakeel Butt <shakeelb@google.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org
References: <CALvZod7E9zzHwenzf7objzGKsdBmVwTgEJ0nPgs0LUFU3SN5Pw@mail.gmail.com>
 <20200108202311.GA40461@romley-ivt3.sc.intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
Message-ID: <bbc27400-68d9-13fd-7402-d158a6754122@intel.com>
Date:   Wed, 8 Jan 2020 12:42:17 -0800
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20200108202311.GA40461@romley-ivt3.sc.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Fenghua,

On 1/8/2020 12:23 PM, Fenghua Yu wrote:
> On Wed, Jan 08, 2020 at 09:07:41AM -0800, Shakeel Butt wrote:
>> Hi,
>>
>> Recently we had a bug in the system software writing the same pids to
>> the tasks file of resctrl group multiple times. The resctrl code
>> allocates "struct task_move_callback" for each such write and call
>> task_work_add() for that task to handle it on return to user-space
>> without checking if such request already exist for that particular
>> task. The issue arises for long sleeping tasks which has thousands for
>> such request queued to be handled. On our production, we notice
>> thousands of tasks having thousands of such requests and taking GiBs
>> of memory for "struct task_move_callback". I am not very familiar with
>> the code to judge if task_work_cancel() is the right approach or just
>> checking closid/rmid before doing task_work_add().
>>
> 
> Thank you for reporting the issue, Shakeel!
> 
> Could you please check if the following patch fixes the issue?
> From 3c23c39b6a44fdfbbbe0083d074dcc114d7d7f1c Mon Sep 17 00:00:00 2001
> From: Fenghua Yu <fenghua.yu@intel.com>
> Date: Wed, 8 Jan 2020 19:53:33 +0000
> Subject: [RFC PATCH] x86/resctrl: Fix redundant task movements
> 
> Currently a task can be moved to a rdtgroup multiple times.
> But, this can cause multiple task works are added, waste memory
> and degrade performance.
> 
> To fix the issue, only move the task to a rdtgroup when the task
> is not in the rdgroup. Don't try to move the task to the rdtgroup
> again when the task is already in the rdtgroup.
> 
> Reported-by: Shakeel Butt <shakeelb@google.com>
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> ---
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 2e3b06d6bbc6..75300c4a5969 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -546,6 +546,17 @@ static int __rdtgroup_move_task(struct task_struct *tsk,
>  	struct task_move_callback *callback;
>  	int ret;
>  
> +	/* If the task is already in rdtgrp, don't move the task. */
> +	if ((rdtgrp->type == RDTCTRL_GROUP && tsk->closid == rdtgrp->closid &&
> +	    tsk->rmid == rdtgrp->mon.rmid) ||
> +	    (rdtgrp->type == RDTMON_GROUP &&
> +	     rdtgrp->mon.parent->closid == tsk->closid &&
> +	     tsk->rmid == rdtgrp->mon.rmid)) {
> +		rdt_last_cmd_puts("Task is already in the rdgroup\n");
> +
> +		return -EINVAL;
> +	}
> +
>  	callback = kzalloc(sizeof(*callback), GFP_KERNEL);
>  	if (!callback)
>  		return -ENOMEM;
> 

I think your fix would address this specific use case but a slightly
different use case will still encounter the problem of high memory
consumption. If for example, sleeping tasks are moved (many times)
between resource or monitoring groups then their task_works queue would
just keep growing. It seems that a call to task_work_cancel() before
adding a new work item should address all these cases?

Reinette
