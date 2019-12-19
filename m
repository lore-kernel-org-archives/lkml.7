Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB085C2D0C1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 12:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1B1E24672
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 12:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576759446;
	bh=6JFwR0saeGyANg1nIHBFlGxnXWgDuEBwv3HadSj8sKA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RtDnJObwGf7jsfAHMOa4gwp4SUopeYMYRrexlhI+0Cr37c6P/JIxRZi1oRSbXinif
	 45fuMoECOG9IntangH+Wv+PjgdXUL/cu2+WACVt61ypb3NZEiYKiWWSWapIQd4ZvTD
	 fM83f8TcXpUHUT66tLDwSxXKvL4hL+aKj+ub1zIs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfLSMoF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 07:44:05 -0500
Received: from foss.arm.com ([217.140.110.172]:38402 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726701AbfLSMoF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 07:44:05 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8CD4831B;
        Thu, 19 Dec 2019 04:44:04 -0800 (PST)
Received: from localhost (unknown [10.37.6.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E6E7D3F719;
        Thu, 19 Dec 2019 04:44:03 -0800 (PST)
Date:   Thu, 19 Dec 2019 12:44:02 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Saravanan Sekar <sravanhome@gmail.com>
Cc:     lgirdwood@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com,
        mripard@kernel.org, heiko@sntech.de, shawnguo@kernel.org,
        laurent.pinchart@ideasonboard.com, icenowy@aosc.io,
        mchehab+samsung@kernel.org, davem@davemloft.net,
        gregkh@linuxfoundation.org, Jonathan.Cameron@huawei.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/4] regulator: mpq7920: add mpq7920 regulator driver
Message-ID: <20191219124402.GC5047@sirena.org.uk>
References: <20191219103721.10935-1-sravanhome@gmail.com>
 <20191219103721.10935-4-sravanhome@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="69pVuxX8awAiJ7fD"
Content-Disposition: inline
In-Reply-To: <20191219103721.10935-4-sravanhome@gmail.com>
X-Cookie: I smell a RANCID CORN DOG!
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--69pVuxX8awAiJ7fD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Dec 19, 2019 at 11:37:20AM +0100, Saravanan Sekar wrote:

This looks pretty good, a few small issues below:

> @@ -0,0 +1,376 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * mpq7920.c  -  mps mpq7920
> + *
> + * Copyright 2019 Monolithic Power Systems, Inc

Please keep the entire comment a C++ one so things look more
intentional.

> +static int mpq7920_set_ramp_delay(struct regulator_dev *rdev, int ramp_delay)
> +{
> +	unsigned int ramp_val = (ramp_delay <= 4000) ? 3 : 2;
> +
> +	return regmap_update_bits(rdev->regmap, MPQ7920_REG_CTL0,
> +				  MPQ7920_MASK_DVS_SLEWRATE, ramp_val << 6);
> +}

This should validate the input.  Please also avoid abusing the ternery
operator like this, just write normal logic statements to make the code
more readable.

> +	struct regulator_desc *rdesc;
> +	struct regulator_ops *ops;
> +
> +	for (i = 0; i < MPQ7920_MAX_REGULATORS; i++) {
> +		rdesc = &info->rdesc[i];
> +		ops = rdesc->ops;
> +		if (rdesc->curr_table) {
> +			ops->get_current_limit =
> +				regulator_get_current_limit_regmap;
> +			ops->set_current_limit =
> +				regulator_set_current_limit_regmap;
> +		}

It would be better to make these constant at build time rather than
patching at runtime, that lets things like static checkers do their
thing more easily.

> +	ret = mpq7920_regulator_register(info, &config);
> +	if (ret < 0)
> +		dev_err(dev, "Failed to register regulator!\n");

This function has one caller, just inline it.

--69pVuxX8awAiJ7fD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAl37cJEACgkQJNaLcl1U
h9COSQf9GWksfSDSmlysjJw328uMbqlUK49mwwu2bV7mGwykv739G6zQK0UilW9J
4pxv5qLozLEyQKbF8JZRsE1geGiUqO3a6Svpdh5Uyfa/8xxWLDFlEPC6LMHulgLw
X1VTS/S92lSCzANbm8EQLGJwz/t5llKlqInigyZqTTIVrI500xoCzFUkwW/wSreJ
aIDttUebnyI2BvjFAP+ehG4/a2/2uK3oT18GieBpvGfIizybdu0P1wAQU/dbI+JN
QEKl2dWLE/sUyFBllzdBh+Sd2O6C/g15y4R4FRU/m43CxFp5WXqzknPOUo+J+RA8
JwaqnL6x9JKbK5P7S71QMGtHLDRMAQ==
=jSsg
-----END PGP SIGNATURE-----

--69pVuxX8awAiJ7fD--
