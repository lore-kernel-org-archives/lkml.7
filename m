Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB87EC2D0D2
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 14:00:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C13B0218AC
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 14:00:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QmcVoTvC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbfLTOAv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 09:00:51 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:38178 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727347AbfLTOAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 09:00:50 -0500
Received: by mail-lf1-f68.google.com with SMTP id r14so7121370lfm.5;
        Fri, 20 Dec 2019 06:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=LpY4UiJbzxoVMEU3tzXRKhaFsho/SBomG9uT1fm9NeU=;
        b=QmcVoTvCYHaEw3r3AT627QQ7IXxWLbNZblYiue9GJXEHjUQPU+HX32uvIeeQJHnqmb
         xfL0NXmuO6szPJ1onlrLq0gnR6lwPoH+8m0gXasUpSUDOfPeyv58mCBbeDvZqaDZjAFA
         VnkimRaUPTyuYXcKJsc/kNaEIHp+DkcNLwBrjzSzk7x+D3XCEJkVWjpI5R22rpy9fhgh
         XlphLIu5euvM8usPlZ0KHsv9WbxmVhgHX21/yCWve8pD1JivI5bO9p0Llqy6evS3AKgX
         vlLuRRPl3+Qofjc8ZSgT3sKcReNnlKMwu/Znj/VFb1v2bO/CpBsjVKRYMDWyifbcVOX3
         g9sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=LpY4UiJbzxoVMEU3tzXRKhaFsho/SBomG9uT1fm9NeU=;
        b=WM4PX3Rn1o9kjr/iJRL9gBq59ZD2c+ChaP04v3eRVk1vDFwoTh8fqf4PbAVHsUwbrK
         0FWxV4lPFJ9TqXFw8cWIAfNPab9v7HpJ35Og81IU9Dz0ATxAphl+ZMMz7tOklNR9cWgc
         SW4mfuYrHwmhU9OxteMSSaDUsxMqI/rJJqz0wxz4ushboEc2bHvvlfPBbgz5k9OBM4Ce
         b1q21Gz5I2g1tIMyzhVQQzAf7Q5w1Ust91BfNTVVE4MlTIpZCEwMaU3fGuv0+5NpGy/V
         HlnOZ+7kGMSFrgaC9EdFwMxl+bPg04e911xEg6OBwjd3DAK0jezQjcdFUlsI/uQgdRmD
         pFYA==
X-Gm-Message-State: APjAAAVJ19vHgIbvrXSJS/87IrZLStE86PC7a4m3zgfxXHlyzP9LhDq+
        U2nHZZmH6Wq6SXRncY5PedTKcw1Z
X-Google-Smtp-Source: APXvYqxLF1kxYTtinKHI+BlHSC56oAk50xiDl2BhSeOUe4iEzValcOoZApvFNIEH1QLTEWNANmMzzA==
X-Received: by 2002:a19:ae18:: with SMTP id f24mr9266082lfc.155.1576850448338;
        Fri, 20 Dec 2019 06:00:48 -0800 (PST)
Received: from [192.168.2.145] (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.googlemail.com with ESMTPSA id m24sm5328108ljb.81.2019.12.20.06.00.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Dec 2019 06:00:47 -0800 (PST)
Subject: Re: [PATCH 1/2] ARM: dts: tegra20: add labels to i2c nodes
To:     Richard Leitner <richard.leitner@skidata.com>, robh+dt@kernel.org,
        mark.rutland@arm.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20191219130431.30458-1-richard.leitner@skidata.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <01ac756c-1e51-5d62-ca45-9e0b4f106a29@gmail.com>
Date:   Fri, 20 Dec 2019 17:00:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20191219130431.30458-1-richard.leitner@skidata.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

19.12.2019 16:04, Richard Leitner пишет:
> Add numbered labels to the i2c nodes of the Tegra20 SoC so we just need
> to alias it from derived boards.
> 
> Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
> ---
>  arch/arm/boot/dts/tegra20.dtsi | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/tegra20.dtsi b/arch/arm/boot/dts/tegra20.dtsi
> index 9c58e7fcf5c0..e02f75757a7e 100644
> --- a/arch/arm/boot/dts/tegra20.dtsi
> +++ b/arch/arm/boot/dts/tegra20.dtsi
> @@ -464,7 +464,7 @@
>  		clocks = <&tegra_car TEGRA20_CLK_RTC>;
>  	};
>  
> -	i2c@7000c000 {
> +	i2c1: i2c@7000c000 {
>  		compatible = "nvidia,tegra20-i2c";
>  		reg = <0x7000c000 0x100>;
>  		interrupts = <GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>;
> @@ -494,7 +494,7 @@
>  		status = "disabled";
>  	};
>  
> -	i2c@7000c400 {
> +	i2c2: i2c@7000c400 {
>  		compatible = "nvidia,tegra20-i2c";
>  		reg = <0x7000c400 0x100>;
>  		interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
> @@ -510,7 +510,7 @@
>  		status = "disabled";
>  	};
>  
> -	i2c@7000c500 {
> +	i2c3: i2c@7000c500 {
>  		compatible = "nvidia,tegra20-i2c";
>  		reg = <0x7000c500 0x100>;
>  		interrupts = <GIC_SPI 92 IRQ_TYPE_LEVEL_HIGH>;
> 

Hello Richard,

Why derived boards couldn't label nodes by themselves? That's what all
derived boards are doing already.

BTW, upstream should benefit from the submitted changes. This is not a
very useful change for upstream if you're not updating the actual DTs of
any of the boards in arch/arm/boot/dts/*.
