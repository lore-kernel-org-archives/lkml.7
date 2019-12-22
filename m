Return-Path: <SRS0=7h0X=2M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5DD8C2D0C8
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Dec 2019 21:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB91C2063A
	for <linux-kernel@archiver.kernel.org>; Sun, 22 Dec 2019 21:55:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YYYQejbH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbfLVVzb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 22 Dec 2019 16:55:31 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34488 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbfLVVza (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Dec 2019 16:55:30 -0500
Received: by mail-lf1-f65.google.com with SMTP id l18so2980920lfc.1;
        Sun, 22 Dec 2019 13:55:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=qdel8qdZZopXXU/0MsNLxJFSuredgyPT8FP01SoHMIw=;
        b=YYYQejbHepeo25f9ZBvmH1Azz26CtUWmPsmRvjt8YchSoFJRUhdIjUEcv2+Q7aVG4R
         sfYy6fpmElQYPv7HMS68jmrp+g7kKZWOE/Y94MCZFVFhY2glx+aMbP5FkRvXG7BFJMp2
         tLQbPymDXSrNWJZZ/6KS3S+4ezIDKIk0kz/jrgsODbsq76tiNgoujDq1ZgATuEQcPpxM
         eQAsVOHGQ/6+THXYyFGaEigvwYFvSvY6AKeP59lvmJ80j7WxS7GW8SBnz+dQTrRG9nj5
         s92LE79yNvSYvkHotkoHyKNxRFJXLqNUY8y46QGoP0k1X6NP/lh7z41F1d0Msrfco+fO
         t8dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qdel8qdZZopXXU/0MsNLxJFSuredgyPT8FP01SoHMIw=;
        b=Q1pnw4q2D/jxS/ZcMX7xr2FoW/Qrl7XD+dt+QendM+TjzjiBzI2doW629IeXSQTrIK
         LkrI67ZIyuoZugTcRLi2fJGlhesNcjXiRyUSNAD1uqHuuW1dhuwEJcHcY3qQiWezwEJp
         x/UV3GSNpIksVY4482b2cAbEQasSvZ1z1O4AJocmwyroUR9DWQy2bVDxgcR0w2qrg+Jk
         ZjqXwbUcYkyAm3SAfOQDiO1b0KX+JxbCXQx7P4fF0B61eqYQ6GvhAZ1xJBP6/bKexRlH
         U0EnUYXbGMNVJQgeg90W687YBz914Q2utztgESS/OXzi1SvfNKFTOle1Dp1ZxEyL3WeZ
         AWvA==
X-Gm-Message-State: APjAAAUabjJ53J8JwNFdwQ0gCZaXMF0PWCT7LO0FrOP+HV+lgOYXO9Bz
        nOy09zgFuQXqIbazYTHhyIO48I3l
X-Google-Smtp-Source: APXvYqzn5im3eIeJlncUcrtHOz4pVrQwlxvT4dFtto8UCzLssXEOmXHSrx49BttUV4/Q5qAg8R3EWQ==
X-Received: by 2002:a19:760c:: with SMTP id c12mr15658542lff.60.1577051727971;
        Sun, 22 Dec 2019 13:55:27 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id q26sm7124334lfb.26.2019.12.22.13.55.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Dec 2019 13:55:27 -0800 (PST)
Subject: Re: [PATCH v5 07/19] dt-bindings: soc: tegra-pmc: Add id for Tegra
 PMC 32KHz blink clock
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
 <1576880825-15010-8-git-send-email-skomatineni@nvidia.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <c8a847fb-3d23-6e1e-59e2-a2d15b63ce02@gmail.com>
Date:   Mon, 23 Dec 2019 00:55:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <1576880825-15010-8-git-send-email-skomatineni@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

21.12.2019 01:26, Sowjanya Komatineni пишет:
> Tegra PMC has blink functionality that allows 32KHz clock out to
> blink pin of the Tegra.
> 
> This patch adds id for this blink clock to use for enabling or
> disabling blink output through device tree.
> 
> Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
> ---
>  include/dt-bindings/soc/tegra-pmc.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/include/dt-bindings/soc/tegra-pmc.h b/include/dt-bindings/soc/tegra-pmc.h
> index f7c866404456..a99a457471ee 100644
> --- a/include/dt-bindings/soc/tegra-pmc.h
> +++ b/include/dt-bindings/soc/tegra-pmc.h
> @@ -9,7 +9,8 @@
>  #define TEGRA_PMC_CLK_OUT_1		0
>  #define TEGRA_PMC_CLK_OUT_2		1
>  #define TEGRA_PMC_CLK_OUT_3		2
> +#define TEGRA_PMC_CLK_BLINK		3
>  
> -#define TEGRA_PMC_CLK_MAX		3
> +#define TEGRA_PMC_CLK_MAX		4
>  
>  #endif	/* _DT_BINDINGS_SOC_TEGRA_PMC_H */
> 

Could you please explain the reason of separating CLK_OUT and BLINK PMC
patches?

Also, you only documented CLK_OUT clocks in the DT binding and no BLINK.
