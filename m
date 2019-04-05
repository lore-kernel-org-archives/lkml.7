Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EE3DC10F0F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 15:44:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D872A20693
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 15:44:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="riSUW4xq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731499AbfDEPoI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 5 Apr 2019 11:44:08 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:40818 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbfDEPoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Apr 2019 11:44:08 -0400
Received: by mail-it1-f196.google.com with SMTP id k64so10209926itb.5
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2019 08:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VspmTPNLn8xL6ouAEeQeDx4TzQeyEHiFldQwlhIpHmo=;
        b=riSUW4xqNYoebenqTnGy0N5CQ3Qi9w65e5kaBkiuoBy6t9ybOJ4Ta6o+SDM7N5QQkn
         fbYsKUZihw33SO35lLO+8xMmCop6ps3odZys1GUxsROYZzHVTe6Nrr5S0N93RFrab9sp
         rWn7Mm7qbysDNx5sMY1v3LI5G/Epijjhn9t7XY/FDsH2VvT1cDHjQOSpfKzK4+Wa/wg7
         eik9GXh965M4U+n5DnV3+NVsZBAca4yVezVxMJe6djMTW1jjHWRdEKy6Hq3Qt51dU+Ck
         Oru0hAW6iUQwmjNRUAgDOXkwCbBE0bl4A/GXClLWNYJLoJ7Rad8ZcuuvzKrXiYeHLLvk
         /G2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VspmTPNLn8xL6ouAEeQeDx4TzQeyEHiFldQwlhIpHmo=;
        b=mY8AqoZj6oteoRVjX15SucrH1/umPz+353jPsqIuMXQEgb5KyIGsVHbJr1cFt5vAf7
         7jtFX3Z+3WCmiIQRF0+kj8FckP/zJseipOop340kCSw90Y1MJY5gnDU6PXxnPEnPcGVP
         RXdLynPfOL6Ju74JceGAnZfNYZtCgYfn3bVxD5z9NOFASGv/T7gGUvSKnn4+UmEQdGl1
         x75qSvo7qZBAUGGDXedZzWBSekeY0EXisbIH+RlnZ9XSKBHdENw2R5VmGEFuaRVphjMf
         eEUD39iHvvztPkHANUJkRY5w4aXKx2GqrZ8jro7ZPcfUe2CWhT+1DUpE5T8yob3avysw
         PX5A==
X-Gm-Message-State: APjAAAUP7VlqMEeFjgdl/Ua6PCkKn6e5TcAcz83mqHmOEUOZUtY/wFNK
        2PW4tresoLcV3y9Kf2Xcg1lRilNjrLrgZjtgachhWw==
X-Google-Smtp-Source: APXvYqxw1P4R6K7ENi+qHR7TWDvyajbZPjl2skwR4UM6WAei5oODulK9yiOJq2uWXsWn5EbxJjU17OSOQDOQt1geoKI=
X-Received: by 2002:a24:ed4d:: with SMTP id r74mr10217596ith.79.1554479047125;
 Fri, 05 Apr 2019 08:44:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190325111200.15940-1-jbrunet@baylibre.com> <20190325111200.15940-2-jbrunet@baylibre.com>
 <155353381842.20095.17915880223118004926@swboyd.mtv.corp.google.com>
 <8b6f0bc6210834af2aff2de7dc95692dd87db539.camel@baylibre.com>
 <155389767798.20095.10570017301900287354@swboyd.mtv.corp.google.com> <6ef984dabf626760ae606567facdc5245fbba984.camel@baylibre.com>
In-Reply-To: <6ef984dabf626760ae606567facdc5245fbba984.camel@baylibre.com>
From:   Michael Turquette <mturquette@baylibre.com>
Date:   Fri, 5 Apr 2019 08:43:40 -0700
Message-ID: <CAEG3pNCrANkLBeEA_wVU7n4U57X3sd-1EzhUZ_PHBryqPHoAaQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] clk: meson: mpll: add init callback and regs
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        "Stephen Boyd <sboyd@codeaurora.org>, Emilio Lopez
        <emilio@elopez.com.ar>, Hans de Goede <hdegoede@redhat.com>, linux-clk
        <linux-clk@vger.kernel.org>, linux-arm-kernel" 
        <linux-clk@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jerome,

On Fri, Mar 29, 2019 at 3:58 PM Jerome Brunet <jbrunet@baylibre.com> wrote:
>
> On Fri, 2019-03-29 at 15:14 -0700, Stephen Boyd wrote:
> > > > We actively discourage using init callbacks. Can you do this some other
> > > > way?
> > >
> > > Yes I'm aware of that but init it the right place to do this.
> > > To be clear, this is not initializing the clock to some particular rate, the
> > > rate is preserved.
> > >
> > > It just applies the necessary settings that needs to be done only once to make
> > > sure the clock is in working order and that the rate calculated is actually
> > > accurate.
> >
> > Ok, but can you do that in your driver's probe routine instead of
> > attaching to the init callback? We want to get rid of "init" at some
> > point so throwing the init sequence stuff into the driver probe around
> > registration is a solution. Or we should think about not discouraging
> > the init callback
>
> Is is callback really a problem after all ?

It is a problem, insofar as Stephen and I want to remove .init some day.

> I think we should actively prevent using it to set a particular rate.
>
> Here, the goal is put the clock in working order. The bootloader does not
> always do that for us.

The above two sentences make it sound like this sequence belongs in .prepare().

I know that you're concerned with setting rate, but I guess it is safe
to assume that you'll always complete .prepare() before you begin to
execute .set_rate(), no? This also avoids the ugliness of putting it
in the .probe(), which I agree doesn't feel like an accurate thing to
do for a clock's own programming sequence.

.probe() is an OK place to put policy (turn these clocks on or set
them to this rate, for a known-good configuration).

Thanks,
Mike

> I could put this in controller driver, but I would have
> to repeat the init pattern for each instance of the clock...not nice
> Using the callback clearly shows the relationship between the init and the
> clock. I think it is a lot better.
>
> In the same series, I have added some init for the controller. In this case
> the init target a group of clocks, so having the init in the controller makes
> sense for that
>
>
>


-- 
Michael Turquette
CEO
BayLibre - At the Heart of Embedded Linux
http://baylibre.com/
Schedule a meeting: https://calendly.com/mturquette
