Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ADA6C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 10:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BB73207E0
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 10:10:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726530AbfCJKKJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 06:10:09 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:36357 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725840AbfCJKKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 06:10:08 -0400
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h2vOz-0007aL-NW; Sun, 10 Mar 2019 11:09:53 +0100
Date:   Sun, 10 Mar 2019 11:09:53 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
cc:     mingo@kernel.org, kjlu@umn.edu, hpa@zytor.com,
        stable@vger.kernel.org, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org
Subject: Re: [tip:sched/core] sched/core: Fix a potential double-fetch bug
 in sched_copy_attr()
In-Reply-To: <alpine.DEB.2.21.1901281409570.1560@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1903101105500.1646@nanos.tec.linutronix.de>
References: <20190109074524.10176-1-kjlu@umn.edu> <tip-120e4e76857ddbc9268e1aa3f9de61a498e84618@git.kernel.org> <alpine.DEB.2.21.1901271201170.1622@nanos.tec.linutronix.de> <20190128075817.GE4500@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1901281409570.1560@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Jan 2019, Thomas Gleixner wrote:
> On Mon, 28 Jan 2019, Peter Zijlstra wrote:
> > On Sun, Jan 27, 2019 at 12:04:44PM +0100, Thomas Gleixner wrote:
> > > On Mon, 21 Jan 2019, tip-bot for Kangjie Lu wrote:
> > > > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > > > index a674c7db2f29..d4d3514c4fe9 100644
> > > > --- a/kernel/sched/core.c
> > > > +++ b/kernel/sched/core.c
> > > > @@ -4499,6 +4499,9 @@ static int sched_copy_attr(struct sched_attr __user *uattr, struct sched_attr *a
> > > >  	if (ret)
> > > >  		return -EFAULT;
> > > >  
> > > > +	/* In case attr->size was changed by user-space: */
> > > > +	attr->size = size;
> > > > +
> > > 
> > > Just when pondering to send that to Linus, I tried to write up a concise
> > > summary for this which made me look at the patch.
> > > 
> > > If the size changed, then its clear that user space fiddled with the date
> > > between the size fetch and the full copy from user. So why restoring the
> > > size instead of doing the obvious:
> > > 
> > >    	 if (attr->size != size)
> > > 	 	return -ECRAP;
> > > 
> > > Hmm?
> > 
> > Sure; but if we do that we should also change perf_copy_attr() which has
> > the exact same thing.
> 
> Yes please.
> 
> The point is that by default the data passed to a function (and it does not
> matter whether it's a syscall) by pointer is immutable. There is exactly
> ONE syscall which is specifically designed to deal with mutable data and
> that's a constant source of headache ....
> 
> Kangjie is right that all double fetch operations like the one in
> sched_copy_attr() are prone to concurrent modification problems. But then
> we really should say NO instead of silently trying to fix things up. I
> personally would even kill the process immediately, no matter whether the
> corruption is caused by malicious intent or by sheer stupidity.

Just noticed that this fell through the cracks. Is anyone working on a fix
for this?

Thanks,

	tglx
