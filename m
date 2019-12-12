Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B7CC43603
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 07:14:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD43522B48
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 07:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mUXcCxZa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbfLLHO0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 02:14:26 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34233 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728092AbfLLHO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 02:14:26 -0500
Received: by mail-pf1-f196.google.com with SMTP id l127so276882pfl.1
        for <linux-kernel@vger.kernel.org>; Wed, 11 Dec 2019 23:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UM9s++t70j7Y7bhdUOf1V6X/EWBiJPENZLLU9vngZ8U=;
        b=mUXcCxZaCrXhrYZXOXSZZrz7FP6QAzw5h1YlXmxZgFNrPPX6ifBFB07Eyy6fIybNX1
         CeDq2DJ4HAlO/RVBkGXKtEMgXT6k+uRJAbpcUU+RZU/jh36ORpWFS88Eqkw9K2HuijkA
         /kpbPwjWFg/u4OIag4yFbjtlqtgnxzVkqoNPR2NK1AltoT/KlFwoP8lm9VQG3gA9Nz5w
         nfibCRxZh5t846fyCKB2pH6ShdttgGKekh/9YynSpZuftZs+KearB+jZEL/Vb0VStYp8
         aZmUHH9ggbinBZ+OOG1sZYXdSVspE50Fyu77e7HPIs9FZf0CEXAIgaB5lZjtw8eHdetz
         jsJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UM9s++t70j7Y7bhdUOf1V6X/EWBiJPENZLLU9vngZ8U=;
        b=uepkXnSbvTx8xCmdHfjTF4MIv/AFtAiDw+oTmYoKgJijHkRE9Atwt7kMp/BsFcZjQo
         dTh4zFXpMr7Xdnrh3S8sXCYUYWO9lkxyzsxzXlyDn2p5/Lh8yNzgtTzSI1+NGw9KRSvD
         pjViXmwUUZb0BRIz18JQvZc9ApJTFDlUUJFKT79b/i7zVg25EKj25hYpm2oZAJPjECW5
         IwqKWYrK0FN/ryzDBFthSktn6iOGIq9EUY77/vbIznIfVkGqPYqOBS2j2egMMOsfpvLx
         MsducrCGfFJt6Ju8j8KrHCaI7xMpfQM4+C09JRtHTYSEjLifVY18qHkfoeksTQW+0FW8
         SpWw==
X-Gm-Message-State: APjAAAUkYz31E3/8/jqoY7wBVps8tpIUuwNDhzwgK/AG618DEHuU505C
        xirLb2lRcy8aHr8eelmXbm2LTw==
X-Google-Smtp-Source: APXvYqxEhDt6TR1zRqNDj0IsSQyAd5Pugqzryb7zLf+dCbFy9ycoYI7ZMOwvSQuHBNF1O0ExRGyhkg==
X-Received: by 2002:a63:6e0e:: with SMTP id j14mr8713365pgc.361.1576134865659;
        Wed, 11 Dec 2019 23:14:25 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id bo9sm4620133pjb.21.2019.12.11.23.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2019 23:14:24 -0800 (PST)
Date:   Wed, 11 Dec 2019 23:14:22 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Brian Masney <masneyb@onstation.org>
Cc:     robdclark@gmail.com, sean@poorly.run, robh+dt@kernel.org,
        airlied@linux.ie, daniel@ffwll.ch, jcrouse@codeaurora.org,
        dianders@chromium.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: drm/msm/gpu: document second
 interconnect
Message-ID: <20191212071422.GL3143381@builder>
References: <20191122012645.7430-1-masneyb@onstation.org>
 <20191122012645.7430-2-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191122012645.7430-2-masneyb@onstation.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 21 Nov 17:26 PST 2019, Brian Masney wrote:

> Some A3xx and all A4xx Adreno GPUs do not have GMEM inside the GPU core
> and must use the On Chip MEMory (OCMEM) in order to be functional.
> There's a separate interconnect path that needs to be setup to OCMEM.
> Let's document this second interconnect path that's available. Since
> there's now two available interconnects, let's add the
> interconnect-names property.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
>  Documentation/devicetree/bindings/display/msm/gpu.txt | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/msm/gpu.txt b/Documentation/devicetree/bindings/display/msm/gpu.txt
> index 2b8fd26c43b0..3e6cd3f64a78 100644
> --- a/Documentation/devicetree/bindings/display/msm/gpu.txt
> +++ b/Documentation/devicetree/bindings/display/msm/gpu.txt
> @@ -23,7 +23,10 @@ Required properties:
>  - iommus: optional phandle to an adreno iommu instance
>  - operating-points-v2: optional phandle to the OPP operating points
>  - interconnects: optional phandle to an interconnect provider.  See
> -  ../interconnect/interconnect.txt for details.
> +  ../interconnect/interconnect.txt for details. Some A3xx and all A4xx platforms
> +  will have two paths; all others will have one path.
> +- interconnect-names: The names of the interconnect paths that correspond to the
> +  interconnects property. Values must be gfx-mem and ocmem.
>  - qcom,gmu: For GMU attached devices a phandle to the GMU device that will
>    control the power for the GPU. Applicable targets:
>      - qcom,adreno-630.2
> @@ -76,6 +79,7 @@ Example a6xx (with GMU):
>  		operating-points-v2 = <&gpu_opp_table>;
>  
>  		interconnects = <&rsc_hlos MASTER_GFX3D &rsc_hlos SLAVE_EBI1>;
> +		interconnect-names = "gfx-mem";
>  
>  		qcom,gmu = <&gmu>;
>  
> -- 
> 2.21.0
> 
