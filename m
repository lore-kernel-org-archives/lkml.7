Return-Path: <SRS0=7h0X=2M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D15C2D0D4
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Dec 2019 22:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF5BD20663
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Dec 2019 22:00:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WhltqlZS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726733AbfLVWAH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Dec 2019 17:00:07 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40657 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbfLVWAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Dec 2019 17:00:07 -0500
Received: by mail-lj1-f195.google.com with SMTP id u1so15930019ljk.7;
        Sun, 22 Dec 2019 14:00:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=VellRtHE/5yjg7j+D4UN10YKpU4GLE2v6UKynyOlfDQ=;
        b=WhltqlZSrXu23QRAxXQHl8ih659/oDLnfkM2wPjzR9avvvxjHpMWi3mbuJtkjn8Vgd
         TSzZBmhc9TpNv9rPUiQ7coza8u0I9ALjlVFat8jt2wcKIAj1H9CKxPsUBScqWLzAB3ja
         GWp54lxPyIAfHWlx1aYF12YVh159C73A8D3cTKvkeijkk8/eY/hmN5d/DDpSkoNj5yvI
         ll273KJ4KQ5HFge45mORaFrbrLiATM2BY2A8M6ZO6qg3RqkGIFbUrqgPTABkhX331Q2N
         3MPgEXkcpvwyxkOwsKCHwHjMgFKZK/EbFgelCPBVAw8USoMvt7MzLiwPHf0BK72ieOOf
         +fbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=VellRtHE/5yjg7j+D4UN10YKpU4GLE2v6UKynyOlfDQ=;
        b=YRS9S+nWrN6HYTF8FEoE//OGK2g4OaSg2I9WYKD7FEiMsb93yFNgK2O09N/DTtEUaT
         9nWGhXobpDJHydBLKAQFeFL9H82IOvPCIh3R5CPfOxY3nPFUjw5ZwJqBujst/P+CyIT9
         nJBZozvRXtZg/lklVxIpG5/w3EKK4iglyeC9g84YdfVq7P+mRuoDZeM6rFNFTaZIWMtJ
         FK7LVFH3rK1FHUIdwwysuFA79ltdP10Gchly4TSfUQTe4BXFtClo+HZMhDVNSIwjGcGx
         y+W5qo9QvuwPN2tvu6z6PTxWzBqfh/G+asiHKFHwz0K5cDu58MMLUYGCmyynpaCmBq1C
         QVcA==
X-Gm-Message-State: APjAAAV05Gcb5AI3lt5zIhkzjf4w1p8iZKKOdp+NwTP4AsDHuTGIY9vx
        oGu0LMkvSs+58rmlSHv3SEyCz7Wa
X-Google-Smtp-Source: APXvYqy268PtBXj8TWBZE2EXtp5dZdQM/k5Azk1RRhX+9RHcur7tiTgRqoZvn8QRrYrkvpBasJxpzw==
X-Received: by 2002:a2e:b555:: with SMTP id a21mr12074989ljn.170.1577052004315;
        Sun, 22 Dec 2019 14:00:04 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id u16sm8524682lfi.36.2019.12.22.14.00.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Dec 2019 14:00:03 -0800 (PST)
Subject: Re: [PATCH v5 18/19] arm64: tegra: smaug: Change clk_out_2 provider
 to pmc
To:     Sowjanya Komatineni <skomatineni@nvidia.com>,
        thierry.reding@gmail.com, jonathanh@nvidia.com, broonie@kernel.org,
        lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.com,
        mperttunen@nvidia.com, gregkh@linuxfoundation.org,
        sboyd@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     pdeschrijver@nvidia.com, pgaikwad@nvidia.com, spujar@nvidia.com,
        josephl@nvidia.com, daniel.lezcano@linaro.org,
        mmaddireddy@nvidia.com, markz@nvidia.com,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1576880825-15010-1-git-send-email-skomatineni@nvidia.com>
 <1576880825-15010-19-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <2f85578e-8552-9e2e-9f67-355b24d6b99f@gmail.com>
Date:   Mon, 23 Dec 2019 01:00:01 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <1576880825-15010-19-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

21.12.2019 01:27, Sowjanya Komatineni пишет:
> clk_out_2 is one of the clocks from Tegra PMC block and Tegra PMC
> clocks are moved from clock driver to pmc driver with pmc as clock
> provider and using pmc clock ids.
> 
> This patch changes clk_out_2 provider to pmc and uses corresponding
> pmc clock id for clk_out_2.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  arch/arm64/boot/dts/nvidia/tegra210-smaug.dts | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts b/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts
> index 72c7a04ac1df..2faab6390552 100644
> --- a/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts
> +++ b/arch/arm64/boot/dts/nvidia/tegra210-smaug.dts
> @@ -1592,7 +1592,7 @@
>  			reg = <0x1a>;
>  			interrupt-parent = <&gpio>;
>  			interrupts = <TEGRA_GPIO(E, 6) IRQ_TYPE_LEVEL_LOW>;
> -			clocks = <&tegra_car TEGRA210_CLK_CLK_OUT_2>;
> +			clocks = <&tegra_pmc TEGRA_PMC_CLK_OUT_2>;
>  			clock-names = "mclk";
>  
>  			nuvoton,jkdet-enable;
> 

Isn't "assigned-clocks" needed here?
