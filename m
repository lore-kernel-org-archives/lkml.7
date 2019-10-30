Return-Path: <SRS0=iR9I=YX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA820CA9EC7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 23:17:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89FDB2087F
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Oct 2019 23:17:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="yuBlehyh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbfJ3XRJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Oct 2019 19:17:09 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:42582 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726677AbfJ3XRI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Oct 2019 19:17:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=ZgKGJ98QB0gP/+GLbKgAYSif2cfIQOt7fPddnuAlRsI=; b=yuBlehyhEqvE5ANG3sGHX2QhMs
        /Vv5hS6OuVcHcpYeoc6a1i18gIXhncNwKTu/fP73gKUaWD42wBWOAenYU+wNmbPXOGVG+e+M9xkp7
        Qk+F/dQDNI7JSLTm5u3DqYxE17/sI47Md8QRkIgfa3piDqTC+dSvnRpMGDhfzh8UFYgM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.92.2)
        (envelope-from <andrew@lunn.ch>)
        id 1iPxD8-0005Wy-QP; Thu, 31 Oct 2019 00:17:06 +0100
Date:   Thu, 31 Oct 2019 00:17:06 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [RFC PATCH 2/3] dt-bindings: net: phy: Add support for AT803X
Message-ID: <20191030231706.GG10555@lunn.ch>
References: <20191030224251.21578-1-michael@walle.cc>
 <20191030224251.21578-3-michael@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030224251.21578-3-michael@walle.cc>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 30, 2019 at 11:42:50PM +0100, Michael Walle wrote:
> Document the Atheros AR803x PHY bindings.
> 
> Signed-off-by: Michael Walle <michael@walle.cc>
> ---
>  .../bindings/net/atheros,at803x.yaml          | 58 +++++++++++++++++++
>  include/dt-bindings/net/atheros-at803x.h      | 13 +++++
>  2 files changed, 71 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/atheros,at803x.yaml
>  create mode 100644 include/dt-bindings/net/atheros-at803x.h
> 
> diff --git a/Documentation/devicetree/bindings/net/atheros,at803x.yaml b/Documentation/devicetree/bindings/net/atheros,at803x.yaml
> new file mode 100644
> index 000000000000..60500fd90fd8
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/atheros,at803x.yaml
> @@ -0,0 +1,58 @@
> +# SPDX-License-Identifier: GPL-2.0+
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/atheros,at803x.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Atheros AR803x PHY
> +
> +maintainers:
> +  - TBD

Hi Michael

If you don't want to maintain it, then list the PHY maintainers.

> +
> +description: |
> +  Bindings for Atheros AR803x PHYs
> +
> +allOf:
> +  - $ref: ethernet-phy.yaml#
> +
> +properties:
> +  atheros,clk-out-frequency:
> +    description: Clock output frequency in Hertz.
> +    enum: [ 25000000, 50000000, 62500000, 125000000 ]
> +
> +  atheros,clk-out-strength:
> +    description: Clock output driver strength.
> +    enum: [ 0, 1, 2 ]
> +
> +  atheros,keep-pll-enabled:
> +    description: |
> +      If set, keep the PLL enabled even if there is no link. Useful if you
> +      want to use the clock output without an ethernet link.
> +    type: boolean
> +
> +  atheros,rgmii-io-1v8:
> +    description: |
> +      The PHY supports RGMII I/O voltages of 2.5V, 1.8V and 1.5V. By default,
> +      the PHY uses a voltage of 1.5V. If this is set, the voltage will changed
> +      to 1.8V.
> +      The 2.5V voltage is only supported with an external supply voltage.

So we can later add atheros,rgmii-io-2v5. That might need a regulator
as well. Maybe add that 2.5V is currently not supported.

   Andrew
