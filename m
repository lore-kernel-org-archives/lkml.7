Return-Path: <SRS0=5wok=UM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 803E6C31E45
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 17:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4105A2053B
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Jun 2019 17:16:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="beXgyiFT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389427AbfFMRQF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Jun 2019 13:16:05 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:40221 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728730AbfFLVr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 17:47:56 -0400
Received: by mail-qt1-f195.google.com with SMTP id a15so20222880qtn.7
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2019 14:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y0R9Y5u/14fp61TO2tgS0lleO5LVMXg1GWU2GeivAkE=;
        b=beXgyiFTypCCT7C2TrYAkQEQ0Y86bX3UbsGVolyft6dR6Mt92hZkgJmSSb2JxPgki0
         0MumfjpqiGfvbQs0a+dKwXlXwCuis/fuvq6ZOco4wK/eAJfARhE15Qq6WzD5OVyA0whm
         dfJDbyrOIvncQ5Svk5oh1I251ExLsKEzr+C7mbO46X/Xio4UNznpfyfa2xpogV70ae4p
         viuZOzQL2C7m48ncI99u2Ga0f9a0gnJyIGARpk5hkr5blLbUCEoYIbNar5ZNssvKNKzw
         yfY3aiy8frBZi5N9rgTfzT+jy0SdpdfGlZ0l0MbptX2RhJrrF+85RF/8YYUyy+3lRS56
         Nh+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y0R9Y5u/14fp61TO2tgS0lleO5LVMXg1GWU2GeivAkE=;
        b=g9NpYYLVB6dpLmRNGECPfO0l5QbWBBgQZNRpASlczGTru79CxE0yHHvgExHWpSakZW
         oha7aR5Qc0egIoFj9OVRxwb69KBgy3DIBgVVHqe5Dsx2m8Np8hhCoKC3EjIZuFcfNtNF
         qgx/odmkStJiX+U7Zj2kWrP3uNXSfZvr3nwRa6uE1rUxOjLSxmQEgEfWHgK/tmZjN+fp
         PMD1G5xd5PhJ5+YoeCnzc14Q99aXUWntGBk8HvDA2PpCSxqDMhy5CEWYbREyxuo2yVTi
         yV46bmqcsndTH+35ndmwlkNXvLE4TFfKIGtMOjr/22Q4wgPJcBqbxMQn/9K0YtQMvLcT
         IhDg==
X-Gm-Message-State: APjAAAXBfKbJ/eStffHGTOuQKLLrNKH6PAF5k5D/Ivlt/quAv4Y+eEcP
        0Ilz3DD6n3MDCbLJZBf73142OA==
X-Google-Smtp-Source: APXvYqxXkJkA8xB0YuhIuSFsctmSzyPfokdRN7DZ3rGl3SeyAV3D9s9kFsPr0UVZnIgGvg2O7KvEPQ==
X-Received: by 2002:ac8:25b1:: with SMTP id e46mr52982677qte.36.1560376074795;
        Wed, 12 Jun 2019 14:47:54 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id 32sm403098qta.91.2019.06.12.14.47.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Jun 2019 14:47:53 -0700 (PDT)
Message-ID: <1560376072.5154.6.camel@lca.pw>
Subject: Re: [PATCH -next] mm/hotplug: skip bad PFNs from
 pfn_to_online_page()
From:   Qian Cai <cai@lca.pw>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>,
        Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Wed, 12 Jun 2019 17:47:52 -0400
In-Reply-To: <CAPcyv4iuNYXmF0-EMP8GF5aiPsWF+pOFMYKCnr509WoAQ0VNUA@mail.gmail.com>
References: <1560366952-10660-1-git-send-email-cai@lca.pw>
         <CAPcyv4hn0Vz24s5EWKr39roXORtBTevZf7dDutH+jwapgV3oSw@mail.gmail.com>
         <CAPcyv4iuNYXmF0-EMP8GF5aiPsWF+pOFMYKCnr509WoAQ0VNUA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-06-12 at 12:38 -0700, Dan Williams wrote:
> On Wed, Jun 12, 2019 at 12:37 PM Dan Williams <dan.j.williams@intel.com>
> wrote:
> > 
> > On Wed, Jun 12, 2019 at 12:16 PM Qian Cai <cai@lca.pw> wrote:
> > > 
> > > The linux-next commit "mm/sparsemem: Add helpers track active portions
> > > of a section at boot" [1] causes a crash below when the first kmemleak
> > > scan kthread kicks in. This is because kmemleak_scan() calls
> > > pfn_to_online_page(() which calls pfn_valid_within() instead of
> > > pfn_valid() on x86 due to CONFIG_HOLES_IN_ZONE=n.
> > > 
> > > The commit [1] did add an additional check of pfn_section_valid() in
> > > pfn_valid(), but forgot to add it in the above code path.
> > > 
> > > page:ffffea0002748000 is uninitialized and poisoned
> > > raw: ffffffffffffffff ffffffffffffffff ffffffffffffffff ffffffffffffffff
> > > raw: ffffffffffffffff ffffffffffffffff ffffffffffffffff ffffffffffffffff
> > > page dumped because: VM_BUG_ON_PAGE(PagePoisoned(p))
> > > ------------[ cut here ]------------
> > > kernel BUG at include/linux/mm.h:1084!
> > > invalid opcode: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN PTI
> > > CPU: 5 PID: 332 Comm: kmemleak Not tainted 5.2.0-rc4-next-20190612+ #6
> > > Hardware name: Lenovo ThinkSystem SR530 -[7X07RCZ000]-/-[7X07RCZ000]-,
> > > BIOS -[TEE113T-1.00]- 07/07/2017
> > > RIP: 0010:kmemleak_scan+0x6df/0xad0
> > > Call Trace:
> > >  kmemleak_scan_thread+0x9f/0xc7
> > >  kthread+0x1d2/0x1f0
> > >  ret_from_fork+0x35/0x4
> > > 
> > > [1] https://patchwork.kernel.org/patch/10977957/
> > > 
> > > Signed-off-by: Qian Cai <cai@lca.pw>
> > > ---
> > >  include/linux/memory_hotplug.h | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/include/linux/memory_hotplug.h
> > > b/include/linux/memory_hotplug.h
> > > index 0b8a5e5ef2da..f02be86077e3 100644
> > > --- a/include/linux/memory_hotplug.h
> > > +++ b/include/linux/memory_hotplug.h
> > > @@ -28,6 +28,7 @@
> > >         unsigned long ___nr = pfn_to_section_nr(___pfn);           \
> > >                                                                    \
> > >         if (___nr < NR_MEM_SECTIONS && online_section_nr(___nr) && \
> > > +           pfn_section_valid(__nr_to_section(___nr), pfn) &&      \
> > >             pfn_valid_within(___pfn))                              \
> > >                 ___page = pfn_to_page(___pfn);                     \
> > >         ___page;                                                   \
> > 
> > Looks ok to me:
> > 
> > Acked-by: Dan Williams <dan.j.williams@intel.com>
> > 
> > ...but why is pfn_to_online_page() a multi-line macro instead of a
> > static inline like all the helper routines it invokes?
> 
> I do need to send out a refreshed version of the sub-section patchset,
> so I'll fold this in and give you a Reported-by credit.

BTW, not sure if your new version will fix those two problem below due to the
same commit.

https://patchwork.kernel.org/patch/10977957/

1) offline is busted [1]. It looks like test_pages_in_a_zone() missed the same
pfn_section_valid() check.

2) powerpc booting is generating endless warnings [2]. In vmemmap_populated() at
arch/powerpc/mm/init_64.c, I tried to change PAGES_PER_SECTION to
PAGES_PER_SUBSECTION, but it alone seems not enough.

[1]
[  415.158451][ T1946] page:ffffea00016a0000 is uninitialized and poisoned
[  415.158459][ T1946] raw: ffffffffffffffff ffffffffffffffff ffffffffffffffff
ffffffffffffffff
[  415.226266][ T1946] raw: ffffffffffffffff ffffffffffffffff ffffffffffffffff
ffffffffffffffff
[  415.264284][ T1946] page dumped because: VM_BUG_ON_PAGE(PagePoisoned(p))
[  415.294332][ T1946] page_owner info is not active (free page?)
[  415.320902][ T1946] ------------[ cut here ]------------
[  415.345340][ T1946] kernel BUG at include/linux/mm.h:1084!
[  415.370284][ T1946] invalid opcode: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN PTI
[  415.402589][ T1946] CPU: 12 PID: 1946 Comm: test.sh Not tainted 5.2.0-rc4-
next-20190612+ #6
[  415.444923][ T1946] Hardware name: HP ProLiant XL420 Gen9/ProLiant XL420
Gen9, BIOS U19 12/27/2015
[  415.485079][ T1946] RIP: 0010:test_pages_in_a_zone+0x285/0x310
[  415.511320][ T1946] Code: c6 c0 96 4c a2 48 89 df e8 18 23 f6 ff 0f 0b 48 c7
c7 80 c7 ad a2 e8 ae c2 1f 00 48 c7 c6 c0 96 4c a2 48 89 cf e8 fb 22 f6 ff <0f>
0b 48 c7 c7 00 c8 ad a2 e8 91 c2 1f 00 48 85 db 0f 84 3c ff ff
[  415.598840][ T1946] RSP: 0018:ffff88832ba37930 EFLAGS: 00010292
[  415.625597][ T1946] RAX: 0000000000000000 RBX: ffff88847fff36c0 RCX:
ffffffffa1b40b78
[  415.660713][ T1946] RDX: 0000000000000000 RSI: 0000000000000008 RDI:
ffff88884743d380
[  415.695778][ T1946] RBP: ffff88832ba37988 R08: ffffed1108e87a71 R09:
ffffed1108e87a70
[  415.730831][ T1946] R10: ffffed1108e87a70 R11: ffff88884743d387 R12:
0000000000060000
[  415.766058][ T1946] R13: 0000000000060000 R14: 0000000000060000 R15:
000000000005a800
[  415.800727][ T1946] FS:  00007fca293e7740(0000) GS:ffff888847400000(0000)
knlGS:0000000000000000
[  415.840114][ T1946] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  415.868966][ T1946] CR2: 0000558da8ffffc0 CR3: 00000002bff10006 CR4:
00000000001606a0
[  415.904736][ T1946] Call Trace:
[  415.920601][ T1946]  __offline_pages+0xdd/0x990
[  415.942887][ T1946]  ? online_pages+0x4f0/0x4f0
[  415.963195][ T1946]  ? kasan_check_write+0x14/0x20
[  415.984710][ T1946]  ? __mutex_lock+0x2ac/0xb70
[  416.004986][ T1946]  ? device_offline+0x70/0x110
[  416.025654][ T1946]  ? klist_next+0x43/0x1c0
[  416.044819][ T1946]  ? __mutex_add_waiter+0xc0/0xc0
[  416.066741][ T1946]  ? do_raw_spin_unlock+0xa8/0x140
[  416.089036][ T1946]  ? klist_next+0xf2/0x1c0
[  416.108178][ T1946]  offline_pages+0x11/0x20
[  416.127490][ T1946]  memory_block_action+0x12e/0x210
[  416.149808][ T1946]  ? device_remove_class_symlinks+0xc0/0xc0
[  416.175650][ T1946]  memory_subsys_offline+0x7d/0xb0
[  416.197897][ T1946]  device_offline+0xd5/0x110
[  416.217800][ T1946]  ? memory_block_action+0x210/0x210
[  416.240809][ T1946]  state_store+0xc6/0xe0
[  416.259508][ T1946]  dev_attr_store+0x3f/0x60
[  416.279018][ T1946]  ? device_create_release+0x60/0x60
[  416.302081][ T1946]  sysfs_kf_write+0x89/0xb0
[  416.321625][ T1946]  ? sysfs_file_ops+0xa0/0xa0
[  416.341906][ T1946]  kernfs_fop_write+0x188/0x240
[  416.363700][ T1946]  __vfs_write+0x50/0xa0
[  416.382789][ T1946]  vfs_write+0x105/0x290
[  416.401087][ T1946]  ksys_write+0xc6/0x160
[  416.421144][ T1946]  ? __x64_sys_read+0x50/0x50
[  416.444824][ T1946]  ? fput+0x13/0x20
[  416.462255][ T1946]  ? filp_close+0x8e/0xa0
[  416.480951][ T1946]  ? __close_fd+0xe0/0x110
[  416.500343][ T1946]  __x64_sys_write+0x43/0x50
[  416.520327][ T1946]  do_syscall_64+0xc8/0x63b
[  416.540048][ T1946]  ? syscall_return_slowpath+0x120/0x120
[  416.564728][ T1946]  ? __do_page_fault+0x44d/0x5b0
[  416.586119][ T1946]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  416.611778][ T1946] RIP: 0033:0x7fca28ac63b8
[  416.630947][ T1946] Code: 89 02 48 c7 c0 ff ff ff ff eb b3 0f 1f 80 00 00 00
00 f3 0f 1e fa 48 8d 05 65 63 2d 00 8b 00 85 c0 75 17 b8 01 00 00 00 0f 05 <48>
3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 41 54 49 89 d4 55
[  416.717953][ T1946] RSP: 002b:00007ffc33f8eb98 EFLAGS: 00000246 ORIG_RAX:
0000000000000001
[  416.755847][ T1946] RAX: ffffffffffffffda RBX: 0000000000000008 RCX:
00007fca28ac63b8
[  416.790908][ T1946] RDX: 0000000000000008 RSI: 0000558daa079880 RDI:
0000000000000001
[  416.826002][ T1946] RBP: 0000558daa079880 R08: 000000000000000a R09:
00007ffc33f8e720
[  416.861054][ T1946] R10: 000000000000000a R11: 0000000000000246 R12:
00007fca28d98780
[  416.896253][ T1946] R13: 0000000000000008 R14: 00007fca28d93740 R15:
0000000000000008
[  416.932117][ T1946] Modules linked in: kvm_intel kvm irqbypass dax_pmem
dax_pmem_core ip_tables x_tables xfs sd_mod igb i2c_algo_bit hpsa i2c_core
scsi_transport_sas dm_mirror dm_region_hash dm_log dm_mod
[  417.019852][ T1946] ---[ end trace 5a30e75692517f36 ]---
[  417.044089][ T1946] RIP: 0010:test_pages_in_a_zone+0x285/0x310
[  417.070435][ T1946] Code: c6 c0 96 4c a2 48 89 df e8 18 23 f6 ff 0f 0b 48 c7
c7 80 c7 ad a2 e8 ae c2 1f 00 48 c7 c6 c0 96 4c a2 48 89 cf e8 fb 22 f6 ff <0f>
0b 48 c7 c7 00 c8 ad a2 e8 91 c2 1f 00 48 85 db 0f 84 3c ff ff
[  417.158165][ T1946] RSP: 0018:ffff88832ba37930 EFLAGS: 00010292
[  417.184809][ T1946] RAX: 0000000000000000 RBX: ffff88847fff36c0 RCX:
ffffffffa1b40b78
[  417.220249][ T1946] RDX: 0000000000000000 RSI: 0000000000000008 RDI:
ffff88884743d380
[  417.255589][ T1946] RBP: ffff88832ba37988 R08: ffffed1108e87a71 R09:
ffffed1108e87a70
[  417.290652][ T1946] R10: ffffed1108e87a70 R11: ffff88884743d387 R12:
0000000000060000
[  417.325808][ T1946] R13: 0000000000060000 R14: 0000000000060000 R15:
000000000005a800
[  417.360953][ T1946] FS:  00007fca293e7740(0000) GS:ffff888847400000(0000)
knlGS:0000000000000000
[  417.401830][ T1946] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  417.430817][ T1946] CR2: 0000558da8ffffc0 CR3: 00000002bff10006 CR4:
00000000001606a0
[  417.470406][ T1946] Kernel panic - not syncing: Fatal exception
[  417.497018][ T1946] Kernel Offset: 0x20600000 from 0xffffffff81000000
(relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[  417.548754][ T1946] ---[ end Kernel panic - not syncing: Fatal exception ]---

[2]
[    0.000000][    T0] WARNING: CPU: 0 PID: 0 at arch/powerpc/mm/pgtable.c:186
set_pte_at+0x3c/0x190
[    0.000000][    T0] Modules linked in:
[    0.000000][    T0] CPU: 0 PID: 0 Comm: swapper Tainted:
G        W         5.2.0-rc4+ #7
[    0.000000][    T0] NIP:  c00000000006129c LR: c000000000075724 CTR:
c000000000061270
[    0.000000][    T0] REGS: c0000000016d7770 TRAP: 0700   Tainted:
G        W          (5.2.0-rc4+)
[    0.000000][    T0] MSR:  9000000000021033 <SF,HV,ME,IR,DR,RI,LE>  CR:
44002884  XER: 20040000
[    0.000000][    T0] CFAR: c00000000005d514 IRQMASK: 1 
[    0.000000][    T0] GPR00: c000000000075724 c0000000016d7a00 c0000000016d4900
c0000000016a48b0 
[    0.000000][    T0] GPR04: c00c0000003d0000 c000001bff5300e8 8e014b001c000080
ffffffffffffffff 
[    0.000000][    T0] GPR08: c000001bff530000 06000000000000c0 07000000000000c0
0000000000000001 
[    0.000000][    T0] GPR12: c000000000061270 c000000002b30000 c0000000009e8830
c0000000009e8860 
[    0.000000][    T0] GPR16: 0000000000000009 0000000000000009 c000001ffffca000
0000000000000000 
[    0.000000][    T0] GPR20: 0000000000000015 0000000000000000 0000000000000000
c000001ffffc9000 
[    0.000000][    T0] GPR24: c0000000016a48b0 c0000000018a07c0 0000000000000005
c00c0000003d0000 
[    0.000000][    T0] GPR28: 800000000000018e 8000001c004b018e c000001bff5300e8
0000000000000008 
[    0.000000][    T0] NIP [c00000000006129c] set_pte_at+0x3c/0x190
[    0.000000][    T0] LR [c000000000075724] __map_kernel_page+0x7a4/0x890
[    0.000000][    T0] Call Trace:
[    0.000000][    T0] [c0000000016d7a00] [0000000400000000] 0x400000000
(unreliable)
[    0.000000][    T0] [c0000000016d7a40] [0000001c004b0000] 0x1c004b0000
[    0.000000][    T0] [c0000000016d7af0] [c0000000008b858c]
radix__vmemmap_create_mapping+0x98/0xbc
[    0.000000][    T0] [c0000000016d7b70] [c0000000008b7194]
vmemmap_populate+0x284/0x31c
[    0.000000][    T0] [c0000000016d7c30] [c0000000008baeb0]
sparse_mem_map_populate+0x40/0x68
[    0.000000][    T0] [c0000000016d7c60] [c000000000af5e10]
sparse_init_nid+0x35c/0x550
[    0.000000][    T0] [c0000000016d7d20] [c000000000af63b0]
sparse_init+0x1a8/0x240
[    0.000000][    T0] [c0000000016d7d60] [c000000000ac67b0]
initmem_init+0x368/0x40c
[    0.000000][    T0] [c0000000016d7e80] [c000000000aba9b8]
setup_arch+0x300/0x380
[    0.000000][    T0] [c0000000016d7ef0] [c000000000ab3fd8]
start_kernel+0xb4/0x710
[    0.000000][    T0] [c0000000016d7f90] [c00000000000ab74]
start_here_common+0x1c/0x4a8
