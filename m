Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D6EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C13FB21873
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 20:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LV80vvS3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbfCTURm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 16:17:42 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41168 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbfCTURl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 16:17:41 -0400
Received: by mail-wr1-f67.google.com with SMTP id p1so4197603wrs.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2019 13:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MJy9/0iCZc807dZ7/36ktoXWqUaatOGia0S0xYu4+zM=;
        b=LV80vvS3NgovX7zXExR6Nt7qcHB4RbTXYOH0sz9xDBGq4qQp3NDLNeT+kT+jBLjKTC
         j1N0wDqb5TlXKL8mgBr27LbNspLA71ZSc15N4rsrtN/DIz+cP9ltq+/HyB92103Pva/E
         7Mr1oQTwIwL50/WeiEnATD/iFA66lYA4FIeJI30EbayZtBWPnNc4Vu/wofV1bUuDWVHz
         K7+SSVMMV6VcZWHlKZcoeIb/TLVO9gJxOn4MjMVthfds7sffDyOw9x9exs2LGmyp+Bz8
         OsKKsYsJ8dRIZe7Ua0TJkagXcvblUCeLFCaD0aTTqI7kE8NQtpgvChidFMA+9stqFmuu
         cNMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MJy9/0iCZc807dZ7/36ktoXWqUaatOGia0S0xYu4+zM=;
        b=sPzLvSkdKGuP8VcDLYpEEj6HEBMQIBHdd7uKn4aB0tLHwCNDOeQCr1n+dnw9cIeZz4
         dL6th2PqDP6uKqAbvIudL6XqTZ688ZKjzMlF0Nr9XZtk7XELhMsaVxVf8kRe5yY4MIbY
         GltsDIvhG+5watFLAIaNUrBaPdEbMOQfpwe+HS7T+IkqJRIPiZQW5cWqQ5DoA1TO1kZj
         HgpktLyUscrb1vuxuEhM3R58u9PPR3C9y0Vt/BYpfBkorexBjbGdVKgn2vezuFpra1fl
         el3DJ0wiV6ZEueJyTwkUcK9477c7KDql1FiXpclw+VGyJO+td60Cf0Yp63bCIYIdYLTj
         l2rQ==
X-Gm-Message-State: APjAAAWK9PZDBwpUk49AYuYBGNPS/GfgWDnWKrfa4gg+eZrGfg5FsK6j
        fDXY86TbuHKtPYLpymXCUqMkvbW29zvd93ohmQKhR1wL
X-Google-Smtp-Source: APXvYqwpUqAGk1Cmf2LYP+jnEeeYFw9HiS4t11zbE6zt2LV9MfdfxiBwb4msQiEpD2o/hm3PgjQRWTdQBnjiN4wGwS4=
X-Received: by 2002:a5d:6050:: with SMTP id j16mr40538wrt.253.1553113059341;
 Wed, 20 Mar 2019 13:17:39 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20190308205332epcas1p181370b12f611fd746d333a557a1ddb48@epcas1p1.samsung.com>
 <CALAqxLUZKinhCasO4rXBJuip3bOo+JCovWLrHYPBPTopf6d7Vw@mail.gmail.com>
 <fe3b207e-1200-4a76-8c10-28655029f16d@samsung.com> <CALAqxLV2tWWNuo5UWq8UqDsUDbT4CQX5GVXiBRkHRb+322ys_w@mail.gmail.com>
In-Reply-To: <CALAqxLV2tWWNuo5UWq8UqDsUDbT4CQX5GVXiBRkHRb+322ys_w@mail.gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Wed, 20 Mar 2019 13:17:27 -0700
Message-ID: <CALAqxLW_6rMG3Bh9tR8=_Zw2y4XkMAsBCnZ6WC89tc7-2kKgHw@mail.gmail.com>
Subject: Re: REGRESSION: dwc2: gadget: Add scatter-gather mode
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Felipe Balbi <felipe.balbi@linux.intel.com>,
        Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>,
        Artur Petrosyan <Arthur.Petrosyan@synopsys.com>,
        Linux USB List <linux-usb@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Tom Gall <tom.gall@linaro.org>,
        Andrzej Hajda <a.hajda@samsung.com>,
        Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 11, 2019 at 9:50 AM John Stultz <john.stultz@linaro.org> wrote:
> On Mon, Mar 11, 2019 at 3:15 AM Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
> > On 2019-03-08 21:53, John Stultz wrote:
> > > Hey Andrzej,
> > >   I just wanted to let you know, trying to boot linus/master on the
> > > hikey board today, I've been seeing lots of errors on boot (which
> > > sometimes crash the board, and sometimes doesn't). See the example
> > > below.
> > >
> > > I've bisected the issue down to 10209abe87f5 ("usb: dwc2: gadget: Add
> > > scatter-gather mode"), and if I revert that change the issue goes
> > > away.
> > >
> > > Looking at the patch, I can't see anything obviously sticking out, but
> > > let me know if you have anything suggestions you'd like me to test.
> >
> > I've CCed new Andrzej's email.
> >
> > Could you tell a bit more how to reproduce this issue? Which USB
> > function are you running on the target system? I've noticed that you are
> > using functionfs. Is is possible to get access to the usb function
> > daemon to reproduce the problem here? Which version of HiKey board are
> > you using?
>
> So this is on a LeMaker HiKey (2gb ram 8gb storage), running AOSP (so
> its adbd that is the ffs daemon)
>
> I have a mainline tracking tree which follows mainline here to provide
> MALI gpu and other android requirements:
>   https://git.linaro.org/people/john.stultz/android-dev.git/log/?h=dev/hikey-mainline-WIP
>
> I'm traveling this week, but if you really want to reproduce this
> yourself you can grab the system/vendor/boot images here:
> https://snapshots.linaro.org/96boards/hikey/linaro/aosp-master/latest/
>
> Then build the kernel w/ the hikey_defconfig and replace the kernel
> image in boot.img w/ the abootimg tool.
>
> Let me know if you have any trouble and I can try to help walk you through it.

Just wanted to follow up to see if there was anything further you
needed from me to help debug this?

thanks
-john
