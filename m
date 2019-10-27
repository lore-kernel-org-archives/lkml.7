Return-Path: <SRS0=Ymnc=YU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EFD4CA9EAF
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F04F0222BE
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Oct 2019 21:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1572211637;
	bh=bNaiTRs73b3nU2uDAXq1nlYBMsWSUeirR2Lzw+CNp3Q=;
	h=In-Reply-To:References:To:From:Cc:Subject:Date:List-ID:From;
	b=hqyyWyrHWKiO89rOISkA27euFubvrOuCWM7nzcyzpVS8ANWtmSBp46yNLntdX0A/t
	 A6EnzCQ9OQ7WtusgZ6U4nsiWbAVNDBnPQhDjW+3YXEAqJmHgTU98cGoE6QYy6CYA0v
	 8NqS27XgyBi1RdfX96yeSWox3j7CZADeUCI3Ttm4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730846AbfJ0V1P (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Oct 2019 17:27:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:47378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732737AbfJ0VZ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Oct 2019 17:25:28 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AE3D021783;
        Sun, 27 Oct 2019 21:25:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572211527;
        bh=bNaiTRs73b3nU2uDAXq1nlYBMsWSUeirR2Lzw+CNp3Q=;
        h=In-Reply-To:References:To:From:Cc:Subject:Date:From;
        b=AeRJJyAS6E+Ckbdk493mYAqTKhYG3sE+ZcY+jlmLsAUKb2o76OzLczJKA5UCyla9V
         DiMwR80R0JXxIj5ucU0KUOM3HzUzhvEhvmfZ50CPKAADp5+zzr74SL3oG4Y0R5DAB5
         IreC2Z4HcHYZqrH9W+pkbCb1tFjXOK8U6KJwH7TA=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20191021105435.GE2654@vkoul-mobl>
References: <20190917091623.3453-1-vkoul@kernel.org> <20190917161000.DAFF3206C2@mail.kernel.org> <20191016122343.GM2654@vkoul-mobl> <20191017174820.F08422089C@mail.kernel.org> <20191021105435.GE2654@vkoul-mobl>
To:     Vinod Koul <vkoul@kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, Taniya Das <tdas@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: gcc: Add missing clocks in SM8150
User-Agent: alot/0.8.1
Date:   Sun, 27 Oct 2019 14:25:26 -0700
Message-Id: <20191027212527.AE3D021783@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vinod Koul (2019-10-21 03:54:35)
> On 17-10-19, 10:48, Stephen Boyd wrote:
> > > > > diff --git a/drivers/clk/qcom/gcc-sm8150.c b/drivers/clk/qcom/gcc=
-sm8150.c
> > > > > index 12ca2d14797f..13d4d14a5744 100644
> > > > > --- a/drivers/clk/qcom/gcc-sm8150.c
> > > > > +++ b/drivers/clk/qcom/gcc-sm8150.c
> > > > > @@ -1616,6 +1616,38 @@ static struct clk_branch gcc_gpu_cfg_ahb_c=
lk =3D {
> > > > >         },
> > > > >  };
> > > > > =20
> > > > > +static struct clk_branch gcc_gpu_gpll0_clk_src =3D {
> > > > > +       .halt_check =3D BRANCH_HALT_SKIP,
> > > >=20
> > > > Why skip?
> > >=20
> > > I will explore and add comments for that
> > >=20
> > > > > +       .clkr =3D {
> > > > > +               .enable_reg =3D 0x52004,
> > > > > +               .enable_mask =3D BIT(15),
> > > > > +               .hw.init =3D &(struct clk_init_data){
> > > > > +                       .name =3D "gcc_gpu_gpll0_clk_src",
> > > > > +                       .parent_hws =3D (const struct clk_hw *[]){
> > > > > +                               &gpll0.clkr.hw },
> > > > > +                       .num_parents =3D 1,
> > > > > +                       .flags =3D CLK_SET_RATE_PARENT,
> > > > > +                       .ops =3D &clk_branch2_ops,
> > > > > +               },
> > > > > +       },
> > > > > +};
> > > > > +
> > > > > +static struct clk_branch gcc_gpu_gpll0_div_clk_src =3D {
> > > > > +       .halt_check =3D BRANCH_HALT_SKIP,
> > > >=20
> > > > Why skip?
> > > >=20
> >=20
> > Any answer from the explorations?
>=20
> Yeah so asking around the answer I got is that these are external
> clocks and we need cannot rely on CLK_OFF bit for these clocks
>=20

The parents are from some other clk controller? Not external to the
chip, right? If so, I still don't get it. Please add some sort of
comment here in the code.

