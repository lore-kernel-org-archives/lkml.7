Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58EF1C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 19:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 29E852075E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 19:09:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Z6AUyGdv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730126AbfDDTJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 15:09:26 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:35483 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729848AbfDDTJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 15:09:26 -0400
Received: by mail-lf1-f66.google.com with SMTP id u21so2636223lfu.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 12:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OcQ6KsvNejmpUh/2q7SELuFlGd/570l7ZBSItTRB/3Y=;
        b=Z6AUyGdvfu7xNM7xzyFHJtaJ2pVTZybbrZLZywFlbYuKrnqTfWQ0TQeJQ2bpekCBsE
         GkF2RO+O2qwsUUIhToW7lNhi2bxjXjKyAmtBLQhi6bsZDhZ4C/ubq5XPp69mPalvK9Bi
         s+0TYyx/0WldH9UQVTWlRwjMel5AHF5SlvFOA8BqpHw8NhMrIB6Gjb2K9NyUcydb96xp
         tYVN1J9f/NgR9GhQRH+QfoE0SUdrbPgD4+yMNkANOG5OOIftS0vZVCQWH6QXbwBLKB1d
         qN+6uNNAHY+iKtJ2mrzqhhNNOC71TXA49UM916JGsco1TD4w7Vt2Ih9HcFov2cbpOy6t
         aFiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OcQ6KsvNejmpUh/2q7SELuFlGd/570l7ZBSItTRB/3Y=;
        b=Xz8vdt3yy8Af8+aQ5pfknKfol32pRFGJ5hjUEbKhbh0cuqs9i3J8Z8lZm1hm5Ak80r
         STmiF6EyBKUZJca8JEj2LSKDRwfSEsxXXa5k843f3+ZGSy5fQHnPVkSP7ZMzzwXqhL17
         cjbg3Xupcd22KlAaEWpd4YZWMqNTTDqyFQ2K/QS5TrzrNAbvgcH3wicQF338q403tmwO
         mFTCy/zUWUre5vyZc05CR1aKgPdxcXRc9UIoTsDJM831cLg62WxdKNz4osHtQp0rbu0f
         IKCAO4ns4S8G8JjW/Dv2GW9+aR5vExHL1zXwvQB+w5uEtrD6v6263+EjPHifU6gs4PXs
         IFXA==
X-Gm-Message-State: APjAAAVnnXJP5oCRpJig4MQCCM2OAAI+Aay1F0Rlb1C6GQq8am/OQzR2
        RoLh+Fz3gKe5hybV1IQyis6l5HpOuJLSfzTzKRJhCQ==
X-Google-Smtp-Source: APXvYqwnMfYIidHUiV+LBj009VRyderD2ldSsEqJdJ6s2BuKWwTAxMRQ2HqO2hBCgIcf2Yauw3FwyMDQPN8gZ+6e8DE=
X-Received: by 2002:ac2:5108:: with SMTP id q8mr3819296lfb.99.1554404963915;
 Thu, 04 Apr 2019 12:09:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190308203801.57920-1-ncrews@chromium.org> <20190308210843.GA16125@amd>
 <CAHX4x85=_76=Kyepf3Nw++4yVKOZujhLsonzaicZOnY5fi-Pfw@mail.gmail.com>
 <20190404112415.GB18653@amd> <CAE_wzQ96MkKb7uSoVBNkOZexevUKPf4jHyQZneg7YNCEs7SHfQ@mail.gmail.com>
 <20190404190326.GC27340@amd>
In-Reply-To: <20190404190326.GC27340@amd>
From:   Dmitry Torokhov <dtor@google.com>
Date:   Thu, 4 Apr 2019 12:09:12 -0700
Message-ID: <CAE_wzQ8mr1OMKB+ASfsCdGcs70YrzEMN4Htfg1+O51=ByhXchw@mail.gmail.com>
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

On Thu, Apr 4, 2019 at 12:03 PM Pavel Machek <pavel@ucw.cz> wrote:
>
> On Thu 2019-04-04 09:13:27, Dmitry Torokhov wrote:
> > On Thu, Apr 4, 2019 at 4:24 AM Pavel Machek <pavel@ucw.cz> wrote:
> > >
> > > On Mon 2019-03-11 09:29:06, Nick Crews wrote:
> > > > Thanks for looking this over. I will fix most of your concerns, but
> > > > have one question.
> > > >
> > > > On Fri, Mar 8, 2019 at 2:08 PM Pavel Machek <pavel@ucw.cz> wrote:
> > > > >
> > > > > On Fri 2019-03-08 13:38:02, Nick Crews wrote:
> > > > > > This patch is meant to be applied on top of the for-next
> > > > > > branch of the platform/chrome repository, as it uses some of
> > > > > > the code staged there.
> > > > > >
> > > > > > The EC is in charge of controlling the keyboard backlight on
> > > > > > the Wilco platform. We expose a standard LED class device at
> > > > > > /sys/class/leds/wilco::kbd_backlight. This driver is modeled
> > > > > > after the standard Chrome OS keyboard backlight driver at
> > > > > > drivers/platform/chrome/cros_kbd_led_backlight.c
> > > > >
> > > > > Can you make it "platform::kbd_backlight"? We want some consistency
> > > > > there.
> > > >
> > > > The analogous name in the standard driver
> > > > drivers/platform/chrome/cros_kbd_led_backlight.c is
> > > > "chromeos::kbd_backlight", and I thought "wilco" was a better
> > > > substitute for "chromeos" than "platform" would be. What other thing
> > > > are you saying "platform" would be consistent with?
> > >
> > > Yeah, well, we not let the cros_kbd_led_backlight.c use chromeos:: in
> > > the first place. But it happened. We want all backlights for the
> > > system keyboard to use common name, and "chromeos" is not really
> > > suitable for that. "platform" is.
> >
> > Pavel, who exactly wants this and why? Looking at today's -next I see:
> >
> > dtor@dtor-ws:~/kernel/linux-next ((next-20190404))$ git grep
> > "::kbd_backlight" | wc -l
> > 18
> > dtor@dtor-ws:~/kernel/linux-next ((next-20190404))$ git grep
> > "platform::kbd_backlight" | wc -l
> > 0
> >
> > so there isn't a single instance of "platform::kbd_backlight" and we
> > definitely not changing existing names.
>
> Yeah, we made mistakes in the past. We _don't_ want userspace to have
> ever growing list of names for userspace to follow.
>
> Backlight of internal keyboard is pretty common concept and there
> should be one name for it.

It is the *function* that is interesting to userspace, not full name,
and we have proper standardization there.

I think before you demand changes in the drivers you need to get you
naming scheme get accepted into mainline
(Documentation/leds/leds-class.txt).

Thanks.

-- 
Dmitry
