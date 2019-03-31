Return-Path: <SRS0=KwB+=SC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6481C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 06:41:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B587321841
	for <linux-kernel@archiver.kernel.org>; Sun, 31 Mar 2019 06:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554014481;
	bh=z/kO9Zu6yqLvBLNFv9E33Lryf4mTQVpNbtguvZvfrAI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=sJ8DjUaaQ8jr8Zapnycu8g11GqFtSb/Wd103gkcd4a8LCL4Ny8PSQrIe6ElwBs4pO
	 Dv6Bxd/LNN3UpHA7TdZVr1ZwCNLUmzoR0pPmphDDfLVByghffS50QgzaoHhVbOO99R
	 r/2BUoV5diDCcdKGvr7RQ3gYw6ErRC8U//zfyy9U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731148AbfCaGlU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 31 Mar 2019 02:41:20 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40629 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731100AbfCaGlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Mar 2019 02:41:18 -0400
Received: by mail-pg1-f194.google.com with SMTP id u9so3153840pgo.7;
        Sat, 30 Mar 2019 23:41:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=heLdrWP5dIr+fKEU8R3xufB5ZKIj1M6FnpxAKWF+n4U=;
        b=dkVE/M9nYmag/WYailJ3MvSSoVEt0T4BpQ9xAnA1m0umSIjikvlYJZ8xmm/AVL+wao
         Af3VEvOk8ACtBkoOO0zknPdz2GznwDMG8NMseOBJwOvW6NHxOHrub3mlWVEyVEo5JB5Z
         RVuOGDxdWaLlyrKjVLkCJfPwv1akLj3Bwdr6zAxTrcmTJuXGXlFwGQYQiEcwI03imCVi
         SIH9dxyjeT7Db6JoQ7QE94Cvffk8lCudpEpnU31YDeEPO/Z5wXvDZU5hLPYAd2XUAde4
         /hXP9dpTNM21TrlZDUqn95juMszDUPvX18kGYoNHuPTZt9drU90WZ6dxRXkEV0S33WK6
         7liQ==
X-Gm-Message-State: APjAAAXEXIHlOXxw3yVG2Jd9Vd4Vxu8EgC4pLq8KWUoT2wrRgUEoSunU
        oK8aV+sQzbCgWbrcPBd+CQ==
X-Google-Smtp-Source: APXvYqy5Pq9KFyiY4TjIHbh7zjc0hbfBjAZiJljE0wFhb6PPMDgSUuhFyzs+7rW9LfnawaMOaOZHPg==
X-Received: by 2002:a63:720c:: with SMTP id n12mr11031226pgc.348.1554014477466;
        Sat, 30 Mar 2019 23:41:17 -0700 (PDT)
Received: from localhost ([210.160.217.68])
        by smtp.gmail.com with ESMTPSA id v82sm15405496pfa.170.2019.03.30.23.41.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 30 Mar 2019 23:41:17 -0700 (PDT)
Message-ID: <5ca0610d.1c69fb81.44d14.2fff@mx.google.com>
Date:   Sun, 31 Mar 2019 01:41:15 -0500
From:   Rob Herring <robh@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Bin Liu <b-liu@ti.com>, Mark Rutland <mark.rutland@arm.com>,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, od@zcrc.me
Subject: Re: [PATCH 1/3] dt-bindings: usb: Add usb-phy property to the
 jz4740-musb node
References: <20190321150956.6629-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190321150956.6629-1-paul@crapouillou.net>
X-Mutt-References: <20190321150956.6629-1-paul@crapouillou.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2019 at 04:09:54PM +0100, Paul Cercueil wrote:
> Add a required 'usb-phy' property, to obtain a phandle to the USB PHY
> from devicetree.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  Documentation/devicetree/bindings/usb/ingenic,jz4740-musb.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/ingenic,jz4740-musb.txt b/Documentation/devicetree/bindings/usb/ingenic,jz4740-musb.txt
> index 620355cee63f..23213779f193 100644
> --- a/Documentation/devicetree/bindings/usb/ingenic,jz4740-musb.txt
> +++ b/Documentation/devicetree/bindings/usb/ingenic,jz4740-musb.txt
> @@ -8,9 +8,15 @@ Required properties:
>  - interrupt-names: must be "mc"
>  - clocks: phandle to the "udc" clock
>  - clock-names: must be "udc"
> +- usb-phy: phandle to the USB PHY

'phys' is the standard property name now.

>  
>  Example:
>  
> +usb_phy: usb-phy@0 {
> +	compatible = "usb-nop-xceiv";
> +	#phy-cells = <0>;
> +};
> +
>  udc: usb@13040000 {
>  	compatible = "ingenic,jz4740-musb";
>  	reg = <0x13040000 0x10000>;
> @@ -21,4 +27,6 @@ udc: usb@13040000 {
>  
>  	clocks = <&cgu JZ4740_CLK_UDC>;
>  	clock-names = "udc";
> +
> +	usb-phy = <&usb_phy>;
>  };
> -- 
> 2.11.0
> 

