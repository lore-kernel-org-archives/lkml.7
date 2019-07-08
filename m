Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2C10C48BE7
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 08:41:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B476B2064B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 08:41:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729301AbfGHIls (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 04:41:48 -0400
Received: from mail.santannapisa.it ([193.205.80.98]:30743 "EHLO
        mail.santannapisa.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727976AbfGHIls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 04:41:48 -0400
X-Greylist: delayed 3600 seconds by postgrey-1.27 at vger.kernel.org; Mon, 08 Jul 2019 04:41:46 EDT
Received: from [151.41.66.174] (account l.abeni@santannapisa.it HELO sweethome)
  by santannapisa.it (CommuniGate Pro SMTP 6.1.11)
  with ESMTPSA id 140626216; Mon, 08 Jul 2019 09:41:44 +0200
Date:   Mon, 8 Jul 2019 09:41:36 +0200
From:   luca abeni <luca.abeni@santannapisa.it>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Quentin Perret <quentin.perret@arm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>
Subject: Re: [RFC PATCH 2/6] sched/dl: Capacity-aware migrations
Message-ID: <20190708094136.7bce5f46@sweethome>
In-Reply-To: <b920d85b-4228-52fd-22db-3a0c26cf8ebd@arm.com>
References: <20190506044836.2914-1-luca.abeni@santannapisa.it>
        <20190506044836.2914-3-luca.abeni@santannapisa.it>
        <b920d85b-4228-52fd-22db-3a0c26cf8ebd@arm.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dietmar,

On Thu, 4 Jul 2019 14:05:22 +0200
Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:

> On 5/6/19 6:48 AM, Luca Abeni wrote:
> 
> [...]
> 
> > diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> > index 5b981eeeb944..3436f3d8fa8f 100644
> > --- a/kernel/sched/deadline.c
> > +++ b/kernel/sched/deadline.c
> > @@ -1584,6 +1584,9 @@ select_task_rq_dl(struct task_struct *p, int
> > cpu, int sd_flag, int flags) if (sd_flag != SD_BALANCE_WAKE)
> >  		goto out;
> >  
> > +	if (dl_entity_is_special(&p->dl))
> > +		goto out;  
> 
> I wonder if this is really required. The if condition
> 
> 1591         if (unlikely(dl_task(curr)) &&
> 1592             (curr->nr_cpus_allowed < 2 ||
> 1593              !dl_entity_preempt(&p->dl, &curr->dl)) &&
> 1594             (p->nr_cpus_allowed > 1)) {
> 
> further below uses '!dl_entity_preempt(&p->dl, &curr->dl))' which
> returns 'dl_entity_is_special(a) || ...'

Uhm... I do not remember the details; I remember that the check fixed
something during the development of the patchset, but I did not check
if it was still needed when I forward-ported the patches...

So, maybe it worked around some bugs in previous versions of the
kernel, but is not needed now.



				Luca
