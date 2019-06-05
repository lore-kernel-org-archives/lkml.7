Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A6B4C282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 08:20:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F105A2075C
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 08:20:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EEsoVwHJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfFEIUx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 04:20:53 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35616 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726501AbfFEIUw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 04:20:52 -0400
Received: by mail-wr1-f65.google.com with SMTP id m3so2663123wrv.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 01:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=4N4wbbPbH5vFPQ02lIzPzQHg+yDqqNmeJgiKq0aKWHQ=;
        b=EEsoVwHJfcVfB0ReGOh4L2CQa6hWhl7NbcxauHoct4OV4K/eJmfkm8ODRylrWf0538
         cFa6Ud53SF9GDxPzTf2QH8ClrklK6SAbghEFIvkPB08cXK8dmhn83Xof+s2ZK+q518Aj
         2GSJmz2YyAyeCySlO/be4cLEbL9RVXGU2l/CaV+hYuqsyJZHVcKKnBUKrOw96GNUV40b
         KNe4oyVp/g92y3oHSnA66Q/gFpFB8Qukzyhelc9SvseBGDW6imI5ONkiObzQkjBsYMub
         PuXqEPcOMPhEBrpFa02315DvejuZd4l+e3SZjyFqd8VDsFe7rOanchMNtkmv8jUP81la
         /Ovg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=4N4wbbPbH5vFPQ02lIzPzQHg+yDqqNmeJgiKq0aKWHQ=;
        b=LhpH0YnDqq/kXj2YlpSlTrmOkYWrTIFZlrXTAkmLzRgLk1L+roUJVzCeUJNpYHWbqe
         1PRbDddVHc79RdR4aW1lbDzi4pfkWbwWL8hB2rY1QOjoVlne9DwayNs8VeFwAaPvxEfm
         XJJLxsCVe5epjA2KBC7kIVTEH69gmSILKvKM7SVtFUzCfTtRX8i031bBNpln1Ly4T6FE
         K/xP89TUVQX+b3YYmWW1Vn7inb9o3eqN8Ex/i7vpJp1nmmCkrGNdnHNY3tBuXog0yBjP
         7ea4HhWxPfnmxfPQBIorwdmilpL78WQxWLPz/lkc07rctcZ+93s8ZQ1+Hs/r/6CC1ci4
         DI3g==
X-Gm-Message-State: APjAAAXTVaMa3WDgexn+GS83rDSt/v3AI2JfLmZQE73F18u6k+qAKEVg
        diAwSbguRsU3vYQtEf2KoXQ1QA==
X-Google-Smtp-Source: APXvYqx/8oIyrbj4ascfwZpwcyMAKVAvtaBu7KaV63F4l5bAfkhGLPkaQF18jo6DwFQGyXdhimt4dQ==
X-Received: by 2002:adf:f38a:: with SMTP id m10mr9150235wro.81.1559722850820;
        Wed, 05 Jun 2019 01:20:50 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id a62sm21930094wmf.19.2019.06.05.01.20.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Jun 2019 01:20:49 -0700 (PDT)
Date:   Wed, 5 Jun 2019 09:20:47 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>, balbi@kernel.org,
        wsa+renesas@sang-engineering.com, gregkh@linuxfoundation.org,
        linus.walleij@linaro.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, david.brown@linaro.org,
        alokc@codeaurora.org, kramasub@codeaurora.org,
        linux-i2c@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, andy.gross@linaro.org,
        jlhugo@gmail.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 2/8] i2c: i2c-qcom-geni: Signify successful driver probe
Message-ID: <20190605082047.GM4797@dell>
References: <20190604104455.8877-1-lee.jones@linaro.org>
 <20190604104455.8877-2-lee.jones@linaro.org>
 <20190605062020.GL22737@tuxbook-pro>
 <20190605071625.GK4797@dell>
 <20190605075656.GC29637@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190605075656.GC29637@localhost>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Jun 2019, Johan Hovold wrote:

> On Wed, Jun 05, 2019 at 08:16:25AM +0100, Lee Jones wrote:
> > On Tue, 04 Jun 2019, Bjorn Andersson wrote:
> > 
> > > On Tue 04 Jun 03:44 PDT 2019, Lee Jones wrote:
> > > 
> > > > The Qualcomm Geni I2C driver currently probes silently which can be
> > > > confusing when debugging potential issues.  Add a low level (INFO)
> > > > print when each I2C controller is successfully initially set-up.
> > > > 
> > > > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > > > ---
> > > >  drivers/i2c/busses/i2c-qcom-geni.c | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > > 
> > > > diff --git a/drivers/i2c/busses/i2c-qcom-geni.c b/drivers/i2c/busses/i2c-qcom-geni.c
> > > > index 0fa93b448e8d..e27466d77767 100644
> > > > --- a/drivers/i2c/busses/i2c-qcom-geni.c
> > > > +++ b/drivers/i2c/busses/i2c-qcom-geni.c
> > > > @@ -598,6 +598,8 @@ static int geni_i2c_probe(struct platform_device *pdev)
> > > >  		return ret;
> > > >  	}
> > > >  
> > > > +	dev_info(&pdev->dev, "Geni-I2C adaptor successfully added\n");
> > > > +
> > > 
> > > I would prefer that we do not add such prints, as it would be to accept
> > > the downstream behaviour of spamming the log to the point where no one
> > > will ever look through it.
> > 
> > We should be able to find a middle ground.  Spamming the log with all
> > sorts of device specific information/debug is obviously not
> > constructive, but a single liner to advertise that an important
> > device/controller has been successfully initialised is more helpful
> > than it is hinderous.
> > 
> > This print was added due to the silent initialisation costing me
> > several hours of debugging ACPI device/driver code (albeit learning a
> > lot about ACPI as I go) just to find out that it was already doing the
> > right thing - just very quietly.
> 
> No, we don't add noise like this to the logs just because it may be
> useful while debugging. Even one-liners add up.

One line per device is should not cause an issue.

Problems occur when developers try to print all kinds of device
specifics to the boot log.  A simple, single line for such an
important device/controller has more benefits than drawbacks.

> There are plenty of options for debugging already ranging from adding a
> temporary dev_info() to the probe function in question to using dynamic
> debugging to have driver core log every successful probe.

This is what I ended up doing.  It was time consuming to parse though
a log of that size when you have no paging or keyboard.

> And in this case you say the driver was in fact already bound; that can
> easily be verified through sysfs too in case things aren't behaving the
> way you expect.

Not in a non-booting system with no keyboard you can't. ;)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
