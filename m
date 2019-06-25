Return-Path: <SRS0=/s9R=UY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5ADEC48BD5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 16:26:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75640208E3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Jun 2019 16:26:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UnAYvApE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728961AbfFYQ0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Jun 2019 12:26:47 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:42925 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbfFYQ0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jun 2019 12:26:46 -0400
Received: by mail-io1-f68.google.com with SMTP id u19so517730ior.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 09:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gwY+oa4CU+2jLrCTvWh4nbvrkKnM/pKWMZeBvxC7ZU0=;
        b=UnAYvApESHYhIZR/6fC9tpaOr5kt+ZnKyBE9mrQhqGpqI2byLeJRHdhAOAAgquPl1T
         HbDW11YvB3zM5qCXzEXKmtW4ZCBN6EK+1UjFx+KwSt8v0elkLfQ0eK3KSju0odSDKVlW
         bKPaxgduKYKyR8eFnQWp8Tn2593l1UvURVSt8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gwY+oa4CU+2jLrCTvWh4nbvrkKnM/pKWMZeBvxC7ZU0=;
        b=QREq/6XVhFvjyGfOVOqr6lDOYUmENwcuUPylWzZ04BCVqT8dLRPw0tpW/GOzVuzA5S
         7UMdvnP8/q7xR9MELHHLTX67qy8U8cCLzLUmDbIN9/ITvJ4Ye487NNnnWB2s0Jw3vSAY
         aAS2U+zpYdUhETGnR4tFlyOtLCG3HZ8bQ7AdKZzALHIoQhzIQR5WiAynS8GeHq3WTakE
         43o+Lu1Gl/M2KL3MRHAkedUBkscPpiRIEQzBOPaTpu+qtdtnEfgTCWPaFImDdNdSqrKp
         nDx5KdsKstSCA3JXbCZIABXE+X07J7zIvxofuJhGlefn1nCeisMWpEk6eFB0lj8CQ+7+
         txTA==
X-Gm-Message-State: APjAAAXQFcE49+XMZ/+OX9dr235j2TZHa3OU6K1B0rsZ1+HDgRqBFnUL
        7CIohqq8XVciarJaNQeJqipnvfwlOdM=
X-Google-Smtp-Source: APXvYqxS89aZpF+Uek1wH8Z88CdUN1pofRjW3ZSvXxWr46xqBbuag4OK9TEArw6KgAYeflXp64ojxg==
X-Received: by 2002:a02:cb4b:: with SMTP id k11mr50003483jap.109.1561480005354;
        Tue, 25 Jun 2019 09:26:45 -0700 (PDT)
Received: from mail-io1-f52.google.com (mail-io1-f52.google.com. [209.85.166.52])
        by smtp.gmail.com with ESMTPSA id y20sm16466583iol.34.2019.06.25.09.26.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Jun 2019 09:26:43 -0700 (PDT)
Received: by mail-io1-f52.google.com with SMTP id u13so1129723iop.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2019 09:26:43 -0700 (PDT)
X-Received: by 2002:a6b:5103:: with SMTP id f3mr7084335iob.142.1561480003100;
 Tue, 25 Jun 2019 09:26:43 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190619211151epcas3p4dbb163c034afa4063869c761b93e24b1@epcas3p4.samsung.com>
 <20190619210718.134951-1-dianders@chromium.org> <bec87373-48cc-0c55-9662-a74a7d2a47a0@samsung.com>
In-Reply-To: <bec87373-48cc-0c55-9662-a74a7d2a47a0@samsung.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 25 Jun 2019 09:26:28 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WJBkYfRznh6aAyvgKgHb8-AG0hMORdKA0BXCL89wG_7w@mail.gmail.com>
Message-ID: <CAD=FV=WJBkYfRznh6aAyvgKgHb8-AG0hMORdKA0BXCL89wG_7w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] drm/bridge/synopsys: dw-hdmi: Handle audio for
 more clock rates
To:     Andrzej Hajda <a.hajda@samsung.com>
Cc:     Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Sean Paul <seanpaul@chromium.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Jonas Karlman <jonas@kwiboo.se>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Dylan Reid <dgreid@chromium.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


On Tue, Jun 25, 2019 at 9:07 AM Andrzej Hajda <a.hajda@samsung.com> wrote:
>
> On 19.06.2019 23:07, Douglas Anderson wrote:
> > Let's add some better support for HDMI audio to dw_hdmi.
> > Specifically:
> >
> > 1. For 44.1 kHz audio the old code made the assumption that an N of
> > 6272 was right most of the time.  That wasn't true and the new table
> > should pick a more ideal value.
>
>
> Why? I ask because it is against recommendation from HDMI specs.

The place where it does matter (and why I originally did this work) is
when you don't have auto-CTS.  In such a case you really need "N" and
"CTS" to make the math work and both be integral.  This makes sure
that you don't slowly accumulate offsets.  I'm hoping that this point
should be non-controversial so I won't argue it more.

I am an admitted non-expert, but I have a feeling that with Auto-CTS
either the old number or the new numbers would produce pretty much the
same experience.  AKA: anyone using auto-CTS won't notice any change
at all.  I guess the question is: with Auto-CTS should you pick the
"ideal" 6272 or a value that allows CTS to be the closest to integral
as possible.  By reading between the lines of the spec, I decided that
it was slightly more important to allow for an integral CTS.  If
achieving an integral CTS wasn't a goal then the spec wouldn't even
have listed special cases for any of the clock rates.  We would just
be using the ideal N and Auto-CTS and be done with it.  The whole
point of the tables they list is to make CTS integral.


> > 2. The new table has values from the HDMI spec for 297 MHz and 594
> > MHz.
> >
> > 3. There is now code to try to come up with a more idea N/CTS for
> > clock rates that aren't in the table.  This code is a bit slow because
> > it iterates over every possible value of N and picks the best one, but
> > it should make a good fallback.
> >
> > NOTES:
> > - The oddest part of this patch comes about because computing the
> >   ideal N/CTS means knowing the _exact_ clock rate, not a rounded
> >   version of it.  The drm framework makes this harder by rounding
> >   rates to kHz, but even if it didn't there might be cases where the
> >   ideal rate could only be calculated if we knew the real
> >   (non-integral) rate.  This means that in cases where we know (or
> >   believe) that the true rate is something other than the rate we are
> >   told by drm.
> > - This patch makes much less of a difference after the patch
> >   ("drm/bridge: dw-hdmi: Use automatic CTS generation mode when using
> >   non-AHB audio"), at least if you're using I2S audio.  The main goal
> >   of picking a good N is to make it possible to get a nice integral
> >   CTS value, but if CTS is automatic then that's much less critical.
>
>
> As I said above HDMI recommendations are different from those from your
> patch. Please elaborate why?
>
> Btw I've seen your old patches introducing recommended N/CTS calculation
> helpers in HDMI framework, unfortunately abandoned due to lack of interest.
>
> Maybe resurrecting them would be a good idea, with assumption there will
> be users :)

I have old patches introducing this into the HDMI framework?  I don't
remember them / can't find them.  Can you provide a pointer?

-Doug
