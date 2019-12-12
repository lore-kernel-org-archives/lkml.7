Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D03F7C00454
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 15:08:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7296206C3
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 15:08:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m4/Wr2qv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729062AbfLLPI5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 10:08:57 -0500
Received: from mail-ua1-f65.google.com ([209.85.222.65]:38639 "EHLO
        mail-ua1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728666AbfLLPI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 10:08:57 -0500
Received: by mail-ua1-f65.google.com with SMTP id z17so1023337uac.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2019 07:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BBZPqQLjRrXMYmR1TRaqMyhH4qY4XtbQYO8hjLWbaCQ=;
        b=m4/Wr2qvLIWwO/nnv/MWFlzrVTYqwIuP//VHOprM0TS4aqnouLBYYbuKXDfZOW4zy6
         WwGNt6wKboMPLkZ2E8/NZCbgzjnehCPCJew6MkeU98jvV4zfh3C9C65H7kzchE6IfEc3
         cPsLn0wlOvRbdjWraOtHB9YHqPNxincix8AEtn1vTYqcZFNx++w0YhKkj22b+wEn8D58
         KihdxGOOV7uAKzwjHIWmulnscOi9cX+DuB+DkH8CWtEvucWc13p3AmI36VLn7BCMFG22
         2TmNAFLJ76Xm9ie4xkbBYzaNembFUKkM0K5MrWfnOhPIfPCMMWLF/Aei/G4b6ruqQ5om
         6DNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BBZPqQLjRrXMYmR1TRaqMyhH4qY4XtbQYO8hjLWbaCQ=;
        b=h8q8Bczto0FWXj1jdNp+/CBzxm1Y9yD2X+omKkJaxZJT7vhyBdTWXX3pH2IF3stOTR
         oL9mxVoV7ZsroaDeQTYr/hHW62Cio/JK26I+4Fa3EBe85XlApmq89tudanHPksPHC/E+
         2q3uRMIA+FjtdhzAv3oH2yIbLL+S/kEciieuZAY53hlYga0xdaJK5H8aZW3H91POdchZ
         u6DN6spEqgx5i2hEsRTdnXWf0Ucate05Up3tV3hZ3T+MJ1L8akfI/b6qYMz68jJOsgh4
         aC89BHOyU5ni0DHVNA+ngYZo8cM1dq5OgNFwcgT+rNw8degJleOnsgZ4xtN+O6BCpFQ4
         MvYw==
X-Gm-Message-State: APjAAAWZsMWa1mtyxr6Xt0uPZCzBysgXzflnBrwix0zG8hbHfmyxp09A
        lY/nd9zvk4hYqwxFiMjdWjmJx5lLVuwmUW9J2fNlfg==
X-Google-Smtp-Source: APXvYqylzTcuVtIdKTe2ptVzi2MZfkuPeOlp+Ab7T3CJfNA/27r7rEWO5mUtRTY83LtjQy3Do512L/IYNuh6OowCLas=
X-Received: by 2002:ab0:2716:: with SMTP id s22mr8672177uao.20.1576163336218;
 Thu, 12 Dec 2019 07:08:56 -0800 (PST)
MIME-Version: 1.0
References: <20191129172537.31410-1-m.felsch@pengutronix.de>
 <20191129172537.31410-4-m.felsch@pengutronix.de> <20191204134631.GT1998@sirena.org.uk>
 <20191210094144.mxximpuouchy3fqu@pengutronix.de> <AM5PR1001MB099497419E4DCA69D424EC35805A0@AM5PR1001MB0994.EURPRD10.PROD.OUTLOOK.COM>
 <20191211170918.q7kqkd4lrwwp7jl3@pengutronix.de>
In-Reply-To: <20191211170918.q7kqkd4lrwwp7jl3@pengutronix.de>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 12 Dec 2019 16:08:44 +0100
Message-ID: <CACRpkda4PFA=99u33xsXzQND1FaP=8GXGRQULngcd5a=zFepXg@mail.gmail.com>
Subject: Re: [PATCH v3 3/6] dt-bindings: mfd: da9062: add regulator voltage
 selection documentation
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
        Mark Brown <broonie@kernel.org>,
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

On Wed, Dec 11, 2019 at 6:09 PM Marco Felsch <m.felsch@pengutronix.de> wrote:

> I discussed it with a colleague again and he mentioned that pinctrl
> should be named pinctrl instead it should be named padctrl.

Quoting Documentation/driver-api/pinctl.rst:

(...)
Definition of PIN:

- PINS are equal to pads, fingers, balls or whatever packaging input or
  output line you want to control and these are denoted by unsigned integers
  in the range 0..maxpin.
(...)

> We don't
> reconfigure the pad to a other function it is still a device general
> purpose input pad. The hw-signal flow goes always trough the gpio block
> so one argument more for my solution. Also we don't configure the "pad"
> to be a vsel/ena-pin. The hw-pad can only be a gpio or has an alternate
> function (WDKICK for GPIO0, Seq. SYS_EN for GPIO2, Seq. PWR_EN for GPIO4).
> Instead we tell the regulator to use _this_ GPIO e.g. for voltage
> selection so we go the other way around. My last argument why pinctrl
> isn't the correct place is that the GPIO1 can be used for
> regulator-0:vsel-in and for regulator-1:enable-in. So this pad would
> have different states which is invalid IMHO.

Yeah it is just one of these cases where the silicon designer pulled
a line of polysilicone over to the regulator enable signal and put a
switch on it and say "so you can also enable the regulator
with a signal from here", it can be used in parallel with anything
else, which is especially messy.

Special cases require special handling, since the electronic design
of this thing is a bit Rube Goldberg.

Yours,
Linus Walleij
