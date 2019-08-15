Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92DA1C3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 13:23:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EBA22084D
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 13:23:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732265AbfHONXC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 09:23:02 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:42890 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732232AbfHONXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 09:23:02 -0400
Received: by mail-qk1-f196.google.com with SMTP id 201so1756277qkm.9
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 06:23:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zjZjZbcIgFSCeXCzJ3fYgRDZYWhQcWjEsXASi7XjuhE=;
        b=Ujha+GTSN9wSbkeXUZcytL8asRv/37j3UhG2TNmmmmBiWXV6TAIz6yfZOpAx1uycWn
         H2HDiVJe+yPYBjuwgMUoNJhWVJdRPhVpJXGSjQN8kYAII6kRisLHOcAEDALU2Ktq4ox2
         a+6q/E/vUvlg6WUXMlec6IYz4MmCNqhPVbOmii+OM2KnRft5JsNz31GqKCfbCBUMfdvx
         qCrpCfWlREj/ftctWvs7LL8vdAIOMnAEm5c6BUOeAgiiSr3EJ5WaSADvlCQl5xHpgVbr
         bVX+6p/cUYnpjM8g385rxxNUdh6+nXMiZ6FGK5qllMAjzW30LB7seDC5sJuY++as08Wt
         najw==
X-Gm-Message-State: APjAAAX+LW1UuuDxpe+YE2XTli8DXytz96Zz2e/NHbflnZPlUNJ/E1Y4
        7Q5XJjB2KJI+o9RCH6wjubWF7sXK48Zf1GkqN+I=
X-Google-Smtp-Source: APXvYqzuSLeBCI+HvzvpFRIcxJxjmf/ZhX0lRJs9nE5xP9Unda7tZqAQLINwD9qn11ufptgjV7C7pLyVYeFGA3ESdz8=
X-Received: by 2002:a37:4ac3:: with SMTP id x186mr3920539qka.138.1565875381281;
 Thu, 15 Aug 2019 06:23:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAK8P3a0VxM1BkjY1D2FfHi6L-ho_NH3v3+gBu45EfpjLF5NU5w@mail.gmail.com>
 <CAHk-=wiO2CWONDBud4nxoPgUJN1JEewFWhHa5wAqY8G5rrTXRQ@mail.gmail.com>
 <20190814000622.GB20365@mit.edu> <342565604d704b6ebaf2e9ec28d3e109@AcuMS.aculab.com>
 <0089C4CC-DD85-48A1-869B-A9D71852BEC7@zytor.com>
In-Reply-To: <0089C4CC-DD85-48A1-869B-A9D71852BEC7@zytor.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 15 Aug 2019 15:22:45 +0200
Message-ID: <CAK8P3a0VQ1F5xnRNmfeg-rAWbKb64u_8xfQjFNahNRoAHTMJ3g@mail.gmail.com>
Subject: Re: New kernel interface for sys_tz and timewarp?
To:     "H. Peter Anvin" <hpa@zytor.com>
Cc:     David Laight <David.Laight@aculab.com>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Florian Weimer <fweimer@redhat.com>,
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

On Wed, Aug 14, 2019 at 6:48 PM <hpa@zytor.com> wrote:
>
> I believe Windows 10 changed the default RTC to UTC, although perhaps
> only if running under UEFI.

I looked at the efi rtc driver now, and found two things:

- The EFI get_time() call passes down timezone information, so we know what
   UTC is, and can just ignore the timezone. This is good.

- The RTC_DRV_EFI depends on !X86 as of commit 7efe665903d0 ("rtc:
  Disable EFI rtc for x86"). This unfortunately means we always fall back to
  either the rtc-cmos driver or the x86 specific read_persistent_clock64()
  implementation even when the EFI RTC is reliable.

If 64-bit Windows relies on a working EFI RTC implementation, we could
decide to leave the driver enabled on 64-bit and only disable it for
32-bit EFI. That way, future distros would no longer have to worry about
the localtime hack, at least the ones that have dropped support for
32-bit x86 kernels.

        Arnd
