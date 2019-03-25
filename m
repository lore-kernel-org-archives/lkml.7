Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2800C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 17:10:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B270207DD
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 17:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553533824;
	bh=mjxygTOz0VfXyEdP437l5ZjPaHMvCuH2ypZNPL35xTk=;
	h=In-Reply-To:References:From:Subject:Cc:To:Date:List-ID:From;
	b=MqFHQd7HTQ2sBDsBDcaHX8TgFPrFxnp6mm1AZNAyrrV1kiDouSPHZWkm6D8lOIYFd
	 RLOR93WuS2XletjO8yrtf1QsUCJDy0ssb45/uNjbLvlPlYqmt3HL3g6F7CmIOUnqXr
	 cZkkVhA+8+bxdlGfTrKGqNPdnmUNlAaaeu2jYWag=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729992AbfCYRKX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 13:10:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:54548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729095AbfCYRKU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 13:10:20 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F3F3207DD;
        Mon, 25 Mar 2019 17:10:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553533819;
        bh=mjxygTOz0VfXyEdP437l5ZjPaHMvCuH2ypZNPL35xTk=;
        h=In-Reply-To:References:From:Subject:Cc:To:Date:From;
        b=X+d7VbyuaMdwdPzusjaMKEp7d/Z9+OKyt6GTmtaX3hLJQBpw/+bkF+lEpfazRgZlI
         ihs4fTc6CjUy3/JITKtxz42md16cfO+/WXiG1bJnwCsZ5B/10yo9T7WkZRI9EGUecQ
         bpMLRyNBxwLBLmgi7wTV45/9Z4oAH1n96p/6UoaE=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190325111200.15940-2-jbrunet@baylibre.com>
References: <20190325111200.15940-1-jbrunet@baylibre.com> <20190325111200.15940-2-jbrunet@baylibre.com>
From:   Stephen Boyd <sboyd@kernel.org>
Subject: Re: [PATCH 1/4] clk: meson: mpll: add init callback and regs
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>
Message-ID: <155353381842.20095.17915880223118004926@swboyd.mtv.corp.google.com>
User-Agent: alot/0.8
Date:   Mon, 25 Mar 2019 10:10:18 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jerome Brunet (2019-03-25 04:11:57)
> @@ -138,6 +129,27 @@ static int mpll_set_rate(struct clk_hw *hw,
>         return 0;
>  }
> =20
> +static void mpll_init(struct clk_hw *hw)
> +{
> +       struct clk_regmap *clk =3D to_clk_regmap(hw);
> +       struct meson_clk_mpll_data *mpll =3D meson_clk_mpll_data(clk);
> +
> +       if (mpll->init_count)
> +               regmap_multi_reg_write(clk->map, mpll->init_regs,
> +                                      mpll->init_count);
> +
> +       /* Enable the fractional part */
> +       meson_parm_write(clk->map, &mpll->sdm_en, 1);
> +
> +       /* Set additional fractional part enable if required */
> +       if (MESON_PARM_APPLICABLE(&mpll->ssen))
> +               meson_parm_write(clk->map, &mpll->ssen, 1);
> +
> +       /* Set the magic misc bit if required */
> +       if (MESON_PARM_APPLICABLE(&mpll->misc))
> +               meson_parm_write(clk->map, &mpll->misc, 1);
> +}
> +
>  const struct clk_ops meson_clk_mpll_ro_ops =3D {
>         .recalc_rate    =3D mpll_recalc_rate,
>         .round_rate     =3D mpll_round_rate,
> @@ -148,6 +160,7 @@ const struct clk_ops meson_clk_mpll_ops =3D {
>         .recalc_rate    =3D mpll_recalc_rate,
>         .round_rate     =3D mpll_round_rate,
>         .set_rate       =3D mpll_set_rate,
> +       .init           =3D mpll_init,

We actively discourage using init callbacks. Can you do this some other
way?

>  };
>  EXPORT_SYMBOL_GPL(meson_clk_mpll_ops);
> =20
