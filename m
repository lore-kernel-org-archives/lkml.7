Return-Path: <SRS0=HHJ+=YV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E5F8CA9EC0
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 18:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F404121920
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Oct 2019 18:01:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lixom-net.20150623.gappssmtp.com header.i=@lixom-net.20150623.gappssmtp.com header.b="KmtiF3LH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404243AbfJ1SA7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Oct 2019 14:00:59 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:38189 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729738AbfJ1SA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Oct 2019 14:00:59 -0400
Received: by mail-io1-f65.google.com with SMTP id u8so11731584iom.5
        for <linux-kernel@vger.kernel.org>; Mon, 28 Oct 2019 11:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lixom-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vQtW6xluTEkNQpX3wORkS3oQg6aBY7Xe6+rUiELGucw=;
        b=KmtiF3LHbCfDirlr0rCLOi2QJCX9QWX11o85FcVml2XADcuJUPrWErtYWL6vC0vqU7
         LiZKHB9Hv8KrmJTCNi09x/hWoF6HC/uEluvzE3rSBGWEjhYb15zPZk8C8HWklpU/Rr9N
         H48Cpuo/6DOSwi33x6HIhSavit1HkPf20ezobE1oS/RqM5FpeBApdmSTBVRgp/HAbpOg
         G9ecqMdu8zSsER/6f1kQgJpSfmO4RXr1Df6qtIx1vASsOzVMCJYCGmIQsD+oMOVq6PrJ
         JQpeJZgxj6x/gt+RZx1XsQLvI6zIRKwl566hUfuccyXen7Pa5TXbXcJnGiEwSQxTubhX
         iA5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vQtW6xluTEkNQpX3wORkS3oQg6aBY7Xe6+rUiELGucw=;
        b=c2E3pGFLuZjg/C1lyoACNNRmXhODG3PTx+QGlX7c5bNlf7ZQhzco9TacFro1gXPrBw
         TOaqv8p+RzuDAZttrSdy339/CjteUVklT0Mu5+bPBx9GoLtXMMUp8rwmWpGbz+eIWg9l
         M8Na3LzPyE2OUx6In7X1x/bqV30uIx12jZqpSFSSiS9HN4qrm0md5VZDHjG34IUbA9RP
         I0fN1JmW/RgO7hhvY5mcIZxlGzSaYzIDDDAsIu/AV/SVlM1eM7pm1wHqtWVhthXwg1Xi
         HpRaLjWAw9LX/OjSEgl5w+pAb7sxCobPCV5VJyqS5YkficXAklx9jiKI3c6AMflr1Wd4
         xadA==
X-Gm-Message-State: APjAAAVdYndSNcf4Lj1FseZOWbWpKjPFFIR7fwlnPOjrM+ZMo8/43WWw
        hsKhwMKjQbEJB9ILDs8QXLVk30rNcRJEeUiq/wJv6A==
X-Google-Smtp-Source: APXvYqyIJFjkYw3rf1nTGqbNqs/jTsIm/SCrBSa8M+/+PAmGh828bCZboOPzCwZzrNG3JZcr7XVSLasZbqdelBzSf+Q=
X-Received: by 2002:a5d:80cb:: with SMTP id h11mr12643137ior.72.1572285657524;
 Mon, 28 Oct 2019 11:00:57 -0700 (PDT)
MIME-Version: 1.0
References: <20191026214732.17725-1-linus.walleij@linaro.org> <20191028155457.5uae2crf3ygvn3qn@localhost>
In-Reply-To: <20191028155457.5uae2crf3ygvn3qn@localhost>
From:   Olof Johansson <olof@lixom.net>
Date:   Mon, 28 Oct 2019 11:00:45 -0700
Message-ID: <CAOesGMhR=CXEeGdULrfAM9FUG7nhPWwUi=Epom_hQdML8On6uw@mail.gmail.com>
Subject: Re: [PATCH v3] mfd: db8500-prcmu: Support U8420-sysclk firmware
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        ARM-SoC Maintainers <arm@kernel.org>,
        Stephan Gerhold <stephan@gerhold.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2019 at 9:00 AM Olof Johansson <olof@lixom.net> wrote:
>
> On Sat, Oct 26, 2019 at 11:47:32PM +0200, Linus Walleij wrote:
> > There is a distinct version of the Ux500 U8420 variant
> > with "sysclk", as can be seen from the vendor code that
> > didn't make it upstream, this firmware lacks the
> > ULPPLL (ultra-low power phase locked loop) which in
> > effect means that the timer clock is instead wired to
> > the 32768 Hz always-on clock.
> >
> > This has some repercussions when enabling the timer
> > clock as the code as it stands will disable the timer
> > clock on these platforms (lacking the so-called
> > "doze mode") and obtaining the wrong rate of the timer
> > clock.
> >
> > The timer frequency is of course needed very early in
> > the boot, and as a consequence, we need to shuffle
> > around the early PRCMU init code: whereas in the past
> > we did not need to look up the PRCMU firmware version
> > in the early init, but now we need to know the version
> > before the core system timers are registered so we
> > restructure the platform callbacks to the PRCMU so as
> > not to take any arguments and instead look up the
> > resources it needs directly from the device tree
> > when initializing.
> >
> > As we do not yet support any platforms using this
> > firmware it is not a regression, but as PostmarketOS
> > is starting to support products with this firmware we
> > need to fix this up.
> >
> > The low rate of 32kHz also makes the MTU timer unsuitable
> > as delay timer but this needs to be fixed in a separate
> > patch.
> >
> > Cc: arm@kernel.org
> > Cc: Lee Jones <lee.jones@linaro.org>
> > Cc: Stephan Gerhold <stephan@gerhold.net>
> > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>
>
> Fine with me to go through MTD, so:

s/MTD/MFD/g

>
> Acked-by: Olof Johansson <olof@lixom.net>
>
>
> -Olof
