Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3CEFC4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 20:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1B92206BA
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 20:22:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="asVSXgG8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730810AbfDDUWq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 16:22:46 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46949 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729547AbfDDUWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 16:22:46 -0400
Received: by mail-lf1-f67.google.com with SMTP id r25so2712969lfn.13
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 13:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LDB19/flcBLRE+mVvIbsKM280+QDIORWb0KeJBezj7Q=;
        b=asVSXgG866QtHlkNamrkOa2pfr45oWcj+XTF/VoBa7SIwhNRakmemU0v1n+WaXt3j5
         ttnoT/sbzwWyiWkes7F5O1RuMTWXzM97mXPwhUGDKu3ytX0+r1Ak2FkK2zbntH7QWaXi
         /QEx1czjHpNp5HcI7ZjR7z5/hX8e4Dz0T1TGQFzxAkibO1Xnf6Jq93+x3QfJ7vqCfJev
         JsFybOQ4A19qG4KGDR0G3djHEtOeHwiw4RI3DpApJYJ0ItokqJdS0OHwEBoGLMUn/17v
         T42NbzcZC0nJWtfMn7du7ZM432qgUjfqh+t1yKsa0HzM5/b+LmFt42bHdz2Fx75rjs7V
         K7Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LDB19/flcBLRE+mVvIbsKM280+QDIORWb0KeJBezj7Q=;
        b=LduABVyC4ddHdDP4PQI0Nn1GKCOkasYI/SJRo9RD8fOjwVXwg8Gat4xaKuJClJyhL2
         HZhvUTPEileD54wN/iaALnr4TI7QTBXJgL2Ij8DkzzO4AAR2O8Iy1Y0W5J+9swUYcdCs
         GJ1YIXa2CWoHix3L/LFQ8dRQfYUYgEnKw24Oc5qTNAPn2VL6zXAS3nC5CBbd8t4al3Qr
         +8FDi6X4ZtpFoNt0H/JS7eZt68WujhYc9yHClZj0qRi7T/Xmroky/OjmSv0hBEiRc/uW
         UOeSXi5CntE7/lphlUtG9JqhYdkeI2wgBqWpodjBE1q3wUQheqhCSeP389trwOBtdEMY
         pEpw==
X-Gm-Message-State: APjAAAVuFrSAjzuJGyP50bR3NijhQgCZR86B/xlXaFkK9mUzqZAoI9HL
        dp1fwej7iEaDuRK/0+B3+cxLvzzX+NAtvc0xDrGtAA==
X-Google-Smtp-Source: APXvYqyn65zSY0THd0T3RfPyxGJP4qblSfeolDzI64ikDMJUnkMSuZ0fWf3OGLlZdIh1s8I/SafkqIobHXORpv1Pk6A=
X-Received: by 2002:a19:ae0a:: with SMTP id f10mr4073594lfc.118.1554409363509;
 Thu, 04 Apr 2019 13:22:43 -0700 (PDT)
MIME-Version: 1.0
References: <20190308203801.57920-1-ncrews@chromium.org> <20190308210843.GA16125@amd>
 <CAHX4x85=_76=Kyepf3Nw++4yVKOZujhLsonzaicZOnY5fi-Pfw@mail.gmail.com>
 <20190404112415.GB18653@amd> <CAE_wzQ96MkKb7uSoVBNkOZexevUKPf4jHyQZneg7YNCEs7SHfQ@mail.gmail.com>
 <20190404190326.GC27340@amd> <CAE_wzQ8mr1OMKB+ASfsCdGcs70YrzEMN4Htfg1+O51=ByhXchw@mail.gmail.com>
 <20190404192331.GB29984@amd> <CAE_wzQ_4Jb+4dDTFGQ7+sbQ-M8Qm8U_k7ug2DoZKKjTbf6pPTQ@mail.gmail.com>
 <20190404201103.GE29984@amd>
In-Reply-To: <20190404201103.GE29984@amd>
From:   Dmitry Torokhov <dtor@google.com>
Date:   Thu, 4 Apr 2019 13:22:32 -0700
Message-ID: <CAE_wzQ-iOkM08u42Q3v0wcJhS_bo1UY-vt1qMwyvm4W7kSXQ9A@mail.gmail.com>
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

On Thu, Apr 4, 2019 at 1:11 PM Pavel Machek <pavel@ucw.cz> wrote:
>
> On Thu 2019-04-04 13:07:39, Dmitry Torokhov wrote:
> > On Thu, Apr 4, 2019 at 12:23 PM Pavel Machek <pavel@ucw.cz> wrote:
> > >
> > > Hi!
> > >
> > > > > > > Yeah, well, we not let the cros_kbd_led_backlight.c use chromeos:: in
> > > > > > > the first place. But it happened. We want all backlights for the
> > > > > > > system keyboard to use common name, and "chromeos" is not really
> > > > > > > suitable for that. "platform" is.
> > > > > >
> > > > > > Pavel, who exactly wants this and why? Looking at today's -next I see:
> > > > > >
> > > > > > dtor@dtor-ws:~/kernel/linux-next ((next-20190404))$ git grep
> > > > > > "::kbd_backlight" | wc -l
> > > > > > 18
> > > > > > dtor@dtor-ws:~/kernel/linux-next ((next-20190404))$ git grep
> > > > > > "platform::kbd_backlight" | wc -l
> > > > > > 0
> > > > > >
> > > > > > so there isn't a single instance of "platform::kbd_backlight" and we
> > > > > > definitely not changing existing names.
> > > > >
> > > > > Yeah, we made mistakes in the past. We _don't_ want userspace to have
> > > > > ever growing list of names for userspace to follow.
> > > > >
> > > > > Backlight of internal keyboard is pretty common concept and there
> > > > > should be one name for it.
> > > >
> > > > It is the *function* that is interesting to userspace, not full name,
> > > > and we have proper standardization there.
> > >
> > > Well, if full name is not interesting, as you argue, why do we have
> > > this discussion?
> >
> > Because I need to understand why you believe that device name for
> > kbd_backlight matters, and having wilco::kbd_backlight is a bad idea,
> > but, for example, having max77650::kbd_backlight is perfectly fine if
> > somebody decided to wire it in this way.
>
> max77650::kbd_backlight is not fine and we'll try to prevent that in
> future.

You do not control DTS for systems though.

>
> We want one name for internal keyboard backlight. What exactly that
> name is is not _that_ important, but platform::kbd_backlight seems
> like reasonable choice.

And I am trying to show that depending on device and product (as in
entire computing device) the same driver could be used in multitude of
ways and expecting that all devices that can be internal will always
have "platform::" prefix is not realistic. It will also fail if you
have multiples of devices, as you need unique names, and that is what
<device> component in name provides you with.

You need smarter userspace to implement policy that is best suited for
your product. Maybe you can help it by adding additional properties to
LED devices, like we have connection_type in USB ports, to tell
whether device is internal or not, but I'd leave the naming alone.


Thanks.

-- 
Dmitry
