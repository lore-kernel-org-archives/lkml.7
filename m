Return-Path: <SRS0=nnGO=2J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C85C43603
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 16:22:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAF7924650
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Dec 2019 16:22:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="c1P8t0wK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfLSQWW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Dec 2019 11:22:22 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:32931 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726818AbfLSQWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Dec 2019 11:22:22 -0500
Received: by mail-io1-f65.google.com with SMTP id z8so6368800ioh.0
        for <linux-kernel@vger.kernel.org>; Thu, 19 Dec 2019 08:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=n81r7QrGuep9hV+3PKVLL2hvZEUY0LLXJO5ENAZWN5M=;
        b=c1P8t0wKClU8n5NQN4ppo/B0Q6B38XEbPLd+ORo1cUS0Ixx/Pd/iga9Cc18cdU7CeE
         UXl8s+dSoQAfchCg17VhEJDCRX2lQLhLjstfXDaficT9/33zFS+0APdxVTnZxmMDnH1Y
         iQjnZcbyuvHKCQP9Xp7FpcBXaPeNKDgR4EhMxDad4Vaw4sxX9dIQorIBVYFWLGzrFBkR
         Zrov6PpiYn4lKtvyYIN7CRc7I2DW1ghFz/WecChzSCTAd8Uh5bIfvo/5Llop5KNcJ7Qk
         /jHJ6tLN2hoy5f8sHmvIcONL98AvLePH3Dc+ERTxpTjcto1L2nYon0kM6i3TnOm4a8Nt
         A3KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=n81r7QrGuep9hV+3PKVLL2hvZEUY0LLXJO5ENAZWN5M=;
        b=EmiI6kp3UfH9gy8/ha22kSVj0snQTTQXQS9lPRRAJLUvt5RlfgHSQm9i7yK405GwwJ
         cvLb0Ab/Ky84rdEpAXTpnvEgLWfsuz8wt6+rf9rEjzE5USJI6AV0Y23tdP2nG9QnYQYc
         MXuUO58fp/W8dz0JuXyO1WW5sMGlhV011I5IHPArq5d98XOJLK+VdsX+FP7nTL82zhUM
         Xeg+Wb4VyZ3X0QW576iELwRPfpbZqfxTT0NIToH32bhwxaJgHMd75gB9daolk4F30mOK
         dz6ZFKgNEgGIeu7n/Co/eloXHL0oEBREZPD6VaLFwiaucj4uwK5ajTmpaNkLCxj9+4rL
         Um0A==
X-Gm-Message-State: APjAAAWZAqp/NEx9ZDZL7gwfk+22xywxuEeewx4unnVtSKI2rAGbEFw4
        krUR4u9xXaspWl4gVWPxHssk7Fvlj4VvqnntNqE/KQ==
X-Google-Smtp-Source: APXvYqyrT8wvS1ZFGoN+rfRmHHdo8+PM6oEXfu/rT2FKRX2JOC1Q5EaDaqpRdCWbu6cVS8DAwmn+7enb8iEi+Sa2Omg=
X-Received: by 2002:a02:3312:: with SMTP id c18mr7785705jae.24.1576772541788;
 Thu, 19 Dec 2019 08:22:21 -0800 (PST)
MIME-Version: 1.0
References: <20191204155912.17590-1-brgl@bgdev.pl> <20191204155912.17590-9-brgl@bgdev.pl>
 <CAHp75VfVHr2LGZYSVhQ+KmhvGrnH=1ZNAPzJOTdZDh7wsjFddw@mail.gmail.com>
In-Reply-To: <CAHp75VfVHr2LGZYSVhQ+KmhvGrnH=1ZNAPzJOTdZDh7wsjFddw@mail.gmail.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Thu, 19 Dec 2019 17:22:11 +0100
Message-ID: <CAMRc=Meb78=x2+0+aFoZkSgRP3b+f9FvUNs_AJJ4rahpM=PPbw@mail.gmail.com>
Subject: Re: [PATCH v2 08/11] gpiolib: emit a debug message when adding events
 to a full kfifo
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Kent Gibson <warthog618@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=C5=9Br., 4 gru 2019 o 23:28 Andy Shevchenko <andy.shevchenko@gmail.com> na=
pisa=C5=82(a):
>
> On Wed, Dec 4, 2019 at 6:04 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> >
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > Currently if the line-event kfifo is full, we just silently drop any ne=
w
> > events. Add a ratelimited debug message so that we at least have some
> > trace in the kernel log of event overflow.
> >
>
> Hmm... I don't like prints in IRQ context (even threaded).
> Can we rather switch to trace points at some point?
>

This is something that will be very rare and unlikely - I don't see
how trace points will help here with all the boiler-plate.

Bart
