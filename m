Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3502C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 17:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 94FEC20840
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 17:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M3QsG5uB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727101AbfHMRLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 13:11:07 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:36360 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726298AbfHMRLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 13:11:06 -0400
Received: by mail-wr1-f66.google.com with SMTP id r3so14718611wrt.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 10:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=21RkXx6R3GQDrR2TjCOw5Y6zUcvqwwn5X36NDyY9IGA=;
        b=M3QsG5uBdUAuYCJmjgUqL7PLM8GNt0QTYmfqU57XtJrC/nyx8IrUHSdvTi4iexA1sX
         loPorAFak91PNqBo4JqbP4kg1cs7x3HL3YJtyO8ty8l155jnxA2ujDYhS9RmlwLlrWEv
         5mh9EnmZ6cYx3cbAXsaPxhn2SJlsMJCHhVcEOvnyCkloSyEEW2GRtwZDolkmECBpTwlY
         KbDnIJvcADo9kBpTIvHAmzm0H/qEPnY/eGLXJDK09WQuEba0D3uIPUAz3/Frp6zGxrSZ
         8FZDGh4xZvJAQDZCBB0+f+gUPK8y+2z19tEOLMjciOIK2wUns1qcj/cf8NnB/THInnun
         8WWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=21RkXx6R3GQDrR2TjCOw5Y6zUcvqwwn5X36NDyY9IGA=;
        b=TZpDOtAxQIj3GxUm4Od1gu1/QgUdmWpj73OQ6SN/wDtM2kMTcan3Ci0illbX8LUenJ
         1gr7gWZ7UcU+I72SzwCIAWuLdMdWQ2iNHxVHQnZa91E/i4F6bVVcwa534b+zjO6KtcjY
         JqlNnbU4ojwXZWS1IJWmfx/DRk9bm6Brx7BVG6sdunhfIRra2MIWdtyAEpfl5gQJKiP4
         9UjIU0FJ/wVO6aLlOBf5OuRifrSoTbUl7otUHTUMef8bxcHVlSy17EMZ95fFQrN+2D2M
         jhZfAORp5QabTTSU1m6KaS2XU0CFP/PJ3/sZKxuBvyMLFot4sAy9tlZqwg9YOOjgihuM
         PotQ==
X-Gm-Message-State: APjAAAVu6Qo1vmnoriifIQ2TRBqEapOSmFR2iRhsJPvxvucCPcOQPPXw
        oMaS0/5CG0GZs5r9rHDsH4uLlEdswk1FvW7V7/S7mA==
X-Google-Smtp-Source: APXvYqzjDFccoFO2mqXij8jWkci8wYnJ1b/+SDrh1fyGfofH/xTWjFwC9cQZ90IWHFUAEUa2hu1TFIDjWrGaX7esF8c=
X-Received: by 2002:adf:ed4a:: with SMTP id u10mr50841803wro.284.1565716264841;
 Tue, 13 Aug 2019 10:11:04 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a0VxM1BkjY1D2FfHi6L-ho_NH3v3+gBu45EfpjLF5NU5w@mail.gmail.com>
In-Reply-To: <CAK8P3a0VxM1BkjY1D2FfHi6L-ho_NH3v3+gBu45EfpjLF5NU5w@mail.gmail.com>
From:   John Stultz <john.stultz@linaro.org>
Date:   Tue, 13 Aug 2019 10:10:53 -0700
Message-ID: <CALAqxLUde4OTEm3Kik0Fvydhp+i-Xo-axS2wRKEBJyT9hY=wCg@mail.gmail.com>
Subject: Re: New kernel interface for sys_tz and timewarp?
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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

On Tue, Aug 13, 2019 at 2:06 AM Arnd Bergmann <arnd@arndb.de> wrote:
> Now, to the actual questions:
>
> * Should we allow setting the sys_tz on new architectures that use only
>   time64 interfaces at all, or should we try to get away from that anyway?

So I'd probably cut this question a bit differently:

1) Do we want to deprecate sys_tz tracking in the kernel? If new
architectures don't have ways to set it, for consistency we should
probably deprecate in-kernel tracking of that value (start returning
an error when folks try to set it and always return 0 when its
accessed).

2) If we deprecate the sys_tz tracking in the kernel, how do we
address the in-kernel systohc syncing with local-time (non-UTC) RTCs
on x86 systems (I'm not aware of other arches that utilize non-UTC
RTCs)


> * Should the NTP timewarp setting ("int persistent_clock_is_local" and
>   its offset) be controllable separately from the timezone used in other
>   drivers?

For the discussion, I'm not sure I'd call this NTP timewarp, but maybe
systohc rtc offset is more clear?

Its really not connected to NTP, except that we only want to
automatically sync the RTC to the system clock when we know the system
clock is right (and that signal comes from NTP).


> * If we want keep having a way to set the sys_tz, what interface
> should that use?
>
>   Suggestions so far include
>    - adding a clock_settimeofday_time64() syscall on all 32-bit architectures to
>      maintain the traditional behavior,

If the answer to #1 above is no, we want to preserve the
functionality, then I think this is probably the best solution.
Alternatively one could add a new syscall/sysctrl that just sets the
timezone, but most 64 bit architectures already have
clock_settimeofday_time64() equiv call, so this is probably the least
duplicative.

>    - adding a sysctl interface for accessing sys_tz.tz_tminuteswest,
>    - using a new field in 'struct timex' for the timewarp offset, and

I'd push back on this one. The timewarp offset is really a RTC offset,
and has nothing to do with ntp, so we shoudn't be adding things to
adjtimex about it.

>    - adding an ioctl command on /dev/rtc/ to control the timewarp
>      offset of that particular device.

If the answer to #1 above is yes, then I think this makes more sense
to me, since the offset is a property of how we interpret the RTC (ie:
is it UTC or local time).

Getting more aggressive, from irc discussions, it sounded like
Alexandre would like to deprecate the in-kernel systohc and hctosys
logic, so if that were the case, and the answer to #1 above was yes,
then we could probably skip all of this and just drop systohc work and
keep the UTC/local logic to userland.

thanks
-john
