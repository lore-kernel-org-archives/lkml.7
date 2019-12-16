Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9931C2D0C3
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 16:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97A592146E
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 16:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576512783;
	bh=Jef9w4OjkRq1icyigJOT8xylp8Mo2WzDKjHr6uAiULc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wSqyc+mJ05p/heR8Z8bLMWcN49icD+JsmjkRofE3COyofMltvgp9XzGyGht4M/TY5
	 FRKHpPV7KD1jf21WbraMRwP/Pjs+gVtxO6NH6l4/+26j1mehTGd1AF2h0iJqFh9fB+
	 CHSnbWclPg8npJH2wC3VVwiWIwU2tsWPLHfozPOg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726426AbfLPQNC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 11:13:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:35600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbfLPQNC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 11:13:02 -0500
Received: from localhost (lfbn-tou-1-1502-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 02A1C20717;
        Mon, 16 Dec 2019 16:13:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576512781;
        bh=Jef9w4OjkRq1icyigJOT8xylp8Mo2WzDKjHr6uAiULc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bRGG0YcSlJmTEk9EfbMd4tusYJTP9xGT22BF+SgJByObFOByPlN0xPhbXAhWIPSrR
         VUVb8gOZYb3cH7+/Ox7rA5EbXd2s3MxEMgmUJcuBmQ2QyTSdSaJEe4856ukG1N6uIA
         fA9XmLS6WVgfrTRO2HlRJRca+A+/LF5G8GaTrAdo=
Date:   Mon, 16 Dec 2019 17:12:58 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Stefan Mavrodiev <stefan@olimex.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:DRM DRIVERS FOR ALLWINNER A10" 
        <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Allwinner sunXi SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH 1/1] drm/sun4i: hdmi: Check for null pointer before
 cleanup
Message-ID: <20191216161258.lmkq2ersfm746t7q@gilmour.lan>
References: <20191216144348.7540-1-stefan@olimex.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tv26vsw7yc2hguuf"
Content-Disposition: inline
In-Reply-To: <20191216144348.7540-1-stefan@olimex.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--tv26vsw7yc2hguuf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

On Mon, Dec 16, 2019 at 04:43:48PM +0200, Stefan Mavrodiev wrote:
> It's possible hdmi->connector and hdmi->encoder divices to be NULL.
> This can happen when building as kernel module and you try to remove
> the module.
>
> This patch make simple null check, before calling the cleanup functions.
>
> Signed-off-by: Stefan Mavrodiev <stefan@olimex.com>
> ---
>  drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
> index a7c4654445c7..b61e00f2ecb8 100644
> --- a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
> +++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
> @@ -685,8 +685,10 @@ static void sun4i_hdmi_unbind(struct device *dev, struct device *master,
>  	struct sun4i_hdmi *hdmi = dev_get_drvdata(dev);
>
>  	cec_unregister_adapter(hdmi->cec_adap);
> -	drm_connector_cleanup(&hdmi->connector);
> -	drm_encoder_cleanup(&hdmi->encoder);
> +	if (hdmi->connector.dev)
> +		drm_connector_cleanup(&hdmi->connector);
> +	if (hdmi->encoder.dev)
> +		drm_encoder_cleanup(&hdmi->encoder);

Hmmm, this doesn't look right. Do you have more information on how you
can reproduce it?

Maxime

--tv26vsw7yc2hguuf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXfetCgAKCRDj7w1vZxhR
xSlzAQCy4c+CBbNxGZLR/c23Wqh2wxxJFng5CLDPuXkQzWCfYAEA2J3Ojg/qotg0
t+szQiO+c0e2z1mtbxDkSMg9ZtyIVwQ=
=fjFy
-----END PGP SIGNATURE-----

--tv26vsw7yc2hguuf--
