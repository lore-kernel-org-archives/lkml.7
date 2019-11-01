Return-Path: <SRS0=OzJr=YZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E57B4CA9ECF
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 15:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD0DD217F9
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Nov 2019 15:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572622497;
	bh=IvThiZwVHnMzgD+APW+Z07boNS0/SJNrneDiPxdkxFs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=RiBwVgUmzB7BBKtvjPSaRSNgo1o7UIyw5HZa8ymoUPtHgjWmKsjt9jE+kSYyTc6zB
	 Ngun+KQB0qJSv0O8qZqysIKxQBM8wq8BzxSzZt1K1yzAZ0c47X5sZCGeH5vEHHT9t1
	 TattFz9TXW42duS1kSE7DvaeYhzsoo+EUEuvUwpQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728767AbfKAPe4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Nov 2019 11:34:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:34584 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727100AbfKAPe4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Nov 2019 11:34:56 -0400
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E32CB20650;
        Fri,  1 Nov 2019 15:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572622495;
        bh=IvThiZwVHnMzgD+APW+Z07boNS0/SJNrneDiPxdkxFs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LjLtnm99UNkajjroI/nKDAD5Lkxp7VQb3KbdYvNYhorGqUfSZEbvg6t4AjDFw9u5y
         pJnlFvZ1qXSTxmI4v7a+Pb5d4EItxhqFUlLOEkUZWKQYAmO304hngxZQUPaNGyAxB/
         RLcKLY5HmdelxbP7BDdWLCfknHS3oD0Wk+KKtOhw=
Date:   Fri, 1 Nov 2019 15:53:43 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     zhong jiang <zhongjiang@huawei.com>
Cc:     broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: sun4i: Use PTR_ERR_OR_ZERO to simplify the code
Message-ID: <20191101145343.4nazxxztj5sfcuxm@hendrix>
References: <1572530979-27595-1-git-send-email-zhongjiang@huawei.com>
 <20191101091355.ibbet6a2zb23bpjn@hendrix>
 <5DBC1D3E.8080705@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fghmn2akruuf7rkm"
Content-Disposition: inline
In-Reply-To: <5DBC1D3E.8080705@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fghmn2akruuf7rkm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 01, 2019 at 07:55:42PM +0800, zhong jiang wrote:
> On 2019/11/1 17:13, Maxime Ripard wrote:
> > On Thu, Oct 31, 2019 at 10:09:39PM +0800, zhong jiang wrote:
> >> It is better to use PTR_ERR_OR_ZERO rather than if(IS_ERR(...)) + PTR_ERR.
> >>
> >> Signed-off-by: zhong jiang <zhongjiang@huawei.com>
> >> ---
> >>  sound/soc/sunxi/sun4i-i2s.c | 4 +---
> >>  1 file changed, 1 insertion(+), 3 deletions(-)
> >>
> >> diff --git a/sound/soc/sunxi/sun4i-i2s.c b/sound/soc/sunxi/sun4i-i2s.c
> >> index d0a8d58..72012a6 100644
> >> --- a/sound/soc/sunxi/sun4i-i2s.c
> >> +++ b/sound/soc/sunxi/sun4i-i2s.c
> >> @@ -1174,10 +1174,8 @@ static int sun4i_i2s_init_regmap_fields(struct device *dev,
> >>  	i2s->field_fmt_sr =
> >>  			devm_regmap_field_alloc(dev, i2s->regmap,
> >>  						i2s->variant->field_fmt_sr);
> >> -	if (IS_ERR(i2s->field_fmt_sr))
> >> -		return PTR_ERR(i2s->field_fmt_sr);
> >>
> >> -	return 0;
> >> +	return PTR_ERR_OR_ZERO(i2s->field_fmt_sr);
> > I don't find it "better". This couples the error handling and the
> > success case, and it makes it harder to extend in the future.
>
> PTR_ERR_OR_ZERO has implemented the if(IS_ERR(...)) + PTR_ERR. It is
> feasible to replace it and more readable at least now.
>
> As you said,  PTR_ERR_OR_ZERO should be removed ? :-(

No, I'm saying that in this context, this change isn't necessary.

Maxime

--fghmn2akruuf7rkm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXbxG9wAKCRDj7w1vZxhR
xZ42AQDQlwiNlRaoXcmwlcL4rb+Xeg2H3yhdzRa5fc61mvBkgwD9HIeK126LjhXW
5Zhap6t6j9ek4YsuLZExdBqcUv9jfg0=
=d28i
-----END PGP SIGNATURE-----

--fghmn2akruuf7rkm--
