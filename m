Return-Path: <SRS0=lTpO=2Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C8E0C3F68F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 21:29:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FB5121734
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Jan 2020 21:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578173358;
	bh=3F8HVDANPGJIQVBGriQO/lQDfoplMWcL4UlGPr6P6lI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aYEXGTmt1DZuxG3DSXJPDESJ8ZFTDclPDSEWg+cAlQ+ybful99LP8y9xVPAzBbYoU
	 pKUhQFVrsIACOFY1uIh9+SynYUPosT8xHmZEk1RXtMAHckmeLIiw7w1d5QG8IwDyX9
	 jAiVwH50DrcuL0Mws2dSoUL7rDGkV1T0YRss6hy4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbgADV3Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jan 2020 16:29:16 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:40670 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726135AbgADV3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jan 2020 16:29:16 -0500
Received: by mail-il1-f193.google.com with SMTP id c4so39407077ilo.7
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jan 2020 13:29:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=acrY0+kOQM/iuVtgKfbOatR4QIHvs7UJPcpx6jaaklw=;
        b=kdyI50HQpV254cjvSbysCKD0AgpF1CHZjMQFTqZTkpu5mjO6uBE6LKPx3o9w2ziQWD
         An7gyRFLhNdn479v9tNxdmzUe85v11h10H7j8ypz08Pg/kgrRwHNbhE68m6FYZscarUC
         VdUstacAe/kqNd93O0iUKXkzKE/Fm5BUpjVmaFRFTOYvExIiZjddmwnxGHcX8GmOKwvE
         gXM+lgdJZi2zc7IR2SilP/7j8R09iMA4izNVKXO2jLrC/PEQZAdrOt0YmYXR0MdSYl1W
         rLvDW8gcUH2SC8u2IMv1/3ZlhusyrdMJEDf+P2Z4xlJoQmWrK6nAMZ2ZgTE9F5U6GpJz
         t/tw==
X-Gm-Message-State: APjAAAVVUaBizLMGRC0yaFaipqEiByjpRlS7VjccVXQd4nwWbMZcXPND
        Y6aYtFLCQkNOiLPjJGmsho00apk=
X-Google-Smtp-Source: APXvYqxh/T5NNs/mWpDIIJx622YVKiDu6q/j9PvDIey61lWuSgNF12K/9NzSO3HrfP06+jmFMpKqrw==
X-Received: by 2002:a92:9184:: with SMTP id e4mr83753244ill.70.1578173355396;
        Sat, 04 Jan 2020 13:29:15 -0800 (PST)
Received: from rob-hp-laptop ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id t17sm22317120ilb.29.2020.01.04.13.29.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jan 2020 13:29:14 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 2219b7
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Sat, 04 Jan 2020 14:29:13 -0700
Date:   Sat, 4 Jan 2020 14:29:13 -0700
From:   Rob Herring <robh@kernel.org>
To:     Yuti Amonkar <yamonkar@cadence.com>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, maxime@cerno.tech, airlied@linux.ie,
        daniel@ffwll.ch, mark.rutland@arm.com, a.hajda@samsung.com,
        narmstrong@baylibre.com, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@siol.net, praneeth@ti.com,
        jsarha@ti.com, tomi.valkeinen@ti.com, mparab@cadence.com,
        sjakhade@cadence.com
Subject: Re: [PATCH v2 1/3] dt-bindings: drm/bridge: Document Cadence MHDP
 bridge bindings in yaml format
Message-ID: <20200104212913.GA12151@bogus>
References: <1577114202-15970-1-git-send-email-yamonkar@cadence.com>
 <1577114202-15970-2-git-send-email-yamonkar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1577114202-15970-2-git-send-email-yamonkar@cadence.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 23, 2019 at 04:16:40PM +0100, Yuti Amonkar wrote:
> Document the bindings used for the Cadence MHDP DPI/DP bridge in
> yaml format.
> 
> Signed-off-by: Yuti Amonkar <yamonkar@cadence.com>
> ---
>  .../bindings/display/bridge/cdns,mhdp.yaml         | 109 +++++++++++++++++++++
>  1 file changed, 109 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/bridge/cdns,mhdp.yaml
> 
> diff --git a/Documentation/devicetree/bindings/display/bridge/cdns,mhdp.yaml b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp.yaml
> new file mode 100644
> index 0000000..aed6224
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/bridge/cdns,mhdp.yaml
> @@ -0,0 +1,109 @@
> +%YAML 1.2
> +---
> +$id: "http://devicetree.org/schemas/display/bridge/cdns,mhdp.yaml#"
> +$schema: "http://devicetree.org/meta-schemas/core.yaml#"
> +
> +title: Cadence MHDP bridge
> +
> +maintainers:
> +  - Swapnil Jakhade <sjakhade@cadence.com>
> +  - Yuti Amonkar <yamonkar@cadence.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - cdns,mhdp8546
> +      - ti,j721e-mhdp8546
> +
> +  clocks:
> +    maxItems: 1
> +    description:
> +      DP bridge clock, it's used by the IP to know how to translate a number of
> +      clock cycles into a time (which is used to comply with DP standard timings
> +      and delays).
> +
> +  reg:
> +    minItems: 1
> +    maxItems: 2
> +    items:
> +      - description:
> +          Register block of mhdptx apb registers upto PHY mapped area(AUX_CONFIG_P).
> +          The AUX and PMA registers are mapped to associated phy driver.
> +      - description:
> +          Register block for DSS_EDP0_INTG_CFG_VP registers in case of TI J7 SoCs.
> +
> +  reg-names:
> +    minItems: 1
> +    maxItems: 2
> +    items:
> +      - const: mhdptx
> +      - const: j721e-intg
> +
> +  phys:
> +    description: see the Documentation/devicetree/bindings/phy/phy-cadence-torrent.yaml
> +
> +  phy-names:
> +    const: dpphy
> +
> +  ports:
> +    type: object
> +    description:
> +      Ports as described in Documentation/devicetree/bindings/graph.txt
> +    properties:
> +       '#address-cells':
> +         const: 1
> +       '#size-cells':
> +         const: 0
> +       port@0:

type: object

> +         description:
> +           input port representing the DP bridge input
> +
> +       port@1:

type: object

> +         description:
> +           output port representing the DP bridge output
> +    required:
> +      - port@0
> +      - port@1
> +      - '#address-cells'
> +      - '#size-cells'
> +
> +required:
> +  - compatible
> +  - clocks
> +  - reg
> +  - phys
> +  - phy-names
> +  - ports
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    mhdp: dp-bridge@f0fb000000 {
> +        compatible = "cdns,mhdp8546";
> +        reg = <0xf0 0xfb000000 0x0 0x1000000>,
> +              <0xf0 0xfc000000 0x0 0x2000000>;
> +        clocks = <&mhdp_clock>;
> +        phys = <&dp_phy>;
> +        phy-names = "dpphy";
> +
> +        ports {
> +              #address-cells = <1>;
> +              #size-cells = <0>;
> +
> +              port@0 {
> +                     reg = <0>;
> +                     dp_bridge_input: endpoint {
> +                                    remote-endpoint = <&xxx_dpi_output>;
> +                     };
> +              };
> +
> +              port@1 {
> +                     reg = <1>;
> +                     dp_bridge_output: endpoint {
> +                                     remote-endpoint = <&xxx_dp_connector_input>;
> +                     };
> +              };
> +      };
> +    };
> +...
> -- 
> 2.7.4
> 
