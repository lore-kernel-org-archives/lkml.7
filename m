Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF07C43603
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 22:48:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 831CC20717
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 22:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="TmD8VqL0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbfLRWsO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 17:48:14 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:39585 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfLRWsO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 17:48:14 -0500
Received: by mail-io1-f65.google.com with SMTP id c16so2312909ioh.6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 14:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HUPNGjTxVnCf9t8O1v8YRvPP2CQXKG1MqWvD1p/QE64=;
        b=TmD8VqL0QC029L9QBQZU+bTfXvQswXjeDXnjiIOMPmWs4dhTEN5qRx+I8xn0raKeX5
         hDcIrNbJquXkV5ebv4aCtGwI9MCCjCz9e4PFwTXle0aKuGwqoYOwAbuQLaASjKA1sS1V
         uwICXiz1tyYXpX6mcKkbfEByYEPzD+Iorh3RI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HUPNGjTxVnCf9t8O1v8YRvPP2CQXKG1MqWvD1p/QE64=;
        b=k9stgrznSyeuw2yRObO6HjqnGiSSIAgd1ZXZdS+Tj1FSjbFYNHkUh8V+HttLADwkVh
         TBIwOLY99MSuTvG/t/KVRE2z6aIrxscnirBvHddzQoidOaRugxAOIDhuaE5DPphqSPuZ
         Tz1l0P8R5+kaXaOCqI4l/48aXmHTZeMPDjxwlVfm+cwZ1dNpZru1C87DmrrcTSn9VCiy
         jrmyn3SRAAaqHBi9JOv6E5vPr6tNoyHRecQzpAP6IVwK/J0KnbTsIfvv8waUKqJRqGm0
         n2J9fES90426qRCrw1QXafhvQCOramURf//XivdisfGY3AfLLpYs8M1do+kl2y6NNrKH
         yLTw==
X-Gm-Message-State: APjAAAWgwr2jNpPY/AN9Hy5uPwXzhA4Uhz9DSfhrjM3yu0xJk7nlz6H/
        DkNBQytKKb5EuBjtlOSp1Hlt90RveU4=
X-Google-Smtp-Source: APXvYqxXZ/TSNbRnRx2medobEhhlSw3HSvaBg1ZKvVcEQj4Vv21NiJSCSaKpXRAZey8qT+lQgf12HA==
X-Received: by 2002:a02:c85b:: with SMTP id r27mr4471261jao.57.1576709293349;
        Wed, 18 Dec 2019 14:48:13 -0800 (PST)
Received: from mail-il1-f169.google.com (mail-il1-f169.google.com. [209.85.166.169])
        by smtp.gmail.com with ESMTPSA id c18sm764871iol.5.2019.12.18.14.48.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Dec 2019 14:48:13 -0800 (PST)
Received: by mail-il1-f169.google.com with SMTP id x5so3136376ila.6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Dec 2019 14:48:13 -0800 (PST)
X-Received: by 2002:a92:ca90:: with SMTP id t16mr3875343ilo.218.1576708930281;
 Wed, 18 Dec 2019 14:42:10 -0800 (PST)
MIME-Version: 1.0
References: <20191218004741.102067-1-dianders@chromium.org>
 <20191217164702.v2.9.Ib59207b66db377380d13748752d6fce5596462c5@changeid>
 <CAF6AEGs5CKNhKh_ZLUqWh8_2GxiDiuaTC2P-yzHqz+Dvhbp-VQ@mail.gmail.com> <CAF6AEGukOwr6TUmo3UySML5LWOC-b7vN4NwJv0OGprFafgTdEw@mail.gmail.com>
In-Reply-To: <CAF6AEGukOwr6TUmo3UySML5LWOC-b7vN4NwJv0OGprFafgTdEw@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 18 Dec 2019 14:41:58 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UqFYAoyxaAF4B768j-SeZOp71=Cq84s61W3s8BB7TO+w@mail.gmail.com>
Message-ID: <CAD=FV=UqFYAoyxaAF4B768j-SeZOp71=Cq84s61W3s8BB7TO+w@mail.gmail.com>
Subject: Re: [PATCH v2 9/9] drm/bridge: ti-sn65dsi86: Avoid invalid rates
To:     Rob Clark <robdclark@gmail.com>
Cc:     Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Rob Clark <robdclark@chromium.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        David Airlie <airlied@linux.ie>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sean Paul <seanpaul@chromium.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Dec 17, 2019 at 8:03 PM Rob Clark <robdclark@gmail.com> wrote:
>
> > > +               for (i = 0; i < ARRAY_SIZE(sink_rates); i++) {
> > > +                       rate_times_200khz = le16_to_cpu(sink_rates[i]);
> > > +
> > > +                       if (!rate_times_200khz)
> > > +                               break;
> > > +
> > > +                       switch (rate_times_200khz) {
> > > +                       case 27000:
> >
> > maybe a bit bike-sheddy, but I kinda prefer to use traditional normal
> > units, ie. just multiply the returned value by 200 and adjust the
> > switch case values.  At least then they match the values in the lut
> > (other than khz vs mhz), which makes this whole logic a bit more
> > obvious... and at that point, maybe just loop over the lut table?
>
> (hit SEND too soon)
>
> and other than that, lgtm but haven't had a chance to test it yet
> (although I guess none of us have an eDP 1.4+ screen so maybe that is
> moot :-))

I think v3 should look much better to you.  I also added a note to the
commit log indicating that the DP 1.4 patch was only tested via
hackery...

https://lore.kernel.org/r/20191218143416.v3.9.Ib59207b66db377380d13748752d6fce5596462c5@changeid

-Doug
