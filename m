Return-Path: <SRS0=7lyw=2D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 808FFC80D24
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B469A24718
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Dec 2019 20:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576269651;
	bh=jaXFBdH1JrIOTkP8xa8k6LKOsAlqJq3zpyPFCV9ZxQY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xBS0DDtQg+52JQx94NHXbXLTGCXyFtJx5LpuUTdLQX0q4pkS8U/y+wFgx3DS7YKGl
	 up/iWrWV2HKBgOrxeSvy+1bbEBAYl/S+kpmWSRWx95+gXxhUJatXy9PTX3/ohp3des
	 NL25uVBA+aoBWy/sEQfkjE7pa6bmzvjWvP9U5BNQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728869AbfLMTDi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Dec 2019 14:03:38 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:42740 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728455AbfLMTDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Dec 2019 14:03:37 -0500
Received: by mail-oi1-f195.google.com with SMTP id j22so1637780oij.9;
        Fri, 13 Dec 2019 11:03:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0jLdwo4Gh3BpcLr+x8Y4V1BSkeVDpmaHMCwdlyDbPHI=;
        b=hF/C1PzzLmW4SyI5BZCh1ATG6HILNW73mJ8mxcNDnMEacNvo8cXpax2KnPq2iA0asi
         hIwxZis6VxrpzUO2URbJQTnYtDhB0RHauCFpEFcliZUr0uZPfRS59cTRFOtWIpYg5pGE
         w7F2NwpXXEgP69/CEoASF60IsY31nzuHaTDbLAxAU+kMYvT90qZJz/ziK5Yc6aYJjq6H
         4FoPwKyDCnyNsbNYC3P0hrIkw83Q4cd6RxW5/Dt69lP+goGOk0l2enbzJ+tFn79E/zjz
         ineKWJVkVkrgZd/3kbtZ4RAp5XSBL0inMsvjs10OR3zyeD+sRyQVzCA9pLTRBPw0N3H9
         erGQ==
X-Gm-Message-State: APjAAAW0jSOtI0zp0ZGTOhbPiOtE5nghsfgpP2yYMDRwQ4MEjc6x2ZOX
        cousz9uf98OKbbDqYZL+kQ==
X-Google-Smtp-Source: APXvYqyDYMLhdnJ4CPCzJjTRPxkIRfS51N1GfBOGJw6/3Te72GU1lQmiGGiO0u/xbrXHuLqsxYwijg==
X-Received: by 2002:aca:3141:: with SMTP id x62mr7090024oix.108.1576263816699;
        Fri, 13 Dec 2019 11:03:36 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id r124sm3612857oie.9.2019.12.13.11.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2019 11:03:35 -0800 (PST)
Date:   Fri, 13 Dec 2019 13:03:35 -0600
From:   Rob Herring <robh@kernel.org>
To:     min.guo@mediatek.com
Cc:     Bin Liu <b-liu@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        chunfeng.yun@mediatek.com, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, tony@atomide.com,
        hdegoede@redhat.com
Subject: Re: [PATCH v9 1/6] dt-bindings: usb: musb: Add support for MediaTek
 musb controller
Message-ID: <20191213190335.GA16897@bogus>
References: <20191211015446.11477-1-min.guo@mediatek.com>
 <20191211015446.11477-2-min.guo@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191211015446.11477-2-min.guo@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 09:54:41AM +0800, min.guo@mediatek.com wrote:
> From: Min Guo <min.guo@mediatek.com>
> 
> This adds support for MediaTek musb controller in
> host, peripheral and otg mode.
> 
> Signed-off-by: Min Guo <min.guo@mediatek.com>
> ---
> changes in v9:
> 1. Add usb-role-switch
> 2. Remove label of usb connector child node
> 3. Change usb connector child node compatible as "gpio-usb-b-connector", "usb-b-connector";
> 
> changes in v8:
> 1. Add reviewed by Rob
> 
> changes in v7:
> 1. Modify compatible as
> - compatible : should be one of:
>                "mediatek,mt2701-musb"
>                ...
>                followed by "mediatek,mtk-musb"
> 2. Change usb connector child node compatible as "gpio-usb-b-connector" 
> 
> changes in v6:
> 1. Modify usb connector child node
> 
> changes in v5:
> suggested by Rob:
> 1. Modify compatible as 
> - compatible : should be one of:
>                "mediatek,mt-2701"
>                ...
>                followed by "mediatek,mtk-musb"
> 2. Add usb connector child node
> 
> changes in v4:
> suggested by Sergei:
> 1. String alignment
> 
> changes in v3:
> 1. no changes
> 
> changes in v2:
> suggested by Bin:
> 1. Modify DRC to DRD
> suggested by Rob:
> 2. Drop the "<soc-model>-musb" in compatible
> 3. Remove phy-names
> 4. Add space after comma in clock-names
> ---
>  .../devicetree/bindings/usb/mediatek,musb.txt | 57 +++++++++++++++++++
>  1 file changed, 57 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/mediatek,musb.txt

Reviewed-by: Rob Herring <robh@kernel.org>
