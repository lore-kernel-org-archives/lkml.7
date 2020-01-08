Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A4F2C282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 21:20:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE112206DB
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 21:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aNZGtxBY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbgAHVUc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 16:20:32 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:37550 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbgAHVUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 16:20:31 -0500
Received: by mail-ot1-f66.google.com with SMTP id k14so5053914otn.4
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jan 2020 13:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A/aXS1qLGDibVRdkVi6GYIjD5m+HHeNcu27hZr1t+qU=;
        b=aNZGtxBYzDmIjqGQjQevveb9QRM85kFUbWqMEMoB09HatUygttFI5JFklWmAZuJqEJ
         Vcp2fJP8kxiXcg7Um7zoQhwitaRkrlIquHfc+RpPdqKylF2wseN0ebM4qi0SVSFYU6E9
         fUGZ11IrzB7lK/+PiloxFguABLGxriEix4sN9FQK4w3ynjwY2d0atWcohIfylq3BMQeX
         hDeiOoDsZUJPG3RXJYTAuZRN/ORMZwn61kjc2TG2+Vc1RCDVNY7zrN/zesXzkXxrQ7dA
         LoKi69ADb7xFQJo+fnvJ7OubX6xDb2Ll/S4SEntJ5lTd/3sP0hByz41k9CFa43zLayZu
         8z3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A/aXS1qLGDibVRdkVi6GYIjD5m+HHeNcu27hZr1t+qU=;
        b=UAiGEUlBtU7Yg80Amy5palzp7NndJGx8IOjbaarXzDQnVeif1jw/0YlsP9VzotBLnM
         CWXAAiAZATzrvF4su7Li52+YXNHPGx1NYVMSfA/vhiP9LrAdvsJ1sOPqmp8wHl5SnEWk
         nMbKmkSV14M1wcf+/+dMEY7CY/MG2Fuxt317jnIv2IfvEO1XT8zYNRICHUzhV+0oQRfh
         FssS5stRr0BDywF68Do8x9VIMnfeT7W+fxtJPeLhYvfXkvWvsDMf6HWJ3I/W4NwsZFI9
         QwThARvlOetjJa0afydl2GPgBtifwpk/xpIcpTt9v9A6eQJ07LjOXCBXG7ILHsEDfe8A
         AJTQ==
X-Gm-Message-State: APjAAAXpwW1w1V1IkpalaVJ0welW1c+qgAV3gWWf1ocxNAxqvOjiIjtC
        KaCQ7qoooBjzeVHr9t4kZdU7CbrCBAmO4QXnVolBgQ==
X-Google-Smtp-Source: APXvYqxnmrBcWNB5RPfJZcymtk9+64ybsPXj8v7VzGwJTPAUFqlthr8krW6eDlElMyvGpUWuW1r3B8vwW45fNS9ldbE=
X-Received: by 2002:a9d:7c8a:: with SMTP id q10mr5296421otn.124.1578518430872;
 Wed, 08 Jan 2020 13:20:30 -0800 (PST)
MIME-Version: 1.0
References: <CALvZod7E9zzHwenzf7objzGKsdBmVwTgEJ0nPgs0LUFU3SN5Pw@mail.gmail.com>
 <20200108202311.GA40461@romley-ivt3.sc.intel.com>
In-Reply-To: <20200108202311.GA40461@romley-ivt3.sc.intel.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 8 Jan 2020 13:20:19 -0800
Message-ID: <CALvZod7qkn9OZUa0GLAyBv0QBt4A0=APdEqWp1RxMbok8mn03w@mail.gmail.com>
Subject: Re: [bug report] resctrl high memory comsumption
To:     Fenghua Yu <fenghua.yu@intel.com>
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 8, 2020 at 12:12 PM Fenghua Yu <fenghua.yu@intel.com> wrote:
>
> On Wed, Jan 08, 2020 at 09:07:41AM -0800, Shakeel Butt wrote:
> > Hi,
> >
> > Recently we had a bug in the system software writing the same pids to
> > the tasks file of resctrl group multiple times. The resctrl code
> > allocates "struct task_move_callback" for each such write and call
> > task_work_add() for that task to handle it on return to user-space
> > without checking if such request already exist for that particular
> > task. The issue arises for long sleeping tasks which has thousands for
> > such request queued to be handled. On our production, we notice
> > thousands of tasks having thousands of such requests and taking GiBs
> > of memory for "struct task_move_callback". I am not very familiar with
> > the code to judge if task_work_cancel() is the right approach or just
> > checking closid/rmid before doing task_work_add().
> >
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
>         struct task_move_callback *callback;
>         int ret;
>
> +       /* If the task is already in rdtgrp, don't move the task. */
> +       if ((rdtgrp->type == RDTCTRL_GROUP && tsk->closid == rdtgrp->closid &&
> +           tsk->rmid == rdtgrp->mon.rmid) ||
> +           (rdtgrp->type == RDTMON_GROUP &&
> +            rdtgrp->mon.parent->closid == tsk->closid &&
> +            tsk->rmid == rdtgrp->mon.rmid)) {
> +               rdt_last_cmd_puts("Task is already in the rdgroup\n");
> +
> +               return -EINVAL;

Why not just return success if the task is already in that group (i.e.
just follow the cgroup behavior).

> +       }
> +
>         callback = kzalloc(sizeof(*callback), GFP_KERNEL);
>         if (!callback)
>                 return -ENOMEM;
> --
> 2.19.1
>
