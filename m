Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A51FAC352A9
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 12:43:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C8E4222C3
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 12:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569501834;
	bh=JJeuzNl2HrjlLcLE7nBRsNYkgbx2lnmScQlIusZiCxI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=W+4SWqBfmS8cDHFiDO3TqHUgLOKr2U137UUpIeHyAg5qM723Y3Pv6Spip3f49Csyq
	 B0r5YqQk45rPyrwMtz6maDc0YjSO3vffoVbHb5EWaGMxOYu21+agC/pp8K/MFXPYTy
	 Lm8R2EUdsiX+WCTYCJ+YFwqqdkBlcgNwNObn0AoI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbfIZMny (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 08:43:54 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33770 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726351AbfIZMnx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 08:43:53 -0400
Received: by mail-wr1-f65.google.com with SMTP id b9so2613602wrs.0;
        Thu, 26 Sep 2019 05:43:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Hlzu40S+QsmZibZuhvWm+mQ9H7Yk8OgsXl+yxJYzbpM=;
        b=TyM2R8fq2Tz7dd9RehsemO7Zbz6PizXzU5bMr3q91WUGuAkcSbQ/leRNpgRjiRROuM
         wKH6ebTkTqGIaz+qLxrbqnhouIv71/RdRo/v4UV+MrCiO8XOVSeTiuKxslwg4f3Nzi5m
         zaHaCNnR4D71F8plIfM/c+7VBDW1bimakyPPG/4uI8kEDJidhubBl4dXiFN4oiMGRvyt
         jIIfY0G5p+I8PPOfSPEVpzZS92FKqwjjpY2W8M/i7IquARffVA4GGYNvnueffEdjnbaU
         85HPsjLcz5QfwsPXrnZTtstpzLCZifny1jazjP28ssA4Ir9qtIB0CcXubEFxje5G69wD
         Zd2w==
X-Gm-Message-State: APjAAAXHGmNFb9P6vdXZVni/ZkP3+mdfUyG04N427B5DeErCvxIA0e5m
        loCzyh3iIqAcsZqc/ylPTWg=
X-Google-Smtp-Source: APXvYqx8inhcJv/PaUWEMATgFiD1pLE0aHXDq51Vd6Cn7R4NZNObwx1ck287H2nKBnvUdj1wwqnFRQ==
X-Received: by 2002:a5d:5708:: with SMTP id a8mr2744494wrv.240.1569501829852;
        Thu, 26 Sep 2019 05:43:49 -0700 (PDT)
Received: from pi3 ([194.230.155.145])
        by smtp.googlemail.com with ESMTPSA id w12sm4112004wrg.47.2019.09.26.05.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Sep 2019 05:43:49 -0700 (PDT)
Date:   Thu, 26 Sep 2019 14:43:46 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Maciej Falkowski <m.falkowski@samsung.com>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>
Subject: Re: [PATCH] dt-bindings: sound: Convert Samsung Exynos5433 TM2(E)
 audio complex with WM5110 codec to dt-schema
Message-ID: <20190926124346.GA15876@pi3>
References: <CGME20190924150230eucas1p295da8f6aa018aec4acabc068f6e1afa1@eucas1p2.samsung.com>
 <20190924150146.15972-1-m.szyprowski@samsung.com>
 <20190924152028.GD9218@pi3>
 <50932d65-6d8b-aca2-2bec-d4eedaba0bdc@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <50932d65-6d8b-aca2-2bec-d4eedaba0bdc@samsung.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 26, 2019 at 01:49:09PM +0200, Maciej Falkowski wrote:
> 
> On 9/24/19 5:20 PM, Krzysztof Kozlowski wrote:
> > On Tue, Sep 24, 2019 at 05:01:46PM +0200, Marek Szyprowski wrote:
> >> From: Maciej Falkowski <m.falkowski@samsung.com>
> >>
> >> Convert Samsung Exynos5433 TM2(E) audio complex with WM5110 codec to newer dt-schema format.
> >>
> >> Signed-off-by: Maciej Falkowski <m.falkowski@samsung.com>
> >> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> >> ---
> >>   .../bindings/sound/samsung,tm2-audio.txt      | 42 ----------
> >>   .../bindings/sound/samsung,tm2-audio.yaml     | 83 +++++++++++++++++++
> >>   2 files changed, 83 insertions(+), 42 deletions(-)
> >>   delete mode 100644 Documentation/devicetree/bindings/sound/samsung,tm2-audio.txt
> >>   create mode 100644 Documentation/devicetree/bindings/sound/samsung,tm2-audio.yaml
> >>
> >> diff --git a/Documentation/devicetree/bindings/sound/samsung,tm2-audio.txt b/Documentation/devicetree/bindings/sound/samsung,tm2-audio.txt
> >> deleted file mode 100644
> >> index f5ccc12ddc00..000000000000
> >> --- a/Documentation/devicetree/bindings/sound/samsung,tm2-audio.txt
> >> +++ /dev/null
> >> @@ -1,42 +0,0 @@
> >> -Samsung Exynos5433 TM2(E) audio complex with WM5110 codec
> >> -
> >> -Required properties:
> >> -
> >> - - compatible		 : "samsung,tm2-audio"
> >> - - model		 : the user-visible name of this sound complex
> >> - - audio-codec		 : the first entry should be phandle of the wm5110 audio
> >> -			   codec node, as described in ../mfd/arizona.txt;
> >> -			   the second entry should be phandle of the HDMI
> >> -			   transmitter node
> >> - - i2s-controller	 : the list of phandle and argument tuples pointing to
> >> -			   I2S controllers, the first entry should be I2S0 and
> >> -			   the second one I2S1
> >> - - audio-amplifier	 : the phandle of the MAX98504 amplifier
> >> - - samsung,audio-routing : a list of the connections between audio components;
> >> -			   each entry is a pair of strings, the first being the
> >> -			   connection's sink, the second being the connection's
> >> -			   source; valid names for sources and sinks are the
> >> -			   WM5110's and MAX98504's pins and the jacks on the
> >> -			   board: HP, SPK, Main Mic, Sub Mic, Third Mic,
> >> -			   Headset Mic
> >> - - mic-bias-gpios	 : GPIO pin that enables the Main Mic bias regulator
> >> -
> >> -
> >> -Example:
> >> -
> >> -sound {
> >> -	compatible = "samsung,tm2-audio";
> >> -	audio-codec = <&wm5110>, <&hdmi>;
> >> -	i2s-controller = <&i2s0 0>, <&i2s1 0>;
> >> -	audio-amplifier = <&max98504>;
> >> -	mic-bias-gpios = <&gpr3 2 0>;
> >> -	model = "wm5110";
> >> -	samsung,audio-routing =
> >> -		"HP", "HPOUT1L",
> >> -		"HP", "HPOUT1R",
> >> -		"SPK", "SPKOUT",
> >> -		"SPKOUT", "HPOUT2L",
> >> -		"SPKOUT", "HPOUT2R",
> >> -		"Main Mic", "MICBIAS2",
> >> -		"IN1R", "Main Mic";
> >> -};
> >> diff --git a/Documentation/devicetree/bindings/sound/samsung,tm2-audio.yaml b/Documentation/devicetree/bindings/sound/samsung,tm2-audio.yaml
> >> new file mode 100644
> >> index 000000000000..377f8cbe17b8
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/sound/samsung,tm2-audio.yaml
> >> @@ -0,0 +1,83 @@
> >> +# SPDX-License-Identifier: GPL-2.0
> >> +%YAML 1.2
> >> +---
> >> +$id: https://protect2.fireeye.com/url?k=ccb9abe11b8a2745.ccb820ae-a91cd712f01d248e&u=http://devicetree.org/schemas/sound/samsung,tm2-audio.yaml#
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: Samsung Exynos SoC Exynos5433 TM2(E) audio complex with WM5110 codec
> >> +
> >> +maintainers:
> >> +  - Krzysztof Kozlowski <krzk@kernel.org>
> >> +  - Sylwester Nawrocki <s.nawrocki@samsung.com>
> >> +
> >> +properties:
> >> +  compatible:
> >> +    const: samsung,tm2-audio
> >> +
> >> +  model:
> >> +    maxItems: 1
> > $ref to string, then maxItems are not needed.
> > Add description (copy-paste).
> 
> Hi Krzysztof,
> 
> You're right, model is not a standard property.
> 
> >> +
> >> +  audio-codec:
> >> +    allOf:
> >> +      - $ref: /schemas/types.yaml#/definitions/phandle-array
> >> +      - items:
> >> +          - description: |
> >> +              phandle of the wm5110 audio codec node,
> >> +              as described in ../mfd/arizona.txt;
> >> +          - description: phandle of the HDMI transmitter node.
> >> +
> >> +  i2s-controller:
> >> +    allOf:
> >> +      - $ref: /schemas/types.yaml#/definitions/phandle-array
> >> +      - items:
> >> +          - description: phandle of the I2S0.
> >> +          - description: phandle of the I2S1.
> >> +
> >> +  audio-amplifier:
> > Can you order the nodes here and in required section by name (except
> > compatible which should be first)?
> 
> Current order is already well-established across bindings (even example).
> I think that sorted properties are undesired with that.

OK, good point, so leave the standard properties in order matching
example-bindings. However order the reset because "audio-codec", then
"i2s-controler" and then again "audio-...". So bring some order here.

Best regards,
Krzysztof

