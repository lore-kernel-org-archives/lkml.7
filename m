Return-Path: <SRS0=K12x=T4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E32C04AB6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 10:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B5B082070D
	for <linux-kernel@archiver.kernel.org>; Tue, 28 May 2019 10:53:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YKs28hvJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfE1Kxb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 May 2019 06:53:31 -0400
Received: from merlin.infradead.org ([205.233.59.134]:48434 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbfE1Kxb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 May 2019 06:53:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=rB9rrnpARXQkc5fberxbJPE/xh3fmIg0x0UG52AxXP4=; b=YKs28hvJyv3gyvK+hty98NGNe
        DLsDNV2SrXOuYnF7ikO7js1hf/TfhoJDY9O0M9vTPDKV/P5kiFJHpFrAH6x/03EqfRAWj2WLjMJ3a
        IXbmLzLxax6uhWFHfbnpnkXcE8+nmbR1CpGyfo0q62ykbdaNU0EB5kewaCoi/I/u6eLD4RoJEB25P
        UREoDW0DSkVmXN5N31KVAACqSDG8WJcn+1abTe8Q0ZtQxULiIaStytVTE8N2PqnDW93hYFBO1cMeO
        EKFOgdvKK9PF63LxxZ1IQN8kWsRtfTFkxEDNTh4Hwd6dXGsifcJv97mPxDhyifAxqXVGHbbs8Aykm
        pTZPmZppQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=hirez.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hVZjF-0002nO-Nv; Tue, 28 May 2019 10:53:13 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 376EE2074C65D; Tue, 28 May 2019 12:53:12 +0200 (CEST)
Date:   Tue, 28 May 2019 12:53:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Hillf Danton <hdanton@sina.com>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Rik van Riel <riel@surriel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Quentin Perret <quentin.perret@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/7] sched/fair: Replace source_load() & target_load() w/
 weighted_cpuload()
Message-ID: <20190528105312.GO2623@hirez.programming.kicks-ass.net>
References: <20190527062116.11512-1-dietmar.eggemann@arm.com>
 <20190527062116.11512-3-dietmar.eggemann@arm.com>
 <63ee8775-f159-e172-15f4-2ddf941870ee@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63ee8775-f159-e172-15f4-2ddf941870ee@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 28, 2019 at 12:24:52PM +0200, Dietmar Eggemann wrote:
> On 5/28/19 6:42 AM, Hillf Danton wrote:
> > 
> > On Mon, 27 May 2019 07:21:11 +0100 Dietmar Eggemann wrote:
> 
> [...]
> 
> > > @@ -5500,7 +5464,7 @@ wake_affine_weight(struct sched_domain *sd, struct task_struct *p,
> > >   		this_eff_load *= 100;
> > >   	this_eff_load *= capacity_of(prev_cpu);
> > > -	prev_eff_load = source_load(prev_cpu, sd->wake_idx);
> > > +	prev_eff_load = weighted_cpuload(cpu_rq(this_cpu));
> > 					 cpu_rq(prev_cpu)
> > 
> > Seems we have no need to see this cpu's load more than once.
> 
> Thanks for catching this! Will fix it in v2.

Fixed :-)
