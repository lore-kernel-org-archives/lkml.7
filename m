Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1226CC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 12:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E105720644
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 12:15:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727643AbfHNMPL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 08:15:11 -0400
Received: from gardel.0pointer.net ([85.214.157.71]:35000 "EHLO
        gardel.0pointer.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbfHNMPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 08:15:10 -0400
Received: from gardel-login.0pointer.net (gardel.0pointer.net [85.214.157.71])
        by gardel.0pointer.net (Postfix) with ESMTP id 3A57BE80937;
        Wed, 14 Aug 2019 14:15:08 +0200 (CEST)
Received: by gardel-login.0pointer.net (Postfix, from userid 1000)
        id D325A160102; Wed, 14 Aug 2019 14:15:07 +0200 (CEST)
Date:   Wed, 14 Aug 2019 14:15:07 +0200
From:   Lennart Poettering <mzxreary@0pointer.de>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, "Theodore Y. Ts'o" <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Alistair Francis <alistair.francis@wdc.com>,
        GNU C Library <libc-alpha@sourceware.org>,
        Karel Zak <kzak@redhat.com>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: Re: New kernel interface for sys_tz and timewarp?
Message-ID: <20190814121507.GB10706@gardel-login>
References: <CAK8P3a0VxM1BkjY1D2FfHi6L-ho_NH3v3+gBu45EfpjLF5NU5w@mail.gmail.com>
 <CAHk-=wiO2CWONDBud4nxoPgUJN1JEewFWhHa5wAqY8G5rrTXRQ@mail.gmail.com>
 <20190814000622.GB20365@mit.edu>
 <CAK8P3a1CXRETxn6Gh_cOxM3rZ-wUwVDu-7=yEwjqOY=uEdC6OQ@mail.gmail.com>
 <20190814090936.GB10516@gardel-login>
 <20190814093208.GG3600@piout.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190814093208.GG3600@piout.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mi, 14.08.19 11:32, Alexandre Belloni (alexandre.belloni@bootlin.com) wrote:

> On 14/08/2019 11:09:36+0200, Lennart Poettering wrote:
> > On Mi, 14.08.19 10:31, Arnd Bergmann (arnd@arndb.de) wrote:
> >
> > > - glibc stops passing the caller timezone argument to the kernel
> > > - the distro kernel disables CONFIG_RTC_HCTOSYS,
> > >   CONFIG_RTC_SYSTOHC  and CONFIG_GENERIC_CMOS_UPDATE
> >
> > What's the benefit of letting userspace do this? It sounds a lot more
> > fragile to leave this syncing to userspace if the kernel can do this
> > trivially on its own.
> >
>
> It does it trivially and badly:
>
>  -  hctosys will always think the RTC is in UTC so if the RTC is in
>     local time, you will anyway have up to 12 hours difference until
> userspace fixes that.

Sure, but 12h off is not that bad, much better than being 39years
off. Moreover, it's off only for those who actually dual boot Windows
and make use of the RTC-in-local-time functionality. For them having
the time slightly off during early boot is not great but also not
totally afwul, and the whole concept of RTC-in-local-time is not that
great anyway. It's not a reason to penalize everybody else who has the
RTC in UTC, as they should.

>  - the RTC to be used for hctosys and systohc is hardcoded in Kconfig
>    and distro usually let the default rtc0 but many platforms have a non
> functional RTC that ends up being rtc0. I would prefer that to be a
> userspace configuration change instead of a kernel configuration
>    change

Well, but how do you think userspace would figure out which RTC to use
in a way the kernel couldn't do equally well or better?

On PCs at least it's very clear which RTC driver is the right one. And
if non-PC hardware comes with borked RTC hw then it's probably a good
idea not to compile support for such RTCs into the kernel in the first
place...

I know that there are some environments where RTC devices are compiled
as modules. But that means they are loaded relatively late during the
boot process, i.e. at a time where udevd is started and triggers all
busses, but that's *very* late in most cases, and it woud suck
having timestamps in early-boot logs that are 39y off until that
point.

I'd argue that in the vast majority of cases the person building the
kernel for a device knows very well which RTC is connected to the
device they are interested in, and should just build that driver in,
and don't bother with userspace complexity, later userspace module
loading or anything like that.

Lennart

--
Lennart Poettering, Berlin
