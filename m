Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1864AC3A5A2
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 06:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF19C233A0
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 06:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566543293;
	bh=W+qn+QOwSKG7puhON5UFJGrv26xyv8xtSb5V5rMP7E4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=fz4GB2RJIfx/9CgM6wJrwfraV5DwmFXJslxhinOoumrvmHJy0O6Jwsgd2uHU/h/pZ
	 Nu0wSl+ZC62iWpNdLetSPXrjpCfGUqGlB+0ahtf1KZIYxTUycfJJdTdiWdryszZfas
	 3yhfRc/oUkLeeyxtwgeZCBgEmNLmbUTETFM5EUBE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404734AbfHWGyx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 02:54:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:51590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404303AbfHWGyw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 02:54:52 -0400
Received: from localhost (unknown [106.200.210.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4BC7921726;
        Fri, 23 Aug 2019 06:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566543291;
        bh=W+qn+QOwSKG7puhON5UFJGrv26xyv8xtSb5V5rMP7E4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wDmw9L/HlwxOz/CUNginISgXT6bUGd2KhGdfkcMeC4UfHm55bRlNgTmgwsHlc6He7
         foWdCjK+8jN0DVJjHT5qJpJGJU1yyHW+6Xw/e6QdqHfDxLRMhT6AdJdBm8KWdmTqw/
         +Dp1q0feQqbW0+sTAnHu9FpRqt6FoRiIlF55x4FU=
Date:   Fri, 23 Aug 2019 12:23:40 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     broonie@kernel.org, robh+dt@kernel.org, spapothi@codeaurora.org,
        bgoswami@codeaurora.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        devicetree@vger.kernel.org
Subject: Re: [RESEND PATCH v4 1/4] dt-bindings: soundwire: add slave bindings
Message-ID: <20190823065340.GD2672@vkoul-mobl>
References: <20190822233759.12663-1-srinivas.kandagatla@linaro.org>
 <20190822233759.12663-2-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190822233759.12663-2-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-08-19, 00:37, Srinivas Kandagatla wrote:
> This patch adds bindings for Soundwire Slave devices that includes how
> SoundWire enumeration address and Link ID are used to represented in
> SoundWire slave device tree nodes.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---
>  .../soundwire/soundwire-controller.yaml       | 75 +++++++++++++++++++
>  1 file changed, 75 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/soundwire/soundwire-controller.yaml
> 
> diff --git a/Documentation/devicetree/bindings/soundwire/soundwire-controller.yaml b/Documentation/devicetree/bindings/soundwire/soundwire-controller.yaml
> new file mode 100644
> index 000000000000..91aa6c6d6266
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/soundwire/soundwire-controller.yaml
> @@ -0,0 +1,75 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/soundwire/soundwire-controller.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SoundWire Controller Generic Binding

Controller does not make sense here, why not use spec terminology and
say "SoundWire Slave Generic Binding"

> +
> +maintainers:
> +  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> +
> +description: |
> +  SoundWire busses can be described with a node for the SoundWire controller
> +  device and a set of child nodes for each SoundWire slave on the bus.
> +
> +properties:
> +  $nodename:
> +    pattern: "^soundwire(@.*|-[0-9a-f])*$"
> +
> +  "#address-cells":
> +    const: 2
> +
> +  "#size-cells":
> +    const: 0
> +
> +patternProperties:
> +  "^.*@[0-9a-f]+$":
> +    type: object
> +
> +    properties:
> +      compatible:
> +      pattern: "^sdw[0-9][0-9a-f]{4}[0-9a-f]{4}[0-9a-f]{2}$"
> +      description:
> +	  Is the textual representation of SoundWire Enumeration
> +	  address. compatible string should contain SoundWire Version ID,
> +	  Manufacturer ID, Part ID and Class ID in order and shall be in
> +	  lower-case hexadecimal with leading zeroes.
> +	  Valid sizes of these fields are
> +	  Version ID is 1 nibble, number '0x1' represents SoundWire 1.0
> +	  and '0x2' represents SoundWire 1.1 and so on.
> +	  MFD is 4 nibbles
> +	  PID is 4 nibbles
> +	  CID is 2 nibbles
> +	  More Information on detail of encoding of these fields can be
> +	  found in MIPI Alliance DisCo & SoundWire 1.0 Specifications.
> +
> +      reg:
> +        maxItems: 1
> +        description:
> +          Instance ID and Link ID of SoundWire Device Address.

This looks better :) Thanks.

Apart from the minor nit above this looks good to me, I can merge the
sdw parts if Rob is fine with them.

Thanks

> +
> +    required:
> +      - compatible
> +      - reg
> +
> +examples:
> +  - |
> +    soundwire@c2d0000 {
> +        #address-cells = <2>;
> +        #size-cells = <0>;
> +        compatible = "qcom,soundwire-v1.5.0";
> +        reg = <0x0c2d0000 0x2000>;
> +
> +        speaker@1 {
> +            compatible = "sdw10217201000";
> +            reg = <1 0>;
> +        };
> +
> +        speaker@2 {
> +            compatible = "sdw10217201000";
> +            reg = <2 0>;
> +        };
> +    };
> +
> +...
> -- 
> 2.21.0

-- 
~Vinod
