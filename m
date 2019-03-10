Return-Path: <SRS0=imS1=RN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8A4BC10F03
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 16:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B7C6F206DF
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Mar 2019 16:46:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AjKDaQVL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726643AbfCJQqU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Mar 2019 12:46:20 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33728 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbfCJQqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Mar 2019 12:46:20 -0400
Received: by mail-qk1-f193.google.com with SMTP id x9so1387931qkf.0;
        Sun, 10 Mar 2019 09:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=iuLVxnZ5LMgmdQCRDTIrsvvMMDtFinU+vzw34nR7vKQ=;
        b=AjKDaQVLKf60Hn9ZJuLN03ZkXyHTey9BudC1nuOXZfvAbJXQ521zCOu7rg4FItBEa7
         iwOUBZE/8llFQIYvjt9yNXgs89NEgppkv9EHOyUmi9wI6xM/ZbLUfRp8TmeY4R1oHIb4
         G4jT3CqfJYNJi3wxboHbCd0gR9Q3kyXQicO5/nJKX2ajdBpSngRD23rXk1QRFduCzh81
         hDsLC8ErYwGr+XHkQK37WvJ/M71GfT/42Z6PEb4civZdccnMxg8Hq+iPz4uUEiO0LxcS
         JAB1/ma7zi9FmvlydDyX0pQudoj5CAG/6ymFzna63J4Jj8bs+bUXMCQubN0EtV39Cfl3
         fpJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=iuLVxnZ5LMgmdQCRDTIrsvvMMDtFinU+vzw34nR7vKQ=;
        b=Qne6jf7No5XDpBaPNlXYpY6uQrETIdIymGKkDNDHmueS0qfLHVy+LY9aB7qtgIUDOn
         IAeKLPF3ZzqSIseiGbsaIMtjvNQe5LnljoBmimPDrWKrbHOyKNgXfaH4l/Oykj5vdjAw
         s1Tnzp3r5x9bLZPLKCGlzJ8MP3ZU32UieFkt1Mqd9GCz4HtUAvVctjPyK4MIA4rHgnb9
         mcfuXITALHKEeeL1rexMqeWHSP4QJ9ZF3fWOIaEnYB7RgLxr5raLWYhpYdCVLPQqeWwx
         c0kPZOhpmTXB9WgKKscozyKkpzL/29IflE9WOzYpBhm1uROU/D/JhFVcMqVTV84ifTbG
         oXcA==
X-Gm-Message-State: APjAAAWt+wU9OprHjcHpOuWBKZCMml4av8Unwn3wQzJ3B/BYnE97u9af
        9pGUgMocVvSSL+fqQD1henAgojsH6Sc=
X-Google-Smtp-Source: APXvYqyM4muD6up3eMkRBdK5r8lFeDYIAOUF/s9YbOTq4GO2s9AAeM/wuqqKyoziYPqWOANqJic7cQ==
X-Received: by 2002:ae9:c30f:: with SMTP id n15mr21137507qkg.227.1552236378226;
        Sun, 10 Mar 2019 09:46:18 -0700 (PDT)
Received: from ?IPv6:2601:153:900:ebb:e9a2:ce76:e8b3:e9e? ([2601:153:900:ebb:e9a2:ce76:e8b3:e9e])
        by smtp.gmail.com with ESMTPSA id f189sm1959453qkb.79.2019.03.10.09.46.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 10 Mar 2019 09:46:17 -0700 (PDT)
Subject: Re: [PATCH] clk: rockchip: fix wrong clock definitions for rk3328
To:     Jonas Karlman <jonas@kwiboo.se>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Heiko Stuebner <heiko@sntech.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <AM3PR03MB0966A06101CACDAEA4ECD72BAC4F0@AM3PR03MB0966.eurprd03.prod.outlook.com>
From:   Peter Geis <pgwipeout@gmail.com>
Message-ID: <97e8505d-391c-9cc6-af3b-0eb1a7d895f5@gmail.com>
Date:   Sun, 10 Mar 2019 12:46:17 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.3
MIME-Version: 1.0
In-Reply-To: <AM3PR03MB0966A06101CACDAEA4ECD72BAC4F0@AM3PR03MB0966.eurprd03.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/10/2019 8:00 AM, Jonas Karlman wrote:
> This patch fixes definition of several clock gate and select register
> that is wrong for rk3328 referring to the TRM and vendor kernel.
> Also use correct number of softrst registers.
> 
> Fix clock definition for:
> - clk_crypto
> - aclk_h265
> - pclk_h265
> - aclk_h264
> - hclk_h264
> - aclk_axisram
> - aclk_gmac
> - aclk_usb3otg
> 
> Fixes: fe3511ad8a1c ("clk: rockchip: add clock controller for rk3328")
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>

Tested on the rk3328-roc-cc.

Tested-by: Peter Geis <pgwipeout@gmail.com>

> ---
>   drivers/clk/rockchip/clk-rk3328.c | 18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/clk/rockchip/clk-rk3328.c b/drivers/clk/rockchip/clk-rk3328.c
> index faa94adb2a37..5f6b6bcc2149 100644
> --- a/drivers/clk/rockchip/clk-rk3328.c
> +++ b/drivers/clk/rockchip/clk-rk3328.c
> @@ -458,7 +458,7 @@ static struct rockchip_clk_branch rk3328_clk_branches[] __initdata = {
>   			RK3328_CLKSEL_CON(35), 15, 1, MFLAGS, 8, 7, DFLAGS,
>   			RK3328_CLKGATE_CON(2), 12, GFLAGS),
>   	COMPOSITE(SCLK_CRYPTO, "clk_crypto", mux_2plls_p, 0,
> -			RK3328_CLKSEL_CON(20), 7, 1, MFLAGS, 0, 7, DFLAGS,
> +			RK3328_CLKSEL_CON(20), 7, 1, MFLAGS, 0, 5, DFLAGS,
>   			RK3328_CLKGATE_CON(2), 4, GFLAGS),
>   	COMPOSITE_NOMUX(SCLK_TSADC, "clk_tsadc", "clk_24m", 0,
>   			RK3328_CLKSEL_CON(22), 0, 10, DFLAGS,
> @@ -550,15 +550,15 @@ static struct rockchip_clk_branch rk3328_clk_branches[] __initdata = {
>   	GATE(0, "hclk_rkvenc_niu", "hclk_rkvenc", 0,
>   			RK3328_CLKGATE_CON(25), 1, GFLAGS),
>   	GATE(ACLK_H265, "aclk_h265", "aclk_rkvenc", 0,
> -			RK3328_CLKGATE_CON(25), 0, GFLAGS),
> +			RK3328_CLKGATE_CON(25), 2, GFLAGS),
>   	GATE(PCLK_H265, "pclk_h265", "hclk_rkvenc", 0,
> -			RK3328_CLKGATE_CON(25), 1, GFLAGS),
> +			RK3328_CLKGATE_CON(25), 3, GFLAGS),
>   	GATE(ACLK_H264, "aclk_h264", "aclk_rkvenc", 0,
> -			RK3328_CLKGATE_CON(25), 0, GFLAGS),
> +			RK3328_CLKGATE_CON(25), 4, GFLAGS),
>   	GATE(HCLK_H264, "hclk_h264", "hclk_rkvenc", 0,
> -			RK3328_CLKGATE_CON(25), 1, GFLAGS),
> +			RK3328_CLKGATE_CON(25), 5, GFLAGS),
>   	GATE(ACLK_AXISRAM, "aclk_axisram", "aclk_rkvenc", CLK_IGNORE_UNUSED,
> -			RK3328_CLKGATE_CON(25), 0, GFLAGS),
> +			RK3328_CLKGATE_CON(25), 6, GFLAGS),
>   
>   	COMPOSITE(SCLK_VENC_CORE, "sclk_venc_core", mux_4plls_p, 0,
>   			RK3328_CLKSEL_CON(51), 14, 2, MFLAGS, 8, 5, DFLAGS,
> @@ -663,7 +663,7 @@ static struct rockchip_clk_branch rk3328_clk_branches[] __initdata = {
>   
>   	/* PD_GMAC */
>   	COMPOSITE(ACLK_GMAC, "aclk_gmac", mux_2plls_hdmiphy_p, 0,
> -			RK3328_CLKSEL_CON(35), 6, 2, MFLAGS, 0, 5, DFLAGS,
> +			RK3328_CLKSEL_CON(25), 6, 2, MFLAGS, 0, 5, DFLAGS,
>   			RK3328_CLKGATE_CON(3), 2, GFLAGS),
>   	COMPOSITE_NOMUX(PCLK_GMAC, "pclk_gmac", "aclk_gmac", 0,
>   			RK3328_CLKSEL_CON(25), 8, 3, DFLAGS,
> @@ -733,7 +733,7 @@ static struct rockchip_clk_branch rk3328_clk_branches[] __initdata = {
>   
>   	/* PD_PERI */
>   	GATE(0, "aclk_peri_noc", "aclk_peri", CLK_IGNORE_UNUSED, RK3328_CLKGATE_CON(19), 11, GFLAGS),
> -	GATE(ACLK_USB3OTG, "aclk_usb3otg", "aclk_peri", 0, RK3328_CLKGATE_CON(19), 4, GFLAGS),
> +	GATE(ACLK_USB3OTG, "aclk_usb3otg", "aclk_peri", 0, RK3328_CLKGATE_CON(19), 14, GFLAGS),
>   
>   	GATE(HCLK_SDMMC, "hclk_sdmmc", "hclk_peri", 0, RK3328_CLKGATE_CON(19), 0, GFLAGS),
>   	GATE(HCLK_SDIO, "hclk_sdio", "hclk_peri", 0, RK3328_CLKGATE_CON(19), 1, GFLAGS),
> @@ -913,7 +913,7 @@ static void __init rk3328_clk_init(struct device_node *np)
>   				     &rk3328_cpuclk_data, rk3328_cpuclk_rates,
>   				     ARRAY_SIZE(rk3328_cpuclk_rates));
>   
> -	rockchip_register_softrst(np, 11, reg_base + RK3328_SOFTRST_CON(0),
> +	rockchip_register_softrst(np, 12, reg_base + RK3328_SOFTRST_CON(0),
>   				  ROCKCHIP_SOFTRST_HIWORD_MASK);
>   
>   	rockchip_register_restart_notifier(ctx, RK3328_GLB_SRST_FST, NULL);
> 
