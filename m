Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54419C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 18:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DEFC20882
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 18:47:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731402AbfCaSrd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 14:47:33 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:34881 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731241AbfCaSrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 14:47:33 -0400
Received: from pty.hi.pengutronix.de ([2001:67c:670:100:1d::c5])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hAfUR-0007FK-3o; Sun, 31 Mar 2019 20:47:31 +0200
Received: from ukl by pty.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <ukl@pengutronix.de>)
        id 1hAfUQ-0001eS-E9; Sun, 31 Mar 2019 20:47:30 +0200
Date:   Sun, 31 Mar 2019 20:47:30 +0200
From:   Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     linux-pwm@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org, thierry.reding@gmail.com,
        kernel@pengutronix.de, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, jbrunet@baylibre.com
Subject: Re: [PATCH 0/1] pwm: meson: fix scheduling while atomic issue
Message-ID: <20190331184730.y767dxhblffxj3om@pengutronix.de>
References: <20190324220217.15813-1-martin.blumenstingl@googlemail.com>
 <20190325084153.l44pzfewcqlkoaoe@pengutronix.de>
 <CAFBinCAn-9oETMKMfSXoJOMBrQyrCFN7AyHG02bQaoxG1px3YA@mail.gmail.com>
 <20190325200730.cx73jgxfexz6ybzq@pengutronix.de>
 <CAFBinCCGWsb+1WHFe6uwrpUYgH4iix0WT8_v_Nj5BhGKRyjiLQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFBinCCGWsb+1WHFe6uwrpUYgH4iix0WT8_v_Nj5BhGKRyjiLQ@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c5
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 30, 2019 at 08:29:35PM +0100, Martin Blumenstingl wrote:
> Hello Uwe,
> 
> On Mon, Mar 25, 2019 at 9:07 PM Uwe Kleine-König
> <u.kleine-koenig@pengutronix.de> wrote:
> [...]
> > > >  - Does stopping the PWM (i.e. clearing MISC_{A,B}_EN in the MISC_AB
> > > >    register) freeze the output, or is the currently running period
> > > >    completed first? (The latter is the right behaviour.)
> > > I don't know, I would have to measure this with a logic analyzer.
> >
> > In practise you can do this with a multimeter, too. Just do something
> > like:
> >
> >         pwm_apply_state({ .enabled = true, .period = 5s, .duty_cycle = 5s, .polarity = PWM_POLARITY_NORMAL });
> >         pwm_apply_state({ .enabled = false, .period = 5s, .duty_cycle = 5s, .polarity = PWM_POLARITY_NORMAL });
> >
> > (assuming the PWM supports periods that long). The expectation is that
> > the last command takes nearly 5 s to complete and while it waits the
> > output is high and on return it's low. If that isn't the case, there is
> > a bug somewhere.
> the longest supported period (using the 24MHz crystal as input, which
> is the slowest input clock and thus gives the longest possible
> duration) is 349514407ns (that's approx. 0.35 seconds). my multimeter
> isn't fast enough to measure this so I'm using my logic analyzer with
> puleseview instead: [0]
> 
> I added the following code to meson_pwm_request:
>   struct pwm_state enable = {
>         .enabled = true,
>         .period = 349514407U,
>         .duty_cycle = 349514407U,
>         .polarity = PWM_POLARITY_NORMAL };
>   struct pwm_state disable = {
>         .enabled = false,
>         .period = 349514407U,
>         .duty_cycle = 349514407U,
>         .polarity = PWM_POLARITY_NORMAL };
>   pwm_apply_state(pwm, &enable);
>   pwm_apply_state(pwm, &disable);
> 
> this returns immediately. my logic analyzer doesn't see signal change
> (I'm sampling at 1MHz).
> 
> can you please confirm that my test code and measurement procedure is correct?
> if it is then my observation is that disabling the PWM does so
> immediately, without waiting for the current period to complete

Ack, with the above two pwm_apply_state the output must be high when the
first pwm_apply_state returns. Then it must stay high for n *
349514407 ns (for an natural n >= 1) and then go low.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
