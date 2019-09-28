Return-Path: <SRS0=c662=XX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48E04C4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 06:22:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 176E9207FA
	for <linux-kernel@archiver.kernel.org>; Sat, 28 Sep 2019 06:22:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hoW52JNO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726171AbfI1GWg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 28 Sep 2019 02:22:36 -0400
Received: from mail-yb1-f193.google.com ([209.85.219.193]:34808 "EHLO
        mail-yb1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbfI1GWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Sep 2019 02:22:36 -0400
Received: by mail-yb1-f193.google.com with SMTP id p11so2764186ybc.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2019 23:22:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Bg7uM/vqGqsjyM9H0Hgoy0WYnWDjhpVkIU5063YeccE=;
        b=hoW52JNOW+UrzwDPyp5y+OJVXfOYJeQM61QNHfj8TFQE5loHjsGS/anBQbi0gKJABo
         97Zfz7DYXT+PnmSh2VqJv3UbJD4lU4TEs8B7Ke88pNI/1boVCi7XFzlrGyDBzCS1eQyQ
         3GaRUJppIwhTL2O9pfuhoXou00xPoRpo2V2f0LatTw2E9nGFgHSGiIbpxexc/n4DF4hH
         j6CV8smroWMwONQFcrKCx0mblkNb6XyshYOE6VhynxtjgGPMBAyRRkuZl8104ym+ZIV9
         5V9HOp49sSMIF1BJ0mmcB68XI8X5MCL+AjVI0+FwYXrbof7VwpfIn4k2SYvTZMSvtO8p
         47Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Bg7uM/vqGqsjyM9H0Hgoy0WYnWDjhpVkIU5063YeccE=;
        b=c+UR9aFXH44kAEuwZYt7sSJ78EuJBNEI4/oYSuDUxaTVh2DKMasJ4cOt3GSXabQIqD
         0yNRsvK5JRkAO7y0MCF1aYCMPjhuwasFL9U7crY8cKNoqHq2OLYjnDoWn7QylsHijYnc
         SBuclpL/HY0WSIMoC9TFdUjmkGh3C7tW1/13PxcQYZg1AGbKU6ee6cJPDIjVwbUNBqvu
         aYFlWyXH6ctZrokQDH3nQgUBnOwDr7hUZ18IeYE/Go8V+c0qy04AhYAMYyBKLGZXGuDS
         B4ASWAGYPoPGQ/RyFG/ifpkKy9RK+8nUnxqwxhC00vr8It43YvTHnHVh1gfyqpcd4hs1
         p8dQ==
X-Gm-Message-State: APjAAAUaqZ/x47M+TLJZA+LIBmuHHKObxe/H4I2FZz2Vexgrpnb9cVmS
        mQydu3msBemzN112pqhlCGWJMGgo38AwWWWzBbo=
X-Google-Smtp-Source: APXvYqyANmT1+JktvebdIP3ODZAdL6CKSso8Gua+q3zbGI/cl6lVo2NUOIn6bpTPmm0tSOitNUy7sg/gnT1dG/L18I4=
X-Received: by 2002:a25:a87:: with SMTP id 129mr8587098ybk.203.1569651755563;
 Fri, 27 Sep 2019 23:22:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190927231418.83100-1-aou@eecs.berkeley.edu>
In-Reply-To: <20190927231418.83100-1-aou@eecs.berkeley.edu>
From:   Bin Meng <bmeng.cn@gmail.com>
Date:   Sat, 28 Sep 2019 14:22:22 +0800
Message-ID: <CAEUhbmURq0M3sPecxTdOwrB+vP5GB59_Du=7hVsaVMAqO-nk4w@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: Fix memblock reservation for device tree blob
To:     Albert Ou <aou@eecs.berkeley.edu>
Cc:     Palmer Dabbelt <palmer@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <Anup.Patel@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 28, 2019 at 7:14 AM Albert Ou <aou@eecs.berkeley.edu> wrote:
>
> This fixes an error with how the FDT blob is reserved in memblock.
> An incorrect physical address calculation exposed the FDT header to
> unintended corruption, which typically manifested with of_fdt_raw_init()
> faulting during late boot after fdt_totalsize() returned a wrong value.
> Systems with smaller physical memory sizes more frequently trigger this
> issue, as the kernel is more likely to allocate from the DMA32 zone
> where bbl places the DTB after the kernel image.
>
> Commit 671f9a3e2e24 ("RISC-V: Setup initial page tables in two stages")
> changed the mapping of the DTB to reside in the fixmap area.
> Consequently, early_init_fdt_reserve_self() cannot be used anymore in
> setup_bootmem() since it relies on __pa() to derive a physical address,
> which does not work with dtb_early_va that is no longer a valid kernel
> logical address.
>
> The reserved[0x1] region shows the effect of the pointer underflow
> resulting from the __pa(initial_boot_params) offset subtraction:
>
> [    0.000000] MEMBLOCK configuration:
> [    0.000000]  memory size = 0x000000001fe00000 reserved size = 0x0000000000a2e514
> [    0.000000]  memory.cnt  = 0x1
> [    0.000000]  memory[0x0]     [0x0000000080200000-0x000000009fffffff], 0x000000001fe00000 bytes flags: 0x0
> [    0.000000]  reserved.cnt  = 0x2
> [    0.000000]  reserved[0x0]   [0x0000000080200000-0x0000000080c2dfeb], 0x0000000000a2dfec bytes flags: 0x0
> [    0.000000]  reserved[0x1]   [0xfffffff080100000-0xfffffff080100527], 0x0000000000000528 bytes flags: 0x0
>
> With the fix applied:
>
> [    0.000000] MEMBLOCK configuration:
> [    0.000000]  memory size = 0x000000001fe00000 reserved size = 0x0000000000a2e514
> [    0.000000]  memory.cnt  = 0x1
> [    0.000000]  memory[0x0]     [0x0000000080200000-0x000000009fffffff], 0x000000001fe00000 bytes flags: 0x0
> [    0.000000]  reserved.cnt  = 0x2
> [    0.000000]  reserved[0x0]   [0x0000000080200000-0x0000000080c2dfeb], 0x0000000000a2dfec bytes flags: 0x0
> [    0.000000]  reserved[0x1]   [0x0000000080e00000-0x0000000080e00527], 0x0000000000000528 bytes flags: 0x0
>
> Fixes: 671f9a3e2e24 ("RISC-V: Setup initial page tables in two stages")

I also found that with commit 671f9a3e2e24 ("RISC-V: Setup initial
page tables in two stages"), when booting the kernel from U-Boot via:

=> bootm $kernel_addr_t - $fdtcontroladdr
($kernel_addr_t = 0x84000000 and $fdtcontroladdr = 0xff741c60)

kernel does not boot. I looked at people's instructions of booting
Linux kernel, and they seem to have such:

=> cp.l ${fdtcontroladdr} ${fdt_addr_r} 0x10000
=> bootm ${kernel_addr_r} - ${fdt_addr_r}

where ${fdt_addr_r} is 0x88000000, and "bootm 84000000  - 88000000"
can make the kernel boot.

Thanks for the patch. Now "bootm $kernel_addr_t - $fdtcontroladdr" works again!

Tested-by: Bin Meng <bmeng.cn@gmail.com>

> Signed-off-by: Albert Ou <aou@eecs.berkeley.edu>
> ---
>
> Changes in v2:
> * Changed variable identifier to dtb_early_pa per reviewer feedback.
> * Removed whitespace change.
>
>  arch/riscv/mm/init.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>

Regards,
Bin
