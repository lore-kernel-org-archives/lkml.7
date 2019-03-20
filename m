Return-Path: <SRS0=4Jrr=RX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD4EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3787E21874
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Mar 2019 17:18:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qH0tHNVk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfCTRSk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Mar 2019 13:18:40 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:43090 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726403AbfCTRSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Mar 2019 13:18:40 -0400
Received: by mail-pf1-f196.google.com with SMTP id c8so2382506pfd.10;
        Wed, 20 Mar 2019 10:18:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tKlHVjRxjKuI1Z9G/6jARFHoWpyJM+7v4o3aLDnjNNI=;
        b=qH0tHNVkGWlbjSxDOS5cRFAlad1fAJcuVVB2LIIXLPGxLEfIjgzPA4GJxU/+ZKwL8B
         SbHavcgamEx/IheNfj1yxudySRcRY40kToJVGhThX2Z5u6UiJKCue9uQehiM2WSYnV9r
         hTP4qiGVZrxOKJEtv520oZ0sxWWqZ56eJkFwwzod/Ri0VArEtjYPTadf/pFl3WoQciU/
         sxJ0apcDLxIOyGIwCkvJL6Dwq4mOJLNENGhbNyoL9iPXllsMj9Ml0OyZjTWE+AGqUwq6
         SJpre9kXp7A3Zxr4gn73vtVAG0JtIcUAe8RePytdGAbPGsTOji6bWZO1PC9ERsl4BAlh
         A26g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tKlHVjRxjKuI1Z9G/6jARFHoWpyJM+7v4o3aLDnjNNI=;
        b=sBSeW8wk8S569c7zIaf3Jvlim0yG/8vGs9WHTcykXQB8kk9w/Nq00ZUTn3lRAyBSJo
         BG1ducaMjd709Gzhsm+KS+TjKwldBiApH7638w3cXibgdSj6/0apRqvk2UyOMFUkPpV0
         BaRUnGMrsYXrXUkkh81mb3Dz4jXa/SrezXvkz6hQYhW9LKpTShGMV/C8F7/wq1cZplOK
         SA4BzntnRxqiuwmtj1B5d7Yh+cQfyaL4WJGxc+T3cbHjB02IYxAfr4wDS4dbBzLkYX9K
         ScTmfk4ZM+kIE2hwE+OfLG0isfoYUfKLxX+WoMrauZRhZH5h6Mxzj6+rppmwKgchNw8G
         ARVQ==
X-Gm-Message-State: APjAAAW7lcHVy7e7iRuIMEVlWCP5R2HLcSfuCgcKsbrJ8kc1zF3XRa2+
        a2tr3YTvQGoYPg4wjDioCmK2NPLmuLGbZkFlk7s=
X-Google-Smtp-Source: APXvYqwL4jS7Y1gocqs7MV9Zdsnw0opceASViNFlqbrzJMlNgCYgXt31CeDlwdlQRMO2oY6G1TgYeDxRQUmU8+8vwMk=
X-Received: by 2002:a63:e845:: with SMTP id a5mr7612181pgk.246.1553102318914;
 Wed, 20 Mar 2019 10:18:38 -0700 (PDT)
MIME-Version: 1.0
References: <LaQHUFs--3-1@tutanota.com> <CAO-hwJLGABHATo-fOc_jgc8uNeLDv7cemsHuQMj7zRJWmfyp4g@mail.gmail.com>
 <9151d116-958c-9298-9427-fe803a163e9f@redhat.com> <F03846A5-6C42-4290-AF72-F644C809A50A@canonical.com>
In-Reply-To: <F03846A5-6C42-4290-AF72-F644C809A50A@canonical.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 20 Mar 2019 19:18:27 +0200
Message-ID: <CAHp75VcOG9H8u+tZyNN682r7+jsRZi8VoPPZ2uJPch1gNyFgmQ@mail.gmail.com>
Subject: Re: [PATCH] ELAN touchpad i2c_hid bugs fix
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        hotwater438@tutanota.com, Jiri Kosina <jikos@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Dmitry Torokhov <dtor@chromium.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 20, 2019 at 6:55 PM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
> at 23:39, Hans de Goede <hdegoede@redhat.com> wrote:
> > On 3/20/19 3:37 PM, Benjamin Tissoires wrote:

> > Benjamin, what I find interesting here is that the BOGUS_IRQ quirk
> > is also used on Elan devices, I suspect that these Elan devices
> > likely also need the I2C_HID_QUIRK_FORCE_TRIGGER_FALLING quirk
> > and then they probably will no longer need the bogus IRQ flag,
> > if you know about bugreports with an acpidump for any of the devices
> > needing the bogus IRQ quirk, then I (or you) can check how the IRQ is
> > declared there, I suspect it will be declared as level-low, just like
> > with the laptop this patch was written for. And it probably need to
> > be edge-falling instead of level-low just like this case.
>
> First, I=E2=80=99ve already tried using IRQF_TRIGGER_FALLING, unfortunate=
ly it
> doesn=E2=80=99t solve the issue for me.
>
> I talked to Elan once, and they confirm the correct IRQ trigger is level
> low. So forcing falling trigger may break other platforms.

As far as I understood Vladislav the quirk he got from Elan as well.

> Recently we found that Elan touchpad doesn=E2=80=99t like GpioInt() from =
its _CRS.
> Once the Interrupt() is used instead, the issue goes away.

IIRC i2c core tries to get interrupt from Interrupt() resource and
then falls back to GpioInt().
See i2c_acpi_get_info() and i2c_device_probe().

> But I am not sure how to patch its DSDT/SSDT in i2c-hid.

--=20
With Best Regards,
Andy Shevchenko
