Return-Path: <SRS0=lMFC=TN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EFBDC04AA7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 11:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EED32086A
	for <linux-kernel@archiver.kernel.org>; Mon, 13 May 2019 11:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OhBo05KG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729203AbfEMLBd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 May 2019 07:01:33 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:38135 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727838AbfEMLBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 May 2019 07:01:32 -0400
Received: by mail-vs1-f67.google.com with SMTP id v9so7725973vse.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2019 04:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3laysTfG58br9ekvMftLCflS2bw8W4QgtgThoJczg/k=;
        b=OhBo05KGmUf9v7pWQWG2ym5VzciK3m8PAY7OCLMPlu6ajuOvl8hsdIR4ktGO+tfwZl
         PjR20rgtE7om7EPFacQai80QmP6uZk5pby1EEaVmUXxjTt6Mz7+zzZ5iu8wW80qi5I9o
         foT1oVXlmX9+sq/K74dm7TbFBOxgihNI3wwntlPd2t+8D5fEEMzj8h4LAzIy4n4C8WpB
         Pkk6j/6qoX6yN6HEH/HV3Gq8tAJFDAHkw8W4a4a5qBsCHltyw120WKfvXocYBD+axxPZ
         o6qfEGMerK6xUutpokiJ7Us7JSqUb3okCaB091vvHdYlJhe5MA/L98Zis5GlgN21VfPC
         wEMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3laysTfG58br9ekvMftLCflS2bw8W4QgtgThoJczg/k=;
        b=q58vm2rjd8JOkJEbL6WqYQzklfRimXXlvsWgNaiYP0EjBKV9lu/lglI1KVeYA2TgZf
         pZG5wZDGbh+YY2H9L5eGa/OZFraLoNcurW130qgwNYCC+9C+fI0CSeN3h6j6ja3UjCyi
         Ot2Sjb4JJ+iN61jULy5AwUEn0176BK6b62ZuPqwds9hewbnEtwqveu9o8fCsSdVAQo09
         qiD7X5iIQ/bupaYeZZUepD9YK/QSKOMIjM8jTszNi5MLE2VjsBxXgjAnK2qSgMZV4Oev
         G4utagmdaONRrLR7JFSATKQJOtzfwk4rL4SW8z473h0J1H8ICSpS7X0vgWj/DyYiJe0o
         PsDQ==
X-Gm-Message-State: APjAAAXwSmksrkQYFYFIy/x52j3uTuxa6g5pCVQe/O24kJ52NUq5pi0N
        MaJq+Z6/xY9V3MJEunWauYj/y5ETbA+6/vf5nJhjEg==
X-Google-Smtp-Source: APXvYqwV2DWLvk1wJJw3pvk0vpggagApxSMhez6K6Oy7eHi1sUKyejPrVUYCo8vRQVFz+4/5mCLluau/NDUjAhelBM0=
X-Received: by 2002:a67:f48b:: with SMTP id o11mr4801333vsn.9.1557745291516;
 Mon, 13 May 2019 04:01:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190114184255.258318-1-mka@chromium.org>
In-Reply-To: <20190114184255.258318-1-mka@chromium.org>
From:   Amit Kucheria <amit.kucheria@linaro.org>
Date:   Mon, 13 May 2019 16:31:20 +0530
Message-ID: <CAHLCerP+F9AP97+qVCMqwu-OMJXRhwZrXd33Wk-vj5eyyw-KyA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: sdm845: Add CPU topology
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2019 at 12:13 AM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> The 8 CPU cores of the SDM845 are organized in two clusters of 4 big
> ("gold") and 4 little ("silver") cores. Add a cpu-map node to the DT
> that describes this topology.

This is partly true. There are two groups of gold and silver cores,
but AFAICT they are in a single cluster, not two separate ones. SDM845
is one of the early examples of ARM's Dynamiq architecture.

> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>

I noticed that this patch sneaked through for this merge window but
perhaps we can whip up a quick fix for -rc2?

> ---
>  arch/arm64/boot/dts/qcom/sdm845.dtsi | 38 ++++++++++++++++++++++++++++
>  1 file changed, 38 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> index c27cbd3bcb0a6..f6c0d87e663f3 100644
> --- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
> @@ -192,6 +192,44 @@
>                                 next-level-cache = <&L3_0>;
>                         };
>                 };
> +
> +               cpu-map {
> +                       cluster0 {
> +                               core0 {
> +                                       cpu = <&CPU0>;
> +                               };
> +
> +                               core1 {
> +                                       cpu = <&CPU1>;
> +                               };
> +
> +                               core2 {
> +                                       cpu = <&CPU2>;
> +                               };
> +
> +                               core3 {
> +                                       cpu = <&CPU3>;
> +                               };
> +                       };
> +
> +                       cluster1 {

This shouldn't exist.

> +                               core0 {

Rename to core4, 5, etc...

> +                                       cpu = <&CPU4>;
> +                               };
> +
> +                               core1 {
> +                                       cpu = <&CPU5>;
> +                               };
> +
> +                               core2 {
> +                                       cpu = <&CPU6>;
> +                               };
> +
> +                               core3 {
> +                                       cpu = <&CPU7>;
> +                               };
> +                       };
> +               };
>         };
>
>         pmu {
> --
> 2.20.1.97.g81188d93c3-goog
>
