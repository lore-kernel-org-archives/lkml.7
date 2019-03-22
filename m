Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F023C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BF15218A5
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 14:38:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729239AbfCVOiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 10:38:10 -0400
Received: from ms01.santannapisa.it ([193.205.80.98]:61456 "EHLO
        mail.santannapisa.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728114AbfCVOiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 10:38:10 -0400
Received: from [10.30.3.184] (account l.abeni@santannapisa.it HELO luca64)
  by santannapisa.it (CommuniGate Pro SMTP 6.1.11)
  with ESMTPSA id 137551599; Fri, 22 Mar 2019 15:38:06 +0100
Date:   Fri, 22 Mar 2019 15:38:01 +0100
From:   luca abeni <luca.abeni@santannapisa.it>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     "chengjian (D)" <cj.chengjian@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Li Bin <huawei.libin@huawei.com>,
        "Xiexiuqi (Xie XiuQi)" <xiexiuqi@huawei.com>, mingo@redhat.com,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: WARN ON at kernel/sched/deadline.c task_non_contending
Message-ID: <20190322153801.64e44cc9@luca64>
In-Reply-To: <20190322143232.GI8775@localhost.localdomain>
References: <dfb46874-3657-71c6-e068-9413ffe3f82e@huawei.com>
        <20190313154948.773427d6@luca64>
        <20190322143232.GI8775@localhost.localdomain>
Organization: Scuola Superiore S. Anna
X-Mailer: Claws Mail 3.17.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Juri,


On Fri, 22 Mar 2019 15:32:32 +0100 Juri Lelli <juri.lelli@redhat.com> wrote:
[...]
> > diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> > index 6a73e41a2016..43901fa3f269 100644
> > --- a/kernel/sched/deadline.c
> > +++ b/kernel/sched/deadline.c
> > @@ -252,7 +252,6 @@ static void task_non_contending(struct
> > task_struct *p) if (dl_entity_is_special(dl_se))
> >  		return;
> >  
> > -	WARN_ON(hrtimer_active(&dl_se->inactive_timer));
> >  	WARN_ON(dl_se->dl_non_contending);
> >  
> >  	zerolag_time = dl_se->deadline -
> > @@ -269,7 +268,7 @@ static void task_non_contending(struct
> > task_struct *p)
> >  	 * If the "0-lag time" already passed, decrease the active
> >  	 * utilization now, instead of starting a timer
> >  	 */
> > -	if (zerolag_time < 0) {
> > +	if ((zerolag_time < 0) ||
> > hrtimer_active(&dl_se->inactive_timer)) { if (dl_task(p))
> >  			sub_running_bw(dl_se, dl_rq);
> >  		if (!dl_task(p) || p->state == TASK_DEAD) {
> > 
> > 
> > The idea is that if the timer is active, we leave dl_non_contending
> > set to 0 (so that the timer handler does nothing), and we
> > immediately decrease the running bw.
> > I think this is OK, because this situation can happen only if the
> > task blocks, wakes up while the timer handler is running, and then
> > immediately blocks again - while the timer handler is still
> > running. So, the "zero lag time" cannot be too much in the future.  
> 
> And if we get here and the handler is running it means that the
> handler is spinning on rq->lock waiting the dequeue to release it.
> So, this looks safe to me as well.
> 
> BTW, I could reproduce with Steve's deadline_test [1], and this seems
> to fix it.
> 
> Would you mind sending out a proper patch Luca?

Thanks for looking at this. I'll try to prepare and send a patch in
next week.



			Thanks,
				Luca
