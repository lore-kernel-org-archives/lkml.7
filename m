Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09829C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 19:23:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0344215EA
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 19:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567106624;
	bh=oiBSsWEkMD2QI1HIknotYFNewxQUHMD5dxnpazQV4Ho=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=M/1O61/l5Zr+rF4RoT7gRhnMksUKN1L6lWQsNwNqS5btmkrSkn28l2u/ATYOJvvzi
	 mXyio41mvxttMVwRM6O9DRN1BbAIMdO2GS68Abw5kskpbryGzHBZzlTFjyPLeuRIVu
	 NZu/oP9z/KRoiD6RRJbR+3T27Wv3oZDcVsEnFeks=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728490AbfH2TXo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 15:23:44 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33535 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727525AbfH2TXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 15:23:43 -0400
Received: by mail-oi1-f194.google.com with SMTP id l2so3508885oil.0;
        Thu, 29 Aug 2019 12:23:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=awB7Qev2kte00T2ifUulW7uJN/+Y8eVNRqAUedJCoug=;
        b=UJHop8Sv1AtXqtY7sK2ZibOwqFgvrqUCzJqItKq7315CEVgmT6T+K6IOUZH1BfwDoz
         M5Z0brymxz99mw5LEaVzJ5ofu9NFTvsovBfH5azApgrvB73Y+MJMBkPVibJqLDOwl87W
         U51gaSuH+XVMZ35vyVTNaE2UOujrDKSIQiCKPEJzNickO46gnK76mxtdjA4O4KaO9mDg
         YzGQHShWmcj0nWbtL9oMRIW95RWQVlllmZk5b1dU7EmMoTV9CpqY8bFtKGkyqvaR/A0B
         4wZWLd8Ci+9Jv3LoYIFt8EhC3YVUtl8zZglvsRF0WELQynU3e2uo3NGRM1mGTtJ7IZgd
         xRAA==
X-Gm-Message-State: APjAAAU0sT87AoFZyEZeCHlwhrS+Z31pIs76aD1ztNVWo7ciq4ApZ8q3
        ZOkXWnNYKaJ4A+ReDoLMmg==
X-Google-Smtp-Source: APXvYqxKBNcCX2Vcs4btyyWNLLy+0CXp/jm5HlmQq9eqINvWH7Jql4eAMiRJysKxAactJJBh/j9HhQ==
X-Received: by 2002:aca:dd8a:: with SMTP id u132mr7196217oig.150.1567106622407;
        Thu, 29 Aug 2019 12:23:42 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id n17sm1107111otl.21.2019.08.29.12.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 12:23:41 -0700 (PDT)
Date:   Thu, 29 Aug 2019 14:23:41 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 01/11] dt-bindings: phy-mtk-tphy: add two optional
 properties for u2phy
Message-ID: <20190829192341.GA26293@bogus>
References: <e99c0d7a55869a4425250c601b80a3331c9d0976.1566542696.git.chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e99c0d7a55869a4425250c601b80a3331c9d0976.1566542696.git.chunfeng.yun@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 23, 2019 at 03:00:08PM +0800, Chunfeng Yun wrote:
> Add two optional properties, one for J-K test, another for disconnect
> threshold, both of them can be used to debug disconnection issues.

Testing and debug properties aren't really things that belong in DT.

> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>  Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt b/Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt
> index a5f7a4f0dbc1..d5b327f85fa2 100644
> --- a/Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt
> +++ b/Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt
> @@ -52,6 +52,8 @@ Optional properties (PHY_TYPE_USB2 port (child) node):
>  - mediatek,eye-vrt	: u32, the selection of VRT reference voltage
>  - mediatek,eye-term	: u32, the selection of HS_TX TERM reference voltage
>  - mediatek,bc12	: bool, enable BC12 of u2phy if support it
> +- mediatek,discth	: u32, the voltage of disconnect threshold
> +- mediatek,intr	: u32, the value of internal R (resistance)

These need units as defined in property-units.txt.

>  
>  Example:
>  
> -- 
> 2.23.0
> 
