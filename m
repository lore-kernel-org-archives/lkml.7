Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4304DC43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 01:58:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E27A2084A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 01:58:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Szp2IOTt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726285AbfFUB6G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 21:58:06 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:44063 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbfFUB6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 21:58:05 -0400
Received: by mail-vs1-f66.google.com with SMTP id v129so2822861vsb.11
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 18:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v0FbC0Xdnnb68PWmVlA2vC7ih6OKam4biQiJRuW8orc=;
        b=Szp2IOTt8MAH66bTRQ2mDk2Pfo0wUi0/7oMQgyfH6fEs59PGr+WL6otSTZ2TvBj84Y
         9zhl+I1aG4XDrcYPISzPSKY2t+lFsNawmZ+y/3eCwhkS/Qscgfohk/FjGrZlkr29kFXw
         TVx/+qhcv8lRwAP/98l1vJWFnhtUIalJBrsa4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v0FbC0Xdnnb68PWmVlA2vC7ih6OKam4biQiJRuW8orc=;
        b=rtA9K8V3Httk9fawsBJRlGlXgGRG0PJlTp/tHLXsUDjEmDOsKYCQjiUuump0dypBPw
         aKYukH0Li9vq3kL6iTqtFDKkOhTv+i2u2RF7z7APMKmH0gbxPuvGV3UizpoqA+ax08C6
         7I4qoyAED11g3VKYbpaiywDGE/Mz474U//dDdSGzrJe2MQ4ElOHFV4zd5Wo+G7EZyNw+
         5iR9hcRh1SOspqBqDAKG8tPZDJZ7n8m/QGpOIoBApp2WV1BVYfesKRBOETShco7PWDfq
         lLxvTTokE/t53c9rTPNVLjUPk1P81rqVTnFCvKd3RosKIaYdAzc5JxfYVZ9q4LkiI4zg
         2JVA==
X-Gm-Message-State: APjAAAUy+WVWru+CAYW1uDZGr3tCV+5MEhj/ZrWNGW0D1LGsiS2HKQ4r
        5iC1vYEskbfh2yTLfhg5mJNPm/gBnjztZGAGzxAzYZwE1dc=
X-Google-Smtp-Source: APXvYqynIpC8UeAIAKmqGg7+BnEM5kPsN/6M+239KLGUtn+uDjwNBpvvs8RYiwSGVVeN8P2fBnGv1nECg5lE54nmZWg=
X-Received: by 2002:a67:7d13:: with SMTP id y19mr53842535vsc.232.1561082283839;
 Thu, 20 Jun 2019 18:58:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190611040350.90064-1-dbasehore@chromium.org>
 <20190611040350.90064-4-dbasehore@chromium.org> <20190611085722.GX21222@phenom.ffwll.local>
 <CAGAzgsr2sh5B1xi_ztQPN0xoQsZd26DDXwWT_qqJ68XeKReJ_Q@mail.gmail.com>
In-Reply-To: <CAGAzgsr2sh5B1xi_ztQPN0xoQsZd26DDXwWT_qqJ68XeKReJ_Q@mail.gmail.com>
From:   "dbasehore ." <dbasehore@chromium.org>
Date:   Thu, 20 Jun 2019 18:57:52 -0700
Message-ID: <CAGAzgsoE5CgkQVhU_LSsetBRistMnuRqO7Sh+cuycMJa7QXzDg@mail.gmail.com>
Subject: Re: [PATCH 3/5] drm/panel: Add attach/detach callbacks
To:     Derek Basehore <dbasehore@chromium.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
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
Cc:     Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we want to query the device tree outside of the panel code in
helper functions, we can do this with the struct as is. There's
already a device struct pointer in drm_panel, so I think we can pull
from that.

On Tue, Jun 11, 2019 at 5:25 PM dbasehore . <dbasehore@chromium.org> wrote:
>
> On Tue, Jun 11, 2019 at 1:57 AM Daniel Vetter <daniel@ffwll.ch> wrote:
> >
> > On Mon, Jun 10, 2019 at 09:03:48PM -0700, Derek Basehore wrote:
> > > This adds the attach/detach callbacks. These are for setting up
> > > internal state for the connector/panel pair that can't be done at
> > > probe (since the connector doesn't exist) and which don't need to be
> > > repeatedly done for every get/modes, prepare, or enable callback.
> > > Values such as the panel orientation, and display size can be filled
> > > in for the connector.
> > >
> > > Signed-off-by: Derek Basehore <dbasehore@chromium.org>
> > > ---
> > >  drivers/gpu/drm/drm_panel.c | 14 ++++++++++++++
> > >  include/drm/drm_panel.h     |  4 ++++
> > >  2 files changed, 18 insertions(+)
> > >
> > > diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
> > > index 3b689ce4a51a..72f67678d9d5 100644
> > > --- a/drivers/gpu/drm/drm_panel.c
> > > +++ b/drivers/gpu/drm/drm_panel.c
> > > @@ -104,12 +104,23 @@ EXPORT_SYMBOL(drm_panel_remove);
> > >   */
> > >  int drm_panel_attach(struct drm_panel *panel, struct drm_connector *connector)
> > >  {
> > > +     int ret;
> > > +
> > >       if (panel->connector)
> > >               return -EBUSY;
> > >
> > >       panel->connector = connector;
> > >       panel->drm = connector->dev;
> > >
> > > +     if (panel->funcs->attach) {
> > > +             ret = panel->funcs->attach(panel);
> > > +             if (ret < 0) {
> > > +                     panel->connector = NULL;
> > > +                     panel->drm = NULL;
> > > +                     return ret;
> > > +             }
> > > +     }
> >
> > Why can't we just implement this in the drm helpers for everyone, by e.g.
> > storing a dt node in drm_panel? Feels a bit overkill to have these new
> > hooks here.
> >
> > Also, my understanding is that this dt stuff is supposed to be
> > standardized, so this should work.
>
> So do you want all of this information added to the drm_panel struct?
> If we do that, we don't necessarily even need the drm helper function.
> We could just copy the values over here in the drm_panel_attach
> function (and clear them in drm_panel_detach).
>
> > -Daniel
> >
> > > +
> > >       return 0;
> > >  }
> > >  EXPORT_SYMBOL(drm_panel_attach);
> > > @@ -128,6 +139,9 @@ EXPORT_SYMBOL(drm_panel_attach);
> > >   */
> > >  int drm_panel_detach(struct drm_panel *panel)
> > >  {
> > > +     if (panel->funcs->detach)
> > > +             panel->funcs->detach(panel);
> > > +
> > >       panel->connector = NULL;
> > >       panel->drm = NULL;
> > >
> > > diff --git a/include/drm/drm_panel.h b/include/drm/drm_panel.h
> > > index 13631b2efbaa..e136e3a3c996 100644
> > > --- a/include/drm/drm_panel.h
> > > +++ b/include/drm/drm_panel.h
> > > @@ -37,6 +37,8 @@ struct display_timing;
> > >   * struct drm_panel_funcs - perform operations on a given panel
> > >   * @disable: disable panel (turn off back light, etc.)
> > >   * @unprepare: turn off panel
> > > + * @detach: detach panel->connector (clear internal state, etc.)
> > > + * @attach: attach panel->connector (update internal state, etc.)
> > >   * @prepare: turn on panel and perform set up
> > >   * @enable: enable panel (turn on back light, etc.)
> > >   * @get_modes: add modes to the connector that the panel is attached to and
> > > @@ -70,6 +72,8 @@ struct display_timing;
> > >  struct drm_panel_funcs {
> > >       int (*disable)(struct drm_panel *panel);
> > >       int (*unprepare)(struct drm_panel *panel);
> > > +     void (*detach)(struct drm_panel *panel);
> > > +     int (*attach)(struct drm_panel *panel);
> > >       int (*prepare)(struct drm_panel *panel);
> > >       int (*enable)(struct drm_panel *panel);
> > >       int (*get_modes)(struct drm_panel *panel);
> > > --
> > > 2.22.0.rc2.383.gf4fbbf30c2-goog
> > >
> >
> > --
> > Daniel Vetter
> > Software Engineer, Intel Corporation
> > http://blog.ffwll.ch
