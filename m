Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E80C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 19:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D921A2189D
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 19:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567106753;
	bh=Txo0evGgmM5MKTYUKN6LQ7+m2PQGiBL4eX+XI9Hu1Ik=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QoiUN7Y1O5l0+8MW5JB2KwMOo/E+kUTHUtM8EYHg+IMXzxFHL1xtviIUX/4e5vJsu
	 NWTe8+wqIV2Lgi+PkPwD7v0jKyGH99xqGqPsVmG7Iz1ZQP3/6elK6NmrHyulNVMeaS
	 auVSDajUW0360RxkMOp/Q6u7tr5t3RXe46YXagkU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728259AbfH2TZx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 15:25:53 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43413 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727146AbfH2TZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 15:25:52 -0400
Received: by mail-oi1-f196.google.com with SMTP id y8so3454960oih.10;
        Thu, 29 Aug 2019 12:25:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=lZ2BYe42I9MJ0wayu5k+436nxyRI7BnkkEeIXJqYPPY=;
        b=obapb+hOCb4MQ2c7EakepKWZjWg8f1j8M9ujLt9grPoH3SXxNL/9vskA4actWLXK/Z
         z/PSuHCAPTm66AXx0KAKHscVxAHdFkUSkVQbrr+pm4mDzgcJCPvqBtHhGBIERBxpOSr7
         0SbBOKF2/ME8s33rHyp4BWGNMFIGkFQzQ1Q4E8dafMNMJSggYBIWrieDn3NeC/EGUATq
         r7lNOGwiTiIXlAvnyZP8Jo8C1nlg9KJw492qmozfyV2zNHodK6Q7LOJqqrt4TJeP0Ens
         i3v/esQNBYLon54rIYA7viFqPZKQc9LFIWWdhqJYjIwKf/LH1vP6S3q09WygEZl2x6LA
         Y9rg==
X-Gm-Message-State: APjAAAVjK61EdlYTjAX3lv4wQvXW9sirnmnj50y1AXExKVMCIM5qtxvs
        u+1TOdg/3l4+e3ae8qiydQ==
X-Google-Smtp-Source: APXvYqxg9o4u0friAhLIFb1wO376me4+33exQL8RzM7lAtGBzLxeG67AR60+ryEQemuydVobqBKytA==
X-Received: by 2002:a54:4893:: with SMTP id r19mr7711912oic.91.1567106751513;
        Thu, 29 Aug 2019 12:25:51 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z26sm839164oih.16.2019.08.29.12.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 12:25:51 -0700 (PDT)
Date:   Thu, 29 Aug 2019 14:25:50 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 02/11] dt-bindings: phy-mtk-tphy: make the ref clock
 optional
Message-ID: <20190829192550.GA29881@bogus>
References: <e99c0d7a55869a4425250c601b80a3331c9d0976.1566542696.git.chunfeng.yun@mediatek.com>
 <a31d78484b64f853a16e7dcb16fae9fc0de45ebb.1566542696.git.chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a31d78484b64f853a16e7dcb16fae9fc0de45ebb.1566542696.git.chunfeng.yun@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 23, 2019 at 03:00:09PM +0800, Chunfeng Yun wrote:
> Make the ref clock optional, then we no need refer to a fixed-clock
> in DTS anymore when the clock of USB3 PHY comes from oscillator
> directly
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>  .../devicetree/bindings/phy/phy-mtk-tphy.txt        | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt b/Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt
> index d5b327f85fa2..1c18bf10b2fe 100644
> --- a/Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt
> +++ b/Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt
> @@ -34,12 +34,6 @@ Optional properties (controller (parent) node):
>  
>  Required properties (port (child) node):
>  - reg		: address and length of the register set for the port.
> -- clocks	: a list of phandle + clock-specifier pairs, one for each
> -		  entry in clock-names
> -- clock-names	: must contain
> -		  "ref": 48M reference clock for HighSpeed analog phy; and 26M
> -			reference clock for SuperSpeed analog phy, sometimes is
> -			24M, 25M or 27M, depended on platform.
>  - #phy-cells	: should be 1 (See second example)
>  		  cell after port phandle is phy type from:
>  			- PHY_TYPE_USB2
> @@ -48,6 +42,13 @@ Required properties (port (child) node):
>  			- PHY_TYPE_SATA
>  
>  Optional properties (PHY_TYPE_USB2 port (child) node):
> +- clocks	: a list of phandle + clock-specifier pairs, one for each
> +		  entry in clock-names
> +- clock-names	: may contain
> +		  "ref": 48M reference clock for HighSpeed anolog phy; and 26M
> +			reference clock for SuperSpeed anolog phy, sometimes is
> +			24M, 25M or 27M, depended on platform.

How do you know the frequency when it is not present?

> +
>  - mediatek,eye-src	: u32, the value of slew rate calibrate
>  - mediatek,eye-vrt	: u32, the selection of VRT reference voltage
>  - mediatek,eye-term	: u32, the selection of HS_TX TERM reference voltage
> -- 
> 2.23.0
> 
