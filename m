Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3302C10F0C
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 19:59:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8235E20882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 19:59:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Fic7WaIS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730589AbfDDT7u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 15:59:50 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:33370 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730541AbfDDT7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 15:59:49 -0400
Received: by mail-lj1-f193.google.com with SMTP id f23so3235739ljc.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 12:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PwBYbEQ83pwKFnTGwPEN9U9qKAZd9KTnoCzlYwy/ROU=;
        b=Fic7WaIS2ZoofTqd2rOMhucup0qNDg0FyuFlvzUShaPQvsMR5LVDFoua9yzhyOTQIo
         +e0z/mrCRV6vunxbEd+NsiOdTLJGrqhjZ4KMTcCfgXWwaHeqHdzN6rfYj6hKiMJFI+7+
         EfVppOwmXmN/gUpr6RGVVeKGxkfXzfYXrmuQr6ISURtb1tpq9qwrzcsI5vV4o0TDpAFw
         dMKZK7+SQRE66WQ+ObjK+TN5SvY0IZsJeg/G8+RLjXVaWGjvooK+nDVyePNCLx8niiJ0
         RgNRYIlFoPW/nWYh9GW2kKM2I1l9JoZyHEGShdqxqZS97FxD++7qXSvS2XHKea0dhZWo
         1ERA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PwBYbEQ83pwKFnTGwPEN9U9qKAZd9KTnoCzlYwy/ROU=;
        b=oYblguvDPRrBh7LWo6o6FIpOOTIWTmVNpc4kVI+WL7R99f19HIuml1dPjMn4cCzmET
         KcjeNKnQ+ueFE2P8PlJ0Km6BwenCdZkZ6eJcED+yN/NqRNJuWH20Z7a2W8UwhFbUWN+Z
         rnVkN0V9swEbkEwQKw1EVVqPGv6k5R8QhGEwivs42fJFoZpddZ0aSoOMrNRUowY9zYKr
         XSih7OPsI18e1e7mqb1U2IemufnaNij1nc+2TBK1pqrZSGo3D5lQrayYabRi8tU6D3b2
         9ArfDij/hJOxyB+DWThbnNszTA09+evxwOU7eDpjamLFGx8lH1wLsHZOmAX0ddMkqZI8
         zcow==
X-Gm-Message-State: APjAAAWuSdKmFfEkIEggW74SRONIf5O09SU6Q0n7+GZE58BJ7rkkv3C1
        s61gxbuj3TBHu2H5d9nReQyf/7kOtnPl8E7hXwggkg==
X-Google-Smtp-Source: APXvYqyeASWvznZmcPl7rh31Wz2z0F6yccLVIjMdbMPE7o87l8x2NWK7G2PLbEqCjgooXqKwB3me1RyTEAy0COySU4I=
X-Received: by 2002:a2e:8888:: with SMTP id k8mr4522908lji.43.1554407985879;
 Thu, 04 Apr 2019 12:59:45 -0700 (PDT)
MIME-Version: 1.0
References: <20190404171007.160878-1-ncrews@chromium.org> <20190404171007.160878-3-ncrews@chromium.org>
 <CABXOdTeFnohENJrZ+=_W-EgsrKWttSFYKoR=LaCwzbhEbaOxzw@mail.gmail.com>
 <CAE_wzQ8xS+zvSKNVs1v4B_y3NDu2qB65p_hD+j=qGHFxQWOmSg@mail.gmail.com>
 <CAHX4x87cQLhZOEDxwBJs=UkDxwGxZOELGjHtp6aFLBWmjyQAFQ@mail.gmail.com>
 <CAE_wzQ8k4vO4yLsr2WNxYQ=-6JDmTsj6OxD0f3P=k8kJYFOD9Q@mail.gmail.com>
 <20190404185919.GB27340@amd> <CAE_wzQ-XuK7WOyPm6yXsmjp7z0=T92mMrfn1TVaavaLejcYVGA@mail.gmail.com>
 <20190404191931.GA29984@amd>
In-Reply-To: <20190404191931.GA29984@amd>
From:   Dmitry Torokhov <dtor@google.com>
Date:   Thu, 4 Apr 2019 12:59:34 -0700
Message-ID: <CAE_wzQ8y8i7C+_tv0CdnbUw0r21g1ggv2YUuzCog1xABivEvWA@mail.gmail.com>
Subject: Re: [PATCH v5 3/3] platform/chrome: Standardize Chrome OS keyboard
 backlight name
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Nick Crews <ncrews@chromium.org>,
        Guenter Roeck <groeck@google.com>,
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

On Thu, Apr 4, 2019 at 12:19 PM Pavel Machek <pavel@ucw.cz> wrote:
>
> On Thu 2019-04-04 12:05:39, Dmitry Torokhov wrote:
> > On Thu, Apr 4, 2019 at 11:59 AM Pavel Machek <pavel@ucw.cz> wrote:
> > >
> > > On Thu 2019-04-04 11:55:27, Dmitry Torokhov wrote:
> > > > On Thu, Apr 4, 2019 at 11:41 AM Nick Crews <ncrews@chromium.org> wrote:
> > > > >
> > > > > On Thu, Apr 4, 2019 at 11:43 AM Dmitry Torokhov <dtor@google.com> wrote:
> > > > > >
> > > > > > On Thu, Apr 4, 2019 at 10:36 AM Guenter Roeck <groeck@google.com> wrote:
> > > > > > >
> > > > > > > On Thu, Apr 4, 2019 at 10:11 AM Nick Crews <ncrews@chromium.org> wrote:
> > > > > > > >
> > > > > > > > We want all backlights for the system keyboard to
> > > > > > > > use a common name, so the name "platform::kbd_backlight"
> > > > > > > > would be better than the current "chromeos::kbd_backlight"
> > > > > > > > name. Normally this wouldn't be worth changing, but the new
> > > > > > > > Wilco keyboard backlight driver uses the "platform" name.
> > > > > > > > We want to make it so all Chrome OS devices are consistent,
> > > > > > > > so we'll change the name here too.
> > > > > > > >
> > > > > > >
> > > > > > > Wondering - who is the "we" you are talking about ?
> > > > >
> > > > > You're right, I should have been more precise.
> > > > > I was referring to Pavel, Enric, and myself. Pavel had this opinion here:
> > > > > https://lkml.org/lkml/2019/4/4/1040. I don't know what Pavel meant by "we"
> > > > > in that comment, but I would guess that could mean the other LED maintainers
> > > > > as well? I talked with Enric 1:1 and he didn't see the problem with changing it,
> > > > > though perhaps he was only considering our use of the LED via powerd,
> > > > > and not users in general. I'm guessing Pavel's and Enric's meanings though,
> > > > > excuse me if I am misinterpreting.
> > > > >
> > > > > >
> > > > > > This also has a potential of breaking existing setups if somebody did
> > > > > > happen to match on entire name instead of suffix. Such changes have to
> > > > > > be considered very carefully; at this point I am against of doing
> > > > > > this.
> > > > >
> > > > > Would it make sense to keep the old name as is, and only make the new
> > > > > Wilco name begin with "platform:"? What would you think is best?
> > > >
> > > > Given that we do not have a single instance of platform::kbd_backlight
> > > > in kernel at this time I have no idea why Pavel is trying to push this
> > > > for Wilco driver.
> > >
> > > See the documentation in the email I sent few seconds ago. I hope it
> > > explains my reasoning, if not, I'll explain it.
> >
> > Yes, I see the doc and I do not think I agree with it. If you look at
> > the LED docs you will see:
>
> If you take a look at mailing list archive, this is currently being
> worked on. And you might want to take a look at MAINTAINERS file :-)

So? Being maintainer does not give you free reign to merge stuff that
does not quite make sense, you still need to discuss it and convince
people.

>
> > LED Device Naming
> > =================
> >
> > Is currently of the form:
> >
> > "devicename:colour:function"
> >
> > It is *function* and maybe color that userspace is interested in, and
> > here we have proper standardization in form of "kbd_backlight". Device
> > name is, well, device name. It should uniquely identify the device led
> > is attached to, but otherwise is rarely interesting. If userspace is
> > really concerned what kind of keyboard backlight it is it should
> > investigate parent device(s) and see what they end up with.
>
> That does not work. Userspace wants to know if it is internal keyboard
> or USB keyboard, not what kind of i2c controller the LED is connected
> to.

Why does userspace want to know it? What does it do differently with
backlit external keyboards vs internal ones? And how does it decide if
USB keyboard is internal or not given that there are devices with
internal USB keyboards?

>
> grep for platform::mic_mute .
>
> (And platform is even pretty good match for how the LED is connected
> in your case).

Until we get a secondary interface that is also "platform"...

Thanks.

-- 
Dmitry
