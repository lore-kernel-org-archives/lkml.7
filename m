Return-Path: <SRS0=vY9Y=RJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75578C43381
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4305C20661
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Mar 2019 18:27:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OAueEc4/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbfCFS1F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Mar 2019 13:27:05 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:41086 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfCFS1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Mar 2019 13:27:05 -0500
Received: by mail-qk1-f196.google.com with SMTP id y15so7395303qki.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2019 10:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=kBMrk+cJz1b/nqRd7zw4UXY0V7pjf3jNTASwtiSq0+I=;
        b=OAueEc4/u4mAgWJBkHS6cELi7LjD2bs/igVzgaoMMKopfZlAWuMUVM4PS2jpJSK0X0
         aJmnhkEyO0YbUyQ1k9F2KJrIra4MrjhEfUaFtL8fg5mYMjteZlZLHmQDbTkUgkAQkIkF
         XTIZPMuL1EbPTgb6PyEyBzQMPXWognybeZ7pyjU0gWAEsoA+HylTNoPGK9yszCr7TJvO
         C4kbXWB92IZH0+PYs74pYj2VpbiKThS5r6UP+xhjii+It7zTpHZbXPue+0TKo3xpNp9I
         f9ycS1IYXFw8TEeYsUvt5gj50M89Yo1P5f4KdlA8dOv5FdYWgFkAAM3zTYJB3nbqfeyp
         CEWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=kBMrk+cJz1b/nqRd7zw4UXY0V7pjf3jNTASwtiSq0+I=;
        b=imM3GN7NimMQP1eIPXWSg1h1ABbLRmu1Y85HlKEsfyWf6sjovrZq+2Rm/PN6uhtKhi
         zTQs/lKfjWBNorfm7YaqSkJ2aKkhlisn1ij6kJkdgJZip4uIJK/xX4Smc4PmfMytGqwm
         QQGwLAHmnrtQ+MvJ9jP/MkocAIaADqu2ahIMAi1ig7AqfBBKLQfFvI/i97+f9gzwinOw
         AJnH/0xTw17sGw89Suigg+uuiQsBGhWF3mGC2AtKuHStRzXgTEXI0A0kL1jBXCrQVEOi
         2Wzthsx1wWjQ5gKi9AcUp0TyReO4s++3129YR7zMBsMCLe54ILxAoqbzzQo4yAHtliNB
         qnjw==
X-Gm-Message-State: APjAAAWr6fRiWDACcBNrJ6FsmmVOdeAgMyd/hozTRUR8WW3+YTEyq85q
        y29f/Tgi/agoaMROcg4ePu7mbgyTOiMcR1GRnSs=
X-Google-Smtp-Source: APXvYqz5EAnxqCVqkhro1f4kNylY/XB/OfFij+EUoZijR4gyBVobpMjmJfsZql2hcaiETf9SC7lPZW+iS28TT4YZxqI=
X-Received: by 2002:a05:620a:391:: with SMTP id q17mr6894809qkm.16.1551896824136;
 Wed, 06 Mar 2019 10:27:04 -0800 (PST)
MIME-Version: 1.0
References: <20190228002725.57444-1-gwendal@chromium.org> <CAFqH_52tWw8pGwY5fdAPQ6npbfWA7o4OhtPxvbUbCh5TdnbSew@mail.gmail.com>
 <CABXOdTfqPKq34OVDmJ9qjTr0nqarhpN=f37m3xH9iuHxex+xrw@mail.gmail.com>
In-Reply-To: <CABXOdTfqPKq34OVDmJ9qjTr0nqarhpN=f37m3xH9iuHxex+xrw@mail.gmail.com>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Wed, 6 Mar 2019 19:26:52 +0100
Message-ID: <CAFqH_50ZQtbOqG+u9VLT8m=9jvv_XQsghUTCuySu-=vho6rLKw@mail.gmail.com>
Subject: Re: [PATCH] mfd: cros: Update EC protocol to match current EC code
To:     Guenter Roeck <groeck@google.com>
Cc:     Gwendal Grignou <gwendal@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Benson Leung <bleung@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

Missatge de Guenter Roeck <groeck@google.com> del dia dc., 6 de mar=C3=A7
2019 a les 18:20:
>
> [resending in plain text mode ]
>
> On Wed, Mar 6, 2019 at 8:57 AM Enric Balletbo Serra <eballetbo@gmail.com>=
 wrote:
> >
> > Hi Gwendal,
> >
> > Many thanks to send this upstream.
> >
> > Missatge de Gwendal Grignou <gwendal@chromium.org> del dia dj., 28 de
> > febr. 2019 a les 1:31:
> > >
> > > Chromebook Embedded Controller protocol is defined in the kernel at
> > > cros_ec_commands.h.
> > > The source of trust for the EC protocol is at
> > > https://chromium.googlesource.com/chromiumos/platform/ec/+/master/inc=
lude/ec_commands.h
> > >
> > > Only needed changes have been picked up from this file to the kernel
> > > include file leading to gaps between the upstream version and what th=
e
> > > latest ECs can do.
> > >
> > > Fill the gaps to ease future integrations. Changes from the original
> > > files is header/footer for license and include files for alignment.
> > >
> > > Check this include file works on ChomeOS kernel 4.14 and 4.19 on eve.
> > >
> > > Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> > > ---
> > >  include/linux/mfd/cros_ec_commands.h | 3627 +++++++++++++++++++++---=
--
> >
> > I'm wondering if we should move this file to include/uapi at some
> > point as this file is also used as user-space API for some userspace
> > applications.
> >
> > While we are here I'd suggest if we can also fix the few errors (3)
> > and warnings (5) spotted by checkpatch. With that it's an ack from my
> > side.
> >
> > Being strict, though, on most cases the variables are going to be used
> > in code that can be seen by user-space programs so maybe we should
> > really need to switch to __u8/__u16/etc exportable data types instead
> > of the uint8_t/uint16_t/etc types (those are not aimed to be used
> > within the kernel). For those types that are internal we should use
> > in-kernel type (u8/u16/etc)
> >
> > There is also the use of the BIT macro instead of the (1 << x), I know
> > that this is a maintainer preference.
> >
> Is all that even possible ?

Sorry, if I wasn't clear from my side, I should have marked those as
nit, as in this case, I don't really mind, but I remember Lee
requesting some of those changes for this file.

What I want to avoid is the desynchronization again. As this file
belongs to the MFD subsystem Lee needs to be happy with it or at least
know that we're not following the kernel style because is an imported
file (i.e not using the BIT macro, doing this example because I know
he takes care of this).

So I think that the main question here is if an imported file like
this is acceptable in the include/linux/mfd?

> After all, this is an imported file, and
> we don't usually expect that imported files meet the Linux kernel
> coding style.
>

I remember seeing somewhere that the EC code was following the Linux
kernel style? Now I am not able to find where.

Thanks,
 Enric

> Thanks,
> Guenter
>
> > [snip]
> >
> > Thanks,
> >  Enric
