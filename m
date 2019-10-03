Return-Path: <SRS0=6dNS=X4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 537AFC4CED1
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 18:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F0192133F
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Oct 2019 18:11:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1570126264;
	bh=aArKOWxO0UzBJPgQiYgtFIO0VS3NLn3FEgzr04GaghE=;
	h=In-Reply-To:References:From:To:Cc:Subject:Date:List-ID:From;
	b=JiAXAy2TJPS8JGOSiE6c9gNpSW5Fe0/rVwnZU4o318qPm+mcUYQ4lt8gNG0U1HomU
	 cV8WqylLiiVMbXC5p/Kxk/DUfSOJU+MGPWDWuSa+1yn7qYC5uEt1evTRkhp6t8RdT1
	 OalbOaGo9Da5m5Wg9Go2uQkYyP7SNdINBFePsejU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387440AbfJCSLD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Oct 2019 14:11:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:33842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731010AbfJCSLD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Oct 2019 14:11:03 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 803B120862;
        Thu,  3 Oct 2019 18:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570126262;
        bh=aArKOWxO0UzBJPgQiYgtFIO0VS3NLn3FEgzr04GaghE=;
        h=In-Reply-To:References:From:To:Cc:Subject:Date:From;
        b=sTG8BoNGODYMJh9K8VdkTLOSAFtZXJXm0caFHt36ztIL/MBfhYfFtDzI1Oi6LU0sL
         O1j9gxbPlg8iCQnVT8pMZIipOVO2X+bRYi5fdMJLaH1XMsr/Tl3y6rf1l0WaJpLBh+
         p2KCBMaJK91l7C6g24fwfoT8haHVbqLr8Dx8CycM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1569553244-3165-3-git-send-email-zhangqing@rock-chips.com>
References: <1569553244-3165-1-git-send-email-zhangqing@rock-chips.com> <1569553244-3165-3-git-send-email-zhangqing@rock-chips.com>
From:   Stephen Boyd <sboyd@kernel.org>
To:     Elaine Zhang <zhangqing@rock-chips.com>, heiko@sntech.de
Cc:     mturquette@baylibre.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        xxx@rock-chips.com, xf@rock-chips.com, huangtao@rock-chips.com,
        Elaine Zhang <zhangqing@rock-chips.com>
Subject: Re: [PATCH v3 2/5] clk: rockchip: fix up the frac clk get rate error
User-Agent: alot/0.8.1
Date:   Thu, 03 Oct 2019 11:11:01 -0700
Message-Id: <20191003181102.803B120862@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Elaine Zhang (2019-09-26 20:00:41)
> support fractional divider with only one level parent clock

Please put a lot more description in here. A single sentence doesn't
help anyone understand the motivation for the change.

>=20
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> ---
>  drivers/clk/rockchip/clk.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/clk/rockchip/clk.c b/drivers/clk/rockchip/clk.c
> index fac5a4a3f5c3..8f77c3f9fab7 100644
> --- a/drivers/clk/rockchip/clk.c
> +++ b/drivers/clk/rockchip/clk.c
> @@ -190,16 +190,21 @@ static void rockchip_fractional_approximation(struc=
t clk_hw *hw,
>         if (((rate * 20 > p_rate) && (p_rate % rate !=3D 0)) ||
>             (fd->max_prate && fd->max_prate < p_rate)) {
>                 p_parent =3D clk_hw_get_parent(clk_hw_get_parent(hw));
> -               p_parent_rate =3D clk_hw_get_rate(p_parent);
> -               *parent_rate =3D p_parent_rate;
> -               if (fd->max_prate && p_parent_rate > fd->max_prate) {
> -                       div =3D DIV_ROUND_UP(p_parent_rate, fd->max_prate=
);
> -                       *parent_rate =3D p_parent_rate / div;
> +               if (!p_parent) {
> +                       *parent_rate =3D p_rate;
> +               } else {
> +                       p_parent_rate =3D clk_hw_get_rate(p_parent);
> +                       *parent_rate =3D p_parent_rate;
> +                       if (fd->max_prate && p_parent_rate > fd->max_prat=
e) {
> +                               div =3D DIV_ROUND_UP(p_parent_rate,
> +                                                  fd->max_prate);
> +                               *parent_rate =3D p_parent_rate / div;
> +                       }
>                 }
> =20
>                 if (*parent_rate < rate * 20) {
> -                       pr_err("%s parent_rate(%ld) is low than rate(%ld)=
*20, fractional div is not allowed\n",
> -                              clk_hw_get_name(hw), *parent_rate, rate);
> +                       pr_warn("%s p_rate(%ld) is low than rate(%ld)*20,=
 use integer or half-div\n",
> +                               clk_hw_get_name(hw), *parent_rate, rate);

Hm.. now it's changed to a warning?

>                         *m =3D 0;
>                         *n =3D 1;
>                         return;
> --=20
> 1.9.1
>=20
>=20
>=20
