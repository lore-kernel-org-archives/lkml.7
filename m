Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2879BC43613
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 21:18:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E46AF2085A
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 21:18:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VNslJ7mh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730532AbfFSVSf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 17:18:35 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:40064 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfFSVSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 17:18:34 -0400
Received: by mail-io1-f65.google.com with SMTP id n5so159223ioc.7
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 14:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=XY7aJ7dmXPxqNPvIOXdraSG/mXJqcFutpgqcMN/Km28=;
        b=VNslJ7mhNRCKEXVbWHWhBbcjyZQQnZuTLynWJkzRy6HJWCzrYxgAE2HhkW/VSd5Pz9
         SHfFCPP+ICxn6nicRTh1QtGs0tabSVxS4XDWpZ26c2/+NvIS9qM5t7B+rePUZMndCsUY
         d/Xt1q1xsTgqaK/ACYSjZ3NODpHgZdE4uqn5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=XY7aJ7dmXPxqNPvIOXdraSG/mXJqcFutpgqcMN/Km28=;
        b=ISPcDOvZcEDHo4qF1Cb+kn4uTUpkp68GeB6+YviBijCzfzcOuAni3ofeX82gMkM2E8
         uHwSLZJ2PYhE+ZYQgbuodI5x6O6c7JOSXyWHO+gKr8ZjeJaryTgQ80wXPHaScuUDjCFA
         Pyegy2MQNcw3u2afLXBOIAW5xSwPoQZjzZ2TYJ9g3h5KlB+SyCNIusjq6et7jHcLUdae
         +2g5qSziDlbghVEDghAOqU1eXzwwaZ1mFL79qifxb94bgwfR18rE1soe+21yDIB2w3It
         m+4UgwxCwr3OGsfLswspIRr7pw0od4cj9UOQMrlOr/kCDForMI9MKXy0L90k/VFAVAZk
         YIFg==
X-Gm-Message-State: APjAAAUvEPBoEx6dqRJ0RkzQLzemzkjuj6KkhE+wgJ/JQw9jZxWcowto
        u4GbuAUxHlF1G/b/12MoF8e0KgY3D5U=
X-Google-Smtp-Source: APXvYqzC2UHinvDMoJ2D1InD9oRxX5Eh7zi818Mg/E8pXuABIyFjSfXvYxqZ9fgpA52HNcpRVy94mw==
X-Received: by 2002:a5d:85c3:: with SMTP id e3mr37007257ios.265.1560979113182;
        Wed, 19 Jun 2019 14:18:33 -0700 (PDT)
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com. [209.85.166.50])
        by smtp.gmail.com with ESMTPSA id x13sm15366123ioj.18.2019.06.19.14.18.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 14:18:33 -0700 (PDT)
Received: by mail-io1-f50.google.com with SMTP id r185so553009iod.6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2019 14:18:33 -0700 (PDT)
X-Received: by 2002:a02:5b05:: with SMTP id g5mr93849116jab.114.1560978714620;
 Wed, 19 Jun 2019 14:11:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190617235558.64571-1-dianders@chromium.org> <6219398.I55JWXAmVF@jernej-laptop>
 <9bba43cb-7070-8b2a-cfc6-f601fd22a315@baylibre.com>
In-Reply-To: <9bba43cb-7070-8b2a-cfc6-f601fd22a315@baylibre.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 19 Jun 2019 14:11:41 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V_xg3VfWDMfjJp158ELUQm5xJQCRn85H4mx_-YfjfWTg@mail.gmail.com>
Message-ID: <CAD=FV=V_xg3VfWDMfjJp158ELUQm5xJQCRn85H4mx_-YfjfWTg@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge/synopsys: dw-hdmi: Handle audio for more clock rates
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@siol.net>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Sean Paul <seanpaul@chromium.org>,
        =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
        Jonas Karlman <jonas@kwiboo.se>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Dylan Reid <dgreid@chromium.org>,
        Cheng-Yi Chiang <cychiang@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Zheng Yang <zhengyang@rock-chips.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jun 19, 2019 at 8:23 AM Neil Armstrong <narmstrong@baylibre.com> wr=
ote:
>
> On 18/06/2019 19:23, Jernej =C5=A0krabec wrote:
> > Hi!
> >
> > Dne torek, 18. junij 2019 ob 01:55:58 CEST je Douglas Anderson napisal(=
a):
> >> Let's add some better support for HDMI audio to dw_hdmi.
> >> Specifically:
> >>
> >> 1. For 44.1 kHz audio the old code made the assumption that an N of
> >> 6272 was right most of the time.  That wasn't true and the new table
> >> should give better 44.1 kHz audio for many more rates.
> >>
> >> 2. The new table has values from the HDMI spec for 297 MHz and 594
> >> MHz.
> >>
> >> 3. There is now code to try to come up with a more idea N/CTS for
> >> clock rates that aren't in the table.  This code is a bit slow because
> >> it iterates over every possible value of N and picks the best one, but
> >> it should make a good fallback.
> >>
> >> 4. The new code allows for platforms that know they make a clock rate
> >> slightly differently to pick different N/CTS values.  For instance on
> >> rk3288 we can make 25,176,471 Hz instead of 25,174,825.1748... Hz
> >> (25.2 MHz / 1.001).  A future patch to the rk3288 platform code could
> >> enable support for this clock rate and specify the N/CTS that would be
> >> ideal.
> >>
> >> NOTE: the oddest part of this patch comes about because computing the
> >> ideal N/CTS means knowing the _exact_ clock rate, not a rounded
> >> version of it.  The drm framework makes this harder by rounding rates
> >> to kHz, but even if it didn't there might be cases where the ideal
> >> rate could only be calculated if we knew the real (non-integral) rate.
> >> This means that in cases where we know (or believe) that the true rate
> >> is something other than the rate we are told by drm.
> >>
> >> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> >
> > Which bus is used for audio transfer on your device? If it is I2S, whic=
h is
> > commonly used, then please be aware of this patch:
> > https://lists.freedesktop.org/archives/dri-devel/2019-June/221539.html
> >
> > It avoids exact N/CTS calculation by enabling auto detection. It is wel=
l
> > tested on multiple SoCs from Allwinner, Amlogic and Rockchip.
> >
> > Best regards,
> > Jernej
> >
> >
> Hi Douglas,
>
> Thanks for your work !
>
> If you could rebase on top of https://lists.freedesktop.org/archives/dri-=
devel/2019-June/221539.html
> so we can make use of your extended N table with automatic CTS HW calcula=
tion, it would be great !

Thanks to you and Jernej for pointing me at this.  It seems likely
that patch by itself would solve problems we found and I'll pick that
into my tree.

Probably my patch is no longer quite as useful atop yours, but I'll
still post a v2 since (in theory) folks that aren't using I2S might
find it useful.  I guess it's also possible (?) that picking an N
where CTS would be able to be integral has some type of advantage,
even with auto CTS?


> Finally could you add the plat_data tmds table as a separate patch to sim=
plify review ?

Sure.  I'm probably not going to be able to post the patch to actually
use it, so I guess we could just not bother applying the 2nd patch
unless someone ever needs it.

-Doug
