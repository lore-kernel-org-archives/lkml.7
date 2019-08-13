Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D281C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 21:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 27459206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 21:45:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726996AbfHMVp6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 17:45:58 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:43141 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbfHMVp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 17:45:57 -0400
X-Originating-IP: 90.65.161.137
Received: from localhost (lfbn-1-1545-137.w90-65.abo.wanadoo.fr [90.65.161.137])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id C9F8E60003;
        Tue, 13 Aug 2019 21:45:52 +0000 (UTC)
Date:   Tue, 13 Aug 2019 23:45:52 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     John Stultz <john.stultz@linaro.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Theodore Ts'o <tytso@mit.edu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Alistair Francis <alistair.francis@wdc.com>,
        GNU C Library <libc-alpha@sourceware.org>,
        Karel Zak <kzak@redhat.com>,
        Lennart Poettering <lennart@poettering.net>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: Re: New kernel interface for sys_tz and timewarp?
Message-ID: <20190813214552.GD3600@piout.net>
References: <CAK8P3a0VxM1BkjY1D2FfHi6L-ho_NH3v3+gBu45EfpjLF5NU5w@mail.gmail.com>
 <CALAqxLUde4OTEm3Kik0Fvydhp+i-Xo-axS2wRKEBJyT9hY=wCg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALAqxLUde4OTEm3Kik0Fvydhp+i-Xo-axS2wRKEBJyT9hY=wCg@mail.gmail.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/08/2019 10:10:53-0700, John Stultz wrote:
> On Tue, Aug 13, 2019 at 2:06 AM Arnd Bergmann <arnd@arndb.de> wrote:
> > Now, to the actual questions:
> >
> > * Should we allow setting the sys_tz on new architectures that use only
> >   time64 interfaces at all, or should we try to get away from that anyway?
> 
> So I'd probably cut this question a bit differently:
> 
> 1) Do we want to deprecate sys_tz tracking in the kernel? If new
> architectures don't have ways to set it, for consistency we should
> probably deprecate in-kernel tracking of that value (start returning
> an error when folks try to set it and always return 0 when its
> accessed).
> 
> 2) If we deprecate the sys_tz tracking in the kernel, how do we
> address the in-kernel systohc syncing with local-time (non-UTC) RTCs
> on x86 systems (I'm not aware of other arches that utilize non-UTC
> RTCs)
> 
> 
> > * Should the NTP timewarp setting ("int persistent_clock_is_local" and
> >   its offset) be controllable separately from the timezone used in other
> >   drivers?
> 
> For the discussion, I'm not sure I'd call this NTP timewarp, but maybe
> systohc rtc offset is more clear?
> 
> Its really not connected to NTP, except that we only want to
> automatically sync the RTC to the system clock when we know the system
> clock is right (and that signal comes from NTP).
> 

Well, the only function in systohc.c is rtc_set_ntp_time and its only
user is kernel/time/ntp.c. That why I suggested on IRC to move it to the
kernel timekeeping instead of having it in the rtc subsystem. Also, this
function only works properly on systems with an MC146818 compatible RTC.

> 
> > * If we want keep having a way to set the sys_tz, what interface
> > should that use?
> >
> >   Suggestions so far include
> >    - adding a clock_settimeofday_time64() syscall on all 32-bit architectures to
> >      maintain the traditional behavior,
> 
> If the answer to #1 above is no, we want to preserve the
> functionality, then I think this is probably the best solution.
> Alternatively one could add a new syscall/sysctrl that just sets the
> timezone, but most 64 bit architectures already have
> clock_settimeofday_time64() equiv call, so this is probably the least
> duplicative.
> 
> >    - adding a sysctl interface for accessing sys_tz.tz_tminuteswest,
> >    - using a new field in 'struct timex' for the timewarp offset, and
> 
> I'd push back on this one. The timewarp offset is really a RTC offset,
> and has nothing to do with ntp, so we shoudn't be adding things to
> adjtimex about it.
> 
> >    - adding an ioctl command on /dev/rtc/ to control the timewarp
> >      offset of that particular device.
> 
> If the answer to #1 above is yes, then I think this makes more sense
> to me, since the offset is a property of how we interpret the RTC (ie:
> is it UTC or local time).
> 

The main issue I have with that is that while the offset is possibly
specific to an RTC, it is something that is not used by the rtc
subsystem as this offset handling is done by the caller. i.e. hwclock
handles local time vs UTC time. That is why sync_rtc_clock also had to
do it. It would be awkward to have different paths in the rtc core
depending on whether the set_time call is coming from userspace or the
kernel.

> Getting more aggressive, from irc discussions, it sounded like
> Alexandre would like to deprecate the in-kernel systohc and hctosys
> logic, so if that were the case, and the answer to #1 above was yes,
> then we could probably skip all of this and just drop systohc work and
> keep the UTC/local logic to userland.
> 

My point is that userspace has all the necessary info to do a correct
job. It is even more flexible because currently the kernel is limited
to the rtc selected at compile time (this often ends up being rtc0 which
may or may not be functional or battery backed) and the 11 minute
interval is fixed.


-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
