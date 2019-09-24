Return-Path: <SRS0=YpA9=XT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 690B8C432C1
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 15:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4021321655
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Sep 2019 15:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569338436;
	bh=Izpp3bavhN6FY2ALqgjTsV4NxUOoEgnUyUQvG+3+PQQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=I4jW3cnyoFttrHak8Mt2yALs3RAzZluWLKntv/+TcmefMpg4Ia2x9UXLQlfkB4WtM
	 sNo/FqMP4hmzXjik9H4tZ/SJYdh0LNAJatCeUZoO72x9Bj7QlXzV75MfpYa8AyPkgZ
	 vrkh3H7hP8VWHVVfCOI6IKHz+rrXlpzGfTtCAgqk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732499AbfIXPUf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 11:20:35 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44071 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732342AbfIXPUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 11:20:33 -0400
Received: by mail-wr1-f68.google.com with SMTP id i18so2400631wru.11;
        Tue, 24 Sep 2019 08:20:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=BehAsP/zGvLbMGAOB59imbbS81RZk/Eob4lWno5h7ug=;
        b=jpP2iYg9uF04ZRifEEs8MFoQpyL9SonauLqcbHD9YmfWcMSeGc3pjkleaEaFHP9GlL
         7/LcS+QvxsoInPT55Whd24ChTaPDxLQhKUXreGBL1BQa6ze1ui7h512yQYJm3ZyodMaJ
         DM1VLHmc5bgCRGsLCNs3o3lalU24qDC9VLUKEg6WBgD7689/5bS76R/K+U3kc4fjUtzH
         2AfFmefmvQkC17ucCnn5/kFFkQnqicUyaF7oaULDemu0txiCvGtJULRWyj4RqYqSS7if
         FROaqXK9Bmziw0m9Yv2xfKjQDco4E2EsfBdDFTOv68FcLv/EGrDYPUzReFHu0qV1XAgn
         djJQ==
X-Gm-Message-State: APjAAAVyLLTtV+JrfK9PXwDKLo0Zae8Xg6jORqLkBeHKBvTFK1fFQLW5
        92LkTuQ0XKb3Ljj2A2lmunE=
X-Google-Smtp-Source: APXvYqyy8MgFCfM7xqDj+hRCjQuQBkjKGh9FOEEQ3dNdjyah3yXeSBlkJCLDGZmzRdpOkQ9aU7M2+w==
X-Received: by 2002:adf:db06:: with SMTP id s6mr2848445wri.41.1569338431334;
        Tue, 24 Sep 2019 08:20:31 -0700 (PDT)
Received: from pi3 ([194.230.155.145])
        by smtp.googlemail.com with ESMTPSA id g13sm2674561wrm.42.2019.09.24.08.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2019 08:20:30 -0700 (PDT)
Date:   Tue, 24 Sep 2019 17:20:28 +0200
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
Subject: Re: [PATCH] dt-bindings: sound: Convert Samsung Exynos5433 TM2(E)
 audio complex with WM5110 codec to dt-schema
Message-ID: <20190924152028.GD9218@pi3>
References: <CGME20190924150230eucas1p295da8f6aa018aec4acabc068f6e1afa1@eucas1p2.samsung.com>
 <20190924150146.15972-1-m.szyprowski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190924150146.15972-1-m.szyprowski@samsung.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 24, 2019 at 05:01:46PM +0200, Marek Szyprowski wrote:
> From: Maciej Falkowski <m.falkowski@samsung.com>
> 
> Convert Samsung Exynos5433 TM2(E) audio complex with WM5110 codec to newer dt-schema format.
> 
> Signed-off-by: Maciej Falkowski <m.falkowski@samsung.com>
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  .../bindings/sound/samsung,tm2-audio.txt      | 42 ----------
>  .../bindings/sound/samsung,tm2-audio.yaml     | 83 +++++++++++++++++++
>  2 files changed, 83 insertions(+), 42 deletions(-)
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
> index 000000000000..377f8cbe17b8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/samsung,tm2-audio.yaml
> @@ -0,0 +1,83 @@
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
> +    maxItems: 1

$ref to string, then maxItems are not needed.
Add description (copy-paste).

> +
> +  audio-codec:
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/phandle-array
> +      - items:
> +          - description: |
> +              phandle of the wm5110 audio codec node,
> +              as described in ../mfd/arizona.txt;
> +          - description: phandle of the HDMI transmitter node.
> +
> +  i2s-controller:
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/phandle-array
> +      - items:
> +          - description: phandle of the I2S0.
> +          - description: phandle of the I2S1.
> +
> +  audio-amplifier:

Can you order the nodes here and in required section by name (except
compatible which should be first)?

Best regards,
Krzysztof

