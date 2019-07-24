Return-Path: <SRS0=3iFO=VV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC85C76186
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:45:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72AAB217F4
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jul 2019 20:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1564001122;
	bh=TBDN3Huv6kEE7MWGFvc+bcIfgzntc2kR7olvl4WWMdg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=YzMN1zarxKCdz859Q6UMiTO/g4P1WcWG3yYIgX+HwuXKA0VFjhNtWgzCmyje2BGSy
	 Si43FJqJnpVloewv8G1HE+W+yqWV0yoN44hEKrw6q7oZUVbSRc/Ayf9jXtbwShWtzK
	 LeodSs0OOLp0tmIQViVm9sNBbyYV9nq2j0xR4pnE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387700AbfGXUpV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jul 2019 16:45:21 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:40279 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbfGXUpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jul 2019 16:45:20 -0400
Received: by mail-io1-f67.google.com with SMTP id h6so5939602iom.7;
        Wed, 24 Jul 2019 13:45:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CCC83gvr3zUqrHBBE2tCcnx8FJnOWLoIpaVrcWkgVNI=;
        b=U2ZNG6zK9f2rtTaQPLwGUWAUtP8h98dV4Ab9wiPUzwOajJmx6F3jb75OdUDS2xxF6r
         fbm5FsgpZOXBHduISVm+dPtDetTVVFD5jyHej7seAkeTmYyhc4z3mmyK2CC0Lacz+aAt
         6NC7BOkUGPYnCo177c6vyahKp2I6zJrc1iMQ9tPPoY3Hm/lxxAIbpcnJ/zwGLv8KNjQf
         pE8rzyOxmJjC1B0+sf73MkfJ52Y7YIPHm88OKQZJuwhzqQB4ECbWmwt60de+oJweZ2Id
         DlLUxY437WiGwMSrZrwIKTpXGs/US6MP6xMGbeJNHvOf7rDNYFnlYlbMM2JbdF7Kr4IQ
         ROUw==
X-Gm-Message-State: APjAAAUJcFUEDv83Wbef8OZu824RpGdYBB3qCorOCljbOZGy+G4HzdWq
        x2Ou8+Y3oEAX95BdUcp/Ow==
X-Google-Smtp-Source: APXvYqzZIXBI6PBNyEYZPD4Zfoy1oC3HcF0imTkHY6VNLfMnea8dJ9IXUk/wVjvDBjbfoxK8Wbqb/Q==
X-Received: by 2002:a5d:9703:: with SMTP id h3mr11500009iol.152.1564001119366;
        Wed, 24 Jul 2019 13:45:19 -0700 (PDT)
Received: from localhost ([64.188.179.254])
        by smtp.gmail.com with ESMTPSA id m20sm44917837ioh.4.2019.07.24.13.45.18
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 13:45:18 -0700 (PDT)
Date:   Wed, 24 Jul 2019 14:45:18 -0600
From:   Rob Herring <robh@kernel.org>
To:     Macpaul Lin <macpaul.lin@mediatek.com>
Cc:     Marc Zyngier <marc.zyngier@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mars Cheng <mars.cheng@mediatek.com>,
        Owen Chen <owen.chen@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        wsd_upstream@mediatek.com, CC Hwang <cc.hwang@mediatek.com>,
        Loda Chou <loda.chou@mediatek.com>, devicetree@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v6 1/8] dt-bindings: clock: mediatek: document clk
 bindings for Mediatek MT6765 SoC
Message-ID: <20190724204518.GA6997@bogus>
References: <1562924653-10056-1-git-send-email-macpaul.lin@mediatek.com>
 <1562924653-10056-2-git-send-email-macpaul.lin@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1562924653-10056-2-git-send-email-macpaul.lin@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 12, 2019 at 05:43:37PM +0800, Macpaul Lin wrote:
> From: Mars Cheng <mars.cheng@mediatek.com>
> 
> This patch adds the binding documentation for apmixedsys, audsys, camsys,
> imgsys, infracfg, mipi0a, topckgen, vcodecsys
> 
> Signed-off-by: Mars Cheng <mars.cheng@mediatek.com>
> Signed-off-by: Owen Chen <owen.chen@mediatek.com>
> Signed-off-by: Macpaul Lin <macpaul.lin@mediatek.com>
> ---
>  .../arm/mediatek/mediatek,apmixedsys.txt      |  1 +
>  .../bindings/arm/mediatek/mediatek,audsys.txt |  1 +
>  .../bindings/arm/mediatek/mediatek,camsys.txt |  1 +
>  .../bindings/arm/mediatek/mediatek,imgsys.txt |  1 +
>  .../arm/mediatek/mediatek,infracfg.txt        |  1 +
>  .../bindings/arm/mediatek/mediatek,mipi0a.txt | 28 +++++++++++++++++++
>  .../bindings/arm/mediatek/mediatek,mmsys.txt  |  1 +
>  .../arm/mediatek/mediatek,pericfg.txt         |  1 +
>  .../arm/mediatek/mediatek,topckgen.txt        |  1 +
>  .../arm/mediatek/mediatek,vcodecsys.txt       | 27 ++++++++++++++++++
>  10 files changed, 63 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mipi0a.txt
>  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,vcodecsys.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt
> index 161e63a6c254..5f2757e0f844 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,apmixedsys.txt
> @@ -8,6 +8,7 @@ Required Properties:
>  - compatible: Should be one of:
>  	- "mediatek,mt2701-apmixedsys"
>  	- "mediatek,mt2712-apmixedsys", "syscon"
> +	- "mediatek,mt6765-apmixedsys", "syscon"
>  	- "mediatek,mt6797-apmixedsys"
>  	- "mediatek,mt7622-apmixedsys"
>  	- "mediatek,mt7623-apmixedsys", "mediatek,mt2701-apmixedsys"
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt
> index f3cef1a6d95c..243db5275438 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,audsys.txt
> @@ -7,6 +7,7 @@ Required Properties:
>  
>  - compatible: Should be one of:
>  	- "mediatek,mt2701-audsys", "syscon"
> +	- "mediatek,mt6765-audsys", "syscon"
>  	- "mediatek,mt7622-audsys", "syscon"
>  	- "mediatek,mt7623-audsys", "mediatek,mt2701-audsys", "syscon"
>  	- "mediatek,mt8183-audiosys", "syscon"
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,camsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,camsys.txt
> index d8930f64aa98..17acc4c5402c 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,camsys.txt
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,camsys.txt
> @@ -6,6 +6,7 @@ The MediaTek camsys controller provides various clocks to the system.
>  Required Properties:
>  
>  - compatible: Should be one of:
> +	- "mediatek,mt6765-camsys", "syscon"
>  	- "mediatek,mt8183-camsys", "syscon"
>  - #clock-cells: Must be 1
>  
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,imgsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,imgsys.txt
> index e3bc4a1e7a6e..4e7b617acfb6 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,imgsys.txt
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,imgsys.txt
> @@ -8,6 +8,7 @@ Required Properties:
>  - compatible: Should be one of:
>  	- "mediatek,mt2701-imgsys", "syscon"
>  	- "mediatek,mt2712-imgsys", "syscon"
> +	- "mediatek,mt6765-imgsys", "syscon"
>  	- "mediatek,mt6797-imgsys", "syscon"
>  	- "mediatek,mt7623-imgsys", "mediatek,mt2701-imgsys", "syscon"
>  	- "mediatek,mt8173-imgsys", "syscon"
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt
> index a90913988d7e..6a6ffb61dd29 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,infracfg.txt
> @@ -9,6 +9,7 @@ Required Properties:
>  - compatible: Should be one of:
>  	- "mediatek,mt2701-infracfg", "syscon"
>  	- "mediatek,mt2712-infracfg", "syscon"
> +	- "mediatek,mt6765-infracfg", "syscon"
>  	- "mediatek,mt6797-infracfg", "syscon"
>  	- "mediatek,mt7622-infracfg", "syscon"
>  	- "mediatek,mt7623-infracfg", "mediatek,mt2701-infracfg", "syscon"
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mipi0a.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mipi0a.txt
> new file mode 100644
> index 000000000000..49313055e574
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mipi0a.txt
> @@ -0,0 +1,28 @@
> +Mediatek mipi0a (mipi_rx_ana_csi0a) controller
> +============================
> +
> +The Mediatek mipi0a controller provides various clocks
> +to the system.

Is that all it does?

> +
> +Required Properties:
> +
> +- compatible: Should be one of:
> +	- "mediatek,mt6765-mipi0a", "syscon"
> +- #clock-cells: Must be 1
> +
> +The mipi0a controller uses the common clk binding from
> +Documentation/devicetree/bindings/clock/clock-bindings.txt
> +The available clocks are defined in dt-bindings/clock/mt*-clk.h.
> +
> +The mipi0a controller also uses the common power domain from
> +Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
> +The available power doamins are defined in dt-bindings/power/mt*-power.h.
> +
> +Example:
> +
> +mipi0a: mipi0a@11c10000 {

if so, then clock-controller@...

Same question on the next one.

> +	compatible = "mediatek,mt6765-mipi0a", "syscon";
> +	reg = <0 0x11c10000 0 0x1000>;
> +	power-domains = <&scpsys MT6765_POWER_DOMAIN_CAM>;
> +	#clock-cells = <1>;
> +};
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
> index 545eab717c96..0c7b1698b98e 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
> @@ -8,6 +8,7 @@ Required Properties:
>  - compatible: Should be one of:
>  	- "mediatek,mt2701-mmsys", "syscon"
>  	- "mediatek,mt2712-mmsys", "syscon"
> +	- "mediatek,mt6765-mmsys", "syscon"
>  	- "mediatek,mt6797-mmsys", "syscon"
>  	- "mediatek,mt7623-mmsys", "mediatek,mt2701-mmsys", "syscon"
>  	- "mediatek,mt8173-mmsys", "syscon"
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.txt
> index 4c7e478117a0..b49b40741be1 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.txt
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,pericfg.txt
> @@ -9,6 +9,7 @@ Required Properties:
>  - compatible: Should be one of:
>  	- "mediatek,mt2701-pericfg", "syscon"
>  	- "mediatek,mt2712-pericfg", "syscon"
> +	- "mediatek,mt6765-pericfg", "syscon"
>  	- "mediatek,mt7622-pericfg", "syscon"
>  	- "mediatek,mt7623-pericfg", "mediatek,mt2701-pericfg", "syscon"
>  	- "mediatek,mt7629-pericfg", "syscon"
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.txt
> index a023b8338960..21ad416bfeec 100644
> --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.txt
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,topckgen.txt
> @@ -8,6 +8,7 @@ Required Properties:
>  - compatible: Should be one of:
>  	- "mediatek,mt2701-topckgen"
>  	- "mediatek,mt2712-topckgen", "syscon"
> +	- "mediatek,mt6765-topckgen", "syscon"
>  	- "mediatek,mt6797-topckgen"
>  	- "mediatek,mt7622-topckgen"
>  	- "mediatek,mt7623-topckgen", "mediatek,mt2701-topckgen"
> diff --git a/Documentation/devicetree/bindings/arm/mediatek/mediatek,vcodecsys.txt b/Documentation/devicetree/bindings/arm/mediatek/mediatek,vcodecsys.txt
> new file mode 100644
> index 000000000000..83f7f8634943
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,vcodecsys.txt
> @@ -0,0 +1,27 @@
> +Mediatek vcodecsys controller
> +============================
> +
> +The Mediatek vcodecsys controller provides various clocks to the system.
> +
> +Required Properties:
> +
> +- compatible: Should be one of:
> +	- "mediatek,mt6765-vcodecsys", "syscon"
> +- #clock-cells: Must be 1
> +
> +The vcodecsys controller uses the common clk binding from
> +Documentation/devicetree/bindings/clock/clock-bindings.txt
> +The available clocks are defined in dt-bindings/clock/mt*-clk.h.
> +
> +The vcodecsys controller also uses the common power domain from
> +Documentation/devicetree/bindings/soc/mediatek/scpsys.txt
> +The available power doamins are defined in dt-bindings/power/mt*-power.h.
> +
> +Example:
> +
> +venc_gcon: venc_gcon@17000000 {
> +	compatible = "mediatek,mt6765-vcodecsys", "syscon";
> +	reg = <0 0x17000000 0 0x10000>;
> +	power-domains = <&scpsys MT6765_POWER_DOMAIN_VCODEC>;
> +	#clock-cells = <1>;
> +};
> -- 
> 2.18.0
> 
