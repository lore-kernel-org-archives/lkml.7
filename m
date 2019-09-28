Return-Path: <SRS0=c662=XX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98DB4C4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 08:01:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5DF4F2075C
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 08:01:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="WN/WcnCQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728275AbfI1IBL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Sep 2019 04:01:11 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:53891 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbfI1IBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Sep 2019 04:01:11 -0400
Received: by mail-wm1-f68.google.com with SMTP id i16so8159045wmd.3
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2019 01:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9wITyUrwg8h7GjKpTtAxenv9sNKlKE3bGBHmQEB/5os=;
        b=WN/WcnCQb503cdvTtFyI9tWB+gjSc6Nd53vmFzSu+GfDK4YhvUIuJzYfWOD54xhyN3
         JIhamxdk0Ev54CnMfXr6Ry3+cP1/N1bJAeyonKucjt0CliM3nCqbs8KkgsVnu4JXuEh9
         NyY25tDwMbC5/PUldI9fjtAeROrTnTRAiHGR5U7dHAqWfvXd43QFp9zqYyAaPZFg4QHr
         Oxi9dS/SzqwDP9sk8VSW6LpWWMmvfE9qHAbpiHda0SAnjdhmhOqMNJuWs5DXO3szpkac
         o63aldu1w14cUtQSur1dpeYWc9cSdba61SREWEC2PczKX3wy6PwCWHY7fhXunHKMA2e7
         +uOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9wITyUrwg8h7GjKpTtAxenv9sNKlKE3bGBHmQEB/5os=;
        b=kZxNH5ZW0MlzuAFxlp+/daqJOYkR3c88mqUEV7k8VzIHsGgiw2J3VYoo1nYX8iQRNZ
         UxiuteD8rKfbVKbr1TU7IEmrg13h9ZSiGsq1QWRsEIzPrK+s/oU8UsGpTY8Zzqbjjkw7
         UFsie3IyGaduJzJzl8BKa2WFBiCLl9pfAiNBfECZPLqcOhTVB8wh6XaeSyoL7f9rBjqv
         CbNhE+QKp5Kahlye0XwUz7GAsaqka80POo4uuXLZgAhA8dktmKiMT+TJWBu2uSzJff7W
         OIu5oYzSCxmG8rvh/xGlwE5q5UkuD9xmg5dVGU5MHR/9TULjt7/ppHGLtdrpPU3S/50/
         39yA==
X-Gm-Message-State: APjAAAXIQBUdFSdKuMts+duxcsUBhMt/wKEtkpBjMAT7VzV/tcpTetW5
        871NFc5ji3kPYE6B2OlSJVzMXuqTupEBkUnVlxcniA==
X-Google-Smtp-Source: APXvYqzjIsj//YQ6zt+7Uyy1PEs6TJKIuXhk/P1ci7xL5y9q8OIdh8AGNRshtc+iEykR0DtSdTVA7iD6fWhIiEWsO8g=
X-Received: by 2002:a7b:c84f:: with SMTP id c15mr10421189wml.52.1569657667847;
 Sat, 28 Sep 2019 01:01:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190927231418.83100-1-aou@eecs.berkeley.edu> <CAEUhbmURq0M3sPecxTdOwrB+vP5GB59_Du=7hVsaVMAqO-nk4w@mail.gmail.com>
In-Reply-To: <CAEUhbmURq0M3sPecxTdOwrB+vP5GB59_Du=7hVsaVMAqO-nk4w@mail.gmail.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Sat, 28 Sep 2019 13:30:57 +0530
Message-ID: <CAAhSdy2RcFSDtBtf5ecvpxDgu9SoAEWHpm7=9i1uroX2si0BXw@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: Fix memblock reservation for device tree blob
To:     Bin Meng <bmeng.cn@gmail.com>
Cc:     Albert Ou <aou@eecs.berkeley.edu>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Anup Patel <Anup.Patel@wdc.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 28, 2019 at 11:52 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> On Sat, Sep 28, 2019 at 7:14 AM Albert Ou <aou@eecs.berkeley.edu> wrote:
> >
> > This fixes an error with how the FDT blob is reserved in memblock.
> > An incorrect physical address calculation exposed the FDT header to
> > unintended corruption, which typically manifested with of_fdt_raw_init()
> > faulting during late boot after fdt_totalsize() returned a wrong value.
> > Systems with smaller physical memory sizes more frequently trigger this
> > issue, as the kernel is more likely to allocate from the DMA32 zone
> > where bbl places the DTB after the kernel image.
> >
> > Commit 671f9a3e2e24 ("RISC-V: Setup initial page tables in two stages")
> > changed the mapping of the DTB to reside in the fixmap area.
> > Consequently, early_init_fdt_reserve_self() cannot be used anymore in
> > setup_bootmem() since it relies on __pa() to derive a physical address,
> > which does not work with dtb_early_va that is no longer a valid kernel
> > logical address.
> >
> > The reserved[0x1] region shows the effect of the pointer underflow
> > resulting from the __pa(initial_boot_params) offset subtraction:
> >
> > [    0.000000] MEMBLOCK configuration:
> > [    0.000000]  memory size = 0x000000001fe00000 reserved size = 0x0000000000a2e514
> > [    0.000000]  memory.cnt  = 0x1
> > [    0.000000]  memory[0x0]     [0x0000000080200000-0x000000009fffffff], 0x000000001fe00000 bytes flags: 0x0
> > [    0.000000]  reserved.cnt  = 0x2
> > [    0.000000]  reserved[0x0]   [0x0000000080200000-0x0000000080c2dfeb], 0x0000000000a2dfec bytes flags: 0x0
> > [    0.000000]  reserved[0x1]   [0xfffffff080100000-0xfffffff080100527], 0x0000000000000528 bytes flags: 0x0
> >
> > With the fix applied:
> >
> > [    0.000000] MEMBLOCK configuration:
> > [    0.000000]  memory size = 0x000000001fe00000 reserved size = 0x0000000000a2e514
> > [    0.000000]  memory.cnt  = 0x1
> > [    0.000000]  memory[0x0]     [0x0000000080200000-0x000000009fffffff], 0x000000001fe00000 bytes flags: 0x0
> > [    0.000000]  reserved.cnt  = 0x2
> > [    0.000000]  reserved[0x0]   [0x0000000080200000-0x0000000080c2dfeb], 0x0000000000a2dfec bytes flags: 0x0
> > [    0.000000]  reserved[0x1]   [0x0000000080e00000-0x0000000080e00527], 0x0000000000000528 bytes flags: 0x0
> >
> > Fixes: 671f9a3e2e24 ("RISC-V: Setup initial page tables in two stages")
>
> I also found that with commit 671f9a3e2e24 ("RISC-V: Setup initial
> page tables in two stages"), when booting the kernel from U-Boot via:
>
> => bootm $kernel_addr_t - $fdtcontroladdr
> ($kernel_addr_t = 0x84000000 and $fdtcontroladdr = 0xff741c60)
>
> kernel does not boot. I looked at people's instructions of booting
> Linux kernel, and they seem to have such:

Thanks for reporting this issue Bin.

I will add more information about the relation of FDT location
with the commit Bin mentioned:
1. With two staged initial page tables in-place, the first stage
only maps kernel image so we used FIXMAP to map FDT
in setup_vm()
2. Another advantage of using FIXMAP to map FDT is that
we can now place FDT anywhere in entire memory map. This
was not possible previously because FDT had to be placed
after kernel load address for __va() and __pa() to work fine.

The one thing which two-staged page tables missed was to
remove use of early_init_fdt_reserve_self() which is what
this patch does.

Also, the ARM64 Linux also used FIXMAP to map FDT and
it does not use early_init_fdt_reserve_self() to reserved FDT.

Anyways, my comments to previous version of this patch
are taken case so...

Reviewed-by: Anup Patel <anup@brainfault.org>

Regards,
Anup

>
> => cp.l ${fdtcontroladdr} ${fdt_addr_r} 0x10000
> => bootm ${kernel_addr_r} - ${fdt_addr_r}
>
> where ${fdt_addr_r} is 0x88000000, and "bootm 84000000  - 88000000"
> can make the kernel boot.
>
> Thanks for the patch. Now "bootm $kernel_addr_t - $fdtcontroladdr" works again!
>
> Tested-by: Bin Meng <bmeng.cn@gmail.com>
>
> > Signed-off-by: Albert Ou <aou@eecs.berkeley.edu>
> > ---
> >
> > Changes in v2:
> > * Changed variable identifier to dtb_early_pa per reviewer feedback.
> > * Removed whitespace change.
> >
> >  arch/riscv/mm/init.c | 12 +++++++++++-
> >  1 file changed, 11 insertions(+), 1 deletion(-)
> >
>
> Regards,
> Bin
>
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv
