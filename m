Return-Path: <SRS0=WVJ0=YK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E5EECE58E
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 18:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE78F2089C
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Oct 2019 18:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1571338592;
	bh=qXo6exvudcIbVnUP2PB0Rmm+J/ae6gIvjV4+nUKOp7c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=A6JEEL1mQZr+OkSzuHCULdPb2BO3K9QgLJe5hH+zgM4p+Ja6pwgrNVpy3IeQFWy/p
	 xxXAoEOIHkkDyF6hjLSq/S/NfwX0cc8hsbt8ShQyxt8+aeywXHcF/+rgZmHLnwa5kb
	 hDz6z646dapbVfNFuOP8X+vwriFCE8gkQzWuZjvI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406966AbfJQS4b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Oct 2019 14:56:31 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:33155 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728796AbfJQS4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 14:56:31 -0400
Received: by mail-oi1-f193.google.com with SMTP id a15so3118516oic.0;
        Thu, 17 Oct 2019 11:56:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OIlKYxbD3v48QhMXdWaoqqWvm2v29IB+F6T3fMPmGFY=;
        b=f2DhRuv5rDAdaWbzcdKuddvNBx2VN+PKV6E5oGhIE6f6c48uLDli1u6eoXsVoOpYqR
         TjLQxo0Wvj2uh8JRhkA71FspOU5WKLv+En8o2/CGYHbNHJSWLfJQ3ybWb7Mk6hwIAJuO
         6EsUQWKod+iKUnZuBtaCpjbwXSEywUo1beTph8VZftb6fSZhQCBcgSKB8l+CNoYV1lKU
         r7fw3D86i9/ldcdmTOHj8Mix0jnTfJNoJ/2DhxEVtvR+4ro6ojcfw3dBybxed7xWDL2p
         /jCRwKULcQac4tc52tmWCKn7391jK2laBjCLZYRBUA7XgXP+L1zq906ZjwXR3MAoUAM3
         QlnA==
X-Gm-Message-State: APjAAAVvherq/Dj9nH9dLrZYAMcocJWb4wYwAgHFYHISktdoQPmMVE+R
        Ut8kYM4CQqIE2+V6i1lUHw==
X-Google-Smtp-Source: APXvYqwbL0Ei9KK0E8mppc/FlyCSa2rde90FmcjmHdODK5gTRt8Pn98hBtxCMqhBOwYMBmAnsbM/PA==
X-Received: by 2002:a05:6808:614:: with SMTP id y20mr4647422oih.60.1571338589906;
        Thu, 17 Oct 2019 11:56:29 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id a88sm846203otb.0.2019.10.17.11.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 11:56:29 -0700 (PDT)
Date:   Thu, 17 Oct 2019 13:56:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Maciej Falkowski <m.falkowski@samsung.com>
Subject: Re: [PATCH v3] dt-bindings: sound: Convert Samsung Exynos5433 TM2(E)
 audio complex with WM5110 codec to dt-schema
Message-ID: <20191017185628.GA25020@bogus>
References: <CGME20191017100514eucas1p2e189e26e887c9cdd2209357c91846641@eucas1p2.samsung.com>
 <20191017100506.4036-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191017100506.4036-1-m.szyprowski@samsung.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 12:05:06PM +0200, Marek Szyprowski wrote:
> From: Maciej Falkowski <m.falkowski@samsung.com>
> 
> Convert Samsung Exynos5433 TM2(E) audio complex with WM5110 codec to
> newer dt-schema format.
> 
> Signed-off-by: Maciej Falkowski <m.falkowski@samsung.com>
> [mszyprow: reordered non-standard properties, added list of values
>  for widgets, minor other fixes]
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  .../bindings/sound/samsung,tm2-audio.txt      | 42 --------
>  .../bindings/sound/samsung,tm2-audio.yaml     | 99 +++++++++++++++++++
>  2 files changed, 99 insertions(+), 42 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/samsung,tm2-audio.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/samsung,tm2-audio.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/samsung,tm2-audio.txt b/Documentation/devicetree/bindings/sound/samsung,tm2-audio.txt
> deleted file mode 100644
> index f5ccc12ddc00..000000000000
> --- a/Documentation/devicetree/bindings/sound/samsung,tm2-audio.txt
> +++ /dev/null
> @@ -1,42 +0,0 @@
> -Samsung Exynos5433 TM2(E) audio complex with WM5110 codec
> -
> -Required properties:
> -
> - - compatible		 : "samsung,tm2-audio"
> - - model		 : the user-visible name of this sound complex
> - - audio-codec		 : the first entry should be phandle of the wm5110 audio
> -			   codec node, as described in ../mfd/arizona.txt;
> -			   the second entry should be phandle of the HDMI
> -			   transmitter node
> - - i2s-controller	 : the list of phandle and argument tuples pointing to
> -			   I2S controllers, the first entry should be I2S0 and
> -			   the second one I2S1
> - - audio-amplifier	 : the phandle of the MAX98504 amplifier
> - - samsung,audio-routing : a list of the connections between audio components;
> -			   each entry is a pair of strings, the first being the
> -			   connection's sink, the second being the connection's
> -			   source; valid names for sources and sinks are the
> -			   WM5110's and MAX98504's pins and the jacks on the
> -			   board: HP, SPK, Main Mic, Sub Mic, Third Mic,
> -			   Headset Mic
> - - mic-bias-gpios	 : GPIO pin that enables the Main Mic bias regulator
> -
> -
> -Example:
> -
> -sound {
> -	compatible = "samsung,tm2-audio";
> -	audio-codec = <&wm5110>, <&hdmi>;
> -	i2s-controller = <&i2s0 0>, <&i2s1 0>;
> -	audio-amplifier = <&max98504>;
> -	mic-bias-gpios = <&gpr3 2 0>;
> -	model = "wm5110";
> -	samsung,audio-routing =
> -		"HP", "HPOUT1L",
> -		"HP", "HPOUT1R",
> -		"SPK", "SPKOUT",
> -		"SPKOUT", "HPOUT2L",
> -		"SPKOUT", "HPOUT2R",
> -		"Main Mic", "MICBIAS2",
> -		"IN1R", "Main Mic";
> -};
> diff --git a/Documentation/devicetree/bindings/sound/samsung,tm2-audio.yaml b/Documentation/devicetree/bindings/sound/samsung,tm2-audio.yaml
> new file mode 100644
> index 000000000000..c9178d928ad4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/samsung,tm2-audio.yaml
> @@ -0,0 +1,99 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/samsung,tm2-audio.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Samsung Exynos SoC Exynos5433 TM2(E) audio complex with WM5110 codec
> +
> +maintainers:
> +  - Krzysztof Kozlowski <krzk@kernel.org>
> +  - Sylwester Nawrocki <s.nawrocki@samsung.com>
> +
> +properties:
> +  compatible:
> +    const: samsung,tm2-audio
> +
> +  model:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description: The user-visible name of this sound complex.
> +
> +  i2s-controller:
> +    allOf:
> +    - $ref: /schemas/types.yaml#/definitions/phandle-array
> +    - items:
> +       - description: phandle of the I2S0.
> +       - description: phandle of the I2S1.
> +
> +  audio-codec:
> +    allOf:
> +    - $ref: /schemas/types.yaml#/definitions/phandle-array
> +    - items:
> +       - description: |
> +            phandle of the wm5110 audio codec node,
> +            as described in ../mfd/arizona.txt;
> +       - description: phandle of the HDMI transmitter node.
> +
> +  audio-amplifier:
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +    description: phandle of the MAX98504 amplifier.
> +
> +  mic-bias-gpios:
> +    description: GPIO pin that enables the Main Mic bias regulator.
> +    maxItems: 1
> +
> +  samsung,audio-routing:
> +    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
> +    description: |
> +      List of the connections between audio components.
> +      Each entry is a pair of strings, the first being the
> +      connection's sink, the second being the connection's
> +      source. Valid names for sources and sinks are:
> +      the WM5110's pins:
> +         "HPOUT1L",
> +         "HPOUT1R",
> +         "HPOUT2L",
> +         "HPOUT2R",
> +         "HPOUT3L",
> +         "HPOUT3R",
> +      MAX98504's pins:
> +         "SPKOUT"
> +      and the jacks on the board:
> +         "HP",
> +         "SPK",
> +         "RCV",
> +         "Main Mic",
> +         "Sub Mic",
> +         "Third Mic",
> +         "Headset Mic".

All these strings can be a schema.

> +
> +required:
> +  - compatible
> +  - model
> +  - i2s-controller
> +  - audio-codec
> +  - audio-amplifier
> +  - mic-bias-gpios
> +  - samsung,audio-routing
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    sound {
> +        compatible = "samsung,tm2-audio";
> +        model = "wm5110";
> +        i2s-controller = <&i2s0 0>, <&i2s1 0>;
> +        audio-codec = <&wm5110>, <&hdmi>;
> +        audio-amplifier = <&max98504>;
> +        mic-bias-gpios = <&gpr3>;
> +        samsung,audio-routing =
> +                "HP", "HPOUT1L",
> +                "HP", "HPOUT1R",
> +                "SPK", "SPKOUT",
> +                "SPKOUT", "HPOUT2L",
> +                "SPKOUT", "HPOUT2R",
> +                "Main Mic", "MICBIAS2",
> +                "IN1R", "Main Mic";
> +    };
> +
> -- 
> 2.17.1
> 
