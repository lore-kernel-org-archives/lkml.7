Return-Path: <SRS0=8hmg=W5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A83C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 14:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D7B12087E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Sep 2019 14:44:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731682AbfIBOo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Sep 2019 10:44:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46412 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726382AbfIBOo2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Sep 2019 10:44:28 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 04A7A10C6975;
        Mon,  2 Sep 2019 14:44:28 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.43.17.63])
        by smtp.corp.redhat.com (Postfix) with SMTP id 9F7FD5D9C3;
        Mon,  2 Sep 2019 14:44:25 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon,  2 Sep 2019 16:44:27 +0200 (CEST)
Date:   Mon, 2 Sep 2019 16:44:24 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Chris Metcalf <cmetcalf@ezchip.com>,
        Christoph Lameter <cl@linux.com>,
        Kirill Tkhai <tkhai@yandex.ru>, Mike Galbraith <efault@gmx.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] Use of probe_kernel_address() in task_rcu_dereference()
 without checking return value
Message-ID: <20190902144424.GB14770@redhat.com>
References: <20190830140805.GD13294@shell.armlinux.org.uk>
 <CAHk-=whuggNup=-MOS=7gBkuRqUigk7ABot_Pxi5koF=dM3S5Q@mail.gmail.com>
 <CAHk-=wiSFvb7djwa7D=-rVtnq3C5msh3u=CF7CVoU6hTJ=VdLw@mail.gmail.com>
 <20190830160957.GC2634@redhat.com>
 <CAHk-=wiZY53ac=mp8R0gjqyUd4ksD3tGHsUS9gvoHiJOT5_cEg@mail.gmail.com>
 <87o906wimo.fsf@x220.int.ebiederm.org>
 <20190902134003.GA14770@redhat.com>
 <20190902135315.GR2369@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190902135315.GR2369@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.65]); Mon, 02 Sep 2019 14:44:28 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/02, Peter Zijlstra wrote:
>
> On Mon, Sep 02, 2019 at 03:40:03PM +0200, Oleg Nesterov wrote:
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index 8dc1811..1f9b021 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -1134,7 +1134,10 @@ struct task_struct {
> >  
> >  	struct tlbflush_unmap_batch	tlb_ubc;
> >  
> > -	struct rcu_head			rcu;
> > +	union {
> > +		bool			xxx;
> > +		struct rcu_head		rcu;
> > +	};
> >  
> >  	/* Cache last used pipe for splice(): */
> >  	struct pipe_inode_info		*splice_pipe;
> > diff --git a/kernel/exit.c b/kernel/exit.c
> > index a75b6a7..baacfce 100644
> > --- a/kernel/exit.c
> > +++ b/kernel/exit.c
> > @@ -182,6 +182,11 @@ static void delayed_put_task_struct(struct rcu_head *rhp)
> >  	put_task_struct(tsk);
> >  }
> >  
> > +void call_delayed_put_task_struct(struct task_struct *p)
> > +{
> > +	if (xchg(&p->xxx, 1))
> > +		call_rcu(&p->rcu, delayed_put_task_struct);
> > +}
> 
> I think this is the first usage of xchg() on _Bool, also not all archs
> implement xchg8()

I didn't even notice I used "bool" ;)


speaking of the users of task_rcu_dereference(), membarrier_global_expedited()
does

		rcu_read_lock();
		p = task_rcu_dereference(&cpu_rq(cpu)->curr);
		if (p && p->mm && (atomic_read(&p->mm->membarrier_state) &
				   MEMBARRIER_STATE_GLOBAL_EXPEDITED)) {

This asks for READ_ONCE, but this is minor. Why can't p->mm be freed?

I guess it is fine to read the garbage from &p->mm->membarrier_state if we race
with the exiting task, but in theory this looks unsafe if CONFIG_DEBUG_PAGEALLOC.

Another possible user of probe_slab_address() or I am totally confused?

Oleg.

