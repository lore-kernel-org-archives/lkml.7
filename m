Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A10FC433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 14:33:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29D2D21726
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 14:33:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Q72XB1jM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394969AbfHBOdc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 10:33:32 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57368 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731131AbfHBOdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 10:33:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rgOIxhvmzzRkxe+QepP7XIs/hwgiVex6JxHcwodnLQc=; b=Q72XB1jMyU/8NpNSF0oqEApFU
        C3dplxXJ8GMS3HZ/CblmNC4cz2iNERozDXsBXwKF8s2FBPpU4yuprWjRcX/xuAXQzn1om/mAbg2tn
        hAhrV8oL9WK+PjWNxKjnlp2aYnyt8nnLEUJk89u9UTm7YgR8s+4/v6l3Y5hNec0wvFmEXVhK0YzA/
        tk1lpQ8dAV7BV6hi+OvQCWTW4HkfwknhGEGsNM+zY7VwPDbmYzIOOrRKw/DBU6S3xL2k2QVmxfjO/
        VZs4wnQmYF1pvMfitzd8Unku9K/Z8QWo5w7Vf2fnqe3VpUXILNSbfhgwjNVcyRxFlpdQaMPC9kbTG
        iTs83bTUA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1htYcY-0002kW-Lw; Fri, 02 Aug 2019 14:33:26 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6A501202953BA; Fri,  2 Aug 2019 16:33:24 +0200 (CEST)
Date:   Fri, 2 Aug 2019 16:33:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 0/5] Fix FIFO-99 abuse
Message-ID: <20190802143324.GH2332@hirez.programming.kicks-ass.net>
References: <20190801111348.530242235@infradead.org>
 <20190801131707.5rpyydznnhz474la@e107158-lin.cambridge.arm.com>
 <20190802093244.GF2332@hirez.programming.kicks-ass.net>
 <20190802102611.54sae3onftck5fye@e107158-lin.cambridge.arm.com>
 <20190802124151.GG2332@hirez.programming.kicks-ass.net>
 <20190802140854.ixq4cmo5nsfdaj24@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190802140854.ixq4cmo5nsfdaj24@e107158-lin.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 02, 2019 at 03:08:54PM +0100, Qais Yousef wrote:
> On 08/02/19 14:41, Peter Zijlstra wrote:
> > On Fri, Aug 02, 2019 at 11:26:12AM +0100, Qais Yousef wrote:
> > 
> > > Yes a somewhat enforced default makes more sense to me. I assume you no longer
> > > want to put the kthreads that just need to be above OTHER in FIFO-1?
> > 
> > I'm not sure, maybe, there's not that many of them, but possibly we add
> > another interface for them.
> 
> By the way, did you see this one which is set to priority 16?
> 
> https://elixir.bootlin.com/linux/v5.3-rc2/source/drivers/gpu/drm/msm/msm_drv.c#L523

I did, I ignored it because it wasn't 99 or something silly like that,
but I'd definitely mop it up when doing the proposed.

> > Also; like said before, the admin had better configure.
> 
> I agree. But I don't think an 'admin' is an easily defined entity for all
> systems. On mobile, is it the SoC vendor, Android framework, or the
> handset/platform vendor/integrator?

Mostly Android I suspect, but if SoC specific drivers have RT threads,
it's their responsibility to integrate properly with the rest of Android
of course.

> > Also also, RR-SMP is actually broken (and nobody has cared enough to
> > bother fixing it).
> 
> If you can give me enough pointers to understand the problem I might be able to
> bother with it :-)

So the push-pull balancer we have (designed for FIFO but also applied to
RR) will only move a task if the destination CPU has a lower prio.  In
the case where one CPU has 3 tasks and the other 1, and they're all the
same prio, it does nothing.  For FIFO that is fine, for RR, not so much.

Because then the one CPU will RR between 3 tasks, giving each task
1/3rd, while the other will only run the one task.

