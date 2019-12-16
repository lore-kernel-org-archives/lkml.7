Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA39BC43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 12:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E534206CB
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 12:28:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S/B9vSxt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbfLPM2n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 07:28:43 -0500
Received: from mail-vk1-f195.google.com ([209.85.221.195]:35585 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727569AbfLPM2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 07:28:42 -0500
Received: by mail-vk1-f195.google.com with SMTP id o187so1562458vka.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 04:28:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QaoPgwh2xfV295jRIGnmPYl36fDZZNdnkiloN5hh4CE=;
        b=S/B9vSxtl+yCUJ5TJtpNk2Stv/n4pxJen2cvthe3ynAP3s2fdfTEDf3tZomPyz6/ti
         c56rzuxM4QAB6cX1SwuBlhogEMIItrAmGHHi3ns9bmKzWiSCvIoPoAQsE6LewWidcSt/
         uS/ygBA6WwzxnYrECvxR1yO2wGs7T55an3bXKgv1VII9O7KQetwebEVFyS7PP5o5JG8Z
         WXw7M3EFBu/VJ44dxGgmBl8Gz7OGufeX8UpyQueudgpm0MdnhWFUBNsCWFzcddS22VKX
         sPNZI3c8eaEF8pJD1EuxwIwS1BAOsagfTF+6dyoXqycYB/nk0NUuEatN48eLbR9wzjR0
         GqBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QaoPgwh2xfV295jRIGnmPYl36fDZZNdnkiloN5hh4CE=;
        b=GVxEyVhXdaj1PPtclpEEEVKBtPYVmCVqV3ufGmEcUIyPrOYd5qhVSVX/3RD8v1Q3ss
         CgugfHSoNnfybBIHUog/CYukYPt0AH7fWHMRQWBw22hTTaDv3Nqqnd15lR94ptUGlMpl
         WvOxgf4EPRrtTKY5ErglJtB0Rt4nGK7DGba2wOgIKr/lY8sVqF8z+P+cRH9Em7key+GD
         110UlGpk9LLgh3lMmwGbXrlyO6njtFybmkjGJBP1FpMrlCjNTYMa5IOOf/YnNvpKj1Nz
         BKtFFxfSqdXG+RxOMeIBLdsHyWljvdbIEJEbg8Usl0X83MH53ZAg5lKbLU5cRFWHDdWe
         1lgA==
X-Gm-Message-State: APjAAAWz8H3zeQhHA2Zk9dMtml6wxgg0kPgRKcQAx2mO2OdboBUS5ay1
        NqMv/yR/aNdgwW7NE/90yQX992nVI+3KQYszihVcFKaztFY=
X-Google-Smtp-Source: APXvYqw/AlQK61lzoibi6xl6okziErleCZ8cs/LBZLmTMrBvWdsoY+o2BjyAVo3CYVnu+ks556/YdO+EFNqOolU0srg=
X-Received: by 2002:a1f:fe4e:: with SMTP id l75mr24217758vki.18.1576499321815;
 Mon, 16 Dec 2019 04:28:41 -0800 (PST)
MIME-Version: 1.0
References: <20191129172537.31410-1-m.felsch@pengutronix.de>
 <20191129172537.31410-4-m.felsch@pengutronix.de> <20191204134631.GT1998@sirena.org.uk>
 <20191210094144.mxximpuouchy3fqu@pengutronix.de> <AM5PR1001MB099497419E4DCA69D424EC35805A0@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
 <20191211170918.q7kqkd4lrwwp7jl3@pengutronix.de> <20191212161019.GF4310@sirena.org.uk>
 <20191212162152.5uu3feacduetysq7@pengutronix.de>
In-Reply-To: <20191212162152.5uu3feacduetysq7@pengutronix.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 16 Dec 2019 13:28:30 +0100
Message-ID: <CACRpkdbkiQLmyxHG4mAOqOho34UkUZwctRwsUgyJKCgZBOUEvQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] dt-bindings: mfd: da9062: add regulator voltage
 selection documentation
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     Mark Brown <broonie@kernel.org>,
        Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Support Opensource <Support.Opensource@diasemi.com>,
        "lee.jones@linaro.org" <lee.jones@linaro.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "bgolaszewski@baylibre.com" <bgolaszewski@baylibre.com>,
        "joel@jms.id.au" <joel@jms.id.au>,
        "andrew@aj.id.au" <andrew@aj.id.au>,
        "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 5:21 PM Marco Felsch <m.felsch@pengutronix.de> wrote:
> On 19-12-12 16:10, Mark Brown wrote:

> > Note that there's two bits to my concern - one is if we should be using
> > gpiolib or pinctrl, the other is what's driving the input (whichever API
> > it's configured through) which didn't seem to be mentioned.
>
> gpiolib or pinctrl:
> I pointed out all my arguments above so I think it is time for Linus.

I think I've elaborated on this?

The API is fine with me, because this thing does some autonomous
control and I don't know any better way to share that same line
with the GPIO subsystem than to make this offset available to
the regulator driver.

Yours,
Linus Walleij
