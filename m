Return-Path: <SRS0=oHH8=SG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF5C6C4360F
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 20:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0A3320882
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Apr 2019 20:07:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fpyL4lJ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730525AbfDDUHy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 16:07:54 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:33081 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727108AbfDDUHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 16:07:53 -0400
Received: by mail-lj1-f194.google.com with SMTP id f23so3255569ljc.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2019 13:07:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L+xjG3YPBm1kYGvDC+JNaQ016wsr4jS4tHZQmV0IMqY=;
        b=fpyL4lJ+uAlP9gT13VXW39ahktAgdPe8WFM21XDrSvXnRLtfg74OzwfctDy9tpeMOw
         AynFsaxu9245CLqcEXy4lF0Qf9uq/kR7sV9u9gnyVXJ91ovHYW3/Cf2oSEShXz0zAbnG
         f2EPEMtRFAYYofFU3YrpIVIsBQOwbL+XK05r+Vj2OaIti7pqDIJkmE+qBWCFDaazqmOW
         wI5xViTKiykMa6CdLsK5PzN4LqEzENAw/YAxtigaMfQpZXSdbVxWuYcGD3OYouGDrqcC
         fsC3dSXEEYF3KsbyRsFAS+31OkcAHfmQEi5TpTH4aT2psPqoM1Dn112Jxf/O0XyMVkmH
         gd0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L+xjG3YPBm1kYGvDC+JNaQ016wsr4jS4tHZQmV0IMqY=;
        b=Y92+PgftvwvEPJfcgG2Vns2lYgN7RdBd8PXvPQMv6tQZO1ecmQPvkIC0LjREuSHyHw
         OOtBw8BnzLwbgFm+848wZMUG2HzTkznvF/g/9QoEv/T+qP5iRz5GeH0Poq62jCc4w/vh
         s36Vzv1Re0h6HSiWBO7TaFfesm0sEd7EwzfJfAkhnfEyG29/aOlgjiVVXUK12T5csd1O
         TFr9azBMpQU786ggBfXTICVsjXYq39YintJFej2GZ7/7Dg4BvC8F2Q6iRT1Z+uUIg9wh
         OlUl8Wt7yaNtJ77KOfesVF+h/IIuLuSTHCnkwnq40bUI1QgEt84YUoctPPr07su/W6px
         dnEA==
X-Gm-Message-State: APjAAAXFOwraakdvSh1c77wdWBVi9N4kkEjCinEHFwmZqJkTkQgBxkBk
        VH+l8VJ9oizbr0SPX3+iodCmanVFsXvtNuqn58ThWA==
X-Google-Smtp-Source: APXvYqzbZhN0VCEm2mE/6bFwfpe5LOzc+oybNg0MIaVzcp52bcAQBucKtmJCBBd1tcNfufdNKIrRJPVVvEamoDCx7xA=
X-Received: by 2002:a2e:219:: with SMTP id 25mr4530981ljc.34.1554408471130;
 Thu, 04 Apr 2019 13:07:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190308203801.57920-1-ncrews@chromium.org> <20190308210843.GA16125@amd>
 <CAHX4x85=_76=Kyepf3Nw++4yVKOZujhLsonzaicZOnY5fi-Pfw@mail.gmail.com>
 <20190404112415.GB18653@amd> <CAE_wzQ96MkKb7uSoVBNkOZexevUKPf4jHyQZneg7YNCEs7SHfQ@mail.gmail.com>
 <20190404190326.GC27340@amd> <CAE_wzQ8mr1OMKB+ASfsCdGcs70YrzEMN4Htfg1+O51=ByhXchw@mail.gmail.com>
 <20190404192331.GB29984@amd>
In-Reply-To: <20190404192331.GB29984@amd>
From:   Dmitry Torokhov <dtor@google.com>
Date:   Thu, 4 Apr 2019 13:07:39 -0700
Message-ID: <CAE_wzQ_4Jb+4dDTFGQ7+sbQ-M8Qm8U_k7ug2DoZKKjTbf6pPTQ@mail.gmail.com>
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

On Thu, Apr 4, 2019 at 12:23 PM Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
>
> > > > > Yeah, well, we not let the cros_kbd_led_backlight.c use chromeos:: in
> > > > > the first place. But it happened. We want all backlights for the
> > > > > system keyboard to use common name, and "chromeos" is not really
> > > > > suitable for that. "platform" is.
> > > >
> > > > Pavel, who exactly wants this and why? Looking at today's -next I see:
> > > >
> > > > dtor@dtor-ws:~/kernel/linux-next ((next-20190404))$ git grep
> > > > "::kbd_backlight" | wc -l
> > > > 18
> > > > dtor@dtor-ws:~/kernel/linux-next ((next-20190404))$ git grep
> > > > "platform::kbd_backlight" | wc -l
> > > > 0
> > > >
> > > > so there isn't a single instance of "platform::kbd_backlight" and we
> > > > definitely not changing existing names.
> > >
> > > Yeah, we made mistakes in the past. We _don't_ want userspace to have
> > > ever growing list of names for userspace to follow.
> > >
> > > Backlight of internal keyboard is pretty common concept and there
> > > should be one name for it.
> >
> > It is the *function* that is interesting to userspace, not full name,
> > and we have proper standardization there.
>
> Well, if full name is not interesting, as you argue, why do we have
> this discussion?

Because I need to understand why you believe that device name for
kbd_backlight matters, and having wilco::kbd_backlight is a bad idea,
but, for example, having max77650::kbd_backlight is perfectly fine if
somebody decided to wire it in this way.

Thanks.

-- 
Dmitry
