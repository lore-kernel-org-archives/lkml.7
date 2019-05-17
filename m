Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AADFC04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 08:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2105120818
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 08:32:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pqnony4E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728437AbfEQIct (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 04:32:49 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39631 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727825AbfEQIcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 04:32:48 -0400
Received: by mail-qk1-f194.google.com with SMTP id z128so3967597qkb.6
        for <linux-kernel@vger.kernel.org>; Fri, 17 May 2019 01:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=bn2Tk1WWfY/HeaHGYV+nCUNplGKW7e4rVvwZD7ionFU=;
        b=pqnony4E1q1z3gsIT1aCzdAGaNB/o6GnNRx7ps/Qhknh1gBFERbcIZOMIK6MW/lxWK
         8NCeAdTkYJ6AA096vmn0gJAr6Tmsa6q8fMQwvMRWDL8PKdliNnjuupeY7akBeDT8B05Q
         xet4BOG66NZqm5heZqzEeiKJveYWQZnCZ9UAmxduw+ClqxVzs0TRRGAjiuDj26Y8HxRx
         7iqpNCliJ4laXloVQCDZeI6DJwM0rFt5Mh8pkXIvNylNP/LPXPoQTVEl/dAIS8JpONYJ
         RKoRC7nPpb68CoqwBsp5XPPGiHTxqD22gL/J3M5dMPHdfrVBNgfeQC+liJAfN2KIF+Gf
         MA4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=bn2Tk1WWfY/HeaHGYV+nCUNplGKW7e4rVvwZD7ionFU=;
        b=eY5nEOs5Yb+ipzvM5j4x5wIhDmJoiBevjxCVZ2tTQxDkc4i8LeFiSaOSYUsEUvlC+o
         fSBNYNPk85+7s4IYD1MYC38JLW5RRb8esGHEGiFHvnuytripVpgLxl46rBn5pgdj4T0L
         lMns1mwfLkwmINFPSwuYzKTNn5ZKoX9K/AoLmjKP6MEqFwquIYEUv/63xyseYa5fd4wO
         OXPqKVFCrgL8L3+jYieBm6R2Fb8LPOHjrBOh3s2x3U9YcgDqYzayGCkHuhgaj7YtYO2N
         rmjcU16DXsVHxZTePheFCtP0S4L8hHqxrlqvN0byVZPceyV/2JdEJ610hk8vkxTitLtM
         jTlw==
X-Gm-Message-State: APjAAAWOn2ybkzydmJbfV2LcJZALj2u6pFdBVujWBvSWRRBGFnLgBhZV
        SoOtf64W6spe6Mu450NjARbWzP/eQ+bnq4yS2ME=
X-Google-Smtp-Source: APXvYqz2S2pYMD4g5p8tZvc0fsiT1Wt3XADTVGU5ycmOHepAR11pzlw/jZGwF4VrbhB+0YLGOirUSkyfsXlLTNJ3pDY=
X-Received: by 2002:ae9:e403:: with SMTP id q3mr42871748qkc.149.1558081967232;
 Fri, 17 May 2019 01:32:47 -0700 (PDT)
MIME-Version: 1.0
From:   Greentime Hu <green.hu@gmail.com>
Date:   Fri, 17 May 2019 16:32:10 +0800
Message-ID: <CAEbi=3fvgapD4JRq80JbtAgR+KpHDZv60etwVs8sjqoNM5H6og@mail.gmail.com>
Subject: [GIT PULL] nds32 patches for 5.2-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greentime <greentime@andestech.com>,
        Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit e93c9c99a629c61837d5a7fc2120cd2b6c70dbdd:

  Linux 5.1 (2019-05-05 17:42:58 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/greentime/linux.git
tags/nds32-for-linus-5.2-rc1

for you to fetch changes up to af9abd65983cf3602c03ef3d16fe549ba1f3eeed:

  nds32: Fix vDSO clock_getres() (2019-05-16 15:07:08 +0800)

----------------------------------------------------------------
nds32 patches for 5.2-rc1

Here is the nds32 patchset based on 5.1
Contained in here are
1. Clean up codes and Makefile
2. Fix a vDSO bug
3. Remove useless functions/header files
4. Update git repo path in MAINTAINERS

----------------------------------------------------------------
Christoph Hellwig (2):
      nds32: remove __virt_to_bus and __bus_to_virt
      nds32: don't export low-level cache flushing routines

Enrico Weigelt, metux IT consult (1):
      arch: nds32: Kconfig: pedantic formatting

Greentime Hu (1):
      MAINTAINERS: update nds32 git repo path

Julien Grall (1):
      nds32: Removed unused thread flag TIF_USEDFPU

Masahiro Yamada (3):
      nds32: add vmlinux.lds and vdso.so to .gitignore
      nds32: vdso: fix and clean-up Makefile
      nds32: remove unused generic-y += cmpxchg-local.h

Nick Desaulniers (1):
      nds32: vdso: drop unnecessary cc-ldoption

Nishad Kamdar (1):
      nds32: Use the correct style for SPDX License Identifier

Valentin Schneider (1):
      nds32: ex-exit: Remove unneeded need_resched() loop

Vincenzo Frascino (1):
      nds32: Fix vDSO clock_getres()

Will Deacon (1):
      nds32/io: Remove useless definition of mmiowb()

Yang Wei (1):
      nds32: fix semicolon code style issue

 MAINTAINERS                              |  2 +-
 arch/nds32/Kconfig                       | 16 ++++++++--------
 arch/nds32/include/asm/Kbuild            |  1 -
 arch/nds32/include/asm/assembler.h       |  2 +-
 arch/nds32/include/asm/barrier.h         |  2 +-
 arch/nds32/include/asm/bitfield.h        |  2 +-
 arch/nds32/include/asm/cache.h           |  2 +-
 arch/nds32/include/asm/cache_info.h      |  2 +-
 arch/nds32/include/asm/cacheflush.h      |  2 +-
 arch/nds32/include/asm/current.h         |  2 +-
 arch/nds32/include/asm/delay.h           |  2 +-
 arch/nds32/include/asm/elf.h             |  2 +-
 arch/nds32/include/asm/fixmap.h          |  2 +-
 arch/nds32/include/asm/futex.h           |  2 +-
 arch/nds32/include/asm/highmem.h         |  2 +-
 arch/nds32/include/asm/io.h              |  4 +---
 arch/nds32/include/asm/irqflags.h        |  2 +-
 arch/nds32/include/asm/l2_cache.h        |  2 +-
 arch/nds32/include/asm/linkage.h         |  2 +-
 arch/nds32/include/asm/memory.h          | 10 +---------
 arch/nds32/include/asm/mmu.h             |  2 +-
 arch/nds32/include/asm/mmu_context.h     |  2 +-
 arch/nds32/include/asm/module.h          |  2 +-
 arch/nds32/include/asm/nds32.h           |  2 +-
 arch/nds32/include/asm/page.h            |  2 +-
 arch/nds32/include/asm/pgalloc.h         |  2 +-
 arch/nds32/include/asm/pgtable.h         |  2 +-
 arch/nds32/include/asm/proc-fns.h        |  2 +-
 arch/nds32/include/asm/processor.h       |  2 +-
 arch/nds32/include/asm/ptrace.h          |  2 +-
 arch/nds32/include/asm/shmparam.h        |  2 +-
 arch/nds32/include/asm/string.h          |  2 +-
 arch/nds32/include/asm/swab.h            |  2 +-
 arch/nds32/include/asm/syscall.h         |  2 +-
 arch/nds32/include/asm/syscalls.h        |  2 +-
 arch/nds32/include/asm/thread_info.h     |  4 +---
 arch/nds32/include/asm/tlb.h             |  2 +-
 arch/nds32/include/asm/tlbflush.h        |  2 +-
 arch/nds32/include/asm/uaccess.h         |  2 +-
 arch/nds32/include/asm/unistd.h          |  2 +-
 arch/nds32/include/asm/vdso.h            |  2 +-
 arch/nds32/include/asm/vdso_datapage.h   |  3 ++-
 arch/nds32/include/asm/vdso_timer_info.h |  2 +-
 arch/nds32/include/uapi/asm/auxvec.h     |  2 +-
 arch/nds32/include/uapi/asm/byteorder.h  |  2 +-
 arch/nds32/include/uapi/asm/cachectl.h   |  2 +-
 arch/nds32/include/uapi/asm/param.h      |  2 +-
 arch/nds32/include/uapi/asm/ptrace.h     |  2 +-
 arch/nds32/include/uapi/asm/sigcontext.h |  2 +-
 arch/nds32/include/uapi/asm/unistd.h     |  2 +-
 arch/nds32/kernel/.gitignore             |  1 +
 arch/nds32/kernel/cacheinfo.c            |  2 +-
 arch/nds32/kernel/ex-exit.S              |  4 ++--
 arch/nds32/kernel/nds32_ksyms.c          |  6 ------
 arch/nds32/kernel/vdso.c                 |  1 +
 arch/nds32/kernel/vdso/.gitignore        |  1 +
 arch/nds32/kernel/vdso/Makefile          | 14 +++++---------
 arch/nds32/kernel/vdso/gettimeofday.c    |  4 +++-
 arch/nds32/mm/init.c                     |  2 +-
 59 files changed, 72 insertions(+), 89 deletions(-)
 create mode 100644 arch/nds32/kernel/.gitignore
 create mode 100644 arch/nds32/kernel/vdso/.gitignore
