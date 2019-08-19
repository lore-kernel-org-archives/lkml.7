Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D470C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 20:29:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3D3B22CE8
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 20:29:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbfHSU3R (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 16:29:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49366 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727988AbfHSU3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 16:29:17 -0400
Received: from pd9ef1cb8.dip0.t-ipconnect.de ([217.239.28.184] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hzoHC-00041V-LQ; Mon, 19 Aug 2019 22:29:14 +0200
Date:   Mon, 19 Aug 2019 22:29:13 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ingo Molnar <mingo@kernel.org>
cc:     LKML <linux-kernel@vger.kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: Re: [patch 38/44] posix-cpu-timers: Respect INFINITY for hard RTTIME
 limit
In-Reply-To: <20190819200650.GE68079@gmail.com>
Message-ID: <alpine.DEB.2.21.1908192225350.4008@nanos.tec.linutronix.de>
References: <20190819143141.221906747@linutronix.de> <20190819143805.022020654@linutronix.de> <20190819200650.GE68079@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Aug 2019, Ingo Molnar wrote:
> * Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> > The RTIME limit expiry code does not check the hard RTTIME limit for
> > INFINITY, i.e. being disabled.  Add it.
> > 
> > Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> > ---
> >  kernel/time/posix-cpu-timers.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > --- a/kernel/time/posix-cpu-timers.c
> > +++ b/kernel/time/posix-cpu-timers.c
> > @@ -905,7 +905,7 @@ static void check_process_timers(struct
> >  		u64 softns, ptime = samples[CPUCLOCK_PROF];
> >  		unsigned long psecs = div_u64(ptime, NSEC_PER_SEC);
> >  
> > -		if (psecs >= hard) {
> > +		if (hard != RLIM_INFINITY && psecs >= hard) {
> >  			/*
> >  			 * At the hard limit, we just die.
> >  			 * No need to calculate anything else now.
> 
> Might make sense to mark this as a possible ABI change in the changelog: 
> if some weird code learned to rely on this (arguably broken) behavior 
> then the bug turned into an ABI.

Will do, though that would be really interesting to see the offending
case. That limit is in seconds and RLIM_INFINITY is at least INT_MAX which
means 68 years. :)

I stumbled over it when I tried to consolidate that duplicated code in that
area. I'll amend the changelog to be more clear.

Thanks,

	tglx
