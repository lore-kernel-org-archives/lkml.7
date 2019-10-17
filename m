Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A5DECE58D
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 17:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F5922089C
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 17:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571334505;
	bh=v34jWqxmNeAMOoNfEOFlbq2+WSKHjXcMGhvRy6ZMeig=;
	h=In-Reply-To:References:From:To:Cc:Subject:Date:List-ID:From;
	b=Wl6jE2hKnfkk649iRKKfZW2GJ0BnrdXQEgx2Jq2O3rBDFWs7oX+94Fer5jwt/wzI6
	 ovcjEsjnUoiUbYjRVpffrnMl+ns2A53EnF8W0eVdfyIujbiys+BW4FK+89VJ7baKQc
	 nVeatYumA8pizpmATz9OIfZEo75Sitk5shTP04NQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730666AbfJQRsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 13:48:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:47148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437169AbfJQRsV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 13:48:21 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F08422089C;
        Thu, 17 Oct 2019 17:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571334501;
        bh=v34jWqxmNeAMOoNfEOFlbq2+WSKHjXcMGhvRy6ZMeig=;
        h=In-Reply-To:References:From:To:Cc:Subject:Date:From;
        b=M262+xKAyWHA0QeAIq39nDeoMvMpkBRJ6TbbsDN/MDmB4cd9yD90JsNNrxuEY5arz
         uXHFuLaJGR2Sfw3uBWNd775l1T0L5DfcHX2dKE0HQnIB+FRr8bsvdWlkd5jSlZNEqM
         AuZS6lW8VkEDJWWEBWlqhsbkz8rROA031xEABvQo=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191016122343.GM2654@vkoul-mobl>
References: <20190917091623.3453-1-vkoul@kernel.org> <20190917161000.DAFF3206C2@mail.kernel.org> <20191016122343.GM2654@vkoul-mobl>
From:   Stephen Boyd <sboyd@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: gcc: Add missing clocks in SM8150
User-Agent: alot/0.8.1
Date:   Thu, 17 Oct 2019 10:48:20 -0700
Message-Id: <20191017174820.F08422089C@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vinod Koul (2019-10-16 05:23:43)
> Hi Steve,
>=20
> Looks like I missed replying to this one, apologies!
>=20
> On 17-09-19, 09:09, Stephen Boyd wrote:
> > Quoting Vinod Koul (2019-09-17 02:16:23)
> > > The initial upstreaming of SM8150 GCC driver missed few clock so add
> > > them up now.
> > >=20
> > > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > > ---
> >=20
> > Should have some sort of fixes tag?
>=20
> Not really, the drivers to use these clks are not upstream so we dont
> miss it yet

Ok.

>=20
> >=20
> > >  drivers/clk/qcom/gcc-sm8150.c | 172 ++++++++++++++++++++++++++++++++=
++
> > >  1 file changed, 172 insertions(+)
> > >=20
> > > diff --git a/drivers/clk/qcom/gcc-sm8150.c b/drivers/clk/qcom/gcc-sm8=
150.c
> > > index 12ca2d14797f..13d4d14a5744 100644
> > > --- a/drivers/clk/qcom/gcc-sm8150.c
> > > +++ b/drivers/clk/qcom/gcc-sm8150.c
> > > @@ -1616,6 +1616,38 @@ static struct clk_branch gcc_gpu_cfg_ahb_clk =
=3D {
> > >         },
> > >  };
> > > =20
> > > +static struct clk_branch gcc_gpu_gpll0_clk_src =3D {
> > > +       .halt_check =3D BRANCH_HALT_SKIP,
> >=20
> > Why skip?
>=20
> I will explore and add comments for that
>=20
> > > +       .clkr =3D {
> > > +               .enable_reg =3D 0x52004,
> > > +               .enable_mask =3D BIT(15),
> > > +               .hw.init =3D &(struct clk_init_data){
> > > +                       .name =3D "gcc_gpu_gpll0_clk_src",
> > > +                       .parent_hws =3D (const struct clk_hw *[]){
> > > +                               &gpll0.clkr.hw },
> > > +                       .num_parents =3D 1,
> > > +                       .flags =3D CLK_SET_RATE_PARENT,
> > > +                       .ops =3D &clk_branch2_ops,
> > > +               },
> > > +       },
> > > +};
> > > +
> > > +static struct clk_branch gcc_gpu_gpll0_div_clk_src =3D {
> > > +       .halt_check =3D BRANCH_HALT_SKIP,
> >=20
> > Why skip?
> >=20

Any answer from the explorations?

