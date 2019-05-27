Return-Path: <SRS0=8QAT=T3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DADFC04AB3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 19:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D89B3208C3
	for <linux-kernel@archiver.kernel.org>; Mon, 27 May 2019 19:13:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eqbh6hPo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727363AbfE0TNe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 May 2019 15:13:34 -0400
Received: from merlin.infradead.org ([205.233.59.134]:42734 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726931AbfE0TNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 May 2019 15:13:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=p42wOqbmiOcQUVQ/fn8JBxhSR+tQHUoc/vHA5dGJ71w=; b=eqbh6hPozkwgb8cVeRg8k1p/8V
        zR8mrDsyfrNPGLzkY3k77q+Ln5YR5coD0Arms9YMm15uRbwl9vFeUOzJwm3//9bj6sUp+lJoCBfa+
        w6SnBvsXZlk4OYRe5+XI7RDAgm3Q+/okBiU5brPnwhXQt01U3XdJQ4YmrQr0Leo9eMndD2hT8QC5D
        VmLRzeH5qh9VO1dHPy7Fd7i35RThAW3ou+/QSVCLKVqTvgEkekMBQyr6dsRZkfAYEgWmGJpm+oRm+
        bt0RPCP/IysoD0PSm97cgPar+Okn88Hs/pggT7RhGJGcuYOxg58Nev8vKxRxENX1NJpdzDyL1h5y2
        oEt9cHRQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hVL3j-0005qe-1q; Mon, 27 May 2019 19:13:23 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 6EA3120301225; Mon, 27 May 2019 21:13:20 +0200 (CEST)
Date:   Mon, 27 May 2019 21:13:20 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Rik van Riel <riel@surriel.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] sched/fair: Rename weighted_cpuload() to cpu_load()
Message-ID: <20190527191320.GH2623@hirez.programming.kicks-ass.net>
References: <20190527062116.11512-1-dietmar.eggemann@arm.com>
 <20190527062116.11512-8-dietmar.eggemann@arm.com>
 <686351aab73911569a7c22a7e104d1b9f0d579b9.camel@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <686351aab73911569a7c22a7e104d1b9f0d579b9.camel@surriel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 27, 2019 at 12:24:07PM -0400, Rik van Riel wrote:
> On Mon, 2019-05-27 at 07:21 +0100, Dietmar Eggemann wrote:
> > This is done to align the per cpu (i.e. per rq) load with the util
> > counterpart (cpu_util(int cpu)). The term 'weighted' is not needed
> > since there is no 'unweighted' load to distinguish it from.
>=20
> I can see why you want to make cpu_util() and cpu_load()
> have the same parameter, but ...
>=20
> > @@ -7931,7 +7928,7 @@ static inline void update_sg_lb_stats(struct
> > lb_env *env,
> >  		if ((env->flags & LBF_NOHZ_STATS) &&
> > update_nohz_stats(rq, false))
> >  			env->flags |=3D LBF_NOHZ_AGAIN;
> > =20
> > -		sgs->group_load +=3D weighted_cpuload(rq);
> > +		sgs->group_load +=3D cpu_load(i);
> >  		sgs->group_util +=3D cpu_util(i);
> >  		sgs->sum_nr_running +=3D rq->cfs.h_nr_running;
>=20
> ... now we end up dereferencing cpu_rq(cpu) 3 times.
>=20
> I guess per-cpu variables are so cheap that we should
> never notice, but I thought I'd ask anyway while looking
> over these patches :)

I was going to say CSE should fix that, but then I noticed per_cpu
contains that hideous RELOC_HIDE() thing and I figure that might
confuse GCC enough to break that :/
