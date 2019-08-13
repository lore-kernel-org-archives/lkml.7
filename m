Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B13C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 21:56:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB2482067D
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 21:56:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfHMV4U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 17:56:20 -0400
Received: from relay8-d.mail.gandi.net ([217.70.183.201]:47889 "EHLO
        relay8-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbfHMV4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 17:56:20 -0400
X-Originating-IP: 90.65.161.137
Received: from localhost (lfbn-1-1545-137.w90-65.abo.wanadoo.fr [90.65.161.137])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay8-d.mail.gandi.net (Postfix) with ESMTPSA id D4C101BF209;
        Tue, 13 Aug 2019 21:56:15 +0000 (UTC)
Date:   Tue, 13 Aug 2019 23:56:15 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Theodore Ts'o <tytso@mit.edu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Alistair Francis <alistair.francis@wdc.com>,
        GNU C Library <libc-alpha@sourceware.org>,
        Karel Zak <kzak@redhat.com>,
        Lennart Poettering <lennart@poettering.net>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: Re: New kernel interface for sys_tz and timewarp?
Message-ID: <20190813215615.GE3600@piout.net>
References: <CAK8P3a0VxM1BkjY1D2FfHi6L-ho_NH3v3+gBu45EfpjLF5NU5w@mail.gmail.com>
 <CAHk-=wiO2CWONDBud4nxoPgUJN1JEewFWhHa5wAqY8G5rrTXRQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiO2CWONDBud4nxoPgUJN1JEewFWhHa5wAqY8G5rrTXRQ@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/08/2019 10:30:34-0700, Linus Torvalds wrote:
> On Tue, Aug 13, 2019 at 2:06 AM Arnd Bergmann <arnd@arndb.de> wrote:
> >
> > * Should we allow setting the sys_tz on new architectures that use only
> >   time64 interfaces at all, or should we try to get away from that anyway?
> 
> We should not do TZ on a kernel level at all. At least not a global
> one. It makes no sense.
> 
> If the original TZ had been defined to have some sane model (perhaps
> per session? Something like that), it would be worth doing. As it is,
> a global TZ is just plain wrong. Per process would be sane (but
> largely useless, I suspect).
> 
> > * Should the NTP timewarp setting ("int persistent_clock_is_local" and
> >   its offset) be controllable separately from the timezone used in other
> >   drivers?
> >
> > * If we want keep having a way to set the sys_tz, what interface
> > should that use?
> 
> I suspect we need to have _some_ way to set the kernel TZ for legacy
> reasons, but it should be deprecated and if we can make do without it
> entirely on architectures where the legacy doesn't make sense, then
> all the better.
> 
> I suspect the only actual _valid_ use in the kernel for a time zone
> setting is likely for RTC clock setting, but even that isn't really
> "global", as much as "per RTC".
> 

Userspace doesn't need help from the kernel to set the RTC using local
time if necessary, this info is in /etc/adjtime and hwclock uses it
correctly. It is only needed when the kernel sets the rtc time 

> That said, if glibc has some sane semantics for TZ, maybe the kernel
> can help with that. But I assume/think that glibc uses (a) environment
> variables and (b) a filesystem-set default (per-user file with a
> system-wide default? I don't know what people do). I suspect the
> kernel can't really do any better.
> 
>                 Linus

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
