Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE1F9C17441
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 12:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B332B2190F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 12:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573475982;
	bh=IyPu+oU78BR99iNVtTf6kR7ZsoJaWH9p3+6ksQHASkw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wz3YNld5w9YXq/95DSUmQA8/1DHMwsbxZCBaah6ezUwHcXPDwnTJPM3xWwO3rPfwN
	 U5+v7V5z6QRvJPPUL9Kzf+upg/lJ3lM9jZC8WRgcePfHcDSOc3AI0+gEA89dtSkE/h
	 HN16mjTvJdwqL8omfck7N4O4s+CyAk/7k6MbN7Qs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbfKKMjm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 07:39:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:59574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726853AbfKKMjl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 07:39:41 -0500
Received: from localhost (lfbn-1-10718-76.w90-89.abo.wanadoo.fr [90.89.68.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B251521872;
        Mon, 11 Nov 2019 12:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573475981;
        bh=IyPu+oU78BR99iNVtTf6kR7ZsoJaWH9p3+6ksQHASkw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TnIbfoNKGvJkLIgpG3sXWjgaRKucqqZWB2ugitr1Fd3BilhdyC9e9/RL2Wr7/TGqj
         TlE/qvUT0gADFASPLDFKNfgaHXB5jRplHmDCujie4eq3wLdfDEnw2dHKjQ5TfIcTE2
         8qLxK4kv+F7CQms5Pz74C8XZwNNifNtfbE817jY4=
Date:   Mon, 11 Nov 2019 13:39:36 +0100
From:   Maxime Ripard <mripard@kernel.org>
To:     Tian Yunhao <t123yh@outlook.com>
Cc:     Icenowy Zheng <icenowy@aosc.io>, Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] clk: sunxi-ng: v3s: Fix incorrect number of hw_clks.
Message-ID: <20191111123936.GM4345@gilmour.lan>
References: <BN8PR08MB57792366D78997180A698AF8897A0@BN8PR08MB5779.namprd08.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Y+Z5jE7Arku/2GrR"
Content-Disposition: inline
In-Reply-To: <BN8PR08MB57792366D78997180A698AF8897A0@BN8PR08MB5779.namprd08.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--Y+Z5jE7Arku/2GrR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Thanks for your patch

On Sat, Nov 09, 2019 at 03:19:09PM +0000, Tian Yunhao wrote:
> The hws field of sun8i_v3s_hw_clks has only 74
> members. However, the number specified by CLK_NUMBER
> is 77 (= CLK_I2S0 + 1). This leads to runtime segmentation
> fault that is not always reproducible.
>
> This patch adds a protective field [CLK_NUMBER] which ensures
> ARRAY_SIZE(.hws) is always greater than .num, thus eliminates
> this error.
>
> Signed-off-by: Yunhao Tian <t123yh@outlook.com>
> ---
>  drivers/clk/sunxi-ng/ccu-sun8i-v3s.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c b/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c
> index 5c779eec454b..de7fce7f32e6 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun8i-v3s.c
> @@ -617,6 +617,7 @@ static struct clk_hw_onecell_data sun8i_v3s_hw_clks = {
>  		[CLK_AVS]		= &avs_clk.common.hw,
>  		[CLK_MBUS]		= &mbus_clk.common.hw,
>  		[CLK_MIPI_CSI]		= &mipi_csi_clk.common.hw,
> +		[CLK_NUMBER]    = NULL,
>  	},
>  	.num	= CLK_NUMBER,
>  };
> @@ -699,6 +700,7 @@ static struct clk_hw_onecell_data sun8i_v3_hw_clks = {
>  		[CLK_AVS]		= &avs_clk.common.hw,
>  		[CLK_MBUS]		= &mbus_clk.common.hw,
>  		[CLK_MIPI_CSI]		= &mipi_csi_clk.common.hw,
> +		[CLK_NUMBER]    = NULL,
>  	},
>  	.num	= CLK_NUMBER,

I'd rather have the number of clocks (.num) being properly set.

Maxime

--Y+Z5jE7Arku/2GrR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCXclWiAAKCRDj7w1vZxhR
xXUPAQDUEnwEjsRX6RINO7bgy2jstA7NJOwLIIXxn0KYXmQhjgEAoyQC8Pu7fer1
8+PaAcBRjjJdzHQrqqYV/PYvjI9dkQE=
=QKWO
-----END PGP SIGNATURE-----

--Y+Z5jE7Arku/2GrR--
