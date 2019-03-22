Return-Path: <SRS0=oArh=RZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 823EFC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:50:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48B8221841
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Mar 2019 15:50:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mv4kNjHp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728003AbfCVPuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Mar 2019 11:50:13 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44161 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbfCVPuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Mar 2019 11:50:12 -0400
Received: by mail-ot1-f65.google.com with SMTP id d24so2300271otl.11
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 08:50:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ipsjAdQ51p8eKs5pci4GHkiYC8eUr8VOsZanUxF4LPE=;
        b=mv4kNjHplPOvA2yR2f6tjTRVvrdo/jwg3VKyIZY4OBKwNVa2us3Dl5HfrUKFL5B0xH
         spP/FFGX94gS/iH5uw4W2UU66Pwaqx2yfG6tG1ERevhIhbKIEhkm90AeHGLJOo0L0Feb
         /Yi9ODvhaAExa5oNLfmG4S69LSQU3QzmaIN58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ipsjAdQ51p8eKs5pci4GHkiYC8eUr8VOsZanUxF4LPE=;
        b=i/akb/aek7nKIC4VOkO7NeEqnEtkPCzY+wnIWvYU8bqAuef+CT8t2m0bAK6S7tlkgo
         Rw07q3sZ5fs2X0M5SlAMZCcaVxc4p4P44TpFpEVcr5uRIPxuH7j/vptLQDyCV+dl36AH
         EzHurU0FJeEqAtPgTECoXYOy9mMu5ofiul+P5HtTIIDzxICZI7PGQomL8vG+03J+l1Z9
         PamTLhhALX8v6Jlld57N2xcCG9NAhbV6KVtT1LlZR5vjqrdx5RMdjdr4Cd/lCQmD6itX
         CoBNDeOh1kzgst7qlc/i9GBhuiYob7fUewMBD2TZRKpM3gsN+Qr57P2CM5yXXdWIz8Tb
         18Vw==
X-Gm-Message-State: APjAAAXTdpqBuqgjVqJEEqRyGa5xVe2I2B3dFUAx/KNNFO4oc/eax9gy
        A6gfFqd7NPM8M5aakh3SS7CzbBUAXdc=
X-Google-Smtp-Source: APXvYqy1hCpUub3sWodSfG4l0wRXKl4llKxeyhPLSJlfhIDI3ESxVKDJW7y8d9urnkzLapf3H9DPIg==
X-Received: by 2002:a9d:7b50:: with SMTP id f16mr4207702oto.221.1553269811542;
        Fri, 22 Mar 2019 08:50:11 -0700 (PDT)
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com. [209.85.167.173])
        by smtp.gmail.com with ESMTPSA id g128sm3145793oif.56.2019.03.22.08.50.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 08:50:10 -0700 (PDT)
Received: by mail-oi1-f173.google.com with SMTP id e22so2081810oiy.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2019 08:50:09 -0700 (PDT)
X-Received: by 2002:aca:558d:: with SMTP id j135mr2335055oib.49.1553269809295;
 Fri, 22 Mar 2019 08:50:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190321221334.240059-3-ncrews@chromium.org> <20190322113509.GE8681@amd>
In-Reply-To: <20190322113509.GE8681@amd>
From:   Nick Crews <ncrews@chromium.org>
Date:   Fri, 22 Mar 2019 09:49:57 -0600
X-Gmail-Original-Message-ID: <CAHX4x85L_WONddW3gCUBm4d99xD8AEUfrh8JFd=gn3m7wyF6Lg@mail.gmail.com>
Message-ID: <CAHX4x85L_WONddW3gCUBm4d99xD8AEUfrh8JFd=gn3m7wyF6Lg@mail.gmail.com>
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

On Fri, Mar 22, 2019 at 5:35 AM Pavel Machek <pavel@ucw.cz> wrote:
>
> Hi!
>
> > The EC is in charge of controlling the keyboard backlight on
> > the Wilco platform. We expose a standard LED class device at
> > /sys/class/leds/wilco::kbd_backlight. This driver is modeled
> > after the standard Chrome OS keyboard backlight driver at
> > drivers/platform/chrome/cros_kbd_led_backlight.c
>
> Please make it platform::kbd_backlight . Userland should not need to
> know what wilco is...

The corresponding device for normal chromeos devices is
"chromeos::kbd_backlight". I wanted to differentiate this device from
that one, so I thought that "wilco" a similar level of specific-ness as
"chromeos". Using "platform" seems too general. The power manager
daemon that controls the backlight just searches for LEDs ending with
"*:kbd_backlight" so it should work for that, and I figured any user just
browsing through sysfs would be able to guess what the LED does.

This is maybe a question for those who will need to maintain the
Chrome OS system after adding this? Could some more
Chrome OS-specific people chime in on this? I also CC'ed Simon
Que, the author of the original driver (Simon, we are talking about
https://lkml.org/lkml/2019/3/21/999)

>
> What is wilco, anyway?

Wilco is a new Chrome OS device which does not use the same embedded
controller as the rest of the Chrome OS ecosystem. Thus, we need this new
driver because the old one will not be compatible.

>
>                                                                         Pavel
> --
> (english) http://www.livejournal.com/~pavelmachek
> (cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
