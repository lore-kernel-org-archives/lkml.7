Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF820C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 14:41:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC11A20825
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 14:41:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfEGOlh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 10:41:37 -0400
Received: from mail.sssup.it ([193.205.80.98]:17999 "EHLO mail.santannapisa.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726444AbfEGOlh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 10:41:37 -0400
Received: from [83.43.182.198] (account l.abeni@santannapisa.it HELO nowhere)
  by santannapisa.it (CommuniGate Pro SMTP 6.1.11)
  with ESMTPSA id 138899014; Tue, 07 May 2019 16:41:35 +0200
Date:   Tue, 7 May 2019 16:41:27 +0200
From:   luca abeni <luca.abeni@santannapisa.it>
To:     Quentin Perret <quentin.perret@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Paul E . McKenney" <paulmck@linux.ibm.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Patrick Bellasi <patrick.bellasi@arm.com>,
        Tommaso Cucinotta <tommaso.cucinotta@santannapisa.it>
Subject: Re: [RFC PATCH 2/6] sched/dl: Capacity-aware migrations
Message-ID: <20190507164127.00cbaaec@nowhere>
In-Reply-To: <20190507141048.d45ia7qfytnfdhqc@queper01-lin>
References: <20190506044836.2914-1-luca.abeni@santannapisa.it>
        <20190506044836.2914-3-luca.abeni@santannapisa.it>
        <20190507141048.d45ia7qfytnfdhqc@queper01-lin>
Organization: Scuola Superiore S.Anna
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 7 May 2019 15:10:50 +0100
Quentin Perret <quentin.perret@arm.com> wrote:

> On Monday 06 May 2019 at 06:48:32 (+0200), Luca Abeni wrote:
> >  static inline unsigned long cpu_bw_dl(struct rq *rq)
> >  {
> > -	return (rq->dl.running_bw * SCHED_CAPACITY_SCALE) >>
> > BW_SHIFT;
> > +	unsigned long res;
> > +
> > +	res = (rq->dl.running_bw * SCHED_CAPACITY_SCALE) >>
> > BW_SHIFT; +
> > +	return (res << SCHED_CAPACITY_SHIFT) /
> > +	       arch_scale_cpu_capacity(NULL, rq->cpu);  
> 
> The only user of cpu_bw_dl() is schedutil right ? If yes, we probably
> don't want to scale things here -- schedutil already does this I
> believe.

I think I added this modification because I arrived to the conclusion
that schedutils does not perform this rescaling (at least, I think it
did not perform it when I wrote the patch :)


BTW, while re-reading the patch I do not understand why this change was
added in this specific patch... I suspect it should have gone in a
separate patch.



				Luca

> 
> Thanks,
> Quentin
> 
> >  }
> >  
> >  static inline unsigned long cpu_util_dl(struct rq *rq)
> > -- 
> > 2.20.1
> >   

