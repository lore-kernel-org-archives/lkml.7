Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6862CC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 15:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B91A2166E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 15:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567093606;
	bh=cHM+V4KNetFDv6bvk4UNayqxUbJb3S5INnPuReHPqLw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=xjpWuKNtAmvoNGJQhBv2CqCSI9hVUb1u1obr9DjH9A27zAGHtH/TFUWwEMi2pHWqF
	 t3x6USIkMH0A5fnRzcLODDwRMtWfsVr8v9eM/PUtdyP0ZigdVShHyHMGbbglR9+oXW
	 7r7SKLII0OhPiEt/aki8qZ6zIsQszcipMCctCSFs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727926AbfH2Pqp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 11:46:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:52238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726283AbfH2Pqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 11:46:45 -0400
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 979B121726;
        Thu, 29 Aug 2019 15:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567093603;
        bh=cHM+V4KNetFDv6bvk4UNayqxUbJb3S5INnPuReHPqLw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Q9hbL5eIgVwnAAJOXnNjlP1Y2Iq//H9voJlF+Pn/JaW8WkSV44fet0A9aZYpzrs7M
         4fHrVkiUk22xNzzQGmAu0G0oI2WqbrWk00j28SbSefXbF9842Sej3ZZe9CQ70TT2//
         a9q2ISFqBgTsS1mfOUsBp3JT/gsxyDONFgN0e7io=
Received: by mail-qk1-f182.google.com with SMTP id p13so3303983qkg.13;
        Thu, 29 Aug 2019 08:46:43 -0700 (PDT)
X-Gm-Message-State: APjAAAXvHjCl2YwsJ4P5THzN3O5W8ds1Aee3AvE6r+ZpMmfCxUbR8/kJ
        AENDgqoVH8xaK0wxNSzZ79dCJJyrN4mbfNltfg==
X-Google-Smtp-Source: APXvYqyA+jMNSQIZCkr6jb8mlC5b6oVNdaV5mOjZDpj/IbaU+kEDe/0ubCo2ed9zxMPBL94qqUFeR0bF/sGOmuc+Nw8=
X-Received: by 2002:a37:8905:: with SMTP id l5mr10368083qkd.152.1567093602775;
 Thu, 29 Aug 2019 08:46:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190829144442.6210-1-srinivas.kandagatla@linaro.org> <20190829144442.6210-4-srinivas.kandagatla@linaro.org>
In-Reply-To: <20190829144442.6210-4-srinivas.kandagatla@linaro.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 29 Aug 2019 10:46:30 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLOHA+r9UCTwyvj+_BzWSrsVDZw5vp-1XhYYvQxncx0sw@mail.gmail.com>
Message-ID: <CAL_JsqLOHA+r9UCTwyvj+_BzWSrsVDZw5vp-1XhYYvQxncx0sw@mail.gmail.com>
Subject: Re: [PATCH v5 3/4] dt-bindings: ASoC: Add WSA881x bindings
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>, Vinod <vkoul@kernel.org>,
        spapothi@codeaurora.org, Banajit Goswami <bgoswami@codeaurora.org>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 29, 2019 at 9:45 AM Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
> This patch adds bindings for WSA8810/WSA8815 Class-D Smart Speaker
> Amplifier. This Amplifier also has a simple thermal sensor for
> over temperature and speaker protection.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../bindings/sound/qcom,wsa881x.yaml          | 41 +++++++++++++++++++
>  1 file changed, 41 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/qcom,wsa881x.yaml
>
> diff --git a/Documentation/devicetree/bindings/sound/qcom,wsa881x.yaml b/Documentation/devicetree/bindings/sound/qcom,wsa881x.yaml
> new file mode 100644
> index 000000000000..7a486c024732
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/qcom,wsa881x.yaml
> @@ -0,0 +1,41 @@
> +# SPDX-License-Identifier: GPL-2.0

Dual license please.

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/qcom,wsa881x.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Bindings for Qualcomm WSA8810/WSA8815 Class-D Smart Speaker Amplifier
> +
> +maintainers:
> +  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> +
> +description: |
> +  WSA8810 is a class-D smart speaker amplifier and WSA8815
> +  is a high-output power class-D smart speaker amplifier.
> +  Their primary operating mode uses a SoundWire digital audio
> +  interface. This binding is for SoundWire interface.
> +
> +properties:
> +  compatible:
> +    const: "sdw10217201000"

No need for quotes.

> +
> +  reg:
> +    maxItems: 1
> +

> +  powerdown-gpios:
> +    description: GPIO spec for Powerdown/Shutdown line to use
> +    maxItems: 1
> +
> +  '#thermal-sensor-cells':
> +    const: 0

Either of these required?

Here you can put 'additionalProperties: false'

> +
> +examples:
> +  - |
> +    speaker@0,1 {

This should be under a soundwire bus node.

> +        compatible = "sdw10217201000";
> +        reg = <0 1>;
> +        powerdown-gpios = <&wcdpinctrl 2 0>;
> +        #thermal-sensor-cells = <0>;
> +    };
> +
> +...
> --
> 2.21.0
>
