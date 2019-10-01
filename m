Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74103C352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 22:09:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4960621906
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 22:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569967749;
	bh=KP7tbJJSrQ+krIzZL4qKovSSv9oz1A9YS1/VWcNUJe4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pxClRz37Za0b1mrA6VH0nv7hkwYcVPej1vQNY3pR0UISyJsMpXwOnKOgGDfbeNrpF
	 jHdDgROi3DiooVmDUyl8bjW1bC/qJfccXhxIVcRpPL32i3tMgdLRRzVC4BkYwgjosr
	 ebE7e1XLDCmQogltQdS51rABc6ZvpZ2tFAXgU3s0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728690AbfJAWJI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 18:09:08 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:35083 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727939AbfJAWJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 18:09:08 -0400
Received: by mail-io1-f67.google.com with SMTP id q10so52255860iop.2;
        Tue, 01 Oct 2019 15:09:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=j0S7cSZMIiJCew19Ox3ICfK8eVP4NNvzwGL3SrqsdBg=;
        b=EKrsajyf2p6WguzyNQSmpMNsgf8vAfAXWhhtdXowsZXyfTH6/EWhwMwxNZcAlcGp1i
         aMiU/ftIcBoxFXEHRO0yqbZG09D2qCqZsIvtEA6iplYzGlmzOZV5nJYH8Kn3BJNFBOC9
         a1aZacpaDldRwPpQQIbdbKFdridv80URELZUES87rxVShbeNSZHZDGP+PfpgQWTcXHT+
         IWDU+metvO8yDDePkpaYjM2WQOA0TWivy31V8JUPX18Rj7v4U6Z7lEcMGHp0CBDoAc/M
         qKKx1aku2w4OalHIwHwz/vt2rxlOPDOrYHnfx075WKZcYlgc/A4DOGjaMmuZl57nB1HT
         mc0A==
X-Gm-Message-State: APjAAAVbCwCzlMSL+r303AiX6HMxswDaQM46RArdwj0JWUJz/rDEWIXx
        S8xuRR3zJDVIjfZ4XWV//tF9ESU=
X-Google-Smtp-Source: APXvYqwZ3rRMPzQT8p0E97fI2TeXqht1cQv+PU9FDpVWfNh8AjFLQdA9FYpdAhTH6dUuqxj2Cm23gQ==
X-Received: by 2002:a02:93e5:: with SMTP id z92mr684479jah.8.1569967747118;
        Tue, 01 Oct 2019 15:09:07 -0700 (PDT)
Received: from localhost ([2607:fb90:1780:6fbf:9c38:e932:436b:4079])
        by smtp.gmail.com with ESMTPSA id 197sm8609364ioc.78.2019.10.01.15.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2019 15:09:06 -0700 (PDT)
Message-ID: <5d93ce82.1c69fb81.fe9a0.e3e6@mx.google.com>
Date:   Tue, 01 Oct 2019 17:09:04 -0500
From:   Rob Herring <robh@kernel.org>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: display: imx: fix native-mode setting
References: <20190918193853.25689-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190918193853.25689-1-martin@kaiser.cx>
X-Mutt-References: <20190918193853.25689-1-martin@kaiser.cx>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 18, 2019 at 09:38:53PM +0200, Martin Kaiser wrote:
> According to
> Documentation/devicetree/bindings/display/panel/display-timing.txt,
> native-mode is a property of the display-timings node.
> 
> If it's located outside of display-timings, the native-mode setting is
> ignored and the first display timing is used.
> 
> We've already fixed the board definitions which got this wrong. Fix the
> example in the imx framebuffer bindings as well.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> ---
>  Documentation/devicetree/bindings/display/imx/fsl,imx-fb.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Please also fix 
Documentation/devicetree/bindings/display/cirrus,clps711x-fb.txt

> 
> diff --git a/Documentation/devicetree/bindings/display/imx/fsl,imx-fb.txt b/Documentation/devicetree/bindings/display/imx/fsl,imx-fb.txt
> index e5a8b363d829..f4df9e83bcd2 100644
> --- a/Documentation/devicetree/bindings/display/imx/fsl,imx-fb.txt
> +++ b/Documentation/devicetree/bindings/display/imx/fsl,imx-fb.txt
> @@ -38,10 +38,10 @@ Example:
>  
>  	display0: display0 {
>  		model = "Primeview-PD050VL1";
> -		native-mode = <&timing_disp0>;
>  		bits-per-pixel = <16>;
>  		fsl,pcr = <0xf0c88080>;	/* non-standard but required */
>  		display-timings {
> +			native-mode = <&timing_disp0>;
>  			timing_disp0: 640x480 {
>  				hactive = <640>;
>  				vactive = <480>;
> -- 
> 2.11.0
> 

