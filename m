Return-Path: <SRS0=vI2Y=WC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32C70C433FF
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 23:58:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1786216F4
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Aug 2019 23:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1565135908;
	bh=j/RvlO/MM/u062VCfMQ2ZMvgSxU6N459yDU0a9QHEGM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Sje/oS4JnThNFaruuwqX6VIvY8mk3FmHCH272cHZ4mk0pfBP1ei2UUorsiYFtwDTl
	 xqJXVonbz3iFIOeyRHsz1dgY7i+VWUDnXarL/NCoBW73T3cmx3HmCIhLdj4d5X2HFb
	 8v485X8MutZq750b0lsOF3+3YQOl6uKyoi5/wu8I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbfHFX60 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Aug 2019 19:58:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:59396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726133AbfHFX60 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Aug 2019 19:58:26 -0400
Received: from localhost.localdomain (c-73-223-200-170.hsd1.ca.comcast.net [73.223.200.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96CCD20663;
        Tue,  6 Aug 2019 23:58:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565135905;
        bh=j/RvlO/MM/u062VCfMQ2ZMvgSxU6N459yDU0a9QHEGM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Sv03h4En6sHUvjYMfXRk7QmI1g/wUlUCsu+aLDz8UlUIF+0+cyQ6Di38j7Nnhrysv
         4SOmjpm0qbcj0ZtINtXe+NNaZM+B40VBZiQd0Ldi81tCJ4rI86C8d8hc1svMxl0Ha0
         p2uze6hxnY52pKINnpq4ffN6GSw4LSF0BCnJxCUg=
Date:   Tue, 6 Aug 2019 16:58:23 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Steven Price <steven.price@arm.com>
Cc:     linux-mm@kvack.org, Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Morse <james.morse@arm.com>,
        =?UTF-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <Mark.Rutland@arm.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>
Subject: Re: [PATCH v10 20/22] x86: mm: Convert dump_pagetables to use
 walk_page_range
Message-Id: <20190806165823.3f735b45a7c4163aca20a767@linux-foundation.org>
In-Reply-To: <20190731154603.41797-21-steven.price@arm.com>
References: <20190731154603.41797-1-steven.price@arm.com>
        <20190731154603.41797-21-steven.price@arm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 31 Jul 2019 16:46:01 +0100 Steven Price <steven.price@arm.com> wrote:

> Make use of the new functionality in walk_page_range to remove the
> arch page walking code and use the generic code to walk the page tables.
> 
> The effective permissions are passed down the chain using new fields
> in struct pg_state.
> 
> The KASAN optimisation is implemented by including test_p?d callbacks
> which can decide to skip an entire tree of entries
> 
> ...
>
> +static const struct ptdump_range ptdump_ranges[] = {
> +#ifdef CONFIG_X86_64
>  
> -#define pgd_large(a) (pgtable_l5_enabled() ? pgd_large(a) : p4d_large(__p4d(pgd_val(a))))
> -#define pgd_none(a)  (pgtable_l5_enabled() ? pgd_none(a) : p4d_none(__p4d(pgd_val(a))))
> +#define normalize_addr_shift (64 - (__VIRTUAL_MASK_SHIFT + 1))
> +#define normalize_addr(u) ((signed long)(u << normalize_addr_shift) \
> +				>> normalize_addr_shift)
>  
> -static inline bool is_hypervisor_range(int idx)
> -{
> -#ifdef CONFIG_X86_64
> -	/*
> -	 * A hole in the beginning of kernel address space reserved
> -	 * for a hypervisor.
> -	 */
> -	return	(idx >= pgd_index(GUARD_HOLE_BASE_ADDR)) &&
> -		(idx <  pgd_index(GUARD_HOLE_END_ADDR));
> +	{0, PTRS_PER_PGD * PGD_LEVEL_MULT / 2},
> +	{normalize_addr(PTRS_PER_PGD * PGD_LEVEL_MULT / 2), ~0UL},

This blows up because PGD_LEVEL_MULT is sometimes not a constant.

x86_64 allmodconfig:

In file included from ./arch/x86/include/asm/pgtable_types.h:249:0,
                 from ./arch/x86/include/asm/paravirt_types.h:45,
                 from ./arch/x86/include/asm/ptrace.h:94,
                 from ./arch/x86/include/asm/math_emu.h:5,
                 from ./arch/x86/include/asm/processor.h:12,
                 from ./arch/x86/include/asm/cpufeature.h:5,
                 from ./arch/x86/include/asm/thread_info.h:53,
                 from ./include/linux/thread_info.h:38,
                 from ./arch/x86/include/asm/preempt.h:7,
                 from ./include/linux/preempt.h:78,
                 from ./include/linux/spinlock.h:51,
                 from ./include/linux/wait.h:9,
                 from ./include/linux/wait_bit.h:8,
                 from ./include/linux/fs.h:6,
                 from ./include/linux/debugfs.h:15,
                 from arch/x86/mm/dump_pagetables.c:11:
./arch/x86/include/asm/pgtable_64_types.h:56:22: error: initializer element is not constant
 #define PTRS_PER_PGD 512
                      ^
arch/x86/mm/dump_pagetables.c:363:6: note: in expansion of macro ‘PTRS_PER_PGD’
  {0, PTRS_PER_PGD * PGD_LEVEL_MULT / 2},
      ^~~~~~~~~~~~
./arch/x86/include/asm/pgtable_64_types.h:56:22: note: (near initialization for ‘ptdump_ranges[0].end’)
 #define PTRS_PER_PGD 512
                      ^
arch/x86/mm/dump_pagetables.c:363:6: note: in expansion of macro ‘PTRS_PER_PGD’
  {0, PTRS_PER_PGD * PGD_LEVEL_MULT / 2},
      ^~~~~~~~~~~~
arch/x86/mm/dump_pagetables.c:360:27: error: initializer element is not constant
 #define normalize_addr(u) ((signed long)(u << normalize_addr_shift) \
                           ^
arch/x86/mm/dump_pagetables.c:364:3: note: in expansion of macro ‘normalize_addr’
  {normalize_addr(PTRS_PER_PGD * PGD_LEVEL_MULT / 2), ~0UL},
   ^~~~~~~~~~~~~~
arch/x86/mm/dump_pagetables.c:360:27: note: (near initialization for ‘ptdump_ranges[1].start’)
 #define normalize_addr(u) ((signed long)(u << normalize_addr_shift) \
                           ^
arch/x86/mm/dump_pagetables.c:364:3: note: in expansion of macro ‘normalize_addr’
  {normalize_addr(PTRS_PER_PGD * PGD_LEVEL_MULT / 2), ~0UL},

I don't know what to do about this so I'll drop the series.
