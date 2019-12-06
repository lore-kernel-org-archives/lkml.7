Return-Path: <SRS0=xBSd=Z4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A951CC2D0B1
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 10:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E5782464E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Dec 2019 10:15:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OeVd+Fz9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbfLFKPp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Dec 2019 05:15:45 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:55374 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726070AbfLFKPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Dec 2019 05:15:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=TFa41b48XR9/6cW6c+SDj5gyFppU1I0WqfMcJwu81kY=; b=OeVd+Fz9z/LKcG5x9rY57ZaPL
        m6FHesfGfs4Yg4kAsqYExhmxHpRrf9pfVebyLlhTlounCIRzD0Vn9rugOQVnbD2uOSNiPEOx+7Nmk
        4bdyrbnlFXrSkjcALvUSrZtJnuCulNhgUx28UdEqOW57CSOTg41y+MzI/AblLveXxsZ1Zujqm+9nF
        XT51s//fqz6I/3xUzcStTnEb7bhV+DrpS8j1zEZQTS2x6MWwFo/knqmcpu5n7O9UZtHNyBxzZgAV8
        80qAkyK4qu1j+zx4/lhFbPau7S5D8kpaptNuDVNOu63bvc5WnJ2Hku9sWEmpnP8qZmj9b+6W2EgBy
        9PsPMaRtw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1idAeF-0008Sj-SF; Fri, 06 Dec 2019 10:15:44 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 33390300DB7;
        Fri,  6 Dec 2019 11:14:23 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B258A2006F795; Fri,  6 Dec 2019 11:15:40 +0100 (CET)
Date:   Fri, 6 Dec 2019 11:15:40 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Running an Ivy Bridge cpu at fixed frequency
Message-ID: <20191206101540.GB2844@hirez.programming.kicks-ass.net>
References: <8eeee0695c664305ba6a56bce42a995f@AcuMS.aculab.com>
 <20191205094535.GF2810@hirez.programming.kicks-ass.net>
 <df5b67c5f51b48c391480358d6af53ca@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df5b67c5f51b48c391480358d6af53ca@AcuMS.aculab.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 05, 2019 at 03:53:55PM +0000, David Laight wrote:
> From: Peter Zijlstra
> > Sent: 05 December 2019 09:46
> > As Andy already wrote, perf is really good for this.
> > 
> > Find attached, it probably is less shiny than what Andy handed you, but
> > contains all the bits required to frob something.
> 
> You are in a maze of incomplete documentation all disjoint.

I'm sure..

> The x86 instruction set doc (eg 325462.pdf) defines the rdpmc instruction, tells you
> how many counters each cpu type has, but doesn't even contain a reference
> to how they are incremented.

There's book 3, chapter 18, performance monitoring overview, that should
explain how the counters work, and chapter 19 that lists many of the
available events.

TL;DR, they're (48bit) signed counters that increment and raise an
interrupt when the sign flips. This means we set them to '-period' and
then upon read (either early or on interrupt) compute the delta and
accumulate elsewhere.

> perf_event_open(2) tells you a few things, but doesn't actually what anything is.
> It contains all but the last 'if' clause of this function, without really saying
> what any of it does - or why you might do it this way.

I don't actually know what's in that manpage. But it really shouldn't be
too hard to understand.

It's a seqcount protected set of value, there's the RDPMC counter index,
and the counter offset. If the idx!=0 it means the counter is actually
programmed and we must RDPMC, the result of which we must add to the
offset.

The whole counter scaling crud is just that, crud you can mostly forget
about if you want to quickly hack something together. See
mmap_read_pinned() for the simplified (and much faster version) that
ignores all that.


> AFAICT:
> 1) The last clause is scaling the count up to allow for time when the hardware counter
>    couldn't be allocated.
>    I'm not convinced that is useful, better to ignore the entire measurement.
>    Half this got deleted from the man page, leaving strange 'set but unused' variables.

Depending on the usecase, sure. I don't mave use for it either. I know
other people find it useful.

> 2) The hardware counters are disabled while the process is asleep.
>    On wake a different pmc counter might be used (maybe on a different cpu).
>    The new cpu might not even have a counter available.

Right, but if this is all you're running that is unlikely to happen.

> 3) If you don't want to scale up for missing periods it is probably enough to do:
> 	do {
> 		seq = pc->offset;
> 		barrier();
> 		idx = pc->index;
> 		if (!index)
> 			return -1;
> 		count = pc->offset + rdpmc(idx - 1);
> 	} while (seq != pc->seq);
> 	return (unsigned int)count;

You still need to do the rdpmc sign extent crud, but see
mmap_read_pinned() that does just about that.

As the name suggests it relies on using perf_event_attr::pinned = 1.

