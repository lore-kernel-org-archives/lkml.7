Return-Path: <SRS0=hRvo=UZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83999C48BD3
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 09:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EF6520645
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Jun 2019 09:09:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jbtXscDh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbfFZJJG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Jun 2019 05:09:06 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:43214 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbfFZJJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jun 2019 05:09:06 -0400
Received: by mail-io1-f66.google.com with SMTP id k20so3344179ios.10
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2019 02:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7dL7h7SkSMLVzpfEmrmJiFGBAxYoaIavJjZPSz0hU7I=;
        b=jbtXscDhjsJEuONxCbh2rlWb09IQnHwk9phiuKReIYqMagEZRqkefxApOqrDgNTjwC
         8cPxCqS0njqZUitqGx7byaBanzWe2tWExVqIf68fiYfH6GgLkeZEwPtnvUm1Lb0sJOQk
         7Whmtox8TN6p53sDlWCs1Oeqo9AMZltPxv5s9W7A8jCwmFqppF8lT+ueiqYTm2ofp54L
         J9pYfCTt5eh2Bbxi/Hb36NchgHNxMaDxlY6CWwQa/LX3TU7ltrsxZOTcb5RPsAUb9y4u
         tX3irBmXchaHy8jhV2/r0EVfAxm5Z2Mk28WUGwx+Qjfvkf7HpEsbuKwE9m+UQeqR9zBN
         MXdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7dL7h7SkSMLVzpfEmrmJiFGBAxYoaIavJjZPSz0hU7I=;
        b=CclyRdb4PxZvVhybxGVfAY/2dvnnxCUyUKkmrjRX+btNE9zpPnE+tDLDsMeJ+uklYo
         AgYJjxbEZ7ErU9A/HuU0nW+rSeQeo+/HFsRsJQhvTnd0rX5K7y3BKuWqSrnlmMOKTUGY
         iUUqOT+2DrXxce5v9lx/zkFt0MjMWaOiwRtToBvMK0AAVWlt8ukb9/Onl8jDVNbmQx+g
         C1yT1xqEV/DSuNcIDqM4BwXosVDfU5WKrVLg9RMivpYCHz/JJdDjjOLfRLfq85kw91F8
         P0nxIsYyVNvei6uhzA/PngR9TFOTmpr2HU5Zpx0iON+Q44WLh9gvTJxxEIQP0T7NNhoL
         snBw==
X-Gm-Message-State: APjAAAXBhzerWVoUYx+oCvsTheX/TuT/yrV/521xxEI5/BsKPPgMYkmH
        q3zjHQbtB8Jd/pj+ucNe4UzCuRFEUf2kT4loIEcLWA==
X-Google-Smtp-Source: APXvYqyfAj3+7X5HQdYqxWCVc+aScPFHv4kHJEc2n+zGiaWOgxDOOyizFKHvtKMZ7FZ6f9dIyrSzDbudAT6xWVQ+DOM=
X-Received: by 2002:a5d:8252:: with SMTP id n18mr2740479ioo.230.1561540145441;
 Wed, 26 Jun 2019 02:09:05 -0700 (PDT)
MIME-Version: 1.0
References: <20190625164733.11091-1-jorge.ramirez-ortiz@linaro.org> <20190625164733.11091-14-jorge.ramirez-ortiz@linaro.org>
In-Reply-To: <20190625164733.11091-14-jorge.ramirez-ortiz@linaro.org>
From:   Niklas Cassel <niklas.cassel@linaro.org>
Date:   Wed, 26 Jun 2019 11:08:54 +0200
Message-ID: <CAHYWTt37Q1E_bggbKb8VdcHRj_YYubqaoVHNN7+1kcr8+XMX0g@mail.gmail.com>
Subject: Re: [PATCH v3 13/14] arm64: dts: qcom: qcs404: Add DVFS support
To:     Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Brown <david.brown@linaro.org>, jassisinghbrar@gmail.com,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Will Deacon <will.deacon@arm.com>, arnd@arndb.de,
        horms+renesas@verge.net.au, heiko@sntech.de,
        Sibi Sankar <sibis@codeaurora.org>,
        enric.balletbo@collabora.com,
        Jagan Teki <jagan@amarulasolutions.com>, olof@lixom.net,
        Vinod Koul <vkoul@kernel.org>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Khasim Syed Mohammed <khasim.mohammed@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I actually think that it makes sense to squash this patch with the
[PATCH v3 10/14] arm64: dts: qcom: qcs404: Add OPP table
patch.

But that might be a personal preference.

Either way, I think this series in ready for the real mailing list.




On Tue, 25 Jun 2019 at 18:48, Jorge Ramirez-Ortiz
<jorge.ramirez-ortiz@linaro.org> wrote:
>
> Support dynamic voltage and frequency scaling on qcs404.
>
> Co-developed-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
> Signed-off-by: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/qcs404.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> index 9569686dbc41..4b4ce0b5df76 100644
> --- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> @@ -34,6 +34,9 @@
>                         enable-method = "psci";
>                         cpu-idle-states = <&CPU_SLEEP_0>;
>                         next-level-cache = <&L2_0>;
> +                       clocks = <&apcs_glb>;
> +                       operating-points-v2 = <&cpu_opp_table>;
> +                       cpu-supply = <&pms405_s3>;
>                 };
>
>                 CPU1: cpu@101 {
> @@ -43,6 +46,9 @@
>                         enable-method = "psci";
>                         cpu-idle-states = <&CPU_SLEEP_0>;
>                         next-level-cache = <&L2_0>;
> +                       clocks = <&apcs_glb>;
> +                       operating-points-v2 = <&cpu_opp_table>;
> +                       cpu-supply = <&pms405_s3>;
>                 };
>
>                 CPU2: cpu@102 {
> @@ -52,6 +58,9 @@
>                         enable-method = "psci";
>                         cpu-idle-states = <&CPU_SLEEP_0>;
>                         next-level-cache = <&L2_0>;
> +                       clocks = <&apcs_glb>;
> +                       operating-points-v2 = <&cpu_opp_table>;
> +                       cpu-supply = <&pms405_s3>;
>                 };
>
>                 CPU3: cpu@103 {
> @@ -61,6 +70,9 @@
>                         enable-method = "psci";
>                         cpu-idle-states = <&CPU_SLEEP_0>;
>                         next-level-cache = <&L2_0>;
> +                       clocks = <&apcs_glb>;
> +                       operating-points-v2 = <&cpu_opp_table>;
> +                       cpu-supply = <&pms405_s3>;
>                 };
>
>                 L2_0: l2-cache {
> --
> 2.21.0
>
