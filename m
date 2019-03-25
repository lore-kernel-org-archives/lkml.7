Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE5B4C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 20:49:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A713D20645
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 20:49:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d438UAbx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730280AbfCYUtJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 16:49:09 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46145 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729548AbfCYUtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 16:49:08 -0400
Received: by mail-lf1-f67.google.com with SMTP id r25so7023342lfn.13
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 13:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mM/qp5ZgX9XypDYpV6Igb1vjxcTXwyNlRFRNZ918d3M=;
        b=d438UAbxBFIrjBcR6pPW8TrNtrFVu9WTc8JbafnwhABZhjvDwA54He4v56Bo8CVdEy
         VLh2xufv+jkohy07lpwV+R3mM7waadtpDsPoExjFwi9WRNmTqbHb+xPwZ8Q7nsdNi1jA
         CdeYTNHePfy4iz3JRrE1WXcTjyY9+A/+Xclo6UJBfUq7GHmipZj3Q4xH2UXmqLNnVPon
         J9BAs3QNYZsfCwDpzDD9tUn2she66BkZ4hYaQUchx21sEc4UmoRz8v2NnBZnBDfuvK1L
         B1LYj9llu28kRjf82z1E879d/YcoTX3NaNOkzqklHOzIdvDNlo7k1jf3rKBOaoNGjtCD
         /wfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mM/qp5ZgX9XypDYpV6Igb1vjxcTXwyNlRFRNZ918d3M=;
        b=EL/Q3SGJmKi4zKJpQBwTzl3L9dBsqvwxy8a1Wyunm5LhXhbPl3DbkoTC/zdahCmcPN
         SgvXh3FbhqmMVwLgVVIuDGmV1CUoAzFClXnoRo2drBIs38ptPMboGysVEWeQWAKXwyqi
         q+85geBGBWsfLBnz6LMGdhCsDvw35JFqZZBeEdnjhVkur+93pcGv9bwuPq9GNnrbhPYy
         g5Gvz1ujdMW9fsKU7eBcPUF5fReJ8dIdnobu/xmin1whe2KZ0q4W3owiSetJhkHZzYsp
         lI3D/Ga9mD05w42xNio4MWTnbOYbkJB0sER2mxrolP+U81i6tG+6JQ8bzFX1+fCLDYlu
         hq2g==
X-Gm-Message-State: APjAAAWpG94ONiuee3pxzE9m/VJus4HQ0LBpZALVdSrK81eX5AWGdQ5K
        F4SAlMv/JAUplP7E4t+gCz3ZHV6CfLUV/ePlPLDZTg==
X-Google-Smtp-Source: APXvYqx481H555sQyN4WQZpBrg3k0R/eX+VrGmmX2YVz0hGNej4ujJEeLQAbrjXN93aEHKCSsAKJmIO5RUGERcUOSfQ=
X-Received: by 2002:a19:5789:: with SMTP id l131mr13253277lfb.8.1553546946121;
 Mon, 25 Mar 2019 13:49:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190321221334.240059-3-ncrews@chromium.org> <20190322113509.GE8681@amd>
In-Reply-To: <20190322113509.GE8681@amd>
From:   Dmitry Torokhov <dtor@google.com>
Date:   Mon, 25 Mar 2019 13:48:54 -0700
Message-ID: <CAE_wzQ8oRKjmA0x01+gmPuQQQ=yCxS+v+c9=VyQSg1EKP8bDkQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] platform/chrome: Add Wilco EC keyboard backlight LEDs support
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Nick Crews <ncrews@chromium.org>, enric.balletbo@collabora.com,
        Benson Leung <bleung@chromium.org>, linux-leds@vger.kernel.org,
        jacek.anaszewski@gmail.com, lkml <linux-kernel@vger.kernel.org>,
        dlaurie@chromium.org, sjg@google.com,
        Guenter Roeck <groeck@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 22, 2019 at 4:35 AM Pavel Machek <pavel@ucw.cz> wrote:
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

It should not. But the current convention is "<device>::kbd-backlight":

dtor@dtor-ws:~/kernel/work $ git grep "::kbd_backlight" -- drivers/
drivers/hid/hid-asus.c: drvdata->kbd_backlight->cdev.name =
"asus::kbd_backlight";
drivers/hid/hid-google-hammer.c:        kbd_backlight->cdev.name =
"hammer::kbd_backlight";
drivers/hwmon/applesmc.c:       .name                   = "smc::kbd_backlight",
drivers/input/misc/ims-pcu.c:            "pcu%d::kbd_backlight",
pcu->device_no);
drivers/platform/chrome/cros_kbd_led_backlight.c:       cdev->name =
"chromeos::kbd_backlight";
drivers/platform/x86/asus-laptop.c:             cdev->name =
"asus::kbd_backlight";
drivers/platform/x86/asus-wmi.c:                asus->kbd_led.name =
"asus::kbd_backlight";
drivers/platform/x86/dell-laptop.c:     .name           = "dell::kbd_backlight",
drivers/platform/x86/samsung-laptop.c:          samsung->kbd_led.name
= "samsung::kbd_backlight";
drivers/platform/x86/thinkpad_acpi.c:           .name           =
"tpacpi::kbd_backlight",
drivers/platform/x86/toshiba_acpi.c:            dev->kbd_led.name =
"toshiba::kbd_backlight";

and userspace already knows how to handle these.

Thanks.

-- 
Dmitry
