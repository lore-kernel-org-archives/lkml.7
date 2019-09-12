Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4863BC4CEC5
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 13:46:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20C7520856
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 13:46:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JSBEkRcK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731283AbfILNqr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 09:46:47 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:45015 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732123AbfILNqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 09:46:46 -0400
Received: by mail-lf1-f65.google.com with SMTP id q11so4467709lfc.11
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 06:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IxAIHy7z7OjGzOcJLm7mV4i2e9Ufg5GWnfAL1EPdhuw=;
        b=JSBEkRcKpYsmirXMw0E6Xl530d2wdWrDWdOAI/GZtFqrGL028ZnO8g40fXoK8DLbKa
         iyJU/QeL+1kC957ltdQS8KLIjp3aKCBP+W4d6WmLXsUxZouOgMoapIgv2URetNzS/6nj
         eFHPABwGjSut9Ntg4wjUCs7HFTqx0iWn6+9IAzUPHez7JBtR1uVAGRq55GpFKIMSOAyA
         rr7djmdcaZuAQKkTX9Fc4+9pkM2bVBukkM28UGAzm6bEN7DqOf7Z3bDl2j4PQl7hBVAe
         c2yvHF4tVxjSluiXZkAohO5iDBA3ovZ7oSzBiMa/9b0Fz+ccMdmfGVjtGpnDdn5JCaR1
         l6pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IxAIHy7z7OjGzOcJLm7mV4i2e9Ufg5GWnfAL1EPdhuw=;
        b=DETpfigcITpn4IXKR2OIrlsPVnAiY3IoLTDJox7hpNyV8iow7T60WjY4tXoEOdeXhe
         Mirlfudl43kRy43PLku1yRtR8r9vLlvESsOJbwJ9fe4fBxC4S4lEtuAQJL5Nubmdby2F
         D5wCnClyXxU6XwxV54mMxs6zXc+Pk3iurwMThvr14n2FDTB3ooskssEe7dyfQdhOjdNZ
         WLGYXq+PswiO/0wf65ljkRdKDm8KekvQRvirVFTtHLCC2xeeLUVEE1r6QxS0QUAwuGzR
         PRYi2pLmAt78Vq9pGa93f3z0MQbCUO1Sw+CjMpkFtsXZysf1z4EGcqoR+CkcFXcuDnR0
         yGyw==
X-Gm-Message-State: APjAAAXpaVYt7i/miILS/3kjqrjifxWgEA5MbabPXIyaht4iiQBrAZRj
        Ra78uFdil+j09b+VPXyb+fA4M0/CrSNxpDvvt5mGFA==
X-Google-Smtp-Source: APXvYqxBQEhNgGyrV+aGEpNgiBh8jz3FwkP2/RjoOFz3uVnJ32fi19wRByEekPgtqxUvCFvqs36MWCHffuJdV5KoIcM=
X-Received: by 2002:ac2:530e:: with SMTP id c14mr1145645lfh.165.1568296005240;
 Thu, 12 Sep 2019 06:46:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190905141304.22005-1-alexandre.belloni@bootlin.com>
 <CACRpkdbVC6DLHWftpL1wfkx_kWyfE=LpCQWZw=cv=RMVxDBm_g@mail.gmail.com> <20190911091101.GC21254@piout.net>
In-Reply-To: <20190911091101.GC21254@piout.net>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 12 Sep 2019 14:46:32 +0100
Message-ID: <CACRpkdbziti1yBY_mZaGPg+jHVPR8vtRm8oNZBqt6e+m2wh67A@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: at91-pio4: implement .get_multiple and .set_multiple
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2019 at 10:11 AM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
> On 11/09/2019 01:27:10+0100, Linus Walleij wrote:

> > > +#if ATMEL_PIO_NPINS_PER_BANK != BITS_PER_LONG
> >
> > Should it not be > rather than != ?
>
> Realistically, the only case that could happen would be
> ATMEL_PIO_NPINS_PER_BANK == 32 and BITS_PER_LONG ==64. so I would go for
> ATMEL_PIO_NPINS_PER_BANK < BITS_PER_LONG

OK I see.

> > > +               word = BIT_WORD(bank * ATMEL_PIO_NPINS_PER_BANK);
> > > +               offset = bank * ATMEL_PIO_NPINS_PER_BANK % BITS_PER_LONG;
> > > +#endif
> >
> > This doesn't look good for multiplatform kernels.
>
> I don't think we have multiplatform kernels that run both in 32 and 64
> bits. I don't believe ATMEL_PIO_NPINS_PER_BANK will ever change, it has
> been 32 on all the atmel SoCs since 2001.

So there is a bit missing from the commit message: the info that
the same driver is being used on 32 and 64 bit builds, and that is
the reason we allow compile-time ifdef things.

Can you add this to the commit message, or maybe
inline in the code, or both?

It confused me so it will confuse others.

Yours,
Linus Walleij
