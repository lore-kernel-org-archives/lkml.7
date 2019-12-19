Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11331C2D0C1
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 20:45:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8D4B2465E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 20:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576788330;
	bh=1WFENB9TZCLJoGhZCzeEs8fDyQMYhkhpRYT9Qmdya1k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=vb5wGS9sE28EY6/fSCKsaOIyd96LirRsgVJO7Krj+I5rYDJrCCwV47MpKvc6PNzPP
	 mbVn/AW4/8vJjszjtzhblhyIEPrHyX6i/dwz7fSDLWiWnt6fx71RVlUGlDIBNwk6Yj
	 WUIYu0T9EX4hACnZgtkpcIA413RVozuK2E16Ixdw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727276AbfLSUp3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 15:45:29 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:34791 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbfLSUp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 15:45:29 -0500
Received: by mail-ot1-f65.google.com with SMTP id a15so8819783otf.1;
        Thu, 19 Dec 2019 12:45:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QEdi/9BuWv68+yRkoA3WGe3MPqpNQsr5gKwCLiu+7aE=;
        b=Hm6JxHnsr3fKGwiLJuRcgLv+05VsfH0NSInb5w49Wl9J7HIHRMzbG9NOgSfeQOfr9r
         VYZcKdyoBrZ5DzuyVpuFLtvXxAlAFh/+SDuPmn2mstQt52fRMjuOZM3YGSv17/NfEpsR
         +3XATTViLvvv1zeYCC3rQitFuxuw4nG9NJWIpVOSVhD+rS2Juzi4i3l+UCMZlS9mUR2K
         qtSfZQFWrYeTbcVo4afeBV9ZIl3ysibwSHVlQtB2BY7oOCEnivOr9+l5x8mNi08jS38A
         Nm/NxJlZ+OxlSkzzq9NhLOcMqLNayTwqicMZy3gEX2s81HRS4vuRVuYVtjqFkdPiN8JC
         nVhw==
X-Gm-Message-State: APjAAAXC9I+f3EtQAhd53I+3JUjFYdPu4O018lutTzCDxn54oO+BLA05
        F32Y3trEClvvAxYf6oEDYg==
X-Google-Smtp-Source: APXvYqxb/DX+sti/X1j7P3N+qjVkbNkerswgHzEY3dYk7v6gSucevN2LN9Hfh/8ZnQcAC3TCXUj3rg==
X-Received: by 2002:a9d:6acd:: with SMTP id m13mr8096032otq.313.1576788328038;
        Thu, 19 Dec 2019 12:45:28 -0800 (PST)
Received: from localhost (ip-184-205-110-29.ftwttx.spcsdns.net. [184.205.110.29])
        by smtp.gmail.com with ESMTPSA id t203sm2392233oig.39.2019.12.19.12.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 12:45:27 -0800 (PST)
Date:   Thu, 19 Dec 2019 14:45:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Boichat <drinkcat@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrzej Hajda <a.hajda@samsung.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        p.zabel@pengutronix.de,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Matthias Brugger <mbrugger@suse.com>,
        Russell King <rmk+kernel@arm.linux.org.uk>
Subject: Re: [PATCH RESEND 1/4] dt-bindings: drm/bridge: analogix-anx7688:
 Add ANX7688 transmitter binding
Message-ID: <20191219204524.GA7841@bogus>
References: <20191211061911.238393-1-hsinyi@chromium.org>
 <20191211061911.238393-2-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191211061911.238393-2-hsinyi@chromium.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 02:19:08PM +0800, Hsin-Yi Wang wrote:
> From: Nicolas Boichat <drinkcat@chromium.org>
> 
> Add support for analogix,anx7688
> 
> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
> Change from RFC to v1:
> - txt to yaml
> ---
>  .../bindings/display/bridge/anx7688.yaml      | 60 +++++++++++++++++++
>  1 file changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/anx7688.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/anx7688.yaml b/Documentation/devicetree/bindings/display/bridge/anx7688.yaml
> new file mode 100644
> index 000000000000..cf79f7cf8fdf
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/anx7688.yaml
> @@ -0,0 +1,60 @@
> +# SPDX-License-Identifier: GPL-2.0
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/bridge/anx7688.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analogix ANX7688 SlimPort (Single-Chip Transmitter for DP over USB-C)
> +
> +maintainers:
> +  - Nicolas Boichat <drinkcat@chromium.org>
> +
> +description: |
> +  The ANX7688 is a single-chip mobile transmitter to support 4K 60 frames per
> +  second (4096x2160p60) or FHD 120 frames per second (1920x1080p120) video
> +  resolution from a smartphone or tablet with full function USB-C.
> +
> +  This binding only describes the HDMI to DP display bridge.
> +
> +properties:
> +  compatible:
> +    const: analogix,anx7688
> +
> +  reg:
> +    maxItems: 1
> +    description: I2C address of the device
> +
> +  ports:
> +    type: object
> +
> +    properties:
> +      port@0:
> +        type: object
> +        description: |
> +          Video port for HDMI input
> +
> +      port@1:
> +        type: object
> +        description: |
> +          Video port for eDP output
> +
> +    required:
> +      - port@0

Sometimes you have no output?

> +
> +required:
> +  - compatible
> +  - reg
> +  - ports

The example will have errors because it is missing 'ports'. Run 'make 
dt_binding_check'.

Add:

additionalProperties: false

> +
> +examples:
> +  - |
> +    anx7688: anx7688@2c {
> +      compatible = "analogix,anx7688";
> +      reg = <0x2c>;
> +
> +      port {
> +        anx7688_in: endpoint {
> +          remote-endpoint = <&hdmi0_out>;
> +        };
> +      };
> +    };
> -- 
> 2.24.0.525.g8f36a354ae-goog
> 
