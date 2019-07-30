Return-Path: <SRS0=Iew4=V3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF51C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 08:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 758E420882
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jul 2019 08:23:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NzOWXb0f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730510AbfG3IXV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jul 2019 04:23:21 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:49650 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728901AbfG3IXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jul 2019 04:23:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=He46g3kl1/1+f74+KD+yC+jjKaZnawdh3B/wdfYNbj8=; b=NzOWXb0f5m8dKQbCqbMySPnBq
        uLhqkEdK8OOdPIsk6kG4QVH++UodNpFAwa8OjrmlafwmYcWrNsHtBBDFAGrkfZi1/bvnGuQg5EUx3
        VMEGkXzsUBVcYymFWu7dJcqcrxfDZlLOf3qBKaAV05z+Go8GTyqBlgVzXi9qdBfTqhNnbIjxJ6Bvu
        8M7WuJyYUWtJUbAxKjMQcUJQvDaHMEE/8/BYzFuYX1Am1IIF6oHcDBJltUVb1gLRuEL/Au1a6YyPU
        WXt2mdCJWER/TrLuTJSNNqDiBUiH4DE3edwA/P/3Q1vwPoscAJjiSLfL+IVnFN8pOJHqPzvW+p4Zk
        MxuF3ONgg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hsNPi-00089P-0A; Tue, 30 Jul 2019 08:23:18 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6BC3120D27EAD; Tue, 30 Jul 2019 10:23:16 +0200 (CEST)
Date:   Tue, 30 Jul 2019 10:23:16 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     luca abeni <luca.abeni@santannapisa.it>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Qais Yousef <Qais.Yousef@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] sched/deadline: Use return value of SCHED_WARN_ON()
 in bw accounting
Message-ID: <20190730082316.GK31381@hirez.programming.kicks-ass.net>
References: <20190726082756.5525-1-dietmar.eggemann@arm.com>
 <20190726082756.5525-6-dietmar.eggemann@arm.com>
 <20190726121819.32be6fb1@sweethome>
 <20190729165434.GO31398@hirez.programming.kicks-ass.net>
 <a12e2330-50d4-b31f-14b5-5b386252d418@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a12e2330-50d4-b31f-14b5-5b386252d418@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 29, 2019 at 05:59:04PM +0100, Dietmar Eggemann wrote:
> On 7/29/19 5:54 PM, Peter Zijlstra wrote:
> > On Fri, Jul 26, 2019 at 12:18:19PM +0200, luca abeni wrote:
> >> Hi Dietmar,
> >>
> >> On Fri, 26 Jul 2019 09:27:56 +0100
> >> Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
> >>
> >>> To make the decision whether to set rq or running bw to 0 in underflow
> >>> case use the return value of SCHED_WARN_ON() rather than an extra if
> >>> condition.
> >>
> >> I think I tried this at some point, but if I remember well this
> >> solution does not work correctly when SCHED_DEBUG is not enabled.
> > 
> > Well, it 'works' in so far that it compiles. But it might not be what
> > one expects. That is, for !SCHED_DEBUG the return value is an
> > unconditional false.
> > 
> > In this case I think that's fine, the WARN _should_ not be happending.
> 
> But there is commit 6d3aed3d ("sched/debug: Fix SCHED_WARN_ON() to
> return a value on !CONFIG_SCHED_DEBUG as well")?
> 
> But it doesn't work with !CONFIG_SCHED_DEBUG
> 
> What compiles and work is (at least on Arm64).
> 
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 4012f98b9d26..494a767a4091 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -78,7 +78,7 @@
>  #ifdef CONFIG_SCHED_DEBUG
>  # define SCHED_WARN_ON(x)      WARN_ONCE(x, #x)
>  #else
> -# define SCHED_WARN_ON(x)      ({ (void)(x), 0; })
> +# define SCHED_WARN_ON(x)      ({ (void)(x), x; })

Why doesn't the ,0 compile? That should work just fine. The thing is,
the two existing users:

kernel/sched/fair.c:            if (SCHED_WARN_ON(!se->on_rq))
kernel/sched/fair.c:            if (SCHED_WARN_ON(!se->on_rq))

seem to compile just fine with it.
