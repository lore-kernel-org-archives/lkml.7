Return-Path: <SRS0=AMXA=TQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 108CDC04AAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 17:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA2EC2070D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 May 2019 17:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="AIRBhrVh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbfEPRk5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 13:40:57 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:41517 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727036AbfEPRk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 13:40:56 -0400
Received: by mail-ua1-f67.google.com with SMTP id s30so1607431uas.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 10:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dgE84Psb/U3etWxpJVt5b8VqKHdbZZrtGPq4Io8QnvM=;
        b=AIRBhrVhFgw7bH2pwHcH9I6R1AqBcsTlPNnNcXJpBf/pEYgcBTvHtbbQvYiD0GdjC3
         Vcii/zl8/NPtJhsrz/3lINqpDAb6oedjkKAJK8LzPcY1+uUm6aNi4S9Dtla3/QabW+ws
         yU6hWLGod2ZBeAEJzafr03Uc6WR2SvzI45sUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dgE84Psb/U3etWxpJVt5b8VqKHdbZZrtGPq4Io8QnvM=;
        b=TrZEtmKSzwpjilYEBLWjeSzT16sMGoQI/SaK7bUpbQnLmjSJ9ATNH8ewZJeVd52/pI
         YcUeI62Hj9Zzv8LL3nkoj4VGrPa85TzNMB95I5dvZc1VWUjn8lX7c1Bw8wVhHZlNsxJe
         Kp7DXoGkqnD4bsm8PJoctM8aoTWDkYGJfLymkJR0OTJGzPJhzrnwVFeiLWwebPTZpTj1
         AAZN3tTyBEr+iuIop+Ioc/gQoy0w+maDfNXPHvWMZR3dvCUEHVRb4PhQ+hEoquw0EVk8
         oBv/tC8Ei6leJHVD+MS9J+nVf+512Mjaj4Pd0d6AKUsQoECu20stHjUpCKL7OqtWSAhr
         2aIg==
X-Gm-Message-State: APjAAAV9VyX5HM0vfYP/QPKGpbHEX7ehCqeOu0+BZBfj7fblpswkd3MY
        weD2OKVZ7Rw8+Hy5afMcdqGt1Jxal0Q=
X-Google-Smtp-Source: APXvYqznyA6hjHDzFpc1XwJ5nCCgkWxHqrKn94l/G1MfdbekqdEqeQGkW7b2F8Lolq6mMM8F++xkfQ==
X-Received: by 2002:ab0:115a:: with SMTP id g26mr24225017uac.84.1558028455617;
        Thu, 16 May 2019 10:40:55 -0700 (PDT)
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com. [209.85.217.45])
        by smtp.gmail.com with ESMTPSA id t189sm3023775vke.31.2019.05.16.10.40.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 May 2019 10:40:54 -0700 (PDT)
Received: by mail-vs1-f45.google.com with SMTP id x184so1841245vsb.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 May 2019 10:40:53 -0700 (PDT)
X-Received: by 2002:a67:1cc2:: with SMTP id c185mr1516432vsc.20.1558028453360;
 Thu, 16 May 2019 10:40:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190516172510.181473-1-mka@chromium.org>
In-Reply-To: <20190516172510.181473-1-mka@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 16 May 2019 10:40:38 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UQcv1+HC2eAk2ctBofufCi9-VvWc+OnY0mtBw3L-YG+Q@mail.gmail.com>
Message-ID: <CAD=FV=UQcv1+HC2eAk2ctBofufCi9-VvWc+OnY0mtBw3L-YG+Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: gpu: add #cooling-cells property to
 the ARM Mali Midgard GPU binding
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        devicetree@vger.kernel.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kevin Hilman <khilman@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, May 16, 2019 at 10:25 AM Matthias Kaehlcke <mka@chromium.org> wrote:

> The GPU can be used as a thermal cooling device, add an optional
> '#cooling-cells' property.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
> Changes in v2:
> - patch added to the series
> ---
>  Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
> index 18a2cde2e5f3..61fd41a20f99 100644
> --- a/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
> +++ b/Documentation/devicetree/bindings/gpu/arm,mali-midgard.txt
> @@ -37,6 +37,8 @@ Optional properties:
>  - operating-points-v2 : Refer to Documentation/devicetree/bindings/opp/opp.txt
>    for details.
>
> +- #cooling-cells: Refer to Documentation/devicetree/bindings/thermal/thermal.txt
> +  for details.
>
>  Example for a Mali-T760:
>
> @@ -51,6 +53,7 @@ gpu@ffa30000 {
>         mali-supply = <&vdd_gpu>;
>         operating-points-v2 = <&gpu_opp_table>;
>         power-domains = <&power RK3288_PD_GPU>;
> +       #cooling-cells = <2>;
>  };

You will conflict with d5ff1adb3809 ("dt-bindings: gpu: mali-midgard:
Add resets property"), but it's easy to rebase.  I'll leave it to
whoever is going to land this to decide if they would like you to
re-post or if they can handle resolving the conflict themselves.
+Kevin who appears to be the one who landed the conflicting commit.

With that:

Reviewed-by: Douglas Anderson <dianders@chromium.org>
