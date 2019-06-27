Return-Path: <SRS0=pEez=U2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D330C48BE7
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 18:13:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D6A92063F
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Jun 2019 18:13:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eNWXsQ0e"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726619AbfF0SNS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Jun 2019 14:13:18 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:41986 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726519AbfF0SNS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jun 2019 14:13:18 -0400
Received: by mail-qk1-f194.google.com with SMTP id b18so2544892qkc.9
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2019 11:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=achxTO4wJS2fcy+fUTW8FntaVv1vHUgFzLLxG1fhXOw=;
        b=eNWXsQ0exTa1bSakdTqOObGEKGnEgDwblZVQJJhMc6tmDj1FOYA3GcFlLKKZEzd1Cz
         PI1/WySjJmmOesMQoLAuP+etojDEqkaHSv6lb+JY73A3B+3a1HiX+heGo1ia1cUK6Z1+
         ptU2jD38bfQFl4WxKH8Zd2QcTi8jQQ0x6t3PeyLMitPC9SFto7PhMElWCdS5MMm4cI/7
         Y637ZXCORBvtnEfNFooPmgcvnnW9dlt59aW86uO0x+Q3Ans2TezNzWkbTN6KH/h3/k7Y
         SO2yFoMWPEHLq70bMYSorYbVTSi1oA9Ju9XuG7+HTQscnd7xxkK4iBbErwrUfwGYXnE+
         Yb+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=achxTO4wJS2fcy+fUTW8FntaVv1vHUgFzLLxG1fhXOw=;
        b=iVwWkI/yufQTy7xRQq3QCg1D54T7JITOm77ldFcG22M5nDNFC3fccyaJeYirjtX/A/
         kB7j25qjt3QLItRHncbme5JjPHmlQKpq3z2BgpY7C6zPTWLk/rj7p/+0lnkeaSvGNaUd
         cefYdi9z7QHcVdctULi/E6982wpUL+6YlK/XPvyJmPfqSm741XPO8VQf+3sP93ls+Tl9
         YXweCNcgxs1ApZykMxyUlKco4toDMNG7dQ/i8NoanVgfa8MJPBFTIc/XMWvfgZIWEY1V
         4+RBiHDJtcF2UUe2belNypw9uSbl7HbdsFItL5JQMT0V3jNBU6h22b0tFYcR7yqLQ4Mn
         ljQA==
X-Gm-Message-State: APjAAAX21cd1lZ6WeaHXXVCoydxzLxKT2aPVJ692YpwS6fi6SpWmvlZd
        VJkLtnuMTeoTF4Bm5ZCK5ahKRAnU5yGdQ9oRVMH7fg==
X-Google-Smtp-Source: APXvYqwy7qrDg0HYHuRZfowIs3mJ0VwSKLbwaN0ySbdrrf99WLvEu5Te/G7yoyWBHxruC9YCspZoJRpGtsabOzFcrXE=
X-Received: by 2002:a05:620a:1285:: with SMTP id w5mr4441274qki.302.1561659197011;
 Thu, 27 Jun 2019 11:13:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190627140215.29353-1-niklas.cassel@linaro.org>
In-Reply-To: <20190627140215.29353-1-niklas.cassel@linaro.org>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Thu, 27 Jun 2019 23:43:05 +0530
Message-ID: <CAP245DVTcQ5DXiSHWud42tOXFXAy7LFkqGsfUDoY0cm+7wQCBA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: qcs404: Add missing space for
 cooling-cells property
To:     Niklas Cassel <niklas.cassel@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 27, 2019 at 7:32 PM Niklas Cassel <niklas.cassel@linaro.org> wrote:
>
> There should be a space both before and after the equal sign.
> Add a missing space for the cooling cells property.
>
> Fixes: f48cee3239a1 ("arm64: dts: qcom: qcs404: Add thermal zones for each sensor")
> Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>

Acked-by: Amit Kucheria <amit.kucheria@linaro.org>

> ---
>  arch/arm64/boot/dts/qcom/qcs404.dtsi | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/qcs404.dtsi b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> index 01a51f381850..3d0789775009 100644
> --- a/arch/arm64/boot/dts/qcom/qcs404.dtsi
> +++ b/arch/arm64/boot/dts/qcom/qcs404.dtsi
> @@ -35,7 +35,7 @@
>                         enable-method = "psci";
>                         cpu-idle-states = <&CPU_SLEEP_0>;
>                         next-level-cache = <&L2_0>;
> -                       #cooling-cells= <2>;
> +                       #cooling-cells = <2>;
>                 };
>
>                 CPU1: cpu@101 {
> @@ -45,7 +45,7 @@
>                         enable-method = "psci";
>                         cpu-idle-states = <&CPU_SLEEP_0>;
>                         next-level-cache = <&L2_0>;
> -                       #cooling-cells= <2>;
> +                       #cooling-cells = <2>;
>                 };
>
>                 CPU2: cpu@102 {
> @@ -55,7 +55,7 @@
>                         enable-method = "psci";
>                         cpu-idle-states = <&CPU_SLEEP_0>;
>                         next-level-cache = <&L2_0>;
> -                       #cooling-cells= <2>;
> +                       #cooling-cells = <2>;
>                 };
>
>                 CPU3: cpu@103 {
> @@ -65,7 +65,7 @@
>                         enable-method = "psci";
>                         cpu-idle-states = <&CPU_SLEEP_0>;
>                         next-level-cache = <&L2_0>;
> -                       #cooling-cells= <2>;
> +                       #cooling-cells = <2>;
>                 };
>
>                 L2_0: l2-cache {
> --
> 2.21.0
>
