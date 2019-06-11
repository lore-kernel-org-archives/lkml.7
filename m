Return-Path: <SRS0=TvG7=UK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B441C4321A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 15:25:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14A0521726
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Jun 2019 15:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1560266752;
	bh=d/VaFO2GopJ/soJKDMYISKQ69HFRcP7EG77tPBICDJk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=WrrlWCYqwCmbaDoRwiT+SyzHGxXwC8X6nWqj4FEcrR1WPLHxUP6X/QJCMH3W3uI1p
	 UObLjjKU6yqB/D6xD2EzuJDGIy5XYCn+S86JNTfokSZtCWn6P/R+6u4wJBOGZ+El8u
	 Bjyuk5FY60B6RvwilaP6Xfg8HuwOs2wYAu/i19as=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404940AbfFKPZv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Jun 2019 11:25:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:57090 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404914AbfFKPZv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jun 2019 11:25:51 -0400
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 096C12175B;
        Tue, 11 Jun 2019 15:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560266750;
        bh=d/VaFO2GopJ/soJKDMYISKQ69HFRcP7EG77tPBICDJk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CdshHLDgJ7Z/1d5LTs2sVuwWCODL2x/qXUFAMEQPKZm794Tm7ad0pFwve7BIfoo62
         4WDI7usTGjFy11bRMh+JpMTO5ZOpdW4p4qrqu8N+4vInTl3LBXaRd+8FMIxGt33wcR
         dracVjyhFWQwwtHdPHeCNubvSPz6pWMOO7QqSbIQ=
Received: by mail-qt1-f173.google.com with SMTP id x2so14119711qtr.0;
        Tue, 11 Jun 2019 08:25:49 -0700 (PDT)
X-Gm-Message-State: APjAAAUt1VyCPDS7csClK3rBa+ptPGd0IZFSzOGVilRwnQCh22/ntpa7
        mt/Nneh4KOfFyyPreX3VBEZRhmKqnI6nqpvKCw==
X-Google-Smtp-Source: APXvYqzPjuRg7gzez7BpTEniSzx8damxLOxBNc/30j7Wqsby4Sg0SN/ftQhCVmvj52vSz6sLfP6GnUjon1dfQkvHQ3o=
X-Received: by 2002:a05:6214:248:: with SMTP id k8mr29740285qvt.200.1560266749174;
 Tue, 11 Jun 2019 08:25:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190611040350.90064-1-dbasehore@chromium.org> <20190611040350.90064-3-dbasehore@chromium.org>
In-Reply-To: <20190611040350.90064-3-dbasehore@chromium.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 11 Jun 2019 09:25:37 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLM1CikZ8+NPjLk2CEW-z9vPynZpVG20x0jsa7hVq0LvA@mail.gmail.com>
Message-ID: <CAL_JsqLM1CikZ8+NPjLk2CEW-z9vPynZpVG20x0jsa7hVq0LvA@mail.gmail.com>
Subject: Re: [PATCH 2/5] dt-bindings: display/panel: Expand rotation documentation
To:     Derek Basehore <dbasehore@chromium.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Sean Paul <sean@poorly.run>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        CK Hu <ck.hu@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        devicetree@vger.kernel.org,
        Intel Graphics <intel-gfx@lists.freedesktop.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2019 at 10:03 PM Derek Basehore <dbasehore@chromium.org> wrote:
>
> This adds to the rotation documentation to explain how drivers should
> use the property and gives an example of the property in a devicetree
> node.
>
> Signed-off-by: Derek Basehore <dbasehore@chromium.org>
> ---
>  .../bindings/display/panel/panel.txt          | 32 +++++++++++++++++++
>  1 file changed, 32 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/display/panel/panel.txt b/Documentation/devicetree/bindings/display/panel/panel.txt
> index e2e6867852b8..f35d62d933fc 100644
> --- a/Documentation/devicetree/bindings/display/panel/panel.txt
> +++ b/Documentation/devicetree/bindings/display/panel/panel.txt
> @@ -2,3 +2,35 @@ Common display properties
>  -------------------------
>
>  - rotation:    Display rotation in degrees counter clockwise (0,90,180,270)
> +
> +Property read from the device tree using of of_drm_get_panel_orientation

Don't put kernel specifics into bindings.

> +
> +The panel driver may apply the rotation at the TCON level, which will

What's TCON? Something Mediatek specific IIRC.

> +make the panel look like it isn't rotated to the kernel and any other
> +software.
> +
> +If not, a panel orientation property should be added through the SoC
> +vendor DRM code using the drm_connector_init_panel_orientation_property
> +function.

The 'rotation' property should be defined purely based on how the
panel is mounted relative to a device's orientation. If the display
pipeline has some ability to handle rotation, that's a feature of the
display pipeline and not the panel.

> +
> +Example:

This file is a collection of common properties. It shouldn't have an
example especially as this example is mostly non-common properties.

> +       panel: panel@0 {
> +               compatible = "boe,himax8279d8p";
> +               reg = <0>;
> +               enable-gpios = <&pio 45 0>;

> +               pp33-gpios = <&pio 35 0>;
> +               pp18-gpios = <&pio 36 0>;

BTW, are these upstream because they look like GPIO controlled
supplies which we model with gpio-regulator binding typically.

> +               pinctrl-names = "default", "state_3300mv", "state_1800mv";
> +               pinctrl-0 = <&panel_pins_default>;
> +               pinctrl-1 = <&panel_pins_3300mv>;
> +               pinctrl-2 = <&panel_pins_1800mv>;
> +               backlight = <&backlight_lcd0>;
> +               rotation = <180>;
> +               status = "okay";
> +
> +               port {
> +                       panel_in: endpoint {
> +                               remote-endpoint = <&dsi_out>;
> +                       };
> +               };
> +       };
> --
> 2.22.0.rc2.383.gf4fbbf30c2-goog
>
