Return-Path: <SRS0=HfRD=XN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E79ABC4CEC4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 13:49:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B221221907
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Sep 2019 13:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1568814588;
	bh=Vsir7F3Rw0yN2oG3BxCXE+fvnqJZovYT8xzQgG4Purk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=LbVNlNtihTpPopTYAiuipWr0OUEhnUWApGl/egZh1k2/f6OMCnK9N6lnRCKAaDUJh
	 ZdkGSvJFTIHBQwcypfhpBxOpUeQ+91tuHiDZUO1X0+xQkhusZY2rYW+JGhMe2ETKJH
	 1glcKmIhOvc64bX3zdYvvDUnc0HqOPkuJBVqoTA0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728925AbfIRNts (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Sep 2019 09:49:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:52340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726659AbfIRNtr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Sep 2019 09:49:47 -0400
Received: from mail-yw1-f47.google.com (mail-yw1-f47.google.com [209.85.161.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF0C321920;
        Wed, 18 Sep 2019 13:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568814585;
        bh=Vsir7F3Rw0yN2oG3BxCXE+fvnqJZovYT8xzQgG4Purk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=MN6zvA84e1GAQzDF8Oc7KorTjwkfX8QhfTlV/yE89YGnvwWTCGc+sZiyx/Cd1wOXW
         88i5Lif6ocTrKz0x4e/qziBndrZ8KfvrmDcYiFeunXLidgzYYY9Y4XgAJgMbrfpLnd
         RywIv4FoZQGnLOZZNn62evPeLTXYCZsAF/6EsZP8=
Received: by mail-yw1-f47.google.com with SMTP id s6so2490039ywe.5;
        Wed, 18 Sep 2019 06:49:45 -0700 (PDT)
X-Gm-Message-State: APjAAAXdAeFYJAy1K/CCI8GZjLjEwtZugQD2I2bo0vymfyDUPEoQNUNE
        ZojVbJtR2VFDJgzXsQPYDOSwd9aG97LZbD0IGA==
X-Google-Smtp-Source: APXvYqyX5J7M/JnrOKuHqti9BK5SCSbzkKBYf8CDlkD0T4RESNs7Vm4Lj+l5V24NuFFkS5g5wceeMPsbDURipVXo9vI=
X-Received: by 2002:a0d:ddc9:: with SMTP id g192mr3041978ywe.281.1568814584947;
 Wed, 18 Sep 2019 06:49:44 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190917120517eucas1p1188d244fac2d10d7990363ff25ffb70d@eucas1p1.samsung.com>
 <20190917111413.22711-1-m.falkowski@samsung.com> <20190917120452.28135-1-m.falkowski@samsung.com>
 <CAL_JsqJmjUR63i_hKUuZwDu42rebwABHu62bQoxTRRJu5yObEA@mail.gmail.com> <40f56f61-a1db-a1a2-262e-1f4c771481e1@samsung.com>
In-Reply-To: <40f56f61-a1db-a1a2-262e-1f4c771481e1@samsung.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 18 Sep 2019 08:49:33 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ=QWk07y=h7dHFiRrKuE7NGoUr50bu3kiOC+YU8qS9jg@mail.gmail.com>
Message-ID: <CAL_JsqJ=QWk07y=h7dHFiRrKuE7NGoUr50bu3kiOC+YU8qS9jg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: sound: Convert Samsung I2S controller
 to dt-schema
To:     Maciej Falkowski <m.falkowski@samsung.com>
Cc:     Linux-ALSA <alsa-devel@alsa-project.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 5:08 AM Maciej Falkowski
<m.falkowski@samsung.com> wrote:
>
>
> On 9/17/19 3:05 PM, Rob Herring wrote:
>
> > On Tue, Sep 17, 2019 at 7:05 AM Maciej Falkowski
> > <m.falkowski@samsung.com> wrote:
> >> Convert Samsung I2S controller to newer dt-schema format.
> >>
> >> Signed-off-by: Maciej Falkowski <m.falkowski@samsung.com>
> >> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> >> ---
> >> v2:
> >> - Added missing Signed-off-by certificate
> >> ---
> >>   .../devicetree/bindings/sound/samsung-i2s.txt |  84 -------------
> >>   .../bindings/sound/samsung-i2s.yaml           | 119 ++++++++++++++++++
> >>   2 files changed, 119 insertions(+), 84 deletions(-)
> >>   delete mode 100644 Documentation/devicetree/bindings/sound/samsung-i2s.txt
> >>   create mode 100644 Documentation/devicetree/bindings/sound/samsung-i2s.yaml
> >> diff --git a/Documentation/devicetree/bindings/sound/samsung-i2s.yaml b/Documentation/devicetree/bindings/sound/samsung-i2s.yaml
> >> new file mode 100644
> >> index 000000000000..59dc76035cb4
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/sound/samsung-i2s.yaml
> >> @@ -0,0 +1,119 @@
> >> +# SPDX-License-Identifier: GPL-2.0
> >> +%YAML 1.2
> >> +---
> >> +$id: http://devicetree.org/schemas/sound/samsung-i2s.yaml#
> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> >> +
> >> +title: Samsung SoC I2S controller
> >> +
> >> +maintainers:
> >> +  - Krzysztof Kozlowski <krzk@kernel.org>
> >> +  - Sangbeom Kim <sbkim73@samsung.com>
> >> +  - Sylwester Nawrocki <s.nawrocki@samsung.com>
> >> +
> >> +properties:
> >> +  compatible:
> >> +    description: |
> >> +      samsung,s3c6410-i2s: for 8/16/24bit stereo I2S.
> >> +
> >> +      samsung,s5pv210-i2s: for 8/16/24bit multichannel(5.1) I2S with
> >> +      secondary fifo, s/w reset control and internal mux for root clk src.
> >> +
> >> +      samsung,exynos5420-i2s: for 8/16/24bit multichannel(5.1) I2S for
> >> +      playback, stereo channel capture, secondary fifo using internal
> >> +      or external dma, s/w reset control, internal mux for root clk src
> >> +      and 7.1 channel TDM support for playback. TDM (Time division multiplexing)
> >> +      is to allow transfer of multiple channel audio data on single data line.
> >> +
> >> +      samsung,exynos7-i2s: with all the available features of exynos5 i2s.
> >> +
> >> +      exynos7 I2S has 7.1 channel TDM support for capture, secondary fifo
> >> +      with only external dma and more no.of root clk sampling frequencies.
> >> +
> >> +      samsung,exynos7-i2s1: I2S1 on previous samsung platforms supports
> >> +      stereo channels. exynos7 i2s1 upgraded to 5.1 multichannel with
> >> +      slightly modified bit offsets.
> >> +    enum:
> >> +      - "samsung,s3c6410-i2s"
> >> +      - "samsung,s5pv210-i2s"
> >> +      - "samsung,exynos5420-i2s"
> >> +      - "samsung,exynos7-i2s"
> >> +      - "samsung,exynos7-i2s1"
> > No need for quotes here.
> >
> >> +
> >> +  reg:
> >> +    maxItems: 1
> >> +
> >> +  dmas:
> >> +    description: list of DMA controller phandle and DMA request line ordered pairs.
> > How many?
>
> Hi Rob,
>
> I have one problem with determining size of dmas.
>
> It seems that there are only two options for dmas: tx, rx or tx, rx, tx-sec.
>
> It looks like minItems should be two and maxItems should be three.
>
> However, some of bindings have different definition of dmas.
>
> When there is:
>
>          dmas = <&pdma0 10
>                  &pdma0 9
>                  &pdma0 8>;
>
> the number of Items for dmas is one,
>
> when there is:
>
>          dmas = <&pdma0 10>,
>                       <&pdma0 9>,
>                       <&pdma0 8>;
>
> the number of Items is three.
>
> Both of these are equal from perspective of dtc,
>
> however from schema point of view, they have different size.
>
>
> What is a proper solution to this kind of problem?

The solution is writing things in the latter form. I have a script to
convert a bunch of these. I need to coordinate doing that at the end
of a merge window.

Rob
