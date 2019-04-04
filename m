Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E779C10F0E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 22:42:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6A079217D4
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 22:42:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XHbNTv+W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730437AbfDDWm3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 18:42:29 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:40094 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730291AbfDDWm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 18:42:28 -0400
Received: by mail-yw1-f67.google.com with SMTP id p64so1617160ywg.7
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 15:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=61QcS1XaF8rISpIrfzv8F98PUZe7iaNJHTu+xZl/mz8=;
        b=XHbNTv+WHgdO6QncIaQtXkLWCN/ThEmFWDRuL+cPsIxaAh38/zokY9qbE636Twt083
         BqiilbDUVskuuOmVhhcVr0NnPH5uUZWypYPAQHhqa1FTR8HVq0hDbt44jNQeGtLq1rn3
         EMH/MaBTX+KDpC3EVSZV6q0LTgZGhZbQuO5ktd7+MFtydWW1uM1VR4JWUKuTRpNxRYnf
         ftuZM4wc3lC2P0TRoGDcMslwmo+k3GyTAAr2NcXzTUFxCC964s6OkPgIYZpWn2LNkfN3
         zT80khl98ZCRWrRC8A9II7ouUuSdVoq+3szA+l79oWEZlNclk+9PnYIWlOdl3K+YIXde
         eYLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=61QcS1XaF8rISpIrfzv8F98PUZe7iaNJHTu+xZl/mz8=;
        b=JSpyg3qygO5K8GhGqKFlG/L1vKni1syyQUdJ7tqhdaA6rXsKxJ4JZOyEcZzIFkb0NJ
         7Gbl65Ps2Y1BmeMNSheYLAM/V9fquJNl1ss9K2HM4MMzXaGtJaKCebBIEjzLi5ASFDSs
         3fSOHi4j48MJPzWg9GafhQ4vcR6zlxvOGdwX/deS5FM28rKJPnJD4RhWvhiCmi8ouqLD
         +ZjlEMNBj3A55uq+4NoVZURhH2aXd5jLWtPp5MNnEI0KQ8aXZsjd8G7jlDbHltnLlq/l
         jspGXXvHqOP969uduuwDPpIpycfyn/lAlIvCeOjyuWn4uLBEhycwDo8md9fGVqjbRd7i
         X89A==
X-Gm-Message-State: APjAAAV9ZZSZ9+LScu+iz0HkvPAlLcRLzu9n3LDnEB/gg/z7ktw3GUuq
        WSQATBkIMYlaKApi1Ct5nBTI4ZyJbjMmiabFSQ7vdw==
X-Google-Smtp-Source: APXvYqyPwee/SWTgDW8QirABp7eIipjaRV83Hudbgo/Ih9kf25YRqGxgVnL6O0cPimcuqQCE35RRPLifdQ6YAdsmC5A=
X-Received: by 2002:a81:3c14:: with SMTP id j20mr7228426ywa.367.1554417747586;
 Thu, 04 Apr 2019 15:42:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190404185919.GB27340@amd> <CAE_wzQ-XuK7WOyPm6yXsmjp7z0=T92mMrfn1TVaavaLejcYVGA@mail.gmail.com>
 <20190404191931.GA29984@amd> <CAE_wzQ8y8i7C+_tv0CdnbUw0r21g1ggv2YUuzCog1xABivEvWA@mail.gmail.com>
 <20190404200658.GD29984@amd> <CAE_wzQ8WcMCzYqvxA_JBZKNza7ca3QE-VShmMxv5++_4F8RR=g@mail.gmail.com>
 <20190404202042.GF29984@amd> <CAE_wzQ-8XwzptH7EqNrELxjBzY2+0oHJGB3Va=vZwwK3csu_aA@mail.gmail.com>
 <20190404204207.GH29984@amd> <CAE_wzQ8xe=x0uYcZkDRVKpUAQ_1vVdEPHU3XnEV1=_WN1-AMfw@mail.gmail.com>
 <20190404220509.GA14690@amd>
In-Reply-To: <20190404220509.GA14690@amd>
From:   Guenter Roeck <groeck@google.com>
Date:   Thu, 4 Apr 2019 15:42:15 -0700
Message-ID: <CABXOdTeQgjd2-T+eZCMdTDWBGLHEk6kvnYR0DjJYR7zuvVTMsQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] platform/chrome: Standardize Chrome OS keyboard
 backlight name
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Dmitry Torokhov <dtor@google.com>,
        Nick Crews <ncrews@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>, linux-leds@vger.kernel.org,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rtc@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Simon Glass <sjg@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 4, 2019 at 3:05 PM Pavel Machek <pavel@ucw.cz> wrote:
>
> On Thu 2019-04-04 14:48:35, Dmitry Torokhov wrote:
> > On Thu, Apr 4, 2019 at 1:42 PM Pavel Machek <pavel@ucw.cz> wrote:
> > >
> > > Hi!
> > >
> > > > > > And what to do if internal keyboard is not platform but USB? Like
> > > > > > Google "Whiskers"? (I am not sure why you decided to drop my mention
> > > > > > of internal USB keyboards completely off your reply).
> > > > >
> > > > > I don't have answers for everything. Even if you have USB keyboard, you'll
> > > > > likely still have backlight connected to embedded controller. If not,
> > > > > then maybe you have exception userland needs to know about.
> > > > >
> > > > > Still better than making everything an exception.
> > > >
> > > > You do not need to make everything exception. You just need to look
> > > > beyond the name, and see how the device is connected. And then apply
> > > > your exceptions for "weird" devices.
> > >
> > > "Where it is connected" is not interesting to the userland. "Is it
> > > backlight for internal keyboard" is the right question. It may be
> > > connected to embedded controller or some kind of controller over
> > > i2c... my shell scripts should not need to know about architecture of
> > > every notebook out there.
> >
> > Then your scripts will be failing for some setups.
>
> Well, yes. Do you want to guess what "lp5523:kb3" is?
>

Oh, please. The discussion is about the driver name part, which you
want to overload with some string to mean "internal", which in turn
is, if anything, part of the functionality.

With "platform", you'll at some point have two
"platform::kbd_backlight" entries. Remind me to send you a "told you
so" when that happens.

Guenter

> > > But I don't see why I should do additional work when its trivial for
> > > kernel to just name the LED in an useful way.
> > >
> > > "platform::kbd_backlight" has no disadvantages compared to
> > > "wilco::kbd_backlight" ... so lets just use it.
> >
> > It has disadvantages because it promises more than it can deliver IMO.
> > If device name != "platform::kbd_backlight" it does not mean that it
> > is not internal keyboard.
>
> My promise is if "platform::kbd_backlight" exists, it is backlight for
> internal keyboard. (And second half is "if it is easy for kernel, we
> name backlight for internal keyboard platform::kbd_backlight").
>
> > And you still have not resolved how you will
> > handle cases when there is more than one deice that can be considered
> > internal and may have a backlight.
>
> Is that realistic? How would that device look like?
>
>                                                                         Pavel
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
