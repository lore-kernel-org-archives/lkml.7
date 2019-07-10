Return-Path: <SRS0=5O2B=VH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BFBFC74A35
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 22:40:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 091B820665
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jul 2019 22:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="i5KPrHov"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbfGJWkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jul 2019 18:40:10 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:39322 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbfGJWkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 18:40:09 -0400
Received: by mail-io1-f67.google.com with SMTP id f4so8308368ioh.6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 15:40:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=h1QrIpFdh5rLkTKFlCHaduUWYuYcrWpgjVEeSTaTyVo=;
        b=i5KPrHovfkqkwkajM2OJwC/MI8IVo3lIvSf1xBkUaMHWuUyWkij1QldVl9kX/GMlE1
         DNsrFiTH/7r6LswYJlPb1030krcbMTp9icHuWypgydw+2C+kuV72UBpH6KFLdct9hP6R
         bfQOoNSN7axemJnh/3RbdCrrYZ6IDuOtjaP+w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=h1QrIpFdh5rLkTKFlCHaduUWYuYcrWpgjVEeSTaTyVo=;
        b=ZNvv0FN3uz/4h+GpD7HcOttLF6dlR8/j8Edo7BXp+PWDpCslX/wHVItRSzarJaAVay
         hX69UWnmofLfO141wqVg5Apgtm7EXf9Wi5vB1WaD51YBdLOW9Vamg2R2yNs4TdFvN0QN
         6HjEfLXjRJsYKaADWegdPZVKMH2TOTtwl59QKO3bVamnACyuG0hTiYyZqXylSpAiIBoa
         yHCts3G3D7oJu5293qDk4WRincB8k/A4MXYZTQgLB8g1lI/Z2mt4lyUv726w6k0rBd7x
         loUz0Hx3rlE+ugeFJ1xsqDQrB8nKuPkOX8SGY8wF8wBqBjFI2MPNSVNJPyUXBTTSws/o
         gqXQ==
X-Gm-Message-State: APjAAAXMHyvIJDKC8cZNYFq4IKKGsEXmro0W3RPplKhHIMyyJM3TfNub
        8m9vhA0k79xqhqjOQ3BCO9wm8SAX0cw=
X-Google-Smtp-Source: APXvYqzQrXP8fo7INa8Uhef/3lQvDN/x78TrogDhHJ9U0yhRHBvCkfSIVNa3Dl3M5JgX8Lq4QYMMgQ==
X-Received: by 2002:a6b:8f47:: with SMTP id r68mr646937iod.204.1562798408520;
        Wed, 10 Jul 2019 15:40:08 -0700 (PDT)
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com. [209.85.166.50])
        by smtp.gmail.com with ESMTPSA id m25sm2008841ion.35.2019.07.10.15.40.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2019 15:40:05 -0700 (PDT)
Received: by mail-io1-f50.google.com with SMTP id o9so8347837iom.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2019 15:40:05 -0700 (PDT)
X-Received: by 2002:a02:c6a9:: with SMTP id o9mr688304jan.90.1562798405041;
 Wed, 10 Jul 2019 15:40:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190401171724.215780-1-dianders@chromium.org>
 <20190401171724.215780-3-dianders@chromium.org> <20190630202246.GB15102@ravnborg.org>
 <CAD=FV=V_wTD1xpkXRe-z2HsZ8QXKq7jmq8CsfhMnFxi-5XDJjw@mail.gmail.com> <20190708175007.GA3511@ravnborg.org>
In-Reply-To: <20190708175007.GA3511@ravnborg.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Wed, 10 Jul 2019 15:39:52 -0700
X-Gmail-Original-Message-ID: <CAD=FV=XnDTKkscdCwFE1137aX6pTtv=5zqXf=yqcnchpZpt5_Q@mail.gmail.com>
Message-ID: <CAD=FV=XnDTKkscdCwFE1137aX6pTtv=5zqXf=yqcnchpZpt5_Q@mail.gmail.com>
Subject: Re: [PATCH v5 2/7] drm/panel: simple: Add ability to override typical timing
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Sean Paul <seanpaul@chromium.org>, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Jeffy Chen <jeffy.chen@rock-chips.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        =?UTF-8?Q?Enric_Balletb=C3=B2?= <enric.balletbo@collabora.com>,
        =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>,
        Ezequiel Garcia <ezequiel@collabora.com>,
        Matthias Kaehlcke <mka@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sam,

On Mon, Jul 8, 2019 at 10:50 AM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi Dough.
>
> On Mon, Jul 01, 2019 at 09:39:24AM -0700, Doug Anderson wrote:
> > Hi,
> >
> > On Sun, Jun 30, 2019 at 1:22 PM Sam Ravnborg <sam@ravnborg.org> wrote:
> > >
> > > > @@ -91,6 +92,8 @@ struct panel_simple {
> > > >       struct i2c_adapter *ddc;
> > > >
> > > >       struct gpio_desc *enable_gpio;
> > > > +
> > > > +     struct drm_display_mode override_mode;
> > > I fail to see where this poiter is assigned.
> >
> > In panel_simple_parse_override_mode().  Specifically:
> >
> > drm_display_mode_from_videomode(&vm, &panel->override_mode);
>
> The above code-snippet is only called in the panel has specified display
> timings using display_timings - it is not called when display_mode is
> used.
> So override_mode is only assigned in some cases and not all cases.
> This needs to be fixed so we do not reference override_mode unless
> it is set.

I'm afraid I'm not following you here.

* override_mode is a structure that's directly part of "struct panel_simple".

* The panel is allocated in panel_simple_probe() with devm_kzalloc().

* The "z" in kzalloc means that this memory will be zero-initialized.

From the points above, "override_mode" will always be set to
something.  If we didn't run "drm_display_mode_from_videomode(&vm,
&panel->override_mode);" then we know the entire override_mode
structure will be zero.

While it took a while for me to get used to it, the kernel convention
is to rely on zero-initialization and not to explicitly init things to
zero.  As an example of this being codified in the source, you can see
that "checkpatch.pl" will yell at you for a similar thing: "do not
initialise globals to 0".


> > > @@ -152,6 +162,44 @@ static int panel_simple_get_fixed_modes(struct panel_simple *panel)
> > > >               num++;
> > > >       }
> > > >
> > > > +     return num;
> > > > +}
> > > > +
> > > > +static int panel_simple_get_non_edid_modes(struct panel_simple *panel)
> > > > +{
> > > > +     struct drm_connector *connector = panel->base.connector;
> > > > +     struct drm_device *drm = panel->base.drm;
> > > > +     struct drm_display_mode *mode;
> > > > +     bool has_override = panel->override_mode.type;
> > > This looks suspicious.
> > > panel->override_mode.type is an unsigned int that may have a number of
> > > bits set.
> > > So the above code implicitly convert a .type != 0 to a true.
> > > This can be expressed in a much more reader friendly way.
> >
> > You would suggest that I add a boolean field to a structure to
> > indicate whether an override mode is present?
> A simple  bool has_override = panel->override_mode.type != 0;
> would do the trick here.
> Then there is no hidden conversion from int to a bool.

I will change this to "panel->override_mode.type != 0" if you're
really sure, but this seems both against the general Linux style
feedback I've received over the years (though there is definitely not
100% consistency) and also against the local convention in this file.
Examples in this file of treating ints as bools without an explicit
"!= 0":

* panel_simple_get_fixed_modes checks "if (panel->desc->bus_format)"
* panel_simple_disable checks "if (p->desc->delay.disable)"
* panel_simple_unprepare checks "if (p->desc->delay.unprepare)"
* panel_simple_prepare checks "if (delay)"
* panel_simple_enable checks "if (p->desc->delay.enable)"

...and, although slightly different, pointers in this file are checked
for NULL vs. non-NULL without an explicit "== NULL".

Of course just because all the other examples in the file do it one
way doesn't mean that new code has to do it another way, but I wanted
to be really sure you wanted me to go against the existing convention
before changing this.


> But as override_mode can be NULL something more needs to be done.

I'm afraid I don't understand how override_mode can be NULL since it's
not a pointer.  Can you clarify?


-Doug
