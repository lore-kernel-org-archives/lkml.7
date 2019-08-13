Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21B5FC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 16:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7CC220651
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 16:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565712293;
	bh=CxzlDL8WXRrCpthti+tcpLB2VPlmPMGeN29MnXeV5HI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QHmK8LgDwppa/ASZn+fV6JxR5yjfVxlHynomWZYF4fWdybZ7NLVOStQx+LfsdFXvW
	 /G1leF8ADT4RU8nJ1nouRtzQGcu27+O6PGMSzGlhHTuhWjFT4oDaBW1uexsTQpF2AR
	 v6CqMXTzTa2y3Iq0GRUx++9/MP5sAW7f+NrTtRfs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbfHMQEv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 12:04:51 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:40864 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728108AbfHMQEv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 12:04:51 -0400
Received: by mail-ot1-f65.google.com with SMTP id c34so34488823otb.7;
        Tue, 13 Aug 2019 09:04:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Yg/tdFt298Hyk/OxrmEU7+mFLMHSrwTggBrmycRWebA=;
        b=VmQiZLt9/DIDrsP6IaEciEJDQc+0arPq3zzzpm9Z1fnCFFb+Fsqw0X2ptF0z4ZMeLS
         wdntnIOVlN8wkkKyxlooVC9njg6ZvY8yw1hKA/ZuVmdOAg7EM8jqf8xsVeHaqkqgUqrA
         MZlJlcWhgJAjAUupvMrPJqmKXWlYQvI6vcRGTmLub86Beddm/c5hbOYSPLH5aMSw+k1T
         YSFr7gHFzvndT1U0coMmJ50BmqFRap88VgkROwj4IOYQaarZjsL3/pSMVKBa0ZExgFJo
         m5zebZvlEawlSIVO+spwgjUAwf1I+KpCUlm/FoTWZNSefQo/zIAVeOOqJXGZgMVsMb5J
         SppA==
X-Gm-Message-State: APjAAAUdXoghDxIIvg36JYCDTw+O11MTo8KEKmqtaoEg5ohRuPx7KPfr
        7vdrcyDI6JFYHhaEXArd2Q==
X-Google-Smtp-Source: APXvYqysIOYL/gXYF6/LQ0CkFVBddSF7hzJ2kMCDtw7RVQKrbAXD64plvuQNUfr+HZ96QtSKg4f7Vw==
X-Received: by 2002:a6b:8b0b:: with SMTP id n11mr41354893iod.101.1565712289907;
        Tue, 13 Aug 2019 09:04:49 -0700 (PDT)
Received: from localhost ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id w17sm2608740ior.23.2019.08.13.09.04.48
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 09:04:49 -0700 (PDT)
Date:   Tue, 13 Aug 2019 10:04:48 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stefan Riedmueller <s.riedmueller@phytec.de>
Cc:     linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Fabio Estevam <festevam@gmail.com>,
        Andrew Smirnov <andrew.smirnov@gmail.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linux-imx@nxp.com
Subject: Re: [PATCH 1/2] dt-bindings: arm: fsl: Add PHYTEC i.MX6 UL/ULL
 devicetree bindings
Message-ID: <20190813160448.GA27548@bogus>
References: <1563954573-370205-1-git-send-email-s.riedmueller@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1563954573-370205-1-git-send-email-s.riedmueller@phytec.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2019 at 09:49:32AM +0200, Stefan Riedmueller wrote:
> Add devicetree bindings for i.MX6 UL/ULL based phyCORE-i.MX6 UL/ULL and
> phyBOARD-Segin.
> 
> Signed-off-by: Stefan Riedmueller <s.riedmueller@phytec.de>
> ---
>  Documentation/devicetree/bindings/arm/fsl.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
> index 7294ac36f4c0..40f007859092 100644
> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
> @@ -161,12 +161,20 @@ properties:
>          items:
>            - enum:
>                - fsl,imx6ul-14x14-evk      # i.MX6 UltraLite 14x14 EVK Board
> +              - phytec,imx6ul-pbacd10     # PHYTEC phyBOARD-Segin with i.MX6 UL
> +              - phytec,imx6ul-pbacd10-emmc  # PHYTEC phyBOARD-Segin eMMC Kit
> +              - phytec,imx6ul-pbacd10-nand  # PHYTEC phyBOARD-Segin NAND Kit
> +              - phytec,imx6ul-pcl063      # PHYTEC phyCORE-i.MX 6UL

This doesn't match what is in the dts files:

arch/arm/boot/dts/imx6ul-phytec-pcl063.dtsi:    compatible = "phytec,imx6ul-pcl063", "fsl,imx6ul";                    
arch/arm/boot/dts/imx6ul-phytec-phyboard-segin-full.dts:      compatible = "phytec,imx6ul-pbacd10", "phytec,imx6ul-pcl063", 
"fsl,imx6ul";
arch/arm/boot/dts/imx6ul-phytec-phyboard-segin.dtsi:    compatible = "phytec,imx6ul-pbacd-10", "phytec,imx6ul-pcl063",
"fsl,imx6ul";

>            - const: fsl,imx6ul
>  
>        - description: i.MX6ULL based Boards
>          items:
>            - enum:
>                - fsl,imx6ull-14x14-evk     # i.MX6 UltraLiteLite 14x14 EVK Board
> +              - phytec,imx6ull-pbacd10    # PHYTEC phyBOARD-Segin with i.MX6 ULL
> +              - phytec,imx6ull-pbacd10-emmc # PHYTEC phyBOARD-Segin eMMC Kit
> +              - phytec,imx6ull-pbacd10-nand # PHYTEC phyBOARD-Segin NAND Kit
> +              - phytec,imx6ull-pcl063     # PHYTEC phyCORE-i.MX 6ULL
>            - const: fsl,imx6ull
>  
>        - description: i.MX6ULZ based Boards
> -- 
> 2.7.4
> 
