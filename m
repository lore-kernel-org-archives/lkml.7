Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD29C10F03
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 12:36:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F31EF2070B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 12:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=essensium-com.20150623.gappssmtp.com header.i=@essensium-com.20150623.gappssmtp.com header.b="smRGyYhe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbfCDMgs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 07:36:48 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:34615 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726095AbfCDMgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 07:36:47 -0500
Received: by mail-yw1-f65.google.com with SMTP id u205so3940187ywe.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 04:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=essensium-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ob8hWZ0HmNwlTXJo/mYlu29SYMoP0D3tHnTBPnurEpc=;
        b=smRGyYheoWgrKBxK4FySqe7WvjpakYuVvISB7ltoRJLyCeitME4JA6Qumxa88B+pn3
         3nMM8Q3/KPrMQYpvcRbdPs2YqnadxOaHZYg2T/22WWiYGqVVsTN3pU76f0jDMIryPuHB
         I0gK0YdNvRO5lIhsF/5go4P5ER6AYkEFyz4b4ULzr8JnJ9TAkmjy/J8lzVBsWlvvXjKh
         HKGUt8hpBqB6Rldtz37WT9w2332qf7UlJjhqOQECmuRdq3b/F9cJ9nJ53MpMtnABxLTq
         INCm+C+cD6ogS8xeEsPy11CGnWCU0qXNSzCuMQTsGu2SFwRPlmKOu/KKzgnjt0id3KNF
         i/2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ob8hWZ0HmNwlTXJo/mYlu29SYMoP0D3tHnTBPnurEpc=;
        b=JeNrzZ04/oSWgWpLJAxFR7ygCnoa2/ekkqCvbDC+Im7yq+20j15ZEVXIlxkuuYCIwt
         lbywL4jkYmlua5HR2XWgrcWsXW2DzYGAXR0gAj9idZM/eJDZ/Fv2q1bXyoR1/DtTgVPG
         iYxLt0Ika/MunR1urMNGD3PI5Zdxlqxr+HkC1strDg5bBsNgSDxM2pJomVYZpFhW3y5Z
         RQT5cjuG5DhQzyH16VxoMmDXWii04i2PykzBWhwE8/ketK9nmNDaqrYkuT7M2Y0L7jgl
         Z9k+KQeC6GcHXmFmQhyBZOfkmsa54tTVM1s8Q8ku5enoNZ6wRTxI5Dy1yxtG3OArjY7G
         gcJw==
X-Gm-Message-State: APjAAAV6DUJAl0Yx7NRVc/lK9WraqxC4/DkQ8MnVmCxaBgfrINR5E2vB
        ozMcwYPjZfQBuct+wElJ8r9jP4Hh49IpZeKnMmYsKg==
X-Google-Smtp-Source: APXvYqxVfOPCjAyP0ik8yPHGWa5ghB1GFgpMDODBfMk1sD3Il17SauW+sZt6b1W6aoYo9GOT9T45U+89TthTCstmbq8=
X-Received: by 2002:a5b:b4d:: with SMTP id b13mr15071149ybr.318.1551703006622;
 Mon, 04 Mar 2019 04:36:46 -0800 (PST)
MIME-Version: 1.0
References: <20190218140321.19166-1-patrick.havelange@essensium.com>
 <20190218140321.19166-5-patrick.havelange@essensium.com> <20190220164154.00547a77@archlinux>
In-Reply-To: <20190220164154.00547a77@archlinux>
From:   Patrick Havelange <patrick.havelange@essensium.com>
Date:   Mon, 4 Mar 2019 13:36:34 +0100
Message-ID: <CAKKE0ZFs_N+StJ4MQ0peaTy=ADufSVW_tp5zSHsyua2myvMiHQ@mail.gmail.com>
Subject: Re: [PATCH 5/8] iio/counter: add FlexTimer Module Quadrature decoder
 counter driver
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        Esben Haabendal <esben@haabendal.dk>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 5:42 PM Jonathan Cameron <jic23@kernel.org> wrote:
[skipped]
> > +
> > +struct ftm_quaddec {
> > +     struct platform_device *pdev;
> > +     void __iomem *ftm_base;
> > +     bool big_endian;
>
> I'm curious. What is the benefit of running in big endian mode?

It is based on the same behaviour as in drivers/clocksource/timer-fsl-ftm.c
The FlexTimer itself on the board I'm testing it with is working in
big endian mode, so this mode is required.

> > +static ssize_t ftm_write_reset(struct iio_dev *indio_dev,
> > +                             uintptr_t private,
> > +                             struct iio_chan_spec const *chan,
> > +                             const char *buf, size_t len)
> > +{
> > +     struct ftm_quaddec *ftm = iio_priv(indio_dev);
> > +
> > +     /* Only "counter reset" is supported for now */
> > +     if (!sysfs_streq(buf, "0")) {
> > +             dev_warn(&ftm->pdev->dev, "Reset only accepts '0'\n");
> > +             return -EINVAL;
>
> Why not just make the channel attribute itself writeable given we are
> setting it to 0?

Good idea, I'll see if this can be applied in the new subsystem.

[skipped]

All other comments are Acked.
