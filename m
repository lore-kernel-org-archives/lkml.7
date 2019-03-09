Return-Path: <SRS0=x0+x=RM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47817C10F0C
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 00:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1252E20857
	for <linux-kernel@archiver.kernel.org>; Sat,  9 Mar 2019 00:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552091038;
	bh=n/JIxP5EjXTbE6AftsS936qkRdKHn9xUYcmdVlCy+NM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=1FlnpaEDvyf6/wWc8oZlC6A/W7YlptHQgzVqxSoiisMS4N4Kznc9UpObLa/o+5Dwk
	 y7rPQiGUsc2xv8YC2oylbc8PuEYXJEkzdDkT9b/UQPU4OcjNtPwUmCcib5BFolu0Ze
	 1bhe2ijvga65R0uZWGzaOdY0VcEp3cWMMZW8WHAs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbfCIAX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Mar 2019 19:23:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:58472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbfCIAX4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Mar 2019 19:23:56 -0500
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13B542086A;
        Sat,  9 Mar 2019 00:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552091035;
        bh=n/JIxP5EjXTbE6AftsS936qkRdKHn9xUYcmdVlCy+NM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AgrS66BuN6zXq6EiJYQr1GyyWEP3WoukrdmVL++6PfdR8eA1EQjweOUJNoG260rhj
         WJj9Fm3vNOdjMegHBWA1wPXpYCJfib5+dz31zAxls5jA7t8q/tjPQqef2Rjcuz+nFE
         cZG/nCrbY3Wm9Ty78o38ScTF9OZlfP8dzWO5rBto=
Received: by mail-qk1-f170.google.com with SMTP id y140so12246801qkb.9;
        Fri, 08 Mar 2019 16:23:55 -0800 (PST)
X-Gm-Message-State: APjAAAX3y5QJoqN4RhwKEnxBxo80ZL1wzaSdB5kEdJUJZZlMZ2lcr6rI
        I1xif31BMcOLW0XjIIE2hHUd0FtWjukvxNkwrQ==
X-Google-Smtp-Source: APXvYqz8Ly0D8oSMcFgkwyNWRuCChEPqCHPGuRoW0+DuNoY747Hez9qeI7cB3bUf2u3GyGmGdKorQ0dNf6AF3m57ex4=
X-Received: by 2002:a05:620a:123b:: with SMTP id v27mr15253215qkj.29.1552091034224;
 Fri, 08 Mar 2019 16:23:54 -0800 (PST)
MIME-Version: 1.0
References: <20190228220756.20262-1-paul@crapouillou.net> <20190228220756.20262-2-paul@crapouillou.net>
In-Reply-To: <20190228220756.20262-2-paul@crapouillou.net>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 8 Mar 2019 18:23:43 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJNBdV=bN7hnXDB=MjL1OnUnxEgC=bRzb9sCE-F_MX-zQ@mail.gmail.com>
Message-ID: <CAL_JsqJNBdV=bN7hnXDB=MjL1OnUnxEgC=bRzb9sCE-F_MX-zQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: Add doc for the ingenic-drm driver
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org, linux-mips@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 28, 2019 at 4:08 PM Paul Cercueil <paul@crapouillou.net> wrote:
>
> Add documentation for the devicetree bindings of the DRM driver for the
> JZ47xx family of SoCs from Ingenic.
>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> Tested-by: Artur Rojek <contact@artur-rojek.eu>
> ---
>  .../devicetree/bindings/display/ingenic,drm.txt    | 30 ++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/ingenic,drm.txt
>
> diff --git a/Documentation/devicetree/bindings/display/ingenic,drm.txt b/Documentation/devicetree/bindings/display/ingenic,drm.txt
> new file mode 100644
> index 000000000000..52a368ec35cd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/ingenic,drm.txt
> @@ -0,0 +1,30 @@
> +Ingenic JZ47xx DRM driver
> +
> +Required properties:
> +- compatible: one of:
> +  * ingenic,jz4740-drm
> +  * ingenic,jz4725b-drm

DRM is a kernel thing. What's the h/w called?

> +- reg: LCD registers location and length
> +- clocks: LCD pixclock and device clock specifiers.
> +          The device clock is only required on the JZ4740.
> +- clock-names: "lcd_pclk" and "lcd"
> +- interrupts: Specifies the interrupt line the LCD controller is connected to.
> +
> +Optional properties:
> +- ingenic,panel: phandle to a display panel, if one is present

Use the graph binding or a child node. See other bindings.

> +- ingenic,lcd-mode: LCD mode to use with the display panel.
> +                   See <dt-bindings/display/ingenic,drm.h> for all the
> +                   possible values.
> +
> +Example:
> +
> +lcd: lcd-controller@13050000 {
> +       compatible = "ingenic,jz4725b-drm";
> +       reg = <0x13050000 0x1000>;
> +
> +       interrupt-parent = <&intc>;
> +       interrupts = <31>;
> +
> +       clocks = <&cgu JZ4725B_CLK_LCD>;
> +       clock-names = "lcd";
> +};
> --
> 2.11.0
>
