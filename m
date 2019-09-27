Return-Path: <SRS0=WTd2=XW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 677DBC4360C
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 09:09:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2E5A1217D7
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Sep 2019 09:09:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="i1noes0U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbfI0JI7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Sep 2019 05:08:59 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:37652 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfI0JI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Sep 2019 05:08:59 -0400
Received: by mail-wm1-f68.google.com with SMTP id f22so5343307wmc.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 02:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=D3OzD1hf0H56gcDrQbyUaQfmUYWImUAVbM45JNOexLY=;
        b=i1noes0UtmrZd/alh2IDqWXcEtnNh/Cq4JZFYWtHORnTgHJwiplImllKMhBLTMl+ZH
         g5qk08JX76gy/KNeTXTXOQXpwQFrSdN9TM0N8gNEGchdsHaJj2v2FtAnnFuQ1kL2zz1o
         YTUgfWC04rdBN5c6kqF+xnjVoIGZo6QpwN5NQ0IAtaL8dJgYSh9PZ9ywgLznVkDq8wp0
         /ByQuIrrOak1yCZ8QPngDkWWav86XPR7+vkx1X32ZwyYiGWhd9SF1g7xKD8clPMmJtuL
         R4bonXwOwdE/O43jSvXjXDW3FcxwQsH096WrrBjyCVSg7wxAVxzC1zetgqpTl9ZZKd95
         Klzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=D3OzD1hf0H56gcDrQbyUaQfmUYWImUAVbM45JNOexLY=;
        b=gCNT35yjGbc6byn0QNUtZgkKQBOSDWCRgQTNsmS6ESt1mNEZuZo4EpI929j+pQhqx0
         NrdJWmhovnWiJSYvbTgqkGgL8iWHc9plLNcTqjLGBo7S8D9eUwPEFHQWlaU3Wgr76PRt
         qq7v+ysZTh2jWAFSY+fXbWmvxnPNgVeU2Fp/lp86az08NWwgfw0EqsapCIAHlqv5mqV5
         S5ae1D8DNjfOK1CpzxAT08anpezwpf24FUBxhQbIo715NF195ElXKZcOhdQuOSTF6Ll7
         /dbOJqt7F7AxnR2owEbuv+fgR9cQ1Zcj93E15x7f/tcjqdfXii+JXSeWgz+pRlrwy2vL
         AD7w==
X-Gm-Message-State: APjAAAVP60z6t/km6ve3pG31XscC9AQRFYUY5feZF8ADwZycYXA6XAI0
        1Fdnxnqi6NhTCJLnaLSoFDIfmBRQF6/17w==
X-Google-Smtp-Source: APXvYqyLvZvD/UjYpUX7ivAodhd31r3/tNz71w9iOXQroqd+5CfjIXg4vF7pBXTMm+o5v8TMFQsldw==
X-Received: by 2002:a1c:29c4:: with SMTP id p187mr6773759wmp.28.1569575335838;
        Fri, 27 Sep 2019 02:08:55 -0700 (PDT)
Received: from [192.168.1.62] (176-150-251-154.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id o19sm2072963wro.50.2019.09.27.02.08.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Sep 2019 02:08:55 -0700 (PDT)
Subject: Re: [PATCH] arm64: dts: meson: g12a: add audio devices resets
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190925093358.15476-1-jbrunet@baylibre.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <9ff3a6f8-13c2-856f-f37b-dd96cb45faad@baylibre.com>
Date:   Fri, 27 Sep 2019 11:08:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190925093358.15476-1-jbrunet@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/09/2019 11:33, Jerome Brunet wrote:
> Provide the reset lines coming from the audio clock controller to
> the audio devices of the g12 family
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-g12.dtsi | 28 +++++++++++++++++-----
>  1 file changed, 22 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12.dtsi
> index 0d9df29994f3..3cf74fc96434 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12.dtsi
> @@ -103,7 +103,9 @@
>  			sound-name-prefix = "TODDR_A";
>  			interrupts = <GIC_SPI 148 IRQ_TYPE_EDGE_RISING>;
>  			clocks = <&clkc_audio AUD_CLKID_TODDR_A>;
> -			resets = <&arb AXG_ARB_TODDR_A>;
> +			resets = <&arb AXG_ARB_TODDR_A>,
> +				 <&clkc_audio AUD_RESET_TODDR_A>;
> +			reset-names = "arb", "rst";
>  			status = "disabled";
>  		};
>  
> @@ -115,7 +117,9 @@
>  			sound-name-prefix = "TODDR_B";
>  			interrupts = <GIC_SPI 149 IRQ_TYPE_EDGE_RISING>;
>  			clocks = <&clkc_audio AUD_CLKID_TODDR_B>;
> -			resets = <&arb AXG_ARB_TODDR_B>;
> +			resets = <&arb AXG_ARB_TODDR_B>,
> +				 <&clkc_audio AUD_RESET_TODDR_B>;
> +			reset-names = "arb", "rst";
>  			status = "disabled";
>  		};
>  
> @@ -127,7 +131,9 @@
>  			sound-name-prefix = "TODDR_C";
>  			interrupts = <GIC_SPI 150 IRQ_TYPE_EDGE_RISING>;
>  			clocks = <&clkc_audio AUD_CLKID_TODDR_C>;
> -			resets = <&arb AXG_ARB_TODDR_C>;
> +			resets = <&arb AXG_ARB_TODDR_C>,
> +				 <&clkc_audio AUD_RESET_TODDR_C>;
> +			reset-names = "arb", "rst";
>  			status = "disabled";
>  		};
>  
> @@ -139,7 +145,9 @@
>  			sound-name-prefix = "FRDDR_A";
>  			interrupts = <GIC_SPI 152 IRQ_TYPE_EDGE_RISING>;
>  			clocks = <&clkc_audio AUD_CLKID_FRDDR_A>;
> -			resets = <&arb AXG_ARB_FRDDR_A>;
> +			resets = <&arb AXG_ARB_FRDDR_A>,
> +				 <&clkc_audio AUD_RESET_FRDDR_A>;
> +			reset-names = "arb", "rst";
>  			status = "disabled";
>  		};
>  
> @@ -151,7 +159,9 @@
>  			sound-name-prefix = "FRDDR_B";
>  			interrupts = <GIC_SPI 153 IRQ_TYPE_EDGE_RISING>;
>  			clocks = <&clkc_audio AUD_CLKID_FRDDR_B>;
> -			resets = <&arb AXG_ARB_FRDDR_B>;
> +			resets = <&arb AXG_ARB_FRDDR_B>,
> +				 <&clkc_audio AUD_RESET_FRDDR_B>;
> +			reset-names = "arb", "rst";
>  			status = "disabled";
>  		};
>  
> @@ -163,7 +173,9 @@
>  			sound-name-prefix = "FRDDR_C";
>  			interrupts = <GIC_SPI 154 IRQ_TYPE_EDGE_RISING>;
>  			clocks = <&clkc_audio AUD_CLKID_FRDDR_C>;
> -			resets = <&arb AXG_ARB_FRDDR_C>;
> +			resets = <&arb AXG_ARB_FRDDR_C>,
> +				 <&clkc_audio AUD_RESET_FRDDR_C>;
> +			reset-names = "arb", "rst";
>  			status = "disabled";
>  		};
>  
> @@ -249,6 +261,7 @@
>  			clocks = <&clkc_audio AUD_CLKID_SPDIFIN>,
>  				 <&clkc_audio AUD_CLKID_SPDIFIN_CLK>;
>  			clock-names = "pclk", "refclk";
> +			resets = <&clkc_audio AUD_RESET_SPDIFIN>;
>  			status = "disabled";
>  		};
>  
> @@ -261,6 +274,7 @@
>  			clocks = <&clkc_audio AUD_CLKID_SPDIFOUT>,
>  				 <&clkc_audio AUD_CLKID_SPDIFOUT_CLK>;
>  			clock-names = "pclk", "mclk";
> +			resets = <&clkc_audio AUD_RESET_SPDIFOUT>;
>  			status = "disabled";
>  		};
>  
> @@ -318,6 +332,7 @@
>  			clocks = <&clkc_audio AUD_CLKID_SPDIFOUT_B>,
>  				 <&clkc_audio AUD_CLKID_SPDIFOUT_B_CLK>;
>  			clock-names = "pclk", "mclk";
> +			resets = <&clkc_audio AUD_RESET_SPDIFOUT_B>;
>  			status = "disabled";
>  		};
>  
> @@ -326,6 +341,7 @@
>  			reg = <0x0 0x744 0x0 0x4>;
>  			#sound-dai-cells = <1>;
>  			sound-name-prefix = "TOHDMITX";
> +			resets = <&clkc_audio AUD_RESET_TOHDMITX>;
>  			status = "disabled";
>  		};
>  	};
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
