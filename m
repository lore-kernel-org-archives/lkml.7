Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1405FC2BBE2
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 17:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC53F24673
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 17:13:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=netronome-com.20150623.gappssmtp.com header.i=@netronome-com.20150623.gappssmtp.com header.b="AFL2+H+B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbfLGRNj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Dec 2019 12:13:39 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44398 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726455AbfLGRNi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Dec 2019 12:13:38 -0500
Received: by mail-wr1-f67.google.com with SMTP id q10so11242161wrm.11
        for <linux-kernel@vger.kernel.org>; Sat, 07 Dec 2019 09:13:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=netronome-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jR3SyHBUEWSPjBlDW1LeGn/KYMF0y8nruNnoz/13mkQ=;
        b=AFL2+H+B1H0cUjM21DoS+EbPmSeWc+tVjHWCByl0XnHympdA1FNb5GilbogW6Vp6k8
         /0v51aHKBg9h7alJHCY9O0Pyv8JakfMZMXWW+ay7kMm8HztvZcuwFHeYDwih1eOF0MXe
         LUmrdjAIh3/bCLzXYh+/IISmwzaajZ0NH9T1nrmHIkS94ijrr/ua1fh0HO0tepKh4kWz
         Ox0GKA4bkAHKiUulETJQrkXORtnNCIqUj+Y3CgDM11nemud34mfxSKzApX6atyLiVkm4
         Zn3qp9eqjSvlcSFc8xZe8GDFW9fFR/8h5iMxkOawmFJfO92rH1hoIFbXuyB8seCGv41z
         MgnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jR3SyHBUEWSPjBlDW1LeGn/KYMF0y8nruNnoz/13mkQ=;
        b=rLV+YtM6eQbcZX8tX8H6MWPiUVWyy9oRiRp7mXOItvA8WKM/a2g1e3o9v62xhyCsI7
         YO+9aciqyYF8Dw/WPomZShpB9W444pPTzgRbk+/zKBa9NuZnTTWrQJKqmlM9U6iQqFJ/
         P3wXazAOf10l8fBAVqaJeKHFhTIf+wyLonbgrKbsw3vVMqkV60OcTdj4XrbFsA2b0S9n
         g3x5McGFOHWU7aUvkHqm89f/BpAq2cSzFMoHq0Y/qhx2pnqDHPwH4ZtmrfH7oxfqwGvt
         xahO8K4axi2FFfj9NNPteEBQy1YOwj+1p+R3jSOv3n9xWwD0A4Lb7wTVSa6oTP6bUE1T
         j22w==
X-Gm-Message-State: APjAAAWoA6XSiVIYuQSnqRti3J/s3cXZJUA7wEEk0arR0oNOqhCaIWvx
        VcgmQgDRXC1l8C6TSeCfKfJJ7A==
X-Google-Smtp-Source: APXvYqzzT6cpEXbdQzFCSXPWWrCMrulA7XTI6/VFmEaL73RKZUx/P2+UHqPR7ey6iRNw14U/hJqzAA==
X-Received: by 2002:a5d:6350:: with SMTP id b16mr22200705wrw.132.1575738816490;
        Sat, 07 Dec 2019 09:13:36 -0800 (PST)
Received: from netronome.com (fred-musen.rivierenbuurt.horms.nl. [2001:470:7eb3:404:a2a4:c5ff:fe4c:9ce9])
        by smtp.gmail.com with ESMTPSA id 2sm21102237wrq.31.2019.12.07.09.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Dec 2019 09:13:35 -0800 (PST)
Date:   Sat, 7 Dec 2019 18:13:34 +0100
From:   Simon Horman <simon.horman@netronome.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, grygorii.strashko@ti.com,
        robh+dt@kernel.org, rafal@milecki.pl, davem@davemloft.net,
        andrew@lunn.ch, mark.rutland@arm.com, devicetree@vger.kernel.org,
        netdev@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Eric Anholt <eric@anholt.net>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: dts: Cygnus: Fix MDIO node address/size cells
Message-ID: <20191207171333.GD26173@netronome.com>
References: <20191206181909.10962-1-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191206181909.10962-1-f.fainelli@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 06, 2019 at 10:19:09AM -0800, Florian Fainelli wrote:
> The MDIO node on Cygnus had an reversed #address-cells and
>  #size-cells properties, correct those.
> 
> Fixes: 40c26d3af60a ("ARM: dts: Cygnus: Add the ethernet switch and ethernet PHY")
> Reported-by: Simon Horman <simon.horman@netronome.com>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Thanks Florian,

this looks good to me.

Reviewed-by: Simon Horman <simon.horman@netronome.com>

> ---
>  arch/arm/boot/dts/bcm-cygnus.dtsi | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
> index 2dac3efc7640..1bc45cfd5453 100644
> --- a/arch/arm/boot/dts/bcm-cygnus.dtsi
> +++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
> @@ -174,8 +174,8 @@
>  		mdio: mdio@18002000 {
>  			compatible = "brcm,iproc-mdio";
>  			reg = <0x18002000 0x8>;
> -			#size-cells = <1>;
> -			#address-cells = <0>;
> +			#size-cells = <0>;
> +			#address-cells = <1>;
>  			status = "disabled";
>  
>  			gphy0: ethernet-phy@0 {
> -- 
> 2.17.1
> 
