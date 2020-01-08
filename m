Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D87DC282DD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 13:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B730205F4
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 13:19:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aNGnhlCQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727706AbgAHNTa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jan 2020 08:19:30 -0500
Received: from merlin.infradead.org ([205.233.59.134]:36912 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726087AbgAHNT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jan 2020 08:19:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=QI9FSPKXEXNXCVFfcwps3NFfNhdiPjcAIviYkTvz5XY=; b=aNGnhlCQH3wcQ/6SaaEDBZ0o9
        smK8V1WVwtw9cLIh2ZUodoConiikHmgsE+yM+v/uBqMeaz1nBR11+yG8vzKHS3oc0PzIWGg7PniQs
        Tvg7wDyzYOqI5Nq4CCL3fAjSBfoVIxVcSPUwfWWkXc9d3wJ2rzxbllfn7fIPJWDdLQclYb27x9E17
        AqaBldmSd5VlsXqTZ3FUkysw2VlJD2JnPSGpvnk+1cDmpPwo1SEQuNR0AkpWRfrteQ3O1OUpchlAM
        lTjgejmIzzk41850EtH9GATefFAGQWaFyNOcE45Z8mb16DeuJvkL6bmmh7gPsMfIxP0RENeQQoxMW
        7VkECMrlQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ipBEj-0002PW-GY; Wed, 08 Jan 2020 13:19:01 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CD2BD300693;
        Wed,  8 Jan 2020 14:17:25 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C5D3320B79C81; Wed,  8 Jan 2020 14:18:58 +0100 (CET)
Date:   Wed, 8 Jan 2020 14:18:58 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>, Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Morten Rasmussen <Morten.Rasmussen@arm.com>,
        Hillf Danton <hdanton@sina.com>,
        Parth Shah <parth@linux.ibm.com>,
        Rik van Riel <riel@surriel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched, fair: Allow a small degree of load imbalance
 between SD_NUMA domains v2
Message-ID: <20200108131858.GZ2827@hirez.programming.kicks-ass.net>
References: <CAKfTPtDp624geHEnPmHki70L=ZrBuz6zJG3zW0VFy+_S064Etw@mail.gmail.com>
 <20200103143051.GA3027@techsingularity.net>
 <CAKfTPtCGm7-mq3duxi=ugy+mn=Yutw6w9c35+cSHK8aZn7rzNQ@mail.gmail.com>
 <20200106145225.GB3466@techsingularity.net>
 <CAKfTPtBa74nd4VP3+7V51Jv=-UpqNyEocyTzMYwjopCgfWPSXg@mail.gmail.com>
 <20200107095655.GF3466@techsingularity.net>
 <CAKfTPtAtJSWGPC1t+0xj_Daid0fZaWnN+b53WQ_a1-Js5fJ6sg@mail.gmail.com>
 <20200107115646.GI3466@techsingularity.net>
 <CAKfTPtAacdmxniM9yZUrQPW39LAvhpBQt6ZiGiwk5qpEx7zicA@mail.gmail.com>
 <20200107202406.GJ3466@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200107202406.GJ3466@techsingularity.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 07, 2020 at 08:24:06PM +0000, Mel Gorman wrote:
> Now I get you, but unfortunately it also would not work out. The number
> of groups is not related to the LLC except in some specific cases.
> It's possible to use the first CPU to find the size of an LLC but now I
> worry that it would lead to unpredictable behaviour. AMD has different
> numbers of LLCs per node depending on the CPU family and while Intel
> generally has one LLC per node, I imagine there are counter examples.

Intel has the 'fun' case of an LLC spanning nodes :-), although Linux
pretends this isn't so and truncates the LLC topology information to be
the node again -- see arch/x86/kernel/smpboot.c:match_llc().

And of course, in the Core2 era we had the Core2Quad chips which was a
dual-die solution and therefore also had multiple LLCs, and I think the
Xeon variant of that would allow the multiple LLC per node situation
too, although this is of course ancient hardware nobody really cares
about anymore.

> This means that load balancing on different machines with similar core
> counts will behave differently due to the LLC size.

That sounds like perfectly fine/expected behaviour to me.

> It might be possible
> to infer it if the intermediate domain was DIE instead of MC but I doubt
> that's guaranteed and it would still be unpredictable. It may be the type
> of complexity that should only be introduced with a separate patch with
> clear rationale as to why it's necessary and we are not at that threshold
> so I withdraw the suggestion.

So IIRC the initial patch(es) had the idea to allow for 1 extra task
imbalance to get 1-1 pairs on the same node, instead of across nodes. I
don't immediately see that in these later patches.

Would that be something to go back to? Would that not side-step much of
the issues under discussion here?
