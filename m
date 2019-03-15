Return-Path: <SRS0=8sqo=RS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02342C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 21:32:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BCD5221900
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Mar 2019 21:32:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="XTsdu9Rv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfCOVcC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Mar 2019 17:32:02 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45926 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725959AbfCOVcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Mar 2019 17:32:01 -0400
Received: by mail-oi1-f195.google.com with SMTP id t82so8504712oie.12
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2019 14:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vgIyXXh0AbPxY3aqPaHCt/0y+Ix/xUe/YJtc3n1dDQs=;
        b=XTsdu9RvM2RAhiwntyzJcgc44qeM1gIaAHFAkuneiln53cE0T5u/BCaxlDoDoVza2x
         FyUwhM++1HORaxYPgLePdpnJI8ZYH1tIHzBNI/y1LJBFT8rQKbvqJKJGb7YqbBxOdQgH
         dhBx/3D5Tq4Mn3Im+473oPLHsWxuiJ6ia++y3RpTp0YfpELry0qq29d3PvzLWJ9zGb/s
         8HYy8TsIC3/ENzF7TO7ImxEMFSD3IKN5fd2KydNT9XrTUfycNOCGXV2o5m18vKvIkqry
         jUPZJXZjsENjRHMGAYUCLkpdybSu1hFwgBp75oB0lVcIBM3dhBs2Y/e7H6EzHX4F0bLo
         EZSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vgIyXXh0AbPxY3aqPaHCt/0y+Ix/xUe/YJtc3n1dDQs=;
        b=Apr52FP34sAot04X/k9Jjv/9Qm2XqPevu2DtPjqkujiAp025UznxyfXZskwkRJy0TW
         ZiXDsv/ErpCjpg9WH6MTBwdYxHQaj2BtUuv5MlO2xxzapftFi+PUxAZIZ1Ysic1Lye7F
         5B5Y20I4J0Nzrbk2mZY0Ex0v+pWd/Qeb4OiH0bfoK/4vF5F4sadG1FWfC3Rpd3fVJ4UI
         sStCzk1E8eyVxT9Fw6X8RS5TLohq0f8iGKZsoW0rooVabi+zbHKCfoOwFyrYL1AYcloH
         dcKBKDqYwB7MMCLWoHwPPY7pGQghU/2nf4RZK55h6Atu2up1cusdJIHVxvPpH+IpGwu4
         Z0Zw==
X-Gm-Message-State: APjAAAUVOsZTizChw6mRO9gk25uoBX0j4iNTNkeAab4v9EWdg6zPKPby
        4o7Ym11vuxKs173UlIsrkxzlSmYFSMTmIB6AXvE=
X-Google-Smtp-Source: APXvYqyszEfJBHzwK5qe8qdz20ry7K2TkwgSFK5kthzvHiXd8RYAQKAjxJAUf+63RHKgwze5mJfojjuwCZreXBOBhTs=
X-Received: by 2002:aca:4808:: with SMTP id v8mr2936092oia.129.1552685520745;
 Fri, 15 Mar 2019 14:32:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190307151342.7381-1-narmstrong@baylibre.com> <20190307151342.7381-6-narmstrong@baylibre.com>
In-Reply-To: <20190307151342.7381-6-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 15 Mar 2019 22:31:49 +0100
Message-ID: <CAFBinCBt290Qabw98SpiON3xG0ihMEDNzwDDTrBo6QYbA5QjMQ@mail.gmail.com>
Subject: Re: [PATCH 5/9] arm64: dts: meson: g12a: add reset controller
To:     Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>
Cc:     khilman@baylibre.com, linux-amlogic@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil and Jerome,

On Thu, Mar 7, 2019 at 4:14 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
>
> From: Jerome Brunet <jbrunet@baylibre.com>
>
> Add the reset controller device of g12a SoC family
>
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>  arch/arm64/boot/dts/amlogic/meson-g12a.dtsi | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
> index f8f055c49f9a..2a700bb45d04 100644
> --- a/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
> +++ b/arch/arm64/boot/dts/amlogic/meson-g12a.dtsi
> @@ -245,6 +245,13 @@
>                         #size-cells = <2>;
>                         ranges = <0x0 0x0 0x0 0xffd00000 0x0 0x100000>;
>
> +                       reset: reset-controller@1004 {
> +                               compatible = "amlogic,meson-g12a-reset",
> +                                            "amlogic,meson-axg-reset";
> +                               reg = <0x0 0x1004 0x0 0x9c>;
> +                               #reset-cells = <1>;
> +                       };
I tried to compare this with what is publicly available in
buildroot_openlinux_kernel_4.9_fbdev_20180706 - unfortunately this is
harder than I thought:
the buildroot kernel doesn't define the reset controller in mesong12a.dtsi

so I tried to follow the code in the HDMITX driver instead:
kernel/aml-4.9/drivers/amlogic/media/vout/hdmitx/hdmi_tx_20/hw/hw_txlx.c
uses P_RESET0_REGISTER and P_RESET2_REGISTER
these are defined in
kernel/aml-4.9/drivers/amlogic/media/vout/hdmitx/hdmi_tx_20/hw/txlx_reg.h
using:
> #define RESET_CBUS_REG_IDX 5
> #define BASE_REG_OFFSET 24
> #define RESET_CBUS_REG_ADDR(reg) \
>    ((RESET_CBUS_REG_IDX << BASE_REG_OFFSET) + (reg << 2))
>
> #define RESET0_REGISTER 0x01
> #define P_RESET0_REGISTER RESET_CBUS_REG_ADDR(RESET0_REGISTER)

when I do the maths:
(5 << 24) + (0x01 << 2) = 0x5000004

The GX SoCs have the reset controller at cbus + 0x4404
however, the offset may have changed in G12A because the SAR ADC
offset also changed (just one example).

Do you have any hint how to verify the CBUS offset (0x1004) of the
reset controller?


Regards
Martin
