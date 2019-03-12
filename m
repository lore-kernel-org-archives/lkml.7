Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8AB0C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 08:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DDBA217F4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 08:59:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727654AbfCLI7c convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 04:59:32 -0400
Received: from ms01.santannapisa.it ([193.205.80.98]:52354 "EHLO
        mail.santannapisa.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbfCLI7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 04:59:31 -0400
X-Greylist: delayed 3601 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Mar 2019 04:59:30 EDT
Received: from [10.1.195.109] (account l.abeni@santannapisa.it HELO nowhere)
  by santannapisa.it (CommuniGate Pro SMTP 6.1.11)
  with ESMTPSA id 137197463; Tue, 12 Mar 2019 08:59:27 +0100
Date:   Tue, 12 Mar 2019 08:59:22 +0100
From:   luca abeni <luca.abeni@santannapisa.it>
To:     "chengjian (D)" <cj.chengjian@huawei.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Li Bin <huawei.libin@huawei.com>,
        "Xiexiuqi (Xie XiuQi)" <xiexiuqi@huawei.com>, <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: WARN ON at kernel/sched/deadline.c task_non_contending
Message-ID: <20190312085922.13895cae@nowhere>
In-Reply-To: <dfb46874-3657-71c6-e068-9413ffe3f82e@huawei.com>
References: <dfb46874-3657-71c6-e068-9413ffe3f82e@huawei.com>
Organization: Scuola Superiore S.Anna
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

On Tue, 12 Mar 2019 10:03:12 +0800
"chengjian (D)" <cj.chengjian@huawei.com> wrote:

> Hi.
> 
> When looking to test SCHED_DEADLINE syzkaller report an warn in
> task_non_contending(). I tested the mainline kernel with the C program
> and captured the same call trace.
[...]
> diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> index 31c050a0d0ce..d73cb033a06d 100644
> --- a/kernel/sched/deadline.c
> +++ b/kernel/sched/deadline.c
> @@ -252,7 +252,6 @@ static void task_non_contending(struct
> task_struct *p) if (dl_entity_is_special(dl_se))
>                  return;
> 
> -       WARN_ON(hrtimer_active(&dl_se->inactive_timer));
>          WARN_ON(dl_se->dl_non_contending);
> 
>          zerolag_time = dl_se->deadline -
> @@ -287,7 +286,9 @@ static void task_non_contending(struct
> task_struct *p) }
> 
>          dl_se->dl_non_contending = 1;
> -       get_task_struct(p);
> +
> +       if (!hrtimer_active(&dl_se->inactive_timer));
> +               get_task_struct(p);
>          hrtimer_start(timer, ns_to_ktime(zerolag_time),
> HRTIMER_MODE_REL); }

At a first glance, I think the patch is OK, but I need some more time to
look at the details.

I'll run some experiments with the reproducer, and I'll let you know my
conclusions.


> Did I miss something ?
> 
> I saw it directly remove the hrtimer in hrtime_start() if hrtime is
> queued, it may be unsafe here when the timer handler is running.

This is probably why I added that WARN_ON()... I'll look at a possible
solution.



			Thanks,
				Luca


> 
> Help ?
> 
> I put the syzkaller log and C demo in attachments.
> 
> Thanks.
> 
> 
> 

