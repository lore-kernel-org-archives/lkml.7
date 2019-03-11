Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8903C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 15:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B239020657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 15:47:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727651AbfCKPrG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 11:47:06 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:46533 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbfCKPrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 11:47:06 -0400
X-Originating-IP: 90.88.150.179
Received: from localhost (aaubervilliers-681-1-31-179.w90-88.abo.wanadoo.fr [90.88.150.179])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id C8C2D1BF216;
        Mon, 11 Mar 2019 15:47:02 +0000 (UTC)
Date:   Mon, 11 Mar 2019 16:47:02 +0100
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     Mans Rullgard <mans@mansr.com>
Cc:     David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/sun4i: hdmi: add support for ddc-i2c-bus property
Message-ID: <20190311154702.eslw5ccol44vxcmy@flea>
References: <20190311134713.25876-1-mans@mansr.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="hoxjklpx767uqidw"
Content-Disposition: inline
In-Reply-To: <20190311134713.25876-1-mans@mansr.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hoxjklpx767uqidw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

On Mon, Mar 11, 2019 at 01:47:13PM +0000, Mans Rullgard wrote:
> Sometimes it is desirabled to use a separate i2c controller for ddc
> access.  This adds support for the ddc-i2c-bus property of the
> hdmi-connector node, using the specified controller if provided.
>=20
> Signed-off-by: Mans Rullgard <mans@mansr.com>
> ---
>  drivers/gpu/drm/sun4i/sun4i_hdmi.h     |  1 +
>  drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c | 37 +++++++++++++++++++++++---
>  2 files changed, 35 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi.h b/drivers/gpu/drm/sun4i/s=
un4i_hdmi.h
> index b685ee11623d..b08c4453d47c 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_hdmi.h
> +++ b/drivers/gpu/drm/sun4i/sun4i_hdmi.h
> @@ -269,6 +269,7 @@ struct sun4i_hdmi {
>  	struct clk		*tmds_clk;
> =20
>  	struct i2c_adapter	*i2c;
> +	struct i2c_adapter	*ddc_i2c;
> =20
>  	/* Regmap fields for I2C adapter */
>  	struct regmap_field	*field_ddc_en;
> diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c b/drivers/gpu/drm/sun=
4i/sun4i_hdmi_enc.c
> index 061d2e0d9011..5b2fac79f5d6 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
> @@ -212,7 +212,7 @@ static int sun4i_hdmi_get_modes(struct drm_connector =
*connector)
>  	struct edid *edid;
>  	int ret;
> =20
> -	edid =3D drm_get_edid(connector, hdmi->i2c);
> +	edid =3D drm_get_edid(connector, hdmi->ddc_i2c ?: hdmi->i2c);

You can't test whether ddc_i2c is NULL or not...

>  	if (!edid)
>  		return 0;
> =20
> @@ -228,6 +228,28 @@ static int sun4i_hdmi_get_modes(struct drm_connector=
 *connector)
>  	return ret;
>  }
> =20
> +static struct i2c_adapter *sun4i_hdmi_get_ddc(struct device *dev)
> +{
> +	struct device_node *phandle, *remote;
> +	struct i2c_adapter *ddc;
> +
> +	remote =3D of_graph_get_remote_node(dev->of_node, 1, -1);
> +	if (!remote)
> +		return ERR_PTR(-EINVAL);
> +
> +	phandle =3D of_parse_phandle(remote, "ddc-i2c-bus", 0);
> +	of_node_put(remote);
> +	if (!phandle)
> +		return NULL;
> +
> +	ddc =3D of_get_i2c_adapter_by_node(phandle);
> +	of_node_put(phandle);
> +	if (!ddc)
> +		return ERR_PTR(-EPROBE_DEFER);
> +
> +	return ddc;

=2E.. Since even in (most) error cases you're returning a !NULL pointer.

> +}
> +
>  static const struct drm_connector_helper_funcs sun4i_hdmi_connector_help=
er_funcs =3D {
>  	.get_modes	=3D sun4i_hdmi_get_modes,
>  };
> @@ -575,6 +597,12 @@ static int sun4i_hdmi_bind(struct device *dev, struc=
t device *master,
>  		goto err_disable_mod_clk;
>  	}
> =20
> +	hdmi->ddc_i2c =3D sun4i_hdmi_get_ddc(dev);
> +	if (IS_ERR(hdmi->ddc_i2c)) {
> +		ret =3D PTR_ERR(hdmi->ddc_i2c);
> +		goto err_del_i2c_adapter;
> +	}
> +
>  	drm_encoder_helper_add(&hdmi->encoder,
>  			       &sun4i_hdmi_helper_funcs);
>  	ret =3D drm_encoder_init(drm,
> @@ -584,14 +612,14 @@ static int sun4i_hdmi_bind(struct device *dev, stru=
ct device *master,
>  			       NULL);
>  	if (ret) {
>  		dev_err(dev, "Couldn't initialise the HDMI encoder\n");
> -		goto err_del_i2c_adapter;
> +		goto err_put_ddc_i2c;
>  	}
> =20
>  	hdmi->encoder.possible_crtcs =3D drm_of_find_possible_crtcs(drm,
>  								  dev->of_node);
>  	if (!hdmi->encoder.possible_crtcs) {
>  		ret =3D -EPROBE_DEFER;
> -		goto err_del_i2c_adapter;
> +		goto err_put_ddc_i2c;
>  	}
> =20
>  #ifdef CONFIG_DRM_SUN4I_HDMI_CEC
> @@ -630,6 +658,8 @@ static int sun4i_hdmi_bind(struct device *dev, struct=
 device *master,
>  err_cleanup_connector:
>  	cec_delete_adapter(hdmi->cec_adap);
>  	drm_encoder_cleanup(&hdmi->encoder);
> +err_put_ddc_i2c:
> +	i2c_put_adapter(hdmi->ddc_i2c);
>  err_del_i2c_adapter:
>  	i2c_del_adapter(hdmi->i2c);
>  err_disable_mod_clk:
> @@ -650,6 +680,7 @@ static void sun4i_hdmi_unbind(struct device *dev, str=
uct device *master,
>  	drm_connector_cleanup(&hdmi->connector);
>  	drm_encoder_cleanup(&hdmi->encoder);
>  	i2c_del_adapter(hdmi->i2c);
> +	i2c_put_adapter(hdmi->ddc_i2c);
>  	clk_disable_unprepare(hdmi->mod_clk);
>  	clk_disable_unprepare(hdmi->bus_clk);
>  }
> --=20
> 2.21.0
>

It looks good otherwise, thanks!
Maxime

--=20
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--hoxjklpx767uqidw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXIaC9gAKCRDj7w1vZxhR
xQn+AQCqjOQQ1+h6XtoxiXvWkZ+C6Dtx3z5MoVg1ce9F19/8XgD/dCBV6PkSIYv0
FOFmmO2muAVB/UcZbyI9EvPCvn3/gwM=
=e+q0
-----END PGP SIGNATURE-----

--hoxjklpx767uqidw--
