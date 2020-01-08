Return-Path: <SRS0=XcGb=25=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6634FC33C9B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 04:57:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3BDE82073D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jan 2020 04:57:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="engY/nBd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbgAHE5x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jan 2020 23:57:53 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:36453 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbgAHE5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jan 2020 23:57:52 -0500
Received: by mail-pj1-f67.google.com with SMTP id n59so538873pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jan 2020 20:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=7N4CATf1B3tWrcIqA0lc8Bs8r5BQEFhVHByDqIRWZkg=;
        b=engY/nBde/VG8iDXNQFdCygeBfI1kKcPbMY/gCLX4UarB1FIWNVeDf6EhhNc3xDyzu
         aYDHKmbHMAxuf/+24HsS0vDPiAWKopjjkDHJqg0mzWvUV05nkRozpxSX2Ho25cBfG8aS
         7ltmZSN54dLw546fKzpFLyc2f+tccLrNqQiOZnJbtXOu7v0ROQTDtO/wuHpT5syhGs3p
         Wo5asKTItDxZGD/WtLMtFF4Pbszpp8AEr6Piu3tk7NS5s42qvoVZImt8i2sLtxMo56gB
         Hoei9n+xsalTTowM80VxASgRJHrSrf1hF/U2Dt1xWATc/N0eBuuLA9j0Tnt5mrXEiR/z
         UBcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=7N4CATf1B3tWrcIqA0lc8Bs8r5BQEFhVHByDqIRWZkg=;
        b=WNpRYSrW67bG9X7/RyS62YO219SkZH7J6JIXubm0XiJYdHZ4km1A4MpBelH3miuy8s
         fhk8q060wfyuPTf9+tUjudY7sLW2AF6M1vRfe0bK8qCAsDMColE4nBQbCgk1kSPgcVUS
         /RnHbwrJqp98e6TEKdDQ0mAmwtqFRSYFXefga0xP3So+PuvtPGD9L9DG0F3aqIE9Wltz
         xsl+dVc80rJr/PhIiQuj3HH4SxPPF5uQC5nYpKOsLr4UUca6+RrhhaVq4nVrXcS1DwVU
         DijEBy64j1sp4TYRgviTPsxxDnyeRSUGCZmCMnXhTzBZAqDJl+rdN5e4zsxThNy0hhiv
         cqXg==
X-Gm-Message-State: APjAAAXvwailDGcYbC4894kCkWd+SengeQamUbxvEG82NbMZ/AiEdCKU
        HH0AJmEaNg6rTnwJynV9uXDgKA==
X-Google-Smtp-Source: APXvYqyNiIMntmUkLSiqTU3rALo/9w7vTQWMfUF1QMT6CqT2wsMNuZvBjRLDUfmYn8Nuk2kqpZTSqQ==
X-Received: by 2002:a17:90b:4383:: with SMTP id in3mr2230799pjb.111.1578459472091;
        Tue, 07 Jan 2020 20:57:52 -0800 (PST)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id r62sm1418357pfc.89.2020.01.07.20.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 20:57:51 -0800 (PST)
Date:   Tue, 7 Jan 2020 20:57:48 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Jordan Crouse <jcrouse@codeaurora.org>,
        Sharat Masetty <smasetty@codeaurora.org>,
        Rob Clark <robdclark@chromium.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] dt-bindings: drm/msm/gpu: Document firmware-name
Message-ID: <20200108045748.GI738324@yoga>
References: <20200108013847.899170-1-robdclark@gmail.com>
 <20200108013847.899170-3-robdclark@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200108013847.899170-3-robdclark@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 07 Jan 17:38 PST 2020, Rob Clark wrote:

> From: Rob Clark <robdclark@chromium.org>
> 
> The firmware-name property in the zap node can be used to specify a
> device specific zap firmware.
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
>  Documentation/devicetree/bindings/display/msm/gpu.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/gpu.txt b/Documentation/devicetree/bindings/display/msm/gpu.txt
> index 3e6cd3f64a78..7edc298a15f2 100644
> --- a/Documentation/devicetree/bindings/display/msm/gpu.txt
> +++ b/Documentation/devicetree/bindings/display/msm/gpu.txt
> @@ -33,6 +33,8 @@ Required properties:
>  - zap-shader: For a5xx and a6xx devices this node contains a memory-region that
>    points to reserved memory to store the zap shader that can be used to help
>    bring the GPU out of secure mode.
> +- firmware-name: optional property of the 'zap-shader' node, listing the
> +  relative path of the device specific zap firmware.
>  
>  Example 3xx/4xx/a5xx:
>  
> @@ -85,6 +87,7 @@ Example a6xx (with GMU):
>  
>  		zap-shader {
>  			memory-region = <&zap_shader_region>;
> +			firmware-name = "qcom/LENOVO/81JL/qcdxkmsuc850.mbn"
>  		};
>  	};
>  };
> -- 
> 2.24.1
> 
