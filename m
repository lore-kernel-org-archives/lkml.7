Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B2CDC43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 12:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63EB02064A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 12:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730114AbfCFM36 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 07:29:58 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:49803 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727222AbfCFM35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 07:29:57 -0500
Received: from p5492e2fc.dip0.t-ipconnect.de ([84.146.226.252] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1h1VgD-0003Rm-9y; Wed, 06 Mar 2019 13:29:49 +0100
Date:   Wed, 6 Mar 2019 13:29:48 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Miroslav Lichvar <mlichvar@redhat.com>
cc:     John Stultz <john.stultz@linaro.org>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Stephen Boyd <sboyd@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC PATCH] ntp: Avoid undefined behaviour in
 second_overflow()
In-Reply-To: <20190306095442.GM21520@localhost>
Message-ID: <alpine.DEB.2.21.1903061327350.1646@nanos.tec.linutronix.de>
References: <1551835710-53773-1-git-send-email-wangxiongfeng2@huawei.com> <CALAqxLXFGKDzxT-S9DDnjRRYvDB1Qq3T-tHYYGQXg3c47HtTbQ@mail.gmail.com> <20190306095442.GM21520@localhost>
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

On Wed, 6 Mar 2019, Miroslav Lichvar wrote:
> On Tue, Mar 05, 2019 at 05:42:25PM -0800, John Stultz wrote:
> > > --- a/kernel/time/ntp.c
> > > +++ b/kernel/time/ntp.c
> > > @@ -677,6 +677,8 @@ static inline void process_adjtimex_modes(const struct timex *txc, s32 *time_tai
> > >
> > >         if (txc->modes & ADJ_MAXERROR)
> > >                 time_maxerror = txc->maxerror;
> > > +       if (time_maxerror > NTP_PHASE_LIMIT)
> > > +               time_maxerror = NTP_PHASE_LIMIT;
> > 
> > This looks sane to me.
> > Acked-by: John Stultz <john.stultz@linaro.org>
> > 
> > Though it makes me wonder a bit more about the sanity checking on the
> > other parameters passed via adjtimex(), tick_usec for instance looks
> > like it could be similarly problematic.
> 
> The tick length is checked earlier in timekeeping_validate_timex(), so
> that should be ok.
> 
> What I'd like to see clamped is the system time itself. ktime_t
> overflows on Apr 11 2262. clock_settime() and adjtimex(ADJ_SETOFFSET)
> can set the time close to the overflow and let everything break.
> 
> Boot a VM and try this:
> 
> # date -s 'Apr 11 23:47:15 UTC 2262'

So once Arnd is done with y2038, we'll ask him to look into y2262 :)

Seriously, yes we should do clamping there.

Thanks,

	tglx
