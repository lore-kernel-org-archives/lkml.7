Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DAD8C7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 13:40:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CB7B218D4
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 13:40:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xSEXxIxO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390339AbfGWNk1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 09:40:27 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40467 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390327AbfGWNk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 09:40:26 -0400
Received: by mail-wr1-f66.google.com with SMTP id r1so43223975wrl.7
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2019 06:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Q1RW+7WTKu2ChwwqlFBnnA2Rj8nJVJpbRqrmrkf5EEQ=;
        b=xSEXxIxOiTmnZaxDi2fXZ05ccWC0CcWv2io5iEuiF/kxgFafmrBskcJ0h5jC8TuAVF
         pODCm3Ynf3hm8QkPNsqA8fwzxfZMcVTUwD8RoGVe0v5DaZtH7eJkjddS0AKJqjFk+Zj1
         AkxlNEOLi/k9ofvfjsK+9fj9xHvr7n4zkrgRgv64P1yGjW95DtNGDjDiNd2JzM0XQTl9
         h7B9hueKxSZboqqPCJ4Ob7/7JYEzCwKeLC7sGB2BM5xX4rq6LEGkbihHBsdPZnzhD/8W
         LqMWpc8mjNbbY4R4SGpVezj56ly0mfqoMWD4zJc+XIfvsmzGqN3sB7vw/PDoUFnYg6rI
         x++g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Q1RW+7WTKu2ChwwqlFBnnA2Rj8nJVJpbRqrmrkf5EEQ=;
        b=K6RpCm5koNlsUIz+h6xEAraujrSytGpiYoO+BYcSnrNAiDBgZgxVmL9L/uBghEDGdo
         cxIxRR3qx3S/uvEOSEioaR3jeVtmGSWR4appv9mQCo1jUkeXVtVQVsc3vpW4eK3hDTjD
         NJYEszkc1LMM4zc84/FejToDXi3YMS+zBOw5XQKSJfMtQG7AQfEtiYk2Q4x+Tgfs2pws
         Wru1MB/a+TXx24VVL/L9ty8MRyf6U3AIk4EOeBnwSkT4CTYGGIZR55O10Ju/fZy2lFti
         7xwOBDz+9N6uDH+914TTbI8/REhgNjCkUdAp4Cu+mXhjrQCQsovKrnOxa9EN/5haU7Xf
         SNyw==
X-Gm-Message-State: APjAAAVM8vpq9vmeWxc6WwxANvUdZKJ4U0xN7KUfM7oRbYxoe/Ylpu7D
        hIix3jO4s469EWN7pjgEb2/LTw==
X-Google-Smtp-Source: APXvYqzi2Mng9I27Xyg/Tj0RYk6yHHDedUhypLElGvurkGTGsxWuk3EVwBMNfBWenznT4gFozxyUJw==
X-Received: by 2002:adf:ed04:: with SMTP id a4mr75709129wro.86.1563889224613;
        Tue, 23 Jul 2019 06:40:24 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id q10sm43171756wrf.32.2019.07.23.06.40.23
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 23 Jul 2019 06:40:24 -0700 (PDT)
Date:   Tue, 23 Jul 2019 14:40:22 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Lee Jones <lee.jones@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-sh@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v2 7/7] backlight: gpio: use a helper variable for
 &pdev->dev
Message-ID: <20190723134022.s74giqi3aq7v3djz@holly.lan>
References: <20190722150302.29526-1-brgl@bgdev.pl>
 <20190722150302.29526-8-brgl@bgdev.pl>
 <20190722160908.GZ9224@smile.fi.intel.com>
 <CAMRc=McGTk+i0SzWN7AvGu3deYbXX_rJX=7+dKRpKFPKM_qxDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=McGTk+i0SzWN7AvGu3deYbXX_rJX=7+dKRpKFPKM_qxDA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 23, 2019 at 08:29:52AM +0200, Bartosz Golaszewski wrote:
> pon., 22 lip 2019 o 18:09 Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> napisał(a):
> >
> > On Mon, Jul 22, 2019 at 05:03:02PM +0200, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > >
> > > Instead of dereferencing pdev each time, use a helper variable for
> > > the associated device pointer.
> >
> > >  static int gpio_backlight_probe(struct platform_device *pdev)
> > >  {
> > > -     struct gpio_backlight_platform_data *pdata =
> > > -             dev_get_platdata(&pdev->dev);
> > > +     struct gpio_backlight_platform_data *pdata;
> > >       struct backlight_properties props;
> > >       struct backlight_device *bl;
> > >       struct gpio_backlight *gbl;
> > >       enum gpiod_flags flags;
> > > +     struct device *dev;
> >
> > Can't we do
> >
> >         struct device dev = &pdev->dev;
> >         struct gpio_backlight_platform_data *pdata = dev_get_platdata(dev);
> >
> > ? It fits 80 nicely.
> >
> 
> IMO it's more readable like that with the reverse christmas tree layout.

There is no requirement for reverse christmas tree layout for this area
of the kernel (and especially not where RCTL is used as a justification
to avoid initializers).

I have a weak personal preference for initializers although it is
sufficiently weak I was happy to put a reviewed by on the original
patch without comment.


Daniel.
