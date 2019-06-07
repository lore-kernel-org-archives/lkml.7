Return-Path: <SRS0=2dYc=UG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A663C2BCA1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 19:03:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36E1D2146E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Jun 2019 19:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1559934215;
	bh=mrL8ZvU1j098gqUDw8JKIJmCCxGU9vpbYH6xVhe34iM=;
	h=In-Reply-To:References:To:From:Subject:Cc:Date:List-ID:From;
	b=dprv/VX/W94D0YThfEa8na6JAKphBvFR7ky8CDgs3zLHgiyaNM2cQKVqA1ciz4CCH
	 O7SmZkMruCP0//hJPCrSAZJyLiB5RUhuXQxTc/+LVe6kXsRMBI6F1P3G+1lSpud0aY
	 nsy86tEa83VGhhDnauFZEOUdlu9zvjQw+E2HDVec=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730253AbfFGTDe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Jun 2019 15:03:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:60192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730212AbfFGTDc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jun 2019 15:03:32 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B06020868;
        Fri,  7 Jun 2019 19:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559934211;
        bh=mrL8ZvU1j098gqUDw8JKIJmCCxGU9vpbYH6xVhe34iM=;
        h=In-Reply-To:References:To:From:Subject:Cc:Date:From;
        b=aBft8Ng32JulEBE9OCaXF/cfqepkKpawjKLmviZxT4hl2AUj+eStMAu2WpzSfOfr6
         CYtJlXMPERBWssrLSooM/NOAcjFr3wTTXL59aQAzpUKEiVsJuCAco1QNi9mo+uqxI3
         F0zju3tuU/ktvo9M1pqGD5IuNkLFt43gwkfkoHJU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190607104533.14700-1-colin.king@canonical.com>
References: <20190607104533.14700-1-colin.king@canonical.com>
To:     Colin King <colin.king@canonical.com>,
        Eric Anholt <eric@anholt.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH][next] clk: bcm2835: fix memork leak on unfree'd pll struct
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
User-Agent: alot/0.8.1
Date:   Fri, 07 Jun 2019 12:03:30 -0700
Message-Id: <20190607190331.8B06020868@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Colin King (2019-06-07 03:45:33)
> From: Colin Ian King <colin.king@canonical.com>
>=20
> The pll struct is being allocated but not kfree'd on an error return
> path when devm_clk_hw_register fails.  Fix this with a kfree on pll
> if an error occurs.
>=20
> Addresses-Coverity: ("Resource leak")
> Fixes: b19f009d4510 ("clk: bcm2835: Migrate to clk_hw based registration =
and OF APIs")

I suspect this problem was there before this commit, but OK.

> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/clk/bcm/clk-bcm2835.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/clk/bcm/clk-bcm2835.c b/drivers/clk/bcm/clk-bcm2835.c
> index 770bb01f523e..90584deaf416 100644
> --- a/drivers/clk/bcm/clk-bcm2835.c
> +++ b/drivers/clk/bcm/clk-bcm2835.c
> @@ -1310,8 +1310,10 @@ static struct clk_hw *bcm2835_register_pll(struct =
bcm2835_cprman *cprman,
>         pll->hw.init =3D &init;
> =20
>         ret =3D devm_clk_hw_register(cprman->dev, &pll->hw);
> -       if (ret)
> +       if (ret) {
> +               kfree(pll);
>                 return NULL;
> +       }
>         return &pll->hw;
>  }

Aren't there more leaks in this driver?=20

