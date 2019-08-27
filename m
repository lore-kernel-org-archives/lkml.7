Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2347C3A5A3
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 16:27:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A0E94214DA
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 16:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730292AbfH0Q1u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Aug 2019 12:27:50 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34537 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbfH0Q1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Aug 2019 12:27:49 -0400
Received: by mail-qk1-f196.google.com with SMTP id m10so17525968qkk.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2019 09:27:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3piUJp2MoC2ky9MeuOLHIQnHrz85ApEsVwyMMA5tACI=;
        b=g7ft7xk5da3j65wkJWSotyzNG19g52qNY7KdsZL2wkqLO9wePclzOhis8ixK4r0sN2
         LAac5fuo2NRFPHHI0gfcHahsuU2Hw0Tgb45HsNxgaE7PWtH7WBohjKALTrdqbOLZTyUF
         IFlvvQ2RgpgBQCeebPOxuc6+CUB4MtWYY6XN5kJNzn3l05n5Z7HmlNzjzoF8UF5dQPX5
         WPFtmqCqElbe70tvHlsOr7i/ZQIrzhUgw/NKquZk6dFsrP1UgaIfHBGyQ7P+VwkTalop
         dC0RMxEqdY/jm4IA5hBOAaSvwzT3bUodYo38bFxurkT5EGqvN9BC38kDMiQbcCPWITwV
         o+3A==
X-Gm-Message-State: APjAAAUB7IkTov/5oPBFCcGEWj4yZB8Ip5YDwL7KWplaNk8sbpk+noyG
        g5cGCLsYsUhw+qNK84YbCTw4GFypcNj2XIoYOSw=
X-Google-Smtp-Source: APXvYqwuYdvnwR9sEFMTO6qMRpJ+oTKsJGjfctTublzUJ92RtOfeuApb6wiSvhk+Hz1CgDqEVg9AqCgbxqtlDePcPes=
X-Received: by 2002:a37:4051:: with SMTP id n78mr21668760qka.138.1566923269072;
 Tue, 27 Aug 2019 09:27:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a0VxM1BkjY1D2FfHi6L-ho_NH3v3+gBu45EfpjLF5NU5w@mail.gmail.com>
 <CAHk-=wiO2CWONDBud4nxoPgUJN1JEewFWhHa5wAqY8G5rrTXRQ@mail.gmail.com>
 <20190814000622.GB20365@mit.edu> <CAK8P3a1CXRETxn6Gh_cOxM3rZ-wUwVDu-7=yEwjqOY=uEdC6OQ@mail.gmail.com>
 <20190814090936.GB10516@gardel-login> <20190814093208.GG3600@piout.net>
 <20190819110903.if3dzhvfnlqutn6s@ws.net.home> <20190820185830.GQ3545@piout.net>
In-Reply-To: <20190820185830.GQ3545@piout.net>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 27 Aug 2019 18:27:32 +0200
Message-ID: <CAK8P3a0EiP-LsKp1nFHgeRF09tQ0+5kPQd9JXBEKc1is30x3SA@mail.gmail.com>
Subject: Re: New kernel interface for sys_tz and timewarp?
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2019 at 8:58 PM Alexandre Belloni
<alexandre.belloni@bootlin.com> wrote:
>
> On 19/08/2019 13:09:03+0200, Karel Zak wrote:
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
> >
> > If I good remember than it's because synchronize userspace hwclock
> > with rtc is pretty fragile and frustrating. We have improved this
> > hwclock code many times and it will never be perfect. See for example
> > hwclock --delay= option, sometimes hwclock has no clue about RTC behaviour.
> >
>
> With a bit of care, we can reliably set the rtc to the system time from
> userspace. It takes a bit of time (up to 2 seconds) but it can be
> reliably set with an accuracy of a few ms on a slow system and an rtc on
> a slow bus or a few ns with a fast system and a fast bus.
> I know I did say I would implement it in hwclock and I still didn't
> (sorry) but we could do better than the --delay option.

Would you use the regular RTC_SET_TIME ioctl for that, or
add a new RTC_SYS_TO_HC command that takes an explicit
offset? It sounds to me that the synchronization bit (actually
waiting for the right moment to update the rtc registers) is better
done in the kernel, while the decision about the offset and when
to call into the driver is better done in user space.

     Arnd
