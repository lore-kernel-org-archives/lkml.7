Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F709C47E49
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 13:31:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE58A218AE
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 13:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="mXiZDkmZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730233AbfKFNb3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 08:31:29 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:40154 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726673AbfKFNb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 08:31:29 -0500
Received: by mail-qk1-f195.google.com with SMTP id a18so6903938qkk.7
        for <linux-kernel@vger.kernel.org>; Wed, 06 Nov 2019 05:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=G+WiPUIG3CrWdd/iWlHup6ErrbIQ6481mPe9TVVrvQQ=;
        b=mXiZDkmZnvX3H/SXw3XSdWctY4ZNagKjvRF+QKgs4wckj4Iz8n840OSjEWSUh0Ergg
         xjUcaT8nEVSOjycOBrACWZUjeNjzq7J43iZ6oVLQ8E1ZInVD0j7l1OC8Ql0qoMj5Sfip
         O0lvdqrUnjZqyn7uSImGRnNzvZnep93hHx8xenXwHOOymowluK8SsSZRPz/yY7yuwKtl
         NkrVU3hNCeJ6vT8Y+qpSg1UE6WoxuMiQoA5kT3tjxdqtHU4Kwpnq0D8lhcMfmeERfc28
         yvzkCPC2F4EFzH9YA8zFl6CBmo39DQ/ynOlAWal8kjniA5D7IOdy7bKdMxOUlh8vBaea
         Z6Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=G+WiPUIG3CrWdd/iWlHup6ErrbIQ6481mPe9TVVrvQQ=;
        b=AjJFsqLws95W8LKKIafZyJ6mBj0sGMgvPP9PKHBNPFV5Wp2cQx67aD5Qwt+eiXm+5U
         yrcQHeLp0vmtHIOkQExff7yvIDEKZPs3tOKU2Rw4q7shS1go5AOI5sIFTpWfbdPg9JPM
         1CDYksOAhrppDINPPiofr6cwuwvT4UzmOoEtf+1NPVQheG//wDvtoEkblj87yG2Ycl/o
         S/HBJT3CL5hewGGQpVUpxVMXWTTw49bL2te0oSC1MhlIV/eWHI0tY40TG1A3C2a3TpZs
         nlY90v3eGVrWirQQAnH3ybdGCmUd+qizpMlh1EXrTirdjtWNKxHbvIsuchY8ip2//J/t
         Hv6w==
X-Gm-Message-State: APjAAAXVY/wEqW0/rP9jwoszaS9FVRdOoKTm0L2heg1EqhxuTVqyw/Xw
        8AbHwXxSAodt6r2OzJ3yaTRxag==
X-Google-Smtp-Source: APXvYqzdeBiCyHfpAPHsMenhV2A+FCafKKeQzrXAhZRzGdmthzVqtHWBRs7H+kUvNJGieZ2ZZZZVWw==
X-Received: by 2002:a05:620a:9c4:: with SMTP id y4mr1998396qky.113.1573047087831;
        Wed, 06 Nov 2019 05:31:27 -0800 (PST)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id a2sm10997955qkb.82.2019.11.06.05.31.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 05:31:27 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3594.4.19\))
Subject: Re: [PATCH v15 00/23] Generic page walk and ptdump
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <1572896147.5937.116.camel@lca.pw>
Date:   Wed, 6 Nov 2019 08:31:25 -0500
Cc:     Andy Lutomirski <luto@kernel.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Morse <james.morse@arm.com>,
        =?utf-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Rutland <Mark.Rutland@arm.com>,
        "Liang, Kan" <kan.liang@linux.intel.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <7B040741-EC8A-4CC0-964B-4046AE2E617A@lca.pw>
References: <20191101140942.51554-1-steven.price@arm.com>
 <1572896147.5937.116.camel@lca.pw>
To:     Steven Price <steven.price@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
X-Mailer: Apple Mail (2.3594.4.19)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 4, 2019, at 2:35 PM, Qian Cai <cai@lca.pw> wrote:
>=20
> On Fri, 2019-11-01 at 14:09 +0000, Steven Price wrote:
>> Many architectures current have a debugfs file for dumping the kernel
>> page tables. Currently each architecture has to implement custom
>> functions for this because the details of walking the page tables =
used
>> by the kernel are different between architectures.
>>=20
>> This series extends the capabilities of walk_page_range() so that it =
can
>> deal with the page tables of the kernel (which have no VMAs and can
>> contain larger huge pages than exist for user space). A generic =
PTDUMP
>> implementation is the implemented making use of the new functionality =
of
>> walk_page_range() and finally arm64 and x86 are switch to using it,
>> removing the custom table walkers.
>>=20
>> To enable a generic page table walker to walk the unusual mappings of
>> the kernel we need to implement a set of functions which let us know
>> when the walker has reached the leaf entry. After a suggestion from =
Will
>> Deacon I've chosen the name p?d_leaf() as this (hopefully) describes
>> the purpose (and is a new name so has no historic baggage). Some
>> architectures have p?d_large macros but this is easily confused with
>> "large pages".
>>=20
>> This series ends with a generic PTDUMP implemention for arm64 and =
x86.
>>=20
>> Mostly this is a clean up and there should be very little functional
>> change. The exceptions are:
>>=20
>> * arm64 PTDUMP debugfs now displays pages which aren't present (patch =
22).
>>=20
>> * arm64 has the ability to efficiently process KASAN pages (which
>>  previously only x86 implemented). This means that the combination of
>>  KASAN and DEBUG_WX is now useable.
>>=20
>> Also available as a git tree:
>> git://linux-arm.org/linux-sp.git walk_page_range/v15
>>=20
>> Changes since v14:
>> =
https://lore.kernel.org/lkml/20191028135910.33253-1-steven.price@arm.com/
>> * Switch walk_page_range() into two functions, the existing
>>   walk_page_range() now still requires VMAs (and treats areas without =
a
>>   VMA as a 'hole'). The new walk_page_range_novma() ignores VMAs and
>>   will report the actual page table layout. This fixes the previous
>>   breakage of /proc/<pid>/pagemap
>> * New patch at the end of the series which reduces the 'level' =
numbers
>>   by 1 to simplify the code slightly
>> * Added tags
>=20
> Does this new version also take care of this boot crash seen with v14? =
Suppose
> it is now breaking CONFIG_EFI_PGT_DUMP=3Dy? The full config is,
>=20
> https://raw.githubusercontent.com/cailca/linux-mm/master/x86.config
>=20

V15 is indeed DOA here.

[   10.957006][    T0] pid_max: default: 131072 minimum: 1024
[   11.543186][    T0] ---[ User Space ]---
[   11.547009][    T0] 0x0000000000000000-0x0000000000001000           =
4K     RW                     x  pte
[   11.556612][    T0] 0x0000000000001000-0x0000000000200000        =
2044K                               pte
[   11.557008][    T0] 0x0000000000200000-0x0000000004000000          =
62M                               pmd
[   11.567014][    T0] 0x0000000004000000-0x0000000004076000         =
472K                               pte
[   11.577033][    T0] 0x0000000004076000-0x0000000004200000        =
1576K                               pte
[   11.587013][    T0] 0x0000000004200000-0x0000000011000000         =
206M                               pmd
[   11.597023][    T0] 0x0000000011000000-0x0000000011100000           =
1M                               pte
[   11.607023][    T0] 0x0000000011100000-0x0000000011200000           =
1M                               pte
[   11.617006][    T0] 0x0000000011200000-0x0000000011800000           =
6M                               pmd
[   11.627068][    T0] =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   11.635087][    T0] BUG: KASAN: wild-memory-access in =
ptdump_pte_entry+0x39/0x60
[   11.636992][    T0] Read of size 8 at addr 000f887fee5ff000 by task =
swapper/0/0
[   11.636992][    T0]=20
[   11.636992][    T0] CPU: 0 PID: 0 Comm: swapper/0 Not tainted =
5.4.0-rc6-next-20191106+ #6
[   11.636992][    T0] Hardware name: HPE ProLiant DL385 Gen10/ProLiant =
DL385 Gen10, BIOS A40 07/10/2019
[   11.636992][    T0] Call Trace:
[   11.636992][    T0]  dump_stack+0xa0/0xea
[   11.636992][    T0]  __kasan_report.cold.7+0xb0/0xc0
[   11.636992][    T0]  ? note_page+0x6a9/0xa70
[   11.636992][    T0]  ? ptdump_pte_entry+0x39/0x60
[   11.636992][    T0]  ? ptdump_walk_pgd_level_core+0x1e0/0x1e0
[   11.636992][    T0]  kasan_report+0x12/0x20
[   11.636992][    T0]  __asan_load8+0x71/0xa0
[   11.636992][    T0]  ptdump_pte_entry+0x39/0x60
[   11.636992][    T0]  walk_pgd_range+0x9e5/0xdb0
[   11.636992][    T0]  __walk_page_range+0x206/0x230
[   11.636992][    T0]  walk_page_range_novma+0xc5/0x130
[   11.636992][    T0]  ? walk_page_range+0x220/0x220
[   11.636992][    T0]  ptdump_walk_pgd+0x76/0xd0
[   11.636992][    T0]  ptdump_walk_pgd_level_core+0x169/0x1e0
[   11.636992][    T0]  ? hugetlb_get_unmapped_area+0x5b0/0x5b0
[   11.636992][    T0]  ? trace_hardirqs_on+0x3a/0x160
[   11.636992][    T0]  ? ptdump_walk_pgd_level_core+0x1e0/0x1e0
[   11.636992][    T0]  ? efi_delete_dummy_variable+0xa9/0xd0
[   11.636992][    T0]  ? __enc_copy+0x90/0x90
[   11.636992][    T0]  ptdump_walk_pgd_level+0x15/0x20
[   11.636992][    T0]  efi_dump_pagetable+0x35/0x37
[   11.636992][    T0]  efi_enter_virtual_mode+0x72a/0x737
[   11.636992][    T0]  start_kernel+0x607/0x6a9
[   11.636992][    T0]  ? thread_stack_cache_init+0xb/0xb
[   11.636992][    T0]  ? idt_setup_from_table+0xd9/0x130
[   11.636992][    T0]  x86_64_start_reservations+0x24/0x26
[   11.636992][    T0]  x86_64_start_kernel+0xf4/0xfb
[   11.636992][    T0]  secondary_startup_64+0xb6/0xc0
[   11.636992][    T0] =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[   11.636992][    T0] Disabling lock debugging due to kernel taint
[   11.637009][    T0] general protection fault: 0000 [#1] SMP =
DEBUG_PAGEALLOC KASAN NOPTI
[   11.645067][    T0] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G    B     =
        5.4.0-rc6-next-20191106+ #6
[   11.646992][    T0] Hardware name: HPE ProLiant DL385 Gen10/ProLiant =
DL385 Gen10, BIOS A40 07/10/2019
[   11.646992][    T0] RIP: 0010:ptdump_pte_entry+0x39/0x60
[   11.646992][    T0] Code: 55 41 54 49 89 fc 48 8d 79 20 53 48 89 cb =
e8 8e 9d fa ff 48 8b 5b 20 48 89 df e8 82 9d fa ff 4c 89 e7 4c 8b 2b e8 =
77 9d fa ff <49> 8b 0c 24 4c 89 f6 48 89 df ba 04 00 00 00 e8 f3 8d 9b =
00 31 c0
[   11.646992][    T0] RSP: 0000:ffffffff8a2079f0 EFLAGS: 00010286
[   11.646992][    T0] RAX: 0000000000000000 RBX: ffffffff8a207cf0 RCX: =
ffffffff88d74576
[   11.646992][    T0] RDX: 0000000000000007 RSI: dffffc0000000000 RDI: =
ffffffff8a8f53d4
[   11.646992][    T0] RBP: ffffffff8a207a10 R08: fffffbfff151c01a R09: =
fffffbfff151c01a
[   11.646992][    T0] R10: fffffbfff151c019 R11: ffffffff8a8e00cb R12: =
000f887fee5ff000
[   11.646992][    T0] R13: ffffffff88caf040 R14: 0000000011a00000 R15: =
ffffffff89cfdcc0
[   11.646992][    T0] FS:  0000000000000000(0000) =
GS:ffff888843400000(0000) knlGS:0000000000000000
[   11.646992][    T0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   11.646992][    T0] CR2: ffff8890779ff000 CR3: 0000000c54a12000 CR4: =
00000000000406b0
[   11.646992][    T0] Call Trace:
[   11.646992][    T0]  walk_pgd_range+0x9e5/0xdb0
[   11.646992][    T0]  __walk_page_range+0x206/0x230
[   11.646992][    T0]  walk_page_range_novma+0xc5/0x130
[   11.646992][    T0]  ? walk_page_range+0x220/0x220
[   11.646992][    T0]  ptdump_walk_pgd+0x76/0xd0
[   11.646992][    T0]  ptdump_walk_pgd_level_core+0x169/0x1e0
[   11.646992][    T0]  ? hugetlb_get_unmapped_area+0x5b0/0x5b0
[   11.646992][    T0]  ? trace_hardirqs_on+0x3a/0x160
[   11.646992][    T0]  ? ptdump_walk_pgd_level_core+0x1e0/0x1e0
[   11.646992][    T0]  ? efi_delete_dummy_variable+0xa9/0xd0
[   11.646992][    T0]  ? __enc_copy+0x90/0x90
[   11.646992][    T0]  ptdump_walk_pgd_level+0x15/0x20
[   11.646992][    T0]  efi_dump_pagetable+0x35/0x37
[   11.646992][    T0]  efi_enter_virtual_mode+0x72a/0x737
[   11.646992][    T0]  start_kernel+0x607/0x6a9
[   11.646992][    T0]  ? thread_stack_cache_init+0xb/0xb
[   11.646992][    T0]  ? idt_setup_from_table+0xd9/0x130
[   11.646992][    T0]  x86_64_start_reservations+0x24/0x26
[   11.646992][    T0]  x86_64_start_kernel+0xf4/0xfb
[   11.646992][    T0]  secondary_startup_64+0xb6/0xc0
[   11.646992][    T0] Modules linked in:
[   11.647003][    T0] ---[ end trace 751e8882de194a93 ]---
[   11.652355][    T0] RIP: 0010:ptdump_pte_entry+0x39/0x60
[   11.657001][    T0] Code: 55 41 54 49 89 fc 48 8d 79 20 53 48 89 cb =
e8 8e 9d fa ff 48 8b 5b 20 48 89 df e8 82 9d fa ff 4c 89 e7 4c 8b 2b e8 =
77 9d fa ff <49> 8b 0c 24 4c 89 f6 48 89 df ba 04 00 00 00 e8 f3 8d 9b =
00 31 c0
[   11.666998][    T0] RSP: 0000:ffffffff8a2079f0 EFLAGS: 00010286
[   11.672961][    T0] RAX: 0000000000000000 RBX: ffffffff8a207cf0 RCX: =
ffffffff88d74576
[   11.676998][    T0] RDX: 0000000000000007 RSI: dffffc0000000000 RDI: =
ffffffff8a8f53d4
[   11.686998][    T0] RBP: ffffffff8a207a10 R08: fffffbfff151c01a R09: =
fffffbfff151c01a
[   11.696998][    T0] R10: fffffbfff151c019 R11: ffffffff8a8e00cb R12: =
000f887fee5ff000
[   11.704882][    T0] R13: ffffffff88caf040 R14: 0000000011a00000 R15: =
ffffffff89cfdcc0
[   11.706999][    T0] FS:  0000000000000000(0000) =
GS:ffff888843400000(0000) knlGS:0000000000000000
[   11.716998][    T0] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   11.726998][    T0] CR2: ffff8890779ff000 CR3: 0000000c54a12000 CR4: =
00000000000406b0
[   11.736998][    T0] Kernel panic - not syncing: Fatal exception
[   11.743272][    T0] ---[ end Kernel panic - not syncing: Fatal =
exception ]---

>>=20
>> Changes since v13:
>> =
https://lore.kernel.org/lkml/20191024093716.49420-1-steven.price@arm.com/
>> * Fixed typo in arc definition of pmd_leaf() spotted by the kbuild =
test
>>   robot
>> * Added tags
>>=20
>> Changes since v12:
>> =
https://lore.kernel.org/lkml/20191018101248.33727-1-steven.price@arm.com/
>> * Correct code format in riscv pud_leaf()/pmd_leaf()
>> * v12 may not have reached everyone because of mail server problems
>>   (which are now hopefully resolved!)
>>=20
>> Changes since v11:
>> =
https://lore.kernel.org/lkml/20191007153822.16518-1-steven.price@arm.com/
>> * Use "-1" as dummy depth parameter in patch 14.
>>=20
>> Changes since v10:
>> =
https://lore.kernel.org/lkml/20190731154603.41797-1-steven.price@arm.com/
>> * Rebased to v5.4-rc1 - mainly various updates to deal with the
>>   splitting out of ops from struct mm_walk.
>> * Deal with PGD_LEVEL_MULT not always being constant on x86.
>>=20
>> Changes since v9:
>> =
https://lore.kernel.org/lkml/20190722154210.42799-1-steven.price@arm.com/
>> * Moved generic macros to first page in the series and explained the
>>   macro naming in the commit message.
>> * mips: Moved macros to pgtable.h as they are now valid for both 32 =
and 64
>>   bit
>> * x86: Dropped patch which changed the debugfs output for x86, =
instead
>>   we have...
>> * new patch adding 'depth' parameter to pte_hole. This is used to
>>   provide the necessary information to output lines for 'holes' in =
the
>>   debugfs files
>> * new patch changing arm64 debugfs output to include holes to match =
x86
>> * generic ptdump KASAN handling has been simplified and now works =
with
>>   CONFIG_DEBUG_VIRTUAL.
>>=20
>> Changes since v8:
>> =
https://lore.kernel.org/lkml/20190403141627.11664-1-steven.price@arm.com/
>> * Rename from p?d_large() to p?d_leaf()
>> * Dropped patches migrating arm64/x86 custom walkers to
>>   walk_page_range() in favour of adding a generic PTDUMP =
implementation
>>   and migrating arm64/x86 to that instead.
>> * Rebased to v5.3-rc1
>>=20
>> Steven Price (23):
>>  mm: Add generic p?d_leaf() macros
>>  arc: mm: Add p?d_leaf() definitions
>>  arm: mm: Add p?d_leaf() definitions
>>  arm64: mm: Add p?d_leaf() definitions
>>  mips: mm: Add p?d_leaf() definitions
>>  powerpc: mm: Add p?d_leaf() definitions
>>  riscv: mm: Add p?d_leaf() definitions
>>  s390: mm: Add p?d_leaf() definitions
>>  sparc: mm: Add p?d_leaf() definitions
>>  x86: mm: Add p?d_leaf() definitions
>>  mm: pagewalk: Add p4d_entry() and pgd_entry()
>>  mm: pagewalk: Allow walking without vma
>>  mm: pagewalk: Add test_p?d callbacks
>>  mm: pagewalk: Add 'depth' parameter to pte_hole
>>  x86: mm: Point to struct seq_file from struct pg_state
>>  x86: mm+efi: Convert ptdump_walk_pgd_level() to take a mm_struct
>>  x86: mm: Convert ptdump_walk_pgd_level_debugfs() to take an =
mm_struct
>>  x86: mm: Convert ptdump_walk_pgd_level_core() to take an mm_struct
>>  mm: Add generic ptdump
>>  x86: mm: Convert dump_pagetables to use walk_page_range
>>  arm64: mm: Convert mm/dump.c to use walk_page_range()
>>  arm64: mm: Display non-present entries in ptdump
>>  mm: ptdump: Reduce level numbers by 1 in note_page()
>>=20
>> arch/arc/include/asm/pgtable.h               |   1 +
>> arch/arm/include/asm/pgtable-2level.h        |   1 +
>> arch/arm/include/asm/pgtable-3level.h        |   1 +
>> arch/arm64/Kconfig                           |   1 +
>> arch/arm64/Kconfig.debug                     |  19 +-
>> arch/arm64/include/asm/pgtable.h             |   2 +
>> arch/arm64/include/asm/ptdump.h              |   8 +-
>> arch/arm64/mm/Makefile                       |   4 +-
>> arch/arm64/mm/dump.c                         | 148 +++-----
>> arch/arm64/mm/mmu.c                          |   4 +-
>> arch/arm64/mm/ptdump_debugfs.c               |   2 +-
>> arch/mips/include/asm/pgtable.h              |   5 +
>> arch/powerpc/include/asm/book3s/64/pgtable.h |  30 +-
>> arch/riscv/include/asm/pgtable-64.h          |   7 +
>> arch/riscv/include/asm/pgtable.h             |   7 +
>> arch/s390/include/asm/pgtable.h              |   2 +
>> arch/sparc/include/asm/pgtable_64.h          |   2 +
>> arch/x86/Kconfig                             |   1 +
>> arch/x86/Kconfig.debug                       |  20 +-
>> arch/x86/include/asm/pgtable.h               |  10 +-
>> arch/x86/mm/Makefile                         |   4 +-
>> arch/x86/mm/debug_pagetables.c               |   8 +-
>> arch/x86/mm/dump_pagetables.c                | 343 =
+++++--------------
>> arch/x86/platform/efi/efi_32.c               |   2 +-
>> arch/x86/platform/efi/efi_64.c               |   4 +-
>> drivers/firmware/efi/arm-runtime.c           |   2 +-
>> fs/proc/task_mmu.c                           |   4 +-
>> include/asm-generic/pgtable.h                |  20 ++
>> include/linux/pagewalk.h                     |  42 ++-
>> include/linux/ptdump.h                       |  22 ++
>> mm/Kconfig.debug                             |  21 ++
>> mm/Makefile                                  |   1 +
>> mm/hmm.c                                     |   8 +-
>> mm/migrate.c                                 |   5 +-
>> mm/mincore.c                                 |   1 +
>> mm/pagewalk.c                                | 126 +++++--
>> mm/ptdump.c                                  | 151 ++++++++
>> 37 files changed, 586 insertions(+), 453 deletions(-)
>> create mode 100644 include/linux/ptdump.h
>> create mode 100644 mm/ptdump.c
>>=20

