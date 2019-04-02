Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 587C8C4360F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 09:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 327002075E
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 09:03:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729837AbfDBJDT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Apr 2019 05:03:19 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:34175 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbfDBJDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Apr 2019 05:03:15 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hBFK2-0000OV-4I; Tue, 02 Apr 2019 11:03:10 +0200
Date:   Tue, 2 Apr 2019 11:03:09 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Ondrej Mosnacek <omosnace@redhat.com>
cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        Paul Moore <paul@paul-moore.com>,
        Richard Guy Briggs <rgb@redhat.com>,
        Steve Grubb <sgrubb@redhat.com>,
        Miroslav Lichvar <mlichvar@redhat.com>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH ghak10 v6 2/2] ntp: Audit NTP parameters adjustment
In-Reply-To: <CAFqZXNvQioPGUiU0q5R4nQLW7pQDsViNH-DR=SF4Fec+-CwksA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1904021100410.1676@nanos.tec.linutronix.de>
References: <20190307123254.348-1-omosnace@redhat.com> <20190307123254.348-3-omosnace@redhat.com> <alpine.DEB.2.21.1903280039530.1789@nanos.tec.linutronix.de> <CAFqZXNvQioPGUiU0q5R4nQLW7pQDsViNH-DR=SF4Fec+-CwksA@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 Apr 2019, Ondrej Mosnacek wrote:
> On Thu, Mar 28, 2019 at 1:02 AM Thomas Gleixner <tglx@linutronix.de> wrote:
> > On Thu, 7 Mar 2019, Ondrej Mosnacek wrote:
> > >                       /* adjtime() is independent from ntp_adjtime() */
> > >                       time_adjust = txc->offset;
> > >                       ntp_update_frequency();
> > > +
> > > +                     audit_ntp_adjust("adjust", save_adjust, txc->offset);
> > >               }
> > >               txc->offset = save_adjust;
> > >       } else {
> >
> > Not going to happen. We are not reshuffling all that code just to
> > accomodate random audit log invocations in a critical section plus having a
> > gazillion of GFP_ATOMIC allocation in the critical section just because.
> 
> OK, seems I underestimated the consequences of putting the logging
> calls directly in there. While I was offline over the weekend I
> already came up with a cleaner version that collects the changes in a
> structure and does the logging outside of the critical section. I
> currently does a few unnecessary writes into memory under
> CONFIG_AUDIT=n, but if that is an issue I can boost the abstraction or
> just add some #ifdefs to avoid that.

No ifdefs please. Aside of that, why do you need all those details of the
ntp internals in the first place? The changelog does not give me an answer
to that.

Thanks,

	tglx
