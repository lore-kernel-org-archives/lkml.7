Return-Path: <SRS0=bMiL=T7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE87C04AB6
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 03:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEE4826256
	for <linux-kernel@archiver.kernel.org>; Fri, 31 May 2019 03:24:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="shygk1Ey"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbfEaDYL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 May 2019 23:24:11 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:38531 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbfEaDYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 May 2019 23:24:10 -0400
Received: by mail-pg1-f193.google.com with SMTP id v11so3198529pgl.5
        for <linux-kernel@vger.kernel.org>; Thu, 30 May 2019 20:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Y0WMcpWfoXbnuMiOdOcy4f4+mdeXgK7Hsp1gRkSwmjI=;
        b=shygk1EyQfcMXGh963h1m75rbQl//nbJkYNuSkZIN9eHEnqkOPNfpMxY7xEIJhi1jT
         Iu1k+ZB/8NLCHx+0bgWxMwOHQPQi7AUg3JcScD4qsPF+vRh31tZl9RgXox4mSa8paq41
         /5VBucDtOkXbg+n//LsBjLXGwBa6+CTvvgyhutw3hX/nUEdopWsZ8LEWT/1IrJyIH8Mv
         WD4YjL//KgX5SMH6i0ENRY1ZPlojG0GAN10VEx8QAGRebHQ6j873cLx6tT8N4eg6zFNd
         hrPsH3Kr4cfeh6lyRB90AoFKazWLYFegSuqatjsKwZ0EO1n8VjbQOMh2t6ctrytK+Vu7
         RTjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Y0WMcpWfoXbnuMiOdOcy4f4+mdeXgK7Hsp1gRkSwmjI=;
        b=de8KOPQGDH3d2Zxie0D5eun/eb8RIVOSahajlzbzc7rGJ00LegXPx5ifD22Zs4BHxq
         9JXazwYu+/GuMje12dbBF4hoO2qU155m+v7BzMwM1O67aUUEbfkvSd9aPxMD7yfE7Dhy
         JWm3afSsNkvwLI+fxFE8v6kpveMIUoCnw8y+48mBpjMzTr/kX7W8insiZvZ3q4tyqF5u
         3EF7z8GH4/RJ4UB72CZrcQ5iw+Xz7yRbRP4fzVtKJlBAi7mqUMh3plLUjBmC5I6XhQ/4
         f+w7TWSU8UXnqxnU3tRUOq4kAmXyFAhH/T700l8VD+i3FU0N1IeAIR15cuqlv27RhF8L
         4Q8Q==
X-Gm-Message-State: APjAAAXRIrnoLuBlB7bQqOJ4zuXhQIa+20ZDfvRh+lSkYSAIfyiAG8a3
        fgoHlNgZPy2wTtlFWO3sDpId
X-Google-Smtp-Source: APXvYqy234vuH9P3R1wJOZtHjpQSL9DPwJjmp2FbbRFLPm8wCMxrM6uNPF1nuywg4K99t7ajF1hGdg==
X-Received: by 2002:a17:90a:62cb:: with SMTP id k11mr6556683pjs.26.1559273049926;
        Thu, 30 May 2019 20:24:09 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2405:204:72cb:ebf2:a51d:3877:feab:5634])
        by smtp.gmail.com with ESMTPSA id s66sm3864501pgs.87.2019.05.30.20.24.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 May 2019 20:24:08 -0700 (PDT)
Date:   Fri, 31 May 2019 08:54:02 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Jianqun Xu <jay.xu@rock-chips.com>
Cc:     heiko@sntech.de, mark.rutland@arm.com, robh+dt@kernel.org,
        zhangzj@rock-chips.com, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/1] arm64: dts: rockchip: add core dtsi file for
 RK3399Pro SoCs
Message-ID: <20190531032402.GA9641@Mani-XPS-13-9360>
References: <20190529074752.19388-1-jay.xu@rock-chips.com>
 <20190530000848.28106-1-jay.xu@rock-chips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190530000848.28106-1-jay.xu@rock-chips.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 30, 2019 at 08:08:48AM +0800, Jianqun Xu wrote:
> This patch adds core dtsi file for Rockchip RK3399Pro SoCs,
> include rk3399.dtsi. Also enable pciei0/pcie_phy for AP to
> talk to NPU part inside SoC.
> 
> Signed-off-by: Jianqun Xu <jay.xu@rock-chips.com>
> ---
> changes since v2:
> - only enable pcie0 and pcie_phy nodes, thanks for Heiko and manivannan
> 
> changes since v1:
> - remove dfi and dmc
> 
>  arch/arm64/boot/dts/rockchip/rk3399pro.dtsi | 22 +++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/rockchip/rk3399pro.dtsi
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399pro.dtsi b/arch/arm64/boot/dts/rockchip/rk3399pro.dtsi
> new file mode 100644
> index 000000000000..bb5ebf6608b9
> --- /dev/null
> +++ b/arch/arm64/boot/dts/rockchip/rk3399pro.dtsi
> @@ -0,0 +1,22 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +// Copyright (c) 2019 Fuzhou Rockchip Electronics Co., Ltd.
> +
> +#include "rk3399.dtsi"
> +
> +/ {
> +	compatible = "rockchip,rk3399pro";
> +};
> +
> +/* Default to enabled since AP talk to NPU part over pcie */
> +&pcie_phy {
> +	status = "okay";
> +};
> +
> +/* Default to enabled since AP talk to NPU part over pcie */
> +&pcie0 {
> +	ep-gpios = <&gpio0 RK_PB4 GPIO_ACTIVE_HIGH>;
> +	num-lanes = <4>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pcie_clkreqn_cpm>;

No pinctrl config for ep-gpio? Other than that, it looks good to me.

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani
> +	status = "okay";
> +};
> -- 
> 2.17.1
> 
> 
> 
