Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C754CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 09:50:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D02F321855
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 09:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572601852;
	bh=HdDiE3u28/EH/XJwBUZXniN/4FBeDOyfUzlaLLrQt8U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=16iDlPnFH0mtyPZdEPMnr9Upcx83FfHa2trCGH2uOwOmu5Fte1OM48frWsYTSAw+2
	 7FLvEXuQS7GxOvrsR3ZrOOfa8ninKWI3AA4mjQFoxQ81HAEKfAj6e+uE5koawx6abf
	 4bTvxGBA4CUetm21r4oWmVZxtQA16loIWH4IIJUE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbfKAJuv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 05:50:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:47480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726957AbfKAJuv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 05:50:51 -0400
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1614D21734;
        Fri,  1 Nov 2019 09:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572601850;
        bh=HdDiE3u28/EH/XJwBUZXniN/4FBeDOyfUzlaLLrQt8U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aOoWh+fa9xUVINtmIFGgLJb5/BUb3CxH2sXYOSzSHO36L6ljk6t0EpPajLqaU8xE7
         mKbvygogrFwXFvu1nBL0sAtUyDMpcbcDONIDYacL9I2TcteuiT9K/dB1teL0eOSRxN
         Kp9WtFItaERwdzHT/tzTckSRZ+H6kyl8hML6xc+I=
Date:   Fri, 1 Nov 2019 10:13:55 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: sun4i: Use PTR_ERR_OR_ZERO to simplify the code
Message-ID: <20191101091355.ibbet6a2zb23bpjn@hendrix>
References: <1572530979-27595-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6vhl2j34wvp3caxz"
Content-Disposition: inline
In-Reply-To: <1572530979-27595-1-git-send-email-zhongjiang@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6vhl2j34wvp3caxz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 31, 2019 at 10:09:39PM +0800, zhong jiang wrote:
> It is better to use PTR_ERR_OR_ZERO rather than if(IS_ERR(...)) + PTR_ERR.
>
> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> ---
>  sound/soc/sunxi/sun4i-i2s.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> index d0a8d58..72012a6 100644
> --- a/sound/soc/sunxi/sun4i-i2s.c
> +++ b/sound/soc/sunxi/sun4i-i2s.c
> @@ -1174,10 +1174,8 @@ static int sun4i_i2s_init_regmap_fields(struct device *dev,
>  	i2s->field_fmt_sr =
>  			devm_regmap_field_alloc(dev, i2s->regmap,
>  						i2s->variant->field_fmt_sr);
> -	if (IS_ERR(i2s->field_fmt_sr))
> -		return PTR_ERR(i2s->field_fmt_sr);
>
> -	return 0;
> +	return PTR_ERR_OR_ZERO(i2s->field_fmt_sr);

I don't find it "better". This couples the error handling and the
success case, and it makes it harder to extend in the future.

Maxime

--6vhl2j34wvp3caxz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXbv3UwAKCRDj7w1vZxhR
xSByAQCjg2HWuIqPYN2yl52RWX3gUhD8/UFFCrxTI4MANT8XIAD/YFUGXPMc30Zx
R7UevyMTvzJVznWeORM6F+mRArQGYQM=
=Pr2a
-----END PGP SIGNATURE-----

--6vhl2j34wvp3caxz--
