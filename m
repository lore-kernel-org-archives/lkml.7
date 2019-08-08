Return-Path: <SRS0=IWld=WE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE3A4C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 11:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 993332187F
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Aug 2019 11:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ehMxjIpi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731907AbfHHLNX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 8 Aug 2019 07:13:23 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:37299 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731312AbfHHLNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Aug 2019 07:13:23 -0400
Received: by mail-ot1-f67.google.com with SMTP id s20so51444032otp.4;
        Thu, 08 Aug 2019 04:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=maxTK/04XPrhP0Dhx7ZYnblUq+fXH69yPK3HdYZ8eNY=;
        b=ehMxjIpitULmeEoBzl8SXMG93dg7IHdRlp07RiliNFFX2jVVnXvJ1Pob1K6XHKqZFx
         XDR6OOSzCp2xzgbF/ShtarNGBThivAKce4F26qVG8TNutV58vqeQSVST8LZxixIJ8NKJ
         mP1aR5d62JT6gr8+Fv5AsKNxGqgRXG54k2UTHgETCz32Sktvrcz4cG00M3p/U0pWKeGi
         ct+2/12SqagKngOlIA/pwEAIAI7xQMuazenkGl2ekxVuuOu2OSyYHTJjSYlXcOY2Z7xT
         y20OIW/FMpdqk3ysSnjFSa30fIDfzrwc1r/qMjlX/5cqPdHiqqFGK7J5tB+0RbIV5H6T
         Rt1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=maxTK/04XPrhP0Dhx7ZYnblUq+fXH69yPK3HdYZ8eNY=;
        b=StTDSoVANwo5l0xB39GqzoMTfFkqLByjJ6wqg9xG8U5/yxkDvz52z+4lhmt05WZ1Zw
         OCY3HwVKDPp0GDMv6yRiwWTjtAcu1XAKqwEOd/kMMJ4e0RBjakaW8gBPACGpWj/AJEt4
         Rk+RB4/olAO4oL0TrgHGifPuAoYYgDuxZPRJEuElIqjUBP9GqU/eMOsvqs7EphTzynTK
         +4L3mxT4DOg8jEBtz0+1ZBYDA9xEeXsXJ9AobEIy10HOZ+VZl813CYXKdMj0OmC6WnrM
         8uqDAty2eKMMgKSJJsANReoRaIjWs5dlYpy9mbofK9pyllMeI21a/pRH+hizTFLZwqmU
         cwGA==
X-Gm-Message-State: APjAAAV6GhQ//bm85pEfj0zEUK0pOhJwpmc5Eev5/dQnoIVUQblhSp40
        PwTT5IDXR1aaZxBJflzrStgiq3Yx/IFtEOrqdFgK76KhM0I=
X-Google-Smtp-Source: APXvYqz4JhR3wURQzAXhAKPJlC5wFGLQ85d/1WkM368Fagn1a+6TBFy41Hdq0fHXzew8nGgopRBnfYEVQ02PU6qe+/g=
X-Received: by 2002:a5d:9703:: with SMTP id h3mr14008223iol.152.1565262801936;
 Thu, 08 Aug 2019 04:13:21 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190807162519eucas1p2b9dd9f31cc6e60e0bc935e9a6ceef908@eucas1p2.samsung.com>
 <20190807162456.28694-1-s.nawrocki@samsung.com> <20190807162456.28694-2-s.nawrocki@samsung.com>
In-Reply-To: <20190807162456.28694-2-s.nawrocki@samsung.com>
From:   Jaafar Ali <jaafarkhalaf@gmail.com>
Date:   Thu, 8 Aug 2019 14:08:13 +0300
Message-ID: <CAF-0O_59PRWf0bpEEUTweKPwB6jaOStMkzdU8z552sYtsJ-jCQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] clk: samsung: exynos5800: Move MAU subsystem clocks
 to MAU sub-CMU
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
> This patch fixes broken sound on Exynos5422/5800 platforms after
> system/suspend resume cycle in cases where the audio root clock
> is derived from MAU_EPLL_CLK.
>
> In order to preserve state of the USER_MUX_MAU_EPLL_CLK clock mux
> during system suspend/resume cycle for Exynos5800 we group the MAU
> block input clocks in "MAU" sub-CMU and add the clock mux control
> bit to .suspend_regs.  This ensures that user configuration of the mux
> is not lost after the PMU block changes the mux setting to OSC_DIV
> when switching off the MAU power domain.
>
> Adding the SRC_TOP9 register to exynos5800_clk_regs[] array is not
> sufficient as at the time of the syscore_ops suspend call MAU power
> domain is already turned off and we already save and subsequently
> restore an incorrect register's value.
>
> Fixes: b06a532bf1fa ("clk: samsung: Add Exynos5 sub-CMU clock driver")
> Reported-by: Jaafar Ali <jaafarkhalaf@gmail.com>
> Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  drivers/clk/samsung/clk-exynos5420.c | 54 ++++++++++++++++++++++------
>  1 file changed, 43 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
> index fdb17c799aa5..b52daf5aa755 100644
> --- a/drivers/clk/samsung/clk-exynos5420.c
> +++ b/drivers/clk/samsung/clk-exynos5420.c
> @@ -534,8 +534,6 @@ static const struct samsung_gate_clock exynos5800_gate_clks[] __initconst = {
>                                 GATE_BUS_TOP, 24, 0, 0),
>         GATE(CLK_ACLK432_SCALER, "aclk432_scaler", "mout_user_aclk432_scaler",
>                                 GATE_BUS_TOP, 27, CLK_IS_CRITICAL, 0),
> -       GATE(CLK_MAU_EPLL, "mau_epll", "mout_user_mau_epll",
> -                       SRC_MASK_TOP7, 20, CLK_SET_RATE_PARENT, 0),
>  };
>
>  static const struct samsung_mux_clock exynos5420_mux_clks[] __initconst = {
> @@ -577,8 +575,13 @@ static const struct samsung_div_clock exynos5420_div_clks[] __initconst = {
>
>  static const struct samsung_gate_clock exynos5420_gate_clks[] __initconst = {
>         GATE(CLK_SECKEY, "seckey", "aclk66_psgen", GATE_BUS_PERIS1, 1, 0, 0),
> +       /* Maudio Block */
>         GATE(CLK_MAU_EPLL, "mau_epll", "mout_mau_epll_clk",
>                         SRC_MASK_TOP7, 20, CLK_SET_RATE_PARENT, 0),
> +       GATE(CLK_SCLK_MAUDIO0, "sclk_maudio0", "dout_maudio0",
> +               GATE_TOP_SCLK_MAU, 0, CLK_SET_RATE_PARENT, 0),
> +       GATE(CLK_SCLK_MAUPCM0, "sclk_maupcm0", "dout_maupcm0",
> +               GATE_TOP_SCLK_MAU, 1, CLK_SET_RATE_PARENT, 0),
>  };
>
>  static const struct samsung_mux_clock exynos5x_mux_clks[] __initconst = {
> @@ -1017,12 +1020,6 @@ static const struct samsung_gate_clock exynos5x_gate_clks[] __initconst = {
>         GATE(CLK_SCLK_DP1, "sclk_dp1", "dout_dp1",
>                         GATE_TOP_SCLK_DISP1, 20, CLK_SET_RATE_PARENT, 0),
>
> -       /* Maudio Block */
> -       GATE(CLK_SCLK_MAUDIO0, "sclk_maudio0", "dout_maudio0",
> -               GATE_TOP_SCLK_MAU, 0, CLK_SET_RATE_PARENT, 0),
> -       GATE(CLK_SCLK_MAUPCM0, "sclk_maupcm0", "dout_maupcm0",
> -               GATE_TOP_SCLK_MAU, 1, CLK_SET_RATE_PARENT, 0),
> -
>         /* FSYS Block */
>         GATE(CLK_TSI, "tsi", "aclk200_fsys", GATE_BUS_FSYS0, 0, 0, 0),
>         GATE(CLK_PDMA0, "pdma0", "aclk200_fsys", GATE_BUS_FSYS0, 1, 0, 0),
> @@ -1281,6 +1278,20 @@ static struct exynos5_subcmu_reg_dump exynos5x_mfc_suspend_regs[] = {
>         { DIV4_RATIO, 0, 0x3 },                 /* DIV dout_mfc_blk */
>  };
>
> +
> +static const struct samsung_gate_clock exynos5800_mau_gate_clks[] __initconst = {
> +       GATE(CLK_MAU_EPLL, "mau_epll", "mout_user_mau_epll",
> +                       SRC_MASK_TOP7, 20, CLK_SET_RATE_PARENT, 0),
> +       GATE(CLK_SCLK_MAUDIO0, "sclk_maudio0", "dout_maudio0",
> +               GATE_TOP_SCLK_MAU, 0, CLK_SET_RATE_PARENT, 0),
> +       GATE(CLK_SCLK_MAUPCM0, "sclk_maupcm0", "dout_maupcm0",
> +               GATE_TOP_SCLK_MAU, 1, CLK_SET_RATE_PARENT, 0),
> +};
> +
> +static struct exynos5_subcmu_reg_dump exynos5800_mau_suspend_regs[] = {
> +       { SRC_TOP9, 0, BIT(8) },
> +};
> +
>  static const struct exynos5_subcmu_info exynos5x_disp_subcmu = {
>         .div_clks       = exynos5x_disp_div_clks,
>         .nr_div_clks    = ARRAY_SIZE(exynos5x_disp_div_clks),
> @@ -1311,12 +1322,27 @@ static const struct exynos5_subcmu_info exynos5x_mfc_subcmu = {
>         .pd_name        = "MFC",
>  };
>
> +static const struct exynos5_subcmu_info exynos5800_mau_subcmu = {
> +       .gate_clks      = exynos5800_mau_gate_clks,
> +       .nr_gate_clks   = ARRAY_SIZE(exynos5800_mau_gate_clks),
> +       .suspend_regs   = exynos5800_mau_suspend_regs,
> +       .nr_suspend_regs = ARRAY_SIZE(exynos5800_mau_suspend_regs),
> +       .pd_name        = "MAU",
> +};
> +
>  static const struct exynos5_subcmu_info *exynos5x_subcmus[] = {
>         &exynos5x_disp_subcmu,
>         &exynos5x_gsc_subcmu,
>         &exynos5x_mfc_subcmu,
>  };
>
> +static const struct exynos5_subcmu_info *exynos5800_subcmus[] = {
> +       &exynos5x_disp_subcmu,
> +       &exynos5x_gsc_subcmu,
> +       &exynos5x_mfc_subcmu,
> +       &exynos5800_mau_subcmu,
> +};
> +
>  static const struct samsung_pll_rate_table exynos5420_pll2550x_24mhz_tbl[] __initconst = {
>         PLL_35XX_RATE(24 * MHZ, 2000000000, 250, 3, 0),
>         PLL_35XX_RATE(24 * MHZ, 1900000000, 475, 6, 0),
> @@ -1547,11 +1573,17 @@ static void __init exynos5x_clk_init(struct device_node *np,
>         samsung_clk_extended_sleep_init(reg_base,
>                 exynos5x_clk_regs, ARRAY_SIZE(exynos5x_clk_regs),
>                 exynos5420_set_clksrc, ARRAY_SIZE(exynos5420_set_clksrc));
> -       if (soc == EXYNOS5800)
> +
> +       if (soc == EXYNOS5800) {
>                 samsung_clk_sleep_init(reg_base, exynos5800_clk_regs,
>                                        ARRAY_SIZE(exynos5800_clk_regs));
> -       exynos5_subcmus_init(ctx, ARRAY_SIZE(exynos5x_subcmus),
> -                            exynos5x_subcmus);
> +
> +               exynos5_subcmus_init(ctx, ARRAY_SIZE(exynos5800_subcmus),
> +                                    exynos5800_subcmus);
> +       } else {
> +               exynos5_subcmus_init(ctx, ARRAY_SIZE(exynos5x_subcmus),
> +                                    exynos5x_subcmus);
> +       }
>
>         samsung_clk_of_add_provider(np, ctx);
>  }
> --
> 2.17.1
>
>
>
