Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EF09C43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 20:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0C32B2084F
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 20:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556311750;
	bh=kNU/SgTSo3lUHx2Kzr8xVxyjoyFKmEyp08eHzmSVUi8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=R4Gwz0IbOVadupY82rFZQb2zwA5Cuf16fn4WveUbj4z/Nih6a182bOezIqhILUNW7
	 z6Tm95L8Q+0T0gmxkTlj65D/9ThZ+S8hyx+aD40kQn9xlKzOHGJ7G4YV8xFXQVyHIR
	 SS2qZc/th2ZenumR651ArrJ2Sx0BY+KHLz8xQKn8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfDZUtJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 16:49:09 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:38372 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbfDZUtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 16:49:08 -0400
Received: by mail-ot1-f67.google.com with SMTP id t20so3798900otl.5;
        Fri, 26 Apr 2019 13:49:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=yT/XON//WSgEMOVSZqw0Vzpd9+7PVH4HBAL475bgyVk=;
        b=HVjO7+aDHtUggFdEse6GwGF5zR1ZspYRNpoip6mGB17hoPDzu3SSCxVn/VfCQA73c/
         btzlyDvNj06kxkMvraL1LjYEE+ZUEMi8CVkuZ2c+hoSSMmogd4RDhvlD+BiUJXWb3IHx
         xAEPChIXoQYL64PKwLXt++RJJMs1YGxT7TeusALodTfYztpNz17YQRBV0MoeoLuV2lpQ
         XLK7+l/P6Jdcot8scT633Vo67fJUdvijb3W+EY4kYePPwxjuQM1i8mVxvxPf9FO2enWz
         x+rxrhPi8Gmx69LmzGYq7ddjwFwIn9eeWQcLJOipIh2U+U6nozCbAJr/PmxC5JqSMK4O
         F45w==
X-Gm-Message-State: APjAAAUhPIxZXd87WeUuCBtnPaIcKfsdXPvFWEOJXTpmN0loORU3sF95
        PD4gy8lsYyCPY23J/biD6g==
X-Google-Smtp-Source: APXvYqzdJ/lqbNb65m2fPe6L55tRE2fIx1i7+lvYj2VUlr2QLQ5aXA5+va67yIwicppYidXubf3CLw==
X-Received: by 2002:a9d:1b70:: with SMTP id l103mr4240966otl.165.1556311747844;
        Fri, 26 Apr 2019 13:49:07 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l23sm2648517otr.81.2019.04.26.13.49.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Apr 2019 13:49:07 -0700 (PDT)
Date:   Fri, 26 Apr 2019 15:49:06 -0500
From:   Rob Herring <robh@kernel.org>
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Li Jun <jun.li@nxp.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Min Guo <min.guo@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Biju Das <biju.das@bp.renesas.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v4 3/6] dt-bindings: usb: mtu3: add properties about USB
 Role Switch
Message-ID: <20190426204906.GB15074@bogus>
References: <1556261237-13823-1-git-send-email-chunfeng.yun@mediatek.com>
 <1556261237-13823-4-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556261237-13823-4-git-send-email-chunfeng.yun@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 02:47:14PM +0800, Chunfeng Yun wrote:
> Now the USB Role Switch is supported, so add properties about it
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
> ---
> v4: no changes
> v3: no changes
> 
> v2 changes:
>   1. fix typo
>   2. refer new binding about connector property
> ---
>  .../devicetree/bindings/usb/mediatek,mtu3.txt          | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/mediatek,mtu3.txt b/Documentation/devicetree/bindings/usb/mediatek,mtu3.txt
> index 3382b5cb471d..6e004c4a89af 100644
> --- a/Documentation/devicetree/bindings/usb/mediatek,mtu3.txt
> +++ b/Documentation/devicetree/bindings/usb/mediatek,mtu3.txt
> @@ -27,7 +27,9 @@ Optional properties:
>   - ranges : allows valid 1:1 translation between child's address space and
>  	parent's address space
>   - extcon : external connector for vbus and idpin changes detection, needed
> -	when supports dual-role mode.
> +	when supports dual-role mode; it's consiedered valid for compatibility
> +	reasons, and not allowed for new bindings, use the property
> +	usb-role-switch instead.
>   - vbus-supply : reference to the VBUS regulator, needed when supports
>  	dual-role mode.
>   - pinctrl-names : a pinctrl state named "default" is optional, and need be
> @@ -36,7 +38,8 @@ Optional properties:
>  	is not set.
>   - pinctrl-0 : pin control group
>  	See: Documentation/devicetree/bindings/pinctrl/pinctrl-bindings.txt
> -
> + - usb-role-switch : use USB Role Switch to support dual-role switch, but
> +	not extcon

Coordinate with the Renesas and HiSilicon folks implementing the same 
thing and put this in a common spot. However, I think this should not 
even be needed as knowing the controller capabilities (based on the 
compatible) and knowing the type of connector should be enough 
information to tell you if dual role is supported or not.

>   - maximum-speed : valid arguments are "super-speed", "high-speed" and
>  	"full-speed"; refer to usb/generic.txt
>   - enable-manual-drd : supports manual dual-role switch via debugfs; usually
> @@ -61,6 +64,9 @@ The xhci should be added as subnode to mtu3 as shown in the following example
>  if host mode is enabled. The DT binding details of xhci can be found in:
>  Documentation/devicetree/bindings/usb/mediatek,mtk-xhci.txt
>  
> +The port would be added as subnode if use usb-role-switch property
> +	see graph.txt
> +
>  Example:
>  ssusb: usb@11271000 {
>  	compatible = "mediatek,mt8173-mtu3";
> -- 
> 2.21.0
> 
