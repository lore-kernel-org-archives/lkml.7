Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD07C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 09:06:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D96BC20840
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 09:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727487AbfHMJGM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 05:06:12 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35566 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbfHMJGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 05:06:12 -0400
Received: by mail-qt1-f193.google.com with SMTP id u34so6325279qte.2
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2019 02:06:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=HmnZPn2FcohHX2LZev8Ik/BDZ6JSYuIxE8Se4rqqNSM=;
        b=rBg9Ybu5rRrZ256ieMYg5dExWYf4lK60OEJinea14cTDUJHKQEL3atsvxFLcBVDp6/
         ya5AtsflVsGkk8Boxfbn5nMOo5DYlRWXMEzsqxhl37Sn0x30TX1GhPWbMU6Y2geUNUqZ
         0/LNi4SHugaImEWlO01ZKXlbNrD/CzirGUD4uarlFc0JC7bc4c17cHuxTyuip3LxMI9J
         QJq1rccaek2X/c8mqoqa96bjvfjbfjmmsJdck4az+HBZtRm5sc5Cf88lE1XfOJKY8H5s
         gH7M3QAgdxiEyI9aLN0jAdkvRcYGEfSSq7ZXDVQz0lmcCskNkdZ2Qquz9foUSOMGfdEQ
         xTtw==
X-Gm-Message-State: APjAAAVlJlqfwcMClYeThiHzgmpIx7x43V5ZuheAq++uMy13INI6k3wE
        x3kLnpzwX8Kw+dRJ7Dl26oYb170YdV+KQSF8m3YXDnZDCD0=
X-Google-Smtp-Source: APXvYqyNuf2Ns1GMH2+Pz/ISPN3UtH8c0jEwPKZ+81G9STAOaVmAjhYlrrCHKcO2ETs6wDE3k0elpxkKiubN/Q9g1lY=
X-Received: by 2002:ac8:2955:: with SMTP id z21mr7561640qtz.204.1565687171045;
 Tue, 13 Aug 2019 02:06:11 -0700 (PDT)
MIME-Version: 1.0
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 13 Aug 2019 11:05:54 +0200
Message-ID: <CAK8P3a0VxM1BkjY1D2FfHi6L-ho_NH3v3+gBu45EfpjLF5NU5w@mail.gmail.com>
Subject: New kernel interface for sys_tz and timewarp?
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
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

The riscv32 kernel port uses the new time64 syscall interface that has no
'settimeofday', only 'clock_settime64'. During the review of the glibc port,
the question arose how to deal with the (old, horrible, deprecated) timezone
portion of the settimeofday() libc API.

Typical uses of timezones in gettimeofday() are broken and should use
the normal user space timezone handling built into localtime() instead,
so the initial idea was to just not bother on new architectures and
break any application at build time that tries to access the struct timezone
members to ensure they are finally fixed, and also do the same thing
across all architectures for consistency.

As it turns out, both util-linux/hwclock and systemd make use of the
timezone field in settimeofday purely for the purpose of setting the
kernel itself into a known state, for three traditional uses:

- gettimeofday reports the timezone that was last set with settimeofday,
  something that is highly discouraged relying on but that has always
  worked.

- a few device drivers and file systems (e.g. fs/fat, full list below) are
  documented as storing timestamps in local time, so the global sys_tz variable
  is used to decide the offset, in addition to a in-superblock offset in most
  cases.

- on x86, windows dual-boot has traditionally (since linux-0.12) allowed the
  hack that the first settimeofday() call after boot decides whether the RTC
  is interpreted as localtime or UTC. This is particularly important because
  with NTP enabled, the time warped mode also updates the RTC with
  the kernel time every 11 minutes. See kernel/time/ntp.c:sync_hw_clock()
  and timekeeping_warp_clock() .

The relevant discussion on libc-alpha and on for systemd is archived at:
https://patchwork.ozlabs.org/patch/1121610/
https://github.com/systemd/systemd/issues/13305

Now, to the actual questions:

* Should we allow setting the sys_tz on new architectures that use only
  time64 interfaces at all, or should we try to get away from that anyway?

* Should the NTP timewarp setting ("int persistent_clock_is_local" and
  its offset) be controllable separately from the timezone used in other
  drivers?

* If we want keep having a way to set the sys_tz, what interface
should that use?

  Suggestions so far include
   - adding a clock_settimeofday_time64() syscall on all 32-bit architectures to
     maintain the traditional behavior,
   - adding a sysctl interface for accessing sys_tz.tz_tminuteswest,
   - using a new field in 'struct timex' for the timewarp offset, and
   - adding an ioctl command on /dev/rtc/ to control the timewarp
     offset of that particular device.

         Arnd
---
Appendix A: full list of kernel code using sys_tz

$ git grep -wl sys_tz drivers/ fs/ net/
drivers/media/platform/vivid/vivid-rds-gen.c
drivers/media/platform/vivid/vivid-vbi-gen.c
drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
drivers/scsi/3w-9xxx.c
drivers/scsi/3w-sas.c
drivers/scsi/aacraid/commsup.c
drivers/scsi/arcmsr/arcmsr_hba.c
drivers/scsi/mvumi.c
drivers/scsi/mvumi.h
drivers/scsi/smartpqi/smartpqi_init.c
fs/affs/amigaffs.c
fs/affs/inode.c
fs/fat/misc.c
fs/hfs/hfs_fs.h
fs/hfs/inode.c
fs/hfs/sysdep.c
fs/hpfs/hpfs_fn.h
fs/udf/udftime.c
net/netfilter/xt_time.c
