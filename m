Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C08ECA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 12:08:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7022E21479
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 12:08:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P5lX77UJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731710AbfJ2MI1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 08:08:27 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46673 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730482AbfJ2MI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 08:08:26 -0400
Received: by mail-wr1-f65.google.com with SMTP id n15so13325008wrw.13
        for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2019 05:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=AThmdWLvoHXRd+gCJ7Rc/MdmxHKDL94oX7/2fySCtI4=;
        b=P5lX77UJ1HJtxK6+w+SrHuDYaDtyieTnHZhqXpqYQooiSH5Kll8AXspDAhkEL4wIlw
         hBQYFRsjp/fhhGLvnGTbxW6Cyas8J5lT2DcgCgvszMF1npFF0o8wt1J4os797vV6KthD
         nch41e/zHWkALfLf1XQs2qEjEnQM6Z9jR0kMq9jvNfBVQj50Ghnb0ZLGlD58WAS85xzH
         TTGyIn5cfIa7QmPPxEX7tFIwsMjItnnJ5oIxUu8Tvlmktoq1n6/IUWv/sEjQKzxXF3B1
         rsdKdUZQNLGLRGmFYe1SoMSneOkEPEKsXkC4N3S2QAEX/dSXn/h+46Mutakba5iRRMUf
         9RuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=AThmdWLvoHXRd+gCJ7Rc/MdmxHKDL94oX7/2fySCtI4=;
        b=luofs0btaawVfjtTMJRTMmrZHBec/H9NmirGpXKJmFJK2/N8aBctMw0F0lRr1CBoFI
         gW8//mLpre5v6i8H3D9/bWvP4kMjw/teTpfDYMnZarCXNkmNVn4FkypIteNHit9ZtcH8
         v5GQEGAVt/PUA0HlzcrBLJrQj2Jws/R9N36+yoAo1h/CGoeoJ674jiQJjhXG9R+zb3Qv
         HcfHDqKij8rzjyAt5N0q0ueNh0L+hyENLLa8pkf2L5SzQBWmNqIxQm8BEyvxL4ZcMNVV
         MYjAKmiX33/ZpLGJulTni4P/nxMlzWIyQEyATdEYaPWjA+lTgQM3dwyPqJlGIK4WZzR/
         M/Cw==
X-Gm-Message-State: APjAAAW4mfy8+pumMPrVLiyolow5Vr6gMoxE8LDIkcN29KOC/cs3s7fY
        5pEqxgUQB3RG9tRve/6wApOusg==
X-Google-Smtp-Source: APXvYqzgTN+N15xxbnf2G3a5OZaR/6UqN35YmkJy8Yi15GIpGWNYrXR0LpTtgteSgBb/D3JIn1j0jQ==
X-Received: by 2002:adf:e488:: with SMTP id i8mr19406966wrm.302.1572350903096;
        Tue, 29 Oct 2019 05:08:23 -0700 (PDT)
Received: from dell ([2.31.163.64])
        by smtp.gmail.com with ESMTPSA id g5sm2893643wmg.12.2019.10.29.05.08.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 29 Oct 2019 05:08:22 -0700 (PDT)
Date:   Tue, 29 Oct 2019 12:08:20 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     "mazziesaccount@gmail.com" <mazziesaccount@gmail.com>,
        "dmurphy@ti.com" <dmurphy@ti.com>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alexandre.belloni@bootlin.com" <alexandre.belloni@bootlin.com>,
        "mturquette@baylibre.com" <mturquette@baylibre.com>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "jacek.anaszewski@gmail.com" <jacek.anaszewski@gmail.com>,
        "a.zummo@towertech.it" <a.zummo@towertech.it>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        "sboyd@kernel.org" <sboyd@kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>,
        "broonie@kernel.org" <broonie@kernel.org>
Subject: Re: [RFC PATCH v2 02/13] dt-bindings: mfd: Document ROHM BD71828
 bindings
Message-ID: <20191029120820.GA4484@dell>
References: <cover.1571915550.git.matti.vaittinen@fi.rohmeurope.com>
 <0182df3c49c6c804ee20ef32fc4b85b50ff45fca.1571915550.git.matti.vaittinen@fi.rohmeurope.com>
 <ed0b2aa8-8a70-0341-4ecf-8959f37c53bd@ti.com>
 <5c793f1308ccc6e787260b64fe6a875a8d0eb9d0.camel@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5c793f1308ccc6e787260b64fe6a875a8d0eb9d0.camel@fi.rohmeurope.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Oct 2019, Vaittinen, Matti wrote:

> Hello Dan,
> 
> Thanks again for checking this :)
> 
> On Thu, 2019-10-24 at 14:35 -0500, Dan Murphy wrote:
> > Matti
> > 
> > On 10/24/19 6:41 AM, Matti Vaittinen wrote:
> > > ROHM BD71828 Power management IC integrates 7 buck converters, 7
> > > LDOs,
> > > a real-time clock (RTC), 3 GPO/regulator control pins, HALL input
> > > and a 32.768 kHz clock gate.
> > > 
> > > Document the dt bindings drivers are using.
> > > 
> > > Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> > > ---
> > > 
> > > No changes since v1
> > > 
> > >   .../bindings/mfd/rohm,bd71828-pmic.txt        | 180
> > > ++++++++++++++++++
> > >   1 file changed, 180 insertions(+)
> > >   create mode 100644
> > > Documentation/devicetree/bindings/mfd/rohm,bd71828-pmic.txt
> > 
> > I will let maintainers weigh in here but if this is new this should 
> > probably be in the yaml format to avoid conversion in the future

Yes please.

> Oh... This is new to me. I guess there are reasons for this - but I
> must say I am not excited as I have never used yaml for anything. I'll
> do as you suggest and wait for what others have to say :) Thanks for
> pointing this out though.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
