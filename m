Return-Path: <SRS0=kYop=UV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 405F6C43613
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 04:15:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F72220843
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Jun 2019 04:15:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="DlB6oG9V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbfFVEOI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Jun 2019 00:14:08 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35316 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725929AbfFVEOI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jun 2019 00:14:08 -0400
Received: by mail-wr1-f67.google.com with SMTP id m3so8390788wrv.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2019 21:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UnNxgzz45jXanekL0G0iIwxvOLwF76KDyFR4BupDUBg=;
        b=DlB6oG9VvsR/BRBZyLkN0QQkvG07sO3eJyod1fWS76wH/Nf6Zijqk/4rKrboH9aoCR
         G1d+knbtufM28yqt/GYYFu4qEU0JsCmEPgTMV7W356ufFI2/G/xKexgOv8fG+9baXvN5
         6bdblZ/bBKtztU58TxVfw7aMaSxN+9Tg/rSuwEvkG4tkqYE6BAqyZjN8r8L/wrscBvmF
         Kez0b3Ghd4SYlU0YX70osvFUAMVm9Fd9k0XUGkdWwYmyXBewi9CHE+7j6rwSZrKNJSNo
         8Plt41Zx/TSsXGmBtiQlo+f9tDDnB7EUUDBtzdnD/rs5uekSljtr7TmSKfTIHbnU6nJD
         KPFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UnNxgzz45jXanekL0G0iIwxvOLwF76KDyFR4BupDUBg=;
        b=lbrUF0EL+AYvgspl4shaqUsvud9V37mk1GGGy5BnQYP4Ja0iCkniknbTcICvJpbTKr
         a2EejKB4PHo075yosR2Za7DeZy2g0DP+XqceOA2DgMiiTLbdxNCQ2ZJeFNLvN0vFpf5Q
         3AmCKg7XHzfhwbgQj2gdj7U5kxXLn4wik84xwJzr7A0R/rXiKcyB9CSoESB4N2QWwMl+
         leE9rYy5NUn/NmwcaonWd31O0gOM4Tcibdk08P7BJ+1IdgRFYk+d3k/pUNjq3tjj2xhd
         3jW9JEaJs13JR9PlcDEdlpBLtBuliROMuc30sBz4AOGJJqV/oKf9R+WtWRanzcPLyyHf
         8D1g==
X-Gm-Message-State: APjAAAXaDdeJ5F8+vdZM70roYcj6Q4hSqK6euAupVixbthDlRlk8QN+T
        5zgspL6gbBc6UCw+BwOgYi4idXBgz2WyNdMTmjYoPw==
X-Google-Smtp-Source: APXvYqy0qSomvM2VPYwdsUAVUeJBcXv6du3aogDq0+nUAilpRabqDlQDj48Qg/rdCcKjlnkDYzPn4J3C99rC7PZysAM=
X-Received: by 2002:a5d:5448:: with SMTP id w8mr65875480wrv.180.1561176846303;
 Fri, 21 Jun 2019 21:14:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190607060049.29257-1-anup.patel@wdc.com>
In-Reply-To: <20190607060049.29257-1-anup.patel@wdc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Sat, 22 Jun 2019 09:43:54 +0530
Message-ID: <CAAhSdy16-6RfHop3iRJkdKxUm3KBXn6MF+v8jp3zH0VxYnNE_w@mail.gmail.com>
Subject: Re: [PATCH v5 0/2] Two-stagged initial page table setup
To:     Anup Patel <Anup.Patel@wdc.com>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <Atish.Patra@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 7, 2019 at 11:31 AM Anup Patel <Anup.Patel@wdc.com> wrote:
>
> This patchset implements two-stagged initial page table setup using fixmap
> to avoid mapping non-existent RAM and also reduce high_memory consumed by
> initial page tables.
>
> The patchset is based on Linux-5.2-rc3 and tested on SiFive Unleashed board
> and QEMU virt machine.
>
> These patches can be found in riscv_setup_vm_v5 branch of
> https//github.com/avpatel/linux.git
>
> Changes since v4:
> - Added dtb_early_va which points to DTB for early parsing
>
> Changes since v3:
> - Changed patch series subject.
> - Dropped PATCH1 because it's already merged
> - Dropped PATCH3 because trampoline page table handles a corner case
>   for 32bit systems where load address range overlaps kernel virtual
>   address range
> - Revamped PATCH for 4K aligned booting into two-stagged initial page
>   table setup
>
> Changes since v2:
> - Dropped PATCH2 because we have separate fix for Linux-5.1-rcX
> - Moved PATCH5 to PATCH2
> - Moved PATCH4 to PATCH3
> - The "Booting kernel from any 4KB aligned address" is now PATCH4
>
> Changes since v1:
> - Add kconfig option BOOT_PAGE_ALIGNED to enable 4KB aligned booting
> - Improved initial page table setup code to select best/biggest
>   possible mapping size based on load address alignment
> - Added PATCH4 to remove redundant trampoline page table
> - Added PATCH5 to fix memory reservation in setup_bootmem()
>
> Anup Patel (2):
>   RISC-V: Fix memory reservation in setup_bootmem()
>   RISC-V: Setup initial page tables in two stages
>
>  arch/riscv/include/asm/fixmap.h     |   5 +
>  arch/riscv/include/asm/pgtable-64.h |   5 +
>  arch/riscv/include/asm/pgtable.h    |   8 +
>  arch/riscv/kernel/head.S            |  17 +-
>  arch/riscv/kernel/setup.c           |   6 +-
>  arch/riscv/mm/init.c                | 331 ++++++++++++++++++++++------
>  6 files changed, 292 insertions(+), 80 deletions(-)
>
> --
> 2.17.1

Hi All,

Any comments on this series?

Regards,
Anup
