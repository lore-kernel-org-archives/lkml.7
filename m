Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7DAEC3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 20:05:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85EDB208C2
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 20:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567109106;
	bh=D9OpUDGZzn5yICLfJrkFRAVB2JcJlRQu1hWLLBuIbRQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=iC+kYBNS+odE8gfAINe7+nbML43dpDRR2948Rccbd58rjfggrdWvYfVEfke1NDHV0
	 o8JlFAsKOD5OSDcJKmSGoKDXuDT05Y1pwHI2yWLMb5Pw8KCbgbwfrZ1Xm/jmZBlaxZ
	 cDW6cDC/7s0UUgcjIZ+QFka+/QFcXIuayEPetbYU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728295AbfH2UFF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 16:05:05 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:36675 "EHLO
        mail-oi1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728085AbfH2UFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 16:05:05 -0400
Received: by mail-oi1-f193.google.com with SMTP id n1so3579400oic.3;
        Thu, 29 Aug 2019 13:05:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=olD2mIH4m+P4tlheGqCEsNMbY7eNHE8lmUC8IgMGIBs=;
        b=X+Bkf/yxgIk2/caIYMIFbkS4Ise/Aw6hqwhYqRwjrizB7Z5ATVOh5Snx3kfsMNAWVA
         Y/KZruo/GAYisLkYaiONlH8bCe1/jiOnlMtz+vSAfn+5vqna7JAWZghXPwLb76YuLAlw
         +iVz/87NBNGLWq+NzmAwjHZNn0ZJ84RFKm8Z6qVoVaW8rg+mJ7lx+bMdlihwh6uFrHuL
         cPX/+59zy5+hlkYaehXbvA1/D/vDUJgN4fsZJAbcLlEThTRZTOWcQj/p+OKKZ51+EHzv
         raBq6gZvqx5jCNz40QaK0Q/XaMB+LvVxYAqOoX1Hr41b7Sloj0+kabG7ZUPpmZyQohTD
         cZ0Q==
X-Gm-Message-State: APjAAAWgogj6km7eYk3qmapkJVEsiwkC+P276FwSbf0GJ14q6jw1Vo5P
        tpXbWFls2zcpsNzux4G/g6npwCE=
X-Google-Smtp-Source: APXvYqw25K1BL3gwLmn1i6McjlyIKHA3SA6g6v8scCo80RRzPLJIQGfYl6oq/ARM6ji1yUyJh172ig==
X-Received: by 2002:aca:b445:: with SMTP id d66mr7924251oif.7.1567109104134;
        Thu, 29 Aug 2019 13:05:04 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id v1sm1055259ota.60.2019.08.29.13.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 13:05:03 -0700 (PDT)
Date:   Thu, 29 Aug 2019 15:05:03 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 04/11] dt-bindings: phy-mtk-tphy: add a new reference
 clock
Message-ID: <20190829200503.GA2542@bogus>
References: <e99c0d7a55869a4425250c601b80a3331c9d0976.1566542696.git.chunfeng.yun@mediatek.com>
 <f6ee7d33103b43b2f1e1331c23c36057ef20b20d.1566542697.git.chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6ee7d33103b43b2f1e1331c23c36057ef20b20d.1566542697.git.chunfeng.yun@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 23, 2019 at 03:00:11PM +0800, Chunfeng Yun wrote:
> Usually the digital and anolog phys use the same reference clock,
> but on some platforms, they are separated, so add another optional
> clock to support it.
> In order to keep the clock names consistent with PHY IP's, use
> the da_ref for anolog phy and ref clock for digital phy.
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>  Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt b/Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt
> index dbc143ed5999..ed9a2641f204 100644
> --- a/Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt
> +++ b/Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt
> @@ -41,9 +41,12 @@ Optional properties (PHY_TYPE_USB2 port (child) node):
>  - clocks	: a list of phandle + clock-specifier pairs, one for each
>  		  entry in clock-names
>  - clock-names	: may contain
> -		  "ref": 48M reference clock for HighSpeed anolog phy; and 26M
> -			reference clock for SuperSpeed anolog phy, sometimes is
> +		  "ref": 48M reference clock for HighSpeed (digital) phy; and 26M
> +			reference clock for SuperSpeed (digital) phy, sometimes is
>  			24M, 25M or 27M, depended on platform.
> +		  "da_ref": the reference clock of anolog phy, used if the clocks
> +			of anolog and digital phys are separated, otherwise uses

s/amolog/analog/

> +			"ref" clock only if need.

needed.

>  
>  - mediatek,eye-src	: u32, the value of slew rate calibrate
>  - mediatek,eye-vrt	: u32, the selection of VRT reference voltage
> -- 
> 2.23.0
> 
