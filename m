Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3E16C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 07:16:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C81520725
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 07:16:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ha9L17WA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbfLPHQu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 02:16:50 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:35056 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbfLPHQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 02:16:50 -0500
Received: by mail-il1-f193.google.com with SMTP id g12so4635529ild.2
        for <linux-kernel@vger.kernel.org>; Sun, 15 Dec 2019 23:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DdW2X0TaM/Yjl1cs8WJAfaWb8b937afv0ai4eAXIEbQ=;
        b=ha9L17WAZBqCDEiESxhWvrNiQOpHmRyoVhTON48lus8d3oYRR3rIxvfPGWw1YPCSrl
         wYa2PqtQQIyQ65YCU6knRNnaLZxgn8GLNj4kMLfTA/FhkTmPaZPvLA9hUUNHoEk3G9As
         09om+raRs1ka5EgN3yL7DTjgKQLTiYDsNjVSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DdW2X0TaM/Yjl1cs8WJAfaWb8b937afv0ai4eAXIEbQ=;
        b=Aekb9/Khsh8oHg6dePoUsYtIHJdk3Vom1T0Lyonxbn4QpDCD0uJWIS1fyVKhdWwUn2
         CkpkSV/pUpVfdMyLdwvDyRM3yz4DN0LY9bcx4VLUaf5aU+oJpTOZ/aO3KSNDUq004ERu
         hgsbosB2mFYL2VjE06xyfHuDL2tkOpAJ9vdpwP/ez4LT8ZgJ++cst24Twqk5EBltf4As
         GyTMkJFWSuEBRkrfkt02xTQ0KqTD9TNBHynn1AurLLnCz1UD86i3NZ8NK8Zr1Jb9Zcck
         vcLlauIwhyj5Zqx989/STtQcyw1UPKvELCGVk9Q2R7NxiPthXSQOyk8mJ0NpiZfscB86
         BfAQ==
X-Gm-Message-State: APjAAAU3JsTh/5XIeRR2a4zuvUVPcI7OCPaJOKNUzkDFGffk0V4fTsS5
        vo/Deaeii+w1LTBUVuWghx5vhDIcL5JVZCi9A/NhpA==
X-Google-Smtp-Source: APXvYqx3LVRZM6HCeLKsjVRJpN93LQNOQCxa7ygHr779jDj9jz6qFUfOmbd97fsgpcFQeRAI55T1yDrqMsqHtxzf2MY=
X-Received: by 2002:a92:5d88:: with SMTP id e8mr11295212ilg.106.1576480608958;
 Sun, 15 Dec 2019 23:16:48 -0800 (PST)
MIME-Version: 1.0
References: <20191211061911.238393-1-hsinyi@chromium.org> <20191211061911.238393-4-hsinyi@chromium.org>
 <CAL_Jsq+jkgDj6-SH1FrnjB1CQmf33=XUwN3N_fw_aJsQm3Fq9A@mail.gmail.com>
In-Reply-To: <CAL_Jsq+jkgDj6-SH1FrnjB1CQmf33=XUwN3N_fw_aJsQm3Fq9A@mail.gmail.com>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Mon, 16 Dec 2019 15:16:23 +0800
Message-ID: <CAJMQK-iwF78=2PDMxp=cvS3sotNi7kjj1ZoVO9q_axejUPdLYA@mail.gmail.com>
Subject: Re: [PATCH RESEND 3/4] dt-bindings: drm/bridge: Add GPIO display mux binding
To:     Rob Herring <robh+dt@kernel.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Matthias Brugger <mbrugger@suse.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 14, 2019 at 5:29 AM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Wed, Dec 11, 2019 at 12:19 AM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
> >
> > From: Nicolas Boichat <drinkcat@chromium.org>
> >
> > Add bindings for Generic GPIO mux driver.
> >
> > Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > ---
> > Change from RFC to v1:
> > - txt to yaml
> > ---
> >  .../bindings/display/bridge/gpio-mux.yaml     | 89 +++++++++++++++++++
> >  1 file changed, 89 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/display/bridge/gpio-mux.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/display/bridge/gpio-mux.yaml b/Documentation/devicetree/bindings/display/bridge/gpio-mux.yaml
> > new file mode 100644
> > index 000000000000..cef098749066
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/display/bridge/gpio-mux.yaml
> > @@ -0,0 +1,89 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/display/bridge/gpio-mux.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Generic display mux (1 input, 2 outputs)
>
> What makes it generic? Doesn't the mux chip have power supply,
> possibly a reset line or not, etc.? What about a mux where the GPIO
> controls the mux?
>
> Generally, we avoid 'generic' bindings because h/w is rarely generic.
> You can have a generic driver which works on multiple devices.
>
Then how about making it mt8173-oak-gpio-mux? Since this is currently
only used in this board.

> > +
> > +maintainers:
> > +  - Nicolas Boichat <drinkcat@chromium.org>
> > +
> > +description: |
> > +  This bindings describes a simple display (e.g. HDMI) mux, that has 1
> > +  input, and 2 outputs. The mux status is controlled by hardware, and
> > +  its status is read back using a GPIO.
> > +
> > +properties:
> > +  compatible:
> > +    const: gpio-display-mux
> > +
> > +  detect-gpios:
> > +    maxItems: 1
> > +    description: GPIO that indicates the active output
> > +
> > +  ports:
> > +    type: object
> > +
> > +    properties:
> > +      port@0:
> > +        type: object
> > +        description: |
> > +          Video port for input.
> > +
> > +      port@1:
> > +        type: object
> > +        description: |
> > +          2 video ports for output.
> > +          The reg value in the endpoints matches the GPIO status: when
> > +          GPIO is asserted, endpoint with reg value <1> is selected.
>
> You should describe 'endpoint@0' and 'endpoint@1' here too.
Will add in next version, thanks
>
> > +
> > +    required:
> > +      - port@0
> > +      - port@1
> > +
> > +required:
> > +  - compatible
> > +  - detect-gpios
> > +  - ports
> > +
> > +examples:
> > +  - |
> > +    hdmi_mux: hdmi_mux {
> > +      compatible = "gpio-display-mux";
> > +      status = "okay";
>
> Don't show status in examples.
>
> > +      detect-gpios = <&pio 36 GPIO_ACTIVE_HIGH>;
> > +      pinctrl-names = "default";
> > +      pinctrl-0 = <&hdmi_mux_pins>;
> > +      ddc-i2c-bus = <&hdmiddc0>;
>
> Not documented. Is the i2c bus muxed too? If not, then this is in the
> wrong place.
>
It's muxed, but this is required because of [1], so it should be
removed in this example.

[1]https://elixir.bootlin.com/linux/v5.5-rc2/source/Documentation/devicetree/bindings/display/mediatek/mediatek,hdmi.txt#L24
> > +
> > +      ports {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +
> > +        port@0 { /* input */
> > +          reg = <0>;
> > +
> > +          hdmi_mux_in: endpoint {
> > +            remote-endpoint = <&hdmi0_out>;
> > +          };
> > +        };
> > +
> > +        port@1 { /* output */
> > +          reg = <1>;
> > +
> > +          #address-cells = <1>;
> > +          #size-cells = <0>;
> > +
> > +          hdmi_mux_out_anx: endpoint@0 {
> > +            reg = <0>;
> > +            remote-endpoint = <&anx7688_in>;
> > +          };
> > +
> > +          hdmi_mux_out_hdmi: endpoint@1 {
> > +            reg = <1>;
> > +            remote-endpoint = <&hdmi_connector_in>;
> > +          };
> > +        };
> > +      };
> > +    };
> > --
> > 2.24.0.525.g8f36a354ae-goog
> >
