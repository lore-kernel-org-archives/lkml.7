Return-Path: <SRS0=BTkm=YO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A231CA9EAF
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 11:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D06F62089C
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Oct 2019 11:33:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Oy1bDj8c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbfJULdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Oct 2019 07:33:20 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43902 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727685AbfJULdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Oct 2019 07:33:20 -0400
Received: by mail-wr1-f65.google.com with SMTP id c2so8306532wrr.10
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2019 04:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=NvogyYcPH5HiSpRRQoQRP+VJ8MEq3onz6Q0+j4Mfoeg=;
        b=Oy1bDj8cgdLtX4MeiPkZTXa0D+BsfxOlUyDd1G94MhAQlyikxatILkupmu8WpJHKhr
         vZ6WT8psdPmKrzaYFRunzvze6/aEy3RAYxWRZ8qtAZfTLsmd1GTW7hyrkb/T/Ov1mNNk
         NX/X/sYIS9v7KTaHCJD11X4THvbgd53xXx/rnoHat2Y5X5uDlVHoneJklSnl439iAGoj
         76f8ZodNxPqIBfxoy2YpqezgC4NBmmSdYwvu8vPOKJS4E0UsbD6q3IFIj3bV9pn6KOic
         4I2FslXSg2psH7JqqY3h0d4EQ0S+I6rz1WxJqctQNUkJBMiSb4+9CC3hPSo1jg34a7pE
         u6Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=NvogyYcPH5HiSpRRQoQRP+VJ8MEq3onz6Q0+j4Mfoeg=;
        b=sNUgIj0LLzImkqxgKeU5/QchZHyWQTCprQjrp1ix28Nu3OUkuriOLY47OcViN3XUMC
         cHlDeRN/7N6zxsucL8XzZqunbCSEKi3PCPEfGThm4olFu+LXI/B5bzUWVTkx4y83potR
         ub0tofPbDh/w+EC5tdeVfAt+qDJJr/FnImPjiYg9PGkK5S0fIh3LQ3zC6v9wwRzJ/isq
         7kFXgLlTDmmC4U1vROH6PKfdml+jDUpPNJq0+ZtR1bPuZdidWrvqV03SwW/d/wuEL0Ce
         7ejBt6fzBgS4AAGtiTv9IATiKz2KAayby9q8SVhPEb2Tx3Y0Am9UGz0adObCVslMTwVk
         eTPA==
X-Gm-Message-State: APjAAAU3mX3AyW2lT+bgyRK/LFuM8DBiFxLfss3g7MPCAji+uMk1SD1c
        60DtdK9AC69XnUTPsoleflLOKg==
X-Google-Smtp-Source: APXvYqyMIAyEPCNwcjoYQRMWKDg+5l3URiHknN8ipHfDzYk/6uRZQr+BzUbWIv6eq6k9BO1W7E1c+Q==
X-Received: by 2002:a5d:678e:: with SMTP id v14mr12033062wru.393.1571657598261;
        Mon, 21 Oct 2019 04:33:18 -0700 (PDT)
Received: from dell ([95.149.164.99])
        by smtp.gmail.com with ESMTPSA id l7sm5284560wro.17.2019.10.21.04.33.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Oct 2019 04:33:17 -0700 (PDT)
Date:   Mon, 21 Oct 2019 12:33:16 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     arnd@arndb.de, broonie@kernel.org, linus.walleij@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        baohua@kernel.org, stephan@gerhold.net
Subject: Re: [PATCH v2 1/9] mfd: cs5535-mfd: Use PLATFORM_DEVID_* defines and
 tidy error message
Message-ID: <20191021113316.GA4365@dell>
References: <20191021105822.20271-1-lee.jones@linaro.org>
 <20191021105822.20271-2-lee.jones@linaro.org>
 <20191021111555.zsvvdfun3gqhrurw@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191021111555.zsvvdfun3gqhrurw@holly.lan>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Oct 2019, Daniel Thompson wrote:

> On Mon, Oct 21, 2019 at 11:58:14AM +0100, Lee Jones wrote:
> > In most contexts '-1' doesn't really mean much to the casual observer.
> > In almost all cases, it's better to use a human readable define.  In
> > this case PLATFORM_DEVID_* defines have already been provided for this
> > purpose.
> > 
> > While we're here, let's be specific about the 'MFD devices' which
> > failed.  It will help when trying to distinguish which of the 2 sets
> > of sub-devices we actually failed to register.
> 
> No objections... but won't the tag added by dev_err() already
> disambiguate?

The difference will be between CS5532 and  CS5532 OLPC.

Please see patch 4 in the series.

> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > ---
> >  drivers/mfd/cs5535-mfd.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/mfd/cs5535-mfd.c b/drivers/mfd/cs5535-mfd.c
> > index f1825c0ccbd0..2c47afc22d24 100644
> > --- a/drivers/mfd/cs5535-mfd.c
> > +++ b/drivers/mfd/cs5535-mfd.c
> > @@ -127,10 +127,11 @@ static int cs5535_mfd_probe(struct pci_dev *pdev,
> >  		cs5535_mfd_cells[i].id = 0;
> >  	}
> >  
> > -	err = mfd_add_devices(&pdev->dev, -1, cs5535_mfd_cells,
> > +	err = mfd_add_devices(&pdev->dev, PLATFORM_DEVID_NONE, cs5535_mfd_cells,
> >  			      ARRAY_SIZE(cs5535_mfd_cells), NULL, 0, NULL);
> >  	if (err) {
> > -		dev_err(&pdev->dev, "MFD add devices failed: %d\n", err);
> > +		dev_err(&pdev->dev,
> > +			"Failed to add CS5532 sub-devices: %d\n", err);
> 
>                                            ^^^
> 
> Typo (and MODULE_DESCRIPTION() says this is a driver for CS5536 too).
> Once that is fixed:
> Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>

Ta.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
