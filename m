Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD80C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 10:00:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71C172465E
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 10:00:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="liu0G248"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbfLTKAv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 05:00:51 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40686 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727125AbfLTKAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 05:00:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wboPPEei1XiVNkDt31D2yRaQW4+eIhEEINuouiM8mHs=; b=liu0G248vBLt3Qt+Ml3sDhNlh
        tezLJ/pa61Z8Xhs06DZMX2gql+tWaeJboBSKoye+Cf/KqEe6UcMQgD7mdk7HHAvfE1Vx+0Qy5vNyx
        jb0/gzwzvmXPtG5N+uScPU15AFjkkebxz+Y7bi4RLxv2I4JToK0A5KskndSo5xPi/fsDQ7EAVvhfy
        0yRFFhuer/eFrSSJ3w3iDwIAR6J1qkxRzdv2vlaz1CswR3UTbw0Dz0gnWmh+RkO20VsOPVX31ylRg
        na/Zpukcnils7eh9/A4Tjw3ZscY9TNX6ApjU4/KOIjTF8CqhqacmwK/L7mLR2wcSK0BTpQIAkT4IB
        7UAbmeVsw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iiF5I-0004aP-Pv; Fri, 20 Dec 2019 10:00:36 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 03A5D30073C;
        Fri, 20 Dec 2019 10:59:09 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id E05A72B4061B0; Fri, 20 Dec 2019 11:00:33 +0100 (CET)
Date:   Fri, 20 Dec 2019 11:00:33 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        Kirill Tkhai <tkhai@yandex.ru>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "bsegall@google.com" <bsegall@google.com>,
        "mgorman@suse.de" <mgorman@suse.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [RFC][PATCH 1/4] sched: Force the address order of each sched
 class descriptor
Message-ID: <20191220100033.GE2844@hirez.programming.kicks-ass.net>
References: <20191219214451.340746474@goodmis.org>
 <20191219214558.510271353@goodmis.org>
 <0a957e8d-7af8-613c-11ae-f51b9b241eb7@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a957e8d-7af8-613c-11ae-f51b9b241eb7@rasmusvillemoes.dk>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 20, 2019 at 09:52:37AM +0100, Rasmus Villemoes wrote:
> On 19/12/2019 22.44, Steven Rostedt wrote:
> > From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> > 
> > In order to make a micro optimization in pick_next_task(), the order of the
> > sched class descriptor address must be in the same order as their priority
> > to each other. That is:
> > 
> >  &idle_sched_class < &fair_sched_class < &rt_sched_class <
> >  &dl_sched_class < &stop_sched_class
> > 
> > In order to guarantee this order of the sched class descriptors, add each
> > one into their own data section and force the order in the linker script.
> 
> I think it would make the code simpler if one reverses these, see other
> reply.

I started out agreeing, because of that mess around STOP_SCHED_CLASS and
that horrid BEFORE_CRUD thing.

Then, when I fixed it all up, I saw what it did to Kyrill's patch (#4)
and that ends up looking like:

-       if (likely((prev->sched_class == &idle_sched_class ||
-                   prev->sched_class == &fair_sched_class) &&
+       if (likely(prev->sched_class >= &fair_sched_class &&

And that's just weird.

Then I had a better look and now...

> > +/*
> > + * The order of the sched class addresses are important, as they are
> > + * used to determine the order of the priority of each sched class in
> > + * relation to each other.
> > + */
> > +#define SCHED_DATA				\
> > +	*(__idle_sched_class)			\
> > +	*(__fair_sched_class)			\
> > +	*(__rt_sched_class)			\
> > +	*(__dl_sched_class)			\
> > +	STOP_SCHED_CLASS

I'm confused, why does that STOP_SCHED_CLASS need magic here at all?
Doesn't the linker deal with empty sections already by making them 0
sized?

> >  /*
> >   * Align to a 32 byte boundary equal to the
> >   * alignment gcc 4.5 uses for a struct
> > @@ -308,6 +326,7 @@
> >  #define DATA_DATA							\
> >  	*(.xiptext)							\
> >  	*(DATA_MAIN)							\
> > +	SCHED_DATA							\
> >  	*(.ref.data)							\
> 
> Doesn't this make the structs end up in .data (writable) rather than
> .rodata?

Right! That wants fixing.
