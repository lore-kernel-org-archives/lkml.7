Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C997DC04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 19:09:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7667520843
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 19:09:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Te5hk/H+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727257AbfEOTJm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 15:09:42 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:55250 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbfEOTJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 15:09:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1557947380; x=1589483380;
  h=subject:to:cc:references:from:message-id:date:
   mime-version:in-reply-to:content-transfer-encoding;
  bh=XKkp/5FjxcdzcXBiWVADd+bsrCzJBVpKiZx6bgPCtvw=;
  b=Te5hk/H+ZIHnKo9HH58yzZ7eF+3MK9tuVc0SHAAQOg8PMaHOhLrrEHvX
   mbyG4sd5q3OruWO2swBB32plfccRBd+vYiNweczr6MZZmvRz/4Lxp7jSs
   j33HwfhG8BPfKGQrjZoLrgzQh8vKHrtpQrnl76iMwbV9FQbTVFkPFPStK
   7d3mzbLvEemfY9gMXt7RmluyD9rkT4LscdoTr5h4LEHk2Am5X7wUEPhOy
   tjAQ/9/suQMVTZZqFshOwRibZIAvXX/VemOsX6oQo+dRpBeZfG/VLJSpA
   5yazJcW57sDqHFwPmdDsOBkCwr57xaUyUk2bUM3ZwNvXO1Du573WEnaoa
   w==;
X-IronPort-AV: E=Sophos;i="5.60,473,1549900800"; 
   d="scan'208";a="214461760"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 16 May 2019 03:09:40 +0800
IronPort-SDR: yd9LWibeB/M/BVwBZhXYhH6E4S2dJXxqEpE7MpanPj6J7H5rPaL5NYCPRp9bgbdD16ZUClITZw
 7cOoDtVyT7zKXFaOu6O77a0kH+LEImDTvbj9Cu/VuRybrDHaH00xZIkl01dyQCXz20ao6rP0Eg
 5ItwtFPL//quHYFfthcIdve57b1a3m92Qk8J0XjjS6EjBd9NX/bSilH3NXmVk4TPnOw3EkrMJ2
 WVjw9mxMKkbL6Db+k6EdZIVHOjoe6oSzUKs7oNScTEFt25YJXPRq46YiXq6S8I6NJPbG0p9VxP
 r1FkqJe8nTZBuzN/7vyV21y+
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP; 15 May 2019 11:45:16 -0700
IronPort-SDR: uSNJ7/H3oezjbkZ/xHN2Zf6QnHXRZDxduONaF44lLAKW8Se8U78dFrVwcHUj0zQ7QShzCIaUp9
 SpxCxQhRISB/lSOTscaX5RjeW19vJ10QUDRa6rNfAxNVSpr/kJ/GXWOw5pf5XH3f++dQLiaZEf
 uSHHzshnW9klI1FvEOjH0gqxxb/yNDToZIyNJIk8hp8GQJmhDo++DmKknDqNzMGpWj9XtJPT0e
 fhgZFRAhusvBS1R6MLsK3ZZ7WB8p/QaOguZKRXcHxTjNgIg9PclWAV18DT7RYas8cjDhqJ+S8r
 MGM=
Received: from r6220.sdcorp.global.sandisk.com (HELO [192.168.1.6]) ([10.196.157.143])
  by uls-op-cesaip01.wdc.com with ESMTP; 15 May 2019 12:09:39 -0700
Subject: Re: [GIT PULL] RISC-V Patches for the 5.2 Merge Window, Part 1
To:     Palmer Dabbelt <palmer@sifive.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <mhng-d6bbd5f4-7409-4d3e-94a0-7ff0c6a71c9e@palmer-si-x1e>
From:   Atish Patra <atish.patra@wdc.com>
Message-ID: <21598eb7-8ff0-2b6b-4cab-c0d1295fd46e@wdc.com>
Date:   Wed, 15 May 2019 12:08:36 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <mhng-d6bbd5f4-7409-4d3e-94a0-7ff0c6a71c9e@palmer-si-x1e>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/15/19 10:40 AM, Palmer Dabbelt wrote:
> The following changes since commit 085b7755808aa11f78ab9377257e1dad2e6fa4bb:
> 
>    Linux 5.1-rc6 (2019-04-21 10:45:57 -0700)
> 
> are available in the Git repository at:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/palmer/riscv-linux.git tags/riscv-for-linus-5.2-mw0
> 
> for you to fetch changes up to e23fc917f04ffac8c156fdb4ee8b56f3867fa50b:
> 
>    RISC-V: Avoid using invalid intermediate translations (2019-05-08 15:06:18 -0700)
> 
> ----------------------------------------------------------------
> RISC-V Patches for the 5.2 Merge Window, Part 1
> 
> This patch set contains an assortment of RISC-V related patches that I'd
> like to target for the 5.2 merge window.  Most of the patches are
> cleanups, but there are a handful of user-visible changes:
> 
> * The nosmp and nr_cpus command-line arguments are now supported, which
>    work like normal.
> * The SBI console no longer installs itself as a preferred console, we
>    rely on standard mechanisms (/chosen, command-line, hueristics)
>    instead.
> * sfence_remove_sfence_vma{,_asid} now pass their arguments along to the
>    SBI call.
> * Modules now support BUG().
> * A missing sfence.vma during boot has been added.  This bug only
>    manifests during boot.
> 
> I've only tested this on QEMU again, as I didn't have time to get things
> running on the Unleashed.  The latest master from this morning merges in
> cleanly and passes the tests as well.
> 
> ----------------------------------------------------------------
> Anup Patel (4):
>        RISC-V: Use tabs to align macro values in asm/csr.h
>        RISC-V: Add interrupt related SCAUSE defines in asm/csr.h
>        RISC-V: Access CSRs using CSR numbers
>        tty: Don't force RISCV SBI console as preferred console
> 
> Atish Patra (4):
>        RISC-V: Add RISC-V specific arch_match_cpu_phys_id
>        RISC-V: Implement nosmp commandline option.
>        RISC-V: Support nr_cpus command line option.
>        RISC-V: Fix minor checkpatch issues.
> 
> Christoph Hellwig (11):
>        riscv: use asm-generic/extable.h
>        riscv: turn mm_segment_t into a struct
>        riscv: remove unreachable big endian code
>        riscv: remove CONFIG_RISCV_ISA_A
>        riscv: clear all pending interrupts when booting
>        riscv: simplify the stack pointer setup in head.S
>        riscv: cleanup the parse_dtb calling conventions
>        riscv: remove unreachable !HAVE_FUNCTION_GRAPH_RET_ADDR_PTR code
>        riscv: remove duplicate macros from ptrace.h
>        riscv: print the unexpected interrupt cause
>        riscv: call pm_power_off from machine_halt / machine_power_off
> 
> Gary Guo (3):
>        riscv: move flush_icache_{all,mm} to cacheflush.c
>        riscv: move switch_mm to its own file
>        riscv: fix sbi_remote_sfence_vma{,_asid}.
> 
> Guo Ren (1):
>        riscv/signal: Fixup additional syscall restarting
> 
> Nick Desaulniers (1):
>        riscv: vdso: drop unnecessary cc-ldoption
> 
> Palmer Dabbelt (1):
>        RISC-V: Avoid using invalid intermediate translations
> 
> Vincent Chen (3):
>        riscv: support trap-based WARN()
>        riscv: Add the support for c.ebreak check in is_valid_bugaddr()
>        riscv: Support BUG() in kernel module
> 
>   arch/riscv/Kconfig                   |   6 +-
>   arch/riscv/Makefile                  |   5 +-
>   arch/riscv/include/asm/Kbuild        |   1 +
>   arch/riscv/include/asm/bug.h         |  35 ++++++----
>   arch/riscv/include/asm/cacheflush.h  |   2 +-
>   arch/riscv/include/asm/csr.h         | 123 ++++++++++++++++++++++-------------
>   arch/riscv/include/asm/elf.h         |   6 --
>   arch/riscv/include/asm/futex.h       |  13 ----
>   arch/riscv/include/asm/irqflags.h    |  10 +--
>   arch/riscv/include/asm/mmu_context.h |  59 +----------------
>   arch/riscv/include/asm/ptrace.h      |  21 ++----
>   arch/riscv/include/asm/sbi.h         |  19 ++++--
>   arch/riscv/include/asm/thread_info.h |   4 +-
>   arch/riscv/include/asm/uaccess.h     |  28 +++-----
>   arch/riscv/kernel/asm-offsets.c      |   3 -
>   arch/riscv/kernel/cpu.c              |   3 +-
>   arch/riscv/kernel/entry.S            |  22 +++----
>   arch/riscv/kernel/head.S             |  33 ++++++----
>   arch/riscv/kernel/irq.c              |  19 ++----
>   arch/riscv/kernel/perf_event.c       |   4 +-
>   arch/riscv/kernel/reset.c            |  15 +++--
>   arch/riscv/kernel/setup.c            |   6 +-
>   arch/riscv/kernel/signal.c           |   6 ++
>   arch/riscv/kernel/smp.c              |  61 +++--------------
>   arch/riscv/kernel/smpboot.           |   0
>   arch/riscv/kernel/smpboot.c          |  22 ++++++-
>   arch/riscv/kernel/stacktrace.c       |  14 ++--
>   arch/riscv/kernel/traps.c            |  30 ++++++---
>   arch/riscv/kernel/vdso/Makefile      |   2 +-
>   arch/riscv/mm/Makefile               |   1 +
>   arch/riscv/mm/cacheflush.c           |  61 +++++++++++++++++
>   arch/riscv/mm/context.c              |  69 ++++++++++++++++++++
>   arch/riscv/mm/fault.c                |   6 +-
>   drivers/tty/hvc/hvc_riscv_sbi.c      |   1 -
>   34 files changed, 390 insertions(+), 320 deletions(-)
>   create mode 100644 arch/riscv/kernel/smpboot.

I think "smpboot." got added as a typo because of commit (RISC-V: 
Support nr_cpus command line option.).

Can you please update the PR directly or should I send a fixup patch?

Regards,
Atish
>   create mode 100644 arch/riscv/mm/context.c
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
> 


-- 
Regards,
Atish
