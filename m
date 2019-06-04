Return-Path: <SRS0=CtY/=UD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF516C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F0EB2496E
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Jun 2019 08:19:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbfFDITq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Jun 2019 04:19:46 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:43529 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726844AbfFDITq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jun 2019 04:19:46 -0400
X-Originating-IP: 90.88.144.139
Received: from localhost (aaubervilliers-681-1-24-139.w90-88.abo.wanadoo.fr [90.88.144.139])
        (Authenticated sender: maxime.ripard@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id D55676001C;
        Tue,  4 Jun 2019 08:19:38 +0000 (UTC)
Date:   Tue, 4 Jun 2019 10:19:38 +0200
From:   Maxime Ripard <maxime.ripard@bootlin.com>
To:     codekipper@gmail.com
Cc:     wens@csie.org, linux-sunxi@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, lgirdwood@gmail.com,
        broonie@kernel.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, be17068@iperbole.bo.it
Subject: Re: [PATCH v4 8/9] ASoc: sun4i-i2s: Add 20, 24 and 32 bit support
Message-ID: <20190604081938.npye7brtjv7c7noj@flea>
References: <20190603174735.21002-1-codekipper@gmail.com>
 <20190603174735.21002-9-codekipper@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6wxkr4ordbttpslj"
Content-Disposition: inline
In-Reply-To: <20190603174735.21002-9-codekipper@gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6wxkr4ordbttpslj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 03, 2019 at 07:47:34PM +0200, codekipper@gmail.com wrote:
> From: Marcus Cooper <codekipper@gmail.com>
>
> Extend the functionality of the driver to include support of 20 and
> 24 bits per sample for the earlier SoCs.
>
> Newer SoCs can also handle 32bit samples.
>
> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
> ---
>  sound/soc/sunxi/sun4i-i2s.c | 34 +++++++++++++++++++++++++++++++---
>  1 file changed, 31 insertions(+), 3 deletions(-)
>
> diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> index 3549a87ed9e9..351b8021173b 100644
> --- a/sound/soc/sunxi/sun4i-i2s.c
> +++ b/sound/soc/sunxi/sun4i-i2s.c
> @@ -428,6 +428,11 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
>  	case 16:
>  		width = DMA_SLAVE_BUSWIDTH_2_BYTES;
>  		break;
> +	case 20:
> +	case 24:
> +	case 32:
> +		width = DMA_SLAVE_BUSWIDTH_4_BYTES;
> +		break;

Doesn't this test the physical width? If so, then I'm not sure that 20
even exists, and that we can support 24.

>  	default:
>  		dev_err(dai->dev, "Unsupported physical sample width: %d\n",
>  			params_physical_width(params));
> @@ -440,7 +445,18 @@ static int sun4i_i2s_hw_params(struct snd_pcm_substream *substream,
>  		sr = 0;
>  		wss = 0;
>  		break;
> -
> +	case 20:
> +		sr = 1;
> +		wss = 1;
> +		break;
> +	case 24:
> +		sr = 2;
> +		wss = 2;
> +		break;
> +	case 32:
> +		sr = 4;
> +		wss = 4;
> +		break;

This doesn't really works, wss being the slot size, and you can have a
different slot size and sample size. I have a patch that reworks this,
I'll send it.

Maxime

--
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

--6wxkr4ordbttpslj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXPYpmgAKCRDj7w1vZxhR
xa21AQCOpQgoV29jgv0RoMH3aHTxjdGgvHs09RTrroaqdpxRWgEA02ukNRDWozBj
j4PRdKMEMXcX9YvD//OOJzSeiWrRJwc=
=ykij
-----END PGP SIGNATURE-----

--6wxkr4ordbttpslj--
