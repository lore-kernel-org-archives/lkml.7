Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C245EC31E45
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 00:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F3B420B7C
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 00:32:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QSPL5o2o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfFNAce (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 20:32:34 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:43132 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725835AbfFNAcd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jun 2019 20:32:33 -0400
Received: by mail-vs1-f66.google.com with SMTP id j26so659984vsn.10
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2019 17:32:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5o5a2UNvqnt2IqG/d30r1Z1PI+lkRFVIZCDDvP3GRa4=;
        b=QSPL5o2oBNVzptcEqAin35G0xLo0WWvgdOOO2+lJQerKfjKIYK/6oBSgxbDxGyOeXK
         xc1Z2RyR8khlsHj7h/56FHn401h/hL1ihSqJACQe/klR228W7RgTufBtib0cQQpfqY5/
         S4NO2rnjTaZdsxN6OkMcnGXhGm9ft7LyISYAE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5o5a2UNvqnt2IqG/d30r1Z1PI+lkRFVIZCDDvP3GRa4=;
        b=Gg479Dkf8nlWCYFd7QlBmYPhAmWfCIFDGbTVL7ZKbry1JNpBtQ5b+t45NUGffNXuFh
         rK84Ul5VeGtsW/BbCz2c2BGFAaoIpFBaZb8rGSQZhFEgy3T+KCqZbIak46XMKGAFAAmb
         flqJ+5wY2f5imJxnJBjWxzgqFVMQVGRlEFJ4UpLQB+L7sGRor3jYh7kvOYjz32FspaEY
         fe6KOtNZa4yye96jUIPJQ9Zg7ilceqdkMzH6BJALhjiK4+ahx1UyPA2+bt5wgWTIwGJa
         jt8Ob3cLMsRagVnzjXWJMpeknncZ9GIU3ESniLxAicgLTJXnOutquNXdDGrIU2uC5FSN
         QgkQ==
X-Gm-Message-State: APjAAAUZJ5qjhV79AxlQfjyWB2wCmUuKetqX+wdctOAQb9qy3hudqHXj
        ljEOwUUsxVQKEc2E0AKHYRQIhSpVHTNvusNVaqcInA==
X-Google-Smtp-Source: APXvYqyFuFyDZEX0VGqPH3v35EIiUK6ftc8JlgTdYuQL9iHMbG0bt8E4uHg/PoKRrVKv16C9BEZM1mqeIvYNB77SyX0=
X-Received: by 2002:a67:d384:: with SMTP id b4mr18708468vsj.152.1560472352531;
 Thu, 13 Jun 2019 17:32:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190611040350.90064-1-dbasehore@chromium.org>
 <20190611040350.90064-2-dbasehore@chromium.org> <20190612212054.GB13155@ravnborg.org>
In-Reply-To: <20190612212054.GB13155@ravnborg.org>
From:   "dbasehore ." <dbasehore@chromium.org>
Date:   Thu, 13 Jun 2019 17:32:21 -0700
Message-ID: <CAGAzgspS_cSDYDUTgApK4R814r3gZk63oe+CdtqDuiXrTG5JdA@mail.gmail.com>
Subject: Re: [PATCH 1/5] drm/panel: Add helper for reading DT rotation
To:     Sam Ravnborg <sam@ravnborg.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        CK Hu <ck.hu@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 12, 2019 at 2:20 PM Sam Ravnborg <sam@ravnborg.org> wrote:
>
> Hi Derek.
>
> On Mon, Jun 10, 2019 at 09:03:46PM -0700, Derek Basehore wrote:
> > This adds a helper function for reading the rotation (panel
> > orientation) from the device tree.
> >
> > Signed-off-by: Derek Basehore <dbasehore@chromium.org>
> > ---
> >  drivers/gpu/drm/drm_panel.c | 41 +++++++++++++++++++++++++++++++++++++
> >  include/drm/drm_panel.h     |  7 +++++++
> >  2 files changed, 48 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
> > index dbd5b873e8f2..3b689ce4a51a 100644
> > --- a/drivers/gpu/drm/drm_panel.c
> > +++ b/drivers/gpu/drm/drm_panel.c
> > @@ -172,6 +172,47 @@ struct drm_panel *of_drm_find_panel(const struct device_node *np)
> >       return ERR_PTR(-EPROBE_DEFER);
> >  }
> >  EXPORT_SYMBOL(of_drm_find_panel);
> > +
> > +/**
> > + * of_drm_get_panel_orientation - look up the rotation of the panel using a
> > + * device tree node
> > + * @np: device tree node of the panel
> > + * @orientation: orientation enum to be filled in
> > + *
> > + * Looks up the rotation of a panel in the device tree. The rotation in the
> > + * device tree is counter clockwise.
> > + *
> > + * Return: 0 when a valid rotation value (0, 90, 180, or 270) is read or the
> > + * rotation property doesn't exist. -EERROR otherwise.
> > + */
> > +int of_drm_get_panel_orientation(const struct device_node *np, int *orientation)
> > +{
> > +     int rotation, ret;
> > +
> > +     ret = of_property_read_u32(np, "rotation", &rotation);
>
> I just noticed that everywhere this code talks about orientation,
> but the property that it reads are rotation.
> To my best understanding these are not the same.

This is because both were previously defined in the kernel. Rotation
was defined as a binding in the devicetree for panels (which is where
we wanted to put this property) and orientation already exists as a
DRM property.

If we want to change one, I would suggest the rotation binding since
it doesn't have any upstream users yet.

>
>         Sam
