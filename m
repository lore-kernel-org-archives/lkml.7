Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D192C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 16:13:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 99173206DD
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 16:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OTRZOngC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728939AbfDDQNl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 12:13:41 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45369 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728803AbfDDQNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 12:13:41 -0400
Received: by mail-lf1-f66.google.com with SMTP id 5so2189095lft.12
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 09:13:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w7cqMoh/o/5tquQe82yVz0UF1UW9cmylA3d/Z3b+co8=;
        b=OTRZOngCg0aOonpHNoOqaoSbmnkYrjCvrhoB+grs4kKkC83w0G+OGlXSaMZf3VJi0f
         fTBZmLlNrRkAX0XtFEFsx+CNQrUL7LXop2xTbAvI3K0Po+ukkfqCbxqNF/l3BuKbVPCZ
         PGoAX/KHxSJEiIoX7UpD3HA1Nm1WGoik0EBEY6dYlahio0Vqnk0XVJhwXOX677pWOE2G
         pen+lZ7WY/qPyMao/o/BKa5zXn7CO01Xp7gOXNj3UEEiMfqQ7onhFK8xJjG7sEzxBpD1
         /ESQ36hS/Lh+9iACGiDJww9SnmAyQGVSlwUT/on6bgdUXOj9X7IM5A0ZEZdVXHzrV/M3
         Pw0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w7cqMoh/o/5tquQe82yVz0UF1UW9cmylA3d/Z3b+co8=;
        b=ucYcMsMBSpaAURHi0DEZlX0VFUuLMs2T2huqPN9joP/hvReaJDV8eMQg+Hg3cEF1rz
         P3baIw6RCizmwzJmrWHcC8j+jnwx609Wfn3DOyHcnJfE4Ovhyu9yO3/PJc1hkTn4ZUMN
         vLoeVd6bA01YzuWIPRa3BBra5kTh8e6vlY3B9S5TsiWZ3UYVv4ZQCrw6zjJJgUwoCEa8
         brZIvG/0y8Hlh2In9WLYqOJ8T39kRaC0V+QdAw/9czJ9uW0p0RSFjRgEeWpGQk9cj5+L
         11Lxh/yJ7Acff+yEO9hQX+Q6BaPGexpM9VUYA2N8M0/9DaWCkYxHsK/Mlqf2CqnRumyD
         nW6A==
X-Gm-Message-State: APjAAAViHn7BxEtAFjq+0R36H8j2KAB7GZA9j4xGEW5pezNQqzhnTxnv
        1YYDjPHfLgKIpoRhAEC7zjbFPbmbVCQgKncLtMDAYQ==
X-Google-Smtp-Source: APXvYqzNx1n/oaadf0cP1rmbjjaMBtlRxxJa7fuaXngE8m5VuYNunaWVG5GB6pP8glSR7qJXBkyPKl9c1pRJ02axOKw=
X-Received: by 2002:a19:ae0a:: with SMTP id f10mr3488781lfc.118.1554394418516;
 Thu, 04 Apr 2019 09:13:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190308203801.57920-1-ncrews@chromium.org> <20190308210843.GA16125@amd>
 <CAHX4x85=_76=Kyepf3Nw++4yVKOZujhLsonzaicZOnY5fi-Pfw@mail.gmail.com> <20190404112415.GB18653@amd>
In-Reply-To: <20190404112415.GB18653@amd>
From:   Dmitry Torokhov <dtor@google.com>
Date:   Thu, 4 Apr 2019 09:13:27 -0700
Message-ID: <CAE_wzQ96MkKb7uSoVBNkOZexevUKPf4jHyQZneg7YNCEs7SHfQ@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: Add Wilco EC keyboard backlight LEDs support
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Nick Crews <ncrews@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>, linux-leds@vger.kernel.org,
        jacek.anaszewski@gmail.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Daniel Erat <derat@google.com>,
        Guenter Roeck <groeck@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 4, 2019 at 4:24 AM Pavel Machek <pavel@ucw.cz> wrote:
>
> On Mon 2019-03-11 09:29:06, Nick Crews wrote:
> > Thanks for looking this over. I will fix most of your concerns, but
> > have one question.
> >
> > On Fri, Mar 8, 2019 at 2:08 PM Pavel Machek <pavel@ucw.cz> wrote:
> > >
> > > On Fri 2019-03-08 13:38:02, Nick Crews wrote:
> > > > This patch is meant to be applied on top of the for-next
> > > > branch of the platform/chrome repository, as it uses some of
> > > > the code staged there.
> > > >
> > > > The EC is in charge of controlling the keyboard backlight on
> > > > the Wilco platform. We expose a standard LED class device at
> > > > /sys/class/leds/wilco::kbd_backlight. This driver is modeled
> > > > after the standard Chrome OS keyboard backlight driver at
> > > > drivers/platform/chrome/cros_kbd_led_backlight.c
> > >
> > > Can you make it "platform::kbd_backlight"? We want some consistency
> > > there.
> >
> > The analogous name in the standard driver
> > drivers/platform/chrome/cros_kbd_led_backlight.c is
> > "chromeos::kbd_backlight", and I thought "wilco" was a better
> > substitute for "chromeos" than "platform" would be. What other thing
> > are you saying "platform" would be consistent with?
>
> Yeah, well, we not let the cros_kbd_led_backlight.c use chromeos:: in
> the first place. But it happened. We want all backlights for the
> system keyboard to use common name, and "chromeos" is not really
> suitable for that. "platform" is.

Pavel, who exactly wants this and why? Looking at today's -next I see:

dtor@dtor-ws:~/kernel/linux-next ((next-20190404))$ git grep
"::kbd_backlight" | wc -l
18
dtor@dtor-ws:~/kernel/linux-next ((next-20190404))$ git grep
"platform::kbd_backlight" | wc -l
0

so there isn't a single instance of "platform::kbd_backlight" and we
definitely not changing existing names.

Thanks.

-- 
Dmitry
