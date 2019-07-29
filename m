Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA5BC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 13:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA5AB206DD
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 13:06:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="rL8CVU7/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728495AbfG2NGH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 09:06:07 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55004 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbfG2NGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 09:06:06 -0400
Received: by mail-wm1-f68.google.com with SMTP id p74so53759983wme.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jul 2019 06:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:openpgp:autocrypt:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=gzcG6JHmmKno6fQH+NVToQxb9v+6Sq8H4NfaqdBg8eA=;
        b=rL8CVU7/Ogp6LWePphSEsy/trY+O3XxbqQOTvm/wilBXKWeGWPXWMv2nRLiiSyKpbf
         4JkN8/+7tj2Cik+qAvmMfsFeXkYxJFA6zXjJCgdQQrNVRTTKhDzN6DJmZugilKfZOuFP
         ggFiH+fnV2CPgYlB4RjhYxseAwKbIsO9Nizt7YxlxbBQ87wIrH8W4txQC8fTBwSt0F4t
         BiKGbGl5FqMAsklL57uwQIwe7IOrbKPXKejM6DRhuO4elzWG0OmdYJZAsiYJJzp/qr/l
         Pumq4IGntWFMYZJfyVGkLFPLnE607hXYO1D97/GYzlJb7CpoV+coGiqt/WjXirNfzD5S
         dT6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :organization:message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=gzcG6JHmmKno6fQH+NVToQxb9v+6Sq8H4NfaqdBg8eA=;
        b=jlrRszRDIixhesBtYGwqG8TZUdhMmEkMso/Gox460nk4TbovX1VjVdZO6hxiGoQysb
         3jZUiolHfzEs9fhrqL2XhYmcjRbIV8wCTc8hQXArKVX0TtWamfX6gN3D7BShafkwr3K6
         h9xruZ5nOhPgor4J2ptYeEHhWdfN2PUOQsvOBGoEUQFniXzAGEnM4qXu+qxIGLX4ZbBj
         jhOcM3cvOjBrGhT+79LgRUoWNsG9sIwTAFUGXdWoQlwaBUHFURFAeMJHcchmx+4OAW+f
         cAfL/Tk35I4dDkK4hff4o0jOEEmqJoLHzN7XFPSafyDuWFVZjShtDOHmD+Xv5o8GKrhe
         N74g==
X-Gm-Message-State: APjAAAWixTMCUXhCaq/PCufOuFso8EBGD4Nf6HUtXoZe2I9iz6OfghLA
        jSfT6gbpzcnjlUsCJ+yezQGidg==
X-Google-Smtp-Source: APXvYqwgg2x3EPaIulTcKD81Hh3F7Xmt0WFn1wKoZ+NSIxWgDXgtKdPbAZbhdkabvZvMTeOgPTkBJA==
X-Received: by 2002:a1c:63d7:: with SMTP id x206mr101098772wmb.19.1564405563741;
        Mon, 29 Jul 2019 06:06:03 -0700 (PDT)
Received: from [10.1.2.12] (lmontsouris-657-1-212-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.gmail.com with ESMTPSA id p6sm68102914wrq.97.2019.07.29.06.06.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 06:06:03 -0700 (PDT)
Subject: Re: [PATCH 1/3] dt-bindings: media: amlogic,vdec: add default
 compatible
To:     Maxime Jourdan <mjourdan@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>
Cc:     linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
References: <20190726124639.7713-1-mjourdan@baylibre.com>
 <20190726124639.7713-2-mjourdan@baylibre.com>
From:   Neil Armstrong <narmstrong@baylibre.com>
Openpgp: preference=signencrypt
Autocrypt: addr=narmstrong@baylibre.com; prefer-encrypt=mutual; keydata=
 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
 ZaTUOEkgIor5losDrePdPgE=
Organization: Baylibre
Message-ID: <b82bd2b5-9192-5ce8-eb97-8bde44c2d363@baylibre.com>
Date:   Mon, 29 Jul 2019 15:06:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190726124639.7713-2-mjourdan@baylibre.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/07/2019 14:46, Maxime Jourdan wrote:
> The first version of the bindings is missing a generic compatible that
> is used by the base node (GX), and then extended by the SoC device trees
> (GXBB, GXL, GXM)
> 
> Also change the example to use "video-codec" instead of "video-decoder",
> as the former is the one used in almost all cases when it comes to video
> decode/encode accelerators.
> 
> Signed-off-by: Maxime Jourdan <mjourdan@baylibre.com>
> ---
>  Documentation/devicetree/bindings/media/amlogic,vdec.txt | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/media/amlogic,vdec.txt b/Documentation/devicetree/bindings/media/amlogic,vdec.txt
> index aabdd01bcf32..9b6aace86ca7 100644
> --- a/Documentation/devicetree/bindings/media/amlogic,vdec.txt
> +++ b/Documentation/devicetree/bindings/media/amlogic,vdec.txt
> @@ -26,6 +26,7 @@ Required properties:
>  	- GXBB (S905) : "amlogic,gxbb-vdec"
>  	- GXL (S905X, S905D) : "amlogic,gxl-vdec"
>  	- GXM (S912) : "amlogic,gxm-vdec"
> +	followed by the common "amlogic,gx-vdec"
>  - reg: base address and size of he following memory-mapped regions :
>  	- dos
>  	- esparser
> @@ -47,8 +48,8 @@ Required properties:
>  
>  Example:
>  
> -vdec: video-decoder@c8820000 {
> -	compatible = "amlogic,gxbb-vdec";
> +vdec: video-codec@c8820000 {
> +	compatible = "amlogic,gxbb-vdec", "amlogic,gx-vdec";
>  	reg = <0x0 0xc8820000 0x0 0x10000>,
>  	      <0x0 0xc110a580 0x0 0xe4>;
>  	reg-names = "dos", "esparser";
> 

Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
