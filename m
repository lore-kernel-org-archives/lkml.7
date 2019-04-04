Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11C9BC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 19:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB27F2082E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 19:05:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="J4/GFTF6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730077AbfDDTFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 15:05:54 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:35260 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730021AbfDDTFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 15:05:54 -0400
Received: by mail-lf1-f68.google.com with SMTP id u21so2628716lfu.2
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 12:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wKp1rToFdUGex172LVCX0S/Lj/+9JfBGYyB2ooa9bw8=;
        b=J4/GFTF6WiD2eqrOe/qDLL+4K0u79+9aUDktAtydDNX5hWx0OHDh2X7kJpjzwPpchV
         SiWfee8aMiHpq1J5aSp3kZ1IibqcozEXsT200sZ+Nk5JL9PCRCZlYxeAex1+8/9ZCfmG
         YyCpUc/8lROQ7J9Nregwatwr7R5QYLZhkUZ4U0Q8v+cXVqTkzhVTmXe8b2/kyw6qfDca
         Cf3gEs97AG5NYPWLQQaxwyCju/kBzaOjRhp4ngkT51sPzd6tIl1CjXiC3RTccZvoB72z
         d89G8uVn8unlC4TLC3lMJJF8DKuKdc/aRrJ9nSa2PQbx7JoRjvmoteEyeJ2LL8YaL8qb
         zARg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wKp1rToFdUGex172LVCX0S/Lj/+9JfBGYyB2ooa9bw8=;
        b=Vr0dMeIW0Tz0e8pbJi0QGfntxoaUa6dkkBWc1fA96julN1giCWcRiY5uytDxuI5n6r
         aThowLp0QsUVKn0dmPdbR9qi/SwFt0rr1S/YOK2kAAhCFhsmBfxJURzqx4Sur+CFNStW
         A4VTh+KJpDIACCQffJEArgIIG8mf0EbyrSRmcQI33rwqoHRT+gnR4aYX8BXIqFr7XxlU
         sslgLjyAyFGkNICskTyuW93XMngNCGomSpdvLeK1phaDlbTXLGikHY7f6HrM0E9uyQfP
         4DrOUsa5s+HJpXNO92r25dPA3O0RJi1vBBzeATpndEzSIJf8zj9GE+Mp6jYYzZ+lTDcn
         paHQ==
X-Gm-Message-State: APjAAAVmmmaoqM2WARWwctd6rNIXWITfq6RqxNDgbfA4riyFxGTsAEfJ
        sXAFqOl0WD83dFIsHQmPsWvcQBDlo3sHzzSPUECbaw==
X-Google-Smtp-Source: APXvYqy0gbMNmAyjyQz0nO3CKzDALY2qplhIL0ptFdNPIDI/FCG2gdRKxASq06bVTpt4VNdECbYRa36LsUMUHP6KtjQ=
X-Received: by 2002:ac2:42c8:: with SMTP id n8mr4302514lfl.28.1554404751351;
 Thu, 04 Apr 2019 12:05:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190404171007.160878-1-ncrews@chromium.org> <20190404171007.160878-3-ncrews@chromium.org>
 <CABXOdTeFnohENJrZ+=_W-EgsrKWttSFYKoR=LaCwzbhEbaOxzw@mail.gmail.com>
 <CAE_wzQ8xS+zvSKNVs1v4B_y3NDu2qB65p_hD+j=qGHFxQWOmSg@mail.gmail.com>
 <CAHX4x87cQLhZOEDxwBJs=UkDxwGxZOELGjHtp6aFLBWmjyQAFQ@mail.gmail.com>
 <CAE_wzQ8k4vO4yLsr2WNxYQ=-6JDmTsj6OxD0f3P=k8kJYFOD9Q@mail.gmail.com> <20190404185919.GB27340@amd>
In-Reply-To: <20190404185919.GB27340@amd>
From:   Dmitry Torokhov <dtor@google.com>
Date:   Thu, 4 Apr 2019 12:05:39 -0700
Message-ID: <CAE_wzQ-XuK7WOyPm6yXsmjp7z0=T92mMrfn1TVaavaLejcYVGA@mail.gmail.com>
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

On Thu, Apr 4, 2019 at 11:59 AM Pavel Machek <pavel@ucw.cz> wrote:
>
> On Thu 2019-04-04 11:55:27, Dmitry Torokhov wrote:
> > On Thu, Apr 4, 2019 at 11:41 AM Nick Crews <ncrews@chromium.org> wrote:
> > >
> > > On Thu, Apr 4, 2019 at 11:43 AM Dmitry Torokhov <dtor@google.com> wrote:
> > > >
> > > > On Thu, Apr 4, 2019 at 10:36 AM Guenter Roeck <groeck@google.com> wrote:
> > > > >
> > > > > On Thu, Apr 4, 2019 at 10:11 AM Nick Crews <ncrews@chromium.org> wrote:
> > > > > >
> > > > > > We want all backlights for the system keyboard to
> > > > > > use a common name, so the name "platform::kbd_backlight"
> > > > > > would be better than the current "chromeos::kbd_backlight"
> > > > > > name. Normally this wouldn't be worth changing, but the new
> > > > > > Wilco keyboard backlight driver uses the "platform" name.
> > > > > > We want to make it so all Chrome OS devices are consistent,
> > > > > > so we'll change the name here too.
> > > > > >
> > > > >
> > > > > Wondering - who is the "we" you are talking about ?
> > >
> > > You're right, I should have been more precise.
> > > I was referring to Pavel, Enric, and myself. Pavel had this opinion here:
> > > https://lkml.org/lkml/2019/4/4/1040. I don't know what Pavel meant by "we"
> > > in that comment, but I would guess that could mean the other LED maintainers
> > > as well? I talked with Enric 1:1 and he didn't see the problem with changing it,
> > > though perhaps he was only considering our use of the LED via powerd,
> > > and not users in general. I'm guessing Pavel's and Enric's meanings though,
> > > excuse me if I am misinterpreting.
> > >
> > > >
> > > > This also has a potential of breaking existing setups if somebody did
> > > > happen to match on entire name instead of suffix. Such changes have to
> > > > be considered very carefully; at this point I am against of doing
> > > > this.
> > >
> > > Would it make sense to keep the old name as is, and only make the new
> > > Wilco name begin with "platform:"? What would you think is best?
> >
> > Given that we do not have a single instance of platform::kbd_backlight
> > in kernel at this time I have no idea why Pavel is trying to push this
> > for Wilco driver.
>
> See the documentation in the email I sent few seconds ago. I hope it
> explains my reasoning, if not, I'll explain it.

Yes, I see the doc and I do not think I agree with it. If you look at
the LED docs you will see:

LED Device Naming
=================

Is currently of the form:

"devicename:colour:function"

It is *function* and maybe color that userspace is interested in, and
here we have proper standardization in form of "kbd_backlight". Device
name is, well, device name. It should uniquely identify the device led
is attached to, but otherwise is rarely interesting. If userspace is
really concerned what kind of keyboard backlight it is it should
investigate parent device(s) and see what they end up with.

Thanks.

--
Dmitry
