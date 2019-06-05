Return-Path: <SRS0=eu/B=UE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04ECCC282DE
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 08:23:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEC5520866
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Jun 2019 08:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UqEtGE+i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbfFEIXd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Jun 2019 04:23:33 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37617 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbfFEIXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jun 2019 04:23:32 -0400
Received: by mail-wm1-f66.google.com with SMTP id 22so1298643wmg.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2019 01:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=KB8B36tEhg7g9/5o0/vbeuwsLyG7Xckc2xGFAP6zc6U=;
        b=UqEtGE+iGLEv5a8+dhYUt/TpItZVF7YutlO2qMc8O+pmYdpG03c90Q518SSLMajSWX
         f40/pwGMGtZCV4kbgbWm0h1VBrWAX3B+JhWGEJIOiQNTAxpC6a0767jdQXd2NJSczqCn
         Rs9t3jhO9MHLwTczbKWos+GUz2T/hyu1HSM1lGIRsKGEHcChMtA2FgZodaGlisIRYavh
         73kSTJkBWr2HxbeHeJcnCdjbOB6Pjxpscko+f36AOaVmL1y652yazuLNBrB8XoqUiqb2
         YrzeXXMfW0z4uJDCH9Px7WTFnuY7s4VmVe8yBfYOi4IiJpYCUjXKiUTI5F+B+Q1eyAVc
         Ts+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=KB8B36tEhg7g9/5o0/vbeuwsLyG7Xckc2xGFAP6zc6U=;
        b=uNfgg85dbX6IlBzWNgrd6O+N8zu46VsF6btP1evlLixWkxel5W6LMAsCR176qiFyPY
         +CGWEv4ei4eqKzkyEvZAznY7wo8BGh1MJHpZcUvgNAsMXReVQGpYvyyQk+w0Z7jHLC3k
         0FCL33qy3yO/Cq0Q/PUmxaPYvzhWUKv9V7MdquDd6uDEoKEmgRC0K2l5r2tpC6Hgc7wn
         3EhUEpuwMjbBQn+UQXtTx8nDr34QZtiaUqZAl7zeT2G0Cqx4fK13DRxhZrXe3CQm1JeI
         yMsrSgIwxUs/PG9xHTLTLHrxT8/MwtSA95X5OA9NQph96Dnfm52uSw+yVh7YnZJS7Tcg
         EW+g==
X-Gm-Message-State: APjAAAWTw7sxLkYhYBCEBdKDkUD+jRveSl9SLyrmsAQPEySpzoAWtjUL
        9dsORw+VySAD4Dg1xwLDo9UEiw==
X-Google-Smtp-Source: APXvYqyn7r2Og6MqHzF9tB1GS7hQSk2g0XHprHTvLKG654EdQDiLEPjf16VyH9JzBnK035IC2hV9qw==
X-Received: by 2002:a1c:f311:: with SMTP id q17mr20555885wmq.2.1559723010516;
        Wed, 05 Jun 2019 01:23:30 -0700 (PDT)
Received: from dell ([2.27.167.43])
        by smtp.gmail.com with ESMTPSA id d2sm14874801wmb.9.2019.06.05.01.23.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Jun 2019 01:23:29 -0700 (PDT)
Date:   Wed, 5 Jun 2019 09:23:27 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>, balbi@kernel.org,
        wsa+renesas@sang-engineering.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-usb <linux-usb@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Brown <david.brown@linaro.org>, alokc@codeaurora.org,
        kramasub@codeaurora.org, linux-i2c <linux-i2c@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        Jeffrey Hugo <jlhugo@gmail.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 2/8] i2c: i2c-qcom-geni: Signify successful driver probe
Message-ID: <20190605082327.GN4797@dell>
References: <20190604104455.8877-1-lee.jones@linaro.org>
 <20190604104455.8877-2-lee.jones@linaro.org>
 <20190605062020.GL22737@tuxbook-pro>
 <20190605071625.GK4797@dell>
 <CAKv+Gu_YcdePUkkCGdP5DC9rxCUAshgOzU32pViAp2CbmAaJuw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKv+Gu_YcdePUkkCGdP5DC9rxCUAshgOzU32pViAp2CbmAaJuw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Jun 2019, Ard Biesheuvel wrote:

> On Wed, 5 Jun 2019 at 09:16, Lee Jones <lee.jones@linaro.org> wrote:
> >
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
> > > >             return ret;
> > > >     }
> > > >
> > > > +   dev_info(&pdev->dev, "Geni-I2C adaptor successfully added\n");
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
> >
> 
> I agree.
> 
> There are numerous EHCI drivers IIRC which, if compiled in,
> unconditionally print some blurb, whether you have the hardware or
> not, which is pretty annoying.
> 
> In this case, however, having a single line per successfully probed
> device (containing the dev_name and perhaps the MMIO base address or
> some other identifying feature) is pretty useful, and shouldn't be
> regarded as log spamming imo. dev_info() honours the 'quiet' kernel
> command line parameter, and so you will only see the message if you
> actually look at the log.

+999

This is exactly as I see it.

If people want a quiet log/fast boot-up times, they can request it.
Otherwise, it's far more useful to trade a second or two for
important information such as which devices are present/enabled on a
platform.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
