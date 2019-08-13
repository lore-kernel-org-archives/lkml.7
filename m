Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C51C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 19:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0519C2054F
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 19:31:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfHMTb3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 15:31:29 -0400
Received: from albireo.enyo.de ([5.158.152.32]:38012 "EHLO albireo.enyo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726130AbfHMTb3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 15:31:29 -0400
Received: from [172.17.203.2] (helo=deneb.enyo.de)
        by albireo.enyo.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        id 1hxcVt-0007t6-IB; Tue, 13 Aug 2019 19:31:21 +0000
Received: from fw by deneb.enyo.de with local (Exim 4.92)
        (envelope-from <fw@deneb.enyo.de>)
        id 1hxcVt-0000qI-DD; Tue, 13 Aug 2019 21:31:21 +0200
From:   Florian Weimer <fw@deneb.enyo.de>
To:     Paul Eggert <eggert@cs.ucla.edu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
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
References: <CAK8P3a0VxM1BkjY1D2FfHi6L-ho_NH3v3+gBu45EfpjLF5NU5w@mail.gmail.com>
        <CAHk-=wiO2CWONDBud4nxoPgUJN1JEewFWhHa5wAqY8G5rrTXRQ@mail.gmail.com>
        <ecf2742a-6cab-cc00-16ab-589fad07b8db@cs.ucla.edu>
Date:   Tue, 13 Aug 2019 21:31:21 +0200
In-Reply-To: <ecf2742a-6cab-cc00-16ab-589fad07b8db@cs.ucla.edu> (Paul Eggert's
        message of "Tue, 13 Aug 2019 10:49:03 -0700")
Message-ID: <87tvakuak6.fsf@mid.deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Paul Eggert:

> Linus Torvalds wrote:
>> I assume/think that glibc uses (a) environment
>> variables and (b) a filesystem-set default (per-user file with a
>> system-wide default? I don't know what people do).

> glibc relies on the TZ environment variable, with a system-wide
> default specified in /etc/localtime or suchlike (there is no
> per-user default). glibc ignores the kernel's 'struct timezone'
> settings for of this, as 'struct timezone' is obsolete/vestigial and
> doesn't contain enough info to do proper conversions anyway.

I think the configuration value that settimeofday changes is not
actually a time zone, but an time offset used to interpret various
things, mostly in a dual-boot environment with Windows, apparently
(Like the default time offset for extracting timetamps from FAT
volumes.)

This data has to come from *somewhere*.  The TZ variable and
/etc/localtime cover something else entirely.

Maybe it is possible to replace these things with other mechanisms
which exist today.  For example, the mount program could read a
configuration file to determine the system default for the time_offset
mount option and apply the value automatically.  The real-time clock
offset could be maintained by whatever mechanism hwclock uses.

I think whatever we end up doing, we should maintain consistency after
a system upgrade after architectures.  It does not make sense to keep
using the settimeofday hack on amd64 indefinitely, and switch to a
different mechanism on RV32, so that the two ways of supplying the
offset are never reconciled across architectures.
