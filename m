Return-Path: <SRS0=Ncac=VO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17126C76192
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 20:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E434021849
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jul 2019 20:17:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5g8BUNG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbfGQURd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jul 2019 16:17:33 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34894 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725993AbfGQURd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jul 2019 16:17:33 -0400
Received: by mail-wm1-f65.google.com with SMTP id l2so23387736wmg.0;
        Wed, 17 Jul 2019 13:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jDSjE56feL4M57HMVhhU1D7CrADaIyXAujaY2b7p0Rs=;
        b=h5g8BUNGvMProBfMdpTh+q7hvyw/nnXkMstQBN2l2v0wVMu9JjnNFLf8G8UBbs8VVJ
         ZK1iHpAE+DvFSamesInpnEeoVI7xvalKz1Gr9FkCem95LcYk+5ODLi/XzMcjGid6sc8C
         pfG2Z66DSfSavp1cmi6zv6zOx7BuBuZbevyK4SKIOAgNp8oueRhPqcaoS0ZdE6CvUW7d
         n7GO8Ye+0B1LccBd5UAITT+B1QMYYalCoox9TW0MC1y9eG5iGRKYKj1n91/3N9VLJPwU
         mXp7GJRKEKpnMrR5jvH6/JMvGAIHZj5mS0z2YZ6N6pSWA0C+f3B2Xrhtt5JBsIJ6ESqR
         esww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jDSjE56feL4M57HMVhhU1D7CrADaIyXAujaY2b7p0Rs=;
        b=MfD0TSgf9bD5elKxGlPNsVnC/kCNiO6o+2yVj3PuJtX9ymls4hJ9rRIiu06AY5Cnod
         xoi2csMYg1lN46nD6era4WD7+zC27M6L+guC81MsSC0ABFELa2dzShUH8AxznHZospKr
         jPfa12ufAvlWy3aeoNMWXqC+cmO+BUTvovBHXiNgZzk60Z6mgCySWwgRRldJD1weBy2a
         DWFdsmgf3U5nSdq5UtxFOfaweFFEpufBsscOacfTQltB7cXBESaqXeO5JkViiHyBcJeo
         1LWe6mncJOo0HBt47cqVdDvRd6rbni+3ITUkowHzgf/Nq4RIHTSh2SjINXZtc+M3Fybn
         xAkg==
X-Gm-Message-State: APjAAAXc7TznpNMV4nHjCGKc9YKyvMCvSDkITYKQDHUmpOd7rNy24Q1R
        RDgcHrV9HvAel9lMDuZ4Vjv+R24nnHv0tgUKyu4=
X-Google-Smtp-Source: APXvYqxJ1bxS+Q8Df3UVfk+sVuMPo1SAEUkpQeAGT7wfV8seECEYiuw8rjMehNQ1vuSUoRjtsWP7h6JvJ5NmHMiYEWw=
X-Received: by 2002:a1c:96c7:: with SMTP id y190mr35132650wmd.87.1563394650383;
 Wed, 17 Jul 2019 13:17:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190702152007.12190-1-daniel.baluta@nxp.com>
In-Reply-To: <20190702152007.12190-1-daniel.baluta@nxp.com>
From:   Daniel Baluta <daniel.baluta@gmail.com>
Date:   Wed, 17 Jul 2019 23:17:19 +0300
Message-ID: <CAEnQRZB23GLVXp459+JieeqQdAKXBRyeTc=hxnovFZwje-tgCw@mail.gmail.com>
Subject: Re: [PATCH] clk: imx8: Add DSP related clocks
To:     Daniel Baluta <daniel.baluta@nxp.com>, Jacky Bai <ping.bai@nxp.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Aisheng Dong <aisheng.dong@nxp.com>, weiyongjun1@huawei.com,
        linux-clk@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        "S.j. Wang" <shengjiu.wang@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aisheng/Jacky,

Can you help with review on this?

On Tue, Jul 2, 2019 at 6:22 PM Daniel Baluta <daniel.baluta@nxp.com> wrote:
>
> i.MX8QXP contains Hifi4 DSP. There are four clocks
> associated with DSP:
>   * dsp_lpcg_core_clk
>   * dsp_lpcg_ipg_clk
>   * dsp_lpcg_adb_aclk
>   * ocram_lpcg_ipg_clk
>
> Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
> ---
>  drivers/clk/imx/clk-imx8qxp-lpcg.c     | 5 +++++
>  include/dt-bindings/clock/imx8-clock.h | 6 +++++-
>  2 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/clk/imx/clk-imx8qxp-lpcg.c b/drivers/clk/imx/clk-imx8qxp-lpcg.c
> index fb6edf1b8aa2..c0aff7ca6374 100644
> --- a/drivers/clk/imx/clk-imx8qxp-lpcg.c
> +++ b/drivers/clk/imx/clk-imx8qxp-lpcg.c
> @@ -72,6 +72,11 @@ static const struct imx8qxp_lpcg_data imx8qxp_lpcg_adma[] = {
>         { IMX_ADMA_LPCG_I2C2_CLK, "i2c2_lpcg_clk", "i2c2_clk", 0, ADMA_LPI2C_2_LPCG, 0, 0, },
>         { IMX_ADMA_LPCG_I2C3_IPG_CLK, "i2c3_lpcg_ipg_clk", "dma_ipg_clk_root", 0, ADMA_LPI2C_3_LPCG, 16, 0, },
>         { IMX_ADMA_LPCG_I2C3_CLK, "i2c3_lpcg_clk", "i2c3_clk", 0, ADMA_LPI2C_3_LPCG, 0, 0, },
> +
> +       { IMX_ADMA_LPCG_DSP_CORE_CLK, "dsp_lpcg_core_clk", "dma_ipg_clk_root", 0, ADMA_HIFI_LPCG, 28, 0, },
> +       { IMX_ADMA_LPCG_DSP_IPG_CLK, "dsp_lpcg_ipg_clk", "dma_ipg_clk_root", 0, ADMA_HIFI_LPCG, 20, 0, },
> +       { IMX_ADMA_LPCG_DSP_ADB_CLK, "dsp_lpcg_adb_clk", "dma_ipg_clk_root", 0, ADMA_HIFI_LPCG, 16, 0, },
> +       { IMX_ADMA_LPCG_OCRAM_IPG_CLK, "ocram_lpcg_ipg_clk", "dma_ipg_clk_root", 0, ADMA_OCRAM_LPCG, 16, 0, },
>  };
>
>  static const struct imx8qxp_ss_lpcg imx8qxp_ss_adma = {
> diff --git a/include/dt-bindings/clock/imx8-clock.h b/include/dt-bindings/clock/imx8-clock.h
> index 4236818e3be5..673a8c662340 100644
> --- a/include/dt-bindings/clock/imx8-clock.h
> +++ b/include/dt-bindings/clock/imx8-clock.h
> @@ -283,7 +283,11 @@
>  #define IMX_ADMA_LPCG_PWM_IPG_CLK                      38
>  #define IMX_ADMA_LPCG_LCD_PIX_CLK                      39
>  #define IMX_ADMA_LPCG_LCD_APB_CLK                      40
> +#define IMX_ADMA_LPCG_DSP_ADB_CLK                      41
> +#define IMX_ADMA_LPCG_DSP_IPG_CLK                      42
> +#define IMX_ADMA_LPCG_DSP_CORE_CLK                     43
> +#define IMX_ADMA_LPCG_OCRAM_IPG_CLK                    44
>
> -#define IMX_ADMA_LPCG_CLK_END                          41
> +#define IMX_ADMA_LPCG_CLK_END                          45
>
>  #endif /* __DT_BINDINGS_CLOCK_IMX_H */
> --
> 2.17.1
>
