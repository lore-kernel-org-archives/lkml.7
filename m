Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3AA0C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 14:49:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A1D1214AE
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 14:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726339AbfCMOt4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 10:49:56 -0400
Received: from ms01.santannapisa.it ([193.205.80.98]:53901 "EHLO
        mail.santannapisa.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbfCMOt4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 10:49:56 -0400
Received: from [10.30.3.156] (account l.abeni@santannapisa.it HELO luca64)
  by santannapisa.it (CommuniGate Pro SMTP 6.1.11)
  with ESMTPSA id 137252577; Wed, 13 Mar 2019 15:49:52 +0100
Date:   Wed, 13 Mar 2019 15:49:48 +0100
From:   luca abeni <luca.abeni@santannapisa.it>
To:     "chengjian (D)" <cj.chengjian@huawei.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Li Bin <huawei.libin@huawei.com>,
        "Xiexiuqi (Xie XiuQi)" <xiexiuqi@huawei.com>, <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>
Subject: Re: WARN ON at kernel/sched/deadline.c task_non_contending
Message-ID: <20190313154948.773427d6@luca64>
In-Reply-To: <dfb46874-3657-71c6-e068-9413ffe3f82e@huawei.com>
References: <dfb46874-3657-71c6-e068-9413ffe3f82e@huawei.com>
Organization: Scuola Superiore S. Anna
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

(I added Juri in cc)

On Tue, 12 Mar 2019 10:03:12 +0800
"chengjian (D)" <cj.chengjian@huawei.com> wrote:
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

After looking at the patch a little bit more and running some tests,
I suspect this solution might be racy:
when the timer is already active, (and hrtimer_start() fails), it
relies on its handler to decrease the running bw (by setting
dl_non_contending to 1)... But inactive_task_timer() might have
already checked dl_non_contending, finding it equal to 0 (so, it
ends up doing nothing and the running bw is not decreased).


So, I would prefer a different solution. I think this patch should work:

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 6a73e41a2016..43901fa3f269 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -252,7 +252,6 @@ static void task_non_contending(struct task_struct *p)
 	if (dl_entity_is_special(dl_se))
 		return;
 
-	WARN_ON(hrtimer_active(&dl_se->inactive_timer));
 	WARN_ON(dl_se->dl_non_contending);
 
 	zerolag_time = dl_se->deadline -
@@ -269,7 +268,7 @@ static void task_non_contending(struct task_struct *p)
 	 * If the "0-lag time" already passed, decrease the active
 	 * utilization now, instead of starting a timer
 	 */
-	if (zerolag_time < 0) {
+	if ((zerolag_time < 0) || hrtimer_active(&dl_se->inactive_timer)) {
 		if (dl_task(p))
 			sub_running_bw(dl_se, dl_rq);
 		if (!dl_task(p) || p->state == TASK_DEAD) {


The idea is that if the timer is active, we leave dl_non_contending set to
0 (so that the timer handler does nothing), and we immediately decrease the
running bw.
I think this is OK, because this situation can happen only if the task
blocks, wakes up while the timer handler is running, and then immediately
blocks again - while the timer handler is still running. So, the "zero lag
time" cannot be too much in the future.


			Thanks,
				Luca
