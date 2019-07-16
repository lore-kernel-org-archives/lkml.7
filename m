Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84737C76192
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 21:52:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D0252173B
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 21:52:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TVDnEikn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730915AbfGPVwd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 17:52:33 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42134 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbfGPVwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 17:52:33 -0400
Received: by mail-lf1-f65.google.com with SMTP id s19so14840663lfb.9
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 14:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sChX2tjZXXzFm/FF0+gISHJ8+I30zgl6h1ocaPpSr4w=;
        b=TVDnEiknWAcRrVYjpkVEp+7UlZza/YL/doDnWkXLRwGqJ9YS6xQoSpx94TtYwkM0Zm
         9JcQMIFbg+AGr5yblr8fIfyWGtAiWjIILXfM7IITLcHbJNA9fCyb6PLAg+BasgvkoPqY
         mOu8Q8JEY5ecE/Co/dtC9Acv0384Ahf5uv5clQz+i59KnETYFC1wsz8UK5PiDYs/T9n1
         cgi/EyRXEgBnePqIEVvybyK+Lmko4rVlZEkLGBTQU7Ct2fceE6jFBcW+cy4RZHOvyaT4
         yK6DJECW1VMyuUV4EO4RpgP01Zcz3GnzbCKe0KHKjUI5P8ZOseBMqWLKAA5U3ku+AEek
         v3mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sChX2tjZXXzFm/FF0+gISHJ8+I30zgl6h1ocaPpSr4w=;
        b=HuN5qLG3j9Xe2FXp9tlYFaZCOTTIauzm7Cs2kACpAuwNQ85UJsjOjeRNX1kSu+DXl1
         F3m+7sOuCx5PNR7eXh1Pz4fj/WrdDJSU83qnc1550SxbHpuLHK0K2B51ApY9EXcopQuH
         aJ8sl9RdcE8gQPromdasnZ+mzTH8TMFDkEh87pUP1KBZ5JoffpcwsBa/L5AiQICF1rhn
         Hqpg+M1p5/K8rE+BCTvaBLyMDbe1/pthINDK0punidWOY7BI/HYenejb4l9Nxvtg9xBn
         Yipn429gwZqviZQ1fxfFZTB4Ldvkbkg3WkWQrYoxQMiYhmdOdYRZ/+1fdIB5QwraK9eL
         bdKA==
X-Gm-Message-State: APjAAAU5ISiEFtss/Btazx83COFUNQnWmIvDR0hifSq9WNvJV1fbWkI+
        B5qfvyhrWwWE1GIdzGDp1n/9f4m2+hYDEUNl9QPgVw==
X-Google-Smtp-Source: APXvYqxF5LGbIM5rW+0/RUz7xG/c4ekdZJIfr+EH8zBCsdrd9zerb9uo3Zsk8A9BlRzj6R313IgBGYMpeLNcjo9YvBk=
X-Received: by 2002:a19:6a01:: with SMTP id u1mr15820032lfu.141.1563313950958;
 Tue, 16 Jul 2019 14:52:30 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000a55d7d058d51ad4f@google.com>
In-Reply-To: <000000000000a55d7d058d51ad4f@google.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 16 Jul 2019 23:52:19 +0200
Message-ID: <CACRpkdYbuJ_yJ+UKtvWrkmBCbQzfk-1mn1-A836dkNMrmTtZow@mail.gmail.com>
Subject: Re: WARNING in gpio_to_desc
To:     syzbot <syzbot+cf35b76f35e068a1107f@syzkaller.appspotmail.com>,
        Johan Hovold <johan@kernel.org>,
        Vincent Cuissard <cuissard@marvell.com>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-usb <linux-usb@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2019 at 1:07 PM syzbot
<syzbot+cf35b76f35e068a1107f@syzkaller.appspotmail.com> wrote:

> HEAD commit:    7829a896 usb-fuzzer: main usb gadget fuzzer driver
(...)
>   __gpio_set_value include/asm-generic/gpio.h:104 [inline]
>   gpio_set_value include/linux/gpio.h:71 [inline]
>   nfcmrvl_chip_halt+0x4e/0x70 drivers/nfc/nfcmrvl/main.c:259
>   nfcmrvl_nci_register_dev+0x2d4/0x378 drivers/nfc/nfcmrvl/main.c:176
>   nfcmrvl_probe+0x4e9/0x5e0 drivers/nfc/nfcmrvl/usb.c:344

This bug is somewhere in the drivers/nfc/nfcmrvl* code handling
GPIOs.

It should be converted to GPIO descriptors and fixed up, see
drivers/gpio/TODO for details on how to do this.

Johan/Vincent, tell me if you want me to forward the full fuzzing
robot crash dump.

Yours,
Linus Walleij
