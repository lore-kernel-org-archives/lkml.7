Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8968AC0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 10:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B8252173E
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 10:31:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kzIjRgAo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403765AbfHHKbb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 06:31:31 -0400
Received: from merlin.infradead.org ([205.233.59.134]:52438 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389963AbfHHKba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 06:31:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=S6dz4OuUeCYqah686Q/y339f2z/tWRG5zuVCguFb5u8=; b=kzIjRgAow5/DsdSq8CfHseei2
        SGXRqgtoKyEbNwoNTqVKy7XQbopDg46kJEkOcCs1b+qNdveBRbvrx91pBnvxHGNE3sre8zeLhwayI
        P6jbILAaCkuLISlAgG0AMRtjPdWpJjfu7slA7EYA9mstSkqmCP8VgejZdf/BxGufIvfJ20atcJaWK
        MQe2WHMJNUfUV2sIH10N7c6lnNaiTMJwEIHbBBMAqhY47lBJgjgXeyxiC4E3vJ3tF+wtAIYgia7Qf
        j5htGgJJZJJAiaubMU8tcOyAFY4wq8ia7ry5HQWd8crK8GXSrTT4o+7vtBmJQdS8bTN257YB6uOwx
        /3ziglPiw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hvfhR-0000m6-Hz; Thu, 08 Aug 2019 10:31:13 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 5D26F307145;
        Thu,  8 Aug 2019 12:30:43 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 5BFAD20C3A774; Thu,  8 Aug 2019 12:31:09 +0200 (CEST)
Date:   Thu, 8 Aug 2019 12:31:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>, mingo@kernel.org,
        linux-kernel@vger.kernel.org, luca.abeni@santannapisa.it,
        bristot@redhat.com, balsini@android.com, dvyukov@google.com,
        tglx@linutronix.de, vpillai@digitalocean.com, rostedt@goodmis.org
Subject: Re: [RFC][PATCH 12/13] sched/deadline: Introduce deadline servers
Message-ID: <20190808103109.GF2369@hirez.programming.kicks-ass.net>
References: <20190726145409.947503076@infradead.org>
 <20190726161358.056107990@infradead.org>
 <34710762-f813-3913-0e55-fde7c91c6c2d@arm.com>
 <20190808075635.GB17205@worktop.programming.kicks-ass.net>
 <20cc05d3-0d0f-a558-2bbe-3b72527dd9bc@arm.com>
 <20190808084652.GG29310@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808084652.GG29310@localhost.localdomain>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 08, 2019 at 10:46:52AM +0200, Juri Lelli wrote:
> On 08/08/19 10:11, Dietmar Eggemann wrote:

> > What about the fast path in pick_next_task()?
> > 
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index bffe849b5a42..f1ea6ae16052 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -3742,6 +3742,9 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
> >                 if (unlikely(!p))
> >                         p = idle_sched_class.pick_next_task(rq, prev, rf);
> >  
> > +               if (p->sched_class == &fair_sched_class && p->server)
> > +                       p->server = NULL;
> > +
> 
> Hummm, but then who sets it back to the correct server. AFAIU
> update_curr() needs a ->server to do the correct DL accounting?

The above looks ok.

The pick_next_task_dl() when it selects a server will set ->server.

