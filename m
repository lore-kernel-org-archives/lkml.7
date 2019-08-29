Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A808C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 15:42:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D1FC2080F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 15:42:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567093373;
	bh=DxWOdTfJDyMTvRtm9hgWK6xzF49v9zdddJc0Ul0OHxY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=oJ30S5HzwV5p6s20XVxToN72T2i5WtAdilSRg+VPdM2V1bGDmcPGdNoGHnPl1SIAu
	 sxQ5ej0ncQIeXSc1El66LKdgkg47FOon7kdnA8sGyjfSN5X5YFuhXelNTsoQZyAlZp
	 mI6sDu8KotrQ5yrEfzPkyMnondnbTBddNwmE/yYw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbfH2Pmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 11:42:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:50400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727118AbfH2Pmw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 11:42:52 -0400
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8649E22CED;
        Thu, 29 Aug 2019 15:42:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567093370;
        bh=DxWOdTfJDyMTvRtm9hgWK6xzF49v9zdddJc0Ul0OHxY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=vzJZPgiDkWKkP+NaPPxauJ+fKFwPvLGB8/KdLTohOjj/xVgXAESpMcyDxLKvgC9FL
         4ds2R9TlkDRR/vh+2bQOe0y3+DDbXYkzBMHs913aiDG10CTXtcEJX0TITe/ya+q4ot
         Mt/Cil3GMNqnHFH52WvFb2OkSak1IHnGLTgP3aq0=
Received: by mail-qt1-f172.google.com with SMTP id k13so4119062qtm.12;
        Thu, 29 Aug 2019 08:42:50 -0700 (PDT)
X-Gm-Message-State: APjAAAV6kgnd10p4AQMetpRnckTAffkAfnLcsF2/f/bKZ+saptydbaGJ
        5pnzEj3TJUT3of5IDi+IOaaOrNpFT8rYCmTckQ==
X-Google-Smtp-Source: APXvYqzic6Dz5pyl8Zhym2cQiIYya/v+IE6KIzVsJARvSoJSziaqBB5AVnV348vxKKPJBjtqCYdf51FhEHiBWnPYbek=
X-Received: by 2002:ad4:4050:: with SMTP id r16mr6931395qvp.200.1567093369577;
 Thu, 29 Aug 2019 08:42:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190829144442.6210-1-srinivas.kandagatla@linaro.org> <20190829144442.6210-2-srinivas.kandagatla@linaro.org>
In-Reply-To: <20190829144442.6210-2-srinivas.kandagatla@linaro.org>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 29 Aug 2019 10:42:37 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLwbz5eiBEw8PmXsJrxzXffNc7rRON-wQ0KviVW8JVv5A@mail.gmail.com>
Message-ID: <CAL_JsqLwbz5eiBEw8PmXsJrxzXffNc7rRON-wQ0KviVW8JVv5A@mail.gmail.com>
Subject: Re: [PATCH v5 1/4] dt-bindings: soundwire: add slave bindings
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
> This patch adds bindings for Soundwire Slave devices that includes how
> SoundWire enumeration address and Link ID are used to represented in
> SoundWire slave device tree nodes.
>
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../soundwire/soundwire-controller.yaml       | 72 +++++++++++++++++++
>  1 file changed, 72 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soundwire/soundwire-controller.yaml
>
> diff --git a/Documentation/devicetree/bindings/soundwire/soundwire-controller.yaml b/Documentation/devicetree/bindings/soundwire/soundwire-controller.yaml
> new file mode 100644
> index 000000000000..449b6130ce63
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soundwire/soundwire-controller.yaml
> @@ -0,0 +1,72 @@
> +# SPDX-License-Identifier: GPL-2.0

(GPL-2.0-only OR BSD-2-Clause) for new bindings.

> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soundwire/soundwire-controller.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SoundWire Controller Generic Binding
> +
> +maintainers:
> +  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> +  - Vinod Koul <vkoul@kernel.org>
> +
> +description: |
> +  SoundWire busses can be described with a node for the SoundWire controller
> +  device and a set of child nodes for each SoundWire slave on the bus.
> +
> +properties:
> +  $nodename:
> +    pattern: "^soundwire(@.*)?$"
> +
> +  "#address-cells":
> +    const: 2
> +
> +  "#size-cells":
> +    const: 0
> +
> +patternProperties:
> +  "^.*@[0-9a-f],[0-9a-f]$":
> +    type: object
> +
> +    properties:
> +      compatible:
> +        pattern: "^sdw[0-9a-f]{1}[0-9a-f]{4}[0-9a-f]{4}[0-9a-f]{2}$"
> +        description: Is the textual representation of SoundWire Enumeration
> +          address. compatible string should contain SoundWire Version ID,
> +          Manufacturer ID, Part ID and Class ID in order and shall be in
> +          lower-case hexadecimal with leading zeroes.
> +          Valid sizes of these fields are
> +          Version ID is 1 nibble, number '0x1' represents SoundWire 1.0
> +          and '0x2' represents SoundWire 1.1 and so on.
> +          MFD is 4 nibbles
> +          PID is 4 nibbles
> +          CID is 2 nibbles
> +          More Information on detail of encoding of these fields can be
> +          found in MIPI Alliance DisCo & SoundWire 1.0 Specifications.
> +
> +      reg:
> +        maxItems: 1
> +        description:
> +          Link ID followed by Instance ID of SoundWire Device Address.
> +
> +    additionalProperties: false

I'm pretty sure you'll want nodes with other properties. If not, then
why are they in DT? So drop this.

Both the controller and child nodes need to list required properties.

> +
> +examples:
> +  - |
> +    soundwire@c2d0000 {
> +        #address-cells = <2>;
> +        #size-cells = <0>;
> +        reg = <0x0c2d0000 0x2000>;
> +
> +        speaker@0,1 {
> +            compatible = "sdw10217201000";
> +            reg = <0 1>;
> +        };
> +
> +        speaker@0,2 {
> +            compatible = "sdw10217201000";
> +            reg = <0 2>;
> +        };
> +    };
> +
> +...
> --
> 2.21.0
>
