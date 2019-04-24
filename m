Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C29BAC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 21:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B8BD20684
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 21:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="RKLxNmld"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388267AbfDXVGu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 17:06:50 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42777 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731973AbfDXVGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 17:06:49 -0400
Received: by mail-pl1-f196.google.com with SMTP id x15so5541014pln.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2019 14:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=bZkshglKcvBU+6PMpXuNp0wARaLPDffIq6iStMQ6XdQ=;
        b=RKLxNmldM2pr5BbxMF2oAFgODVC5qNpB3prnTXZLfC+J2jtRqMZTDJqQHDx3HM/Zfh
         vs+ujn3c2UjpEYsFATkXUSzIIAthnd8X+8e07S+SC9jdP8D9F5RAYDv+E32aM5YsQdPP
         N/Jf8BHBc9iThEZwJnJoN9+HKvltLKYUwiPuWo3Sti0JwhvqxoaTvi0lDbhLklOl3Ik6
         gR/jpw95F4L6O71W+G+D9cTfKcggHrois1GGfCf/Pc5zM9PrYC05BFFiguRKTW4lhmzt
         xYcVMG1o5qg0uNWVtE2d9myCNk7X/QhtnR6pW/wXBN575Q9XRDZN6uGSSYpmwp4jnAom
         TKeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=bZkshglKcvBU+6PMpXuNp0wARaLPDffIq6iStMQ6XdQ=;
        b=T4WTfOp0VnkolSc1Po0sxyyVJhjKxyima6nDIO20e3HjyZX6R1HlyGknj3IfhvTGDc
         K926p+/TB+0UhXJ0uBBbdvTQ3a0s6UMZiC/IkjTSt9BetR6mQ65LEjsVC2+M95zkUted
         si+NPi7BFUMehCVjot30k8zozz3vRazjML0CFjmfl5zbxr2pIGH8eS55hQr4grtDiOzu
         W1YcXPiMmMsUAaBMQuW4nDYGSWQxJ4EtaRYHw5+/U9feF3MnOqozxCWxtY6LrdLZCVoI
         4S7WeMobK/TRlLq2mAbLygNDyBtdJPNhNKfCILJP5eT2XADtKWJ4VUvBrheb+QDbKyaj
         Dvag==
X-Gm-Message-State: APjAAAXEMm7VHxFCy640dls0zzQLguU2niVgyzMAX3YubyL5+gxahOk4
        XybQyWt4lFp4ppMnfbsEWuFkdg==
X-Google-Smtp-Source: APXvYqwiqgHS4Nde3OSvELilWPNt02aegb8UgiVyCbbNbUStwGwHbXrgdZe31DQr92zc4dWpW9rWDQ==
X-Received: by 2002:a17:902:2ae6:: with SMTP id j93mr35635251plb.18.1556140008705;
        Wed, 24 Apr 2019 14:06:48 -0700 (PDT)
Received: from localhost ([134.134.139.92])
        by smtp.gmail.com with ESMTPSA id i24sm26639846pfo.85.2019.04.24.14.06.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 24 Apr 2019 14:06:47 -0700 (PDT)
Date:   Wed, 24 Apr 2019 14:06:47 -0700 (PDT)
X-Google-Original-Date: Wed, 24 Apr 2019 11:29:42 PDT (-0700)
Subject:     Re: [PATCH v3 2/4] RISC-V: Fix memory reservation in setup_bootmem()
In-Reply-To: <20190325092234.5451-3-anup.patel@wdc.com>
CC:     aou@eecs.berkeley.edu, Atish Patra <Atish.Patra@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Paul Walmsley <paul.walmsley@sifive.com>, rppt@linux.ibm.com,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup.Patel@wdc.com
From:   Palmer Dabbelt <palmer@sifive.com>
To:     Anup.Patel@wdc.com
Message-ID: <mhng-8cf03f23-1af7-48f0-8be8-60654bc09559@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Mar 2019 02:23:09 PDT (-0700), Anup.Patel@wdc.com wrote:
> Currently, the setup_bootmem() reserves memory from RAM start to the
> kernel end. This prevents us from exploring ways to use the RAM below
> (or before) the kernel start hence this patch updates setup_bootmem()
> to only reserve memory from the kernel start to the kernel end.
>
> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/riscv/mm/init.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index 8cf9ff1f9058..3e66b7cb3a61 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -29,6 +29,8 @@ unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)]
>  							__page_aligned_bss;
>  EXPORT_SYMBOL(empty_zero_page);
>  
> +extern char _start[];
> +
>  static void __init zone_sizes_init(void)
>  {
>  	unsigned long max_zone_pfns[MAX_NR_ZONES] = { 0, };
> @@ -108,23 +110,21 @@ void __init setup_bootmem(void)
>  {
>  	struct memblock_region *reg;
>  	phys_addr_t mem_size = 0;
> +	phys_addr_t vmlinux_end = __pa(&_end);
> +	phys_addr_t vmlinux_start = __pa(&_start);
>  
>  	/* Find the memory region containing the kernel */
>  	for_each_memblock(memory, reg) {
> -		phys_addr_t vmlinux_end = __pa(_end);
>  		phys_addr_t end = reg->base + reg->size;
>  
> -		if (reg->base <= vmlinux_end && vmlinux_end <= end) {
> -			/*
> -			 * Reserve from the start of the region to the end of
> -			 * the kernel
> -			 */
> -			memblock_reserve(reg->base, vmlinux_end - reg->base);
> +		if (reg->base <= vmlinux_end && vmlinux_end <= end)
>  			mem_size = min(reg->size, (phys_addr_t)-PAGE_OFFSET);
> -		}
>  	}
>  	BUG_ON(mem_size == 0);
>  
> +	/* Reserve from the start of the kernel to the end of the kernel */
> +	memblock_reserve(vmlinux_start, vmlinux_end - vmlinux_start);
> +
>  	set_max_mapnr(PFN_DOWN(mem_size));
>  	max_low_pfn = PFN_DOWN(memblock_end_of_DRAM());
>  
> @@ -196,7 +196,6 @@ void __set_fixmap(enum fixed_addresses idx, phys_addr_t phys, pgprot_t prot)
>   */
>  asmlinkage void __init setup_vm(void)
>  {
> -	extern char _start;
>  	uintptr_t i;
>  	uintptr_t pa = (uintptr_t) &_start;
>  	pgprot_t prot = __pgprot(pgprot_val(PAGE_KERNEL) | _PAGE_EXEC);
> -- 
> 2.17.1

I've already merged your first patch for 5.1, but I'm going through and
collecting 5.2 patches now and it appears this has a conflict.  Do you mind
re-submitting the patch set against rc6?
