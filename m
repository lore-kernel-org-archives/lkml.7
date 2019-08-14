Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F927C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 08:31:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DA9220843
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 08:31:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbfHNIbv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 04:31:51 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42444 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725265AbfHNIbv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 04:31:51 -0400
Received: by mail-qt1-f195.google.com with SMTP id t12so20700427qtp.9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2019 01:31:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Ynk/jW9Vb1735IlArNmWYpmV/2cD+KS6CksYAP1WBT4=;
        b=SY23sl4IGAtBV5QPu/2oyisqHhCbve4erfv9734frddPxYTNP48+MnVB7tjSW/PBSR
         vNZlYQmkNm8M/SvxNZ4FmjkZxZqCwwLuwS2L0dbxdNhZawxr72R05sNWVrABffQB8YHq
         QzXil9WtoJr6PBZuH1RYAgBIJ+sAYplqEAwkLXg11uMtRik5mQLMCsVO4KpcrHjwAKmI
         W4Yh+t/KOQmEWscDn+9s/wR+TkenK67nqYAHcD7JlqyMyriyaBULKlhOE/BObp7lXMVZ
         csUE2CJWmi7KP2wD9uwtrkSgIKtWV0uwtKxpX6JqHfL2lpo/3DCTwycaWHNU47sKZjfm
         DfGw==
X-Gm-Message-State: APjAAAUaXORkmUmGgUaTRTwk7VIEM1LF72RBdBx6kDIKCLe4T2kwF4Kk
        d/xmkT1rvUK9GWKAcQmLszZ6yDB0uMZxeSHJrec=
X-Google-Smtp-Source: APXvYqxfiAEJ1NSovRCpZIxSvWc5sEsLpBMye8i2PaF25oymSkZwmjEhvJiD5cBJF8SwZsk4KB7f9ZBnEpMlwDwX0mc=
X-Received: by 2002:ac8:239d:: with SMTP id q29mr8243044qtq.304.1565771509953;
 Wed, 14 Aug 2019 01:31:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a0VxM1BkjY1D2FfHi6L-ho_NH3v3+gBu45EfpjLF5NU5w@mail.gmail.com>
 <CAHk-=wiO2CWONDBud4nxoPgUJN1JEewFWhHa5wAqY8G5rrTXRQ@mail.gmail.com> <20190814000622.GB20365@mit.edu>
In-Reply-To: <20190814000622.GB20365@mit.edu>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 14 Aug 2019 10:31:33 +0200
Message-ID: <CAK8P3a1CXRETxn6Gh_cOxM3rZ-wUwVDu-7=yEwjqOY=uEdC6OQ@mail.gmail.com>
Subject: Re: New kernel interface for sys_tz and timewarp?
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
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

On Wed, Aug 14, 2019 at 2:06 AM Theodore Y. Ts'o <tytso@mit.edu> wrote:
> On Tue, Aug 13, 2019 at 10:30:34AM -0700, Linus Torvalds wrote:
> >
> > I suspect the only actual _valid_ use in the kernel for a time zone
> > setting is likely for RTC clock setting, but even that isn't really
> > "global", as much as "per RTC".
>
> As I recall (and I may or may not have been original for the original
> sys_tz; it was many years ago, and my memories of 1992 are a bit
> fuzzy) the only reason why we added it was because x86 systems that
> were dual-booting with Windows had a RTC which ticked localtime, and
> originally, the system time was fetched from the RTC in early boot,
> and then when the timezone was set, the time would be warped so it
> would be correct.

I think this was the case from 1992 to commit 84e345e4e209 ("time,
Fix setting of hardware clock in NTP code") in 2013, when we started
taking the time warp into account during the periodic sync_cmos_clock()
call from kernel/time/ntp.c.

> Trying to use this for anything else is probably a bad idea, and in a
> world where we can have initrd's and reading the RTC gets done by
> userspace as opposed to kernel, it probably doesn't make any sence to
> keep it.

As Alexandre keeps pointing out, we really ought to do this from user
space, but in systemd today still relies on the kernel setting the
initial time using CONFIG_RTC_HCTOSYS, but this breaks e.g.
when the rtc driver itself is a loadable module.

From what I understand it would be easy for systemd to sync the
rtc to system time at boot and let distros disable CONFIG_RTC_HCTOSYS,
but it still has to do the initial settimeofday(NULL, tz) call to
ensure the correct offset is used for sync_hw_clock() in case
CONFIG_GENERIC_CMOS_UPDATE or CONFIG_RTC_SYSTOHC
are set (which they tend to be at the moment).

In the long run, a distro can decide to avoid this all, once these
bits come together:

- glibc stops passing the caller timezone argument to the kernel
- the distro kernel disables CONFIG_RTC_HCTOSYS,
  CONFIG_RTC_SYSTOHC  and CONFIG_GENERIC_CMOS_UPDATE
- systemd reads the RTC at boot and sets the system
  time according to the configuration in /etc/localtime and /etc/adjtime
- systemd, ntp or something else in user space takes care of the periodic
  rtc update, again taking configuration into account.

When someone mixes today's glibc/systemd/kernel with other
components past that migration, things can go wrong somewhat
annoying but non-fatal ways:
- Users that dual-boot with windows may have to force Windows
  to set the RTC to UTC mode rather than setting Linux to
  localtime.
- if neither the kernel not user space do the periodic RTC update,
  it may be out of sync and cause a larger time jump after the
  next boot time ntp synchronization

Creating a kernel interface for systemd to see or contol how the
11-minute update is done in the kernel would help part of that
transition.

      Arnd
