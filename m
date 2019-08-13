Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5217EC433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 20:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26F8320665
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 20:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfHMUEX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 16:04:23 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33696 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725944AbfHMUEX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 16:04:23 -0400
Received: by mail-qk1-f193.google.com with SMTP id r6so80760095qkc.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 13:04:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ama7Tg2aWhvE0NVoH4vqvv98NhGbGAzz1NVcfkHyItw=;
        b=BtogfYE6Ncz2eGiF/ANLEa9gwfZ3l20rrTX8/NSCjpuO837TMUkPGv05AZEUAw6dxW
         ZPUSDc4ZLLlYM4jm73lOM5wAHNScOnYPD6C24ySXIYH1+5dYBjp3GvyaWs6tTNJWxtmJ
         hB7u3qiISfF81oz0ZLCPbFYpIEhWn8x0ln4YdX7QBoDcjAWEnW7D9mYLjbM/P404i033
         szsSXg22IwJNj24BBaOlxHVTkOO57AqUsRgHKhAHnW7Jf+HyQYU2z8mXK+IO6K2DHUx1
         shR03fHkHMj8Elh8zp8lIDdBhtAsBGhDZL2Z8LNk1gmHEEnGfeeUjmbpWe2zQjhzW+8g
         OWkw==
X-Gm-Message-State: APjAAAVKiZMBgdCFfNc+58BPz0PgnIo7JxsEZaEAFmxuwUeK7wTyNHy0
        xmFatBwo4AbWa5AtoW6X5sAQ+BCOVj01D0Iiav8=
X-Google-Smtp-Source: APXvYqyrynY29BAMTciUypf5U8XfdwgfGM9arQl7rLqLL5xFK4w21YbUT/3AyNemkegtSRMaw64BooYqgX3gvHzdagQ=
X-Received: by 2002:a37:76c5:: with SMTP id r188mr35052600qkc.394.1565726662513;
 Tue, 13 Aug 2019 13:04:22 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a0VxM1BkjY1D2FfHi6L-ho_NH3v3+gBu45EfpjLF5NU5w@mail.gmail.com>
 <CAHk-=wiO2CWONDBud4nxoPgUJN1JEewFWhHa5wAqY8G5rrTXRQ@mail.gmail.com>
 <ecf2742a-6cab-cc00-16ab-589fad07b8db@cs.ucla.edu> <87tvakuak6.fsf@mid.deneb.enyo.de>
In-Reply-To: <87tvakuak6.fsf@mid.deneb.enyo.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 13 Aug 2019 22:04:05 +0200
Message-ID: <CAK8P3a13f7an3xkQcP7qcSR-yhp=wYMT_cJ9h7gEdB3Qk8chBw@mail.gmail.com>
Subject: Re: New kernel interface for sys_tz and timewarp?
To:     Florian Weimer <fw@deneb.enyo.de>
Cc:     Paul Eggert <eggert@cs.ucla.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        "Theodore Ts'o" <tytso@mit.edu>, "H. Peter Anvin" <hpa@zytor.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Alistair Francis <alistair.francis@wdc.com>,
        GNU C Library <libc-alpha@sourceware.org>,
        Karel Zak <kzak@redhat.com>,
        Lennart Poettering <lennart@poettering.net>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2019 at 9:31 PM Florian Weimer <fw@deneb.enyo.de> wrote:
> * Paul Eggert:
> > Linus Torvalds wrote:
> >> I assume/think that glibc uses (a) environment
> >> variables and (b) a filesystem-set default (per-user file with a
> >> system-wide default? I don't know what people do).
>
> > glibc relies on the TZ environment variable, with a system-wide
> > default specified in /etc/localtime or suchlike (there is no
> > per-user default). glibc ignores the kernel's 'struct timezone'
> > settings for of this, as 'struct timezone' is obsolete/vestigial and
> > doesn't contain enough info to do proper conversions anyway.
>
> I think the configuration value that settimeofday changes is not
> actually a time zone, but an time offset used to interpret various
> things, mostly in a dual-boot environment with Windows, apparently
> (Like the default time offset for extracting timetamps from FAT
> volumes.)
>
> This data has to come from *somewhere*.  The TZ variable and
> /etc/localtime cover something else entirely.

systemd and hwclock call localtime_r() when setting initial
system time an tz information at boot time, so that information
comes from /etc/localtime.

/etc/adjtime is used to determine whether to set warp the
time at boot and rtc update or not warp it.

      Arnd
