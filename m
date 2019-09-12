Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3CB9C5ACAE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 09:36:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA59520856
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 09:36:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HC4txyRj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730632AbfILJgC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 05:36:02 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:42920 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730083AbfILJgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 05:36:02 -0400
Received: by mail-lf1-f68.google.com with SMTP id c195so3897933lfg.9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 02:36:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kH4sFfjOL7A7KkMOV7vO4UQpyFz9162V/0NGhP2LeSw=;
        b=HC4txyRjxxz5UdDmhEgx85TIHyKxoHw2xFB4boVIniAuaYNptRdirmEVyOSmpxTlK/
         l/CSZ+KB0+6Cx13rsE3aBhIo1L1jAy18I6BmPAE1dTZOiFapkH17OTjZY94KGQpT0l2E
         szQD3XSjOdIMpaeBS7iY/NEbdKAzIttZ6jytZNnmyPg4/7hsrAWqkWCnd0qKKbeVKOuZ
         CdgSX8i0IElZQwO5Si1vmsuLR7dM37KB6z5mQwmBus5iGvcWwoKd/oZWJi1X9qzl0cLC
         S4t9QBD+TrljIfpI/6ImwJmy0vevu/vCe2RKPG7THWx+8gxQsa/hYPUgVbxmn1ywXfzl
         t83Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kH4sFfjOL7A7KkMOV7vO4UQpyFz9162V/0NGhP2LeSw=;
        b=VvPkNJV5j9POtpvOXyGRYIok2v3/WJohv7wCi40cxe4ag5NjaTFB3d98uoRkTTD9YA
         f2gePbU6t1JnGG1vFqw0gmb9mr5315dzrccSS8e2KOjyMyLt6PRkvjMDTgXqbxhoCylQ
         dI2WMI9UjkY2QVKkCw6NIVzp5hZ6vUEW6cFKlReBkRPuDEkktnOiY7LufmdNlfsJoERX
         FUJkyg06YoJXDu1dE2yScxOd9ofdjO5C2y9UZ+TRuP+11jtzmQBW1zFkx4/5s3B4zzKp
         duIxawDgLgBbmodrIDx9yqQaUlvYvX6ELpqEzFvXx5G8GRoalP/zo8qCnBc5yVIscFnp
         D1oQ==
X-Gm-Message-State: APjAAAVC8dAPCgv5D5BcEpLl2mrmOXxHdPSmtsN70Yev42pSCXUGyzs8
        6ltWSu2gwExGpXbuR49Y+t/hVNr1STvIFD44At80yA==
X-Google-Smtp-Source: APXvYqyxNtgIo21vnlXm6rIfHw5trKnnP33CLddtU3yZiyvg20eJ+KsBoi44dzHBWHnwNIT4/vtfRWOEHEBXKqSKQto=
X-Received: by 2002:ac2:5c11:: with SMTP id r17mr27549722lfp.61.1568280960418;
 Thu, 12 Sep 2019 02:36:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190911075215.78047-1-dmitry.torokhov@gmail.com>
 <20190911075215.78047-3-dmitry.torokhov@gmail.com> <20190911170140.GS2680@smile.fi.intel.com>
In-Reply-To: <20190911170140.GS2680@smile.fi.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 12 Sep 2019 10:35:49 +0100
Message-ID: <CACRpkdZNy82SwDYThtD8Q3K_2MrFHXjWfv2k93sp=XnoWj71TA@mail.gmail.com>
Subject: Re: [PATCH 02/11] gpiolib: introduce devm_fwnode_gpiod_get_index()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 11, 2019 at 6:01 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Wed, Sep 11, 2019 at 12:52:06AM -0700, Dmitry Torokhov wrote:
> > devm_fwnode_get_index_gpiod_from_child() is too long, besides the fwnode
> > in question does not have to be a child of device node. Let's rename it
> > to devm_fwnode_gpiod_get_index() and keep the old name for compatibility
> > for now.
> >
> > Also let's add a devm_fwnode_gpiod_get() wrapper as majority of the
> > callers need a single GPIO.
>
> > +     return devm_fwnode_gpiod_get_index(dev, fwnode, con_id, 0,
> > +                                        flags, label);
>
> At least one parameter can fit previous line, but taking into consideration
> that moving second one makes it 81 character long, I would do it completely on
> one line. I don't remember Linus' preferences.

I don't really have one, I don't mind 80+ chars, I don't mind breaking lines
to avoid it.

Yours,
Linus Walleij
