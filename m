Return-Path: <SRS0=KBKa=UT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB95C43613
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 12:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 42D10206E0
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Jun 2019 12:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UD2HEJxI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731808AbfFTM26 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Jun 2019 08:28:58 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35377 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731743AbfFTM26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jun 2019 08:28:58 -0400
Received: by mail-wm1-f65.google.com with SMTP id c6so2999376wml.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2019 05:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=f8A38WuFGwuhUpIag07Mu5Ad2tlvuMwviR3nNUO1eYc=;
        b=UD2HEJxIaZYFN31LZj5+kRb827BBEknCjoff00qcVtmDfXoih9RTdVVDk2A28tEDPX
         uL6DgkzoiFr3IYYvQC8PM9dHOcHFGPmvGskBatlKBBrH3GdhYx2yK/XrxWquZyEPX2pe
         EDSAie7w6zSMZNMsOcYDoAVp9RJMTqsBiLewKrSNJxOaa+nWK94OSBwCp2TGLE/vsCAX
         fm1VxysEEzZEgpdoMU5KBnMSWeIXrrnuzkdtuFrdOBCgI7BcDHtllqpVV1N8euujUxvN
         UcEVotm6+4sGk69SiCgC8WQ1DZsZdYkp3nMHU/LcuIVPG64NnsKeja6vsHDzIhxjEC4C
         6ngg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=f8A38WuFGwuhUpIag07Mu5Ad2tlvuMwviR3nNUO1eYc=;
        b=ERw+cXqfNxLdozy1QZQlbZVpADDV2Nk4DJSmpn9pn9HK/oTX6QY3QYkWnBJRwwdYOR
         tTfDm/gDCRoLgA/5dACCAqRGbWIOM2tnJWfLBsiDim9V3GUGmtjTyxIgJ0HxIqg1YBut
         FN2Xq4ovYTINhacU0RVx4uwfDdFHKmaJl21WjtCDCQa5x3IWr03dNIB0Cdrj2ic+9Qzc
         5fzh/ObGvWw7S0m1iwDL1MpVbtsDpn1CRHQ244EDpy1SZzGooWzCMAqj+OfODqhBJ+oB
         BMTsAhErXePKT0gPpKKsuCqMqKBXMqbdg85cd4eNC5AUYZzIVuiHHTeegBKe02eguq3E
         xU6g==
X-Gm-Message-State: APjAAAU7Z/YFDw2/D9xqYXTGWJkuADaXGRIw2h/8GIo6DZVXziS+Y1oG
        pGrpcVtdKOvb1psgri5bvwwTHA==
X-Google-Smtp-Source: APXvYqwdnD8aCGlhiKsRg0lBY/4mAWljDCZ/gIODZhpJgrKYLXJdy2inAGcX+Y9xJvhsdnpUve6dwQ==
X-Received: by 2002:a1c:7008:: with SMTP id l8mr2602367wmc.64.1561033736096;
        Thu, 20 Jun 2019 05:28:56 -0700 (PDT)
Received: from dell ([2.27.35.243])
        by smtp.gmail.com with ESMTPSA id k82sm5613177wma.15.2019.06.20.05.28.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Jun 2019 05:28:55 -0700 (PDT)
Date:   Thu, 20 Jun 2019 13:28:53 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Steve Twiss <stwiss.opensource@diasemi.com>
Cc:     "wsa+renesas@sang-engineering.com" <wsa+renesas@sang-engineering.com>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "kieran.bingham+renesas@ideasonboard.com" 
        <kieran.bingham+renesas@ideasonboard.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "peda@axentia.se" <peda@axentia.se>,
        Support Opensource <Support.Opensource@diasemi.com>
Subject: Re: [PATCH] mfd: da9063: occupy second I2C address, too
Message-ID: <20190620122853.GD4699@dell>
References: <AM6PR10MB218184C8F2206024C6CB77EAFEE40@AM6PR10MB2181.EURPRD10.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AM6PR10MB218184C8F2206024C6CB77EAFEE40@AM6PR10MB2181.EURPRD10.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jun 2019, Steve Twiss wrote:

> (resend because the e-mail client added HTML formatting to my last reply)
> 
> Hi Wolfram,
> 
> On Wed, 19 Jun 2019 19:18:06, Wolfram Sang wrote:
> 
> > Subject: [PATCH] mfd: da9063: occupy second I2C address, too
> > 
> > Even though we don't use it yet, we should mark the second I2C address
> > this device is listening to as used.
> 
> Sure. There is a second method for accessing higher pages of registers.
> The DA9063 Datasheet Revision 2.2, 12-Mar-2019, page 96, says this:
> 
> In 2-WIRE operation, the DA9063 offers an alternative method to access register pages 2 and 3.
> These pages can be accessed directly by incrementing the device address by one (default read
> address 0xB3; write address 0xB2). This removes the need to write to the page register before
> access to pages 2 and 3, thus reducing the traffic on the 2-WIRE bus.
> 
> Is this a safety clause? What I mean is, shouldn't the hardware design make
> sure there are not two devices located on the same I2C bus with the same slave
> address?

Why isn't this reply attached (threaded) to the patch.

Is your mailer broken?

> > Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > Reviewed-by: Peter Rosin <peda@axentia.se>
> > Reviewed-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> > ---
> >  drivers/mfd/da9063-i2c.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/drivers/mfd/da9063-i2c.c b/drivers/mfd/da9063-i2c.c
> > index 455de74c0dd2..2133b09f6e7a 100644
> > --- a/drivers/mfd/da9063-i2c.c
> > +++ b/drivers/mfd/da9063-i2c.c
> > @@ -221,6 +221,8 @@ static int da9063_i2c_probe(struct i2c_client *i2c,
> >  		return ret;
> >  	}
> >  
> > +	devm_i2c_new_dummy_device(&i2c->dev, i2c->adapter, i2c->addr + 1);
> > +
> >  	return da9063_device_init(da9063, i2c->irq);
> >  }
> >  
> 

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
