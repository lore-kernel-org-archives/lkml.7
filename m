Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 655D4C606C1
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:58:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3ADF3216F4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 15:58:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OXbjFpWm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388947AbfGHP6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 11:58:54 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:40389 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388088AbfGHP6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 11:58:53 -0400
Received: by mail-io1-f65.google.com with SMTP id h6so28173351iom.7
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 08:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tMCiFsRLDuW6geBulr3EjyW7t17T9yVxinnBG4xjmyE=;
        b=OXbjFpWmkvpDp2y6eTwPwQeZzYHFJ41RVnrCR/bBnbn3zmrcjD44kQV6AOejyYbCET
         Xw1BD5zUF87gnasL9QHVthJWk8/FVdH2b4ELdIR34m4lfjlZPKmCl70qe5p2QRmHi8nA
         uP0SYDtYKhdyMH1ZypI3iFmOV4Bcv5ysoSlXw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tMCiFsRLDuW6geBulr3EjyW7t17T9yVxinnBG4xjmyE=;
        b=sMf9gwyG/3kQW1imAHCCZ+3VqJZbWRyy6ghAfAt1qGPdN15GgFFnmJwmK4R4T57YCm
         B/UOUDMo4geIvK3dS+lkl1HqoFVBTYN3m7K6ll88sp/SHXC+6998VyYWNqDMaucMHGFg
         KSXLkD9gLeaHnEHljhls4qW8wY0OhUP2SSQ5k/rcao684NugGN8GsC8iRUuUrjUKbtMl
         V1I45lSAw6vIh6CGsu6kB+wPqwqXgi5H3s8lcHHNM2dYI2UxZ8J607YfN/HRyu3Bvg24
         J+/inesvFHXOgm03Os3+RLOSXX8Dt5yKO0v1qvZF3dtxRUI2qvr2Hz9PCPEiedklmwxH
         L4CA==
X-Gm-Message-State: APjAAAUm+Wm1/41yQq+0CSnALc7LyJuA7MoECkjMF0dpUyOc+5Lvfkdn
        VbPcY1DJHljUqsXkDWGLz1QLNSqilJc=
X-Google-Smtp-Source: APXvYqwBcxsZu1ODp6oLFBr6/t3E5EzNQPV4H7G1tmn+HtLLXdJhwjeEGnRhEXT+kFU7K5jn2UVZfA==
X-Received: by 2002:a6b:8e82:: with SMTP id q124mr11725976iod.68.1562601532081;
        Mon, 08 Jul 2019 08:58:52 -0700 (PDT)
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com. [209.85.166.49])
        by smtp.gmail.com with ESMTPSA id j14sm14898788ioa.78.2019.07.08.08.58.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 08:58:50 -0700 (PDT)
Received: by mail-io1-f49.google.com with SMTP id j6so36415294ioa.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2019 08:58:49 -0700 (PDT)
X-Received: by 2002:a5e:8f08:: with SMTP id c8mr20045788iok.52.1562601529525;
 Mon, 08 Jul 2019 08:58:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190401171724.215780-1-dianders@chromium.org>
 <CAD=FV=Vi2C7s2oWBDD0n+HK=_SuBYhRM9saMK-y6Qa0+k-g17w@mail.gmail.com>
 <20190628171342.GA2238@ravnborg.org> <2169143.hEFa8b2HQR@diego>
In-Reply-To: <2169143.hEFa8b2HQR@diego>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 8 Jul 2019 08:58:41 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U3Wj8vaZcQLmkfX6zgjVFEra+GrHMH3OCs5QQ_-tM4hw@mail.gmail.com>
Message-ID: <CAD=FV=U3Wj8vaZcQLmkfX6zgjVFEra+GrHMH3OCs5QQ_-tM4hw@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] drm/panel: simple: Add mode support to devicetree
To:     =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>
Cc:     Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sean Paul <seanpaul@chromium.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Brian Norris <briannorris@chromium.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        =?UTF-8?Q?Enric_Balletb=C3=B2?= <enric.balletbo@collabora.com>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sam,

On Sat, Jun 29, 2019 at 7:09 AM Heiko St=C3=BCbner <heiko@sntech.de> wrote:
>
> Hi Sam,
>
> Am Freitag, 28. Juni 2019, 19:13:42 CEST schrieb Sam Ravnborg:
> > Hi Doug.
> >
> > > Sam: Oh!  I hadn't noticed that you've been added as a panel
> > > maintainer in commit ef0db94f94a0 ("MAINTAINERS: Add Sam as reviewer
> > > for drm/panel").  Does that mean you are able to provide some advice
> > > for how to land this series?
> > Reviewer only, not maintainer....
> >
> > It is on my TODO list for the weekend to go through the patch set in
> > details and provide feedback. I have read them before, but I miss to do
> > a more detailed read through.
> >
> > But I cannot apply this unless Thierry or one of the DRM maintainers
> > ack it.
> > We simply need someone with a better general knowledge of DRM to ack it
> > than I have.
>
> So Thierry was able to look at the patches yesterday it seems and has Ack=
ed
> all the relevant ones. As a drm-misc-contributor I could also apply them
> myself, but now don't want to preempt any additional comments you might
> have ;-) . So I guess my question would be if you still want to do a revi=
ew
> or if I should apply them.

Hopefully you saw, but I responded to all of your review feedback.  In
the end, I thought it'd be OK to land the series as-is and I can fix
up nits in a follow-up series, though I'm waiting for your responses
to a couple questions first.

It would be ideal if you could confirm that you're OK with this plan
even if you don't have time to respond in detail to my emails yet.  I
think Heiko can land them all through the appropriate channels since
the patches have all the proper Acks.

Thanks!

-Doug
