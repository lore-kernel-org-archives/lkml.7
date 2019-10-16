Return-Path: <SRS0=S2At=YJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CD8BFA372A
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 16:53:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21BC821835
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Oct 2019 16:53:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HeZJ0LsX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406520AbfJPQxe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Oct 2019 12:53:34 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:38834 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406479AbfJPQxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Oct 2019 12:53:33 -0400
Received: by mail-lf1-f66.google.com with SMTP id u28so18076518lfc.5
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2019 09:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tNeMRNIfdjHwkdsyXewzfu5Z/8d+Ipu1WBE/Nji2j6o=;
        b=HeZJ0LsXW7mmUON1V5xmhDSncNZB6lkZZK/aQWqiaeWfoLceQmVHBsDrCPQSNheJR8
         IlGmQI4GJ0a3KeeFkLuB74++cbk9zF0MDCMgauIVVv0MwlsN3fCAwETly3Hs6g4/FkHw
         iEk8N0MQZJH+hJFBo2HVA6OtUhJMuYfZ5sPusj5OQxOppuNXZYOgYxDnB9MIBb3gxyzH
         1icSwpBDJK0X2hCL65Fadnjyq+4tckml3p2rGvN2a9MV48WAFf+YIo2fnTLKfDbQ6ASd
         XuEN3r0BA457vpI/RA+I/+JpNL3X/U4hmzV6WfI7z2bL2ECB+9Oj+VZvzNfX+X+uijTK
         m2Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tNeMRNIfdjHwkdsyXewzfu5Z/8d+Ipu1WBE/Nji2j6o=;
        b=AsV1blh07LKRzdGKlHGA3s8wY/3Nx80q2WR+iDI/caPTnLXQ16y46+MpDAj2N+xuJN
         inu1RJCmP918bVhFWZ6Gun5a2drMk5jZAXm2LItxybWNk+3xNdHyq/57xap9JhOMQdQc
         REVQ4jJxJplVamUnyjZMqa60hjG3OmqwwTeWXEGELq+Sh/7Z95b4MwHzCRYKzVACUvSN
         cIM9xFXhSlr6vSPqUBVxxeWqzNqn2GpN7qKn//PFUgzAVjfbJ66dRFL3EsQJHfIzkkvQ
         j6fQuA3tnvHup1+K1oXRnArgZpzH8xjwWyg7eXJgVAQneq+pIzYMZeOmnA419lF7wVaD
         B43g==
X-Gm-Message-State: APjAAAVzIgAKo09KHLyGjIcNpA4vTQS54kag2ldFQi1hu+tcOlNdKt5T
        TJAeZEWfhm/ZCXdQxeUpWkEVrPmZ//eYetFk/Fk=
X-Google-Smtp-Source: APXvYqwMseb7aiO3tFfsZ84aQ9dmGeiDkv2eggWi2RKvGK2efG0A11Ujp0LulqKpVQBfYEFHkesdEqqpegAgmnEE75E=
X-Received: by 2002:a19:6e0a:: with SMTP id j10mr9861743lfc.131.1571244811925;
 Wed, 16 Oct 2019 09:53:31 -0700 (PDT)
MIME-Version: 1.0
References: <20191016082430.5955-1-poeschel@lemonage.de>
In-Reply-To: <20191016082430.5955-1-poeschel@lemonage.de>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 16 Oct 2019 18:53:20 +0200
Message-ID: <CANiq72=uXWpEWHixM+wwyxZfzQ41WYvQsoV8B3+JLRharDjC0w@mail.gmail.com>
Subject: Re: [PATCH 1/3] auxdisplay: Make charlcd.[ch] more general
To:     Lars Poeschel <poeschel@lemonage.de>
Cc:     Willy Tarreau <willy@haproxy.com>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 10:24 AM Lars Poeschel <poeschel@lemonage.de> wrote:
>
> charlcd.c contains lots of hd44780 hardware specific stuff. It is nearly
> impossible to reuse the interface for other character based displays.
> The current users of charlcd are the hd44780 and the panel drivers.
> This does factor out the hd44780 specific stuff out of charlcd into a
> new module called hd44780_common.
> charlcd gets rid of the hd44780 specfics and more generally useable.
> The hd44780 and panel drivers are modified to use the new
> hd44780_common.
> This is tested on a hd44780 connected through the gpios of a pcf8574.
>
> Signed-off-by: Lars Poeschel <poeschel@lemonage.de>
> ---
>  drivers/auxdisplay/Kconfig          |  16 +
>  drivers/auxdisplay/Makefile         |   1 +
>  drivers/auxdisplay/charlcd.c        | 591 ++++++++--------------------
>  drivers/auxdisplay/charlcd.h        | 109 ++++-
>  drivers/auxdisplay/hd44780.c        | 121 ++++--
>  drivers/auxdisplay/hd44780_common.c | 370 +++++++++++++++++
>  drivers/auxdisplay/hd44780_common.h |  32 ++
>  drivers/auxdisplay/panel.c          | 178 ++++-----
>  8 files changed, 851 insertions(+), 567 deletions(-)

Thanks Lars, CC'ing Geert since he wrote a large portion of this, as
well as Andy.

From a cursory look (sorry, not doing it inline since it is a pain to
edit in this UI given the size...):
  * panel.c doesn't compile since lcd_backlight's return type did not
get updated, which makes me uneasy. I am not sure why you changed the
return type anyway, since callers ignore it and callees always return
0.
  * Declared and then immediately defined hd44780_common in the header...?
  * Some things (e.g. the addition of enums like charlcd_onoff) seem
like could have been done other patches (since they are not really
related to the reorganization).
  * From checkpatch.pl: DOS line endings and trailing whitespace

I am not capable of testing this, so extra testing by anyone who has
the different hardware affected around is very welcome.

Cheers,
Miguel
