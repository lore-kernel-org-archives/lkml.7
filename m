Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B177AC4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 20:09:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8306C222C8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 20:09:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568837362;
	bh=fOhSKAKBlBR8tnbKfh/2cRHcfVt6SAbNweeiVuSPlLE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ocImglVqVdfDyjxTZBvwwAqlIe/teSI9OUuBPl4lzmiHKM/8yfNtKpw6NyWWkdgID
	 KH0AQlOJm6Su0DWHg3DBGf39RGIDW1Z2iE3UgW6+ngRlQRQVSJY9dA5xjjgfiSHN9L
	 PCFf5Nejt9ZPvytCUspae6YXyVOyPNV2Xcu9Lf18=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390641AbfIRUJV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 16:09:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:59638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390627AbfIRUJU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 16:09:20 -0400
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7E7921927;
        Wed, 18 Sep 2019 20:09:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568837359;
        bh=fOhSKAKBlBR8tnbKfh/2cRHcfVt6SAbNweeiVuSPlLE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=g4e02vBhHET34BYIzpZHZNIUl+b6bp+dwAlK5jzLOO8OTMI4gYLfFIRk4nifKKp7q
         GTHQzlEs7UIYqEidg/sbU4qiC2wPwKrO3CNhpL4l46hqNcSWkCfn5ow+G0YVCQRqeu
         3agnnwij+hPSJaZ+U+tt1nhW43X/6GY9cht3IW9o=
Received: by mail-qt1-f171.google.com with SMTP id c21so1256589qtj.12;
        Wed, 18 Sep 2019 13:09:19 -0700 (PDT)
X-Gm-Message-State: APjAAAWqZCLAA28sXRkqf8eihXTCM8RwypQ7qWkdj5+OxavTMk7tezNP
        HoQ4CecdKkbn+jiSTeZuEykJHqKMbv+ogDjoXQ==
X-Google-Smtp-Source: APXvYqyI0YWOlINOzwZl5AYOwbRdU1uVlZeni02GnsS/T/U6yuTYOht5gSEnZU8Z0DdyycUyh6iztt8ZwwabQaKl+2Y=
X-Received: by 2002:ac8:75c7:: with SMTP id z7mr6127853qtq.136.1568837358985;
 Wed, 18 Sep 2019 13:09:18 -0700 (PDT)
MIME-Version: 1.0
References: <20190918063837.8196-1-u.kleine-koenig@pengutronix.de>
 <b00ca30f-2c06-7722-96b2-123d15751cb6@axentia.se> <20190918084748.hnjkiq7wc5b35wjh@pengutronix.de>
In-Reply-To: <20190918084748.hnjkiq7wc5b35wjh@pengutronix.de>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 18 Sep 2019 15:09:06 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJuJrOj+D4xkGACC1=zaB5OUkt=SNzCOiOiTVtM9E9z+A@mail.gmail.com>
Message-ID: <CAL_JsqJuJrOj+D4xkGACC1=zaB5OUkt=SNzCOiOiTVtM9E9z+A@mail.gmail.com>
Subject: Re: [PATCH v2] of: restore old handling of cells_name=NULL in of_*_phandle_with_args()
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Peter Rosin <peda@axentia.se>,
        Frank Rowand <frowand.list@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 3:47 AM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> Before commit e42ee61017f5 ("of: Let of_for_each_phandle fallback to
> non-negative cell_count") the iterator functions calling
> of_for_each_phandle assumed a cell count of 0 if cells_name was NULL.
> This corner case was missed when implementing the fallback logic in
> e42ee61017f5 and resulted in an endless loop.
>
> Restore the old behaviour of of_count_phandle_with_args() and
> of_parse_phandle_with_args() and add a check to
> of_phandle_iterator_init() to prevent a similar failure as a safety
> precaution. of_parse_phandle_with_args_map() doesn't need a similar fix
> as cells_name isn't NULL there.
>
> Affected drivers are:
>  - drivers/base/power/domain.c
>  - drivers/base/power/domain.c
>  - drivers/clk/ti/clk-dra7-atl.c
>  - drivers/hwmon/ibmpowernv.c
>  - drivers/i2c/muxes/i2c-demux-pinctrl.c
>  - drivers/iommu/mtk_iommu.c
>  - drivers/net/ethernet/freescale/fman/mac.c
>  - drivers/opp/of.c
>  - drivers/perf/arm_dsu_pmu.c
>  - drivers/regulator/of_regulator.c
>  - drivers/remoteproc/imx_rproc.c
>  - drivers/soc/rockchip/pm_domains.c
>  - sound/soc/fsl/imx-audmix.c
>  - sound/soc/fsl/imx-audmix.c
>  - sound/soc/meson/axg-card.c
>  - sound/soc/samsung/tm2_wm5110.c
>  - sound/soc/samsung/tm2_wm5110.c
>
> Thanks to Geert Uytterhoeven for reporting the issue, Peter Rosin for
> helping pinpoint the actual problem and the testers for confirming this
> fix.
>
> Fixes: e42ee61017f5 ("of: Let of_for_each_phandle fallback to non-negativ=
e cell_count")
> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>
> On Wed, Sep 18, 2019 at 08:01:05AM +0000, Peter Rosin wrote:
> > On 2019-09-18 08:38, Uwe Kleine-K=C3=B6nig wrote:
> > >  EXPORT_SYMBOL(of_parse_phandle_with_args);
> > >
> > > @@ -1765,6 +1779,18 @@ int of_count_phandle_with_args(const struct de=
vice_node *np, const char *list_na
> > >     struct of_phandle_iterator it;
> > >     int rc, cur_index =3D 0;
> > >
> > > +   /* If cells_name is NULL we assume a cell count of 0 */
> > > +   if (cells_name =3D=3D NULL) {
> >
> > A couple of nits.
> >
> > I don't know if there are other considerations, but in the previous two
> > hunks you use !cells_name instead of comparing explicitly with NULL.
> > Personally, I find the shorter form more readable, and in the name of
> > consistency bla bla...
>
> Ack, changed to !cells_name here, too.
>
> >
> > Also, the comment explaining this NULL-check didn't really make sense
> > to me until I realized that knowing the cell count to be zero makes
> > counting trivial. Something along those lines should perhaps be in the
> > comment?
>
> You're right, I extended the comment a bit.
>
> > But as I said, these are nits. Feel free to ignore.
>
> I considered resending already anyhow as I fatfingerd my email address.
> this is fixed now, too. Additionally I fixed a typo in one of the
> comments.
>
> Thanks for your feedback.
>
> Best regards
> Uwe
>
>  drivers/of/base.c | 35 +++++++++++++++++++++++++++++++++--
>  1 file changed, 33 insertions(+), 2 deletions(-)

Can I get a proper patch please.

Rob
