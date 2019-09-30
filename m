Return-Path: <SRS0=rUXN=XZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24961C4360C
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 07:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05A8221855
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Sep 2019 07:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729621AbfI3HMj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Sep 2019 03:12:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39526 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729503AbfI3HMj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Sep 2019 03:12:39 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 65E9581DE8
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 07:12:38 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id v13so4070354wrq.23
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2019 00:12:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FP2wpfwscfcrh0yIlqZA2JxYpIaHnNMXDCjv6Vl/UO4=;
        b=Q5CXxWAExkJoMME3hbvYRhFIZbhkbvNUwPCvX47lO+vF83K8TXTtr2uT7MSyKtbQmK
         KUUTwaPAHYoH0fh2aRYHAM0jEHTDttFIHpgrLhHgWM+0FDw3HaxRhCj6BxafdGhj9NBV
         084JujJWjVZKS3O9k5OoVLHGwO5yr4D9133vS+0R8A92/EtfqcpdAsClKqQAfrCcfLot
         ouRLtgxnZHLorPpE/csC2DgM2yV/fCBVstLeb+slPdrXNCZeRblJTF1A5U0ajpPIBLix
         1zTFKtlaUpQ0D54Z5lVJtL6+CoN7BZkjZ22Q7r1DLObXHb0/57VL4N0DnRgs8JasUxGQ
         Rxyw==
X-Gm-Message-State: APjAAAWs0AmM5qb567zQSD0bLU/dQh3ydsoSUExJX1HitGtLo+ZL5PXd
        vFsUI4+DyhPbRjaIkedY/SIwXEa5sgd4RQTesqDFVt5/GXCMIsaTebVVZawDJa9JpNoahvVkhiz
        5wvpqdNjNjNRCn6SFim79TdXd
X-Received: by 2002:a5d:5229:: with SMTP id i9mr12125129wra.76.1569827556940;
        Mon, 30 Sep 2019 00:12:36 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxqe8Praj1uJSmZ7eIEE3Q8SvPMygFHi5RgSDmrPqQs0SPp0+8YQOjPylVkznPdyq+Ndy9H1A==
X-Received: by 2002:a5d:5229:: with SMTP id i9mr12125104wra.76.1569827556644;
        Mon, 30 Sep 2019 00:12:36 -0700 (PDT)
Received: from localhost.localdomain ([151.29.237.241])
        by smtp.gmail.com with ESMTPSA id e18sm16747075wrv.63.2019.09.30.00.12.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Sep 2019 00:12:35 -0700 (PDT)
Date:   Mon, 30 Sep 2019 09:12:33 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Scott Wood <swood@redhat.com>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-kernel@vger.kernel.org, linux-rt-users@vger.kernel.org
Subject: Re: [PATCH RT 5/8] sched/deadline: Reclaim cpuset bandwidth in
 .migrate_task_rq()
Message-ID: <20190930071233.GE31660@localhost.localdomain>
References: <20190727055638.20443-1-swood@redhat.com>
 <20190727055638.20443-6-swood@redhat.com>
 <20190927081141.GB31660@localhost.localdomain>
 <9a4cc499e6de4690c682c03c0c880363fe3c9307.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a4cc499e6de4690c682c03c0c880363fe3c9307.camel@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/09/19 11:40, Scott Wood wrote:
> On Fri, 2019-09-27 at 10:11 +0200, Juri Lelli wrote:
> > Hi Scott,
> > 
> > On 27/07/19 00:56, Scott Wood wrote:
> > > With the changes to migrate disabling, ->set_cpus_allowed() no longer
> > > gets deferred until migrate_enable().  To avoid releasing the bandwidth
> > > while the task may still be executing on the old CPU, move the
> > > subtraction
> > > to ->migrate_task_rq().
> > > 
> > > Signed-off-by: Scott Wood <swood@redhat.com>
> > > ---
> > >  kernel/sched/deadline.c | 67 +++++++++++++++++++++++-------------------
> > > -------
> > >  1 file changed, 31 insertions(+), 36 deletions(-)
> > > 
> > > diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
> > > index c18be51f7608..2f18d0cf1b56 100644
> > > --- a/kernel/sched/deadline.c
> > > +++ b/kernel/sched/deadline.c
> > > @@ -1606,14 +1606,42 @@ static void yield_task_dl(struct rq *rq)
> > >  	return cpu;
> > >  }
> > >  
> > > +static void free_old_cpuset_bw_dl(struct rq *rq, struct task_struct *p)
> > > +{
> > > +	struct root_domain *src_rd = rq->rd;
> > > +
> > > +	/*
> > > +	 * Migrating a SCHED_DEADLINE task between exclusive
> > > +	 * cpusets (different root_domains) entails a bandwidth
> > > +	 * update. We already made space for us in the destination
> > > +	 * domain (see cpuset_can_attach()).
> > > +	 */
> > > +	if (!cpumask_intersects(src_rd->span, p->cpus_ptr)) {
> > > +		struct dl_bw *src_dl_b;
> > > +
> > > +		src_dl_b = dl_bw_of(cpu_of(rq));
> > > +		/*
> > > +		 * We now free resources of the root_domain we are migrating
> > > +		 * off. In the worst case, sched_setattr() may temporary
> > > fail
> > > +		 * until we complete the update.
> > > +		 */
> > > +		raw_spin_lock(&src_dl_b->lock);
> > > +		__dl_sub(src_dl_b, p->dl.dl_bw, dl_bw_cpus(task_cpu(p)));
> > > +		raw_spin_unlock(&src_dl_b->lock);
> > > +	}
> > > +}
> > > +
> > >  static void migrate_task_rq_dl(struct task_struct *p, int new_cpu
> > > __maybe_unused)
> > >  {
> > >  	struct rq *rq;
> > >  
> > > -	if (p->state != TASK_WAKING)
> > > +	rq = task_rq(p);
> > > +
> > > +	if (p->state != TASK_WAKING) {
> > > +		free_old_cpuset_bw_dl(rq, p);
> > 
> > What happens if a DEADLINE task is moved between cpusets while it was
> > sleeping? Don't we miss removing from the old cpuset if the task gets
> > migrated on wakeup?
> 
> In that case set_task_cpu() is called by ttwu after setting state to
> TASK_WAKING.

Right.

> I guess it could be annoying if the task doesn't wake up for a
> long time and therefore doesn't release the bandwidth until then.

Hummm, I was actually more worried about the fact that we call free_old_
cpuset_bw_dl() only if p->state != TASK_WAKING.
