Return-Path: <SRS0=CEgE=VT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E9F9C76194
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 21:25:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E88D82199C
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jul 2019 21:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1563830740;
	bh=NW7gQC4ICt0N9/M+RHMFx28ZJTSv9cMfIhpuZHQv35w=;
	h=In-Reply-To:References:Subject:To:Cc:From:Date:List-ID:From;
	b=rSl56c2lDyPkybVBONVeYvD2fLK64fZBDEXAKvQsqHn1HseNa8xGuZyT4MwK1YZPC
	 rzTLyR83IYs02Uj7g3L9lpRet7nnppVJ8eX3hYFxPz9BuXOxXka+fAksYV/XZJa15a
	 4nlZg+xtp4C5i4ryEtHPv+EmEfuU1EtFRm7cZ9GM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731568AbfGVVZi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jul 2019 17:25:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:54362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729059AbfGVVZi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jul 2019 17:25:38 -0400
Received: from kernel.org (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41C9121900;
        Mon, 22 Jul 2019 21:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563830737;
        bh=NW7gQC4ICt0N9/M+RHMFx28ZJTSv9cMfIhpuZHQv35w=;
        h=In-Reply-To:References:Subject:To:Cc:From:Date:From;
        b=hXFwaRQ7UUiTJbf90j7UD6moPpoc9yC4DZo44EfNqlULb8ETuD8ZbrBhKjcTRo9FH
         WXY+++WosNX0wunwkISAfXn4J0IF5QHuIpIXi7rWY3UALHNiInmZCgheVowxDDs7NS
         FFBRu3zwZacwUg8LwJmhzAGevALVAy9s1XutzI1M=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20190705085218.lvvqnqx6nfph2era@fsr-ub1664-175>
References: <1561453316-11481-1-git-send-email-abel.vesa@nxp.com> <20190625223223.3B8EC2053B@mail.kernel.org> <20190705085218.lvvqnqx6nfph2era@fsr-ub1664-175>
Subject: Re: [PATCH] clk: imx8mq: Mark AHB clock as critical
To:     Abel Vesa <abel.vesa@nxp.com>
Cc:     Anson Huang <anson.huang@nxp.com>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Sascha Hauer <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8.1
Date:   Mon, 22 Jul 2019 14:25:36 -0700
Message-Id: <20190722212537.41C9121900@mail.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Abel Vesa (2019-07-05 01:52:19)
> On 19-06-25 15:32:22, Stephen Boyd wrote:
> > Quoting Abel Vesa (2019-06-25 02:01:56)
> > > Keep the AHB clock always on since there is no driver to control it a=
nd
> > > all the other clocks that use it as parent rely on it being always en=
abled.
> > >=20
> > > Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> > > ---
> > >  drivers/clk/imx/clk-imx8mq.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8m=
q.c
> > > index 5fbc2a7..b48268b 100644
> > > --- a/drivers/clk/imx/clk-imx8mq.c
> > > +++ b/drivers/clk/imx/clk-imx8mq.c
> > > @@ -398,7 +398,7 @@ static int imx8mq_clocks_probe(struct platform_de=
vice *pdev)
> > >         clks[IMX8MQ_CLK_NOC_APB] =3D imx8m_clk_composite_critical("no=
c_apb", imx8mq_noc_apb_sels, base + 0x8d80);
> > > =20
> > >         /* AHB */
> > > -       clks[IMX8MQ_CLK_AHB] =3D imx8m_clk_composite("ahb", imx8mq_ah=
b_sels, base + 0x9000);
> > > +       clks[IMX8MQ_CLK_AHB] =3D imx8m_clk_composite_critical("ahb", =
imx8mq_ahb_sels, base + 0x9000);
> >=20
> > Please add a comment into the code why it's critical.
>=20
> Comment explaining why the AHB bus clock is critical ?
> Isn't that self-explanatory ?

Nope, it isn't self-explanatory, because nothing on this line says "bus"
and it could be that someone reading this code isn't well versed in the
concepts of ARM world AHB to connect the two.

>=20
> >=20
> > >         clks[IMX8MQ_CLK_AUDIO_AHB] =3D imx8m_clk_composite("audio_ahb=
", imx8mq_audio_ahb_sels, base + 0x9100);
