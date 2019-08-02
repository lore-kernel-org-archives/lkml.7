Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74B66C32750
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47B1020679
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 09:40:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GoQZna+i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731061AbfHBJcz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 05:32:55 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:47558 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390208AbfHBJcx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 05:32:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=VqZFWxYVaUyhcuckDh3toTCzxHPZyFXRQKZUhqggFXI=; b=GoQZna+i55ANnp670+KAk3j4T
        9iUvNxWhNh4GE989znF+XY5olW08Wy3IhDB8tCUij90HkRkVUxM1qrKT+GTC7xCp+T31aLPdF+1DQ
        f+tmPXYCr5/Xs0iyB+Iz0zEJ8TAY3KNgMaYHgXt7bbN3XF+m9CtaKhgKX0/6zeMUQijY9HZ6h1Uv5
        yNVg/1bp0jvtQAQI3dC0MSvCYD+w/koQ6FkNtC3o6SHCbuUYOFIyyipCW1yKD3/J0vfvV9ZDlnuO7
        RJhmpTQi1w/wacf2gqAp+z9qt+wg/ib3ODK8iJEZ0fG7NruEkvEDTY/iHi78e5v7RsGZOrzqRjBdd
        PM4KuTLow==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1htTva-00016v-F3; Fri, 02 Aug 2019 09:32:46 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1C4492029F4CB; Fri,  2 Aug 2019 11:32:44 +0200 (CEST)
Date:   Fri, 2 Aug 2019 11:32:44 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/5] Fix FIFO-99 abuse
Message-ID: <20190802093244.GF2332@hirez.programming.kicks-ass.net>
References: <20190801111348.530242235@infradead.org>
 <20190801131707.5rpyydznnhz474la@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190801131707.5rpyydznnhz474la@e107158-lin.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2019 at 02:17:07PM +0100, Qais Yousef wrote:
> On 08/01/19 13:13, Peter Zijlstra wrote:
> > I noticed a bunch of kthreads defaulted to FIFO-99, fix them.
> > 
> > The generic default is FIFO-50, the admin will have to configure the system
> > anyway.
> > 
> > For some the purpose is to be above OTHER and then FIFO-1 really is sufficient.
> 
> I was looking in this area too and was thinking of a way to consolidate the
> creation of RT/DL tasks in the kernel and the way we set the priority.
> 
> Does it make sense to create a new header for RT priorities for kthreads
> created in the kernel so that we can easily track and rationale about the
> relative priorities of in-kernel RT tasks?
> 
> When working in the FW world such a header helped a lot in understanding what
> runs at each priority level and how to reason about what priority level makes
> sense for a new item. It could be a nice single point of reference; even for
> admins.

Well, SCHED_FIFO is a broken scheduler model; that is, it is
fundamentally incapable of resource management, which is the one thing
an OS really should be doing.

This is of course the reason it is limited to privileged users only.

Worse still; it is fundamentally impossible to compose static priority
workloads. You cannot take two correctly working static prio workloads
and smash them together and still expect them to work.

For this reason 'all' FIFO tasks the kernel creates are basically at:

  MAX_RT_PRIO / 2

The administrator _MUST_ configure the system, the kernel simply doesn't
know enough information to make a sensible choice.

Now, Geert suggested so make make a define for that, but how about we do
something like:

/*
 * ${the above explanation}
 */
int kernel_setscheduler_fifo(struct task_struct *p)
{
	struct sched_param sp = { .sched_priority = MAX_RT_PRIO / 2 };
	return sched_setscheduler_nocheck(p, SCHED_FIFO, &sp);
}

And then take away sched_setscheduler*().
