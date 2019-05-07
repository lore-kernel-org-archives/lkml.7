Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A94D1C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 11:36:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78113205ED
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 11:36:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lX2uPFcu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfEGLgo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 07:36:44 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46748 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbfEGLgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 07:36:43 -0400
Received: by mail-pg1-f194.google.com with SMTP id t187so4045082pgb.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 04:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=JozcPTzIlj0LjY7Lh6j2NSqbSEGNTeWecbTka74yFBY=;
        b=lX2uPFcuiuQE8UI2yTgrCw9rUzo5Jh0xrCI+gmQALphLmfYhBINLy6vsrgapzPt85n
         rr95dq6sbatagkYGwVlxV2X6kKpwb+XHLZT8guGMaxSQC6NmVEtnygTN1D0qRu7F2l7/
         701S88pA/3hGTTTO8bmPbsleo97+q5txD/oyhYCW+PSg1HlIiLSVp8DG4aasGN8Xo8Uk
         CWoBA2wyAp8GIooy6aD3hL0Ck5qhaakcX20osCcdadZ/g3QIS1jmJGRAJui7nEwp1dcj
         lEtKxK1CVqyQXfc3GPeitqCss/mVb+Gwkn2w+D+htWgT8ud5sskp/ea5AnDOBRg2syjN
         9o8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=JozcPTzIlj0LjY7Lh6j2NSqbSEGNTeWecbTka74yFBY=;
        b=VD31aOX3n/8UAp/kb2HNca7zb/8JM3UAssIENLItkTNO0vjF6G9tNub8LTdW+iMAb/
         VKdQvdMt5X8PjL5pWK4L0eLQHkIMk7h030s0Q04R8sJstdEMFNMUQkj/vQsJ4ftYKkFS
         69wkoO0F3qVk9Y1bdpgDE8ILcFtBl+ERFKVo1am6dI/VyeZ2MSJtzPKD/YMTu0hNYmbY
         3LvztdSNPOCR3AInWBWTv4Oo/aHIecZtutHAA7UGTNMC2/h1HXuH9eAI0+pS/09i7Dm/
         GDK7eo/9cnN6MWIAKpiYXFc/lHl2ljaJDBgrnFS0/s6M3PpbHg8KnqpTyMvoTP4+Ju8/
         kOwQ==
X-Gm-Message-State: APjAAAVCuOu+GjCtCZsf+Dp+NmZbrMb9XLRzbH9ZFfmzEbVIwxmROjv1
        4b3YySJSk2I1llT6iFnTAWcR
X-Google-Smtp-Source: APXvYqzNqjzrtFc05ZFodpitRY7VSYiEX1Z08HpY7hktZWwpbVJUjoguhWG9iuc54JTZywekY+Av4w==
X-Received: by 2002:a63:e24:: with SMTP id d36mr47665pgl.80.1557229003106;
        Tue, 07 May 2019 04:36:43 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:99e:34fe:41ce:b81d:ca3c:de5])
        by smtp.gmail.com with ESMTPSA id g71sm7862877pgc.41.2019.05.07.04.36.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 04:36:42 -0700 (PDT)
Date:   Tue, 7 May 2019 17:06:35 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        ezequiel@collabora.com, tom@vamrs.com, dev@vamrs.com
Subject: Re: [PATCH 2/2] arm64: dts: rockchip: Enable SPI1 on Ficus
Message-ID: <20190507113635.GB309@Mani-XPS-13-9360>
References: <20190506120458.25842-1-manivannan.sadhasivam@linaro.org>
 <20190506120458.25842-2-manivannan.sadhasivam@linaro.org>
 <2127870.SxaTtWf5LP@phil>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2127870.SxaTtWf5LP@phil>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 07, 2019 at 01:22:03PM +0200, Heiko Stuebner wrote:
> Am Montag, 6. Mai 2019, 14:04:58 CEST schrieb Manivannan Sadhasivam:
> > Enable SPI1 exposed on both Low and High speed expansion connectors
> > of Ficus. SPI1 has 3 different chip selects wired as below:
> > 
> > CS0 - Serial Flash (unpopulated)
> > CS1 - Low Speed expansion
> > CS2 - High Speed expansion
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  arch/arm64/boot/dts/rockchip/rk3399-ficus.dts | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3399-ficus.dts b/arch/arm64/boot/dts/rockchip/rk3399-ficus.dts
> > index 027d428917b8..9baa378fc770 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3399-ficus.dts
> > +++ b/arch/arm64/boot/dts/rockchip/rk3399-ficus.dts
> > @@ -146,6 +146,12 @@
> >  	};
> >  };
> >  
> > +&spi1 {
> > +	/* On both Low speed and High speed expansion */
> > +	cs-gpios = <0>, <&gpio4 6 0>, <&gpio4 7 0>;
> 
> cs0 should still be part of the cs-gpios though (gpio1 RK_PB2).
> The flash is part of the schematics, so there might be board with
> it pre-populated or people might put a flash chip on it.
> 

Why? CS0 is owned by the SPI controller itself, so we can't use it as
a GPIO. Otherwise, we need to change the pinctrl definition of it, which
doesn't look good to me.

> Also please use the constants for pin specification (RK_PA6, RK_PA7 above)
> 

Sure.

Thanks,
Mani

> 
> Heiko
> 
> > +	status = "okay";
> > +};
> > +
> >  &usbdrd_dwc3_0 {
> >  	dr_mode = "host";
> >  };
> > 
> 
> 
> 
> 
