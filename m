Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40186C43218
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 04:53:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FA02208C2
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 04:53:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HpA8pvf+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbfD0ExQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 00:53:16 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35415 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbfD0ExP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 00:53:15 -0400
Received: by mail-pf1-f195.google.com with SMTP id t21so2671369pfh.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2019 21:53:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Ns6N4oFTdZM+vc2GDxUbVsIuCvrsHYW4RATaR20nDKY=;
        b=HpA8pvf+Z8NbejBOUclDkuoGVXLqbljpaOXCqb+IL1mIo1DpAv2WIz4v+z6yHybGOo
         dxoLTcMWER+55jrHQQaKrMqlioFHZZTVir0jHnULCj99pJkcsqty9F5nWdhlD9mi0nTm
         6oRkJ7kL6jF1yNAtPTNPBnSVKCxL2vg6+PbSdPB9T6s0q9ONxo4lajLymdu7WaDnGodk
         tgm6mSLA5aEDEdeG9HcamnIpb03uTaeDbW7JunnonQnDKQP1KK+rUtgmvhwEl7XfUPU8
         9V3RoGak/9/FPbkZnjn7LJ1ekd0xr3EfsSljTo/v0OLxLo+Uo9DfZE+ybR9VnaRq6vJe
         ry1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Ns6N4oFTdZM+vc2GDxUbVsIuCvrsHYW4RATaR20nDKY=;
        b=OCFO853YFc8kV0PH7Q4ZkoIJOl70IOG19L5MBBxgwPu75zTTf59kQJhaXc9oWRtqgh
         sPh96+uwatHkV2FSL9w8b/tb89PQTHkWhh93tbX251sPbRWBSrUXxDKjr+ji8KXGCVuI
         vUj6OqvXuYwflCGCbt6xyoMcG+Su50lJhNj6q4YO9sTJ1LkMbP8NHFeZ3u/Ra+cuUErK
         MG2IJ8z868P2IyZPW5tjtsflxZwNiWKKZg/cKHTGSmxcD8OSH63ejsTTNiXezEKhWX8/
         eu7wMNHaUwqOelhTx6JMm9HwgJdO/lV4iinNPbYrbntfSC+8+RNnLHj+SuiVS+NuGTfq
         kyeA==
X-Gm-Message-State: APjAAAUsPvzEOV9l0jFSo5b/nyqwoJc/Cfjik74hmdxynt/FqtF6SUHO
        a1UTWVT9i1wjaYR3wL4w5f2qrgrv1NY=
X-Google-Smtp-Source: APXvYqwvXlHWylhctGaSGkglhsx3cT0wqx7Rb/pyUh2hz6lOs1jH/oA02MJ+XoVj2zfV2wkG9bc8aA==
X-Received: by 2002:aa7:8c56:: with SMTP id e22mr50488693pfd.155.1556340794829;
        Fri, 26 Apr 2019 21:53:14 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id r11sm34452902pga.87.2019.04.26.21.53.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 21:53:13 -0700 (PDT)
Date:   Fri, 26 Apr 2019 21:53:11 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: qcom: qcs404-evb: fix l3 min voltage
Message-ID: <20190427045311.GF3137@builder>
References: <20190425123402.18167-1-niklas.cassel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190425123402.18167-1-niklas.cassel@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 25 Apr 05:34 PDT 2019, Niklas Cassel wrote:

> The current l3 min voltage level is not supported by
> the regulator (the voltage is not a multiple of the regulator step size),
> so a driver requesting this exact voltage would fail, see discussion in:
> https://patchwork.kernel.org/comment/22461199/
> 
> It was agreed upon to set a min voltage level that is a multiple of the
> regulator step size.
> 
> There was actually a patch sent that did this:
> https://patchwork.kernel.org/patch/10819313/
> 
> However, the commit 331ab98f8c4a ("arm64: dts: qcom: qcs404:
> Fix voltages l3") that was applied is not identical to that patch.
> 
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>

Thanks for spotting and sorting this out, picked up.

Regards,
Bjorn

> ---
>  arch/arm64/boot/dts/qcom/qcs404-evb.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
> index 6910fc663fe1..9a7d930dcd23 100644
> --- a/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qcs404-evb.dtsi
> @@ -118,7 +118,7 @@
>  		};
>  
>  		vreg_l3_1p05: l3 {
> -			regulator-min-microvolt = <1050000>;
> +			regulator-min-microvolt = <1048000>;
>  			regulator-max-microvolt = <1160000>;
>  		};
>  
> -- 
> 2.20.1
> 
