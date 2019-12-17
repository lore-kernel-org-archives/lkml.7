Return-Path: <SRS0=vnTL=2H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 643BEC2D0CD
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 17:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3059C24682
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Dec 2019 17:45:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FxKV2Ad+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbfLQRpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Dec 2019 12:45:19 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:38527 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727538AbfLQRpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Dec 2019 12:45:18 -0500
Received: by mail-io1-f68.google.com with SMTP id v3so11988754ioj.5
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 09:45:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K++e5QOhyphAxpqqtvJTK/6MhPRY4wAHe5pP45LXjzM=;
        b=FxKV2Ad+DXwOEcA4A7bwirIMji+gxfaDm21MtuQYFag6aDszB62r6Bc3K1Cx3dfH8T
         0oBiM0DkCTMj1QEGmpca17104EuOb0G/UKL5WwqziTeD/Hu7h0reJl9quTCbUa08Tb3o
         opbAtbWUFmu8BCgb6kkQCTDDHhBH2AdsTJ6nY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K++e5QOhyphAxpqqtvJTK/6MhPRY4wAHe5pP45LXjzM=;
        b=SH+3qstFoDh6UiOw1waC8sYM+GUL//MxNip4LnGPi6uI8Yiz/uK2vnIyaQ6/NoOIHG
         lr4OKks0G9CYFKETQedhwI3tcoIOWoplqtgZCVPGeSLxjuvW81yyVHIE1+kt3j1Dgnvf
         UYyy0w4jQwnFCqDFLt6LxHZH91nrjicY6rc/igz9XnYh2DgZZAJSHOB4NpBU2ww3PkPY
         +s0UzN+6/y+HStKT8i2f8rblq4051DRzuLUlOh5pQXNC0MdpUqOSeP5Mp9S+IaiMVmkI
         Af5y2Kyg/FERy2rTPcsMDEoThauSQmZ8MQllt6nuSBoWbZcri5coKiC+aWayftiBTFvU
         8fZQ==
X-Gm-Message-State: APjAAAUIKgGlP1eEw+1ZWwXcL3sTLcG8Uwc/vtHhflaK3Lom5EEez7Lg
        x9D7FT0MKm0++fJmUpLKaXj23migCCI=
X-Google-Smtp-Source: APXvYqyGv/gvGGCdva6OtC8g/tUDyvKy+OdmpJFUi/YMEN6gm2J34g/hutC9TJjnK+kbl86dLRFY7g==
X-Received: by 2002:a02:7086:: with SMTP id f128mr17363159jac.12.1576604717562;
        Tue, 17 Dec 2019 09:45:17 -0800 (PST)
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com. [209.85.166.181])
        by smtp.gmail.com with ESMTPSA id z15sm6986338ill.20.2019.12.17.09.45.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Dec 2019 09:45:16 -0800 (PST)
Received: by mail-il1-f181.google.com with SMTP id t8so265195iln.4
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2019 09:45:16 -0800 (PST)
X-Received: by 2002:a92:911b:: with SMTP id t27mr17776689ild.142.1576604716025;
 Tue, 17 Dec 2019 09:45:16 -0800 (PST)
MIME-Version: 1.0
References: <20191217005424.226858-1-swboyd@chromium.org>
In-Reply-To: <20191217005424.226858-1-swboyd@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Tue, 17 Dec 2019 09:45:02 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UQAgd2R=ykTCnBZuOvFFKoWu4o-3Rq=GEdrc1KKSi9cQ@mail.gmail.com>
Message-ID: <CAD=FV=UQAgd2R=ykTCnBZuOvFFKoWu4o-3Rq=GEdrc1KKSi9cQ@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: tpm: Convert cr50 binding to YAML
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Rob Herring <robh@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Andrey Pronin <apronin@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Dec 16, 2019 at 4:54 PM Stephen Boyd <swboyd@chromium.org> wrote:
>
> This allows us to validate the dt binding to the implementation. Add the
> interrupt property too, because that's required but nobody noticed when
> the non-YAML binding was introduced.
>
> Cc: Andrey Pronin <apronin@chromium.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  .../bindings/security/tpm/google,cr50.txt     | 19 -------
>  .../bindings/security/tpm/google,cr50.yaml    | 52 +++++++++++++++++++
>  2 files changed, 52 insertions(+), 19 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/security/tpm/google,cr50.txt
>  create mode 100644 Documentation/devicetree/bindings/security/tpm/google,cr50.yaml
>
> diff --git a/Documentation/devicetree/bindings/security/tpm/google,cr50.txt b/Documentation/devicetree/bindings/security/tpm/google,cr50.txt
> deleted file mode 100644
> index cd69c2efdd37..000000000000
> --- a/Documentation/devicetree/bindings/security/tpm/google,cr50.txt
> +++ /dev/null
> @@ -1,19 +0,0 @@
> -* H1 Secure Microcontroller with Cr50 Firmware on SPI Bus.
> -
> -H1 Secure Microcontroller running Cr50 firmware provides several
> -functions, including TPM-like functionality. It communicates over
> -SPI using the FIFO protocol described in the PTP Spec, section 6.
> -
> -Required properties:
> -- compatible: Should be "google,cr50".
> -- spi-max-frequency: Maximum SPI frequency.
> -
> -Example:
> -
> -&spi0 {
> -       tpm@0 {
> -               compatible = "google,cr50";
> -               reg = <0>;
> -               spi-max-frequency = <800000>;
> -       };
> -};
> diff --git a/Documentation/devicetree/bindings/security/tpm/google,cr50.yaml b/Documentation/devicetree/bindings/security/tpm/google,cr50.yaml
> new file mode 100644
> index 000000000000..8bfff0e757af
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/security/tpm/google,cr50.yaml
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/tpm/google,cr50.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: H1 Secure Microcontroller with Cr50 Firmware on SPI Bus
> +
> +description:
> +  H1 Secure Microcontroller running Cr50 firmware provides several functions,
> +  including TPM-like functionality. It communicates over SPI using the FIFO
> +  protocol described in the PTP Spec, section 6.
> +
> +maintainers:
> +  - Andrey Pronin <apronin@chromium.org>

Does Andrey agree to be the maintainer here?


I'd like to see if we can delete most of what you've written here.
Specifically in "spi/spi-controller.yaml" you can see a really nice
description of what SPI devices ought to look like.  Can we just
reference that?  To do that I _think_ we actually need to break that
description into a separate YAML file and then include it from there
and here.  Maybe someone on the list can confirm or we can just post
some patches for that?


> +properties:
> +  compatible:
> +    const: google,cr50
> +
> +  reg:
> +    maxItems: 1

I'm curious if you need a minItems here.  ...and if we don't somehow
include it, should we follow 'spi-controller.yaml' and treat this like
an int?


> +  spi-max-frequency:
> +    maxItems: 1

This is not an array type.  Why do you need maxItems?  Should treat
like an int?  Do we have any ranges of sane values we can put here?
I'm sure that there is a maximum that Cr50 can talk at.


> +  interrupts:
> +    maxItems: 1

I'm curious if you need a minItems here.

...also: should we be trying to validate the flags at all?  AKA that
Cr50 expects a rising edge interrupt?


> +required:
> +  - compatible
> +  - reg
> +  - spi-max-frequency

Technically spi-max-frequency might not be required (the SPI binding
doesn't list it as such), but I guess it was before...


> +  - interrupts
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +    spi {
> +      #address-cells = <0x1>;
> +      #size-cells = <0x0>;
> +      tpm@0 {
> +          compatible = "google,cr50";
> +          reg = <0>;
> +          spi-max-frequency = <800000>;
> +          interrupts = <50 IRQ_TYPE_EDGE_RISING>;

I would tend to prefer seeing the interrupt parent in the example
since it's pretty likely that the GPIO controller isn't the overall
parent and likely that our interrupt is a GPIO.  I'm not sure the
convention, though.


> +      };
> +    };
> +
> +...

Is the "..." important here?  I guess this is only if you're trying to
jam two bindings into the same file, but I could be wrong.  I guess a
bunch of arm ones owned by Rob have it at the end (though the example
doesn't?), so maybe it's right?
