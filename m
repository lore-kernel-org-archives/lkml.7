Return-Path: <SRS0=J4ZE=RP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B763C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 16:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4721A2054F
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Mar 2019 16:05:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="OU18r5JX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfCLQFy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Mar 2019 12:05:54 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:37261 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbfCLQFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Mar 2019 12:05:54 -0400
Received: by mail-oi1-f196.google.com with SMTP id w66so2534028oia.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 09:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JQK4P7oIuX8yYDSIeh7wV+xqkzOVF0UCQ2O/+xiRagc=;
        b=OU18r5JXhhOyZeWF99RY1nql8Dapbf2BFk7+d1lRve5W6ONee9n4NW9Z3iWJQrLk3s
         wJghfaGTWKqXTd6116yGO6I8RMQnKgBcMZ0jTdJYJm+OqXdOp7umV+NAAwQV3tJEokGn
         KOsWASTxe4VCvgBbgF00tOxbCwBRlYObFqjfg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JQK4P7oIuX8yYDSIeh7wV+xqkzOVF0UCQ2O/+xiRagc=;
        b=H8+sh8S4/kM0NSVNqeuhqakrrLAHKt87xofa9OcNLTVgTQxsxD360evI7bgnUW5RkI
         1BbqmgvKyorT47yrLwQWO31l0KxqgniLjXmCH+j/GUB784SC4CyPv12WNIyDrw0pKLUF
         2bo5j1rq9fmmfe0PF2/YCl1hEtXVQllCCNGogbQG7RTKa19SGVrSFSxNngZ4aavQo/CM
         6+xpahM0eAPi9/YuFp44rbirkVFp6D/TxclsACVuPYOJTQYe/XBtaGwsxj4ktIW5A4lo
         yV+5yc/6jxINTOsiY2BBGaVfq0SW+oiqvWqeMSU3uyfEY6do/glawA6pvBBd1rtCdS7i
         50tQ==
X-Gm-Message-State: APjAAAWTnldT5296OJTLlz+gpiMP4cqkLXpFoL9+BX6N4UrHLnpCmRlq
        y/vbvJwRE/Jqc/r6ab2zKg0r5ueQl80=
X-Google-Smtp-Source: APXvYqzRFYiGOuWVSeDClOVLaEePfRN0O5DbBuaNOwMs8egcb1qqqKzEf8ndfTQfneFrrB+pjxgfbw==
X-Received: by 2002:aca:4911:: with SMTP id w17mr2128589oia.36.1552406752925;
        Tue, 12 Mar 2019 09:05:52 -0700 (PDT)
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com. [209.85.167.173])
        by smtp.gmail.com with ESMTPSA id o17sm1292889otl.27.2019.03.12.09.05.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Mar 2019 09:05:51 -0700 (PDT)
Received: by mail-oi1-f173.google.com with SMTP id a15so2387005oid.5
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2019 09:05:51 -0700 (PDT)
X-Received: by 2002:aca:d803:: with SMTP id p3mr2046883oig.111.1552406749668;
 Tue, 12 Mar 2019 09:05:49 -0700 (PDT)
MIME-Version: 1.0
References: <20190308203801.57920-1-ncrews@chromium.org> <CAE_wzQ-Ds5a9iPuLTpV5mBHBtoUUh_-fRw66s0Su7eOifygqKQ@mail.gmail.com>
 <20190308221307.GB16125@amd>
In-Reply-To: <20190308221307.GB16125@amd>
From:   Nick Crews <ncrews@chromium.org>
Date:   Tue, 12 Mar 2019 10:05:38 -0600
X-Gmail-Original-Message-ID: <CAHX4x85Ve+AHvcO1dPN9x6P3X8RV=rSzoWbYp=S-OeDnjGmOaQ@mail.gmail.com>
Message-ID: <CAHX4x85Ve+AHvcO1dPN9x6P3X8RV=rSzoWbYp=S-OeDnjGmOaQ@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: Add Wilco EC keyboard backlight LEDs support
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Dmitry Torokhov <dtor@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>, linux-leds@vger.kernel.org,
        jacek.anaszewski@gmail.com, lkml <linux-kernel@vger.kernel.org>,
        Duncan Laurie <dlaurie@chromium.org>,
        Daniel Erat <derat@google.com>,
        Guenter Roeck <groeck@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Some Wilco devices do not support a keyboard backlight. This
> > > is checked in probe(), and in this case the sysfs entry will
> > > not appear, and everything will behave normally.
> >
> > It would be even better if we did not register platform device if EC
> > does not support backlight.

Good point Dmitry. I would imagine this would entail exposing the
keyboard_leds_exist() function. What is the best practice for doing that?
I could either imagine EXPORT_SYMBOL_GPL()ing that function, but
that would require making the core driver dependent upon this keyboard
backlight driver in a circular dependency, so there would have to be some
refactoring. The other option I see would be to add this entire driver to
the core module.

Just so I learn something, I don't see performance or stability
concerns with adding one unused platform device, is your rationale
that it would just be cleaner code?

> >
> > > +       data->led.brightness_set = keyboard_led_set_brightness;
> > > +       data->led.brightness_get = keyboard_led_get_brightness;
> >
> > wilco_ec_mailbox() may sleep, so you need to assign it to
> > led.brightness_set_blocking.

Yes, thanks for the catch.

>
> Hmm. Seeing get method there... can the EC change the brightness
> without command from kernel?

No, the EC will never do that, good point. Therefore it looks like
I can just remove the get_brightness() function and the core
library will do the right thing.

Thanks,
Nick
