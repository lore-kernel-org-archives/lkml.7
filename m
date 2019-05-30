Return-Path: <SRS0=Dgga=T6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A97C28CC0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 00:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 65D6F243AB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 May 2019 00:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="nW0+RjTg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbfE3AeU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 May 2019 20:34:20 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:33696 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbfE3AeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 May 2019 20:34:20 -0400
Received: by mail-qk1-f195.google.com with SMTP id p18so2795819qkk.0;
        Wed, 29 May 2019 17:34:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KHD+sHVUPLQmygDU5dgl8aDe2PTeVVrxe8ejiYsJbzA=;
        b=nW0+RjTgr112JeSC0qx2gUZmFr6cGCDqdl+BpCHWqJuE+d78Bs5iJJebC6syz05H1g
         APITCHaqFOtnhiPTw51uDWFk0zRdcaug6U0SqwHUL+FX62RpIXyMwquSehD4D9wCa9Nz
         DjkgdB2ypi/hj1qa/QKZLnb8qvc1wkMBkifao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KHD+sHVUPLQmygDU5dgl8aDe2PTeVVrxe8ejiYsJbzA=;
        b=PSozzJ5MylixD74xAziq2vnYErIjyjlFPOeJRj+qEWtVcGEkWDo+JKoN8WZThX5Dw7
         xb/Vc6oY3DjOT5hvQBIbeNXLsnTNfr78w1lYDWKTy3yHYbFW/n25Lx+ABuQXx5hTPUZ6
         bMHK7+skthwO/JKcLRD6Jov8iJKc6L9EZFM6llifQZixo5W6A4B6kBtp0m0mxtO9TTiU
         q95eH9PfyMR8DSP9U3ahoRG/7IKyyNtud7ILDGSXYHqD61LT2tpZLuLkdmLeBj9E66Aj
         TnXoyALnWsgam0NCTsmfWGGclrbnvfQqwBvD0Ww/+7Pdo2/CPNAofJTzA6Eovb1+w9r5
         RxMg==
X-Gm-Message-State: APjAAAUPR9RH5raicE9cF1iie/t13w24IdRjHdQ97DIGrxjVVkPDAepr
        l8WKP+ibJHltRQ4JMtasuanUUlAfIYRw6VxQ4Og=
X-Google-Smtp-Source: APXvYqxYyCeKyYUztJa3DHENKeZigts1pQtuupR+90lPSZNjZI5bKFuOpg4mU0O5bqKNHFmvb0879Dook4z1MhjB/qo=
X-Received: by 2002:a37:a10b:: with SMTP id k11mr713236qke.76.1559176459320;
 Wed, 29 May 2019 17:34:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190527112753.1681-1-a.filippov@yadro.com>
In-Reply-To: <20190527112753.1681-1-a.filippov@yadro.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Thu, 30 May 2019 00:34:04 +0000
Message-ID: <CACPK8XeXh8uiQ6f5LWJRBJ=VwMAvdPHOo34uHhWZyMFBG2HVqw@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: aspeed: g4: add video engine support
To:     Alexander Filippov <a.filippov@yadro.com>
Cc:     linux-aspeed@lists.ozlabs.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,

On Mon, 27 May 2019 at 11:28, Alexander Filippov <a.filippov@yadro.com> wrote:
>
> Add a node to describe the video engine and VGA scratch registers on
> AST2400.

The scratch registers are unrelated to the video engine. As Andrew
pointed out, the bindings are not upstream either.

Can you re-spin this patch wit just the video engine changes?

We also need a platform to enable and test this on. Can you submit the
device tree for your system?

>
> These changes were copied from aspeed-g5.dtsi
>
> Signed-off-by: Alexander Filippov <a.filippov@yadro.com>
> ---
>  arch/arm/boot/dts/aspeed-g4.dtsi | 62 ++++++++++++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
>
> diff --git a/arch/arm/boot/dts/aspeed-g4.dtsi b/arch/arm/boot/dts/aspeed-g4.dtsi
> index 6011692df15a..adc1804918df 100644
> --- a/arch/arm/boot/dts/aspeed-g4.dtsi
> +++ b/arch/arm/boot/dts/aspeed-g4.dtsi
> @@ -168,6 +168,10 @@
>                                         compatible = "aspeed,g4-pinctrl";
>                                 };
>
> +                               vga_scratch: scratch {
> +                                       compatible = "aspeed,bmc-misc";
> +                               };
> +
>                                 p2a: p2a-control {
>                                         compatible = "aspeed,ast2400-p2a-ctrl";
>                                         status = "disabled";
> @@ -195,6 +199,16 @@
>                                 reg = <0x1e720000 0x8000>;      // 32K
>                         };
>
> +                       video: video@1e700000 {
> +                               compatible = "aspeed,ast2400-video-engine";
> +                               reg = <0x1e700000 0x1000>;
> +                               clocks = <&syscon ASPEED_CLK_GATE_VCLK>,
> +                                        <&syscon ASPEED_CLK_GATE_ECLK>;
> +                               clock-names = "vclk", "eclk";
> +                               interrupts = <7>;
> +                               status = "disabled";
> +                       };
> +
>                         gpio: gpio@1e780000 {
>                                 #gpio-cells = <2>;
>                                 gpio-controller;
> @@ -1408,6 +1422,54 @@
>         };
>  };
>
> +&vga_scratch {
> +       dac_mux {
> +               offset = <0x2c>;
> +               bit-mask = <0x3>;
> +               bit-shift = <16>;
> +       };
> +       vga0 {
> +               offset = <0x50>;
> +               bit-mask = <0xffffffff>;
> +               bit-shift = <0>;
> +       };
> +       vga1 {
> +               offset = <0x54>;
> +               bit-mask = <0xffffffff>;
> +               bit-shift = <0>;
> +       };
> +       vga2 {
> +               offset = <0x58>;
> +               bit-mask = <0xffffffff>;
> +               bit-shift = <0>;
> +       };
> +       vga3 {
> +               offset = <0x5c>;
> +               bit-mask = <0xffffffff>;
> +               bit-shift = <0>;
> +       };
> +       vga4 {
> +               offset = <0x60>;
> +               bit-mask = <0xffffffff>;
> +               bit-shift = <0>;
> +       };
> +       vga5 {
> +               offset = <0x64>;
> +               bit-mask = <0xffffffff>;
> +               bit-shift = <0>;
> +       };
> +       vga6 {
> +               offset = <0x68>;
> +               bit-mask = <0xffffffff>;
> +               bit-shift = <0>;
> +       };
> +       vga7 {
> +               offset = <0x6c>;
> +               bit-mask = <0xffffffff>;
> +               bit-shift = <0>;
> +       };
> +};
> +
>  &sio_regs {
>         sio_2b {
>                 offset = <0xf0>;
> --
> 2.20.1
>
