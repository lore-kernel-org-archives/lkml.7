Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D9F1C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 06:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1ADD220882
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 06:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554014557;
	bh=8eb3k+EwjoDCpB0zasMMfc/DJ9YotPdIvaL1XdSR93E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=s8Q8VJC2iJWaRs6WXbX5CY2rKxi+RpabUlv0CHLhDJg4Ff6J5EIyMhw7appn4XHPQ
	 RR2ojr6uy4TbNISocXtQcN+KHhtJo4z817xCTpBf5eMYDxJpTcgmrU3VJiLBCrMbzh
	 pkllFSsVXsdWpLERibDqfBSc6HDC4l4rFWFExDhQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731517AbfCaGmf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 02:42:35 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46231 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731500AbfCaGmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 02:42:33 -0400
Received: by mail-pg1-f195.google.com with SMTP id q1so3143152pgv.13;
        Sat, 30 Mar 2019 23:42:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=AtFc08IiLC6GeXp4UiEfdqnOSmCZZjGUscVqzxJFTV0=;
        b=DdPt0oKmnsIRrYdQhqzwGLriPJj6OVsJcJCGvM/dxR9+iC6kzl4u+ZXOBBoHLnab9q
         q/tV/+1vsR3agIrqfawISFL/Izkuysytl/vFdCzf8Rnf01JcIf1UqocNh7DxwwnqGch5
         GJt/AySpg6HAcEtLeJ9oVuZ2coFWwcpWhw37Evc6xDBaPI8iH/cNeeN/+0Y7V2T5J6Ep
         S8C5E1I5R7WHMaU0AstGek9KjOHldKx14l7F8bh/MLQ4MMkdmcA53yBLJuKl0lpO+nZ5
         qTIqJuKqm7LYLN8eQwYSZvcxupJAxWC2akxvINoDtePJDhpIuhk8Dy1fhYXixhsqAGCE
         Zu7w==
X-Gm-Message-State: APjAAAWwAseGKfNfJ4SKDxjf87WffVYw1wKjRc70ADGgV8ZeROyIa5Du
        6p+6JJQXJpr2ZqOj+HNSvw==
X-Google-Smtp-Source: APXvYqwjaSgWYdUj9fGHbf9Sf3BhKyhFQKbk08o4T29s4ASwf9nXKroLqQd/3M0gDTwv2/0eRwuhZw==
X-Received: by 2002:a65:6144:: with SMTP id o4mr17341314pgv.247.1554014552810;
        Sat, 30 Mar 2019 23:42:32 -0700 (PDT)
Received: from localhost ([210.160.217.68])
        by smtp.gmail.com with ESMTPSA id z77sm12221108pfi.155.2019.03.30.23.42.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Mar 2019 23:42:32 -0700 (PDT)
Message-ID: <5ca06158.1c69fb81.bd33a.eaae@mx.google.com>
Date:   Sun, 31 Mar 2019 01:42:30 -0500
From:   Rob Herring <robh@kernel.org>
To:     yongqiang.niu@mediatek.com
Cc:     ck.hu@mediatek.com, p.zabel@pengutronix.de, matthias.bgg@gmail.com,
        airlied@linux.ie, mark.rutland@arm.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, Bibby.Hsieh@mediatek.com,
        yt.shen@mediatek.com
Subject: Re: [PATCH v2 02/25] dt-bindings: mediatek: add binding for mt8183
 display
References: <1553667561-25447-1-git-send-email-yongqiang.niu@mediatek.com>
 <1553667561-25447-3-git-send-email-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1553667561-25447-3-git-send-email-yongqiang.niu@mediatek.com>
X-Mutt-References: <1553667561-25447-3-git-send-email-yongqiang.niu@mediatek.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 27, 2019 at 02:18:58PM +0800, yongqiang.niu@mediatek.com wrote:
> From: Yongqiang Niu <yongqiang.niu@mediatek.com>
> 
> Update device tree binding documention for the display subsystem for
> Mediatek MT8183 SOCs
> 
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  .../bindings/display/mediatek/mediatek,disp.txt    | 37 ++++++++++++++--------
>  1 file changed, 23 insertions(+), 14 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
> index 8469de5..5467470c 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
> @@ -27,20 +27,23 @@ Documentation/devicetree/bindings/display/mediatek/mediatek,dpi.txt.
>  
>  Required properties (all function blocks):
>  - compatible: "mediatek,<chip>-disp-<function>", one of
> -	"mediatek,<chip>-disp-ovl"   - overlay (4 layers, blending, csc)
> -	"mediatek,<chip>-disp-rdma"  - read DMA / line buffer
> -	"mediatek,<chip>-disp-wdma"  - write DMA
> -	"mediatek,<chip>-disp-color" - color processor
> -	"mediatek,<chip>-disp-aal"   - adaptive ambient light controller
> -	"mediatek,<chip>-disp-gamma" - gamma correction
> -	"mediatek,<chip>-disp-merge" - merge streams from two RDMA sources
> -	"mediatek,<chip>-disp-split" - split stream to two encoders
> -	"mediatek,<chip>-disp-ufoe"  - data compression engine
> -	"mediatek,<chip>-dsi"        - DSI controller, see mediatek,dsi.txt
> -	"mediatek,<chip>-dpi"        - DPI controller, see mediatek,dpi.txt
> -	"mediatek,<chip>-disp-mutex" - display mutex
> -	"mediatek,<chip>-disp-od"    - overdrive
> -  the supported chips are mt2701, mt2712 and mt8173.
> +	"mediatek,<chip>-disp-ovl"   		- overlay (4 layers, blending, csc)
> +	"mediatek,<chip>-disp-ovl-2l"   	- overlay (2 layers, blending, csc)
> +	"mediatek,<chip>-disp-rdma"  		- read DMA / line buffer
> +	"mediatek,<chip>-disp-wdma"  		- write DMA
> +	"mediatek,<chip>-disp-ccorr" 		- color correction
> +	"mediatek,<chip>-disp-color" 		- color processor
> +	"mediatek,<chip>-disp-dither" 		- dither
> +	"mediatek,<chip>-disp-aal"   		- adaptive ambient light controller
> +	"mediatek,<chip>-disp-gamma" 		- gamma correction
> +	"mediatek,<chip>-disp-merge" 		- merge streams from two RDMA sources
> +	"mediatek,<chip>-disp-split" 		- split stream to two encoders
> +	"mediatek,<chip>-disp-ufoe"  		- data compression engine
> +	"mediatek,<chip>-dsi"        		- DSI controller, see mediatek,dsi.txt
> +	"mediatek,<chip>-dpi"        		- DPI controller, see mediatek,dpi.txt
> +	"mediatek,<chip>-disp-mutex" 		- display mutex
> +	"mediatek,<chip>-disp-od"    		- overdrive
> +  the supported chips are mt2701, mt2712, mt8173 and mt8183.
>  - reg: Physical base address and length of the function block register space
>  - interrupts: The interrupt signal from the function block (required, except for
>    merge and split function blocks).
> @@ -71,6 +74,12 @@ mmsys: clock-controller@14000000 {
>  	#clock-cells = <1>;
>  };
>  
> +display_components: dispsys@14000000 {
> +		compatible = "mediatek,mt8183-display";

Documented?

> +		reg = <0 0x14000000 0 0x1000>;
> +		power-domains = <&scpsys MT8183_POWER_DOMAIN_DISP>;
> +};
> +
>  ovl0: ovl@1400c000 {
>  	compatible = "mediatek,mt8173-disp-ovl";
>  	reg = <0 0x1400c000 0 0x1000>;
> -- 
> 1.8.1.1.dirty
> 

