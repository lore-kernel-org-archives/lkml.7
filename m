Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97A01C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 15:24:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64EA4222C6
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 15:24:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727233AbfKLPYQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 10:24:16 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:50704 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbfKLPYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 10:24:15 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 7101229047A
Received: by earth.universe (Postfix, from userid 1000)
        id 85D0B3C0C78; Tue, 12 Nov 2019 16:24:11 +0100 (CET)
Date:   Tue, 12 Nov 2019 16:24:11 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Cc:     Support Opensource <Support.Opensource@diasemi.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@collabora.com" <kernel@collabora.com>
Subject: Re: [PATCHv1 1/5] ASoC: da7213: Add regulator support
Message-ID: <20191112152411.d626b34wmvkzpqjf@earth.universe>
References: <20191108174843.11227-1-sebastian.reichel@collabora.com>
 <20191108174843.11227-2-sebastian.reichel@collabora.com>
 <AM5PR1001MB09942731970692EE42BE9CB180740@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="herodyak6v63emyg"
Content-Disposition: inline
In-Reply-To: <AM5PR1001MB09942731970692EE42BE9CB180740@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--herodyak6v63emyg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Nov 11, 2019 at 02:07:46PM +0000, Adam Thomson wrote:
> On 08 November 2019 17:49, Sebastian Reichel wrote:
>=20
> > This adds support for most regulators of da7212 for improved
> > power management. The only thing skipped was the speaker supply,
> > which has some undocumented dependencies. It's supposed to be
> > either always-enabled or always-disabled.
> >=20
> > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> > ---
> >  .../devicetree/bindings/sound/da7213.txt      |  4 ++
> >  sound/soc/codecs/da7213.c                     | 72 +++++++++++++++++++
> >  sound/soc/codecs/da7213.h                     |  2 +
> >  3 files changed, 78 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/sound/da7213.txt
> > b/Documentation/devicetree/bindings/sound/da7213.txt
> > index 759bb04e0283..cc8200b7d748 100644
> > --- a/Documentation/devicetree/bindings/sound/da7213.txt
> > +++ b/Documentation/devicetree/bindings/sound/da7213.txt
> > @@ -21,6 +21,10 @@ Optional properties:
> >  - dlg,dmic-clkrate : DMIC clock frequency (Hz).
> >  	[<1500000>, <3000000>]
> >=20
> > + - VDDA-supply : Regulator phandle for Analogue power supply
> > + - VDDMIC-supply : Regulator phandle for Mic Bias
> > + - VDDIO-supply : Regulator phandle for I/O power supply
> > +
> >  =3D=3D=3D=3D=3D=3D
> >=20
> >  Example:
> > diff --git a/sound/soc/codecs/da7213.c b/sound/soc/codecs/da7213.c
> > index aff306bb58df..36e5a7c9ac33 100644
> > --- a/sound/soc/codecs/da7213.c
> > +++ b/sound/soc/codecs/da7213.c
> > @@ -19,6 +19,7 @@
> >  #include <linux/module.h>
> >  #include <sound/pcm.h>
> >  #include <sound/pcm_params.h>
> > +#include <linux/pm_runtime.h>
> >  #include <sound/soc.h>
> >  #include <sound/initval.h>
> >  #include <sound/tlv.h>
> > @@ -806,6 +807,12 @@ static int da7213_dai_event(struct
> > snd_soc_dapm_widget *w,
> >   */
> >=20
> >  static const struct snd_soc_dapm_widget da7213_dapm_widgets[] =3D {
> > +	/*
> > +	 * Power Supply
> > +	 */
> > +	SND_SOC_DAPM_REGULATOR_SUPPLY("VDDA", 0, 0),
>=20
> Having spoken with our HW team, this will cause a POR in the device so we=
 can't
> just enable/disable VDD_A supply. Needs to present at all times. How are =
you
> verifying this?

Ok. The system, that I used for testing shared a regulator
for VDDIO and VDDA. I suppose this needs to be moved next
to enabling VDDIO then.

> > +	SND_SOC_DAPM_REGULATOR_SUPPLY("VDDMIC", 0, 0),
> > +
> >  	/*
> >  	 * Input & Output
> >  	 */
> > @@ -931,7 +938,16 @@ static const struct snd_soc_dapm_widget
> > da7213_dapm_widgets[] =3D {
> >  static const struct snd_soc_dapm_route da7213_audio_map[] =3D {
> >  	/* Dest       Connecting Widget    source */
> >=20
> > +	/* Main Power Supply */
> > +	{"DAC Left", NULL, "VDDA"},
> > +	{"DAC Right", NULL, "VDDA"},
> > +	{"ADC Left", NULL, "VDDA"},
> > +	{"ADC Right", NULL, "VDDA"},
> > +
> >  	/* Input path */
> > +	{"Mic Bias 1", NULL, "VDDMIC"},
> > +	{"Mic Bias 2", NULL, "VDDMIC"},
> > +
> >  	{"MIC1", NULL, "Mic Bias 1"},
> >  	{"MIC2", NULL, "Mic Bias 2"},
> >=20
> > @@ -1691,6 +1707,8 @@ static int da7213_probe(struct snd_soc_component
> > *component)
> >  {
> >  	struct da7213_priv *da7213 =3D
> > snd_soc_component_get_drvdata(component);
> >=20
> > +	pm_runtime_get_sync(component->dev);
> > +
> >  	/* Default to using ALC auto offset calibration mode. */
> >  	snd_soc_component_update_bits(component, DA7213_ALC_CTRL1,
> >  			    DA7213_ALC_CALIB_MODE_MAN, 0);
> > @@ -1811,6 +1829,8 @@ static int da7213_probe(struct snd_soc_component
> > *component)
> >  				    DA7213_DMIC_CLK_RATE_MASK, dmic_cfg);
> >  	}
> >=20
> > +	pm_runtime_put_sync(component->dev);
> > +
> >  	/* Check if MCLK provided */
> >  	da7213->mclk =3D devm_clk_get(component->dev, "mclk");
> >  	if (IS_ERR(da7213->mclk)) {
> > @@ -1848,6 +1868,12 @@ static const struct regmap_config
> > da7213_regmap_config =3D {
> >  	.cache_type =3D REGCACHE_RBTREE,
> >  };
> >=20
> > +static void da7213_power_off(void *data)
> > +{
> > +	struct da7213_priv *da7213 =3D data;
> > +	regulator_disable(da7213->vddio);
> > +}
> > +
> >  static int da7213_i2c_probe(struct i2c_client *i2c,
> >  			    const struct i2c_device_id *id)
> >  {
> > @@ -1860,6 +1886,18 @@ static int da7213_i2c_probe(struct i2c_client *i=
2c,
> >=20
> >  	i2c_set_clientdata(i2c, da7213);
> >=20
> > +	da7213->vddio =3D devm_regulator_get(&i2c->dev, "VDDIO");
> > +	if (IS_ERR(da7213->vddio))
> > +		return PTR_ERR(da7213->vddio);
> > +
> > +	ret =3D regulator_enable(da7213->vddio);
> > +	if (ret < 0)
> > +		return ret;
> > +
> > +	ret =3D devm_add_action_or_reset(&i2c->dev, da7213_power_off,
> > da7213);
> > +	if (ret < 0)
> > +		return ret;
>=20
> We're seemingly leaving the VDDIO regulator enabled on failure, unless I'm
> missing some magic somewhere?

If regulator_enable fails, the regulator is not enabled. If devm_add_action=
_or_reset
fails, it will call da7213_power_off().

> >  	da7213->regmap =3D devm_regmap_init_i2c(i2c, &da7213_regmap_config);
> >  	if (IS_ERR(da7213->regmap)) {
> >  		ret =3D PTR_ERR(da7213->regmap);
> > @@ -1867,6 +1905,11 @@ static int da7213_i2c_probe(struct i2c_client *i=
2c,
> >  		return ret;
> >  	}
> >=20
> > +	pm_runtime_set_autosuspend_delay(&i2c->dev, 100);
> > +	pm_runtime_use_autosuspend(&i2c->dev);
> > +	pm_runtime_set_active(&i2c->dev);
> > +	pm_runtime_enable(&i2c->dev);
> > +
> >  	ret =3D devm_snd_soc_register_component(&i2c->dev,
> >  			&soc_component_dev_da7213, &da7213_dai, 1);
> >  	if (ret < 0) {
> > @@ -1876,6 +1919,34 @@ static int da7213_i2c_probe(struct i2c_client *i=
2c,
> >  	return ret;
> >  }
> >=20
> > +static int __maybe_unused da7213_runtime_suspend(struct device *dev)
> > +{
> > +	struct da7213_priv *da7213 =3D dev_get_drvdata(dev);
> > +
> > +	regcache_cache_only(da7213->regmap, true);
> > +	regcache_mark_dirty(da7213->regmap);
> > +	regulator_disable(da7213->vddio);
> > +
> > +	return 0;
> > +}
> > +
> > +static int __maybe_unused da7213_runtime_resume(struct device *dev)
> > +{
> > +	struct da7213_priv *da7213 =3D dev_get_drvdata(dev);
> > +	int ret;
> > +
> > +	ret =3D regulator_enable(da7213->vddio);
> > +	if (ret < 0)
> > +		return ret;
> > +	regcache_cache_only(da7213->regmap, false);
> > +	regcache_sync(da7213->regmap);
> > +	return 0;
> > +}
> > +
> > +static const struct dev_pm_ops da7213_pm =3D {
> > +	SET_RUNTIME_PM_OPS(da7213_runtime_suspend,
> > da7213_runtime_resume, NULL)
> > +};
> > +
> >  static const struct i2c_device_id da7213_i2c_id[] =3D {
> >  	{ "da7213", 0 },
> >  	{ }
> > @@ -1888,6 +1959,7 @@ static struct i2c_driver da7213_i2c_driver =3D {
> >  		.name =3D "da7213",
> >  		.of_match_table =3D of_match_ptr(da7213_of_match),
> >  		.acpi_match_table =3D ACPI_PTR(da7213_acpi_match),
> > +		.pm =3D &da7213_pm,
> >  	},
> >  	.probe		=3D da7213_i2c_probe,
> >  	.id_table	=3D da7213_i2c_id,
> > diff --git a/sound/soc/codecs/da7213.h b/sound/soc/codecs/da7213.h
> > index 3250a3821fcc..97a250ea39e6 100644
> > --- a/sound/soc/codecs/da7213.h
> > +++ b/sound/soc/codecs/da7213.h
> > @@ -12,6 +12,7 @@
> >=20
> >  #include <linux/clk.h>
> >  #include <linux/regmap.h>
> > +#include <linux/regulator/consumer.h>
> >  #include <sound/da7213.h>
> >=20
> >  /*
> > @@ -524,6 +525,7 @@ enum da7213_sys_clk {
> >  /* Codec private data */
> >  struct da7213_priv {
> >  	struct regmap *regmap;
> > +	struct regulator *vddio;
> >  	struct clk *mclk;
> >  	unsigned int mclk_rate;
> >  	int clk_src;

-- Sebastian

--herodyak6v63emyg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAl3KzpsACgkQ2O7X88g7
+pp3dBAAjwY8s+vadK2wX4lKRPKnQdX7lYpbRPeo5qPNiyo3nstCRZvaEX9LDkH2
B7nVLHL0/+88vcElg0Zhk93YmLNrNQGuDPcnREN9cs6/zvEe1z/rdzIghSeXRWVy
tdZbveqmGES0m+62iIaTN8Ffvbnv7/QC89x2L8jRjTWTsfAeUv0nYhZy4X8JSo07
e84mwPyieuJJtdbjGMCCqYL3K/5floyv7Z+LmCznIEL59oWg9ppVvAnciNjNZqxT
Jw/m0E4g3BSsZKunj1QDN7jQnb98uQzMd/5g28UQoD5Pi6nroMfxKrERd4PELTYl
HYHJ8a0VjkuEc9GHl7MXM9OIK7TaOe/izK6S41/EhTTS1ucQTESJcORtb/Eyzs4V
5u2tcBcqS3RyJmS11rDGiIyiSNK9mGuZMIufqurCuANk5RFl+diLRqCTx5H7dxj9
507nFl+iOsCOa3sl5sw/beMi74DMsDK/Oo79efJzbljLfEPNY2sUzdaChT+78QVv
MmSqqnNP3U0bQzC4Jit6tKqdVKqkLLVX5oVI5vyWy9KMK2VS/XcDiBDR/YFHZD+U
Vlk/emvRjwLNSms2zRt9Zi+ErE5GOWrqmG1NKtsLzQnw4WpmuttNx2EEf+kHAt9p
5F4zd1o/CT8C58b5YakR6MA3rXXr9VJn8tW1deeXmPynOnKEXZQ=
=8xPj
-----END PGP SIGNATURE-----

--herodyak6v63emyg--
