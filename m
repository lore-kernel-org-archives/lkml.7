Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0686C4740C
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 18:56:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8760F21924
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 18:56:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DhYg+foH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732482AbfIIS4o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 14:56:44 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:39540 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727164AbfIIS4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 14:56:44 -0400
Received: by mail-pl1-f193.google.com with SMTP id bd8so6938375plb.6
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2019 11:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=9PpVHKOkn7AvbOWw4B8dKfxzmxwCcW0yqGrQBUq0hN8=;
        b=DhYg+foHMBNgIp8ZI6L0UbWWMEHpLnOxeSdowJUQ0hVIusLXPBuzB5YrlNfmFeh+K6
         Xm1rdE3/IBzPQjUatOMjcobzfLiFnLZihws9zc6ra29d7Wwo8P3N3LBSRVlys2Nug1v3
         s+0LaXu2s4EWSkKyG4IEoUsd5ohWbInVKmiAM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9PpVHKOkn7AvbOWw4B8dKfxzmxwCcW0yqGrQBUq0hN8=;
        b=O2DXVLUku58DLWb52jAUzC3tMnIQvnZdYnIRcgwSUvuzjkHq8fLdsD6uqB/5FI1WO8
         mjwpprmBWOmjEo/ivixo/WmJoZ9tzMI+2ALcf07p9f/Ts8f9PfHhk2fzz9DxxTP02ZaF
         tWldhsdm1b2dwyW+CERwlzfmMMp86nj9QcjaDXrFNhil+US5/Xu24aHdEuEV8++ap++5
         I0aFJfLgXY51QkKPdw1519Oq1e36RtLAVwZy+lqa3dTfd7nRVXVuOEb81AyC3wcTYUnX
         MYNmP9CG8vU+kKh9vZECLu620uoMboXtni/3s4iQvO7051iC9uimvd0vTNrJT6JJ945+
         kdZA==
X-Gm-Message-State: APjAAAUcqCAEjEuZ/47MDUNygAT1sqoEQtdh3o5pF6Ve1ka3FOZb8Vod
        w5ja8KEYC8N5hlCAD46gUfF0liQB2xqC3O4Y841vyqO2l06xDWdOgRxgq132OvgfeIKUc92O/Pu
        WTIq/hwVTc77VonTICR9duesQgfXSxSw8c8XqIkhBAlir4kXpKuVgHMsTct3CnXHY0KH6pNTy2r
        DGF9g=
X-Google-Smtp-Source: APXvYqxHAEqC9e+AAStf9IM6pukGCQTPomG2dj8gqDOX6pR5nm98F+0IcF0DggiI0chSTzXXODrb7A==
X-Received: by 2002:a17:902:166:: with SMTP id 93mr26449506plb.320.1568055401720;
        Mon, 09 Sep 2019 11:56:41 -0700 (PDT)
Received: from rj-aorus.ric.broadcom.com ([192.19.228.250])
        by smtp.gmail.com with ESMTPSA id l72sm270722pjb.7.2019.09.09.11.56.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Sep 2019 11:56:40 -0700 (PDT)
Subject: Re: [PATCH v1 1/1] arm64: dts: Fix gpio to pinmux mapping
To:     Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1568018127-26730-1-git-send-email-rayagonda.kokatanur@broadcom.com>
From:   Ray Jui <ray.jui@broadcom.com>
Message-ID: <664091a5-7cc0-eeb9-425a-ce39c31b1dfc@broadcom.com>
Date:   Mon, 9 Sep 2019 11:56:37 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1568018127-26730-1-git-send-email-rayagonda.kokatanur@broadcom.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/9/19 1:35 AM, Rayagonda Kokatanur wrote:
> There are total of 151 non-secure gpio (0-150) and four
> pins of pinmux (91, 92, 93 and 94) are not mapped to any
> gpio pin, hence update same in DT.
> 
> Fixes: 8aa428cc1e2e ("arm64: dts: Add pinctrl DT nodes for Stingray SOC")
> Signed-off-by: Rayagonda Kokatanur <rayagonda.kokatanur@broadcom.com>
> ---
>   arch/arm64/boot/dts/broadcom/stingray/stingray-pinctrl.dtsi | 5 +++--
>   arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi         | 3 +--
>   2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray-pinctrl.dtsi b/arch/arm64/boot/dts/broadcom/stingray/stingray-pinctrl.dtsi
> index 8a3a770..56789cc 100644
> --- a/arch/arm64/boot/dts/broadcom/stingray/stingray-pinctrl.dtsi
> +++ b/arch/arm64/boot/dts/broadcom/stingray/stingray-pinctrl.dtsi
> @@ -42,13 +42,14 @@
>   
>   		pinmux: pinmux@14029c {
>   			compatible = "pinctrl-single";
> -			reg = <0x0014029c 0x250>;
> +			reg = <0x0014029c 0x26c>;
>   			#address-cells = <1>;
>   			#size-cells = <1>;
>   			pinctrl-single,register-width = <32>;
>   			pinctrl-single,function-mask = <0xf>;
>   			pinctrl-single,gpio-range = <
> -				&range 0 154 MODE_GPIO
> +				&range 0  91 MODE_GPIO
> +				&range 95 60 MODE_GPIO
>   				>;
>   			range: gpio-range {
>   				#pinctrl-single,gpio-range-cells = <3>;
> diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
> index 71e2e34..0098dfd 100644
> --- a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
> +++ b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
> @@ -464,8 +464,7 @@
>   					<&pinmux 108 16 27>,
>   					<&pinmux 135 77 6>,
>   					<&pinmux 141 67 4>,
> -					<&pinmux 145 149 6>,
> -					<&pinmux 151 91 4>;
> +					<&pinmux 145 149 6>;
>   		};
>   
>   		i2c1: i2c@e0000 {
> 

Thanks for the fix. Looks good to me!

Reviewed-by: Ray Jui <ray.jui@broadcom.com>
