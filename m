Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC0F8C3A59D
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 11:09:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 913632082A
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 11:09:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbfHSLJK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 07:09:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41452 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726477AbfHSLJK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 07:09:10 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 4D91E3D96D;
        Mon, 19 Aug 2019 11:09:09 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.205.174])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BB33227C41;
        Mon, 19 Aug 2019 11:09:05 +0000 (UTC)
Date:   Mon, 19 Aug 2019 13:09:03 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Lennart Poettering <mzxreary@0pointer.de>,
        Arnd Bergmann <arnd@arndb.de>,
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
Message-ID: <20190819110903.if3dzhvfnlqutn6s@ws.net.home>
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
User-Agent: NeoMutt/20180716-1584-710bcd
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Mon, 19 Aug 2019 11:09:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2019 at 11:32:08AM +0200, Alexandre Belloni wrote:
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

Good point, why CONFIG_RTC_SYSTOHC has been added to the kernel? 

If I good remember than it's because synchronize userspace hwclock 
with rtc is pretty fragile and frustrating. We have improved this
hwclock code many times and it will never be perfect. See for example
hwclock --delay= option, sometimes hwclock has no clue about RTC behaviour.
 
> It does it trivially and badly:
> 
>  -  hctosys will always think the RTC is in UTC so if the RTC is in
>     local time, you will anyway have up to 12 hours difference until
> userspace fixes that.

Cannot we provide all necessary information for example on kernel
command line, or/and as rtc module option?

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
