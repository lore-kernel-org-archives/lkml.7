Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C757C2D0C9
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 22:17:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5194B2073D
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 22:17:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576275479;
	bh=tlc6zX/LTEyF5wczNgFfQrREIesmdwXR+IfQ/HzAsqI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=VB9bxBLkibiW5Hn87f1/5EftdJLdE8XQpXUk5o4EfiBjg1d1sSGXAHOQnTKnCGJuA
	 8tJyqcdwYnVNlzDbLKgY9mMXdTNKTX/ijGCEzO4jVj2PNsdyzZ1151I+xUUHYSl7sj
	 DPk6+nqP5VZ/7Pf1f6z1lIQSKG2qA2sGpnmrUjgE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbfLMWR6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 17:17:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:38638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725948AbfLMWR6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 17:17:58 -0500
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0F9192073D;
        Fri, 13 Dec 2019 22:17:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576275477;
        bh=tlc6zX/LTEyF5wczNgFfQrREIesmdwXR+IfQ/HzAsqI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BkxSAcqVhR0pEES5vqzaja2g/RZ4Zz1iwoK5Yo4PncyYac7iZxStJ+xuU3nPxDrh6
         0YmTwFqmA3/uqTdAVhcCtFaEYOoHGCVhgQnhIQIGiCKp7TOkX/sEQSHtgccpwHM3NJ
         mWxS5sjFZZ9cUhKehXAcDrTfxjqDjsOZE9wb9aMo=
Received: by mail-qk1-f174.google.com with SMTP id z76so538668qka.2;
        Fri, 13 Dec 2019 14:17:57 -0800 (PST)
X-Gm-Message-State: APjAAAWvc023vKK6GfR8jcmsz3cunA4YJ50GWLodEn8WB2xoJIH/Rry1
        EmLmuGZmagLy3/uG1oaQ5Slntji76Rw5eYcLBQ==
X-Google-Smtp-Source: APXvYqyLVGyr/ou6/zCUSR6nbqEvM4qZSGd5lkUZviadNs7lGm/zXP4dZkMOJJThzBpo59gYWshwpV/gf0X0NWtCe7c=
X-Received: by 2002:a05:620a:135b:: with SMTP id c27mr1536497qkl.119.1576245251094;
 Fri, 13 Dec 2019 05:54:11 -0800 (PST)
MIME-Version: 1.0
References: <20191211061911.238393-1-hsinyi@chromium.org> <20191211061911.238393-4-hsinyi@chromium.org>
In-Reply-To: <20191211061911.238393-4-hsinyi@chromium.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 13 Dec 2019 07:53:59 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+jkgDj6-SH1FrnjB1CQmf33=XUwN3N_fw_aJsQm3Fq9A@mail.gmail.com>
Message-ID: <CAL_Jsq+jkgDj6-SH1FrnjB1CQmf33=XUwN3N_fw_aJsQm3Fq9A@mail.gmail.com>
Subject: Re: [PATCH RESEND 3/4] dt-bindings: drm/bridge: Add GPIO display mux binding
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        devicetree@vger.kernel.org,
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

On Wed, Dec 11, 2019 at 12:19 AM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>
> From: Nicolas Boichat <drinkcat@chromium.org>
>
> Add bindings for Generic GPIO mux driver.
>
> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
> Change from RFC to v1:
> - txt to yaml
> ---
>  .../bindings/display/bridge/gpio-mux.yaml     | 89 +++++++++++++++++++
>  1 file changed, 89 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/gpio-mux.yaml
>
> diff --git a/Documentation/devicetree/bindings/display/bridge/gpio-mux.yaml b/Documentation/devicetree/bindings/display/bridge/gpio-mux.yaml
> new file mode 100644
> index 000000000000..cef098749066
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/gpio-mux.yaml
> @@ -0,0 +1,89 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/bridge/gpio-mux.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Generic display mux (1 input, 2 outputs)

What makes it generic? Doesn't the mux chip have power supply,
possibly a reset line or not, etc.? What about a mux where the GPIO
controls the mux?

Generally, we avoid 'generic' bindings because h/w is rarely generic.
You can have a generic driver which works on multiple devices.

> +
> +maintainers:
> +  - Nicolas Boichat <drinkcat@chromium.org>
> +
> +description: |
> +  This bindings describes a simple display (e.g. HDMI) mux, that has 1
> +  input, and 2 outputs. The mux status is controlled by hardware, and
> +  its status is read back using a GPIO.
> +
> +properties:
> +  compatible:
> +    const: gpio-display-mux
> +
> +  detect-gpios:
> +    maxItems: 1
> +    description: GPIO that indicates the active output
> +
> +  ports:
> +    type: object
> +
> +    properties:
> +      port@0:
> +        type: object
> +        description: |
> +          Video port for input.
> +
> +      port@1:
> +        type: object
> +        description: |
> +          2 video ports for output.
> +          The reg value in the endpoints matches the GPIO status: when
> +          GPIO is asserted, endpoint with reg value <1> is selected.

You should describe 'endpoint@0' and 'endpoint@1' here too.

> +
> +    required:
> +      - port@0
> +      - port@1
> +
> +required:
> +  - compatible
> +  - detect-gpios
> +  - ports
> +
> +examples:
> +  - |
> +    hdmi_mux: hdmi_mux {
> +      compatible = "gpio-display-mux";
> +      status = "okay";

Don't show status in examples.

> +      detect-gpios = <&pio 36 GPIO_ACTIVE_HIGH>;
> +      pinctrl-names = "default";
> +      pinctrl-0 = <&hdmi_mux_pins>;
> +      ddc-i2c-bus = <&hdmiddc0>;

Not documented. Is the i2c bus muxed too? If not, then this is in the
wrong place.

> +
> +      ports {
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +
> +        port@0 { /* input */
> +          reg = <0>;
> +
> +          hdmi_mux_in: endpoint {
> +            remote-endpoint = <&hdmi0_out>;
> +          };
> +        };
> +
> +        port@1 { /* output */
> +          reg = <1>;
> +
> +          #address-cells = <1>;
> +          #size-cells = <0>;
> +
> +          hdmi_mux_out_anx: endpoint@0 {
> +            reg = <0>;
> +            remote-endpoint = <&anx7688_in>;
> +          };
> +
> +          hdmi_mux_out_hdmi: endpoint@1 {
> +            reg = <1>;
> +            remote-endpoint = <&hdmi_connector_in>;
> +          };
> +        };
> +      };
> +    };
> --
> 2.24.0.525.g8f36a354ae-goog
>
