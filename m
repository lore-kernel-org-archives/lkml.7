Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9650EC43218
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 17:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 55D0C212F5
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 17:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sCCzuOHu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbfDZRV2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 13:21:28 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:41587 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfDZRV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 13:21:27 -0400
Received: by mail-pf1-f195.google.com with SMTP id 188so2035204pfd.8;
        Fri, 26 Apr 2019 10:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BfEfIB7zJ1MoBE8h3/9+xMM1sMPYYSNwRQhj35jgsyM=;
        b=sCCzuOHuXzLNKbne+d7zeXA1+e9N3GmGvjJfTYOjvRgbfDkLCkBtF8rkOZ2prjiHGu
         Nho+0BxEw3mlTgwzVV5rJuyW7RCKNbP61cEslbCzyWgq2qz6H8TjgGhpNzBkDG7IAy4M
         hQaA+lIv7fRDnqZFG0UYg3J1GMkDWIdSNBDUlXGAZldLpGspKb5aMd+gR6RHVPCNQ33j
         yDX8znl9RCS+DnfG7MwE9NDDnq8r68bdaYZ+eLz8GtACxKquBCwCVHIxswjYXUbVZJU2
         THXjStQulFzvEllk/nQ9dRDGpLpbO/E4NFzRgKm4nhP07FTPIs2vxLqNxlTdX9S3OXQt
         peRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BfEfIB7zJ1MoBE8h3/9+xMM1sMPYYSNwRQhj35jgsyM=;
        b=ndwFgVGsMzHTVmePSZz4ksegaLsMUgcRFV4b5Z4R3Xqwd0Ijdcavssp7M/agKy7vsN
         fl+Z1DJIMhO8cuLBvsgyI5X7ke9+p8kk6V7JC+sCUk1TqA5CARK3gKPrKKwaIAwnD+WX
         L66IZMwwVovRY4diock9nPHK3ZFzR+Nm9zVLxKp0TrXQqmUMkGG8cdt3yM8Suglo1nIE
         B70B4CBr0qZj9+vW4kwhwQNzGQZwWGba1pnF3uMU4wIoQt1hU5kdGqGJwIN5zXM5h/Nh
         gsEFnNMUYN0BF4JOvNQY+Wcgql3YeqsGC6WzLmHa3Zo0Cu1gltLaT+20l19rH/f5bHA8
         O6zw==
X-Gm-Message-State: APjAAAV/uH93HU6zvzHFdREFZGkmRtPVAAT27l5V2GM06d0PM2Aov+XK
        XzSNiHcmnHC9QJPnnag/T1e0ft9gvtQW6fUcX7k=
X-Google-Smtp-Source: APXvYqwgfF5XJ3TZptd0ZzFKZmATNY606I1FThPbo5lJWZ+onLNZBS0SLO0NO52xnzkdT0jSKFXoV82OPBSQmsMLH5w=
X-Received: by 2002:a63:c54e:: with SMTP id g14mr44562395pgd.265.1556299287219;
 Fri, 26 Apr 2019 10:21:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190426084038.6377-1-esben@geanix.com> <20190426143521.GW9224@smile.fi.intel.com>
 <87wojgemci.fsf@haabendal.dk>
In-Reply-To: <87wojgemci.fsf@haabendal.dk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 26 Apr 2019 20:21:16 +0300
Message-ID: <CAHp75VfAZnDLy4QdkbkPd5hkxMfTEjk2tWnL6TF6OPSWPZOj-A@mail.gmail.com>
Subject: Re: [PATCH 0/2] serial: 8250: Add support for 8250/16550 as MFD function
To:     Esben Haabendal <esben@haabendal.dk>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Darwin Dingel <darwin.dingel@alliedtelesis.co.nz>,
        Florian Fainelli <f.fainelli@gmail.com>,
        He Zhe <zhe.he@windriver.com>,
        Jisheng Zhang <Jisheng.Zhang@synaptics.com>,
        Lokesh Vutla <lokeshvutla@ti.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tony Lindgren <tony@atomide.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 26, 2019 at 8:16 PM Esben Haabendal <esben@haabendal.dk> wrote:
>
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:
>
> > On Fri, Apr 26, 2019 at 10:40:36AM +0200, Esben Haabendal wrote:
> >> This series adds a driver for adding 8250/16550 UART ports as functions to
> >> MFD devices.
> >>
> >
> > The patch 2/2 disappeared.
>
> Yes, seems like that.  I have resent it by itself.  Or do I have to
> resend the series as a whole?

Series, but first check up on existing comments and try to address them first.

-- 
With Best Regards,
Andy Shevchenko
