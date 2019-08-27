Return-Path: <SRS0=qJmF=WX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 300B7C3A59F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 00:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0296620850
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Aug 2019 00:13:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="H9Kk7EsS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbfH0AN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 20:13:26 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41181 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbfH0ANZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 20:13:25 -0400
Received: by mail-pg1-f195.google.com with SMTP id x15so11574403pgg.8
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2019 17:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Iw6JNWRP3igEjjbsY2DrjeSufzb3AiZwDl6GtE2wNmQ=;
        b=H9Kk7EsSWtOGwDBBXZTaiLDAh5a1CmQ5esXABzmC/dKl4QkDAHnLeMUeqiCnWxa1gP
         6B3Etsb8xeqdUYbeTB7DjXOuVflwu03YeST4etZacSsHDo0XzcX5F5cZ8v4LMjVAsMyh
         yWsZ1SqONunlv2fYuisr0dDHh2luMguN3vfvwun6XlvEWS6XKjzAR8YIY/eqdbEdKAzX
         o8bBrWJbnScDvU/btyFAiwrxjQZs91OpmUD4fP5cKTGM1SPVth8BuZUhCrAHQKcZOnSC
         Cm/TTNqRq1j9Iyk0UY+5dl2/QIG4arHrAKczc5/DteCLRIeccmm+6pywJNCEYYZOoSfT
         zwJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Iw6JNWRP3igEjjbsY2DrjeSufzb3AiZwDl6GtE2wNmQ=;
        b=sIBBZKLnuDEvdBPuXDGOJrbp0uYTWOz/b8A004/VRzlydT709XZlejL3Y0dWE5SgqA
         X197nnAxS8tt2VSh45bHUwndOaqQXM+UdtLJyUivYPd9F94HweZMTp9VZTXawfaqwKq3
         9cIUEuMnZVZN9wEyrrag6CknbrT7W59uBByToN1DYa/U327dBZtaivUqEF1HMU85jH85
         LyLiJMMAT/a/5BPcB/eFRpETqQGVYKCM3EzAQ77FaHr87ZRMtjh4SXW+xOuHJLVZw1gH
         GT36xp31fCf963+jwp1qJs4D82Ed/rQOKvx53yLhKz1n2ne4ZNqaxnbFSrGVgFDDOF+D
         mk/Q==
X-Gm-Message-State: APjAAAUtBs/1yEcEfNk6V5sbNuJVx7dT/63okHkvKi+go+rUdmJWzjO/
        koWIUZlOOrlXRVz/M6pfpYJw1g==
X-Google-Smtp-Source: APXvYqx6u1wwF4tgUg81853PTvaK/j5q0KHWzOBzXOEEHdr0Jg/DZ7R06Oea/jeHX1iyLYWkTf4fMw==
X-Received: by 2002:a65:5a8c:: with SMTP id c12mr18420410pgt.73.1566864804459;
        Mon, 26 Aug 2019 17:13:24 -0700 (PDT)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id j11sm566443pjb.11.2019.08.26.17.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Aug 2019 17:13:23 -0700 (PDT)
Date:   Mon, 26 Aug 2019 17:13:23 -0700 (PDT)
From:   Paul Walmsley <paul.walmsley@sifive.com>
X-X-Sender: paulw@viisi.sifive.com
To:     Anup Patel <Anup.Patel@wdc.com>
cc:     Palmer Dabbelt <palmer@sifive.com>,
        Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Christoph Hellwig <hch@infradead.org>,
        Anup Patel <anup@brainfault.org>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] RISC-V: Fix FIXMAP area corruption on RV32 systems
In-Reply-To: <20190819051345.81097-1-anup.patel@wdc.com>
Message-ID: <alpine.DEB.2.21.9999.1908261704500.10109@viisi.sifive.com>
References: <20190819051345.81097-1-anup.patel@wdc.com>
User-Agent: Alpine 2.21.9999 (DEB 301 2018-08-15)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Anup,

On Mon, 19 Aug 2019, Anup Patel wrote:

> Currently, various virtual memory areas of Linux RISC-V are organized
> in increasing order of their virtual addresses is as follows:
> 1. User space area (This is lowest area and starts at 0x0)
> 2. FIXMAP area
> 3. VMALLOC area
> 4. Kernel area (This is highest area and starts at PAGE_OFFSET)
> 
> The maximum size of user space aread is represented by TASK_SIZE.
> 
> On RV32 systems, TASK_SIZE is defined as VMALLOC_START which causes the
> user space area to overlap the FIXMAP area. This allows user space apps
> to potentially corrupt the FIXMAP area and kernel OF APIs will crash
> whenever they access corrupted FDT in the FIXMAP area.
> 
> On RV64 systems, TASK_SIZE is set to fixed 256GB and no other areas
> happen to overlap so we don't see any FIXMAP area corruptions.
> 
> This patch fixes FIXMAP area corruption on RV32 systems by setting
> TASK_SIZE to FIXADDR_START. 

This part -- the TASK_SIZE change -- makes sense to me.  

However, the patch also changes FIXADDR_SIZE to be defined in terms of 
page table-related constants.  Previously, FIXADDR_SIZE was based on 
__end_of_fixed_addresses, as it is for most other architectures. The part 
of the patch that changes FIXADDR_SIZE seems unrelated to the actual fix.

If that's indeed the case -- that the change to FIXADDR_SIZE is unrelated 
from the fix -- could you please split that into a separate patch, with a 
description of the rationale?  I think I understand why you're proposing 
it, but it seems odd to explicitly connect it to page table-related 
constants, rather than the contents of "enum fixed_addresses", and I'm 
reluctant to merge that part of this patch without a bit more discussion.


> We also move FIXADDR_TOP, FIXADDR_SIZE, and FIXADDR_START defines to 
> asm/pgtable.h so that we can avoid cyclic header includes.
> 
> Signed-off-by: Anup Patel <anup.patel@wdc.com>
> Tested-by: Alistair Francis <alistair.francis@wdc.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
> Changes since v1:
> - Drop braces from "#define FIXADDR_TOP"
> ---
>  arch/riscv/include/asm/fixmap.h  |  4 ----
>  arch/riscv/include/asm/pgtable.h | 12 ++++++++++--
>  2 files changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/riscv/include/asm/fixmap.h b/arch/riscv/include/asm/fixmap.h
> index 9c66033c3a54..161f28d04a07 100644
> --- a/arch/riscv/include/asm/fixmap.h
> +++ b/arch/riscv/include/asm/fixmap.h
> @@ -30,10 +30,6 @@ enum fixed_addresses {
>  	__end_of_fixed_addresses
>  };
> 
> -#define FIXADDR_SIZE		(__end_of_fixed_addresses * PAGE_SIZE)
> -#define FIXADDR_TOP		(VMALLOC_START)
> -#define FIXADDR_START		(FIXADDR_TOP - FIXADDR_SIZE)
> -
>  #define FIXMAP_PAGE_IO		PAGE_KERNEL
> 
>  #define __early_set_fixmap	__set_fixmap
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index a364aba23d55..c24a083b3e12 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -420,14 +420,22 @@ static inline void pgtable_cache_init(void)
>  #define VMALLOC_END      (PAGE_OFFSET - 1)
>  #define VMALLOC_START    (PAGE_OFFSET - VMALLOC_SIZE)
> 
> +#define FIXADDR_TOP      VMALLOC_START
> +#ifdef CONFIG_64BIT
> +#define FIXADDR_SIZE     PMD_SIZE
> +#else
> +#define FIXADDR_SIZE     PGDIR_SIZE
> +#endif
> +#define FIXADDR_START    (FIXADDR_TOP - FIXADDR_SIZE)
> +
>  /*
> - * Task size is 0x4000000000 for RV64 or 0xb800000 for RV32.
> + * Task size is 0x4000000000 for RV64 or 0x9fc00000 for RV32.
>   * Note that PGDIR_SIZE must evenly divide TASK_SIZE.
>   */
>  #ifdef CONFIG_64BIT
>  #define TASK_SIZE (PGDIR_SIZE * PTRS_PER_PGD / 2)
>  #else
> -#define TASK_SIZE VMALLOC_START
> +#define TASK_SIZE FIXADDR_START
>  #endif
> 
>  #include <asm-generic/pgtable.h>
> --
> 2.17.1
> 


- Paul
