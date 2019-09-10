Return-Path: <SRS0=embV=XF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E412C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 09:52:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E490B206CD
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Sep 2019 09:52:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="ljRKsul0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391458AbfIJJwp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Sep 2019 05:52:45 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34994 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391369AbfIJJwp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Sep 2019 05:52:45 -0400
Received: by mail-lf1-f65.google.com with SMTP id w6so12959042lfl.2
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2019 02:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UCCxiazzNKm8GfRdBMzix7RqbnKVVm8PwfIPcf8Ud9o=;
        b=ljRKsul0mZVE7hjuRdwu0vDFTakT8JFE/2cyerU5FPgdhHWt1rkLc/XVmzFSuCdPyA
         /G3lIV76GIKLQb3bB+uKUlq6zEOJp1/Jn7Bscc2/jQI6vtCMBKWUsj/fmMSyCEd2qNAL
         V1vG8Se1hHXhwDqAbg8s7vDI3Ibg8uD2ZzkbbiS48Sm3gFFKFoG/OpoGBsMLp+jl42NB
         CX+IqlW87dKEJnQTPMd2wc1doUzIXECqEdcQZZhRlbagUPN5NRb3QL2t3CHNXtubY7Qk
         qdl1LrhsmO8b1M0BjYMm7Z3hO+0+IS7IDQImB+80dHHcpeWxrs8aFoFmvgFMCl1SsLZg
         yH/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UCCxiazzNKm8GfRdBMzix7RqbnKVVm8PwfIPcf8Ud9o=;
        b=Gg6WLshm2jpTtwSkBnMocf6Vv6RIRbdU9tTm9EsYuQwbwMA1W1gj5zD1nqlvP776F5
         UsleVncq2KMG43dsCZq3NPe4CRUGw0VMqT+ioPnjMvUJOm1AoWKeq5+xKR0oHDKR4QhI
         8c7JYDDNpc81XdjYgODFMI1fjDU4vB4cmVVv63HdCFfjD6W9aPEVSSJvjGVQK7lkctxw
         45v4cVHL29qnltBYsmsqN0XiafqQ3e7xlKDqecRSzJlLs9805REJYJbUITuHHEakymK/
         K1gmPv2ql1OwF94hQgE0JEqmRkmkXXyWKAKZQYH2ut8aPZhwz8Zd/sOLZWTuoQqCw56w
         uv2w==
X-Gm-Message-State: APjAAAUCb19qhurx474d6ilHtIUGvbhuM11q99rt26GBiSAfy39Ixk/Q
        BHTWAH8uBkdupc8B0ERTyMQD29KqJn63Uo7sJFu7oEPM
X-Google-Smtp-Source: APXvYqx9y3L6l20MO17A9IA6zgodZQShZyGHzkSX5INuMhtqmNR4XtMFHhM2ZZJH9fSmw/HaeCyGmGFqU1WqfGLgg0o=
X-Received: by 2002:a19:770a:: with SMTP id s10mr2194571lfc.30.1568109163186;
 Tue, 10 Sep 2019 02:52:43 -0700 (PDT)
MIME-Version: 1.0
References: <1566379420-26762-1-git-send-email-yash.shah@sifive.com>
In-Reply-To: <1566379420-26762-1-git-send-email-yash.shah@sifive.com>
From:   Yash Shah <yash.shah@sifive.com>
Date:   Tue, 10 Sep 2019 15:22:07 +0530
Message-ID: <CAJ2_jOGO-isv52rnwRusV7jtyCY_JWYWAj9opN3Zg6ZbZr-8-w@mail.gmail.com>
Subject: Re: [PATCH] riscv: dts: Add DT support for SiFive FU540 PWM driver
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Bin Meng <bmeng.cn@gmail.com>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Sachin Ghadi <sachin.ghadi@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Any comments on this patch?

- Yash

On Wed, Aug 21, 2019 at 2:53 PM Yash Shah <yash.shah@sifive.com> wrote:
>
> Add the PWM DT node in SiFive FU540 soc-specific DT file.
> Enable the PWM nodes in HiFive Unleashed board-specific DT file.
>
> Signed-off-by: Yash Shah <yash.shah@sifive.com>
> ---
>  arch/riscv/boot/dts/sifive/fu540-c000.dtsi          | 19 +++++++++++++++++++
>  arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts |  8 ++++++++
>  2 files changed, 27 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/sifive/fu540-c000.dtsi b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
> index 42b5ec2..bb422db 100644
> --- a/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
> +++ b/arch/riscv/boot/dts/sifive/fu540-c000.dtsi
> @@ -230,6 +230,25 @@
>                         #size-cells = <0>;
>                         status = "disabled";
>                 };
> +               pwm0: pwm@10020000 {
> +                       compatible = "sifive,pwm0";
> +                       reg = <0x0 0x10020000 0x0 0x1000>;
> +                       interrupt-parent = <&plic0>;
> +                       interrupts = <42 43 44 45>;
> +                       clocks = <&prci PRCI_CLK_TLCLK>;
> +                       #pwm-cells = <3>;
> +                       status = "disabled";
> +               };
> +               pwm1: pwm@10021000 {
> +                       compatible = "sifive,pwm0";
> +                       reg = <0x0 0x10021000 0x0 0x1000>;
> +                       interrupt-parent = <&plic0>;
> +                       interrupts = <46 47 48 49>;
> +                       reg-names = "control";
> +                       clocks = <&prci PRCI_CLK_TLCLK>;
> +                       #pwm-cells = <3>;
> +                       status = "disabled";
> +               };
>
>         };
>  };
> diff --git a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
> index 93d68cb..104d334 100644
> --- a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
> +++ b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
> @@ -85,3 +85,11 @@
>                 reg = <0>;
>         };
>  };
> +
> +&pwm0 {
> +       status = "okay";
> +};
> +
> +&pwm1 {
> +       status = "okay";
> +};
> --
> 1.9.1
>
