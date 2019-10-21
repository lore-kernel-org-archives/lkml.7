Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED7CACA9EB0
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 16:08:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB1D2214AE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 16:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KmpFriVh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729892AbfJUQIC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 12:08:02 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:41861 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729666AbfJUQIC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 12:08:02 -0400
Received: by mail-io1-f65.google.com with SMTP id r144so4720419iod.8;
        Mon, 21 Oct 2019 09:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QoGVt8z7Xqona1SxpdHTyw3J7LGidBEFHR42VoLXFRU=;
        b=KmpFriVhTnDG86I3PIVY7uzgzRy5yfikd7/rJhKkmbBgCaPm4gLz2slAO5cKIIY42E
         lkCegMnUc9yLmebmqGeZ1JzKwJ2IVjk0HBw5rnvqWEHbVYUa+rPnoKqr4vWybDnAjMKO
         v0lkXShVt/n67sMopyAsRw/A9wOUXwZ4Ghovwt9NJXto8fTLOHbd6oNM2jeXq5ACrDCw
         KbZeKbBY2UEa8u4dug26zfSJkkuymjBxHB8aX4P8fjLvj1Zr5UIDfbI40h2x6+F0uo4C
         HqBszL0hl5fflm+3AHi71b2WXVQICuHQ9z9DoVQhCNjg7Pwa3I754JbKsPY2TSQvM19I
         Q3tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QoGVt8z7Xqona1SxpdHTyw3J7LGidBEFHR42VoLXFRU=;
        b=cHgb5+GwWhPDKcmjeH3J03v8C2uoTkOy0V1XAsxKtEtKOvOkYGWYK/DvP/5ESO+x2E
         znCPJsGCVdsPkiKbhkc5KVkR5LgOW/pZ1kgKdnPDyft9jM+i0CRXpRHD+vkE32RLOh94
         v1JziUVYKD01Lz/HmOthIdrQP376vcrG9DHPr9f1wjR2IbDOHbd4lqnNUHJQ3N3g+pmh
         jDXyM4q4mLGvKl/pzufi5zmjCsHitOtn4TWXddoUEaX9Y4XSv3U/8d/z16WqS3UFQEaw
         enLKsP1InlsH7U0Du5NoiNutFh58zKdEKaQGYdSqNW7YWL8IR14lNAfLwhIPzyPo7Lxj
         0DaQ==
X-Gm-Message-State: APjAAAX6XASrJTVUNwVVJtCG5b+NFQPbRJD0aI5epYUCsLyfkRcSNuM8
        /hh4XBF24tUyr2AsDNt8BMxgPGMDqcVybts/rVg3UQ==
X-Google-Smtp-Source: APXvYqwkUZqqEAi78M4CToxxX7LrSOewa0chx6aLK0CEbG9exQ6nzm5udY+EvrqO/8UmQn0n0KKFAHXzewx9LjlwqLQ=
X-Received: by 2002:a5d:8991:: with SMTP id m17mr22588160iol.106.1571674080766;
 Mon, 21 Oct 2019 09:08:00 -0700 (PDT)
MIME-Version: 1.0
References: <20191021151440.13505-1-krzk@kernel.org>
In-Reply-To: <20191021151440.13505-1-krzk@kernel.org>
From:   Alim Akhtar <alim.akhtar@gmail.com>
Date:   Mon, 21 Oct 2019 21:37:24 +0530
Message-ID: <CAGOxZ531SdYcud3nQ-6hbCRZptUYznTRajVyxwEi-mFmm8-zPg@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: exynos: Rename children of SysRAM node to "sram"
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2019 at 8:45 PM Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> The device node name should reflect generic class of a device so rename
> the children of SysRAM node to "smp-sysram".  This will be also in sync
Typo "smp-sram"
> with upcoming DT schema.  No functional change.
>
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
Looks good to me.

>  arch/arm/boot/dts/exynos3250.dtsi               | 4 ++--
>  arch/arm/boot/dts/exynos4210-universal_c210.dts | 6 +++---
>  arch/arm/boot/dts/exynos4210.dtsi               | 4 ++--
>  arch/arm/boot/dts/exynos4412.dtsi               | 4 ++--
>  arch/arm/boot/dts/exynos5250.dtsi               | 4 ++--
>  arch/arm/boot/dts/exynos54xx.dtsi               | 4 ++--
>  6 files changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/arch/arm/boot/dts/exynos3250.dtsi b/arch/arm/boot/dts/exynos3250.dtsi
> index b016b0b68306..044e5da64a76 100644
> --- a/arch/arm/boot/dts/exynos3250.dtsi
> +++ b/arch/arm/boot/dts/exynos3250.dtsi
> @@ -145,12 +145,12 @@
>                         #size-cells = <1>;
>                         ranges = <0 0x02020000 0x40000>;
>
> -                       smp-sysram@0 {
> +                       smp-sram@0 {
>                                 compatible = "samsung,exynos4210-sysram";
>                                 reg = <0x0 0x1000>;
>                         };
>
> -                       smp-sysram@3f000 {
> +                       smp-sram@3f000 {
>                                 compatible = "samsung,exynos4210-sysram-ns";
>                                 reg = <0x3f000 0x1000>;
>                         };
> diff --git a/arch/arm/boot/dts/exynos4210-universal_c210.dts b/arch/arm/boot/dts/exynos4210-universal_c210.dts
> index 09d3d54d09ff..a1bdf7830a87 100644
> --- a/arch/arm/boot/dts/exynos4210-universal_c210.dts
> +++ b/arch/arm/boot/dts/exynos4210-universal_c210.dts
> @@ -590,16 +590,16 @@
>  };
>
>  &sysram {
> -       smp-sysram@0 {
> +       smp-sram@0 {
>                 status = "disabled";
>         };
>
> -       smp-sysram@5000 {
> +       smp-sram@5000 {
>                 compatible = "samsung,exynos4210-sysram";
>                 reg = <0x5000 0x1000>;
>         };
>
> -       smp-sysram@1f000 {
> +       smp-sram@1f000 {
>                 status = "disabled";
>         };
>  };
> diff --git a/arch/arm/boot/dts/exynos4210.dtsi b/arch/arm/boot/dts/exynos4210.dtsi
> index 554819ae1446..b4466232f0c1 100644
> --- a/arch/arm/boot/dts/exynos4210.dtsi
> +++ b/arch/arm/boot/dts/exynos4210.dtsi
> @@ -79,12 +79,12 @@
>                         #size-cells = <1>;
>                         ranges = <0 0x02020000 0x20000>;
>
> -                       smp-sysram@0 {
> +                       smp-sram@0 {
>                                 compatible = "samsung,exynos4210-sysram";
>                                 reg = <0x0 0x1000>;
>                         };
>
> -                       smp-sysram@1f000 {
> +                       smp-sram@1f000 {
>                                 compatible = "samsung,exynos4210-sysram-ns";
>                                 reg = <0x1f000 0x1000>;
>                         };
> diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
> index 5022aa574b26..48868947373e 100644
> --- a/arch/arm/boot/dts/exynos4412.dtsi
> +++ b/arch/arm/boot/dts/exynos4412.dtsi
> @@ -195,12 +195,12 @@
>                         #size-cells = <1>;
>                         ranges = <0 0x02020000 0x40000>;
>
> -                       smp-sysram@0 {
> +                       smp-sram@0 {
>                                 compatible = "samsung,exynos4210-sysram";
>                                 reg = <0x0 0x1000>;
>                         };
>
> -                       smp-sysram@2f000 {
> +                       smp-sram@2f000 {
>                                 compatible = "samsung,exynos4210-sysram-ns";
>                                 reg = <0x2f000 0x1000>;
>                         };
> diff --git a/arch/arm/boot/dts/exynos5250.dtsi b/arch/arm/boot/dts/exynos5250.dtsi
> index e1f0215e3985..ec983283f573 100644
> --- a/arch/arm/boot/dts/exynos5250.dtsi
> +++ b/arch/arm/boot/dts/exynos5250.dtsi
> @@ -171,12 +171,12 @@
>                         #size-cells = <1>;
>                         ranges = <0 0x02020000 0x30000>;
>
> -                       smp-sysram@0 {
> +                       smp-sram@0 {
>                                 compatible = "samsung,exynos4210-sysram";
>                                 reg = <0x0 0x1000>;
>                         };
>
> -                       smp-sysram@2f000 {
> +                       smp-sram@2f000 {
>                                 compatible = "samsung,exynos4210-sysram-ns";
>                                 reg = <0x2f000 0x1000>;
>                         };
> diff --git a/arch/arm/boot/dts/exynos54xx.dtsi b/arch/arm/boot/dts/exynos54xx.dtsi
> index f78dee801cd9..8aa5117e58ce 100644
> --- a/arch/arm/boot/dts/exynos54xx.dtsi
> +++ b/arch/arm/boot/dts/exynos54xx.dtsi
> @@ -62,12 +62,12 @@
>                         #size-cells = <1>;
>                         ranges = <0 0x02020000 0x54000>;
>
> -                       smp-sysram@0 {
> +                       smp-sram@0 {
>                                 compatible = "samsung,exynos4210-sysram";
>                                 reg = <0x0 0x1000>;
>                         };
>
> -                       smp-sysram@53000 {
> +                       smp-sram@53000 {
>                                 compatible = "samsung,exynos4210-sysram-ns";
>                                 reg = <0x53000 0x1000>;
>                         };
> --
> 2.17.1
>


-- 
Regards,
Alim
