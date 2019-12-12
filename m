Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B5BBC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 14:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D23A0206C3
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 14:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576162414;
	bh=9OIa0OImZlhBiGZn1giTJNIx45uf2z/d7bZC91VmEJE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JPV4iuZ3wAzkpYBR9Nl73eNu4AsAWFPC8EbzZdkYrlKWZ2L6tFkMmTa9qpqnhuhDE
	 Wq35xVl+gWbIjhvmQO7MVLNKjvPZk1rNXFj+gpH2Y+bgL305oOd/AGc5zF8X7AgCj3
	 PsYnmMJA/0PkxW/u7iENKnqjIHmfB4QdQOfQAjXs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728950AbfLLOxe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 09:53:34 -0500
Received: from foss.arm.com ([217.140.110.172]:49522 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728861AbfLLOxd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 09:53:33 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AEE1CDA7;
        Thu, 12 Dec 2019 06:53:32 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2E5B03F6CF;
        Thu, 12 Dec 2019 06:53:32 -0800 (PST)
Date:   Thu, 12 Dec 2019 14:53:30 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jeff Chang <richtek.jeff.chang@gmail.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        matthias.bgg@gmail.com, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jeff_chang@richtek.com
Subject: Re: [PATCH] ASoC: Add MediaTek MT6660 Speaker Amp Driver
Message-ID: <20191212145330.GC4310@sirena.org.uk>
References: <1576152740-11979-1-git-send-email-richtek.jeff.chang@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gr/z0/N6AeWAPJVB"
Content-Disposition: inline
In-Reply-To: <1576152740-11979-1-git-send-email-richtek.jeff.chang@gmail.com>
X-Cookie: We have DIFFERENT amounts of HAIR --
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gr/z0/N6AeWAPJVB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2019 at 08:12:20PM +0800, Jeff Chang wrote:

> sense, which are able to be monitored via DATAO through proper
>=20
> ---
>=20
> [PATCH v2] :
> 	1. remove unnecessary space from commit message
> 	2. add Signed-off-by info
>=20
> Signed-off-by: Jeff Chang <richtek.jeff.chang@gmail.com>
> ---

You should place the Signed-off-by before the first --- as covered by
submitting-patches.rst.  Please, slow down a bit before resending and
make sure you've checked what you're doing thoroughly.  Look at what
you're sending and how it compares to what others are sending.

> +config SND_SOC_MT6660
> +	tristate "Mediatek MT6660 Speaker Amplifier"
> +	depends on I2C
> +	select CRC32
> +	select CRYPTO_SHA256
> +	select CRYTO_RSA
> +	help

These selects of crypto stuf appear entirely unrelated to anything in
the driver?

> +++ b/sound/soc/codecs/mt6660.c
> @@ -0,0 +1,1063 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2019 MediaTek Inc.
> + */

Please make the entire comment a C++ one so things look more
intentional.

> +static int mt6660_dbg_io_write(void *drvdata, u16 reg,
> +			       const void *val, u16 size)
> +{
> +	struct mt6660_chip *chip =3D (struct mt6660_chip *)drvdata;
> +	int reg_size =3D mt6660_get_reg_size(reg);
> +	int i =3D 0;
> +	unsigned int regval =3D 0;
> +	u8 *_val =3D (u8 *)val;

This is duplicating standard regmap functionality.

> +static bool mt6660_volatile_reg(struct device *dev, unsigned int reg)
> +{
> +	return true;
> +}

There's no need to do this, there's no cache configured.

> +static unsigned int mt6660_component_io_read(
> +	struct snd_soc_component *component, unsigned int reg)
> +{
> +	struct mt6660_chip *chip =3D snd_soc_component_get_drvdata(component);
> +	unsigned int val;
> +	int ret;
> +
> +	ret =3D regmap_read(chip->regmap, reg, &val);
> +	if (ret < 0) /* ret success -> >=3D 0, fail -> < - */
> +		return ret;
> +	pr_err("%s val =3D 0x%x\n", __func__, val);
> +	return val;
> +}

This function appears to be redunddant, ASoC has wrappers for I/O on
components, same for writes.

> +static int data_debug_show(struct seq_file *s, void *data)
> +{
> +	struct dbg_info *di =3D s->private;
> +	struct dbg_internal *d =3D &di->internal;

regmap has standard support for dumping the register map via debugfs, no
need to write your own.  You should be able to just remove all the
debugfs code.

> +/*
> + * MT6660 Generic Setting make this chip work normally.
> + * it is tuned by Richtek RDs.
> + */
> +static const struct codec_reg_val generic_reg_inits[] =3D {
> +	{ MT6660_REG_WDT_CTRL, 0x80, 0x00 },
> +	{ MT6660_REG_SPS_CTRL, 0x01, 0x00 },
> +	{ MT6660_REG_AUDIO_IN2_SEL, 0x1c, 0x04 },

The writes to reserved registers should be fine but things like this
which looks like it's configuring the input path should just be left at
the chip default, we don't want to be configuring for particular boards
since the same driver will be used for every board with the chip.

> +	{ MT6660_REG_HPF1_COEF, 0xffffffff, 0x7fdb7ffe },
> +	{ MT6660_REG_HPF2_COEF, 0xffffffff, 0x7fdb7ffe },

Similarly here.

> +static int mt6660_component_init_setting(struct snd_soc_component *compo=
nent)
> +{
> +	int i, len, ret;
> +	const struct codec_reg_val *init_table;
> +
> +	pr_info("%s start\n", __func__);

These pr_info() calls are going to be too noisy.

> +	switch (level) {
> +	case SND_SOC_BIAS_OFF:
> +		ret =3D regmap_read(chip->regmap, MT6660_REG_IRQ_STATUS1, &val);
> +		dev_info(component->dev,
> +			"%s reg0x05 =3D 0x%x\n", __func__, val);
> +		break;

This is just making noise, it looks like there's nothing to do in this
function at all and the above is only for debugging.  There's lots of
these throughout the driver.

> +static int mt6660_component_put_volsw(struct snd_kcontrol *kcontrol,
> +				  struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *component =3D
> +		snd_soc_kcontrol_component(kcontrol);
> +	int put_ret =3D 0;
> +
> +	pm_runtime_get_sync(component->dev);
> +	put_ret =3D snd_soc_put_volsw(kcontrol, ucontrol);
> +	if (put_ret < 0)
> +		return put_ret;
> +	pm_runtime_put(component->dev);
> +	return put_ret;
> +}

It would be *much* better to just use a register cache here rather than
open code like this, and given that the device is suspended via the
register map it is more than a little surprising that there's any need
to do anything special here.

--gr/z0/N6AeWAPJVB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl3yVGkACgkQJNaLcl1U
h9AdBgf/Txq2F8UErlJS7V2ETpVBmA7z2H4huGjRBF5D9tDQD5uNbT/pA25/Oe5D
VFt+1dRHKpk3TU3MUFiIwkZNH0UzD2MC8RmK3UvxGZP51HCE9R8SkleH8cDoSbJc
aZqys/4lsz0DVc+qzhyuxHA2dckYOyqRTrn+4RNT1Q3reiJfYDDk5ziZRpqohril
8e9lNqyTewpob7SrL5zUtHbn0cIGuSFt/mo6Iweocy6+J7hYMEZEBb7kd84LAhRP
H3S3ggEEGC32CS0ez0Qdgm+tq6DF2+UGkZOU6AGk9aOgjbGoBZxvWlXTQS/qPX1C
04OcQ5JFv5kv6Sr/okYs23KuYYQrLg==
=2dQa
-----END PGP SIGNATURE-----

--gr/z0/N6AeWAPJVB--
