Return-Path: <SRS0=3QRk=U6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 768F6C0650E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 16:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41BC321479
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jul 2019 16:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BLEh6NVQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729460AbfGAQjk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jul 2019 12:39:40 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:33090 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728187AbfGAQjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jul 2019 12:39:40 -0400
Received: by mail-io1-f65.google.com with SMTP id u13so30334397iop.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 09:39:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=p18mI6/20bFKypRld06SAfi0/go3QKljAqtkFENCpmc=;
        b=BLEh6NVQjzd/lDI/fhA9TxE0gONI1OE1ADRQfc/gHNWpXo0HGOhu11uzc9cS4nskJy
         U57jmZFkZcXb1fIUlf4tYzexTdASwXIKatQvOJc6tPxJz4k+kmXspvtvNIYo2Vm4puH4
         on/9bZA0CjrU7ISIb0+QA7DfGck8w2sNeSdeQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=p18mI6/20bFKypRld06SAfi0/go3QKljAqtkFENCpmc=;
        b=qjnHz+BcZcVt7KYkDko3FWcACh+0hYlO8F6xdKaIHwQr00siXJvOZ8gZa6MDWaHu3e
         KISec7i2soDmJ8rcWLbQC1R5nmiGhrQLJix7abqoLtmZpqqwZHwlk2kNV+3qRH1XG9zA
         V0oar8M0jEgavGNhqR36W6VIsOuK7sWo6fM4GFWPeAGeOi0nmkCpIn3niOH70zA7Nq19
         wC0BXlpEko0RO+CnlxhYcB5MfitDK5u+072BONvO4oUmzkHBVg4wWc6wg3lslxzChWId
         GB/zsYMinC3P7P/SW9Z9DgVCYDrytC/ocPzfiXYFTE5k9hErQXMJ5uHiqJ11nUl65cjk
         BSfg==
X-Gm-Message-State: APjAAAVDvsS6dp6+W2SAIm2PUJ4Z3m7Vj5hDIL+oiMdu9eMC4/gXu/5S
        jx2B5QA899lm73DOxOX0hPZ4OE56ERI=
X-Google-Smtp-Source: APXvYqxKTRAiQ0L713IH1gwtd76jjYXT0MU6cct1N6BmVr1YwK1HVivYqzVhO1PyxX3L9RjXPWUXlw==
X-Received: by 2002:a5d:8347:: with SMTP id q7mr25978424ior.277.1561999179053;
        Mon, 01 Jul 2019 09:39:39 -0700 (PDT)
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com. [209.85.166.54])
        by smtp.gmail.com with ESMTPSA id b20sm9261950ios.44.2019.07.01.09.39.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 09:39:37 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id h6so30333603ioh.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2019 09:39:37 -0700 (PDT)
X-Received: by 2002:a5e:c241:: with SMTP id w1mr5709959iop.58.1561999176456;
 Mon, 01 Jul 2019 09:39:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190401171724.215780-1-dianders@chromium.org>
 <20190401171724.215780-3-dianders@chromium.org> <20190630202246.GB15102@ravnborg.org>
In-Reply-To: <20190630202246.GB15102@ravnborg.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 1 Jul 2019 09:39:24 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V_wTD1xpkXRe-z2HsZ8QXKq7jmq8CsfhMnFxi-5XDJjw@mail.gmail.com>
Message-ID: <CAD=FV=V_wTD1xpkXRe-z2HsZ8QXKq7jmq8CsfhMnFxi-5XDJjw@mail.gmail.com>
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

Hi,

On Sun, Jun 30, 2019 at 1:22 PM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> > @@ -91,6 +92,8 @@ struct panel_simple {
> >       struct i2c_adapter *ddc;
> >
> >       struct gpio_desc *enable_gpio;
> > +
> > +     struct drm_display_mode override_mode;
> I fail to see where this poiter is assigned.

In panel_simple_parse_override_mode().  Specifically:

drm_display_mode_from_videomode(&vm, &panel->override_mode);


> @@ -152,6 +162,44 @@ static int panel_simple_get_fixed_modes(struct panel_simple *panel)
> >               num++;
> >       }
> >
> > +     return num;
> > +}
> > +
> > +static int panel_simple_get_non_edid_modes(struct panel_simple *panel)
> > +{
> > +     struct drm_connector *connector = panel->base.connector;
> > +     struct drm_device *drm = panel->base.drm;
> > +     struct drm_display_mode *mode;
> > +     bool has_override = panel->override_mode.type;
> This looks suspicious.
> panel->override_mode.type is an unsigned int that may have a number of
> bits set.
> So the above code implicitly convert a .type != 0 to a true.
> This can be expressed in a much more reader friendly way.

You would suggest that I add a boolean field to a structure to
indicate whether an override mode is present?  I will certainly do
that if you're sure that's what you want, but my understanding of the
convention for much of the kernel is that you generally rely on
structures being zero-initialized and then (assuming that zero isn't a
valid value) it's safe to confirm they've been initialized by seeing
that they're non-zero.

In this case panel_simple_parse_override_mode() will _definitely_ set
a non-zero value for this field in the case that it ran to completion.
...and, even further, the end of that function has a WARN_ON() if it
doesn't.

Any chance you missed reading panel_simple_parse_override_mode() in
the original patch?


> And on top of this, I cannot see that panel->override_mode points to a
> valid instance of display_mode, at least not always.

override_mode isn't a pointer, right?  It's a structure straight in
the panel.  So all its fields will be initted to 0 by the kzalloc in
panel_simple_probe().  If the type is non-zero then we know
panel_simple_parse_override_mode() finished to completion.


> > @@ -268,7 +316,7 @@ static int panel_simple_get_modes(struct drm_panel *panel)
> >       }
> >
> >       /* add hard-coded panel modes */
> > -     num += panel_simple_get_fixed_modes(p);
> > +     num += panel_simple_get_non_edid_modes(p);
> >
> >       return num;
> >  }
> > @@ -299,10 +347,58 @@ static const struct drm_panel_funcs panel_simple_funcs = {
> >       .get_timings = panel_simple_get_timings,
> >  };
> >
> > +#define PANEL_SIMPLE_BOUNDS_CHECK(to_check, bounds, field) \
> > +     (to_check->field.typ >= bounds->field.min && \
> > +      to_check->field.typ <= bounds->field.max)
> > +static void panel_simple_parse_override_mode(struct device *dev,
> > +                                          struct panel_simple *panel,
> > +                                          const struct display_timing *ot)
> > +{
> > +     const struct panel_desc *desc = panel->desc;
> > +     struct videomode vm;
> > +     unsigned int i;
> > +
> > +     if (WARN_ON(desc->num_modes)) {
> > +             dev_err(dev, "Reject override mode: panel has a fixed mode\n");
> > +             return;
> > +     }
> > +     if (WARN_ON(!desc->num_timings)) {
> > +             dev_err(dev, "Reject override mode: no timings specified\n");
> > +             return;
> > +     }
> > +
> > +     for (i = 0; i < panel->desc->num_timings; i++) {
> > +             const struct display_timing *dt = &panel->desc->timings[i];
> > +
> > +             if (!PANEL_SIMPLE_BOUNDS_CHECK(ot, dt, hactive) ||
> > +                 !PANEL_SIMPLE_BOUNDS_CHECK(ot, dt, hfront_porch) ||
> > +                 !PANEL_SIMPLE_BOUNDS_CHECK(ot, dt, hback_porch) ||
> > +                 !PANEL_SIMPLE_BOUNDS_CHECK(ot, dt, hsync_len) ||
> > +                 !PANEL_SIMPLE_BOUNDS_CHECK(ot, dt, vactive) ||
> > +                 !PANEL_SIMPLE_BOUNDS_CHECK(ot, dt, vfront_porch) ||
> > +                 !PANEL_SIMPLE_BOUNDS_CHECK(ot, dt, vback_porch) ||
> > +                 !PANEL_SIMPLE_BOUNDS_CHECK(ot, dt, vsync_len))
> > +                     continue;
> > +
> > +             if (ot->flags != dt->flags)
> > +                     continue;
> The binding do not say anything about flags. Is this check really
> needed?

Flags here is an implementation detail of the Linux driver and the
bindings are supposed to be Linux-agnostic.  The bindings started out
talking about lots of stuff that happened in the driver and I was told
to take all those out.  ;-)

Specifically note that flags here holds whether we have specified a
positive or negative for hsync or vsync.  These are the "hsync-active"
and "vsync-active" properties of the panel bindings.  Take a look at
of_parse_display_timing().

...so to summarize the flags here is just a different set of
properties to check like the checks above.


> > +
> > +             videomode_from_timing(ot, &vm);
> > +             drm_display_mode_from_videomode(&vm, &panel->override_mode);
>
> > +             panel->override_mode.type |= DRM_MODE_TYPE_DRIVER |
> > +                                          DRM_MODE_TYPE_PREFERRED;
> > +             break;
> > +     }
> > +
> > +     if (WARN_ON(!panel->override_mode.type))
> > +             dev_err(dev, "Reject override mode: No display_timing found\n");
> > +}
> > +
> >  static int panel_simple_probe(struct device *dev, const struct panel_desc *desc)
> >  {
> >       struct device_node *backlight, *ddc;
> >       struct panel_simple *panel;
> > +     struct display_timing dt;
> >       int err;
> >
> >       panel = devm_kzalloc(dev, sizeof(*panel), GFP_KERNEL);
> > @@ -348,6 +444,9 @@ static int panel_simple_probe(struct device *dev, const struct panel_desc *desc)
> >               }
> >       }
> >
> > +     if (!of_get_display_timing(dev->of_node, "panel-timing", &dt))
> > +             panel_simple_parse_override_mode(dev, panel, &dt);
> > +
> Naming bike-shedding.
> With the new node name, the function name
> panel_simple_parse_override_mode() could use an update.
> Maybe: panel_simple_parse_panel_timing_node()

Happy to change the name to panel_simple_parse_panel_timing_node().

---

Summary of the above:

* Unless you say otherwise, I will leave the check of "type != 0" and
not introduce a new boolean.

* Only action request is rename of panel_simple_parse_override_mode()
to panel_simple_parse_panel_timing_node()

NOTE: Since this feedback is minor and this patch has been outstanding
for a while (and is blocking other work), I am assuming that the best
path forward is for Heiko to land this patch with Thierry's Ack and
I'll send a follow-up.  Please yell if you disagree.  I'll respond to
each of your emails separately and then wait for your response before
sending the follow-up series.


-Doug
