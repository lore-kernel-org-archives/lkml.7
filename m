Return-Path: <SRS0=xYIU=RV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C1EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D79D020872
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Mar 2019 15:50:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727650AbfCRPuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Mar 2019 11:50:17 -0400
Received: from relay7-d.mail.gandi.net ([217.70.183.200]:59255 "EHLO
        relay7-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbfCRPuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Mar 2019 11:50:17 -0400
X-Originating-IP: 90.88.22.102
Received: from localhost (aaubervilliers-681-1-80-102.w90-88.abo.wanadoo.fr [90.88.22.102])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay7-d.mail.gandi.net (Postfix) with ESMTPSA id 5918320005;
        Mon, 18 Mar 2019 15:50:14 +0000 (UTC)
Date:   Mon, 18 Mar 2019 16:50:13 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     =?utf-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>
Cc:     David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/sun4i: hdmi: add support for ddc-i2c-bus property
Message-ID: <20190318155013.lge2x2cp5hvyz52f@flea>
References: <20190311134713.25876-1-mans@mansr.com>
 <20190311154702.eslw5ccol44vxcmy@flea>
 <yw1xef7d4cit.fsf@mansr.com>
 <20190314154105.o6r7hzeuiyajxh7v@flea>
 <yw1xk1h130ba.fsf@mansr.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="zgta55aho4vg3yl5"
Content-Disposition: inline
In-Reply-To: <yw1xk1h130ba.fsf@mansr.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--zgta55aho4vg3yl5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2019 at 04:09:13PM +0000, M=E5ns Rullg=E5rd wrote:
> Maxime Ripard <maxime.ripard@bootlin.com> writes:
>
> > On Mon, Mar 11, 2019 at 04:11:06PM +0000, M=E5ns Rullg=E5rd wrote:
> >> Maxime Ripard <maxime.ripard@bootlin.com> writes:
> >>
> >> > Hi!
> >> >
> >> > On Mon, Mar 11, 2019 at 01:47:13PM +0000, Mans Rullgard wrote:
> >> >> Sometimes it is desirabled to use a separate i2c controller for ddc
> >> >> access.  This adds support for the ddc-i2c-bus property of the
> >> >> hdmi-connector node, using the specified controller if provided.
> >> >>
> >> >> Signed-off-by: Mans Rullgard <mans@mansr.com>
> >> >> ---
> >> >>  drivers/gpu/drm/sun4i/sun4i_hdmi.h     |  1 +
> >> >>  drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c | 37 ++++++++++++++++++++++=
+---
> >> >>  2 files changed, 35 insertions(+), 3 deletions(-)
> >> >>
> >> >> diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi.h b/drivers/gpu/drm/s=
un4i/sun4i_hdmi.h
> >> >> index b685ee11623d..b08c4453d47c 100644
> >> >> --- a/drivers/gpu/drm/sun4i/sun4i_hdmi.h
> >> >> +++ b/drivers/gpu/drm/sun4i/sun4i_hdmi.h
> >> >> @@ -269,6 +269,7 @@ struct sun4i_hdmi {
> >> >>  	struct clk		*tmds_clk;
> >> >>
> >> >>  	struct i2c_adapter	*i2c;
> >> >> +	struct i2c_adapter	*ddc_i2c;
> >> >>
> >> >>  	/* Regmap fields for I2C adapter */
> >> >>  	struct regmap_field	*field_ddc_en;
> >> >> diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c b/drivers/gpu/d=
rm/sun4i/sun4i_hdmi_enc.c
> >> >> index 061d2e0d9011..5b2fac79f5d6 100644
> >> >> --- a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
> >> >> +++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
> >> >> @@ -212,7 +212,7 @@ static int sun4i_hdmi_get_modes(struct drm_conn=
ector *connector)
> >> >>  	struct edid *edid;
> >> >>  	int ret;
> >> >>
> >> >> -	edid =3D drm_get_edid(connector, hdmi->i2c);
> >> >> +	edid =3D drm_get_edid(connector, hdmi->ddc_i2c ?: hdmi->i2c);
> >> >
> >> > You can't test whether ddc_i2c is NULL or not...
> >> >
> >> >>  	if (!edid)
> >> >>  		return 0;
> >> >>
> >> >> @@ -228,6 +228,28 @@ static int sun4i_hdmi_get_modes(struct drm_con=
nector *connector)
> >> >>  	return ret;
> >> >>  }
> >> >>
> >> >> +static struct i2c_adapter *sun4i_hdmi_get_ddc(struct device *dev)
> >> >> +{
> >> >> +	struct device_node *phandle, *remote;
> >> >> +	struct i2c_adapter *ddc;
> >> >> +
> >> >> +	remote =3D of_graph_get_remote_node(dev->of_node, 1, -1);
> >> >> +	if (!remote)
> >> >> +		return ERR_PTR(-EINVAL);
> >> >> +
> >> >> +	phandle =3D of_parse_phandle(remote, "ddc-i2c-bus", 0);
> >> >> +	of_node_put(remote);
> >> >> +	if (!phandle)
> >> >> +		return NULL;
> >> >> +
> >> >> +	ddc =3D of_get_i2c_adapter_by_node(phandle);
> >> >> +	of_node_put(phandle);
> >> >> +	if (!ddc)
> >> >> +		return ERR_PTR(-EPROBE_DEFER);
> >> >> +
> >> >> +	return ddc;
> >> >
> >> > ... Since even in (most) error cases you're returning a !NULL pointe=
r.
> >> >
> >> >> +}
> >> >> +
> >> >>  static const struct drm_connector_helper_funcs sun4i_hdmi_connecto=
r_helper_funcs =3D {
> >> >>  	.get_modes	=3D sun4i_hdmi_get_modes,
> >> >>  };
> >> >> @@ -575,6 +597,12 @@ static int sun4i_hdmi_bind(struct device *dev,=
 struct device *master,
> >> >>  		goto err_disable_mod_clk;
> >> >>  	}
> >> >>
> >> >> +	hdmi->ddc_i2c =3D sun4i_hdmi_get_ddc(dev);
> >> >> +	if (IS_ERR(hdmi->ddc_i2c)) {
> >>
> >> ... which is checked here.
> >>
> >> The property is optional, so the idea was to return null in that case
> >> and use the built-in controller.  If the property exists but some error
> >> occurs, we want to abort rather than proceed with the fallback which
> >> almost certainly won't work.
> >>
> >> Maybe I got something wrong in that logic.
> >
> > Indeed, I just got confused. I guess returning ENODEV in such a case,
> > and testing for that, would make things more obvious.
>
> There's also a case I hadn't thought of: property exists but isn't a
> valid phandle.  What do you think is the correct action in that case?

I think we would have that one covered. of_parse_phandle will return
!NULL, but then of_get_i2c_adapter_by_node will return NULL since we
wouldn't have an associated i2c adapter to the bogus phandle, and you
are checking for that already.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--zgta55aho4vg3yl5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXI++NQAKCRDj7w1vZxhR
xU/fAPwKyH3UipugIw6d2GTBm58n3be3hj7Du3v4gb67f87YNAD/bcJ7Ga6d2liD
a9a7pHBzi9jALRrCU+KSGfr5NY/T4AQ=
=xMyn
-----END PGP SIGNATURE-----

--zgta55aho4vg3yl5--
