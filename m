Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 661FDC3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 16:31:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41A58214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 16:31:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730232AbfH0Qbn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 12:31:43 -0400
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:40221 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726539AbfH0Qbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 12:31:42 -0400
X-Originating-IP: 86.207.98.53
Received: from localhost (aclermont-ferrand-651-1-259-53.w86-207.abo.wanadoo.fr [86.207.98.53])
        (Authenticated sender: alexandre.belloni@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id CFBC124000E;
        Tue, 27 Aug 2019 16:31:37 +0000 (UTC)
Date:   Tue, 27 Aug 2019 18:31:34 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Karel Zak <kzak@redhat.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
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
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: Re: New kernel interface for sys_tz and timewarp?
Message-ID: <20190827163134.GC21922@piout.net>
References: <CAK8P3a0VxM1BkjY1D2FfHi6L-ho_NH3v3+gBu45EfpjLF5NU5w@mail.gmail.com>
 <CAHk-=wiO2CWONDBud4nxoPgUJN1JEewFWhHa5wAqY8G5rrTXRQ@mail.gmail.com>
 <20190814000622.GB20365@mit.edu>
 <CAK8P3a1CXRETxn6Gh_cOxM3rZ-wUwVDu-7=yEwjqOY=uEdC6OQ@mail.gmail.com>
 <20190814090936.GB10516@gardel-login>
 <20190814093208.GG3600@piout.net>
 <20190819110903.if3dzhvfnlqutn6s@ws.net.home>
 <20190820185830.GQ3545@piout.net>
 <CAK8P3a0EiP-LsKp1nFHgeRF09tQ0+5kPQd9JXBEKc1is30x3SA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0EiP-LsKp1nFHgeRF09tQ0+5kPQd9JXBEKc1is30x3SA@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/08/2019 18:27:32+0200, Arnd Bergmann wrote:
> On Tue, Aug 20, 2019 at 8:58 PM Alexandre Belloni
> <alexandre.belloni@bootlin.com> wrote:
> >
> > On 19/08/2019 13:09:03+0200, Karel Zak wrote:
> > > On Wed, Aug 14, 2019 at 11:32:08AM +0200, Alexandre Belloni wrote:
> > > > On 14/08/2019 11:09:36+0200, Lennart Poettering wrote:
> > > > > On Mi, 14.08.19 10:31, Arnd Bergmann (arnd@arndb.de) wrote:
> > > > >
> > > > > > - glibc stops passing the caller timezone argument to the kernel
> > > > > > - the distro kernel disables CONFIG_RTC_HCTOSYS,
> > > > > >   CONFIG_RTC_SYSTOHC  and CONFIG_GENERIC_CMOS_UPDATE
> > > > >
> > > > > What's the benefit of letting userspace do this? It sounds a lot more
> > > > > fragile to leave this syncing to userspace if the kernel can do this
> > > > > trivially on its own.
> > >
> > > Good point, why CONFIG_RTC_SYSTOHC has been added to the kernel?
> > >
> > > If I good remember than it's because synchronize userspace hwclock
> > > with rtc is pretty fragile and frustrating. We have improved this
> > > hwclock code many times and it will never be perfect. See for example
> > > hwclock --delay= option, sometimes hwclock has no clue about RTC behaviour.
> > >
> >
> > With a bit of care, we can reliably set the rtc to the system time from
> > userspace. It takes a bit of time (up to 2 seconds) but it can be
> > reliably set with an accuracy of a few ms on a slow system and an rtc on
> > a slow bus or a few ns with a fast system and a fast bus.
> > I know I did say I would implement it in hwclock and I still didn't
> > (sorry) but we could do better than the --delay option.
> 
> Would you use the regular RTC_SET_TIME ioctl for that, or
> add a new RTC_SYS_TO_HC command that takes an explicit
> offset? It sounds to me that the synchronization bit (actually
> waiting for the right moment to update the rtc registers) is better
> done in the kernel, while the decision about the offset and when
> to call into the driver is better done in user space.
> 

The existing ioctls are fine to do that, see:
https://git.kernel.org/pub/scm/linux/kernel/git/abelloni/rtc-tools.git/tree/rtc-sync.c

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
