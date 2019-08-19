Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B59C3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 13:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B50A2082C
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 13:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbfHSNt3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 09:49:29 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47321 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbfHSNt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 09:49:29 -0400
Received: from [5.158.153.52] (helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1hzi2G-0004rQ-VG; Mon, 19 Aug 2019 15:49:25 +0200
Date:   Mon, 19 Aug 2019 15:49:24 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Karel Zak <kzak@redhat.com>
cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        Arnd Bergmann <arnd@arndb.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Alistair Francis <alistair.francis@wdc.com>,
        GNU C Library <libc-alpha@sourceware.org>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: Re: New kernel interface for sys_tz and timewarp?
In-Reply-To: <alpine.DEB.2.21.1908191541340.2147@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1908191548150.2147@nanos.tec.linutronix.de>
References: <CAK8P3a0VxM1BkjY1D2FfHi6L-ho_NH3v3+gBu45EfpjLF5NU5w@mail.gmail.com> <CAHk-=wiO2CWONDBud4nxoPgUJN1JEewFWhHa5wAqY8G5rrTXRQ@mail.gmail.com> <20190814000622.GB20365@mit.edu> <CAK8P3a1CXRETxn6Gh_cOxM3rZ-wUwVDu-7=yEwjqOY=uEdC6OQ@mail.gmail.com>
 <20190814090936.GB10516@gardel-login> <20190814093208.GG3600@piout.net> <20190819110903.if3dzhvfnlqutn6s@ws.net.home> <alpine.DEB.2.21.1908191541340.2147@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 19 Aug 2019, Thomas Gleixner wrote:
> On Mon, 19 Aug 2019, Karel Zak wrote:
> > On Wed, Aug 14, 2019 at 11:32:08AM +0200, Alexandre Belloni wrote:
> > > On 14/08/2019 11:09:36+0200, Lennart Poettering wrote:
> > > > On Mi, 14.08.19 10:31, Arnd Bergmann (arnd@arndb.de) wrote:
> > > > 
> > > > > - glibc stops passing the caller timezone argument to the kernel
> > > > > - the distro kernel disables CONFIG_RTC_HCTOSYS,
> > > > >   CONFIG_RTC_SYSTOHC  and CONFIG_GENERIC_CMOS_UPDATE
> > > > 
> > > > What's the benefit of letting userspace do this? It sounds a lot more
> > > > fragile to leave this syncing to userspace if the kernel can do this
> > > > trivially on its own.
> > 
> > Good point, why CONFIG_RTC_SYSTOHC has been added to the kernel? 
> 
> 023f333a99ce ("NTP: Add a CONFIG_RTC_SYSTOHC configuration")

Just for the record. Not a single defconfig enables, but it's selected by
SPARC for whatever reason.

Thanks,

	tglx

