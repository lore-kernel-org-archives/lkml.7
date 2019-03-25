Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31287C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 09:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE5722085A
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 09:24:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730318AbfCYJYA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 05:24:00 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42424 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730182AbfCYJX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 05:23:59 -0400
Received: by mail-qt1-f196.google.com with SMTP id p20so9384680qtc.9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2019 02:23:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zQqIEua7PVyZDl/EKiJcikUcbVrGD83ni60fBHGM7DQ=;
        b=ACxALl5867kthPZC/QuDBD6cDQ6SYERt5pPlHCjVauIDiyjaRBN7irXzHct1TiNg+o
         Gl6EsnbkkRI6erDWAurGOE+dhCcz+L+W4TgEFy4qFXXm+/93CLGsX8oIezBreepZFUgB
         bBJLXGP+W12/DXS4byppTBX6DV0H82di5hON9uC5mDN1xU9007ogcgnAixcqCv+blRz0
         gN9p+NylJ7OuYrI+Sgsu6IHEGLQTBz08qbolRADliCCaLf0bB9lVsaImAWJ2gcNJ5O1y
         GxB1vNLta1Vh7k00GRjC+V6xp3ODDxVJj6CzlhbaU8q0wQ3LddtTCWxu8fY0xe0hfqeh
         jTEQ==
X-Gm-Message-State: APjAAAW5JnKmvZmVfN3Pc+Jgz2st8M4eA9XwRu0xCzxdOwSQeg3vb0VA
        nc3kVxQkmzEsR6Uw4sSVlOF/OS7EMWtOm+eZz9dHXQ==
X-Google-Smtp-Source: APXvYqwSt5Av2PLA28F7GqE1NfEKf53jPEY8527dvLS/x3Q2M8+yFIM3vsWEs+oBx7Em1+i7bCJRuI065m0MRJa0BuI=
X-Received: by 2002:ac8:2cd6:: with SMTP id 22mr19701937qtx.112.1553505838462;
 Mon, 25 Mar 2019 02:23:58 -0700 (PDT)
MIME-Version: 1.0
References: <20190324191035.18705-1-hotwater438@tutanota.com>
In-Reply-To: <20190324191035.18705-1-hotwater438@tutanota.com>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Mon, 25 Mar 2019 10:23:47 +0100
Message-ID: <CAO-hwJK6XU=4tXoe79cdp0OjchB2RzEGTX+WHx5NRRgWmkXXOw@mail.gmail.com>
Subject: Re: [PATCH] ELAN touchpad i2c_hid bugs fix
To:     Vladislav Dalechyn <vlad.dalechin@gmail.com>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Kai Heng Feng <kai.heng.feng@canonical.com>,
        Stephen Boyd <swboyd@chromium.org>, bigeasy@linutronix.de,
        Dmitry Torokhov <dtor@chromium.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        h0tw4t3r <hotwater438@tutanota.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vladislav,

we are almost there.

When submitting/applying a patch, we do run ./script/checkpatch.pl on
the final patch.

This gives us here 2 warnings (inlined below)

Also, can you versionize your submissions (use `-v` in git
format-patch: `git format-patch -v3 HEAD`).

On Sun, Mar 24, 2019 at 8:10 PM Vladislav Dalechyn
<vlad.dalechin@gmail.com> wrote:
>
> From: h0tw4t3r <hotwater438@tutanota.com>

checkpatch.pl complains here:
WARNING: Missing Signed-off-by: line by nominal patch author 'h0tw4t3r
<hotwater438@tutanota.com>'

Either:
- change your git settings and reset the author (git commit --amend
--reset-author)
- just drop this "From:" from the patch from git format-patch


>
> Description: The ELAN1200:04F3:303E touchpad exposes several issues, all
> caused by an error setting the correct IRQ_TRIGGER flag:
>     - i2c_hid incoplete error flood in journalctl;
>     - Five finger tap kill's module so you have to restart it;
>     - Two finger scoll is working incorrect and sometimes even when you
> raised one of two finger still thinks that you are scrolling
>
> Fix all of these with a new quirk that corrects the trigger flag
> announced by the ACPI tables. (edge-falling).
>
> Reason behind moving i2c_hid_init_irq section described below:
>     i2c_hid_init_irq now checks for a quirk, so we must setup the quirks
> before we init the irq, and we cannot setup the quirk earlier, so we must
> init the irq later.
>
> Signed-off-by: Vladislav Dalechyn <hotwater438@tutanota.com>

IIRC Andy said Co-developped-by: Hans de Goede <...> here. Does that stand Hans?

> ---
>  drivers/hid/hid-ids.h              |  1 +
>  drivers/hid/i2c-hid/i2c-hid-core.c | 25 +++++++++++++++----------
>  2 files changed, 16 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index b6d93f4ad037..660b4e0e912e 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -389,6 +389,7 @@
>  #define USB_DEVICE_ID_TOSHIBA_CLICK_L9W        0x0401
>  #define USB_DEVICE_ID_HP_X2            0x074d
>  #define USB_DEVICE_ID_HP_X2_10_COVER   0x0755
> +#define I2C_DEVICE_ID_ELAN_TOUCHPAD 0x303e
>
>  #define USB_VENDOR_ID_ELECOM           0x056e
>  #define USB_DEVICE_ID_ELECOM_BM084     0x0061
> diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
> index 90164fed08d3..9b417914411f 100644
> --- a/drivers/hid/i2c-hid/i2c-hid-core.c
> +++ b/drivers/hid/i2c-hid/i2c-hid-core.c
> @@ -51,6 +51,7 @@
>  #define I2C_HID_QUIRK_NO_RUNTIME_PM            BIT(2)
>  #define I2C_HID_QUIRK_DELAY_AFTER_SLEEP                BIT(3)
>  #define I2C_HID_QUIRK_BOGUS_IRQ                        BIT(4)
> +#define I2C_HID_QUIRK_FORCE_TRIGGER_FALLING    BIT(5)
>
>  /* flags */
>  #define I2C_HID_STARTED                0
> @@ -182,8 +183,10 @@ static const struct i2c_hid_quirks {
>                 I2C_HID_QUIRK_NO_RUNTIME_PM },
>         { I2C_VENDOR_ID_GOODIX, I2C_DEVICE_ID_GOODIX_01F0,
>                 I2C_HID_QUIRK_NO_RUNTIME_PM },
> +       { USB_VENDOR_ID_ELAN, I2C_DEVICE_ID_ELAN_TOUCHPAD,
> +               I2C_HID_QUIRK_BOGUS_IRQ | I2C_HID_QUIRK_FORCE_TRIGGER_FALLING },
>         { USB_VENDOR_ID_ELAN, HID_ANY_ID,
> -                I2C_HID_QUIRK_BOGUS_IRQ },
> +               I2C_HID_QUIRK_BOGUS_IRQ },
>         { 0, 0 }
>  };
>
> @@ -854,6 +857,8 @@ static int i2c_hid_init_irq(struct i2c_client *client)
>
>         if (!irq_get_trigger_type(client->irq))
>                 irqflags = IRQF_TRIGGER_LOW;
> +       if (ihid->quirks & I2C_HID_QUIRK_FORCE_TRIGGER_FALLING)
> +               irqflags = IRQF_TRIGGER_FALLING;
>
>         ret = request_threaded_irq(client->irq, NULL, i2c_hid_irq,
>                                    irqflags | IRQF_ONESHOT, client->name, ihid);
> @@ -1123,14 +1128,10 @@ static int i2c_hid_probe(struct i2c_client *client,
>         if (ret < 0)
>                 goto err_pm;
>
> -       ret = i2c_hid_init_irq(client);
> -       if (ret < 0)
> -               goto err_pm;
> -
>         hid = hid_allocate_device();
>         if (IS_ERR(hid)) {
>                 ret = PTR_ERR(hid);
> -               goto err_irq;
> +               goto err_pm;
>         }
>
>         ihid->hid = hid;
> @@ -1149,11 +1150,15 @@ static int i2c_hid_probe(struct i2c_client *client,
>
>         ihid->quirks = i2c_hid_lookup_quirk(hid->vendor, hid->product);
>
> +       ret = i2c_hid_init_irq(client);
> +       if (ret < 0)
> +               goto err_mem_free;
> +
>         ret = hid_add_device(hid);
>         if (ret) {
>                 if (ret != -ENODEV)
>                         hid_err(client, "can't add hid device: %d\n", ret);
> -               goto err_mem_free;
> +               goto err_irq;
>         }
>
>         if (!(ihid->quirks & I2C_HID_QUIRK_NO_RUNTIME_PM))
> @@ -1161,12 +1166,12 @@ static int i2c_hid_probe(struct i2c_client *client,
>
>         return 0;
>
> +err_irq:
> +    free_irq(client->irq, ihid);
> +

WARNING: please, no spaces at the start of a line
#112: FILE: drivers/hid/i2c-hid/i2c-hid-core.c:1170:
+    free_irq(client->irq, ihid);$


Thanks for fixing these 3 minor issues, and we will be able to merge it :)

Cheers,
Benjamin

>  err_mem_free:
>         hid_destroy_device(hid);
>
> -err_irq:
> -       free_irq(client->irq, ihid);
> -
>  err_pm:
>         pm_runtime_put_noidle(&client->dev);
>         pm_runtime_disable(&client->dev);
> --
> 2.20.1
>
