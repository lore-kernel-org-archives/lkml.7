Return-Path: <SRS0=gp+X=WL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B366BC3A589
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 15:50:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 891E520665
	for <linux-kernel@archiver.kernel.org>; Thu, 15 Aug 2019 15:50:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="PKP9EOU3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbfHOPu4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 11:50:56 -0400
Received: from terminus.zytor.com ([198.137.202.136]:52655 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbfHOPu4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 11:50:56 -0400
Received: from [IPv6:2601:646:8600:3281:591e:e77:65e1:9db1] ([IPv6:2601:646:8600:3281:591e:e77:65e1:9db1])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id x7FFo2e82401331
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Thu, 15 Aug 2019 08:50:04 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com x7FFo2e82401331
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565884208;
        bh=rZVtSKWKJMYaNqQAqv7vBDcXZkR10Vw+m7flZizgKig=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=PKP9EOU3UYbYSGImxe+UPWqDyYAZXTZe+MMNowVHnkuaETdwk6L/yrF9pstKMeHak
         /Q2Anr2bsSO0g7boKn1A6o6Mw0c5INMZgSBvtr7Cb6pT2m1tTs+88Netipp17KDn6I
         5lL1hrXp9Cw5VOteRpseX4e9K3HHagDCRgYtHcnNxp772Y+U0OZ1IJ1NcrSXehEGFm
         kvU9Ml2AvClG5MlIE2Q4OlGdoeZEosxINH12prwicZTPj4l7MZVm1yQvRq1Ms5Bm7a
         TVYKhH2MkGOGSfiqfU6+bxQiPGghZgoj+N/wT5F7Q5/DjZpR4sUU3GOjJuq+FjQWZ6
         bDobhTpMGYdyg==
Date:   Thu, 15 Aug 2019 08:24:09 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <20190815150530.GA18727@mit.edu>
References: <CAK8P3a0VxM1BkjY1D2FfHi6L-ho_NH3v3+gBu45EfpjLF5NU5w@mail.gmail.com> <CAHk-=wiO2CWONDBud4nxoPgUJN1JEewFWhHa5wAqY8G5rrTXRQ@mail.gmail.com> <20190814000622.GB20365@mit.edu> <342565604d704b6ebaf2e9ec28d3e109@AcuMS.aculab.com> <0089C4CC-DD85-48A1-869B-A9D71852BEC7@zytor.com> <CAK8P3a0VQ1F5xnRNmfeg-rAWbKb64u_8xfQjFNahNRoAHTMJ3g@mail.gmail.com> <20190815150530.GA18727@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: New kernel interface for sys_tz and timewarp?
To:     "Theodore Y. Ts'o" <tytso@mit.edu>, Arnd Bergmann <arnd@arndb.de>
CC:     David Laight <David.Laight@aculab.com>,
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
From:   hpa@zytor.com
Message-ID: <EA707642-4509-4B88-B4FF-453B1F473608@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On August 15, 2019 8:05:30 AM PDT, "Theodore Y=2E Ts'o" <tytso@mit=2Eedu> w=
rote:
>On Thu, Aug 15, 2019 at 03:22:45PM +0200, Arnd Bergmann wrote:
>> If 64-bit Windows relies on a working EFI RTC implementation, we
>could
>> decide to leave the driver enabled on 64-bit and only disable it for
>> 32-bit EFI=2E That way, future distros would no longer have to worry
>about
>> the localtime hack, at least the ones that have dropped support for
>> 32-bit x86 kernels=2E
>
>=2E=2E=2E and who have also dropped support for legacy (non-UEFI) 64-bit
>boot=2E  Keep in mind that even for distributions which may install with
>UEFI by default, if people have been upgrading from (for example)
>Debian Jessie to Stretch to Buster, they may still be using non-UEFI
>boot=2E  This might be especially true on small Linode servers (such as,
>for example, the one which is currently running my mail smarthost=2E=2E=
=2E=2E)
>
>    	     	     	      			   - Ted

There is also the ACPI TAD device, which can be used to expose this throug=
h ACPI=2E We might also be able to request that the ACPI information for th=
e RTC be augmented with a CMOS timezone location=2E
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
