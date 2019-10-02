Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_SBL,URIBL_SBL_A,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 314E1C4360C
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 19:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F14D720700
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 19:21:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="yuVLX7Cf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbfJBTVI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 15:21:08 -0400
Received: from gateway22.websitewelcome.com ([192.185.47.168]:12333 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726076AbfJBTVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 15:21:07 -0400
Received: from cm10.websitewelcome.com (cm10.websitewelcome.com [100.42.49.4])
        by gateway22.websitewelcome.com (Postfix) with ESMTP id 7E7E01E71B7
        for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2019 14:21:05 -0500 (CDT)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id FkBNibP9THunhFkBNiJArI; Wed, 02 Oct 2019 14:21:05 -0500
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:Subject:From:References:Cc:To:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=MYuPAtPEE+RTLg3/3dWrsMvlI5VxePFm5Mc0ii8PfRU=; b=yuVLX7Cf7OXXC9cAzmUi/vHs6Z
        fE4NUh5mQBcAg8KJGqciEEkjfCc+H6LgZHSIBGlr79MveXbtwOPXziex5HZ3ZfEHAWLIsAA+VwzFK
        JEye4VY/cCYsKCWQwBIzRpoQ4p6byE2U2w+ePzJITBDE22ar6zzeWZp6KMsZc5VvxfRVqOwccQbw+
        ww4uG6ZCl3pTSLJzjMeK4W5nc7I9cYWGorfu4BVFKuonRyfsW8LSgHrwFGMVwi1/PuDWpNpAlqPOi
        uska9kzRkyB8qc6DZ5b02NmU7jc+ke36vF1S61m2gXDXmXqSAKlJiqdi7JrukS3G+6Xn2DxFvpJjF
        dm/tZKkg==;
Received: from 187-162-252-62.static.axtel.net ([187.162.252.62]:44076 helo=[192.168.0.128])
        by gator4166.hostgator.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1iFkBM-004Gwz-VT; Wed, 02 Oct 2019 14:21:05 -0500
To:     Stephen Kitt <steve@sk2.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Paul Burton <paul.burton@mips.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190927185110.29897-1-steve@sk2.org>
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Openpgp: preference=signencrypt
Autocrypt: addr=gustavo@embeddedor.com; keydata=
 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
 VtSixD1uOgytAP7RWS474w==
Subject: Re: [PATCH] drivers/clk: convert VL struct to struct_size
Message-ID: <24c5e42f-cb56-f57a-163b-c35392bbf887@embeddedor.com>
Date:   Wed, 2 Oct 2019 14:20:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190927185110.29897-1-steve@sk2.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 187.162.252.62
X-Source-L: No
X-Exim-ID: 1iFkBM-004Gwz-VT
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: 187-162-252-62.static.axtel.net ([192.168.0.128]) [187.162.252.62]:44076
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 13
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/27/19 13:51, Stephen Kitt wrote:
> There are a few manually-calculated variable-length struct allocations
> left, this converts them to use struct_size.
> 

How did you find this?

Please, mention the tool you used to find this in the commit log. With that
you can add my

Acked-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Thanks
--
Gustavo

> Signed-off-by: Stephen Kitt <steve@sk2.org>
> ---
>  drivers/clk/at91/sckc.c                     | 3 +--
>  drivers/clk/imgtec/clk-boston.c             | 3 +--
>  drivers/clk/ingenic/tcu.c                   | 3 +--
>  drivers/clk/mvebu/ap-cpu-clk.c              | 4 ++--
>  drivers/clk/mvebu/cp110-system-controller.c | 4 ++--
>  drivers/clk/samsung/clk.c                   | 3 +--
>  drivers/clk/uniphier/clk-uniphier-core.c    | 3 +--
>  7 files changed, 9 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/clk/at91/sckc.c b/drivers/clk/at91/sckc.c
> index 9bfe9a28294a..5ad6180449cb 100644
> --- a/drivers/clk/at91/sckc.c
> +++ b/drivers/clk/at91/sckc.c
> @@ -478,8 +478,7 @@ static void __init of_sam9x60_sckc_setup(struct device_node *np)
>  	if (IS_ERR(slow_osc))
>  		goto unregister_slow_rc;
>  
> -	clk_data = kzalloc(sizeof(*clk_data) + (2 * sizeof(struct clk_hw *)),
> -			   GFP_KERNEL);
> +	clk_data = kzalloc(struct_size(clk_data, hws, 2), GFP_KERNEL);
>  	if (!clk_data)
>  		goto unregister_slow_osc;
>  
> diff --git a/drivers/clk/imgtec/clk-boston.c b/drivers/clk/imgtec/clk-boston.c
> index 33ab4ff61165..b00cbd045af5 100644
> --- a/drivers/clk/imgtec/clk-boston.c
> +++ b/drivers/clk/imgtec/clk-boston.c
> @@ -58,8 +58,7 @@ static void __init clk_boston_setup(struct device_node *np)
>  	cpu_div = ext_field(mmcmdiv, BOSTON_PLAT_MMCMDIV_CLK1DIV);
>  	cpu_freq = mult_frac(in_freq, mul, cpu_div);
>  
> -	onecell = kzalloc(sizeof(*onecell) +
> -			  (BOSTON_CLK_COUNT * sizeof(struct clk_hw *)),
> +	onecell = kzalloc(struct_size(onecell, hws, BOSTON_CLK_COUNT),
>  			  GFP_KERNEL);
>  	if (!onecell)
>  		return;
> diff --git a/drivers/clk/ingenic/tcu.c b/drivers/clk/ingenic/tcu.c
> index a1a5f9cb439e..ad7daa494fd4 100644
> --- a/drivers/clk/ingenic/tcu.c
> +++ b/drivers/clk/ingenic/tcu.c
> @@ -358,8 +358,7 @@ static int __init ingenic_tcu_probe(struct device_node *np)
>  		}
>  	}
>  
> -	tcu->clocks = kzalloc(sizeof(*tcu->clocks) +
> -			      sizeof(*tcu->clocks->hws) * TCU_CLK_COUNT,
> +	tcu->clocks = kzalloc(struct_size(tcu->clocks, hws, TCU_CLK_COUNT),
>  			      GFP_KERNEL);
>  	if (!tcu->clocks) {
>  		ret = -ENOMEM;
> diff --git a/drivers/clk/mvebu/ap-cpu-clk.c b/drivers/clk/mvebu/ap-cpu-clk.c
> index af5e5acad370..6b394302c76a 100644
> --- a/drivers/clk/mvebu/ap-cpu-clk.c
> +++ b/drivers/clk/mvebu/ap-cpu-clk.c
> @@ -274,8 +274,8 @@ static int ap_cpu_clock_probe(struct platform_device *pdev)
>  	if (!ap_cpu_clk)
>  		return -ENOMEM;
>  
> -	ap_cpu_data = devm_kzalloc(dev, sizeof(*ap_cpu_data) +
> -				sizeof(struct clk_hw *) * nclusters,
> +	ap_cpu_data = devm_kzalloc(dev, struct_size(ap_cpu_data, hws,
> +						    nclusters),
>  				GFP_KERNEL);
>  	if (!ap_cpu_data)
>  		return -ENOMEM;
> diff --git a/drivers/clk/mvebu/cp110-system-controller.c b/drivers/clk/mvebu/cp110-system-controller.c
> index 808463276145..84c8900542e4 100644
> --- a/drivers/clk/mvebu/cp110-system-controller.c
> +++ b/drivers/clk/mvebu/cp110-system-controller.c
> @@ -235,8 +235,8 @@ static int cp110_syscon_common_probe(struct platform_device *pdev,
>  	if (ret)
>  		return ret;
>  
> -	cp110_clk_data = devm_kzalloc(dev, sizeof(*cp110_clk_data) +
> -				      sizeof(struct clk_hw *) * CP110_CLK_NUM,
> +	cp110_clk_data = devm_kzalloc(dev, struct_size(cp110_clk_data, hws,
> +						       CP110_CLK_NUM),
>  				      GFP_KERNEL);
>  	if (!cp110_clk_data)
>  		return -ENOMEM;
> diff --git a/drivers/clk/samsung/clk.c b/drivers/clk/samsung/clk.c
> index e544a38106dd..dad31308c071 100644
> --- a/drivers/clk/samsung/clk.c
> +++ b/drivers/clk/samsung/clk.c
> @@ -60,8 +60,7 @@ struct samsung_clk_provider *__init samsung_clk_init(struct device_node *np,
>  	struct samsung_clk_provider *ctx;
>  	int i;
>  
> -	ctx = kzalloc(sizeof(struct samsung_clk_provider) +
> -		      sizeof(*ctx->clk_data.hws) * nr_clks, GFP_KERNEL);
> +	ctx = kzalloc(struct_size(ctx, clk_data.hws, nr_clks), GFP_KERNEL);
>  	if (!ctx)
>  		panic("could not allocate clock provider context.\n");
>  
> diff --git a/drivers/clk/uniphier/clk-uniphier-core.c b/drivers/clk/uniphier/clk-uniphier-core.c
> index c6aaca73cf86..12380236d7ab 100644
> --- a/drivers/clk/uniphier/clk-uniphier-core.c
> +++ b/drivers/clk/uniphier/clk-uniphier-core.c
> @@ -64,8 +64,7 @@ static int uniphier_clk_probe(struct platform_device *pdev)
>  	for (p = data; p->name; p++)
>  		clk_num = max(clk_num, p->idx + 1);
>  
> -	hw_data = devm_kzalloc(dev,
> -			sizeof(*hw_data) + clk_num * sizeof(struct clk_hw *),
> +	hw_data = devm_kzalloc(dev, struct_size(hw_data, hws, clk_num),
>  			GFP_KERNEL);
>  	if (!hw_data)
>  		return -ENOMEM;
> 
