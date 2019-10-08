Return-Path: <SRS0=XKeO=YB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A17C10F14
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 23:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E9BD21721
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Oct 2019 23:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=eecs-berkeley-edu.20150623.gappssmtp.com header.i=@eecs-berkeley-edu.20150623.gappssmtp.com header.b="TNInimJ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729734AbfJHXbU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 19:31:20 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33413 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbfJHXbU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 19:31:20 -0400
Received: by mail-pl1-f194.google.com with SMTP id d22so118707pls.0
        for <linux-kernel@vger.kernel.org>; Tue, 08 Oct 2019 16:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eecs-berkeley-edu.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:comments:mime-version
         :content-id:content-transfer-encoding:date:message-id;
        bh=l1pNyE3/ypBPj3KYLx4NoFd3cbEq25ItIhYszhCrZaQ=;
        b=TNInimJ9HufK1KFrWxBnkKKOAF2I92fr42GfIBIFxtY1fmaLRS6EeduqrYo/jHl2dr
         wKZVWSqdv+tNwGs8IxzUu4Z1H+GEwiqIM7d6NlWCtaSB7R9MabuXQ2tyLFBkuVXf/xES
         blxcc09t5EdrfgQqvw8WdAW7lqeYyBxQgBZjUbnUBChbUVf6xcvqRPGApfg/2YQEGJxG
         PMII4GskDoYAoTc3BEBLFkbjNFyjOCN2MGdlbFSSccxvu1vhLqCsYPPotIjnwFuAmvyC
         VyCBrKZdyIAHFzZEq1fsZLKCfuFVUxwU9K6E/6OnHBd7hp/CrMbn8NmvquQbKOAGUs/C
         aECw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references
         :comments:mime-version:content-id:content-transfer-encoding:date
         :message-id;
        bh=l1pNyE3/ypBPj3KYLx4NoFd3cbEq25ItIhYszhCrZaQ=;
        b=I+3UAZnZqpAR+Pk9WrKxcHCxnCKe95KOV+QfvPez6I4lve+Io/6XZ4kNiMM76doQxZ
         32/jfgMZLqR/6kNXNqMvnjPnyoGuVgLho0z8hutnvbFCBGCFb5dqKdJmZOoYd/4cm56V
         Ago3Yx08fL4AVr2HeCIGyZPrk+iQe/dZc0F5ux6XNHhNytxn3wzqqOQH5gKau+QEVpeV
         nQLWvxQ9EEbtLDya/Gp6imuxwCz0e5rJKELDu7V8WV4B7nzdgwYF62ZAol5RJtIMqqrV
         m6+L8KbWgcqopcgd4iw5X3IMo1IVV/w11NLLynBoYOrcEWXaJQd+bP1fdx6pv0SMkljb
         dlmg==
X-Gm-Message-State: APjAAAV+GAyKm22FNrsrEnWDDy9Q6CQetaYVa06IfLUxEScNo4to4KJi
        wPhVVRPUsirKJ/TQtvv04OuhkQ==
X-Google-Smtp-Source: APXvYqwSfw2Qo/LT+fqD7RJh5I8b3bSKQU5hBm2KqrkBAWtmLpBa1mZskznpOqIyutrlritjF4gj2Q==
X-Received: by 2002:a17:902:8608:: with SMTP id f8mr88788plo.185.1570577478928;
        Tue, 08 Oct 2019 16:31:18 -0700 (PDT)
Received: from localhost (dhcp-35-38.EECS.Berkeley.EDU. [128.32.35.38])
        by smtp.gmail.com with ESMTPSA id d3sm242576pgb.3.2019.10.08.16.31.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Oct 2019 16:31:18 -0700 (PDT)
From:   Albert Ou <aou@eecs.berkeley.edu>
To:     Palmer Dabbelt <palmer@sifive.com>
cc:     anup@brainfault.org, Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: Fix memblock reservation for device tree blob
In-reply-to: <mhng-464b0376-8728-4ca9-a090-e785ffb2df14@palmer-si-x1e>
References: <mhng-464b0376-8728-4ca9-a090-e785ffb2df14@palmer-si-x1e>
Comments: In-reply-to Palmer Dabbelt <palmer@sifive.com>
   message dated "Tue, 08 Oct 2019 15:38:15 -0700."
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <46781.1570577453.1@ratiocinator.vaxen.org>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 08 Oct 2019 16:31:17 -0700
Message-ID: <46808.1570577477@ratiocinator.vaxen.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019-10-08 15:38:15 -0700, Palmer Dabbelt <palmer@sifive.com> wrote:
> On Fri, 20 Sep 2019 21:34:57 PDT (-0700), anup@brainfault.org wrote:
> > On Sat, Sep 21, 2019 at 6:30 AM Albert Ou <aou@eecs.berkeley.edu> wrot=
e:
> >>
> >> This fixes an error with how the FDT blob is reserved in memblock.
> >> An incorrect physical address calculation exposed the FDT header to
> >> unintended corruption, which typically manifested with of_fdt_raw_ini=
t()
> >> faulting during late boot after fdt_totalsize() returned a wrong valu=
e.
> >> Systems with smaller physical memory sizes more frequently trigger th=
is
> >> issue, as the kernel is more likely to allocate from the DMA32 zone
> >> where bbl places the DTB after the kernel image.
> >>
> >> Commit 671f9a3e2e24 ("RISC-V: Setup initial page tables in two stages=
")
> >> changed the mapping of the DTB to reside in the fixmap area.
> >> Consequently, early_init_fdt_reserve_self() cannot be used anymore in
> >> setup_bootmem() since it relies on __pa() to derive a physical addres=
s,
> >> which does not work with dtb_early_va that is no longer a valid kerne=
l
> >> logical address.
> >>
> >> The reserved[0x1] region shows the effect of the pointer underflow
> >> resulting from the __pa(initial_boot_params) offset subtraction:
> >>
> >> [    0.000000] MEMBLOCK configuration:
> >> [    0.000000]  memory size =3D 0x000000001fe00000 reserved size =3D =
0x0000000000a2e514
> >> [    0.000000]  memory.cnt  =3D 0x1
> >> [    0.000000]  memory[0x0]     [0x0000000080200000-0x000000009ffffff=
f], 0x000000001fe00000 bytes flags: 0x0
> >> [    0.000000]  reserved.cnt  =3D 0x2
> >> [    0.000000]  reserved[0x0]   [0x0000000080200000-0x0000000080c2dfe=
b], 0x0000000000a2dfec bytes flags: 0x0
> >> [    0.000000]  reserved[0x1]   [0xfffffff080100000-0xfffffff08010052=
7], 0x0000000000000528 bytes flags: 0x0
> >>
> >> With the fix applied:
> >>
> >> [    0.000000] MEMBLOCK configuration:
> >> [    0.000000]  memory size =3D 0x000000001fe00000 reserved size =3D =
0x0000000000a2e514
> >> [    0.000000]  memory.cnt  =3D 0x1
> >> [    0.000000]  memory[0x0]     [0x0000000080200000-0x000000009ffffff=
f], 0x000000001fe00000 bytes flags: 0x0
> >> [    0.000000]  reserved.cnt  =3D 0x2
> >> [    0.000000]  reserved[0x0]   [0x0000000080200000-0x0000000080c2dfe=
b], 0x0000000000a2dfec bytes flags: 0x0
> >> [    0.000000]  reserved[0x1]   [0x0000000080e00000-0x0000000080e0052=
7], 0x0000000000000528 bytes flags: 0x0
> >
> > Thanks for catching this issue.
> >
> > Most of us did not notice this issue most likely because:
> > 1. We generally have good enough RAM on QEMU and SiFive Unleashed
> > 2. Most of people use OpenSBI FW_JUMP on QEMU and U-Boot  on
> >     SiFive Unleashed to boot in Linux which places FDT quite far away
> >     from Linux kernel end
> >
> > Linux ARM64 kernel also uses FIXMAP to access FDT and over there
> > as well early_init_fdt_reserve_self() is not used.
> >
> >>
> >> Fixes: 671f9a3e2e24 ("RISC-V: Setup initial page tables in two stages=
")
> >> Signed-off-by: Albert Ou <aou@eecs.berkeley.edu>
> >> ---
> >>  arch/riscv/mm/init.c | 13 ++++++++++++-
> >>  1 file changed, 12 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> >> index f0ba713..52d007c 100644
> >> --- a/arch/riscv/mm/init.c
> >> +++ b/arch/riscv/mm/init.c
> >> @@ -11,6 +11,7 @@
> >>  #include <linux/swap.h>
> >>  #include <linux/sizes.h>
> >>  #include <linux/of_fdt.h>
> >> +#include <linux/libfdt.h>
> >>
> >>  #include <asm/fixmap.h>
> >>  #include <asm/tlbflush.h>
> >> @@ -82,6 +83,8 @@ static void __init setup_initrd(void)
> >>  }
> >>  #endif /* CONFIG_BLK_DEV_INITRD */
> >>
> >> +static phys_addr_t __dtb_pa __initdata;
> >
> > May be dtb_early_pa will be more consistent name
> > instead of __dtb_pa because it matches dtb_early_va
> > used below.
> >
> >> +
> >>  void __init setup_bootmem(void)
> >>  {
> >>         struct memblock_region *reg;
> >> @@ -117,7 +120,12 @@ void __init setup_bootmem(void)
> >>         setup_initrd();
> >>  #endif /* CONFIG_BLK_DEV_INITRD */
> >>
> >> -       early_init_fdt_reserve_self();
> >> +       /*
> >> +        * Avoid using early_init_fdt_reserve_self() since __pa() doe=
s
> >> +        * not work for DTB pointers that are fixmap addresses
> >> +        */
> >> +       memblock_reserve(__dtb_pa, fdt_totalsize(dtb_early_va));
> >> +
> >>         early_init_fdt_scan_reserved_mem();
> >>         memblock_allow_resize();
> >>         memblock_dump_all();
> >> @@ -333,6 +341,7 @@ static uintptr_t __init best_map_size(phys_addr_t=
 base, phys_addr_t size)
> >>         "not use absolute addressing."
> >>  #endif
> >>
> >> +
> >
> > Please remove this newline addition.
> >
> >>  asmlinkage void __init setup_vm(uintptr_t dtb_pa)
> >>  {
> >>         uintptr_t va, end_va;
> >> @@ -393,6 +402,8 @@ asmlinkage void __init setup_vm(uintptr_t dtb_pa)
> >>
> >>         /* Save pointer to DTB for early FDT parsing */
> >>         dtb_early_va =3D (void *)fix_to_virt(FIX_FDT) + (dtb_pa & ~PA=
GE_MASK);
> >> +       /* Save physical address for memblock reservation */
> >> +       __dtb_pa =3D dtb_pa;
> >>  }
> >>
> >>  static void __init setup_vm_final(void)
> >> --
> >> 2.7.4
> >>
> >>
> >> _______________________________________________
> >> linux-riscv mailing list
> >> linux-riscv@lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/linux-riscv
> >
> > This deserves to be stable kernel fix as well.
> > You should add:
> > Cc: stable@vger.kernel.org
> > in your commit description.
> >
> > Apart from minor nits above.
> >
> > Reviewed-by: Anup Patel <anup@brainfault.org>
> >
> > I tried this patch for both RV64 and RV32 on QEMU with
> > Yocto rootfs.
> >
> > Tested-by: Anup Patel <anup@brainfault.org>
> >
> > Regards,
> > Anup
>
> Albert: Do you plan on spinning a v2 of the patch set?
>

v2 was sent last week and has already been applied as
922b0375fc93fb1a20c5617e37c389c26bbccb70 by Paul.

-- =

Albert Ou
