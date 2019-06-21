Return-Path: <SRS0=s1fu=UU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D5B1C43613
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 09:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC8C320665
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Jun 2019 09:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AtY+EMm+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbfFUJTe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Jun 2019 05:19:34 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35943 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbfFUJTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 05:19:34 -0400
Received: by mail-wm1-f65.google.com with SMTP id u8so5814136wmm.1;
        Fri, 21 Jun 2019 02:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=uqOVQTxmNExiORglBPUYXCzHT8Z+/V19PnzivbaHVFg=;
        b=AtY+EMm+8qKifhQvPhh0SzfwY8M40OwmQaZCjKlTFlON5z0akSBcx0Fj8962OPK3ax
         qSeCVT1pZ7yHTxx1zUODdIkRlJf0v2QfrzZ0vXrWHmop2DQLKfQxfTbLBOBUC3Fxovef
         hDWBmtqxaYo6hkz7FeuQGR9PkIz/Zg6AGkClzwe+5erBgT7hzbe60jJOYiN54ZTgWgFU
         IpuQhCE6lGLTOnsgqCJda4W/R3IpPzppR+Jz8j05S+TyH4UcgUcxA+vs3ci829X4uaaC
         UJKoOhqFMxgLLlRlQN2h2ZniFUDim5S9N8yK6CW5Ff2EI0fqFEnV3fTcbrlZl1Xf0ebw
         7e5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=uqOVQTxmNExiORglBPUYXCzHT8Z+/V19PnzivbaHVFg=;
        b=eauckQPq24eVQZqCmzqLjhOYHu0h7QEIVx7jE/gj7ozxtdTKBJfW4E6AhpWNLJ3QVf
         xaaDMBkQlte4bm7O1ydq9FZsvEq14WD6vWvAKQMs6KgTuGljnKyqgmU2OY+rXh88BIRe
         8sz1VhhFzfkS59GiqA4zhBzbFFldEeOaQ3d3d3weug89SfugXi3w+n42x2U8eqKmxxce
         oRcFItEF6Tv+VKuPTpXG4zS7W+EkFZ6ifj/TnssKQhoAHhC7VwtohPVGiRrhxYp7HRfA
         wq6A3Dc9gY2FbCsjTSkWRGiXR13IZPi8TNe7e/q2Cwr/rz8RLRwgvioqy+YwdzbPV1eu
         iQMA==
X-Gm-Message-State: APjAAAV7Xrfrp6h5hIHL1CWYqi1nTA4ucrXvtm1gWRbzA5Y+gSIrkJrp
        Hx1FUk45ycRR4jdI3ZQbyik=
X-Google-Smtp-Source: APXvYqyqeaEKJauyN71saFZvZTDk0qi91ACjIQXrzW5Yfpqp1okzyBsUv4pQHA0207ShjTomFKY7Lw==
X-Received: by 2002:a1c:4b1a:: with SMTP id y26mr3294210wma.105.1561108771060;
        Fri, 21 Jun 2019 02:19:31 -0700 (PDT)
Received: from localhost (p2E5BEF36.dip0.t-ipconnect.de. [46.91.239.54])
        by smtp.gmail.com with ESMTPSA id r12sm1761771wrt.95.2019.06.21.02.19.29
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 21 Jun 2019 02:19:30 -0700 (PDT)
Date:   Fri, 21 Jun 2019 11:19:28 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     "dbasehore ." <dbasehore@chromium.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
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
        <linux-mediatek@lists.infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH 3/5] drm/panel: Add attach/detach callbacks
Message-ID: <20190621091928.GA11839@ulmo>
References: <20190611040350.90064-1-dbasehore@chromium.org>
 <20190611040350.90064-4-dbasehore@chromium.org>
 <20190611085722.GX21222@phenom.ffwll.local>
 <CAGAzgsr2sh5B1xi_ztQPN0xoQsZd26DDXwWT_qqJ68XeKReJ_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="cWoXeonUoKmBZSoM"
Content-Disposition: inline
In-Reply-To: <CAGAzgsr2sh5B1xi_ztQPN0xoQsZd26DDXwWT_qqJ68XeKReJ_Q@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--cWoXeonUoKmBZSoM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2019 at 05:25:47PM -0700, dbasehore . wrote:
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
> > >  int drm_panel_attach(struct drm_panel *panel, struct drm_connector *=
connector)
> > >  {
> > > +     int ret;
> > > +
> > >       if (panel->connector)
> > >               return -EBUSY;
> > >
> > >       panel->connector =3D connector;
> > >       panel->drm =3D connector->dev;
> > >
> > > +     if (panel->funcs->attach) {
> > > +             ret =3D panel->funcs->attach(panel);
> > > +             if (ret < 0) {
> > > +                     panel->connector =3D NULL;
> > > +                     panel->drm =3D NULL;
> > > +                     return ret;
> > > +             }
> > > +     }
> >
> > Why can't we just implement this in the drm helpers for everyone, by e.=
g.
> > storing a dt node in drm_panel? Feels a bit overkill to have these new
> > hooks here.
> >
> > Also, my understanding is that this dt stuff is supposed to be
> > standardized, so this should work.
>=20
> So do you want all of this information added to the drm_panel struct?
> If we do that, we don't necessarily even need the drm helper function.
> We could just copy the values over here in the drm_panel_attach
> function (and clear them in drm_panel_detach).

Yeah, I think we should have all this extra information in the struct
drm_panel. However, I think we need to more carefully split things such
that the DT parsing happens at panel probe time. That way we can catch
errors in DT, or missing entries/resources when we can still do
something about it.

If we start parsing DT and encounter failures, it's going to be very
confusing if that's at panel attach time where code will usually just
assume that everything is already validated and can't fail anymore.

Thierry

--cWoXeonUoKmBZSoM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAl0MoR0ACgkQ3SOs138+
s6HqSA/+K8hfGyhC4XmLpKlVudKyrd41RyGRD7AunVOl6aE/CaukHevacdCPSUtk
d/jaIe1fC3ImLE/uIZQDQBsBL3JzwrJHo0RVxijTJ7P9X1jrMR1ynK5sOWW0dPxR
Sd87iKVNNu0Rl8CxAYzucxHrr2Up2W6uT02H0Lbxk+idIWKixRrPbUAVCMpFHTyr
MbaVLkRd1sOEqLzetlU7HoUCx3wKgWdQgeRllgTDYgGutEQWnizljTrTglT0IAeQ
U2LAykWBhhM4LBxYoEcdfOnosYQpKrg9suaNHNXknN+KEB5lnt/UbWCi5poLg1P4
vyXMGFN8GwXXRNEKP0hYKGlLTzM19i3g9FRXAzeKv1hxmYhdG6S3dnzX22TG75No
g0mUT2aFCEImAtMtQaCsucDHAnU/+YfmTekla4NxZo2UdOh0GYyKTaZ8OKsaETu+
Hb+l76/ebe16vU+nJUYzKF5i/T+UlplLKLLGF8ivNBDSbWDD4l5Gh+hec2akFAVd
U/CvEE85FyPaUIM9rTztStgICDwaxJNk62apvYouCkIIHOR3QVlgkxvk6DM6O5/c
AjfC0dJqHvnx1HYiD0Sz65SeWArm/ujA1tcNZAFKLtPN2P5CHo6b2P2C1DfclkCw
HBVMLmjbClz3caQjKmTvXk9YSnSSZBejdPW6zptywAik+UBj2r0=
=ph6O
-----END PGP SIGNATURE-----

--cWoXeonUoKmBZSoM--
