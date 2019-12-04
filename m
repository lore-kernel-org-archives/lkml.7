Return-Path: <SRS0=oopU=Z2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BCF4C2BD09
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 16:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CAA76206DB
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Dec 2019 16:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="pEoHuUuN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728859AbfLDQdR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 11:33:17 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:45270 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728241AbfLDQdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 11:33:16 -0500
Received: by mail-oi1-f194.google.com with SMTP id v10so5340576oiv.12
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2019 08:33:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=n2y9bKsjHQQ/sQYW5a+q8cQ+TWGbOrBBM4+4Kc0+440=;
        b=pEoHuUuNqCmDLMoZdmaR8AvTgeAlEVhDMUh7j1A3rIp0mq4dyAAeTeZG0raj7t38/y
         u4V8BlZTZNAVDz2HJ6suNvgMfl3G55Bmef9/ApmNO3bFOn0uZXyFGH0hPxvBD9E1tBZl
         7rfMDg6n5pdvH+nzBjgXMq/uKKDSc++l9eeCOFbfiJAi3WIR2gAAmanN51TGgExcnOZE
         FsYu0UDVwSAcncxisd5UJOCkfCbk0YUXMRh7E6ZEkMFldf9F5msPfq6DV74gmCJ3hI6C
         yLjtO9dpa6WoelsjKpnTrGRBxE3WhRKTKWL530Bg9WX6BsN7u4IGclcds4vTn658Qam/
         BwVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=n2y9bKsjHQQ/sQYW5a+q8cQ+TWGbOrBBM4+4Kc0+440=;
        b=YtZPJEjpcE+GI4a/qGEIkFfdMEjx6OzEwU0QGqSGfj8VTxV/R4zC6mDhAMoBIVrOz9
         bglb350w4q4TTFnUTLmwflsxFHj7C0sVDF8sgh78uEhO4aG9Jbq49um2RhCG/DZ0gEKT
         b1fuEBTFnHsnoBWlftyYduuGOOOF4OvoXsJ1DrxXvMh7nKCJvbhBn9uwFHtrudAgvFD9
         rUCOrSK3oknEWmS4KjKfxwiaismo81zPsU5AfqJQS97kypjeTOAE9LqJcGHILco74AnH
         sMFkicGRu3Sla7BLMRLvZXuOO25UAl5CN+F7xUTRMcSID4XiJbFKVzfV1Z+OUdjyPdav
         OpSw==
X-Gm-Message-State: APjAAAWLJfsZZcUL0eIr6q+I8MyO6G7qP8RJAHqRmukjprvzaZi+S8hF
        pKN2sP72K3Y/eJ3TaW+1SFFNlPmfAXgIrkPGJhntKw==
X-Google-Smtp-Source: APXvYqyy3s4IwVckknMZiz0lfEUnnNfxopjnZCuAwE48pDY5+FgfnXPScog/M5ofsCmDliXQ5ArkAROB6dwPhqVZxdc=
X-Received: by 2002:aca:d904:: with SMTP id q4mr3404877oig.21.1575477194797;
 Wed, 04 Dec 2019 08:33:14 -0800 (PST)
MIME-Version: 1.0
References: <1575433106-16171-1-git-send-email-peng.fan@nxp.com> <20191204072422.vfo3mrrcaav75jv4@pengutronix.de>
In-Reply-To: <20191204072422.vfo3mrrcaav75jv4@pengutronix.de>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Wed, 4 Dec 2019 17:33:04 +0100
Message-ID: <CAMpxmJUAk5Y3mX_irTjwveaii8W=coaG0w2aWvFXUEXqHxpArQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] gpio: mvebu: use platform_irq_count
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Peng Fan <peng.fan@nxp.com>,
        "rjui@broadcom.com" <rjui@broadcom.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "sbranden@broadcom.com" <sbranden@broadcom.com>,
        "thierry.reding@gmail.com" <thierry.reding@gmail.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "bcm-kernel-feedback-list@broadcom.com" 
        <bcm-kernel-feedback-list@broadcom.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-pwm@vger.kernel.org" <linux-pwm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Alice Guo <alice.guo@nxp.com>,
        Sascha Hauer <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=9Br., 4 gru 2019 o 08:24 Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> napisa=C5=82(a):
>
> On Wed, Dec 04, 2019 at 04:20:41AM +0000, Peng Fan wrote:
> > From: Peng Fan <peng.fan@nxp.com>
> >
> > platform_irq_count() is the more generic way (independent of
> > device trees) to determine the count of available interrupts. So
> > use this instead.
> >
> > As platform_irq_count() might return an error code (which
> > of_irq_count doesn't) some additional handling is necessary.
> >
> > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> Reviewed-and-Commit-Log-Provided-by: Uwe Kleine-K=C3=B6nig <u.kleine-koen=
ig@pengutronix.de>

This is not a valid tag, but I take it as Suggested-by and Reviewed-by. :)

Bart

>
> :-)
> Best regards
> Uwe
>
> --
> Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig       =
     |
> Industrial Linux Solutions                 | https://www.pengutronix.de/ =
|
