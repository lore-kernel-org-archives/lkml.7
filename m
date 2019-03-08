Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC951C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 06:24:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD27120811
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 06:24:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fDC+PGo/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbfCHGYK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 01:24:10 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:46816 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbfCHGYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 01:24:10 -0500
Received: by mail-qt1-f194.google.com with SMTP id z25so20088742qti.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 22:24:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aGU05ZOWtmlmwypOaP7id+McLm9LOcz0MsaglE8fUvs=;
        b=fDC+PGo/0AQKJxSSJYBvclvGPPGa/iuloy2vQ/4nHs8KCiDUSsQhDxrt/796+UmafS
         Zz9F6AdSaA80Pu9EbAn5HmSe9sDWMB8OhkQBXIb7rxIYCiP/8TAgYWx1gLeiK7atOTQ4
         s4GvsKRjn84Qldrl5DzrcPqt6AskGfA8n3JFQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aGU05ZOWtmlmwypOaP7id+McLm9LOcz0MsaglE8fUvs=;
        b=G1Ns1CCLgj+UPOAqzlazT/SkKHHODRNbyoX8itx90EoMMynG9nVS7Q0aX2kVLr2MtP
         Di29N+lmpkA6I/pmgG70hcmYssvaZ4a/85DNYTmPndlYtJkkoMyRfhUNjEt4dkm+J3MV
         pswsXCNkTxKJPvSGoD6utZTSOi/KaJlG3Swj8oAiQ3npvWFnMJP0LJlrEFoYmslfQ+VU
         4z26ixnF8ISPQ1T+KtfYigaUg2Cc5PFLcU0AAg11wc4DE+T41ryu41CirWps0t3KN+QE
         F2q6LBMzL3SxPxAeSPnEsXVYttjeF/8k4v+dmYyRI31z2cKBEsyYZm2x306Q+kOaa7E0
         YhvA==
X-Gm-Message-State: APjAAAWL4TR43XOWEa0zh3bvhatSOOyJYgepzvC9iulkxrjKznQwoP7M
        Xij4/K945i5hF8L0jJztjfHhPEEbxTFmFtaT9jw0UQ==
X-Google-Smtp-Source: APXvYqy0g0nSa9LQ7iM/NVOxQvvdiYV0Mlps+pG+r/4aixTM2hnLdxb9vb4NMmpqCZqeNrwFh1YRbKNlr9bEnUlcYr8=
X-Received: by 2002:ac8:3183:: with SMTP id h3mr13803375qte.368.1552026249063;
 Thu, 07 Mar 2019 22:24:09 -0800 (PST)
MIME-Version: 1.0
References: <20190305050546.23431-1-weiyi.lu@mediatek.com> <20190305050546.23431-9-weiyi.lu@mediatek.com>
In-Reply-To: <20190305050546.23431-9-weiyi.lu@mediatek.com>
From:   Nicolas Boichat <drinkcat@chromium.org>
Date:   Fri, 8 Mar 2019 14:23:58 +0800
Message-ID: <CANMq1KCcACM_h=OMoEcKGZNZiu740qEkSeMt-Pqsa+1Ex9P+tw@mail.gmail.com>
Subject: Re: [PATCH v5 7/9] clk: mediatek: Add configurable pcw_chg_reg to mtk_pll_data
To:     Weiyi Lu <weiyi.lu@mediatek.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Rob Herring <robh@kernel.org>,
        James Liao <jamesjj.liao@mediatek.com>,
        Fan Chen <fan.chen@mediatek.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, linux-clk@vger.kernel.org,
        srv_heupstream <srv_heupstream@mediatek.com>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 5, 2019 at 1:05 PM Weiyi Lu <weiyi.lu@mediatek.com> wrote:
>
> In previous MediaTek PLL design, it assumes the pcw change control
> is always on the CON1 register.
> However, the pcw change bit on MT8183 was moved onto CON0 because
> the the PCW length of audio PLLs are extended to 32-bit.
> Add configurable pcw_chg_reg to set the pcw change control register
> address or using the default control register CON1 if without
> setting in pll data.
>
> Signed-off-by: Weiyi Lu <weiyi.lu@mediatek.com>

Reviewed-and-tested-by: Nicolas Boichat <drinkcat@chromium.org>

> ---
>  drivers/clk/mediatek/clk-mtk.h |  1 +
>  drivers/clk/mediatek/clk-pll.c | 17 +++++++++++------
>  2 files changed, 12 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
> index 928905496c4b..37ae944548e9 100644
> --- a/drivers/clk/mediatek/clk-mtk.h
> +++ b/drivers/clk/mediatek/clk-mtk.h
> @@ -221,6 +221,7 @@ struct mtk_pll_data {
>         int pcwibits;
>         uint32_t pcw_reg;
>         int pcw_shift;
> +       uint32_t pcw_chg_reg;
>         const struct mtk_pll_div_table *div_table;
>         const char *parent_name;
>  };
> diff --git a/drivers/clk/mediatek/clk-pll.c b/drivers/clk/mediatek/clk-pll.c
> index 67aaa3082d9b..65cee1d6c400 100644
> --- a/drivers/clk/mediatek/clk-pll.c
> +++ b/drivers/clk/mediatek/clk-pll.c
> @@ -27,7 +27,7 @@
>  #define CON0_BASE_EN           BIT(0)
>  #define CON0_PWR_ON            BIT(0)
>  #define CON0_ISO_EN            BIT(1)
> -#define CON0_PCW_CHG           BIT(31)
> +#define PCW_CHG_MASK           BIT(31)
>
>  #define AUDPLL_TUNER_EN                BIT(31)
>
> @@ -51,6 +51,7 @@ struct mtk_clk_pll {
>         void __iomem    *tuner_addr;
>         void __iomem    *tuner_en_addr;
>         void __iomem    *pcw_addr;
> +       void __iomem    *pcw_chg_addr;
>         const struct mtk_pll_data *data;
>  };
>
> @@ -122,7 +123,7 @@ static void __mtk_pll_tuner_disable(struct mtk_clk_pll *pll)
>  static void mtk_pll_set_rate_regs(struct mtk_clk_pll *pll, u32 pcw,
>                 int postdiv)
>  {
> -       u32 con1, val;
> +       u32 chg, val;
>         int pll_en;
>
>         pll_en = readl(pll->base_addr + REG_CON0) & CON0_BASE_EN;
> @@ -147,14 +148,14 @@ static void mtk_pll_set_rate_regs(struct mtk_clk_pll *pll, u32 pcw,
>         val |= pcw << pll->data->pcw_shift;
>         writel(val, pll->pcw_addr);
>
> -       con1 = readl(pll->base_addr + REG_CON1);
> +       chg = readl(pll->pcw_chg_addr);
>
>         if (pll_en)
> -               con1 |= CON0_PCW_CHG;
> +               chg |= PCW_CHG_MASK;
>
> -       writel(con1, pll->base_addr + REG_CON1);
> +       writel(chg, pll->pcw_chg_addr);
>         if (pll->tuner_addr)
> -               writel(con1 + 1, pll->tuner_addr);
> +               writel(val + 1, pll->tuner_addr);
>
>         /* restore tuner_en */
>         __mtk_pll_tuner_enable(pll);
> @@ -329,6 +330,10 @@ static struct clk *mtk_clk_register_pll(const struct mtk_pll_data *data,
>         pll->pwr_addr = base + data->pwr_reg;
>         pll->pd_addr = base + data->pd_reg;
>         pll->pcw_addr = base + data->pcw_reg;
> +       if (data->pcw_chg_reg)
> +               pll->pcw_chg_addr = base + data->pcw_chg_reg;
> +       else
> +               pll->pcw_chg_addr = pll->base_addr + REG_CON1;
>         if (data->tuner_reg)
>                 pll->tuner_addr = base + data->tuner_reg;
>         if (data->tuner_en_reg)
> --
> 2.18.0
>
