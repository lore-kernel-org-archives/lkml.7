Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6810C0650F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 11:14:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 829CF21874
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 11:14:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bUKpo3HS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732006AbfHHLOF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 07:14:05 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41058 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728289AbfHHLOF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 07:14:05 -0400
Received: by mail-ot1-f66.google.com with SMTP id o101so116960500ota.8;
        Thu, 08 Aug 2019 04:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Jva9Z6n1Ndr1YmdlN5MpKjiaFnFJwfp/j/OzHLMrf4o=;
        b=bUKpo3HSRB2Zw9epVhoaft+qoLn7Q+14BQa7xWXlLH+zsyn5UR9t4/r7YXHRs04mjS
         1E7ZtECX35PFXkqocvAlO6UIV28AeFNsqVOWieV5256ymXByUT+5YHt/JYmZxt301UDR
         5NNI/dp0dc96KKdeW78QSHZLqgCTgGMov+FU1Pc0CnOlPMho/HVZ5kIvyvCfUq4Fb7PW
         2f8n++DgkRdUBB6vCsHas7ZVNiNGxisu3X1m8KfrNsSedlqbcsgZ3ewk2i9OaVi2F6uo
         Hew2OtPK9n+Jy/nZAPwRPBQKTvsMHCVHW5a99Yi5+wLOEYSExu6eg2SYIhcCASR/LR3z
         ZLsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Jva9Z6n1Ndr1YmdlN5MpKjiaFnFJwfp/j/OzHLMrf4o=;
        b=is62tlDMyvCxAQcWvFqgaBpAqSSnFTDOdHu+oPLneudFdbafqHwqjzw7ECmjc48swP
         MKBYnegxAeSiIn59vUzXbyANhnAFyijkMPwmOl1adDsbmTuFH1Hfjj1DG38MXkSRXVB+
         xe+u5V2RDoy0xRgwSNy18DNgXzKqmnKldbDCmjGCgdPQu1z+y1XPJwyQi+Z5ns77VsU1
         fLZan2tE0l+ixaw3CaJUUxO607LB0yPEzD9hsEB8h8MwVRUuKJ4AaAxTd1UjL3fgMfHn
         bMG7s9YNMWRFpoW5DyypbdyBMYleSaYmrrMMdl5zYauVPz7NClBjJ8bpzZ57bQM+szj6
         ca/g==
X-Gm-Message-State: APjAAAVNz7yyNTWwjLgXIDMhGjX1rTqE3uS/W97AggxND1vxmdUmjBka
        yJW3uBpjfDJ/JQ8x4GjMjuGczFsB/o4SzaLWT74=
X-Google-Smtp-Source: APXvYqyOvbHA6UVjUCDh8aTmrSD/zJuVkzQMt/8VGMrhHSvsRFRebT3nqPDa5TlbA6p/J3xhepMlgPOACswmF2ALjFQ=
X-Received: by 2002:a02:c65a:: with SMTP id k26mr5206256jan.18.1565262843952;
 Thu, 08 Aug 2019 04:14:03 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190807162511eucas1p2eedb33bdee87f80528b59bb4e869daf1@eucas1p2.samsung.com>
 <20190807162456.28694-1-s.nawrocki@samsung.com>
In-Reply-To: <20190807162456.28694-1-s.nawrocki@samsung.com>
From:   Jaafar Ali <jaafarkhalaf@gmail.com>
Date:   Thu, 8 Aug 2019 14:08:55 +0300
Message-ID: <CAF-0O_59cMcdtrSYwm-sQ1p+Q8veo5xgV220Hop2CrBXg+cLcw@mail.gmail.com>
Subject: Re: [PATCH 1/2] clk: samsung: Change signature of exynos5_subcmus_init()
 function
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     sboyd@kernel.org, mturquette@baylibre.com, linux@armlinux.org.uk,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>, cw00.choi@samsung.com,
        m.szyprowski@samsung.com, b.zolnierkie@samsung.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tested-by: Jaafar Ali <jaafarkhalaf@gmail.com>

On Thu, 8 Aug 2019 at 12:24, Sylwester Nawrocki <s.nawrocki@samsung.com> wrote:
>
> In order to make it easier in subsequent patch to create different subcmu
> lists for exynos5420 and exynos5800 SoCs the code is rewritten so we pass
> an array of pointers to the subcmus initialization function.
>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  drivers/clk/samsung/clk-exynos5-subcmu.c | 16 +++----
>  drivers/clk/samsung/clk-exynos5-subcmu.h |  2 +-
>  drivers/clk/samsung/clk-exynos5250.c     |  7 ++-
>  drivers/clk/samsung/clk-exynos5420.c     | 60 ++++++++++++++----------
>  4 files changed, 49 insertions(+), 36 deletions(-)
>
> diff --git a/drivers/clk/samsung/clk-exynos5-subcmu.c b/drivers/clk/samsung/clk-exynos5-subcmu.c
> index 91db7894125d..65c82d922b05 100644
> --- a/drivers/clk/samsung/clk-exynos5-subcmu.c
> +++ b/drivers/clk/samsung/clk-exynos5-subcmu.c
> @@ -14,7 +14,7 @@
>  #include "clk-exynos5-subcmu.h"
>
>  static struct samsung_clk_provider *ctx;
> -static const struct exynos5_subcmu_info *cmu;
> +static const struct exynos5_subcmu_info **cmu;
>  static int nr_cmus;
>
>  static void exynos5_subcmu_clk_save(void __iomem *base,
> @@ -56,17 +56,17 @@ static void exynos5_subcmu_defer_gate(struct samsung_clk_provider *ctx,
>   * when OF-core populates all device-tree nodes.
>   */
>  void exynos5_subcmus_init(struct samsung_clk_provider *_ctx, int _nr_cmus,
> -                         const struct exynos5_subcmu_info *_cmu)
> +                         const struct exynos5_subcmu_info **_cmu)
>  {
>         ctx = _ctx;
>         cmu = _cmu;
>         nr_cmus = _nr_cmus;
>
>         for (; _nr_cmus--; _cmu++) {
> -               exynos5_subcmu_defer_gate(ctx, _cmu->gate_clks,
> -                                         _cmu->nr_gate_clks);
> -               exynos5_subcmu_clk_save(ctx->reg_base, _cmu->suspend_regs,
> -                                       _cmu->nr_suspend_regs);
> +               exynos5_subcmu_defer_gate(ctx, (*_cmu)->gate_clks,
> +                                         (*_cmu)->nr_gate_clks);
> +               exynos5_subcmu_clk_save(ctx->reg_base, (*_cmu)->suspend_regs,
> +                                       (*_cmu)->nr_suspend_regs);
>         }
>  }
>
> @@ -163,9 +163,9 @@ static int __init exynos5_clk_probe(struct platform_device *pdev)
>                 if (of_property_read_string(np, "label", &name) < 0)
>                         continue;
>                 for (i = 0; i < nr_cmus; i++)
> -                       if (strcmp(cmu[i].pd_name, name) == 0)
> +                       if (strcmp(cmu[i]->pd_name, name) == 0)
>                                 exynos5_clk_register_subcmu(&pdev->dev,
> -                                                           &cmu[i], np);
> +                                                           cmu[i], np);
>         }
>         return 0;
>  }
> diff --git a/drivers/clk/samsung/clk-exynos5-subcmu.h b/drivers/clk/samsung/clk-exynos5-subcmu.h
> index 755ee8aaa3de..9ae5356f25aa 100644
> --- a/drivers/clk/samsung/clk-exynos5-subcmu.h
> +++ b/drivers/clk/samsung/clk-exynos5-subcmu.h
> @@ -21,6 +21,6 @@ struct exynos5_subcmu_info {
>  };
>
>  void exynos5_subcmus_init(struct samsung_clk_provider *ctx, int nr_cmus,
> -                         const struct exynos5_subcmu_info *cmu);
> +                         const struct exynos5_subcmu_info **cmu);
>
>  #endif
> diff --git a/drivers/clk/samsung/clk-exynos5250.c b/drivers/clk/samsung/clk-exynos5250.c
> index f2b896881768..931c70a4da19 100644
> --- a/drivers/clk/samsung/clk-exynos5250.c
> +++ b/drivers/clk/samsung/clk-exynos5250.c
> @@ -681,6 +681,10 @@ static const struct exynos5_subcmu_info exynos5250_disp_subcmu = {
>         .pd_name        = "DISP1",
>  };
>
> +static const struct exynos5_subcmu_info *exynos5250_subcmus[] = {
> +       &exynos5250_disp_subcmu,
> +};
> +
>  static const struct samsung_pll_rate_table vpll_24mhz_tbl[] __initconst = {
>         /* sorted in descending order */
>         /* PLL_36XX_RATE(rate, m, p, s, k) */
> @@ -843,7 +847,8 @@ static void __init exynos5250_clk_init(struct device_node *np)
>
>         samsung_clk_sleep_init(reg_base, exynos5250_clk_regs,
>                                ARRAY_SIZE(exynos5250_clk_regs));
> -       exynos5_subcmus_init(ctx, 1, &exynos5250_disp_subcmu);
> +       exynos5_subcmus_init(ctx, ARRAY_SIZE(exynos5250_subcmus),
> +                            exynos5250_subcmus);
>
>         samsung_clk_of_add_provider(np, ctx);
>
> diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
> index 01bca5a498b2..fdb17c799aa5 100644
> --- a/drivers/clk/samsung/clk-exynos5420.c
> +++ b/drivers/clk/samsung/clk-exynos5420.c
> @@ -1281,32 +1281,40 @@ static struct exynos5_subcmu_reg_dump exynos5x_mfc_suspend_regs[] = {
>         { DIV4_RATIO, 0, 0x3 },                 /* DIV dout_mfc_blk */
>  };
>
> -static const struct exynos5_subcmu_info exynos5x_subcmus[] = {
> -       {
> -               .div_clks       = exynos5x_disp_div_clks,
> -               .nr_div_clks    = ARRAY_SIZE(exynos5x_disp_div_clks),
> -               .gate_clks      = exynos5x_disp_gate_clks,
> -               .nr_gate_clks   = ARRAY_SIZE(exynos5x_disp_gate_clks),
> -               .suspend_regs   = exynos5x_disp_suspend_regs,
> -               .nr_suspend_regs = ARRAY_SIZE(exynos5x_disp_suspend_regs),
> -               .pd_name        = "DISP",
> -       }, {
> -               .div_clks       = exynos5x_gsc_div_clks,
> -               .nr_div_clks    = ARRAY_SIZE(exynos5x_gsc_div_clks),
> -               .gate_clks      = exynos5x_gsc_gate_clks,
> -               .nr_gate_clks   = ARRAY_SIZE(exynos5x_gsc_gate_clks),
> -               .suspend_regs   = exynos5x_gsc_suspend_regs,
> -               .nr_suspend_regs = ARRAY_SIZE(exynos5x_gsc_suspend_regs),
> -               .pd_name        = "GSC",
> -       }, {
> -               .div_clks       = exynos5x_mfc_div_clks,
> -               .nr_div_clks    = ARRAY_SIZE(exynos5x_mfc_div_clks),
> -               .gate_clks      = exynos5x_mfc_gate_clks,
> -               .nr_gate_clks   = ARRAY_SIZE(exynos5x_mfc_gate_clks),
> -               .suspend_regs   = exynos5x_mfc_suspend_regs,
> -               .nr_suspend_regs = ARRAY_SIZE(exynos5x_mfc_suspend_regs),
> -               .pd_name        = "MFC",
> -       },
> +static const struct exynos5_subcmu_info exynos5x_disp_subcmu = {
> +       .div_clks       = exynos5x_disp_div_clks,
> +       .nr_div_clks    = ARRAY_SIZE(exynos5x_disp_div_clks),
> +       .gate_clks      = exynos5x_disp_gate_clks,
> +       .nr_gate_clks   = ARRAY_SIZE(exynos5x_disp_gate_clks),
> +       .suspend_regs   = exynos5x_disp_suspend_regs,
> +       .nr_suspend_regs = ARRAY_SIZE(exynos5x_disp_suspend_regs),
> +       .pd_name        = "DISP",
> +};
> +
> +static const struct exynos5_subcmu_info exynos5x_gsc_subcmu = {
> +       .div_clks       = exynos5x_gsc_div_clks,
> +       .nr_div_clks    = ARRAY_SIZE(exynos5x_gsc_div_clks),
> +       .gate_clks      = exynos5x_gsc_gate_clks,
> +       .nr_gate_clks   = ARRAY_SIZE(exynos5x_gsc_gate_clks),
> +       .suspend_regs   = exynos5x_gsc_suspend_regs,
> +       .nr_suspend_regs = ARRAY_SIZE(exynos5x_gsc_suspend_regs),
> +       .pd_name        = "GSC",
> +};
> +
> +static const struct exynos5_subcmu_info exynos5x_mfc_subcmu = {
> +       .div_clks       = exynos5x_mfc_div_clks,
> +       .nr_div_clks    = ARRAY_SIZE(exynos5x_mfc_div_clks),
> +       .gate_clks      = exynos5x_mfc_gate_clks,
> +       .nr_gate_clks   = ARRAY_SIZE(exynos5x_mfc_gate_clks),
> +       .suspend_regs   = exynos5x_mfc_suspend_regs,
> +       .nr_suspend_regs = ARRAY_SIZE(exynos5x_mfc_suspend_regs),
> +       .pd_name        = "MFC",
> +};
> +
> +static const struct exynos5_subcmu_info *exynos5x_subcmus[] = {
> +       &exynos5x_disp_subcmu,
> +       &exynos5x_gsc_subcmu,
> +       &exynos5x_mfc_subcmu,
>  };
>
>  static const struct samsung_pll_rate_table exynos5420_pll2550x_24mhz_tbl[] __initconst = {
> --
> 2.17.1
>
>
>
