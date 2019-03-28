Return-Path: <SRS0=Qu8K=R7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D3AC43381
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 17:02:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 591B220823
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Mar 2019 17:02:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="vIektQj8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727327AbfC1RCH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Mar 2019 13:02:07 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:38726 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726210AbfC1RCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Mar 2019 13:02:07 -0400
Received: by mail-ot1-f68.google.com with SMTP id e80so19031983ote.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2019 10:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2/msr4RbWJfoZvhNBGATtM7u9No1FKJsLc/sMNbvprQ=;
        b=vIektQj8frXiik6na6SK08j7owEio3SuST/YX7MOnAf7Q+JInvwBu0QZCWTG81COgj
         hXRC410i9NjLIQwTyBCvqc6wIsIBqe52s76Eti2c6X19yQPEGsDcT64m38Wnj4yzVwjN
         KTN8x01qZVQntXEPppIvQDhVVcznTnBVBDt7MxD5kt3ut9yN2DT2WR8D4xBHc2YZw/By
         Hgl30Eg3n0KVWPd2pEkdYfC5cgvP2/1PQ6raPRLUtsCa6DAvzAUo9pneSk67O1vcy4l7
         JLbMY1kIXMcAdDpkkFirapxXFusbw1BoF5+QFEnZhRpJpc+9Z36+A90NgwtMyComtvFd
         mJFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2/msr4RbWJfoZvhNBGATtM7u9No1FKJsLc/sMNbvprQ=;
        b=ApcyHosHOTtXaBusIcawRleWku2S7QNFoESa6u4eoauOEk2s/wYkmTmp0UlvoVt/Ij
         0y6EJef45duGwShc9Q5VWa9AkI67jDi2sCHNGiz9Tv5C04oyUSTzpBAtdoK7DzZx/JEL
         FQPgo99EQSsIcB8WlbJfLuXcZ/6Y9L3iRYnyDJsE04svimi3GJ0F2eruKVqczo1h5vki
         HfpE86Hp/J6TNHHhR8kQ5PtqDdqJ4Kev0DxDPLePvRVxYylm8wqcUDSk9Uu8qceBVgml
         qQy7yp+UXfRlVbIVJeb5RqS1ZkoRUkieFbSacJvSdd7fB/Ljqf37I2tK8qC3Zco7ma8O
         0gMg==
X-Gm-Message-State: APjAAAXMJQrTEH7b5hGiIZEnAs4G2NDB1qcD6E4jnTaZrXYYEns8HyB0
        OPnYWjqK9L9YdOBfws/kNBrXKE50Z1KIckR3nzwxug==
X-Google-Smtp-Source: APXvYqxh6GZGtWWNF9OTb+WJfvYlAv9LQywEKneEBifr92SlkJirBmXkGGkTMHwcYEe8AbbvUZyjirW4tdPR66WGoaI=
X-Received: by 2002:a9d:6ad1:: with SMTP id m17mr30288212otq.108.1553792526036;
 Thu, 28 Mar 2019 10:02:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190322173052.23763-1-brgl@bgdev.pl> <CACRpkdbw7zvYx1s742HmYj8E=J0=SygEgBHVDyQ5c84N70V3fA@mail.gmail.com>
 <CAMRc=Mfd=cj7TcMOeaSJaAG_kfs8tg2UMGUR6iTwNhT3+q3n6A@mail.gmail.com> <CACRpkdZvc2iMZO+9ACFWiyy496huu5R0A=d6OOD8C71kAD1C5g@mail.gmail.com>
In-Reply-To: <CACRpkdZvc2iMZO+9ACFWiyy496huu5R0A=d6OOD8C71kAD1C5g@mail.gmail.com>
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Thu, 28 Mar 2019 18:01:55 +0100
Message-ID: <CAMpxmJUdW4bnc0YFVdSkyUpQ4c0XkAt8Ju7Qzt4sHYtiwc1R4Q@mail.gmail.com>
Subject: Re: [PATCH] gpio: mockup: fix debugfs read
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

czw., 28 mar 2019 o 17:56 Linus Walleij <linus.walleij@linaro.org> napisa=
=C5=82(a):
>
> On Thu, Mar 28, 2019 at 5:47 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote=
:
> > czw., 28 mar 2019 o 17:38 Linus Walleij <linus.walleij@linaro.org> napi=
sa=C5=82(a):
> > > On Fri, Mar 22, 2019 at 6:30 PM Bartosz Golaszewski <brgl@bgdev.pl> w=
rote:
> > >
> > > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > > >
> > > > The debugfs read callback must advance ppos or users using read() o=
n
> > > > the file descriptor will never get the EOL. This wasn't spotted bef=
ore
> > > > as I was using busybox cat for testing which uses sendfile() intern=
ally
> > > > and only noticed it now when switched to cat from coreutils.
> > > >
> > > > Fixes: 2a9e27408e12 ("gpio: mockup: rework debugfs interface")
> > > > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > >
> > > Patch applied for fixes.
> > > Sorry for slow application, I was in no-wifi-land for some days.
> > >
> > > Yours,
> > > Linus Walleij
> >
> > Ugh, I was thinking about sending you a pull-request with this and a
> > subsequent fix this evening. Plus other fixes I have in my tree.
>
> Oh if it is easier for you do that, and I will drop this patch and just
> merge your PR as it arrives.
>
> Yours,
> Linus Walleij

Yes, let's do it.

Bart
