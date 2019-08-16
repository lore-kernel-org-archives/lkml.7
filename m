Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 076EAC3A589
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 01:05:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE56A206C1
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 01:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="qpeJdpG1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbfHPBFW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Aug 2019 21:05:22 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50577 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbfHPBFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Aug 2019 21:05:22 -0400
Received: by mail-wm1-f68.google.com with SMTP id v15so2732145wml.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Aug 2019 18:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7Ip/v0TDAZjAfpcFjyW7SV7ckK6aXUGiD3K/tBldql4=;
        b=qpeJdpG13aFoxjEPvKIUGZh40x293gnmRJs1KuI6t8G/qdjkI/1T0S6Lyb1R8qTt8P
         DDg5xtB+oxFjqlql5EHw1xOWq3QeJW8ggkdULwYHv6Nim+okbLvl1FaBOdAthwXdQXTV
         2E/b9nz/8DD6RbicdU3yIa9wgJavZIbrycIH57DHvQG1LulafEe63lBOL9L01ighvIhY
         VOkFzE2/ilBmElWqMvJ/E2QXeg2FceVcpcTOXimnK7ZOJuxHL+Wj6KRsMwslz2YMw1it
         FIffhuHFM90rvB61Wb6gGqvEdDVdP3bQ2QrZLe5cQGlxnQ6AruC423KludMKaIqv86BI
         w9Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Ip/v0TDAZjAfpcFjyW7SV7ckK6aXUGiD3K/tBldql4=;
        b=jYAgts4sVSyBsueyu14d43oty5URVGcfXC8sA/YorYaz/T6el2lY8AndXYDk2X7lVM
         MsdIHW0QIgcQae7aGYbdZDpXJZ7AGKaEaE2ZnWL+8zCymCUW48T7I1uFCNLqeaa/Rbxl
         wil53ozMndvhH6lFmhtfbs6ZXu7Q5b/mBZLeydIqGvkdCVBQSPzLtksKY/aNO6j0lmJJ
         KqpJJydOw12zwxwa/0YXut7Y+EW4FgvAlFBvV3SFGI7eQsTmoqWmTVAfQ5WSCh8KfGeH
         lQbrkwwq/QmQW7krlq+I+79jFUsf+YzEPOgHuE4E88UkZhXl/Ul/9g4cBTPbGcA2rKz6
         ZRcw==
X-Gm-Message-State: APjAAAUbExLWdR7sPOG5M37NVI7q68eUTFBqrVoUnejXb3JP1ChkwsLk
        MCZaoXmXcoqSpmYgbLLX5pT2DsxMt3jCB3IgvBF06g==
X-Google-Smtp-Source: APXvYqzSbJg85L5Xu4nb//pY3brakvTSX+s8qNt9LVUZQJT8w5x/OD97aYNS6uW6OG1OBP3Dwbeq79sXHqM5grVaxOs=
X-Received: by 2002:a1c:be05:: with SMTP id o5mr4830082wmf.52.1565917519455;
 Thu, 15 Aug 2019 18:05:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190607060049.29257-1-anup.patel@wdc.com> <20190607060049.29257-3-anup.patel@wdc.com>
 <alpine.DEB.2.21.9999.1907101703150.3422@viisi.sifive.com> <847fb8c879bbd2c3fd41dc1e428b3217253acebb.camel@wdc.com>
In-Reply-To: <847fb8c879bbd2c3fd41dc1e428b3217253acebb.camel@wdc.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Fri, 16 Aug 2019 06:35:09 +0530
Message-ID: <CAAhSdy0ULa9mEQVBWMSUjxtjxmiPunbZP8diJduvFjNA0E4nYQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] RISC-V: Setup initial page tables in two stages
To:     Alistair Francis <Alistair.Francis@wdc.com>
Cc:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "palmer@sifive.com" <palmer@sifive.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rppt@linux.ibm.com" <rppt@linux.ibm.com>,
        "hch@infradead.org" <hch@infradead.org>,
        Atish Patra <Atish.Patra@wdc.com>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 12:27 AM Alistair Francis
<Alistair.Francis@wdc.com> wrote:
>
> On Wed, 2019-07-10 at 17:05 -0700, Paul Walmsley wrote:
> > On Fri, 7 Jun 2019, Anup Patel wrote:
> >
> > > Currently, the setup_vm() does initial page table setup in one-shot
> > > very early before enabling MMU. Due to this, the setup_vm() has to
> > > map
> > > all possible kernel virtual addresses since it does not know size
> > > and
> > > location of RAM. This means we have kernel mappings for non-
> > > existent
> > > RAM and any buggy driver (or kernel) code doing out-of-bound access
> > > to RAM will not fault and cause underterministic behaviour.
> > >
> > > Further, the setup_vm() creates PMD mappings (i.e. 2M mappings) for
> > > RV64 systems. This means for PAGE_OFFSET=0xffffffe000000000 (i.e.
> > > MAXPHYSMEM_128GB=y), the setup_vm() will require 129 pages (i.e.
> > > 516 KB) of memory for initial page tables which is never freed. The
> > > memory required for initial page tables will further increase if
> > > we chose a lower value of PAGE_OFFSET (e.g. 0xffffff0000000000)
> > >
> > > This patch implements two-staged initial page table setup, as
> > > follows:
> > > 1. Early (i.e. setup_vm()): This stage maps kernel image and DTB in
> > > a early page table (i.e. early_pg_dir). The early_pg_dir will be
> > > used
> > > only by boot HART so it can be freed as-part of init memory free-
> > > up.
> > > 2. Final (i.e. setup_vm_final()): This stage maps all possible RAM
> > > banks in the final page table (i.e. swapper_pg_dir). The boot HART
> > > will start using swapper_pg_dir at the end of setup_vm_final(). All
> > > non-boot HARTs directly use the swapper_pg_dir created by boot
> > > HART.
> > >
> > > We have following advantages with this new approach:
> > > 1. Kernel mappings for non-existent RAM don't exists anymore.
> > > 2. Memory consumed by initial page tables is now indpendent of the
> > > chosen PAGE_OFFSET.
> > > 3. Memory consumed by initial page tables on RV64 system is 2 pages
> > > (i.e. 8 KB) which has significantly reduced and these pages will be
> > > freed as-part of the init memory free-up.
> > >
> > > The patch also provides a foundation for implementing strict kernel
> > > mappings where we protect kernel text and rodata using PTE
> > > permissions.
> > >
> > > Suggested-by: Mike Rapoport <rppt@linux.ibm.com>
> > > Signed-off-by: Anup Patel <anup.patel@wdc.com>
> >
> > Thanks, updated to apply and to fix a checkpatch warning, and
> > queued.
> >
> > This may not make it in for v5.3-rc1; if not, we'll submit it later.
>
> I'm seeing this failure on RV32 which I bisected to this patch:
>
> [    1.820461] systemd[1]: systemd 242-19-gdb2e367+ running in system
> mode. (-PAM -AUDIT -SELINUX +IMA -APPARMOR +SMACK +SYSVINIT +UTMP
> -LIBCRYPTSETUP -GCRYPT -GNUTLS +ACL +XZ -LZ4 -SECCOMP +BLKID -ELFUTILS
> +KMOD -IDN2 -IDN -PCRE2 default-hierarchy=hybrid)
> [    1.824320] Unable to handle kernel paging request at virtual
> address 9ff00c15
> [    1.824973] Oops [#1]
> [    1.825162] Modules linked in:
> [    1.825536] CPU: 0 PID: 1 Comm: systemd Not tainted 5.2.0-rc7 #1
> [    1.826039] sepc: c05c3c78 ra : c04b5a74 sp : df047ce0
> [    1.826514]  gp : c07a1038 tp : df04c000 t0 : 000000fc
> [    1.826919]  t1 : 00000002 t2 : 000003ef s0 : df047cf0
> [    1.827322]  s1 : df7090f8 a0 : 9ff00c15 a1 : c072166c
> [    1.827723]  a2 : 00000000 a3 : 00000001 a4 : 00000001
> [    1.828104]  a5 : df6f8138 a6 : 0000002f a7 : de62a000
> [    1.828534]  s2 : c072166c s3 : 00000000 s4 : 00000000
> [    1.828931]  s5 : c07a2000 s6 : 00400cc0 s7 : 00000400
> [    1.829319]  s8 : de491018 s9 : 00000000 s10: fffff000
> [    1.829702]  s11: de491030 t3 : de62b000 t4 : 00000000
> [    1.830090]  t5 : 00000000 t6 : 00000080
> [    1.830392] sstatus: 00000100 sbadaddr: 9ff00c15 scause: 0000000d
> [    1.831616] ---[ end trace 49a926a1a5300c00 ]---
> [    1.835776] Kernel panic - not syncing: Attempted to kill init!
> exitcode=0x0000000b
> [    1.836575] ---[ end Kernel panic - not syncing: Attempted to kill
> init! exitcode=0x0000000b ]---
>
> Does anyone else see this?
>
> A simple revert of this patch on 5.3-rc4 fixes the issue for me.

It looks like this patch is exposing some other bug of Linux RISC-V
32bit kernel.

We will be hiding the actual issue by reverting this patch because
previously we were mapping all possible kernel virtual addresses
even for non-existent RAM (after RAM ends).

Let me debug this more.

Regards,
Anup

>
> Alistair
>
> >
> >
> > - Paul
> >
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
