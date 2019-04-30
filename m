Return-Path: <SRS0=DLm5=TA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE9D2C43219
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 12:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF66C205ED
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Apr 2019 12:12:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ip3SQRAE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727251AbfD3MMG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Apr 2019 08:12:06 -0400
Received: from merlin.infradead.org ([205.233.59.134]:36548 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbfD3MMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 08:12:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=7qQfUICH5ThnTASCph/ZFazPjhwDVaINTXgbGNuii3s=; b=Ip3SQRAEGBB/8yNwpoUc+vXIP
        PrAq/6zhGfvp21wgXfzhmsvABXgjF/X+6yrY4KLakgDggT/Lc9MnfsPRyztLKeUk+5AOsF8VR+hDk
        x6Ymg6arDLAU4Nl2T3sskvJvzToimbfO4OThXTOerTgrpKGL3gSTu6FN4SY1Pr9Ctgk2l3sfEDEhQ
        Ws/QWSkVQYPZg4V/wFgD0zi2Nl25hHntFX1e+pyLLp48HI/VWppkuSRkQgGXxAqGqWcxLW3rqFVUX
        fr2K4eZNqQSqfQ0RYpA3H/H5Rijna47+ACME8C5bNcOqkTjh5Nq76/ZhBoEC1DAIIHbw74T7AQRIJ
        oVVtd4EnQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hLRbx-0000kk-GH; Tue, 30 Apr 2019 12:11:49 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 36AE0203C05DB; Tue, 30 Apr 2019 14:11:48 +0200 (CEST)
Date:   Tue, 30 Apr 2019 14:11:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yuyang Du <duyuyang@gmail.com>
Cc:     will.deacon@arm.com, Ingo Molnar <mingo@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>, ming.lei@redhat.com,
        Frederic Weisbecker <frederic@kernel.org>, tglx@linutronix.de,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 19/28] locking/lockdep: Optimize irq usage check when
 marking lock usage bit
Message-ID: <20190430121148.GV2623@hirez.programming.kicks-ass.net>
References: <20190424101934.51535-1-duyuyang@gmail.com>
 <20190424101934.51535-20-duyuyang@gmail.com>
 <20190425193247.GU12232@hirez.programming.kicks-ass.net>
 <CAHttsrY4jK2cayBE8zNCSJKDAkzLiBb40GVfQHpJi2YK1nEZaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHttsrY4jK2cayBE8zNCSJKDAkzLiBb40GVfQHpJi2YK1nEZaQ@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 02:57:37PM +0800, Yuyang Du wrote:
> Thanks for review.
> 
> On Fri, 26 Apr 2019 at 03:32, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Wed, Apr 24, 2019 at 06:19:25PM +0800, Yuyang Du wrote:
> >
> > After only a quick read of these next patches; this is the one that
> > worries me most.
> >
> > You did mention Frederic's patches, but I'm not entirely sure you're
> > aware why he's doing them. He's preparing to split the softirq state
> > into one state per softirq vector.
> >
> > See here:
> >
> >   https://lkml.kernel.org/r/20190228171242.32144-14-frederic@kernel.org
> >   https://lkml.kernel.org/r/20190228171242.32144-15-frederic@kernel.org
> >
> > IOW he's going to massively explode this storage.
> 
> If I understand correctly, he is not going to.
> 
> First of all, we can divide the whole usage thing into tracking and checking.
> 
> Frederic's fine-grained soft vector state is applied to usage
> tracking, i.e., which specific vectors a lock is used or enabled.
> 
> But for usage checking, which vectors are does not really matter. So,
> the current size of the arrays and bitmaps are good enough. Right?

Frederic? My understanding was that he really was going to split the
whole thing. The moment you allow masking individual soft vectors, you
get per-vector dependency chains.
