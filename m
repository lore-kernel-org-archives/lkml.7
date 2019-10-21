Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED41DCA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 11:35:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C10EC20B7C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 11:35:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j5qq2d7i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728417AbfJULfd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 07:35:33 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50450 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727571AbfJULfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 07:35:33 -0400
Received: by mail-wm1-f68.google.com with SMTP id q13so2869025wmj.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 04:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=0sdJfBLrNhSnyt1oG9eOew+sDCXYd7qlS53fN8Wh8i0=;
        b=j5qq2d7in13MCKCxENLawerzUfcTXKh1TPbZ7oQiuL9FySNbACnFIWIHKQJKrTDTPA
         iDjnYguzH+/MU8qRHyqT3HZUCh/F+uQCA+JgnjfhetGmVc58CJ3UbUj/pqft4mCFaZ12
         n1tBUOzr7/+G7UXFLTpHt9shLmNfJXPrljZm1rqNu8WE8h042Ydis3aU+cENpbiUiOCl
         uGD/GURiG8TZeKP/6h8nqbklanb4LUFyMVpHJleg9SQjCEqlFpuO6imeMpTtouYo1kGZ
         +PvPLL+1bsWji/xBGPAKUYCB1AfTrOGfnXa7fqk3njinJQFvX9dlkN04Go2ZeNZ043Rw
         ySRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=0sdJfBLrNhSnyt1oG9eOew+sDCXYd7qlS53fN8Wh8i0=;
        b=t3lHADoofPf/W/MkaTtHCGxcG1Uu6ln/tkQVjDN1y5eM5ZZV3CTx9GAaR8V3kB68ay
         Gofhejbsbtf4pPbvjsqZR/ZGfdFS8Li2nryKyfQUdYRGKB5hJn1CNtrKqhcpjcscXQ6J
         /lt5Pa1msFS6cNW7Jf+sCPp6vzxArlLABydCar52waxMDbAj3egMmoywVCjmurxhRo2T
         grtETJ1cf0xmvqm0Ygdnu5Lbxr5WI9YBA7He1HMuwiB/m5Ziyhq8p/pi4nURQbciMtAg
         OiMV30mMj04STbTuXY+YKJcbEZrsBBCJ2PtOdcBvXvQwCs21WNocZ7okEyLUsiKMJdVM
         wDfQ==
X-Gm-Message-State: APjAAAWhbmIyTm6j0udIqDxDx1EqMQtBT5IItWv8IEO+7AAPGKgWayMt
        iDFe6NDNnjyntNLogA60Ia5X3g==
X-Google-Smtp-Source: APXvYqx0OLlY7zxfk1fGkgqbBOZCGdm/XFCc/sWS6WexpuxLzNRUWm/xzTU2ReiqZ3YSyahma4PxaA==
X-Received: by 2002:a7b:c8c5:: with SMTP id f5mr18630589wml.170.1571657731261;
        Mon, 21 Oct 2019 04:35:31 -0700 (PDT)
Received: from dell ([95.149.164.99])
        by smtp.gmail.com with ESMTPSA id t8sm14256793wrx.76.2019.10.21.04.35.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Oct 2019 04:35:30 -0700 (PDT)
Date:   Mon, 21 Oct 2019 12:35:29 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     arnd@arndb.de, broonie@kernel.org, linus.walleij@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        baohua@kernel.org, stephan@gerhold.net
Subject: Re: [PATCH v2 1/9] mfd: cs5535-mfd: Use PLATFORM_DEVID_* defines and
 tidy error message
Message-ID: <20191021113529.GB4365@dell>
References: <20191021105822.20271-1-lee.jones@linaro.org>
 <20191021105822.20271-2-lee.jones@linaro.org>
 <20191021111555.zsvvdfun3gqhrurw@holly.lan>
 <20191021113316.GA4365@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191021113316.GA4365@dell>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Oct 2019, Lee Jones wrote:

> On Mon, 21 Oct 2019, Daniel Thompson wrote:
> 
> > On Mon, Oct 21, 2019 at 11:58:14AM +0100, Lee Jones wrote:
> > > In most contexts '-1' doesn't really mean much to the casual observer.
> > > In almost all cases, it's better to use a human readable define.  In
> > > this case PLATFORM_DEVID_* defines have already been provided for this
> > > purpose.
> > > 
> > > While we're here, let's be specific about the 'MFD devices' which
> > > failed.  It will help when trying to distinguish which of the 2 sets
> > > of sub-devices we actually failed to register.
> > 
> > No objections... but won't the tag added by dev_err() already
> > disambiguate?
> 
> The difference will be between CS5532 and  CS5532 OLPC.
> 
> Please see patch 4 in the series.
> 
> > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > ---
> > >  drivers/mfd/cs5535-mfd.c | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/mfd/cs5535-mfd.c b/drivers/mfd/cs5535-mfd.c
> > > index f1825c0ccbd0..2c47afc22d24 100644
> > > --- a/drivers/mfd/cs5535-mfd.c
> > > +++ b/drivers/mfd/cs5535-mfd.c
> > > @@ -127,10 +127,11 @@ static int cs5535_mfd_probe(struct pci_dev *pdev,
> > >  		cs5535_mfd_cells[i].id = 0;
> > >  	}
> > >  
> > > -	err = mfd_add_devices(&pdev->dev, -1, cs5535_mfd_cells,
> > > +	err = mfd_add_devices(&pdev->dev, PLATFORM_DEVID_NONE, cs5535_mfd_cells,
> > >  			      ARRAY_SIZE(cs5535_mfd_cells), NULL, 0, NULL);
> > >  	if (err) {
> > > -		dev_err(&pdev->dev, "MFD add devices failed: %d\n", err);
> > > +		dev_err(&pdev->dev,
> > > +			"Failed to add CS5532 sub-devices: %d\n", err);
> > 
> >                                            ^^^
> > 
> > Typo (and MODULE_DESCRIPTION() says this is a driver for CS5536 too).
> > Once that is fixed:
> > Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>
> 
> Ta.

Looks like this comes from the failed message from the
mfd_add_devices() above.  I'll fix both.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
