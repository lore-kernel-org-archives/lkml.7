Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4586C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 21:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 900DF21D7D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 21:10:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576789855;
	bh=lQERu9alBwf503Vc41Dj/ZKViSToATPMJz5twGxpqgI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=s7kSKx+i/5NrPLIJ2sUyISzd88MUQFo7dCBM/KN2p8ibhyzxhkzwUz27XqW/slECQ
	 uQ1yhxQOugy+dEV60NVPxYKfaerGdMupJzwB+IxjRJ35E7P/ALuSxBu4VrAJZsqyd9
	 sDk2rPFFmTbgTCCzGoqjNB6Rn2cxiy8kbIPTgRGY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbfLSVKy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 16:10:54 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44963 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbfLSVKy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 16:10:54 -0500
Received: by mail-ot1-f65.google.com with SMTP id h9so6309138otj.11;
        Thu, 19 Dec 2019 13:10:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=kdIcXkG3q+6Tp6qJkg61HxwVk6Xb+NLQK9ho5n/HPpg=;
        b=mn4aKrbBTAcFWAUd1Wh4OPflXLfCV0HL3DJu35sZpmJWc3bpYjEP+kHncXZalgm8BP
         5i6vaPxXL42sHBXANrGEe2y2DEp88V9OSQ1yw8nP4HVB/faxPNjVVEOzZHKg6SZB0OyS
         xg8MNlfpk2jFBnl7Px7MZo3vFL69WzL5AJ4UITssVi9XWz1BNcMHeU6rCgvY+AbTDHoX
         3zB/tjBOejqq6g4BdpUqhUsl4r7DsJk4mbicWM6wUyJBo9IUxVXr8ImnwV4TDf80xu1h
         1uPPE/IDIa7nC6cU7CtY4ptweai9Cm4ZPBSHiFk1bLO4YzL+4ihiLNcoGpN8TZfdLKKk
         IuZw==
X-Gm-Message-State: APjAAAWkSjqG5P/LgHf/OVHWNGuCdh+aQofft3hT91dKFC1wQog9YhUk
        9HOPlvWqzsyXkMrA9FY02Q==
X-Google-Smtp-Source: APXvYqyWwc0KqeYK5GLuZwGu9o5s8XYZqL3nuqpxPP87JVURXgzBHlQXhWwSr7SlCvGX0+pv00UsZA==
X-Received: by 2002:a05:6830:160c:: with SMTP id g12mr10696228otr.82.1576789853254;
        Thu, 19 Dec 2019 13:10:53 -0800 (PST)
Received: from localhost (ip-184-205-110-29.ftwttx.spcsdns.net. [184.205.110.29])
        by smtp.gmail.com with ESMTPSA id z21sm2534203oto.52.2019.12.19.13.10.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2019 13:10:52 -0800 (PST)
Date:   Thu, 19 Dec 2019 15:10:50 -0600
From:   Rob Herring <robh@kernel.org>
To:     Yuti Amonkar <yamonkar@cadence.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kishon@ti.com, mark.rutland@arm.com, jsarha@ti.com,
        tomi.valkeinen@ti.com, praneeth@ti.com, mparab@cadence.com,
        sjakhade@cadence.com
Subject: Re: [RESEND PATCH v1 02/15] dt-bindings:phy: Convert Cadence MHDP
 PHY bindings to YAML.
Message-ID: <20191219211050.GA1841@bogus>
References: <1576069760-11473-1-git-send-email-yamonkar@cadence.com>
 <1576069760-11473-3-git-send-email-yamonkar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1576069760-11473-3-git-send-email-yamonkar@cadence.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 02:09:07PM +0100, Yuti Amonkar wrote:
> - Convert the MHDP PHY devicetree bindings to yaml schemas.
> - Rename DP PHY to have generic Torrent PHY nomrnclature.
> - Rename compatible string from "cdns,dp-phy" to "cdns,torrent-phy".

You can't just change compatible strings. It's an ABI. Unless you know 
for sure there are no users that would care.

> 
> Signed-off-by: Yuti Amonkar <yamonkar@cadence.com>
> ---
>  .../devicetree/bindings/phy/phy-cadence-dp.txt     | 30 ------------
>  .../bindings/phy/phy-cadence-torrent.yaml          | 57 ++++++++++++++++++++++
>  2 files changed, 57 insertions(+), 30 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/phy/phy-cadence-dp.txt
>  create mode 100644 Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-cadence-dp.txt b/Documentation/devicetree/bindings/phy/phy-cadence-dp.txt
> deleted file mode 100644
> index 7f49fd54e..0000000
> --- a/Documentation/devicetree/bindings/phy/phy-cadence-dp.txt
> +++ /dev/null
> @@ -1,30 +0,0 @@
> -Cadence MHDP DisplayPort SD0801 PHY binding
> -===========================================
> -
> -This binding describes the Cadence SD0801 PHY hardware included with
> -the Cadence MHDP DisplayPort controller.
> -
> --------------------------------------------------------------------------------
> -Required properties (controller (parent) node):
> -- compatible	: Should be "cdns,dp-phy"
> -- reg		: Defines the following sets of registers in the parent
> -		  mhdp device:
> -			- Offset of the DPTX PHY configuration registers
> -			- Offset of the SD0801 PHY configuration registers
> -- #phy-cells	: from the generic PHY bindings, must be 0.
> -
> -Optional properties:
> -- num_lanes	: Number of DisplayPort lanes to use (1, 2 or 4)
> -- max_bit_rate	: Maximum DisplayPort link bit rate to use, in Mbps (2160,
> -		  2430, 2700, 3240, 4320, 5400 or 8100)
> --------------------------------------------------------------------------------
> -
> -Example:
> -	dp_phy: phy@f0fb030a00 {
> -		compatible = "cdns,dp-phy";
> -		reg = <0xf0 0xfb030a00 0x0 0x00000040>,
> -		      <0xf0 0xfb500000 0x0 0x00100000>;
> -		num_lanes = <4>;
> -		max_bit_rate = <8100>;
> -		#phy-cells = <0>;
> -	};
> diff --git a/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
> new file mode 100644
> index 0000000..4fa9d0a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml

Normal file naming is using the compatible string.

> @@ -0,0 +1,57 @@
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/phy/phy-cadence-torrent.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Cadence Torrent SD0801 PHY binding for DisplayPort
> +
> +description:
> +  This binding describes the Cadence SD0801 PHY hardware included with
> +  the Cadence MHDP DisplayPort controller.
> +
> +maintainers:
> +  - Swapnil Jakhade <sjakhade@cadence.com>
> +  - Yuti Amonkar <yamonkar@cadence.com>
> +
> +properties:
> +  compatible:
> +    const: cdns,torrent-phy
> +
> +  reg:
> +    items:
> +      - description: Offset of the DPTX PHY configuration registers.
> +      - description: Offset of the SD0801 PHY configuration registers.
> +
> +  "#phy-cells":
> +    const: 0
> +
> +  num_lanes:
> +    description:
> +      Number of DisplayPort lanes.
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - enum: [1, 2, 4]
> +
> +  max_bit_rate:
> +    description:
> +      Maximum DisplayPort link bit rate to use, in Mbps
> +    allOf:
> +      - $ref: /schemas/types.yaml#/definitions/uint32
> +      - enum: [2160, 2430, 2700, 3240, 4320, 5400, 8100]
> +
> +required:
> +  - compatible
> +  - reg
> +  - "#phy-cells"
> +
> +examples:
> +  - |
> +    dp_phy: phy@f0fb030a00 {
> +          compatible = "cdns,torrent-phy";
> +          reg = <0xf0 0xfb030a00 0x0 0x00000040>,
> +                <0xf0 0xfb500000 0x0 0x00100000>;
> +          num_lanes = <4>;
> +          max_bit_rate = <8100>;
> +          #phy-cells = <0>;
> +    };
> +...
> -- 
> 2.7.4
> 
