Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C0E5C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 08:49:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D9C4621841
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 08:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="WA0k8sfd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfCTItg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 04:49:36 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35052 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbfCTItg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 04:49:36 -0400
Received: by mail-wm1-f66.google.com with SMTP id y197so1093753wmd.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 01:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=OGXGcvskv4iCf+DQMwdniJ9CF3Cv0SYqxOdkT3KVa+w=;
        b=WA0k8sfdCPCCgdaECQhrTL4VIxD5StlA7xxHwHEzX7kM/F6Z1UF0sUCfASwdX1Ge0J
         cWsA03a/x6qvODKIBwD44V/xm7lzHInUUU4GMpEuWObgquhln3NCE+2FTPgdoe/SO6XC
         MbCkYUh/iJBkrsbp/B+RVfk3lsm7k1skYRjD2iiPq1GBtXnvnlSCVqXA3DLl+OSeqKmS
         1fuEmFjbzOxL7Toou2zqJxbXsTUwQQ+lVj/gDF102U9bo03n07WzPbEx6LmRq8Eq/P6H
         RScVTypeUr22Huema2t/Bsvi4eCdG231JJMzhUdsaEjmMBPuChK+mYdGg0H70Xc1NDXw
         DH2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=OGXGcvskv4iCf+DQMwdniJ9CF3Cv0SYqxOdkT3KVa+w=;
        b=XdlV6rWj1Oy7cvWKQXAWcKd+mofpbwNtbGtAEbzTDityVFct3HQkzm7/dHkcTuOKSf
         pZfrSyFRoiq1FSjkRZPOE7nMECqwKVTashXZfvAiI7F0jY+9BzLVj1nx1uzyBbWhkqy9
         EVYMObf1/neecXqDPmPhMmYnHQHOee5ooP7M+uv3536JSTCVmveT/u2pt82rqrT13iXn
         K1bxyTBRIHLN+ykNu9orn/8LmAhH3YUy2oqq3tIsRvkxqdbqz2LL230/6MHw94cb+sEm
         fT9P07H+yyUv43dTfA0ax+5Gzx3cCvNMAObJ0ToFJypfFDbBLiBSQlBXOQHDjyiR2CSm
         7ERA==
X-Gm-Message-State: APjAAAWOowOu2YJZbqsMo9X+wXpEuVdFGAq9+o0KOHe52LTnLiHhtEtG
        uIzvr3PTtWpuYFeeRhKk+1ohcg==
X-Google-Smtp-Source: APXvYqx/j0beIVS2vwDu50rOrnf8gkb7XYqITZeZIfk0qeRZvwzUQiB8KpoyngBXodMOq3m6MLHsXA==
X-Received: by 2002:a1c:cb82:: with SMTP id b124mr6907166wmg.11.1553071773429;
        Wed, 20 Mar 2019 01:49:33 -0700 (PDT)
Received: from [192.168.1.62] (176-150-251-154.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id a9sm1672536wrt.29.2019.03.20.01.49.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Mar 2019 01:49:32 -0700 (PDT)
Subject: Re: [PATCH] dt-bindings: clock: axg-audio: unexpose controller inputs
To:     Jerome Brunet <jbrunet@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Maxime Jourdan <mjourdan@baylibre.com>
References: <20190213095835.17448-1-jbrunet@baylibre.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <703bf558-a0f7-e64b-bf0b-bb619c16d4c3@baylibre.com>
Date:   Wed, 20 Mar 2019 09:49:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190213095835.17448-1-jbrunet@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/02/2019 10:58, Jerome Brunet wrote:
> Remove the bindings ID of the clock input of the controller. These
> clocks are purely internal to the controller, exposing them was a
> mistake. Actually, these should not even be in the provider and have
> IDs to begin with.
> 
> Unexpose these IDs before:
>  * someone starts using them (even if there no valid reason to do so)
>  * the actual clocks are removed. The fact that they exist is just the
>    result of an ugly hack. This will be resolved in CCF when we can
>    reference DT directly in parent table.
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  drivers/clk/meson/axg-audio.h              | 20 ++++++++++++++++++++
>  include/dt-bindings/clock/axg-audio-clkc.h | 20 --------------------
>  2 files changed, 20 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/clk/meson/axg-audio.h b/drivers/clk/meson/axg-audio.h
> index 7191b39c9d65..644f0b0fddf2 100644
> --- a/drivers/clk/meson/axg-audio.h
> +++ b/drivers/clk/meson/axg-audio.h
> @@ -60,6 +60,26 @@
>  #define AUD_CLKID_MST5			6
>  #define AUD_CLKID_MST6			7
>  #define AUD_CLKID_MST7			8
> +#define AUD_CLKID_SLV_SCLK0		9
> +#define AUD_CLKID_SLV_SCLK1		10
> +#define AUD_CLKID_SLV_SCLK2		11
> +#define AUD_CLKID_SLV_SCLK3		12
> +#define AUD_CLKID_SLV_SCLK4		13
> +#define AUD_CLKID_SLV_SCLK5		14
> +#define AUD_CLKID_SLV_SCLK6		15
> +#define AUD_CLKID_SLV_SCLK7		16
> +#define AUD_CLKID_SLV_SCLK8		17
> +#define AUD_CLKID_SLV_SCLK9		18
> +#define AUD_CLKID_SLV_LRCLK0		19
> +#define AUD_CLKID_SLV_LRCLK1		20
> +#define AUD_CLKID_SLV_LRCLK2		21
> +#define AUD_CLKID_SLV_LRCLK3		22
> +#define AUD_CLKID_SLV_LRCLK4		23
> +#define AUD_CLKID_SLV_LRCLK5		24
> +#define AUD_CLKID_SLV_LRCLK6		25
> +#define AUD_CLKID_SLV_LRCLK7		26
> +#define AUD_CLKID_SLV_LRCLK8		27
> +#define AUD_CLKID_SLV_LRCLK9		28
>  #define AUD_CLKID_MST_A_MCLK_SEL	59
>  #define AUD_CLKID_MST_B_MCLK_SEL	60
>  #define AUD_CLKID_MST_C_MCLK_SEL	61
> diff --git a/include/dt-bindings/clock/axg-audio-clkc.h b/include/dt-bindings/clock/axg-audio-clkc.h
> index fd9c362099d9..eafb0de8466b 100644
> --- a/include/dt-bindings/clock/axg-audio-clkc.h
> +++ b/include/dt-bindings/clock/axg-audio-clkc.h
> @@ -7,26 +7,6 @@
>  #ifndef __AXG_AUDIO_CLKC_BINDINGS_H
>  #define __AXG_AUDIO_CLKC_BINDINGS_H
>  
> -#define AUD_CLKID_SLV_SCLK0		9
> -#define AUD_CLKID_SLV_SCLK1		10
> -#define AUD_CLKID_SLV_SCLK2		11
> -#define AUD_CLKID_SLV_SCLK3		12
> -#define AUD_CLKID_SLV_SCLK4		13
> -#define AUD_CLKID_SLV_SCLK5		14
> -#define AUD_CLKID_SLV_SCLK6		15
> -#define AUD_CLKID_SLV_SCLK7		16
> -#define AUD_CLKID_SLV_SCLK8		17
> -#define AUD_CLKID_SLV_SCLK9		18
> -#define AUD_CLKID_SLV_LRCLK0		19
> -#define AUD_CLKID_SLV_LRCLK1		20
> -#define AUD_CLKID_SLV_LRCLK2		21
> -#define AUD_CLKID_SLV_LRCLK3		22
> -#define AUD_CLKID_SLV_LRCLK4		23
> -#define AUD_CLKID_SLV_LRCLK5		24
> -#define AUD_CLKID_SLV_LRCLK6		25
> -#define AUD_CLKID_SLV_LRCLK7		26
> -#define AUD_CLKID_SLV_LRCLK8		27
> -#define AUD_CLKID_SLV_LRCLK9		28
>  #define AUD_CLKID_DDR_ARB		29
>  #define AUD_CLKID_PDM			30
>  #define AUD_CLKID_TDMIN_A		31
> 


Applied to next/drivers
