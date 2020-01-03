Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C9FFC00523
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 22:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DBF0227BF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 22:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578090410;
	bh=HiU//N94Vl6wij2RpULeJtTyqG9XDs5TxrzybVZG+ds=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=A+cz7oclOOP0O8+HIaiRs6+RREgOigATC+COmmMaVhrdg8Y0ylNopqJyQ+aOdN0ze
	 fGztjKg6oqPaXMHjhQEcXGuig/Tk661JtZ7a7fAwW/a+4s4HIXc6ld3LnnaRBtBw40
	 ZV2cDkNyzlwXXpSRtweF8unOm4acIxr7qm2pEJgA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728815AbgACW0t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 17:26:49 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:46849 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728711AbgACW0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 17:26:49 -0500
Received: by mail-il1-f194.google.com with SMTP id t17so37798530ilm.13
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jan 2020 14:26:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nH8EiEpsw3qEqxTu/vy8rZgCVIsth2Q4jMx+TyJClBo=;
        b=K76b2eYnd1UgjO4gWlGoEmshz3XC5dSZ4ohlHB/v0NUZlAUa4D7L5uFS44Ky5ZPv3r
         UWLw8aGwcr9oGwbUubOOoPWFmMpkrm9P5UE7TgpU0amILOF90CfEksVXzacakJ79t3Hx
         XlRHX2dvyp9BOwiTViip4ihs/vqAIMKbgAJysyfR6m2Kt1NmXLCh50bh8MCST3Sm2UYg
         VxAPBC/Lake7QCe3Gi84fyPbiarifp6hfTNfLZHo7HxuwyKSDo8OWWB/ihjZmVDTSvMd
         /BRyXGNKuQCGY3h5fo+0DPam0u0NSrmH6y9crhkSkKMsMe7rqKAkOTnaMBliFqNc3ahV
         IW/w==
X-Gm-Message-State: APjAAAVG9HXd8FSkpT8b345OdBty7griS4j5XGT6bDqA6s3y6pJm4RY9
        X4SS7Lfg1xYLAkBxgXVMNweLFNw=
X-Google-Smtp-Source: APXvYqyhUz61MDzXhLtQQC3YolJS0HLp3NP5NVmr0Pc9jLR8x8yJvYcy1+P9FnP4H2PNrhu+eqBNWA==
X-Received: by 2002:a92:4781:: with SMTP id e1mr74704476ilk.147.1578090407908;
        Fri, 03 Jan 2020 14:26:47 -0800 (PST)
Received: from rob-hp-laptop ([64.188.179.251])
        by smtp.gmail.com with ESMTPSA id 81sm21338761ilx.40.2020.01.03.14.26.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2020 14:26:46 -0800 (PST)
Received: from rob (uid 1000)
        (envelope-from rob@rob-hp-laptop)
        id 2219a5
        by rob-hp-laptop (DragonFly Mail Agent v0.11);
        Fri, 03 Jan 2020 15:26:45 -0700
Date:   Fri, 3 Jan 2020 15:26:45 -0700
From:   Rob Herring <robh@kernel.org>
To:     Yongqiang Niu <yongqiang.niu@mediatek.com>
Cc:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [RESEND PATCH v6 01/17] dt-bindings: mediatek: add
 rdma_fifo_size description for mt8183 display
Message-ID: <20200103222645.GA24430@bogus>
References: <1578021148-32413-1-git-send-email-yongqiang.niu@mediatek.com>
 <1578021148-32413-2-git-send-email-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1578021148-32413-2-git-send-email-yongqiang.niu@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 03, 2020 at 11:12:12AM +0800, Yongqiang Niu wrote:
> Update device tree binding documention for rdma_fifo_size

Typo. And write complete sentences.

> 
> Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> ---
>  .../devicetree/bindings/display/mediatek/mediatek,disp.txt  | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
> index 681502e..34bef44 100644
> --- a/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
> +++ b/Documentation/devicetree/bindings/display/mediatek/mediatek,disp.txt
> @@ -70,6 +70,10 @@ Required properties (DMA function blocks):
>    argument, see Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
>    for details.
>  
> +Required properties (DMA function blocks):
> +- mediatek,rdma_fifo_size: rdma fifo size may be different even in same SOC, add this
> +  property to the corresponding rdma

s/_/-/

Valid values? Max value?

> +
>  Examples:
>  
>  mmsys: clock-controller@14000000 {
> @@ -211,3 +215,12 @@ od@14023000 {
>  	power-domains = <&scpsys MT8173_POWER_DOMAIN_MM>;
>  	clocks = <&mmsys CLK_MM_DISP_OD>;
>  };
> +
> +rdma1: rdma@1400c000 {
> +	compatible = "mediatek,mt8183-disp-rdma";
> +	reg = <0 0x1400c000 0 0x1000>;
> +	interrupts = <GIC_SPI 229 IRQ_TYPE_LEVEL_LOW>;
> +	power-domains = <&scpsys MT8183_POWER_DOMAIN_DISP>;
> +	clocks = <&mmsys CLK_MM_DISP_RDMA1>;
> +	mediatek,rdma_fifo_size = <2048>;
> +};

A new property doesn't really warrant a whole new example.

> \ No newline at end of file

^^^

> -- 
> 1.8.1.1.dirty
