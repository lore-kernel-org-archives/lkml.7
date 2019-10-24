Return-Path: <SRS0=Yun1=YR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00DE1CA9EAF
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 12:10:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA5E221925
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Oct 2019 12:10:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DPS127uU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439614AbfJXMKx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Oct 2019 08:10:53 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34455 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439598AbfJXMKx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Oct 2019 08:10:53 -0400
Received: by mail-wm1-f67.google.com with SMTP id v3so1859980wmh.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2019 05:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=qm6MaFFOd7IZ24s/NUot8Yx+kOI9nuPZ71b2RZgYWvE=;
        b=DPS127uU+ChceB17ZJLKDaQE07GYeDdDlytghRl6kNeHX32NLBx3xYIg9wQLCbzuNC
         Mi/+REdC49GFr4gcHVCDBKKU80/ZswNznpFOwZbAmTjcGo2gBbXY4beaepmwpNvY9ZXb
         /w4+/6+sumngs4e+C9YnRYkXs8lxEhqkPkgn35bX43WzmxTbvAtsh/XU0jbciulqHf6X
         gB6oeEC4HGaRLc6h5pmoVQWjvXqyzq2rPaRx9Ksl0WslbkiGzHBZ9XCuK6me0zAreoeB
         Pubu5eH//tvBTIc6z8zQ7qL5oUAlAfF06KxgMetKE8cDfZe5eMG9X7zruZZrKY56baqs
         Vw6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=qm6MaFFOd7IZ24s/NUot8Yx+kOI9nuPZ71b2RZgYWvE=;
        b=KsDJ3hpUGkZf4mGBUvXlM6TT8OrTltE1vt7umqu6/4ixYO1jI2bQDKDYvEyeo9wz1j
         zAu90z8zNKb1rPDHnx8phBVIfyqzDZX9av247iW8Rxkw/Gg81IaBV5kqB3sF/uv9gN+v
         Fw5+kr8NlcpCcHV7bwGnVd+rB5OYgatOaVMTqgMrDZ5GFeo+APDwXh6LfUJcgdhanQNt
         pAS1DqbxTJpsxOMRrrDDIdE5vhVGs8RcSd4iRjbRibu2YghmkBKR2hYE6OqPuttK+pb+
         7WpngYid+zqqjBiNDckfntm1CUI/UX0fTcoB0fXP2Pt9RuVUEEjCOCYEzFyCBca53mdG
         xh4A==
X-Gm-Message-State: APjAAAVy4B3KnrI3WzuvDNeA2Kes5SV+P3YOvtLrkFxwT5L7/j9mWOuX
        GkbIWA8t2VMnys+RRcs4pyQh4w==
X-Google-Smtp-Source: APXvYqx2HhqaEtBXDkosGKPp83lO/Dzy4wDFshtgtjUqtmLu8R8iP5OaqPpWe4HU8GQp+iPG7ZFDtQ==
X-Received: by 2002:a1c:ed04:: with SMTP id l4mr4878676wmh.116.1571919050910;
        Thu, 24 Oct 2019 05:10:50 -0700 (PDT)
Received: from dell ([95.149.164.99])
        by smtp.gmail.com with ESMTPSA id l6sm2395212wmg.2.2019.10.24.05.10.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Oct 2019 05:10:49 -0700 (PDT)
Date:   Thu, 24 Oct 2019 13:10:47 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Jacopo Mondi <jacopo@jmondi.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:DRM PANEL DRIVERS" <dri-devel@lists.freedesktop.org>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Subject: Re: [PATCH v7 0/9] backlight: gpio: simplify the driver
Message-ID: <20191024121047.GM15843@dell>
References: <20191022083630.28175-1-brgl@bgdev.pl>
 <CAMRc=MeyrDZgmHJ+2SMipP7y9NggxiVfkAh4kCLePFWvUku9aQ@mail.gmail.com>
 <20191023155941.q563d3cfizre4zvt@holly.lan>
 <20191024064726.GB15843@dell>
 <20191024071703.6keoebzlfnn2qmyd@uno.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191024071703.6keoebzlfnn2qmyd@uno.localdomain>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Oct 2019, Jacopo Mondi wrote:
> On Thu, Oct 24, 2019 at 07:47:26AM +0100, Lee Jones wrote:
> > On Wed, 23 Oct 2019, Daniel Thompson wrote:

[...]

> > > > Jacopo is travelling until November 1st and won't be able to test this
> > > > again before this date. Do you think you can pick it up and in case
> > > > anything's broken on SH, we can fix it after v5.5-rc1, so that it
> > > > doesn't miss another merge window?
> >
> > November 1st (-rc6) will be fine.
> >
> > I'd rather apply it late-tested than early-non-tested.
> >
> > Hopefully Jacopo can prioritise testing this on Thursday or Friday,
> > since Monday will be -rc7 which is really cutting it fine.
> 
> I'll do my best, I'll get home Friday late afternoon :)

Thanks. We'd all really appreciate it.

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
