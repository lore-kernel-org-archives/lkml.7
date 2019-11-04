Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C297C47E49
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 19:35:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 529BB214D9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 19:35:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="N+dW478f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387397AbfKDTfw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Nov 2019 14:35:52 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40295 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728648AbfKDTfv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Nov 2019 14:35:51 -0500
Received: by mail-qk1-f193.google.com with SMTP id a18so1162807qkk.7
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2019 11:35:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s6fHn8D8g/+CM3zb716GGpSYlFO9CSnt8mb/KoMnVMQ=;
        b=N+dW478fUUkocTg2edz1NYtK1+JvORRQO4A6gw9YQA1UDng0xUm9bPmX2hqyD1Df8H
         kvLIgvgLbSx1p+MRzGrZ8rCAV8emMQN5qLhF6HuyEVtKtczydYegpcSF5LaEp2jDlxbw
         EfuWHX9gZIIEFLe8OwxkHmKqNR1xgmGS0dMVnHNE5r77mGMIvQ61raoKiJjU1eCZlcYV
         EHxyMCwS0ZnZJmanO8Qm3cHkROQQ1RjEH8D9QJguzLcnktIzhDYF66tTxczh9wTIzYDt
         gzZodG5Fo4GVZNmyE/1sS7WYYPKP11qdgM/KXD7+bkb8r/npwi6z/ThymNy9pqc0V6XQ
         aKqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s6fHn8D8g/+CM3zb716GGpSYlFO9CSnt8mb/KoMnVMQ=;
        b=JSOaBvKghdajQJvgEbS2hk6+wYHM7bXHU78o5DljSNmqgXqSOSX76lc5GF+/Q45iiO
         tKAsrBFNXo3R+fLkms3J4TR6U0o6t1z3QHPwS291VOt6NSRdKjk1y/pmlVs4ohI6znXQ
         5pYy9HK8qa8iLfxfgdBYiqqJ/afR9kA7HWdP8f0QfjgRtD3QdybkRhdwS6Wbt4bg3goH
         CkHmb/QqCZ6WTXOrre/IXTzG/dkymnBqOhL0FPD45rS21covFOnSgG605WpaDjaqOk+Q
         Ki0rDn0Of9vzkMyKc37NpUVsYKjbpAQtN1F7wlnGpMvMtFalFUkfwNBfUks+dnQMcstG
         P0/g==
X-Gm-Message-State: APjAAAU5ez26mqUWkfgx82cj7ULMLZNUCwVt3nDoric+NvtTNx5Nf8zj
        1Dyx6iTX/RIBiZMe9TgvCVvL/w==
X-Google-Smtp-Source: APXvYqyWl0W2ItouBP+V+7dFZf5/qRiM+6pckVZaokjDz5EIw3v5A/LV2FhCMuVaUaOT3utN4VC7oA==
X-Received: by 2002:a37:a18d:: with SMTP id k135mr711588qke.342.1572896150079;
        Mon, 04 Nov 2019 11:35:50 -0800 (PST)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id k7sm1453061qkf.40.2019.11.04.11.35.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Nov 2019 11:35:49 -0800 (PST)
Message-ID: <1572896147.5937.116.camel@lca.pw>
Subject: Re: [PATCH v15 00/23] Generic page walk and ptdump
From:   Qian Cai <cai@lca.pw>
To:     Steven Price <steven.price@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
Cc:     Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Morse <james.morse@arm.com>,
        =?ISO-8859-1?Q?J=E9r=F4me?= Glisse <jglisse@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <Mark.Rutland@arm.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>
Date:   Mon, 04 Nov 2019 14:35:47 -0500
In-Reply-To: <20191101140942.51554-1-steven.price@arm.com>
References: <20191101140942.51554-1-steven.price@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2019-11-01 at 14:09 +0000, Steven Price wrote:
> Many architectures current have a debugfs file for dumping the kernel
> page tables. Currently each architecture has to implement custom
> functions for this because the details of walking the page tables used
> by the kernel are different between architectures.
> 
> This series extends the capabilities of walk_page_range() so that it can
> deal with the page tables of the kernel (which have no VMAs and can
> contain larger huge pages than exist for user space). A generic PTDUMP
> implementation is the implemented making use of the new functionality of
> walk_page_range() and finally arm64 and x86 are switch to using it,
> removing the custom table walkers.
> 
> To enable a generic page table walker to walk the unusual mappings of
> the kernel we need to implement a set of functions which let us know
> when the walker has reached the leaf entry. After a suggestion from Will
> Deacon I've chosen the name p?d_leaf() as this (hopefully) describes
> the purpose (and is a new name so has no historic baggage). Some
> architectures have p?d_large macros but this is easily confused with
> "large pages".
> 
> This series ends with a generic PTDUMP implemention for arm64 and x86.
> 
> Mostly this is a clean up and there should be very little functional
> change. The exceptions are:
> 
> * arm64 PTDUMP debugfs now displays pages which aren't present (patch 22).
> 
> * arm64 has the ability to efficiently process KASAN pages (which
>   previously only x86 implemented). This means that the combination of
>   KASAN and DEBUG_WX is now useable.
> 
> Also available as a git tree:
> git://linux-arm.org/linux-sp.git walk_page_range/v15
> 
> Changes since v14:
> https://lore.kernel.org/lkml/20191028135910.33253-1-steven.price@arm.com/
>  * Switch walk_page_range() into two functions, the existing
>    walk_page_range() now still requires VMAs (and treats areas without a
>    VMA as a 'hole'). The new walk_page_range_novma() ignores VMAs and
>    will report the actual page table layout. This fixes the previous
>    breakage of /proc/<pid>/pagemap
>  * New patch at the end of the series which reduces the 'level' numbers
>    by 1 to simplify the code slightly
>  * Added tags

Does this new version also take care of this boot crash seen with v14? Suppose
it is now breaking CONFIG_EFI_PGT_DUMP=y? The full config is,

https://raw.githubusercontent.com/cailca/linux-mm/master/x86.config

[   10.550313][    T0] Switched APIC routing to physical flat.
[   10.563899][    T0] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[   10.614633][    T0] clocksource: tsc-early: mask: 0xffffffffffffffff
max_cycles: 0x1fa6f481074, max_idle_ns: 440795311917 ns
[   10.625979][    T0] Calibrating delay loop (skipped), value calculated using
timer frequency.. 4391.73 BogoMIPS (lpj=21958690)
[   10.635990][    T0] pid_max: default: 131072 minimum: 1024
[   11.259736][    T0] ---[ User Space ]---
[   11.263737][    T0] 0x0000000000000000-
0x0000000000001000           4K     RW                     x  pte
[   11.266028][    T0] 0x0000000000001000-
0x0000000000200000        2044K                               pte
[   11.275992][    T0] 0x0000000000200000-
0x0000000004000000          62M                               pmd
[   11.285998][    T0] 0x0000000004000000-
0x0000000004076000         472K                               pte
[   11.296019][    T0] 0x0000000004076000-
0x0000000004200000        1576K                               pte
[   11.305997][    T0] 0x0000000004200000-
0x0000000011000000         206M                               pmd
[   11.316008][    T0] 0x0000000011000000-
0x0000000011100000           1M                               pte
[   11.326008][    T0] 0x0000000011100000-
0x0000000011200000           1M                               pte
[   11.335990][    T0] 0x0000000011200000-
0x0000000011800000           6M                               pmd
[   11.346054][    T0]
==================================================================
[   11.354074][    T0] BUG: KASAN: wild-memory-access in
ptdump_pte_entry+0x39/0x60
[   11.355975][    T0] Read of size 8 at addr 000f887fee5ff000 by task
swapper/0/0
[   11.355975][    T0] 
[   11.355975][    T0] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.4.0-rc5-mm1+
#1
[   11.355975][    T0] Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385
Gen10, BIOS A40 07/10/2019
[   11.355975][    T0] Call Trace:
[   11.355975][    T0]  dump_stack+0xa0/0xea
[   11.355975][    T0]  __kasan_report.cold.7+0xb0/0xc0
[   11.355975][    T0]  ? note_page+0x7f8/0xa70
[   11.355975][    T0]  ? ptdump_pte_entry+0x39/0x60
[   11.355975][    T0]  ? ptdump_walk_pgd_level_core+0x1b0/0x1b0
[   11.355975][    T0]  kasan_report+0x12/0x20
[   11.355975][    T0]  __asan_load8+0x71/0xa0
[   11.355975][    T0]  ptdump_pte_entry+0x39/0x60
[   11.355975][    T0]  walk_pgd_range+0xb75/0xce0
[   11.355975][    T0]  __walk_page_range+0x206/0x230
[   11.355975][    T0]  ? vmacache_find+0x3a/0x170
[   11.355975][    T0]  walk_page_range+0x136/0x210
[   11.355975][    T0]  ? __walk_page_range+0x230/0x230
[   11.355975][    T0]  ? find_held_lock+0xca/0xf0
[   11.355975][    T0]  ptdump_walk_pgd+0x76/0xd0
[   11.355975][    T0]  ptdump_walk_pgd_level_core+0x13b/0x1b0
[   11.355975][    T0]  ? hugetlb_get_unmapped_area+0x5b0/0x5b0
[   11.355975][    T0]  ? trace_hardirqs_on+0x3a/0x160
[   11.355975][    T0]  ? ptdump_walk_pgd_level_core+0x1b0/0x1b0
[   11.355975][    T0]  ? efi_delete_dummy_variable+0xa9/0xd0
[   11.355975][    T0]  ? __enc_copy+0x90/0x90
[   11.355975][    T0]  ptdump_walk_pgd_level+0x15/0x20
[   11.355975][    T0]  efi_dump_pagetable+0x35/0x37
[   11.355975][    T0]  efi_enter_virtual_mode+0x72a/0x737
[   11.355975][    T0]  start_kernel+0x607/0x6a9
[   11.355975][    T0]  ? thread_stack_cache_init+0xb/0xb
[   11.355975][    T0]  ? idt_setup_from_table+0xd9/0x130
[   11.355975][    T0]  x86_64_start_reservations+0x24/0x26
[   11.355975][    T0]  x86_64_start_kernel+0xf4/0xfb
[   11.355975][    T0]  secondary_startup_64+0xb6/0xc0
[   11.355975][    T0]
==================================================================
[   11.355975][    T0] Disabling lock debugging due to kernel taint
[   11.355991][    T0] general protection fault: 0000 [#1] SMP DEBUG_PAGEALLOC
KASAN NOPTI
[   11.364049][    T0] CPU: 0 PID: 0 Comm: swapper/0 Tainted:
G    B             5.4.0-rc5-mm1+ #1
[   11.365975][    T0] Hardware name: HPE ProLiant DL385 Gen10/ProLiant DL385
Gen10, BIOS A40 07/10/2019
[   11.365975][    T0] RIP: 0010:ptdump_pte_entry+0x39/0x60
[   11.365975][    T0] Code: 55 41 54 49 89 fc 48 8d 79 18 53 48 89 cb e8 5e 0e
fa ff 48 8b 5b 18 48 89 df e8 52 0e fa ff 4c 89 e7 4c 8b 2b e8 47 0e fa ff <49>
8b 0c 24 4c 89 f6 48 89 df ba 05 00 00 00 e8 03 1d 9b 00 31 c0
[   11.365975][    T0] RSP: 0000:ffffffffaf8079d0 EFLAGS: 00010282
[   11.365975][    T0] RAX: 0000000000000000 RBX: ffffffffaf807cf0 RCX:
ffffffffae374306
[   11.365975][    T0] RDX: 0000000000000007 RSI: dffffc0000000000 RDI:
ffffffffafef2bf4
[   11.365975][    T0] RBP: ffffffffaf8079f0 R08: fffffbfff5fdbb22 R09:
fffffbfff5fdbb22
[   11.365975][    T0] R10: fffffbfff5fdbb21 R11: ffffffffafedd90b R12:
000f887fee5ff000
[   11.365975][    T0] R13: ffffffffae2aee40 R14: 0000000011a00000 R15:
0000000011a01000
[   11.365975][    T0] FS:  0000000000000000(0000) GS:ffff888843400000(0000)
knlGS:0000000000000000
[   11.365975][    T0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   11.365975][    T0] CR2: ffff8890779ff000 CR3: 0000000baf412000 CR4:
00000000000406b0
[   11.365975][    T0] Call Trace:
[   11.365975][    T0]  walk_pgd_range+0xb75/0xce0
[   11.365975][    T0]  __walk_page_range+0x206/0x230
[   11.365975][    T0]  ? vmacache_find+0x3a/0x170
[   11.365975][    T0]  walk_page_range+0x136/0x210
[   11.365975][    T0]  ? __walk_page_range+0x230/0x230
[   11.365975][    T0]  ? find_held_lock+0xca/0xf0
[   11.365975][    T0]  ptdump_walk_pgd+0x76/0xd0
[   11.365975][    T0]  ptdump_walk_pgd_level_core+0x13b/0x1b0
[   11.365975][    T0]  ? hugetlb_get_unmapped_area+0x5b0/0x5b0
[   11.365975][    T0]  ? trace_hardirqs_on+0x3a/0x160
[   11.365975][    T0]  ? ptdump_walk_pgd_level_core+0x1b0/0x1b0
[   11.365975][    T0]  ? efi_delete_dummy_variable+0xa9/0xd0
[   11.365975][    T0]  ? __enc_copy+0x90/0x90
[   11.365975][    T0]  ptdump_walk_pgd_level+0x15/0x20
[   11.365975][    T0]  efi_dump_pagetable+0x35/0x37
[   11.365975][    T0]  efi_enter_virtual_mode+0x72a/0x737
[   11.365975][    T0]  start_kernel+0x607/0x6a9
[   11.365975][    T0]  ? thread_stack_cache_init+0xb/0xb
[   11.365975][    T0]  ? idt_setup_from_table+0xd9/0x130
[   11.365975][    T0]  x86_64_start_reservations+0x24/0x26
[   11.365975][    T0]  x86_64_start_kernel+0xf4/0xfb
[   11.365975][    T0]  secondary_startup_64+0xb6/0xc0
[   11.365975][    T0] Modules linked in:
[   11.365988][    T0] ---[ end trace 8e90dc89e2468d55 ]---
[   11.375984][    T0] RIP: 0010:ptdump_pte_entry+0x39/0x60
[   11.381335][    T0] Code: 55 41 54 49 89 fc 48 8d 79 18 53 48 89 cb e8 5e 0e
fa ff 48 8b 5b 18 48 89 df e8 52 0e fa ff 4c 89 e7 4c 8b 2b e8 47 0e fa ff <49>
8b 0c 24 4c 89 f6 48 89 df ba 05 00 00 00 e8 03 1d 9b 00 31 c0
[   11.385982][    T0] RSP: 0000:ffffffffaf8079d0 EFLAGS: 00010282
[   11.395982][    T0] RAX: 0000000000000000 RBX: ffffffffaf807cf0 RCX:
ffffffffae374306
[   11.403864][    T0] RDX: 0000000000000007 RSI: dffffc0000000000 RDI:
ffffffffafef2bf4
[   11.405982][    T0] RBP: ffffffffaf8079f0 R08: fffffbfff5fdbb22 R09:
fffffbfff5fdbb22
[   11.415982][    T0] R10: fffffbfff5fdbb21 R11: ffffffffafedd90b R12:
000f887fee5ff000
[   11.425982][    T0] R13: ffffffffae2aee40 R14: 0000000011a00000 R15:
0000000011a01000
[   11.435982][    T0] FS:  0000000000000000(0000) GS:ffff888843400000(0000)
knlGS:0000000000000000
[   11.445982][    T0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   11.452466][    T0] CR2: ffff8890779ff000 CR3: 0000000baf412000 CR4:
00000000000406b0
[   11.455981][    T0] Kernel panic - not syncing: Fatal exception
[   11.462246][    T0] ---[ end Kernel panic - not syncing: Fatal exception ]---

> 
> Changes since v13:
> https://lore.kernel.org/lkml/20191024093716.49420-1-steven.price@arm.com/
>  * Fixed typo in arc definition of pmd_leaf() spotted by the kbuild test
>    robot
>  * Added tags
> 
> Changes since v12:
> https://lore.kernel.org/lkml/20191018101248.33727-1-steven.price@arm.com/
>  * Correct code format in riscv pud_leaf()/pmd_leaf()
>  * v12 may not have reached everyone because of mail server problems
>    (which are now hopefully resolved!)
> 
> Changes since v11:
> https://lore.kernel.org/lkml/20191007153822.16518-1-steven.price@arm.com/
>  * Use "-1" as dummy depth parameter in patch 14.
> 
> Changes since v10:
> https://lore.kernel.org/lkml/20190731154603.41797-1-steven.price@arm.com/
>  * Rebased to v5.4-rc1 - mainly various updates to deal with the
>    splitting out of ops from struct mm_walk.
>  * Deal with PGD_LEVEL_MULT not always being constant on x86.
> 
> Changes since v9:
> https://lore.kernel.org/lkml/20190722154210.42799-1-steven.price@arm.com/
>  * Moved generic macros to first page in the series and explained the
>    macro naming in the commit message.
>  * mips: Moved macros to pgtable.h as they are now valid for both 32 and 64
>    bit
>  * x86: Dropped patch which changed the debugfs output for x86, instead
>    we have...
>  * new patch adding 'depth' parameter to pte_hole. This is used to
>    provide the necessary information to output lines for 'holes' in the
>    debugfs files
>  * new patch changing arm64 debugfs output to include holes to match x86
>  * generic ptdump KASAN handling has been simplified and now works with
>    CONFIG_DEBUG_VIRTUAL.
> 
> Changes since v8:
> https://lore.kernel.org/lkml/20190403141627.11664-1-steven.price@arm.com/
>  * Rename from p?d_large() to p?d_leaf()
>  * Dropped patches migrating arm64/x86 custom walkers to
>    walk_page_range() in favour of adding a generic PTDUMP implementation
>    and migrating arm64/x86 to that instead.
>  * Rebased to v5.3-rc1
> 
> Steven Price (23):
>   mm: Add generic p?d_leaf() macros
>   arc: mm: Add p?d_leaf() definitions
>   arm: mm: Add p?d_leaf() definitions
>   arm64: mm: Add p?d_leaf() definitions
>   mips: mm: Add p?d_leaf() definitions
>   powerpc: mm: Add p?d_leaf() definitions
>   riscv: mm: Add p?d_leaf() definitions
>   s390: mm: Add p?d_leaf() definitions
>   sparc: mm: Add p?d_leaf() definitions
>   x86: mm: Add p?d_leaf() definitions
>   mm: pagewalk: Add p4d_entry() and pgd_entry()
>   mm: pagewalk: Allow walking without vma
>   mm: pagewalk: Add test_p?d callbacks
>   mm: pagewalk: Add 'depth' parameter to pte_hole
>   x86: mm: Point to struct seq_file from struct pg_state
>   x86: mm+efi: Convert ptdump_walk_pgd_level() to take a mm_struct
>   x86: mm: Convert ptdump_walk_pgd_level_debugfs() to take an mm_struct
>   x86: mm: Convert ptdump_walk_pgd_level_core() to take an mm_struct
>   mm: Add generic ptdump
>   x86: mm: Convert dump_pagetables to use walk_page_range
>   arm64: mm: Convert mm/dump.c to use walk_page_range()
>   arm64: mm: Display non-present entries in ptdump
>   mm: ptdump: Reduce level numbers by 1 in note_page()
> 
>  arch/arc/include/asm/pgtable.h               |   1 +
>  arch/arm/include/asm/pgtable-2level.h        |   1 +
>  arch/arm/include/asm/pgtable-3level.h        |   1 +
>  arch/arm64/Kconfig                           |   1 +
>  arch/arm64/Kconfig.debug                     |  19 +-
>  arch/arm64/include/asm/pgtable.h             |   2 +
>  arch/arm64/include/asm/ptdump.h              |   8 +-
>  arch/arm64/mm/Makefile                       |   4 +-
>  arch/arm64/mm/dump.c                         | 148 +++-----
>  arch/arm64/mm/mmu.c                          |   4 +-
>  arch/arm64/mm/ptdump_debugfs.c               |   2 +-
>  arch/mips/include/asm/pgtable.h              |   5 +
>  arch/powerpc/include/asm/book3s/64/pgtable.h |  30 +-
>  arch/riscv/include/asm/pgtable-64.h          |   7 +
>  arch/riscv/include/asm/pgtable.h             |   7 +
>  arch/s390/include/asm/pgtable.h              |   2 +
>  arch/sparc/include/asm/pgtable_64.h          |   2 +
>  arch/x86/Kconfig                             |   1 +
>  arch/x86/Kconfig.debug                       |  20 +-
>  arch/x86/include/asm/pgtable.h               |  10 +-
>  arch/x86/mm/Makefile                         |   4 +-
>  arch/x86/mm/debug_pagetables.c               |   8 +-
>  arch/x86/mm/dump_pagetables.c                | 343 +++++--------------
>  arch/x86/platform/efi/efi_32.c               |   2 +-
>  arch/x86/platform/efi/efi_64.c               |   4 +-
>  drivers/firmware/efi/arm-runtime.c           |   2 +-
>  fs/proc/task_mmu.c                           |   4 +-
>  include/asm-generic/pgtable.h                |  20 ++
>  include/linux/pagewalk.h                     |  42 ++-
>  include/linux/ptdump.h                       |  22 ++
>  mm/Kconfig.debug                             |  21 ++
>  mm/Makefile                                  |   1 +
>  mm/hmm.c                                     |   8 +-
>  mm/migrate.c                                 |   5 +-
>  mm/mincore.c                                 |   1 +
>  mm/pagewalk.c                                | 126 +++++--
>  mm/ptdump.c                                  | 151 ++++++++
>  37 files changed, 586 insertions(+), 453 deletions(-)
>  create mode 100644 include/linux/ptdump.h
>  create mode 100644 mm/ptdump.c
> 
