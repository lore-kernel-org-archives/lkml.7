Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 698DAC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 18:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D1E920820
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 18:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qNSUVG/h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730041AbfDDSzo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 14:55:44 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:40030 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729925AbfDDSzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 14:55:41 -0400
Received: by mail-lj1-f194.google.com with SMTP id q66so3036791ljq.7
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 11:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IABmWUk7Ma/eFMtoGIGHc3YEKnB3XWGMSYVSlgvw1zo=;
        b=qNSUVG/h25dEIaiFNlw22kwfRQCXlh+gsiELe8gpJB7CSlWyLh3rnQtot2DMZLk2gg
         7lDFGlJG1PgEBY8+gmZOuGyJyiPsgebpbmweknL6SppKNwVoRsQFpZlhLCUqptHbhyKI
         C52eoDuzeuGoODW0JFleKhAj1/ogtQMb7EQj6VdXjhlGXKb3sqRlEIIIoE3uRKB6F0IB
         HPkhc3oSGuuHlCf53CxMg3ht5EIOBRYhpm/OVRvlU98SzT1aXqNJIDCKCfxWr4Lpayem
         l7c0qoYsdBF1yrcB3TTLc2b8zMjN4YeKOFLac8g6Nee2nd5wBSfhezer6xbJ5RJqPBfB
         vj1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IABmWUk7Ma/eFMtoGIGHc3YEKnB3XWGMSYVSlgvw1zo=;
        b=Gr2vAFYy6/7ZgWxEHlwRWctdpEs27D83gOvIghvoWtK5YxrLRqRLSp9SKS1JfMroDR
         GFh0hX7HwAMnC/qykOOmcY714IqNweSEugumgN344RanVU97iK/ANDbRZ1p2oQglIc9d
         4QUqYKcOV62vH4IjX+SyBT0tIw90dikUbYQDas82dYYR4logsEt1lROkbTwF0G2lIIIf
         YOBnIfOMMgjs7nO9aWpxaLE3wTjVRVHb1sCm3tLKp7S9/zM/qtUgeg7VebsILNuzLyQw
         vX3wILNIGtLQiDt20MA1+cegWThsA2nMquzg3LOAr8PB/QAab1O3YcQ7HHjATvhrB8At
         5fBA==
X-Gm-Message-State: APjAAAUf4CWJ8fRXXmczKCi+s0yMJzcU9n7J72vFdDyh1qO6/sNv2JSd
        GvWZ/PXruLdjfB7VuxaSwPyFtxU65kfgMZBAYZsxXg==
X-Google-Smtp-Source: APXvYqzxnyvc41OL8JmWmu69WHQkqegCcwKGsxhFh7mYcIlPBC6ukR06/KWxknfiMa6ubR3j5e7rlMTUoujSQ55e4mM=
X-Received: by 2002:a2e:219:: with SMTP id 25mr4358340ljc.34.1554404138712;
 Thu, 04 Apr 2019 11:55:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190404171007.160878-1-ncrews@chromium.org> <20190404171007.160878-3-ncrews@chromium.org>
 <CABXOdTeFnohENJrZ+=_W-EgsrKWttSFYKoR=LaCwzbhEbaOxzw@mail.gmail.com>
 <CAE_wzQ8xS+zvSKNVs1v4B_y3NDu2qB65p_hD+j=qGHFxQWOmSg@mail.gmail.com> <CAHX4x87cQLhZOEDxwBJs=UkDxwGxZOELGjHtp6aFLBWmjyQAFQ@mail.gmail.com>
In-Reply-To: <CAHX4x87cQLhZOEDxwBJs=UkDxwGxZOELGjHtp6aFLBWmjyQAFQ@mail.gmail.com>
From:   Dmitry Torokhov <dtor@google.com>
Date:   Thu, 4 Apr 2019 11:55:27 -0700
Message-ID: <CAE_wzQ8k4vO4yLsr2WNxYQ=-6JDmTsj6OxD0f3P=k8kJYFOD9Q@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] platform/chrome: Standardize Chrome OS keyboard
 backlight name
To:     Nick Crews <ncrews@chromium.org>
Cc:     Guenter Roeck <groeck@google.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>, linux-leds@vger.kernel.org,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        Pavel Machek <pavel@ucw.cz>,
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

On Thu, Apr 4, 2019 at 11:41 AM Nick Crews <ncrews@chromium.org> wrote:
>
> On Thu, Apr 4, 2019 at 11:43 AM Dmitry Torokhov <dtor@google.com> wrote:
> >
> > On Thu, Apr 4, 2019 at 10:36 AM Guenter Roeck <groeck@google.com> wrote:
> > >
> > > On Thu, Apr 4, 2019 at 10:11 AM Nick Crews <ncrews@chromium.org> wrote:
> > > >
> > > > We want all backlights for the system keyboard to
> > > > use a common name, so the name "platform::kbd_backlight"
> > > > would be better than the current "chromeos::kbd_backlight"
> > > > name. Normally this wouldn't be worth changing, but the new
> > > > Wilco keyboard backlight driver uses the "platform" name.
> > > > We want to make it so all Chrome OS devices are consistent,
> > > > so we'll change the name here too.
> > > >
> > >
> > > Wondering - who is the "we" you are talking about ?
>
> You're right, I should have been more precise.
> I was referring to Pavel, Enric, and myself. Pavel had this opinion here:
> https://lkml.org/lkml/2019/4/4/1040. I don't know what Pavel meant by "we"
> in that comment, but I would guess that could mean the other LED maintainers
> as well? I talked with Enric 1:1 and he didn't see the problem with changing it,
> though perhaps he was only considering our use of the LED via powerd,
> and not users in general. I'm guessing Pavel's and Enric's meanings though,
> excuse me if I am misinterpreting.
>
> >
> > This also has a potential of breaking existing setups if somebody did
> > happen to match on entire name instead of suffix. Such changes have to
> > be considered very carefully; at this point I am against of doing
> > this.
>
> Would it make sense to keep the old name as is, and only make the new
> Wilco name begin with "platform:"? What would you think is best?

Given that we do not have a single instance of platform::kbd_backlight
in kernel at this time I have no idea why Pavel is trying to push this
for Wilco driver.

Thanks.

-- 
Dmitry
