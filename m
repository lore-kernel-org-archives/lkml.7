Return-Path: <SRS0=WT+Y=ZE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56734C17441
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 23:17:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3082F2196E
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Nov 2019 23:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNa+J2mY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbfKLXRs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Nov 2019 18:17:48 -0500
Received: from mail-lj1-f171.google.com ([209.85.208.171]:44921 "EHLO
        mail-lj1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbfKLXRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Nov 2019 18:17:47 -0500
Received: by mail-lj1-f171.google.com with SMTP id g3so318076ljl.11;
        Tue, 12 Nov 2019 15:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LIflrWKP50iYK8//oCk2tWTFXozYzLmXIwfV667z38A=;
        b=PNa+J2mYKXMZqAUoDMzX0KUDv3Kyt6nEFoZ2A6dqCsdWHd/+om99vZDSq83XQqCC4M
         LCxzwZWEcdAUqRXZRH2bBQqCt6GLWa5ZGSXmMZRXE8EUs2KPKN5eLRopGkRZG+JzyFav
         dA7WFBfoY1eG6BK8ALXm0CZJxc5IWF3NPTr3FtI8AWd2Xt9sxVIIaOsPiPz6VbYrzeyM
         W6HryYPqgBk4lzubEIp6ESQ8Ph8C1zPvO+qYynxEjLMTW5hPB+WqUfFkxSS8bEbkJns2
         0Y76W3k2caHIlNVNoNkFVMbAvLWG4e3X3n3FWZ0Xs0kyW/HcS5461tqBTaUJFvlFp1rt
         fpCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LIflrWKP50iYK8//oCk2tWTFXozYzLmXIwfV667z38A=;
        b=WldObkJ0ubfOovwg4WKait/hCFmFpTD+Vuc23J25G2DgdeQLq/QfXgE8VbIi6WNzhW
         Ni+q+u8ATTixbrmWWS318q3FcqPHB9GWnN/5YRGsZVg9oYBwv/qEqa+ae54eFVIZftL0
         HJ0zCtFP2MKfU/e+kVbie/fGnz+gBKbrC8uOZm2khrhsY9VX9RctEw+nj51lT8qqkfP1
         6FFg1WjtV/5R/urhQcnGY/tDpkTJOpQx0rPHkbIQV9QYFAIRjBVqW+JXFMstGDBgoUaL
         Ub8Gq2gvbvmAynyHFsVTgVya2s9AdvefWpWOwkpDuUhWzsY+XO6fwXr18p6FtlAgilhn
         r7aQ==
X-Gm-Message-State: APjAAAVogiePfjEHvqNmib3wsIsIiVODEY6t7909gizWVjkFlrgh78lQ
        F15w3XL2q4thH5ae846ls7BGZ6Elo8vUCMshT9s=
X-Google-Smtp-Source: APXvYqyiLn4l/vK/xsmhu6N/3INF3zPy1lwX0qjKsVVRCGKK0WOh5xXLyk9+epm/72hEtkvaBpn8VeB1nb70JN092o4=
X-Received: by 2002:a05:651c:d3:: with SMTP id 19mr197085ljr.202.1573600665005;
 Tue, 12 Nov 2019 15:17:45 -0800 (PST)
MIME-Version: 1.0
References: <1573586526-15007-1-git-send-email-oliver.graute@gmail.com> <1573586526-15007-3-git-send-email-oliver.graute@gmail.com>
In-Reply-To: <1573586526-15007-3-git-send-email-oliver.graute@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 12 Nov 2019 20:17:33 -0300
Message-ID: <CAOMZO5DX_-zSHJjDigK2c=dVLEMxvfd_dFCu=0fbyjht1gsr=A@mail.gmail.com>
Subject: Re: [PATCHv7 2/3] ARM: dts: Add support for i.MX6 UltraLite DART
 Variscite Customboard
To:     Oliver Graute <oliver.graute@gmail.com>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oliver,

On Tue, Nov 12, 2019 at 4:22 PM Oliver Graute <oliver.graute@gmail.com> wrote:

> +&lcdif {
> +       pinctrl-names = "default";
> +       pinctrl-0 = <&pinctrl_lcdif>;
> +       display = <&display0>;
> +       status = "okay";
> +
> +       display0: display0 {
> +               bits-per-pixel = <16>;
> +               bus-width = <24>;
> +
> +               display-timings {
> +                       native-mode = <&timing0>;
> +                       timing0: timing0 {
> +                               clock-frequency =<35000000>;
> +                               hactive = <800>;
> +                               vactive = <480>;
> +                               hfront-porch = <40>;
> +                               hback-porch = <40>;
> +                               hsync-len = <48>;
> +                               vback-porch = <29>;
> +                               vfront-porch = <13>;
> +                               vsync-len = <3>;
> +                               hsync-active = <0>;
> +                               vsync-active = <0>;
> +                               de-active = <1>;
> +                               pixelclk-active = <0>;
> +                       };
> +               };
> +       };
> +};

You are using the deprecated bindings.

Please switch to the DRM bindings as stated at
Documentation/devicetree/bindings/display/mxsfb.txt

You should also add your panel to the simple panel driver.
