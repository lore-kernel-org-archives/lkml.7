Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63DE2C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 13:46:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C089206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 13:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="ACMidKuh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbfHNNqH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 09:46:07 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37221 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726575AbfHNNqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 09:46:06 -0400
Received: by mail-wr1-f68.google.com with SMTP id z11so9223048wrt.4
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 06:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=TlGjjt3pKm7Y+Xi9AmXuCsOh2BkyPJ+SBu9c0vd073M=;
        b=ACMidKuhbM+uzagCaYuihV5VXI4v6CNfJHtQtkRadD8JQtGNKNN/Rgpi5j/75w8oL6
         yYhcE1bJTODm1Fo5ZwOqt7J2DDiSjEpcr4cSw68z3Mol5FF1tVZKLr49vccp5E3IpAyU
         JaLcp6ei6WP245DEXtoZNHD+sI4m1/TGBH4JeCbhR46TgYm6hAyMosSZ1WS/gWxqtEzy
         OvntyLZPBzSR++KPBCCKrsH6rVS9BBWnsleGiipgNlx8Gw1h3FyZsvfs4kX+7PATj6n5
         6CsMUK3RtCHLe6fd5YPLn1yeV9bKogsen0xjq5WtjbpiIksTPnyD6bUxGm8ttzI/a8a3
         Ektw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=TlGjjt3pKm7Y+Xi9AmXuCsOh2BkyPJ+SBu9c0vd073M=;
        b=r+qol3Bby//eIDd7FL1Mt1YTYFKqpsdAqJaJkfBhAOswJTl7kdhYqmVAQvXbcRBpLR
         bbDT0MgTggxm0Zuk3XU29FPxSmH7BEf+NyglYC2CFLCOD3GXbLNIiIgo6USjB+h6BV4X
         oM1JxQ0dxqQQkCGxuMcBJW22pDHMTIYm+MmXFZfCUzfGYj4hj2JgA5igt44fqBv4vQ4Z
         H7GFwyuwCgMgK0xtvjiiJDVjgqgD6QQM4Wzf9XcIbWbX2rFXjwhbTO/9oAqXAFFLWWq4
         LPf0EEwq+asLj7+F/oOXv2hEi77RSY3kD98NNzmCK5mr2b0KJJaPSQAm/cZnnEWyZrV4
         hWQQ==
X-Gm-Message-State: APjAAAUr1wh2IetrvPrFAop0rKNbdaBUSRgdBeHZoKP5CA+wLBIaBbYo
        BdlQrzXvsUvHAdkJPSvh7TODDge07EINMg==
X-Google-Smtp-Source: APXvYqxqqfAonffyvhUiK7vcNDMyy5IZUeu9Swk/dpe9Q1XaRim9vb+17qnXxQVHTrOP2aDseyUUYA==
X-Received: by 2002:a5d:4111:: with SMTP id l17mr53446238wrp.59.1565790362528;
        Wed, 14 Aug 2019 06:46:02 -0700 (PDT)
Received: from [192.168.1.62] (176-150-251-154.abo.bbox.fr. [176.150.251.154])
        by smtp.gmail.com with ESMTPSA id e6sm20116180wrw.35.2019.08.14.06.46.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Aug 2019 06:46:01 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] dt-bindings: clock: meson: add resets to the audio
 clock controller
To:     Jerome Brunet <jbrunet@baylibre.com>
Cc:     Kevin Hilman <khilman@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20190812123253.4734-1-jbrunet@baylibre.com>
 <20190812123253.4734-2-jbrunet@baylibre.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <cf6fffe3-4b73-be98-ee7c-40940fa7a985@baylibre.com>
Date:   Wed, 14 Aug 2019 15:46:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190812123253.4734-2-jbrunet@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/08/2019 14:32, Jerome Brunet wrote:
> Add the documentation and bindings for the resets provided by the g12a
> audio clock controller
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> ---
>  .../bindings/clock/amlogic,axg-audio-clkc.txt |  1 +
>  .../reset/amlogic,meson-g12a-audio-reset.h    | 38 +++++++++++++++++++
>  2 files changed, 39 insertions(+)
>  create mode 100644 include/dt-bindings/reset/amlogic,meson-g12a-audio-reset.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/amlogic,axg-audio-clkc.txt b/Documentation/devicetree/bindings/clock/amlogic,axg-audio-clkc.txt
> index 0f777749f4f1..b3957d10d241 100644
> --- a/Documentation/devicetree/bindings/clock/amlogic,axg-audio-clkc.txt
> +++ b/Documentation/devicetree/bindings/clock/amlogic,axg-audio-clkc.txt
> @@ -22,6 +22,7 @@ Required Properties:
>  				       components.
>  - resets	: phandle of the internal reset line
>  - #clock-cells	: should be 1.
> +- #reset-cells  : should be 1 on the g12a (and following) soc family
>  
>  Each clock is assigned an identifier and client nodes can use this identifier
>  to specify the clock which they consume. All available clocks are defined as
> diff --git a/include/dt-bindings/reset/amlogic,meson-g12a-audio-reset.h b/include/dt-bindings/reset/amlogic,meson-g12a-audio-reset.h
> new file mode 100644
> index 000000000000..14b78dabed0e
> --- /dev/null
> +++ b/include/dt-bindings/reset/amlogic,meson-g12a-audio-reset.h
> @@ -0,0 +1,38 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * Copyright (c) 2019 BayLibre, SAS.
> + * Author: Jerome Brunet <jbrunet@baylibre.com>
> + *
> + */
> +
> +#ifndef _DT_BINDINGS_AMLOGIC_MESON_G12A_AUDIO_RESET_H
> +#define _DT_BINDINGS_AMLOGIC_MESON_G12A_AUDIO_RESET_H
> +
> +#define AUD_RESET_PDM		0
> +#define AUD_RESET_TDMIN_A	1
> +#define AUD_RESET_TDMIN_B	2
> +#define AUD_RESET_TDMIN_C	3
> +#define AUD_RESET_TDMIN_LB	4
> +#define AUD_RESET_LOOPBACK	5
> +#define AUD_RESET_TODDR_A	6
> +#define AUD_RESET_TODDR_B	7
> +#define AUD_RESET_TODDR_C	8
> +#define AUD_RESET_FRDDR_A	9
> +#define AUD_RESET_FRDDR_B	10
> +#define AUD_RESET_FRDDR_C	11
> +#define AUD_RESET_TDMOUT_A	12
> +#define AUD_RESET_TDMOUT_B	13
> +#define AUD_RESET_TDMOUT_C	14
> +#define AUD_RESET_SPDIFOUT	15
> +#define AUD_RESET_SPDIFOUT_B	16
> +#define AUD_RESET_SPDIFIN	17
> +#define AUD_RESET_EQDRC		18
> +#define AUD_RESET_RESAMPLE	19
> +#define AUD_RESET_DDRARB	20
> +#define AUD_RESET_POWDET	21
> +#define AUD_RESET_TORAM		22
> +#define AUD_RESET_TOACODEC	23
> +#define AUD_RESET_TOHDMITX	24
> +#define AUD_RESET_CLKTREE	25
> +
> +#endif
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
