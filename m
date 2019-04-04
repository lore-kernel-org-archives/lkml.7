Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E910BC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 17:09:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAD742082E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 17:09:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r/8Giy1W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729534AbfDDRJR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 13:09:17 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37777 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbfDDRJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 13:09:16 -0400
Received: by mail-wr1-f68.google.com with SMTP id w10so4763185wrm.4;
        Thu, 04 Apr 2019 10:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=1QXYzhB1C9JXhfKFXHrnZIEuSOQCYdHCN0Etm6FsMDQ=;
        b=r/8Giy1W0rv6k6VwxSjnx771lQWaPEgpp04Ek/NcpQ+I5uza8dN9gY2eYcy6f6KhMT
         lFnhoo228+9m36tw99d8hHZrRILlyM/eDn2LVL0RwnP30UfhKhXcT4EMQFpyCJga976g
         87TCm3y/CKqbrVCJL7cBu4HPa7xAjA2QUiSo/oF+k7OL73L8/P33PaYH5rOhJ7H0hhHE
         7ak0R2Z3UetPiu5Y9kzb/6QSRxKfPonKh16SEWPiyGXq8s5gg5mO2IWd0o3CRbRYniXY
         L1SVABlISNA/j775mCaoDunkMgph5wI7cv74IdXnbqo3DEKhb0j/JZekgptrLkzLWbr8
         bytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=1QXYzhB1C9JXhfKFXHrnZIEuSOQCYdHCN0Etm6FsMDQ=;
        b=HKjtwzhHabroqXK2mjLfJ95BqDKWuPaJsTNWJAQmqgtGesDsj7+NIA8/SwQBFZ+rTG
         WUe4v7jOzEwbXW7HQn3YEMHz5ZBrKZBu0qLbe3XDFZFESqlIB8PaTtLZCsSHs4lusO92
         0RF4DzYuvzGKO2xpW1D1cg51yPTNfWSuPVQr9NKdhlw5Yis2HVpJBTOzLG8xI1YJhNFs
         vHnKPE43PA4MLR1CUmbuXutwwJ9LENcOZUDGS4W4Gy4nJLpMp/rZgbbUDCzBsYdg1VL7
         LL99wYVq1OxOQqBu9e8GW96C+KOBJ76PjGDTKAE2NICxKyJnQU4gWbw0//9+JikYfzfd
         7tMg==
X-Gm-Message-State: APjAAAUc/sWbGvs3yvDeEnthFtosIAJ+Hn7vvqsvPf8qPctFo+5qixOw
        J3wIWcflq+oR+U5YWJFoyLg=
X-Google-Smtp-Source: APXvYqy0rw8fqFaNiCt8ZDQvL77+/874eYDtxtauP6DQHKwqHsoAj47g8aIXt3nnZfG+Im/v8JRp3A==
X-Received: by 2002:adf:b60a:: with SMTP id f10mr4845812wre.116.1554397754527;
        Thu, 04 Apr 2019 10:09:14 -0700 (PDT)
Received: from localhost (pD9E51B25.dip0.t-ipconnect.de. [217.229.27.37])
        by smtp.gmail.com with ESMTPSA id s1sm13484620wrt.43.2019.04.04.10.09.13
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Apr 2019 10:09:13 -0700 (PDT)
Date:   Thu, 4 Apr 2019 19:09:13 +0200
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Guido =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>
Cc:     Joe Perches <joe@perches.com>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Johan Hovold <johan@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH] drm/panel: Rocktech jh057n00900: Add terminating
 newlines to logging
Message-ID: <20190404170913.GB3078@ulmo>
References: <cover.1554114302.git.agx@sigxcpu.org>
 <20190403161735.GN5238@ulmo>
 <1ed5eb3af4df6b2dd1544c7b696e034ed5c94f06.camel@perches.com>
 <20190404105359.GA8255@bogon.m.sigxcpu.org>
 <da6f2344396555034cf2476c8338b0ce1c56e0a7.camel@perches.com>
 <20190404154850.GA19334@bogon.m.sigxcpu.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="yNb1oOkm5a9FJOVX"
Content-Disposition: inline
In-Reply-To: <20190404154850.GA19334@bogon.m.sigxcpu.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yNb1oOkm5a9FJOVX
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 04, 2019 at 05:48:50PM +0200, Guido G=C3=BCnther wrote:
> Hi Joe,
> On Thu, Apr 04, 2019 at 08:06:09AM -0700, Joe Perches wrote:
> > These were missing '\n' terminations, add them.
> >=20
> > Signed-off-by: Joe Perches <joe@perches.com>
> > ---
> >  drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c | 19 ++++++++++----=
-----
> >  1 file changed, 10 insertions(+), 9 deletions(-)
> >=20
> > diff --git a/drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c b/drive=
rs/gpu/drm/panel/panel-rocktech-jh057n00900.c
> > index 158a6d548068..d88ea8da2ec2 100644
> > --- a/drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c
> > +++ b/drivers/gpu/drm/panel/panel-rocktech-jh057n00900.c
> > @@ -123,7 +123,7 @@ static int jh057n_init_sequence(struct jh057n *ctx)
> > =20
> >  	ret =3D mipi_dsi_dcs_exit_sleep_mode(dsi);
> >  	if (ret < 0) {
> > -		DRM_DEV_ERROR(dev, "Failed to exit sleep mode");
> > +		DRM_DEV_ERROR(dev, "Failed to exit sleep mode\n");
> >  		return ret;
> >  	}
> >  	/* Panel is operational 120 msec after reset */
> > @@ -132,7 +132,7 @@ static int jh057n_init_sequence(struct jh057n *ctx)
> >  	if (ret)
> >  		return ret;
> > =20
> > -	DRM_DEV_DEBUG_DRIVER(dev, "Panel init sequence done");
> > +	DRM_DEV_DEBUG_DRIVER(dev, "Panel init sequence done\n");
> >  	return 0;
> >  }
> > =20
> > @@ -172,7 +172,7 @@ static int jh057n_prepare(struct drm_panel *panel)
> >  	if (ctx->prepared)
> >  		return 0;
> > =20
> > -	DRM_DEV_DEBUG_DRIVER(ctx->dev, "Resetting the panel.");
> > +	DRM_DEV_DEBUG_DRIVER(ctx->dev, "Resetting the panel\n");
> >  	gpiod_set_value_cansleep(ctx->reset_gpio, 1);
> >  	usleep_range(20, 40);
> >  	gpiod_set_value_cansleep(ctx->reset_gpio, 0);
> > @@ -180,7 +180,8 @@ static int jh057n_prepare(struct drm_panel *panel)
> > =20
> >  	ret =3D jh057n_init_sequence(ctx);
> >  	if (ret < 0) {
> > -		DRM_DEV_ERROR(ctx->dev, "Panel init sequence failed: %d", ret);
> > +		DRM_DEV_ERROR(ctx->dev, "Panel init sequence failed: %d\n",
> > +			      ret);
> >  		return ret;
> >  	}
> > =20
> > @@ -212,7 +213,7 @@ static int jh057n_get_modes(struct drm_panel *panel)
> > =20
> >  	mode =3D drm_mode_duplicate(panel->drm, &default_mode);
> >  	if (!mode) {
> > -		DRM_DEV_ERROR(ctx->dev, "Failed to add mode %ux%u@%u",
> > +		DRM_DEV_ERROR(ctx->dev, "Failed to add mode %ux%u@%u\n",
> >  			      default_mode.hdisplay, default_mode.vdisplay,
> >  			      default_mode.vrefresh);
> >  		return -ENOMEM;
> > @@ -241,7 +242,7 @@ static int allpixelson_set(void *data, u64 val)
> >  	struct jh057n *ctx =3D data;
> >  	struct mipi_dsi_device *dsi =3D to_mipi_dsi_device(ctx->dev);
> > =20
> > -	DRM_DEV_DEBUG_DRIVER(ctx->dev, "Setting all pixels on");
> > +	DRM_DEV_DEBUG_DRIVER(ctx->dev, "Setting all pixels on\n");
> >  	dsi_generic_write_seq(dsi, ST7703_CMD_ALL_PIXEL_ON);
> >  	msleep(val * 1000);
> >  	/* Reset the panel to get video back */
> > @@ -290,7 +291,7 @@ static int jh057n_probe(struct mipi_dsi_device *dsi)
> > =20
> >  	ctx->reset_gpio =3D devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
> >  	if (IS_ERR(ctx->reset_gpio)) {
> > -		DRM_DEV_ERROR(dev, "cannot get reset gpio");
> > +		DRM_DEV_ERROR(dev, "cannot get reset gpio\n");
> >  		return PTR_ERR(ctx->reset_gpio);
> >  	}
> > =20
> > @@ -315,12 +316,12 @@ static int jh057n_probe(struct mipi_dsi_device *d=
si)
> > =20
> >  	ret =3D mipi_dsi_attach(dsi);
> >  	if (ret < 0) {
> > -		DRM_DEV_ERROR(dev, "mipi_dsi_attach failed. Is host ready?");
> > +		DRM_DEV_ERROR(dev, "mipi_dsi_attach failed. Is host ready?\n");
> >  		drm_panel_remove(&ctx->panel);
> >  		return ret;
> >  	}
> > =20
> > -	DRM_DEV_INFO(dev, "%ux%u@%u %ubpp dsi %udl - ready",
> > +	DRM_DEV_INFO(dev, "%ux%u@%u %ubpp dsi %udl - ready\n",
> >  		     default_mode.hdisplay, default_mode.vdisplay,
> >  		     default_mode.vrefresh,
> >  		     mipi_dsi_pixel_format_to_bpp(dsi->format), dsi->lanes);
> >=20
>=20
> Reviewed-By: Guido G=C3=BCnther <agx@sigxcpu.org>

Nit: the correct tag is "Reviewed-by:", note the lowercase "by". I only
noticed because checkpatch complained, and fixed it up.

Thierry

--yNb1oOkm5a9FJOVX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAlymOjgACgkQ3SOs138+
s6G40Q//cfa/g8ByBehQaJpVRytIu6Yf5hdfJSIzvX++ulaGkhNnUs74vMkCkhbj
rkQ4c7OTv+zL0CEHb4WicWB8DKDWYCz3BU8I3BkHmlrBdbEnm1dK1R8L6vmIpR0K
XMSoyydNQxSOT7iykt7WXYaHy2eTRR1jePGKbDHVZyRcZoT0T/k+ae057GEju0BH
E6xt7ztcWXSRVxjW6KrmaF/sSvVGUDKsp2dBDOEHM0wDSZk09Avjf53LrP6UbDYX
3M7TeNoHW/FGP1AKTgXgNvdqsTvRL9PS8hp9EBFJqso8C9L59R4F282xRnvGnBnd
4Pw6K2Zo1gQdv+08oFwnSaP/CwOLzVROvCdRvuZsI6khUgtY9veyxcXTUnVxg6Aq
83V7OzMFplaK4OCfDrWoef2ISZaF1+TJxc10uskj/yQiLydY3l82Zgdtu9890LJZ
wcqAIi/+iIm7ADp1WnHzr+LauJf/mFc0NCFyUsmiVgWC48E70rt05OpYZbjLKLVH
RLjObOloJqyqywpGD+2VYpljAzn8wbzEknPP4iS2nJpbjSbtLSijnXhN+iBXPwRm
xJNLT252WwE77eoZzsZ8cqsCtS40SWcAOgRpVN0uDS4R6prN/L/b5smefAuGulbQ
xuXHXxrt7dGa+LOx0cnp/qYbN5s2rUchmbD5V3EQQPUVP7Nun/w=
=7pLZ
-----END PGP SIGNATURE-----

--yNb1oOkm5a9FJOVX--
