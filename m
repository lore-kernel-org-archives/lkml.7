Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8913AC10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 13:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5492120693
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 13:13:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555938826;
	bh=GfKXT+ZuhRm5Jn9euYKis3qNlZMgAnLXskTaqP5QHWY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=SBLHAeOcZSh9xdqXivTN2rSDZkudtmYv0BbmmkUxgboheng3dhQZiuPhWZbcUQ/DF
	 ETwxSWrBpjXMxQUGfE+Y2evybxD1+U0FBnL8tafGpjOi+uWvji5ER/yirwwpl5Mfdc
	 Nz2f8WblVhFUN+9Yp1IRAPkCN3c4buhgON3FI1G0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727372AbfDVNNo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 09:13:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:49026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726057AbfDVNNo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 09:13:44 -0400
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E1AD20874;
        Mon, 22 Apr 2019 13:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555938822;
        bh=GfKXT+ZuhRm5Jn9euYKis3qNlZMgAnLXskTaqP5QHWY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ZG9bTDFzNkvt/TJR5dfwtLs3PWMCVJTAmaK7JQyYzvSDqd/Ug2CmjjzTL8E9O2OBc
         SwlQlF5LmIWAwYcTqqwdiSLiJr6hic067OODyBTgRm3Dy/eeo8nbDdGIBpiX5/B2zJ
         Pr+BAaKmZacbR9vidrDEuPlstodpheHsPAsWGZ0g=
Received: by mail-qk1-f177.google.com with SMTP id w73so4178246qkb.13;
        Mon, 22 Apr 2019 06:13:42 -0700 (PDT)
X-Gm-Message-State: APjAAAX5Y+OE8nZtp/MznUv4MGM5p8FeKstkMLJJOmY2Wv8dDkZ+4thL
        BX4UsN+/M/XZ24ZPQdgkDSDCgEL8C4ArjrjDJQ==
X-Google-Smtp-Source: APXvYqzJYG+geuHAg6kTRjqKLRTQTE5eJnRiE83Vm6KlY6wH8aAMezPzFmY1PFRTiRVSGI1WRy10cBl3QZkSCyxz1qU=
X-Received: by 2002:a37:9186:: with SMTP id t128mr14431012qkd.326.1555938821856;
 Mon, 22 Apr 2019 06:13:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190420122333.23662-1-luca@z3ntu.xyz>
In-Reply-To: <20190420122333.23662-1-luca@z3ntu.xyz>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 22 Apr 2019 08:13:29 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+EJpRFRzh-dmZAJUQ84iMm6rs=sNTYstpQJzsbSboUqg@mail.gmail.com>
Message-ID: <CAL_Jsq+EJpRFRzh-dmZAJUQ84iMm6rs=sNTYstpQJzsbSboUqg@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: input: add GPIO controllable vibrator
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Pascal PAILLET-LME <p.paillet@st.com>,
        Coly Li <colyli@suse.de>, Lee Jones <lee.jones@linaro.org>,
        Xiaotong Lu <xiaotong.lu@spreadtrum.com>,
        Brian Masney <masneyb@onstation.org>,
        Baolin Wang <baolin.wang@linaro.org>,
        David Brown <david.brown@linaro.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        "open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..." 
        <linux-input@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 20, 2019 at 7:24 AM Luca Weiss <luca@z3ntu.xyz> wrote:
>
> Provide a simple driver for GPIO controllable vibrators.
> It will be used by the Fairphone 2.
>
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---
> Changes from v3:
> - Convert .txt based doc to the new yaml based format
>
>  .../bindings/input/gpio-vibrator.yaml         | 39 +++++++++++++++++++
>  1 file changed, 39 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/gpio-vibrator.yaml
>
> diff --git a/Documentation/devicetree/bindings/input/gpio-vibrator.yaml b/Documentation/devicetree/bindings/input/gpio-vibrator.yaml
> new file mode 100644
> index 000000000000..bca1b6ea07a4
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/gpio-vibrator.yaml
> @@ -0,0 +1,39 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/bindings/input/gpio-vibrator.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: GPIO vibrator
> +
> +maintainers:
> +  - Luca Weiss <luca@z3ntu.xyz>
> +
> +description: |+
> +  Registers a GPIO device as vibrator, where the on/off capability is controlled by a GPIO.
> +
> +properties:
> +  compatible:

> +    items:
> +      - const: gpio-vibrator

These 2 lines can be simplified to just 'const: gpio-vibrator'.

> +
> +  enable-gpios:
> +    maxItems: 1
> +
> +  vcc-supply:
> +    $ref: /schemas/types.yaml#/definitions/phandle

This isn't necessary as we can do this for every occurrence of
'*-supply'. I'll add that to the core schema.

With those 2 changes:

Reviewed-by: Rob Herring <robh@kernel.org>

> +    description: Regulator that provides power
> +
> +required:
> +  - compatible
> +  - enable-gpios
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    vibrator {
> +        compatible = "gpio-vibrator";
> +        enable-gpios = <&msmgpio 86 GPIO_ACTIVE_HIGH>;
> +        vcc-supply = <&pm8941_l18>;
> +    };
> --
> 2.21.0
>
