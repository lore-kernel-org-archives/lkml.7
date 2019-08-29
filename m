Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E09C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 20:16:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C3E223403
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 20:16:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1567109791;
	bh=ow7KRrXupdrE0NJV9p5Pb2NG+5tREcr1q/hR6kuAIZ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=cJxYn4xvki6sjyaXxcshIcinWIkBQzxl1usrlPdmx0HLTrANOQG54FDHdzp+Ts7wl
	 AWsQ4sPS9EMYvTYd1cp7iXlWfgERtCH6nA6q1N+VNIpSoWOk6tBltzwr6c+B8b2UuN
	 bsfmkCKzUG84yfLv22Fo4lAAutQMOlUblZ6BEkcw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbfH2UQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 16:16:30 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:33767 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbfH2UQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 16:16:30 -0400
Received: by mail-oi1-f194.google.com with SMTP id l2so3631489oil.0;
        Thu, 29 Aug 2019 13:16:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r0elfNE0RyTt9GAHlyWPO1II9ncvkXZ597Rk7e3riyo=;
        b=ke2ELXL67IZUOtUdbSP0+/kP91Eq/5S1d0zVQKEokxPRdGk8z37mwCNda1uf87JQNC
         kTBv7laaZTJWvRlPiZNeEpnpAJWYfx2uQ2EW0GAmZh1gMVfNhrDQo16+M2E89ChwUrDJ
         zA/M4OcuqgvL1Csf3qpoT7qwagmzQwIrCCIsBE0x1/9kRF/K9ZhWDQYRhM2v7Z4b9ZOE
         tsrSTp9+5MJAW2GZKY4bpxAW2R7j+6WJBEIZfBaruxTwYgChviyB+Y1iiK4yrZOkhXFy
         bj2hBhR3u9OsE7FhJsVbqqvsbV1+Cl2KZXoNFqIDEsWwZCO5ucldQCqBUzGo+XhfmFet
         VEkw==
X-Gm-Message-State: APjAAAUyb7unOnV4ShrBzvEBK3YhI9fpbNZHuJZSEOHblJZmozxNYM/B
        jmhcgyJmI2QaqRnRnyKsxQ==
X-Google-Smtp-Source: APXvYqwLRsexffOxgvvJuaoaSbPvixtSE9lU61VmCdvYBdklRZADSzWrV5Y8s+8RQCvzu3wPGHEP4g==
X-Received: by 2002:aca:911:: with SMTP id 17mr7698213oij.166.1567109788775;
        Thu, 29 Aug 2019 13:16:28 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id q85sm983117oic.52.2019.08.29.13.16.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 13:16:28 -0700 (PDT)
Date:   Thu, 29 Aug 2019 15:16:27 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 05/11] dt-bindings: phy-mtk-tphy: add the properties
 about address mapping
Message-ID: <20190829201627.GA24612@bogus>
References: <e99c0d7a55869a4425250c601b80a3331c9d0976.1566542696.git.chunfeng.yun@mediatek.com>
 <8ce6da3118b80556f9576c5ac331312be07d8e29.1566542697.git.chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ce6da3118b80556f9576c5ac331312be07d8e29.1566542697.git.chunfeng.yun@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Aug 2019 15:00:12 +0800, Chunfeng Yun wrote:
> Add three required properties about the address mapping, including
> '#address-cells', '#size-cells' and 'ranges'
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
>  Documentation/devicetree/bindings/phy/phy-mtk-tphy.txt | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
