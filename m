Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 487D9C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 12:11:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1472524679
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 12:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576843917;
	bh=K04Kd/JIgIwx8J931dev25po0GvaN0DUsXPBGFUx8jk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=nLao5FHnpvOlXrgxCHd/aSbB4QK0A6MpEr0lADraaw50j9ck3L26I6CgP1X8etHn+
	 70EEeHvnt0ULgtU++5TKgdog0lV/ZawrhKwoiLuahHaBYwSXXuN2CHzGg8ZdM/pSij
	 2wg3w3t6QytcvV9Z84dYUn3yMovkDDC1XZ6MiwA8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727298AbfLTML4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 07:11:56 -0500
Received: from foss.arm.com ([217.140.110.172]:50244 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727191AbfLTMLz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 07:11:55 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id EA40830E;
        Fri, 20 Dec 2019 04:11:54 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 683BC3F719;
        Fri, 20 Dec 2019 04:11:54 -0800 (PST)
Date:   Fri, 20 Dec 2019 12:11:52 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Jeff Chang <richtek.jeff.chang@gmail.com>
Cc:     lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        matthias.bgg@gmail.com, alsa-devel@alsa-project.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        jeff_chang@richtek.com
Subject: Re: [PATCH] ASoC: Add MediaTek MT6660 Speaker Amp Driver
Message-ID: <20191220121152.GC4790@sirena.org.uk>
References: <1576836934-5370-1-git-send-email-richtek.jeff.chang@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Y5rl02BVI9TCfPar"
Content-Disposition: inline
In-Reply-To: <1576836934-5370-1-git-send-email-richtek.jeff.chang@gmail.com>
X-Cookie: I think we're in trouble.
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Y5rl02BVI9TCfPar
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 20, 2019 at 06:15:34PM +0800, Jeff Chang wrote:

> +++ b/sound/soc/codecs/mt6660.c
> @@ -0,0 +1,653 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2019 MediaTek Inc.
> + */

Please make the entire comment a C++ one so things look more
intentional.

> +	{ MT6660_REG_DEVID, 2},
> +	{ MT6660_REG_TDM_CFG3, 2},
> +	{ MT6660_REG_HCLIP_CTRL, 2},
> +	{ MT6660_REG_DA_GAIN, 2},

Missing space before the } (the same thing happens in some of the
other tables).

> +static int mt6660_component_get_volsw(struct snd_kcontrol *kcontrol,
> +				  struct snd_ctl_elem_value *ucontrol)
> +{
> +	struct snd_soc_component *component =
> +		snd_soc_kcontrol_component(kcontrol);
> +	struct mt6660_chip *chip = (struct mt6660_chip *)
> +		snd_soc_component_get_drvdata(component);
> +	int ret = -EINVAL;
> +
> +	if (!strcmp(kcontrol->id.name, "Chip_Rev")) {

Why would this be used on a different control?

> +	SOC_SINGLE_EXT("BoostMode", MT6660_REG_BST_CTRL, 0, 3, 0,
> +		       snd_soc_get_volsw, snd_soc_put_volsw),

Boost Mode.  You've also got a lot of these controls that are _EXT but
you then just use standard operations so it's not clear why you're using
_EXT.

> +	SOC_SINGLE_EXT("audio input selection", MT6660_REG_DATAO_SEL, 6, 3, 0,
> +		       snd_soc_get_volsw, snd_soc_put_volsw),

Audio Input Selection, but this looks like it should be a DAPM control
if it's controlling audio routing.  A simple numerical setting
definitely doesn't seem like the right thing.

> +	SOC_SINGLE_EXT("AUD LOOP BACK Switch", MT6660_REG_PATH_BYPASS, 4, 1, 0,
> +		       snd_soc_get_volsw, snd_soc_put_volsw),

This sounds like it should be a DAPM thing too.

> +static int mt6660_component_probe(struct snd_soc_component *component)
> +{
> +	struct mt6660_chip *chip = snd_soc_component_get_drvdata(component);
> +	int ret = 0;
> +
> +	dev_info(component->dev, "%s\n", __func__);

dev_dbg() at most but probably better to remove this and the other
similar dev_info()s.

> +static inline int _mt6660_chip_id_check(struct mt6660_chip *chip)
> +{
> +	u8 id[2] = {0};
> +	int ret = 0;
> +
> +	ret = i2c_smbus_read_i2c_block_data(chip->i2c, MT6660_REG_DEVID, 2, id);
> +	if (ret < 0)
> +		return ret;
> +	ret = (id[0] << 8) + id[1];
> +	ret &= 0x0ff0;
> +	if (ret != 0x00e0 && ret != 0x01e0)
> +		return -ENODEV;

It'd be better to print an error message saying we don't recognize the
device to help people doing debugging.

> +	if (of_property_read_u32(np, "rt,init_setting_num", &val)) {
> +		dev_info(dev, "no init setting\n");
> +		chip->plat_data.init_setting_num = 0;

You should be adding a DT binding document for any new DT bindings.

--Y5rl02BVI9TCfPar
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl38uogACgkQJNaLcl1U
h9B+kQf6AzhZSat7mqBSwJVubwAXZcJ6ApJ29GlB2ypbTdOhUOTKKR8ytA2kMg6l
Ifw88ajLzpL4jAIHwwS3NOMonMD/9KgNLfQVgMxzuzsYyRYBmj7p9lXsYICNIvoe
nSn2nPJfw5g5PlMZ+qwxyNNMTOkui6qKCFoFS77TJq0hsbTh+x6azMfn8VVRwrL+
VRXPN2C9mAdyrVPw/XPjkTyCrXw8P6brXK6qW23Y14FRQ8dXke0rhMumWytquybM
ebURG75CUEXyykGbNGHoJa4ycypd5AA/LYR86mzRbs7Mxiqlmw3co8/C44n4XKM0
QungC3A3a98p1kNSIiBM9g2Ie+cgBw==
=pOxx
-----END PGP SIGNATURE-----

--Y5rl02BVI9TCfPar--
