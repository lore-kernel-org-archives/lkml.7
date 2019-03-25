Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72598C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 20:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FE2920854
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 20:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UcG0ndZT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730421AbfCYUYY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 16:24:24 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39071 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729610AbfCYUYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 16:24:23 -0400
Received: by mail-ot1-f68.google.com with SMTP id f10so9330592otb.6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 13:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0qqEdTBCa53HzZOTNKKThV+l9a01PHbQ1KmHoVXZuXQ=;
        b=UcG0ndZTLjH1l7Ig3qKmsjzdKKkshlF1n4ZQbheWBm9YeXQB0hoqPNpsRJvdD+YeSr
         Vy2iNIUsPw3wE86izayielcKoplMIykGVrj6WwVrl+zyvZ8YHfi9S2J8pGFHJJAwSwgH
         ypBp8AS/zzK/rgORftpPSpIn1hRrfGgHDwxh8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0qqEdTBCa53HzZOTNKKThV+l9a01PHbQ1KmHoVXZuXQ=;
        b=WZXUeSfhvS5wW5M8MH7ZYBXO9RqdTr0ZEOFXhOf8I7b7G4LGZe0TX9WpAZ04radnuF
         GxacIlynyuG8ew/QNVbagGa+ulePJ94Mvkc48aEzK/gVYLUEJ2qGUURaDrAPHoFM1GGr
         N8VIDMI+MCSd09NjDgbYeU+XP+lJt7/rCV13FuebBxnOeqoTR5Uq5JF6gIcPs5O6vSsz
         pP39YD0CvXTjp/PgMlYcwtQcxA1H0TU89CvCou/Fu9VPObG5zYS7xqShR/CUkdYd1GuD
         Ekudz/haOcYRhIItSGGcJxGibakFqrT3GTnIyiwc/1FrJ/FwuF5z4LRxBRPRE7AWItTD
         isRg==
X-Gm-Message-State: APjAAAUwVitVxW3e5PIzN/9nDNaSqgf2eKuHn8RAX8MULYesQAe7gh/T
        9gutdWo9n2Vz/kvvvSekgyxo2XiFnQc=
X-Google-Smtp-Source: APXvYqylmvA6/lECl05UsQHN6U2DD1Y2yxaQEMj7NtqQN3bbxPrUOgR123VQUpHyApRMQOGwx96/og==
X-Received: by 2002:a9d:5509:: with SMTP id l9mr18717814oth.195.1553545462533;
        Mon, 25 Mar 2019 13:24:22 -0700 (PDT)
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com. [209.85.167.181])
        by smtp.gmail.com with ESMTPSA id q19sm6544841otf.81.2019.03.25.13.24.21
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Mar 2019 13:24:21 -0700 (PDT)
Received: by mail-oi1-f181.google.com with SMTP id v84so8112252oif.4
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 13:24:21 -0700 (PDT)
X-Received: by 2002:aca:c483:: with SMTP id u125mr12388878oif.148.1553545460910;
 Mon, 25 Mar 2019 13:24:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190321221334.240059-3-ncrews@chromium.org> <20190322113509.GE8681@amd>
 <CAHX4x85L_WONddW3gCUBm4d99xD8AEUfrh8JFd=gn3m7wyF6Lg@mail.gmail.com>
In-Reply-To: <CAHX4x85L_WONddW3gCUBm4d99xD8AEUfrh8JFd=gn3m7wyF6Lg@mail.gmail.com>
From:   Nick Crews <ncrews@chromium.org>
Date:   Mon, 25 Mar 2019 14:24:09 -0600
X-Gmail-Original-Message-ID: <CAHX4x84qSZxZ51FiYZ4ELEmUKJnUvMy7OGQVSQv2xh7x-nC57A@mail.gmail.com>
Message-ID: <CAHX4x84qSZxZ51FiYZ4ELEmUKJnUvMy7OGQVSQv2xh7x-nC57A@mail.gmail.com>
Subject: Re: [PATCH 3/3] platform/chrome: Add Wilco EC keyboard backlight LEDs support
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>, linux-leds@vger.kernel.org,
        jacek.anaszewski@gmail.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Simon Glass <sjg@google.com>,
        Guenter Roeck <groeck@google.com>,
        Dmitry Torokhov <dtor@google.com>, Simon Que <sque@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 9:49 AM Nick Crews <ncrews@chromium.org> wrote:
>
> On Fri, Mar 22, 2019 at 5:35 AM Pavel Machek <pavel@ucw.cz> wrote:
> >
> > Hi!
> >
> > > The EC is in charge of controlling the keyboard backlight on
> > > the Wilco platform. We expose a standard LED class device at
> > > /sys/class/leds/wilco::kbd_backlight. This driver is modeled
> > > after the standard Chrome OS keyboard backlight driver at
> > > drivers/platform/chrome/cros_kbd_led_backlight.c
> >
> > Please make it platform::kbd_backlight . Userland should not need to
> > know what wilco is...
>
> The corresponding device for normal chromeos devices is
> "chromeos::kbd_backlight". I wanted to differentiate this device from
> that one, so I thought that "wilco" a similar level of specific-ness as
> "chromeos". Using "platform" seems too general. The power manager
> daemon that controls the backlight just searches for LEDs ending with
> "*:kbd_backlight" so it should work for that, and I figured any user just
> browsing through sysfs would be able to guess what the LED does.
>
> This is maybe a question for those who will need to maintain the
> Chrome OS system after adding this? Could some more
> Chrome OS-specific people chime in on this? I also CC'ed Simon
> Que, the author of the original driver (Simon, we are talking about
> https://lkml.org/lkml/2019/3/21/999)

From talking to Simon, since the interface is the same, I'll just keep the name
as "chromeos::kbd_backlight". This makes sense to me too. I'll send out a
patch fixing this.

>
> >
> > What is wilco, anyway?
>
> Wilco is a new Chrome OS device which does not use the same embedded
> controller as the rest of the Chrome OS ecosystem. Thus, we need this new
> driver because the old one will not be compatible.
>
> >
> >                                                                         Pavel
> > --
> > (english) http://www.livejournal.com/~pavelmachek
> > (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
