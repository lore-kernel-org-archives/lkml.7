Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D05D0C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 11:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F38B205ED
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 11:33:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fhC9+A8r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfEGLds (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 07:33:48 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35554 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfEGLdr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 07:33:47 -0400
Received: by mail-pf1-f196.google.com with SMTP id t87so7943778pfa.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2019 04:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sR5BpYMQqvU33+qKoi/MmdBbUlBWeD3X1bsZEIF3QFw=;
        b=fhC9+A8r0mSbiTlAYOPbaxaHR1YL8JghQMh+MjGsndpuB6jiMcbihqosl7SqrR9Bg4
         eJHhAE0+cxTlbttRzHm3WxGeN6cKlprzV5wVVJNbblxJvdhzyJQSCl7//+UbdSAf6nvg
         gCoefUxDiFmCGsr2NcvUePitEJFz5LwVkvbwB2DM6+nS1hcw6OAOZrJqlh5Rse3Glnpy
         fEdYulBRxsoqZj4BR0KKihU330+fKteuIQyFbJeIp8MY4TtIbt4iTe2vV28NjA2yAZXf
         DD2MiUAjg3Tj45FdV+s6ymLE7zzPNib9GR7zpj+3EOOWxxDbjd9L1OBHlSGsmJcO9T6D
         svAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sR5BpYMQqvU33+qKoi/MmdBbUlBWeD3X1bsZEIF3QFw=;
        b=WwUBxQ/kFnsisavlht50fImwAUb024kThg89A4zvw0YZc62Z5DCsz3asNwBz+GUxEg
         O01+h0FYr0pVzwJEGyL9OcoA3uHPVZftuBZDWhPMR4pWGK/Sxmabh1x0dgf1yn/JGivA
         XBNthqLVhRY8f0gsDb93dpj0K7K/MJeSCcc+EUEO6eO63jTSSMPxNt+pjuYHrByylczD
         Z++JXy0OQBY74HGx9ZHn3aq2yf6REvXAQimN3Tw4LIzmw3DHFY4q8pJsSwd/CcoelNdg
         KBDtSSQ2KMTaesCWnf8VB7+CsQ0kTNSFhfdtgvoNPxDkHBlAu7oWyXP6cEhm1/Lx/V+f
         +qNw==
X-Gm-Message-State: APjAAAWQlBscUClhMjXNBS9DN3zJHcGlx3gLp7iD26QMY1woDj2vIDF2
        +TAjmyWW6wMjOltf1rdUt0kf
X-Google-Smtp-Source: APXvYqyAKJZP4RUcj4/+fM77Hhrfsi/pdsboySmMz+0IE4qjVjtfRycKA+OR92PXBDkgcqkej5fGkQ==
X-Received: by 2002:a63:5516:: with SMTP id j22mr36851432pgb.370.1557228826789;
        Tue, 07 May 2019 04:33:46 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:99e:34fe:41ce:b81d:ca3c:de5])
        by smtp.gmail.com with ESMTPSA id 8sm8279543pfn.158.2019.05.07.04.33.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 May 2019 04:33:46 -0700 (PDT)
Date:   Tue, 7 May 2019 17:03:39 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        ezequiel@collabora.com, tom@vamrs.com, dev@vamrs.com
Subject: Re: [PATCH 1/2] arm64: dts: rockchip: Enable SPI0 and SPI4 on Rock960
Message-ID: <20190507113339.GA309@Mani-XPS-13-9360>
References: <20190506120458.25842-1-manivannan.sadhasivam@linaro.org>
 <3484838.jBNMtg6mRV@phil>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3484838.jBNMtg6mRV@phil>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

On Tue, May 07, 2019 at 01:17:10PM +0200, Heiko Stuebner wrote:
> Am Montag, 6. Mai 2019, 14:04:57 CEST schrieb Manivannan Sadhasivam:
> > Enable SPI0 and SPI4 exposed on the Low and High speed expansion
> > connectors of Rock960.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  arch/arm64/boot/dts/rockchip/rk3399-rock960.dts | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts
> > index 12285c51cceb..7498344d4a73 100644
> > --- a/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts
> > +++ b/arch/arm64/boot/dts/rockchip/rk3399-rock960.dts
> > @@ -114,6 +114,18 @@
> >  	};
> >  };
> >  
> > +&spi0 {
> > +	/* On Low speed expansion */
> > +	label = "LS-SPI0";
> 
> where does the label property come from and what does it do?
> It's not part of the rockchip-spi / general-spi binding.
> 

It is not part of the binding but I thought it will provide the users
the information of the SPI bus as per the specification when they
look into devicetree.

If it doesn't makes sense, I can remove that!

Thanks,
Mani

> 
> Heiko
> 
> > +	status = "okay";
> > +};
> > +
> > +&spi4 {
> > +	/* On High speed expansion */
> > +	label = "HS-SPI1";
> > +	status = "okay";
> > +};
> > +
> >  &usbdrd_dwc3_0 {
> >  	dr_mode = "otg";
> >  };
> > 
> 
> 
> 
> 
