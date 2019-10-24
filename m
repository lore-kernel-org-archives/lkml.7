Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00EE6CA9EBB
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 19:59:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C94AB2070B
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 19:59:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="snuxE3aH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393211AbfJXT73 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 15:59:29 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:42955 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfJXT73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 15:59:29 -0400
Received: by mail-ot1-f65.google.com with SMTP id b16so74314otk.9;
        Thu, 24 Oct 2019 12:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x0F8kOEXNZOfO+KIT0hQfdKv4yLZvQqLGUo1yR7k0NA=;
        b=snuxE3aHoCZdXiCfya3k+KjX1hRdlD81yjj5m/zXuf5AkSmy4EOBjVolf3jlV5YW9D
         Fjjr3kLr3wloPS2UonX0HIUFkETx2i5bJ/JX6BKqwshEBRgw2BVj0qGwvZgMPqGRRY3g
         TxBw8H6kjqwMKbYCQYhiB0uXC4la7Rfu8uoD9LCHXKAvZeNloqkQnej4z7VrR/YbhY6i
         0zeggDxB2WzPZqRZxlZ3lnORVRDURl7L8gC9WUYD2udicNGwo5g1QFsiLq3uR7Hgbtdv
         U2x36BuSqPfEeybobiQOJG9I5OfV1Zu/u1cOaAuqqvo2XIb7kF1mrYudZ0TjtwZtZLwR
         3CyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x0F8kOEXNZOfO+KIT0hQfdKv4yLZvQqLGUo1yR7k0NA=;
        b=arc5PvR1REhKWHtx/CQ++UvaTLHEYw3TR/vMz6TjACaw8qmnPBMr3/RhZj8tIg+r+G
         bM6H0BOhVuIWutp1G4LxEkUJXk4reYUQm7btgwjEfW0rooQczga6Ri478GhcMWTOWDce
         XRkaiEBNxc+2ABbnmjV2xYxz3wSs5FdmuSbIpWh1SXYDyNdFPy1A2FV+7OLEAtV80VAN
         kapCXQR1bMU3PlwDiMtA8lH0bo4pJTPFAQsEwWnfCl2/JQxp70E3NNKIL+fOwca3yf5C
         5iJQVxWq3i7gL4jgc9HC7hT3VY+162lG5Sx2o41amDMdQddsfxYkHaZX6BZM0MJuWsFD
         xy7A==
X-Gm-Message-State: APjAAAUcgXo5ktPefcV+mRefW5rQnxvFa1HtSRAjus1qDVjR3JOlpAx+
        9wd26Nf4S54WxvoZ0xUsYSheNIOJRl5i58JtnKM=
X-Google-Smtp-Source: APXvYqwfrFMeaEKve/AdMM1rYLh7RtVdW3+WPD9G7iO/wQWEsl/rRNnNoOdK2OWQnig+oY+jXCbIZdvOKxvVAdAvS30=
X-Received: by 2002:a05:6830:13d8:: with SMTP id e24mr5940324otq.42.1571947168180;
 Thu, 24 Oct 2019 12:59:28 -0700 (PDT)
MIME-Version: 1.0
References: <20191021132322.25256-1-narmstrong@baylibre.com>
In-Reply-To: <20191021132322.25256-1-narmstrong@baylibre.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Thu, 24 Oct 2019 21:59:17 +0200
Message-ID: <CAFBinCAv7fVBbZaUW-5unjcuOAWtEbDsjZFa=WeSRff7_Zrf2A@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: usb: dwc3: Move Amlogic G12A DWC3 Glue
 Bindings to YAML schemas
To:     Neil Armstrong <narmstrong@baylibre.com>
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Mon, Oct 21, 2019 at 3:23 PM Neil Armstrong <narmstrong@baylibre.com> wrote:
[...]
> diff --git a/Documentation/devicetree/bindings/usb/amlogic,meson-g12a-usb-ctrl.yaml b/Documentation/devicetree/bindings/usb/amlogic,meson-g12a-usb-ctrl.yaml
> new file mode 100644
> index 000000000000..45bcc98ee9a4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/amlogic,meson-g12a-usb-ctrl.yaml
> @@ -0,0 +1,132 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright 2019 BayLibre, SAS
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/usb/amlogic,meson-g12a-usb-ctrl.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Amlogic Meson G12A DWC3 USB SoC Controller Glue
> +
> +maintainers:
> +  - Neil Armstrong <narmstrong@baylibre.com>
> +
> +description: |
> +  The Amlogic G12A embeds a DWC3 USB IP Core configured for USB2 and USB3
> +  in host-only mode, and a DWC2 IP Core configured for USB2 peripheral mode
> +  only.
> +
> +  A glue connects the DWC3 core to USB2 PHYs and optionnaly to an USB3 PHY.
optionnaly -> optionally

> +
> +  One of the USB2 PHY can be re-routed in peripheral mode to a DWC2 USB IP.
One of the USB2 PHYs...

with these two fixed:
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

[...]
> +  phy-names:
> +    items:
> +      - const: usb2-phy0 # USB2 PHY0 if USBHOST_A port is used
> +      - const: usb2-phy1 # USB2 PHY1 if USBOTG_B port is used
> +      - const: usb3-phy0 # USB3 PHY if USB3_0 is used
> +
> +  phys:
> +    minItems: 1
> +    maxItems: 3
(off-topic and probably a question for Rob: do you know the validation
mechanism knows that phys and phy-names belong together. so if one phy
is omitted then phy-names can be shorter than 3 entries?)


Martin
