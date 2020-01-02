Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 070B0C32767
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 03:32:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6D7420848
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 03:32:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brainfault-org.20150623.gappssmtp.com header.i=@brainfault-org.20150623.gappssmtp.com header.b="wOwJ001+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727591AbgABDcM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jan 2020 22:32:12 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45039 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727525AbgABDcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 22:32:12 -0500
Received: by mail-wr1-f65.google.com with SMTP id q10so38042739wrm.11
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jan 2020 19:32:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brainfault-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0GhjVv4D/EbozgYYQebu9kHkFsX0cKA5Vsg+9qRPUH0=;
        b=wOwJ001+o9V9w8eVNas2K19aARPSD6KN5kq0RrvUlCnhUch35ZsS4OMnKoGVx74jXm
         xdtTrZckOz9uIuVAypq+w/7liuM8XpMg85ADYSLCiKqkbLgMhLeVk8/KYwDdRsxx+4rL
         GpTv6i+005a9Nm6mJLxMpb6B/HOTfQQgIG5kI3pNP/NhiWxrdBJf6q0nlNRJS6i2jlHW
         NlV+Y6jXHBTWNnKAJ93ncU0Hqi38zOSdvz/yFEvvde/EIMMkrqynAK8WIxXukz9BaX90
         juGzyWuhWACStnUSct31QYt3PfiA2hQ+MnG3Y0kJ+watLKr+WJD2K2qbADqQGnWp49SX
         ogkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0GhjVv4D/EbozgYYQebu9kHkFsX0cKA5Vsg+9qRPUH0=;
        b=VcxVlU4OfuWOt7pqGOD+ZugIIA50NkjOchJ0qIWBOwDpZlXhjxEsGJOH6i3+XNjrnd
         t6HF9ermlaAoVlBC8Oi5QSiM4iNrkoOaY+LOM+m9aQLxjG05mOlIHlhm++24CCvAFAFC
         7pCcUUrvWGFnwSl7Gz4HprGaF+qegHDWoPlYACpE9w/RkkbUBw2n1Wbg+6RbDbp2+cjj
         eOJ7Sb4fZwLoxlG6jGM0mQnOdMD8jTfIbo9TOzCcEHXOexlFovKygln+FX2L+SbSpJC+
         fxIkeuRRFw0tcxfCgTRMJnGwuq5I2FngQV43wBg01zvpUuPRV9uWMif12H+SMVuCQUIF
         5g0A==
X-Gm-Message-State: APjAAAWEu9KtiOzx2PrEbASYSzUsN+tCQcdyT/4bIqQQZlVb9+6m0Ftz
        Y/7PbjFEsIpk4k9yfhL5hweO5p4YxKiaugOS54wWNYl5hEI=
X-Google-Smtp-Source: APXvYqxy+4c0hpqCEiZkzu7f20ddEKWx0WKeOCcURH36ITCn6JSrJblYC8ofxwFKetGQKjjFYPh42GARTcmixm8UhZg=
X-Received: by 2002:adf:d850:: with SMTP id k16mr76314967wrl.96.1577935929993;
 Wed, 01 Jan 2020 19:32:09 -0800 (PST)
MIME-Version: 1.0
References: <20200102031240.44484-1-zong.li@sifive.com> <20200102031240.44484-3-zong.li@sifive.com>
In-Reply-To: <20200102031240.44484-3-zong.li@sifive.com>
From:   Anup Patel <anup@brainfault.org>
Date:   Thu, 2 Jan 2020 09:01:58 +0530
Message-ID: <CAAhSdy0sp_=nwAKxphA8of4UV_NfxHE-KXyTPekmHkieq_XyVw@mail.gmail.com>
Subject: Re: [PATCH 2/2] riscv: mm: use __pa_symbol for kernel symbols
To:     Zong Li <zong.li@sifive.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 2, 2020 at 8:42 AM Zong Li <zong.li@sifive.com> wrote:
>
> __pa_symbol is the marcro that should be used for kernel symbols. It is
> also a pre-requisite for DEBUG_VIRTUAL which will do bounds checking.
>
> Signed-off-by: Zong Li <zong.li@sifive.com>
> ---
>  arch/riscv/mm/init.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 69f6678db7f3..965a8cf4829c 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -99,13 +99,13 @@ static void __init setup_initrd(void)
>                 pr_info("initrd not found or empty");
>                 goto disable;
>         }
> -       if (__pa(initrd_end) > PFN_PHYS(max_low_pfn)) {
> +       if (__pa_symbol(initrd_end) > PFN_PHYS(max_low_pfn)) {
>                 pr_err("initrd extends beyond end of memory");
>                 goto disable;
>         }
>
>         size = initrd_end - initrd_start;
> -       memblock_reserve(__pa(initrd_start), size);
> +       memblock_reserve(__pa_symbol(initrd_start), size);
>         initrd_below_start_ok = 1;
>
>         pr_info("Initial ramdisk at: 0x%p (%lu bytes)\n",
> @@ -124,8 +124,8 @@ void __init setup_bootmem(void)
>  {
>         struct memblock_region *reg;
>         phys_addr_t mem_size = 0;
> -       phys_addr_t vmlinux_end = __pa(&_end);
> -       phys_addr_t vmlinux_start = __pa(&_start);
> +       phys_addr_t vmlinux_end = __pa_symbol(&_end);
> +       phys_addr_t vmlinux_start = __pa_symbol(&_start);
>
>         /* Find the memory region containing the kernel */
>         for_each_memblock(memory, reg) {
> @@ -445,7 +445,7 @@ static void __init setup_vm_final(void)
>
>         /* Setup swapper PGD for fixmap */
>         create_pgd_mapping(swapper_pg_dir, FIXADDR_START,
> -                          __pa(fixmap_pgd_next),
> +                          __pa_symbol(fixmap_pgd_next),
>                            PGDIR_SIZE, PAGE_TABLE);
>
>         /* Map all memory banks */
> @@ -474,7 +474,7 @@ static void __init setup_vm_final(void)
>         clear_fixmap(FIX_PMD);
>
>         /* Move to swapper page table */
> -       csr_write(CSR_SATP, PFN_DOWN(__pa(swapper_pg_dir)) | SATP_MODE);
> +       csr_write(CSR_SATP, PFN_DOWN(__pa_symbol(swapper_pg_dir)) | SATP_MODE);
>         local_flush_tlb_all();
>  }
>  #else
> --
> 2.24.1
>

Overall looks good to me.

Reviewed-by: Anup Patel <anup@brainfault.org>

I have not tried this patch but can you confirm that
__pa_symbol() works fine even when DEBUG_VIRTUAL=n

Regards,
Anup
