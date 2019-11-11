Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD833C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 23:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A82D221D7F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 23:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727492AbfKKXhr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 18:37:47 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60246 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbfKKXhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 18:37:47 -0500
Received: from p5b06da22.dip0.t-ipconnect.de ([91.6.218.34] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1iUJFe-0001gT-0H; Tue, 12 Nov 2019 00:37:42 +0100
Date:   Tue, 12 Nov 2019 00:37:41 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Bartosz Golaszewski <bgolaszewski@baylibre.com>
cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Colin King <colin.king@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] clocksource/drivers/davinci: fix memory leak on clockevent
 on error return
In-Reply-To: <CAMpxmJVC5GGhR0z_4CkF7Opfw-5HpEKD8fUrKsgBZTbz0wDd-Q@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1911120033220.1833@nanos.tec.linutronix.de>
References: <20191109155836.223635-1-colin.king@canonical.com> <CAMpxmJVC5GGhR0z_4CkF7Opfw-5HpEKD8fUrKsgBZTbz0wDd-Q@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1927344373-1573515462=:1833"
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1927344373-1573515462=:1833
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Bartosz,

On Sun, 10 Nov 2019, Bartosz Golaszewski wrote:
> sob., 9 lis 2019 o 16:58 Colin King <colin.king@canonical.com> napisał(a):
> >
> > From: Colin Ian King <colin.king@canonical.com>
> >
> > In the case where request_irq fails, the return path does not kfree
> > clockevent and hence we have a memory leak.  Fix this by kfree'ing

s/we have/creates/  or whatever verb you prefer.

> > clockevent before returning.
> >
> > Addresses-Coverity: ("Resource leak")
> > Fixes: 721154f972aa ("clocksource/drivers/davinci: Add support for clockevents")
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > ---
> >  drivers/clocksource/timer-davinci.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/clocksource/timer-davinci.c b/drivers/clocksource/timer-davinci.c
> > index 62745c962049..910d4d2f0d64 100644
> > --- a/drivers/clocksource/timer-davinci.c
> > +++ b/drivers/clocksource/timer-davinci.c
> > @@ -299,6 +299,7 @@ int __init davinci_timer_register(struct clk *clk,
> >                          "clockevent/tim12", clockevent);
> >         if (rv) {
> >                 pr_err("Unable to request the clockevent interrupt");
> > +               kfree(clockevent);
> >                 return rv;
> >         }
> >
> > --
> > 2.20.1
> >
> 
> Hi Daniel,
> 
> this is what I think the third time someone tries to "fix" this
> driver's "memory leaks". I'm not sure what the general approach in
> clocksource is but it doesn't make sense to free resources on
> non-recoverable errors, does it? Should I add a comment about it or
> you'll just take those "fixes" to stop further such submissions?

There are two ways to deal with that:

  1) If the error is really unrecoverable, panic right there. No point
     to continue.

  2) If there is even a minimal chance to survive, free the memory and
     return.

Adding a comment is just a useless non-option.

Thanks,

	tglx
--8323329-1927344373-1573515462=:1833--
