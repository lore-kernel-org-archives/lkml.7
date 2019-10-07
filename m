Return-Path: <SRS0=z8wE=YA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FAB9ECE58C
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 13:03:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7609A2070B
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Oct 2019 13:03:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SeFZrK8g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbfJGNDk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Oct 2019 09:03:40 -0400
Received: from mail-ua1-f68.google.com ([209.85.222.68]:36247 "EHLO
        mail-ua1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728146AbfJGNDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Oct 2019 09:03:38 -0400
Received: by mail-ua1-f68.google.com with SMTP id r25so3999610uam.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2019 06:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ds8WznLX+NYi3ptkiUX0OCakAHSXETW90blbf1WdtvY=;
        b=SeFZrK8gMg6fY4PxMOK0NPAoUBk5SKZP6Rm2RpMc1sRZKgJg2NDDLR9yH+ZTkFrojb
         ECECpc6XwZXZYWrLpY3dkrOp1pLvCwRPEB3LV/Opy8prDkyQaXBI+0Em6seuvBwIpUf3
         WSFX4glUQS905Oi7/4W2htI0p1s5RzgKNERk4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ds8WznLX+NYi3ptkiUX0OCakAHSXETW90blbf1WdtvY=;
        b=BUhYbNhTkeHvO2qlf1ePV72Cuxuwkft5xMGmsnEUA6sWmgK/v063Ugok2d/VzLIyCY
         ElRANH9FWDnFMbbLMzMgm7JQzPPeAyI8jW4TUuvNjBZR1//XJzGuVtnzgPQ6wuYAw/lv
         xwlpFX6cY6/4gv4jP4tqDdG1AHPfCFKgO9TpFGtNIXSrYB4huOXwtvH5BowHJFtFLWPS
         39oaK4hzx+f3kC5DJE1xaBhzB0fdznMGTWoSnQarBEHyffDI6ezKUcrI4QyZ4iQvKxX7
         AlJEohYYaJx02EWaXIYLqEBYpkymYXBnGBskPUt4J6X9O/u+z+ndLRzyY8bkqCXNTH9w
         Br1w==
X-Gm-Message-State: APjAAAXgENsfSOJt9ml+449b2XCPDGmgszjvK+B33bzEddLNUU5U052y
        9BoaAz9FQBwaf3bp5N8GGNTnFdFKgckFzdyE783p0A==
X-Google-Smtp-Source: APXvYqyXRPLlM1sC+Qh9Y+U2YnUrT41/QnuLEzazUmqup77OPEOS8gKvErJCG8qbHkr6M+W+SZdp07y4EAEUpxg6cwg=
X-Received: by 2002:a9f:2924:: with SMTP id t33mr11661088uat.69.1570453416905;
 Mon, 07 Oct 2019 06:03:36 -0700 (PDT)
MIME-Version: 1.0
References: <20191003041438.194224-1-cychiang@chromium.org> <b8ad03db-b93f-44e0-ccd6-fc8bda1af223@baylibre.com>
In-Reply-To: <b8ad03db-b93f-44e0-ccd6-fc8bda1af223@baylibre.com>
From:   Cheng-yi Chiang <cychiang@chromium.org>
Date:   Mon, 7 Oct 2019 21:03:10 +0800
Message-ID: <CAFv8Nw+xfqzKC+x9m-Zd-dmPNayXxqTCeo8JsO7pQn8Uk1Ybsw@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND] drm/bridge: dw-hdmi: Restore audio when setting
 a mode
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Jonas Karlman <jonas@kwiboo.se>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Doug Anderson <dianders@chromium.org>,
        Dylan Reid <dgreid@chromium.org>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." 
        <alsa-devel@alsa-project.org>, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        Daniel Kurtz <djkurtz@chromium.org>,
        Yakir Yang <ykk@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 7, 2019 at 7:57 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> Hi,
>
> On 03/10/2019 06:14, Cheng-Yi Chiang wrote:
> > From: Daniel Kurtz <djkurtz@chromium.org>
> >
> > When setting a new display mode, dw_hdmi_setup() calls
> > dw_hdmi_enable_video_path(), which disables all hdmi clocks, including
> > the audio clock.
> >
> > We should only (re-)enable the audio clock if audio was already enabled
> > when setting the new mode.
> >
> > Without this patch, on RK3288, there will be HDMI audio on some monitors
> > if i2s was played to headphone when the monitor was plugged.
> > ACER H277HU and ASUS PB278 are two of the monitors showing this issue.
> >
> > Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
> > Signed-off-by: Daniel Kurtz <djkurtz@chromium.org>
> > Signed-off-by: Yakir Yang <ykk@rock-chips.com>
> > ---
> >  Change from v1 to v2:
> >   - Use audio_lock to protect audio clock.
> >   - Fix the patch title.
> >
> >  drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 13 ++++++++++++-
> >  1 file changed, 12 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> > index aa7efd4da1c8..749d8e4c535b 100644
> > --- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> > +++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
> > @@ -1982,6 +1982,17 @@ static void hdmi_disable_overflow_interrupts(struct dw_hdmi *hdmi)
> >                   HDMI_IH_MUTE_FC_STAT2);
> >  }
> >
> > +static void dw_hdmi_audio_restore(struct dw_hdmi *hdmi)
> > +{
> > +     unsigned long flags;
> > +
> > +     spin_lock_irqsave(&hdmi->audio_lock, flags);
> > +
> > +     hdmi_enable_audio_clk(hdmi, hdmi->audio_enable);
> > +
> > +     spin_unlock_irqrestore(&hdmi->audio_lock, flags);
>
> Dumb question, why is this protected by a spinlock ?
>
> Neil
>

Hi Neil,
Thanks for the review.
Good catch. I found that the spinlock audio_lock was introduced in

b90120a96608 drm: bridge/dw_hdmi: introduce interfaces to enable and
disable audio

to protect N/CTS value.
Actually it was not used to protect audio clock.
So we don't need this spinlock.

Hi Daniel Kurtz,
If this rings any bell in your memory as for why this is protected,
please let me know.
I would like to remove this spinlock and simplify this patch in v3.

Thanks!


> > +}
> > +
> >  static int dw_hdmi_setup(struct dw_hdmi *hdmi, struct drm_display_mode *mode)
> >  {
> >       int ret;
> > @@ -2045,7 +2056,7 @@ static int dw_hdmi_setup(struct dw_hdmi *hdmi, struct drm_display_mode *mode)
> >
> >               /* HDMI Initialization Step E - Configure audio */
> >               hdmi_clk_regenerator_update_pixel_clock(hdmi);
> > -             hdmi_enable_audio_clk(hdmi, true);
> > +             dw_hdmi_audio_restore(hdmi);
> >       }
> >
> >       /* not for DVI mode */
> >
>
