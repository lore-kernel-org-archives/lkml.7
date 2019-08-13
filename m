Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACFF6C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 17:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DAA520663
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 17:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565717457;
	bh=Bk+/PhZhQeH7Oy2cW+sHt860DBgIyZ1zaTr/4b5mDZ8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=iUsGCbDyPSz1Ba8xWAMyDH5uFX7juEEl6uyqP5KYr7uIwmDduByfMw7yaO3gTC7Vl
	 l4hv6IoC7ktpeHNIIG/eAK2nSoICvhmCgq2gwT8lK1cP/9nTNK1Y/NjwNYu1UFq0kP
	 VD19ABIOuaPHUWOAeVAfQ0hVAmrVHn8aFkL8o8qo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbfHMRa4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 13:30:56 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33904 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726062AbfHMRaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 13:30:55 -0400
Received: by mail-lj1-f196.google.com with SMTP id x18so5851091ljh.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 10:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PcCwXVLm6QInE6f6YnLzxsQVruGBu70an/s0ARJn0xM=;
        b=PsN6mTRe/RPI2hT2jq/fSCvTqDjEFGZ58VoUAFieJsIyl3xqt3TIuHSf8o8ZiNpmaB
         Ccoio3Rt4D6J7p5XFf44/kwkyEnKxhdZ+A9Hq2HaJlzcOe8Y94fe/BnIESBWdVF3FuvO
         YDsGcpHsLNXUwszqTyIKxHV95Y4BEhzPOcmeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PcCwXVLm6QInE6f6YnLzxsQVruGBu70an/s0ARJn0xM=;
        b=JYj4AUzOPNFEablFm3OOwjSb6JvepB3/cS1EQx7pnLC2OKse0lAm4stWv/ct+BZ6vf
         i21+oNS7UG+c2lAKiDGZ3Eaak7zSvocQh5fi4KlswpYYZxoqTWsHlQvNaHEIHAB2vRUp
         PNsO0XbJ+H3BcnVdFV3dDTTF5cr1RvaB6b9MwdnxdmmzRdOIOByvtQFSZHwjoTM+/JYI
         EcpCbjQyWJNMGLS+6K9HRZ8Di7aW7mFVisufWQRNr90GgUPgXhNGTqFsy6VmHFqpTSGO
         9ovbyyD5sADWMvp2owb3ad6rLsFA0B3hK9Vh60Bwzupoqdu3VO4IUA1a5pT7tIwT19y8
         6/RQ==
X-Gm-Message-State: APjAAAXZLq6mNyk7ggo7tqFN69za5HZgRNr0kb91LTHp8lLqOMIvI3Gp
        KNzZTQQmxL7dzuGfzylabZmaO0ROOMU=
X-Google-Smtp-Source: APXvYqz4ByPdS0fx/sI4vD/+vbfW6/OLVvdlnVLJL4DPa23wLVTNmcmRESzbdd24Oo14N9cg011Tmg==
X-Received: by 2002:a2e:980d:: with SMTP id a13mr7705724ljj.145.1565717451898;
        Tue, 13 Aug 2019 10:30:51 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id c23sm377872ljj.69.2019.08.13.10.30.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Aug 2019 10:30:50 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id t14so47172lji.4
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 10:30:50 -0700 (PDT)
X-Received: by 2002:a2e:3a0e:: with SMTP id h14mr5710820lja.180.1565717449994;
 Tue, 13 Aug 2019 10:30:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a0VxM1BkjY1D2FfHi6L-ho_NH3v3+gBu45EfpjLF5NU5w@mail.gmail.com>
In-Reply-To: <CAK8P3a0VxM1BkjY1D2FfHi6L-ho_NH3v3+gBu45EfpjLF5NU5w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 13 Aug 2019 10:30:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiO2CWONDBud4nxoPgUJN1JEewFWhHa5wAqY8G5rrTXRQ@mail.gmail.com>
Message-ID: <CAHk-=wiO2CWONDBud4nxoPgUJN1JEewFWhHa5wAqY8G5rrTXRQ@mail.gmail.com>
Subject: Re: New kernel interface for sys_tz and timewarp?
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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

On Tue, Aug 13, 2019 at 2:06 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> * Should we allow setting the sys_tz on new architectures that use only
>   time64 interfaces at all, or should we try to get away from that anyway?

We should not do TZ on a kernel level at all. At least not a global
one. It makes no sense.

If the original TZ had been defined to have some sane model (perhaps
per session? Something like that), it would be worth doing. As it is,
a global TZ is just plain wrong. Per process would be sane (but
largely useless, I suspect).

> * Should the NTP timewarp setting ("int persistent_clock_is_local" and
>   its offset) be controllable separately from the timezone used in other
>   drivers?
>
> * If we want keep having a way to set the sys_tz, what interface
> should that use?

I suspect we need to have _some_ way to set the kernel TZ for legacy
reasons, but it should be deprecated and if we can make do without it
entirely on architectures where the legacy doesn't make sense, then
all the better.

I suspect the only actual _valid_ use in the kernel for a time zone
setting is likely for RTC clock setting, but even that isn't really
"global", as much as "per RTC".

That said, if glibc has some sane semantics for TZ, maybe the kernel
can help with that. But I assume/think that glibc uses (a) environment
variables and (b) a filesystem-set default (per-user file with a
system-wide default? I don't know what people do). I suspect the
kernel can't really do any better.

                Linus
