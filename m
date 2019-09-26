Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F7EAC352A9
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 13:50:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74B21222CA
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 13:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569505827;
	bh=apWU6v79zjp0y+stZs8LNPa1deISYSPdCh9xjSVMz9Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JOefTH+15zx3TZt5lod8P0TvHlJMIfEK+sLaYv1nv0bW95QSCx/LtUoTHDsjkfPO2
	 LLGpF2i/JhVuU3A3b1zr87eSaNhp7c0MjRyQwExKa4FNqx8bqzhsfUyTWcgy6Ihvd5
	 C0WlRwO6GKm3TfijKOnFTgz4SEublAyfLS/mA5l8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbfIZNu0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 09:50:26 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39663 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726094AbfIZNu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 09:50:26 -0400
Received: by mail-wm1-f65.google.com with SMTP id v17so2657367wml.4;
        Thu, 26 Sep 2019 06:50:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=D/8T5m7hbGHRf18FTM0IPCMPxpbgEnnIkFO3iBtgMoI=;
        b=nQeKbai9YfR0Lrh+v0Hm9coCUK2o2jf61jrhYnhIaM18AwruBNjJEHdF/5i5+TTG/g
         AGxQLmDdjgz8DH+ueLcpD5Vo+RnIIvwWcdDAWs0QxBYbNrO45+yH12RSirMaiY6toBz/
         9acX+ypWSOO1OEtg/KFQgqyYw1EL68j8l5Pv7wYPkqy3xwZspWu9t12tpvguTJEO2LfZ
         uzlngXLGgTvKCrUKhOQh0atIo+agbvjXjhRhpb/kKoFuDoSlfIzJP63bioaKqnEm9R6L
         k8J26BHcOQd7Ji7LLRNqML8A/NUBa0avUJMavs4OKAx6VfJX98jmvs9VG8FYeo9qNF8d
         azSQ==
X-Gm-Message-State: APjAAAXrkWUbK6bgltNptlEpbxYCL/N5rbV9+owfHrefj3Z11MLTjvTV
        i0S7BX9sPU/cbVgSAJkqZBI=
X-Google-Smtp-Source: APXvYqzdU1cIa3FD+JAPYVAaH707n4teHQKT/IIvZ7iBM1sXGF77mTWqzqflvK9u9d6gvprBoDLiEg==
X-Received: by 2002:a7b:c949:: with SMTP id i9mr2903344wml.136.1569505823617;
        Thu, 26 Sep 2019 06:50:23 -0700 (PDT)
Received: from pi3 ([194.230.155.145])
        by smtp.googlemail.com with ESMTPSA id l9sm2945985wme.45.2019.09.26.06.50.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 06:50:22 -0700 (PDT)
Date:   Thu, 26 Sep 2019 15:50:20 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Maciej Falkowski <m.falkowski@samsung.com>
Subject: Re: [PATCH] dt-bindings: sound: Convert Samsung Exynos Odroid
 XU3/XU4 audio complex to dt-schema
Message-ID: <20190926135020.GB15876@pi3>
References: <CGME20190926120115eucas1p20280a4e50c826d43bea7bfe5d670aebe@eucas1p2.samsung.com>
 <20190926120111.8478-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190926120111.8478-1-m.szyprowski@samsung.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2019 at 02:01:11PM +0200, Marek Szyprowski wrote:
> From: Maciej Falkowski <m.falkowski@samsung.com>
> 
> Convert Samsung Exynos Odroid XU3/XU4 audio complex with MAX98090 codec
> to newer dt-schema format.
> 
> 'clocks' property is unneeded in the bindings and is left undefined in 'properties'.
> 
> 'samsung,audio-widgets' and 'samsung,audio-routing' are optional from driver
> perspective and they are set as unrequired.
> 
> Signed-off-by: Maciej Falkowski <m.falkowski@samsung.com>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  .../bindings/sound/samsung,odroid.txt         | 54 -----------
>  .../bindings/sound/samsung,odroid.yaml        | 91 +++++++++++++++++++
>  2 files changed, 91 insertions(+), 54 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/sound/samsung,odroid.txt
>  create mode 100644 Documentation/devicetree/bindings/sound/samsung,odroid.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/samsung,odroid.txt b/Documentation/devicetree/bindings/sound/samsung,odroid.txt
> deleted file mode 100644
> index e9da2200e173..000000000000
> --- a/Documentation/devicetree/bindings/sound/samsung,odroid.txt
> +++ /dev/null
> @@ -1,54 +0,0 @@
> -Samsung Exynos Odroid XU3/XU4 audio complex with MAX98090 codec
> -
> -Required properties:
> -
> - - compatible - "hardkernel,odroid-xu3-audio" - for Odroid XU3 board,
> -		"hardkernel,odroid-xu4-audio" - for Odroid XU4 board (deprecated),
> -		"samsung,odroid-xu3-audio" - for Odroid XU3 board (deprecated),
> -		"samsung,odroid-xu4-audio" - for Odroid XU4 board (deprecated)
> - - model - the user-visible name of this sound complex
> - - clocks - should contain entries matching clock names in the clock-names
> -    property
> - - samsung,audio-widgets - this property specifies off-codec audio elements
> -   like headphones or speakers, for details see widgets.txt
> - - samsung,audio-routing - a list of the connections between audio
> -   components;  each entry is a pair of strings, the first being the
> -   connection's sink, the second being the connection's source;
> -   valid names for sources and sinks are the MAX98090's pins (as
> -   documented in its binding), and the jacks on the board
> -
> -   For Odroid X2:
> -     "Headphone Jack", "Mic Jack", "DMIC"
> -
> -   For Odroid U3, XU3:
> -     "Headphone Jack", "Speakers"
> -
> -   For Odroid XU4:
> -     no entries
> -
> -Required sub-nodes:
> -
> - - 'cpu' subnode with a 'sound-dai' property containing the phandle of the I2S
> -    controller
> - - 'codec' subnode with a 'sound-dai' property containing list of phandles
> -    to the CODEC nodes, first entry must be corresponding to the MAX98090
> -    CODEC and the second entry must be the phandle of the HDMI IP block node
> -
> -Example:
> -
> -sound {
> -	compatible = "hardkernel,odroid-xu3-audio";
> -	model = "Odroid-XU3";
> -	samsung,audio-routing =
> -		"Headphone Jack", "HPL",
> -		"Headphone Jack", "HPR",
> -		"IN1", "Mic Jack",
> -		"Mic Jack", "MICBIAS";
> -
> -	cpu {
> -		sound-dai = <&i2s0 0>;
> -	};
> -	codec {
> -		sound-dai = <&hdmi>, <&max98090>;
> -	};
> -};
> diff --git a/Documentation/devicetree/bindings/sound/samsung,odroid.yaml b/Documentation/devicetree/bindings/sound/samsung,odroid.yaml
> new file mode 100644
> index 000000000000..db6d3ea3180e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/samsung,odroid.yaml
> @@ -0,0 +1,91 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/samsung,odroid.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Samsung Exynos Odroid XU3/XU4 audio complex with MAX98090 codec
> +
> +maintainers:
> +  - Krzysztof Kozlowski <krzk@kernel.org>
> +  - Sylwester Nawrocki <s.nawrocki@samsung.com>
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: hardkernel,odroid-xu3-audio
> +
> +      - const: hardkernel,odroid-xu4-audio
> +        deprecated: true
> +
> +      - const: samsung,odroid-xu3-audio
> +        deprecated: true
> +
> +      - const: samsung,odroid-xu4-audio
> +        deprecated: true
> +
> +  model:
> +    $ref: /schemas/types.yaml#/definitions/string
> +    description: The user-visible name of this sound complex.
> +
> +  cpu:

Continuing discussion from TM2 audio, these are not standard properties,
so they can be in some reasonable order. Ordering might not only bring
readability but also solve conflicts of simultaneous edits.  The same in
"required" section (except compatible).

> +    type: object
> +    properties:
> +      sound-dai:
> +        $ref: /schemas/types.yaml#/definitions/phandle-array
> +        description: phandles to the I2S controllers
> +
> +  codec:
> +    type: object
> +    properties:
> +      sound-dai:
> +        $ref: /schemas/types.yaml#/definitions/phandle-array
> +        description: |
> +          List of phandles to the CODEC nodes,
> +          first entry must be corresponding to the MAX98090 CODEC and
> +          the second entry must be the phandle of the HDMI IP block node.
> +
> +  samsung,audio-widgets:
> +    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
> +    description: |
> +      This property specifies off-codec audio elements
> +      like headphones or speakers, for details see widgets.txt
> +
> +  samsung,audio-routing:
> +    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
> +    description: |
> +      List of the connections between audio

Too early word wrap.

Rest looks good to me, so with the changes:

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

