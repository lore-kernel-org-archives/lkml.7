Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77C5FC04AB4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 21:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FC8C2087E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 21:30:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729358AbfEQVag (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 May 2019 17:30:36 -0400
Received: from retiisi.org.uk ([95.216.213.190]:51398 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729322AbfEQVag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 May 2019 17:30:36 -0400
Received: from valkosipuli.localdomain (valkosipuli.retiisi.org.uk [IPv6:2a01:4f9:c010:4572::80:2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hillosipuli.retiisi.org.uk (Postfix) with ESMTPS id 3E512634C7B;
        Sat, 18 May 2019 00:30:31 +0300 (EEST)
Received: from sailus by valkosipuli.localdomain with local (Exim 4.89)
        (envelope-from <sakari.ailus@retiisi.org.uk>)
        id 1hRkQx-0000IE-4l; Sat, 18 May 2019 00:30:31 +0300
Date:   Sat, 18 May 2019 00:30:31 +0300
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Justin Piszcz <jpiszcz@lucidpixels.com>
Cc:     'LKML' <linux-kernel@vger.kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: 5.1 and 5.1.1: BUG: unable to handle kernel paging request at
 ffffea0002030000
Message-ID: <20190517213031.6rj3xwzmbw2bwhsk@valkosipuli.retiisi.org.uk>
References: <CAO9zADzXTQpv5cGp61BzsVPvWQz5xbSJv_N71jBa3zopr7CB=Q@mail.gmail.com>
 <000901d5089d$93b52e70$bb1f8b50$@lucidpixels.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000901d5089d$93b52e70$bb1f8b50$@lucidpixels.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 12, 2019 at 04:34:55AM -0400, Justin Piszcz wrote:
> 
> 
> > -----Original Message-----
> > From: Justin Piszcz [mailto:jpiszcz@lucidpixels.com]
> > Sent: Sunday, May 12, 2019 4:28 AM
> > To: LKML
> > Subject: 5.1 and 5.1.1: BUG: unable to handle kernel paging request at
> > ffffea0002030000
> > 
> > Hello,
> > 
> > I've turned off zram/zswap and I am still seeing the following during
> > periods of heavy I/O, I am returning to 5.0.xx in the meantime.
> > 
> > Kernel: 5.1.1
> > Arch: x86_64
> > Dist: Debian x86_64
> 
> [ .. ]
> 
> Reverting back to linux-5.0.15, will see if it recurs (I've never seen this before moving to 5.1.x)
> 
> $ diff -u linux-5.1.1/mm/compaction.c linux-5.0.15/mm/compaction.c | wc -l
> 1628

I've seen the same on v5.1.2 twice now; I wanted to see whether I'd be
lucky with applying "mm/compaction.c: correct zone boundary handling when
isolating pages from a pageblock" but it made no difference. I'm not sure
whether this is related.

Cc'ing Mel as I see he's been working on the file. :-)

The first one is plain v5.1.2 and the second one with the aforementioned
patch, and my .config is here:

<URL:https://www.retiisi.org.uk/~sakke/foo/.config.5.1>

The host isn't running anything too heavy but there are about a dozen
QEMU/KVM virtual machines.


BUG: unable to handle kernel paging request at ffffebe783ff0030
#PF error: [normal kernel read fault]
PGD 46fff9067 P4D 46fff9067 PUD 46fff8067 PMD 0 
Oops: 0000 [#1] SMP NOPTI
CPU: 1 PID: 4149 Comm: CPU 2/KVM Not tainted 5.1.2+ #133
Hardware name: empty empty/S32272NR-C538, BIOS V2.00 08/04/2017
RIP: 0010:compaction_alloc+0x4ce/0x910
Code: 48 c1 e5 06 e9 ca 00 00 00 41 80 be 3d 04 00 00 00 0f 84 dc 00 00 00 49 89 ed 4c 03 2d 9b bd ad 00 4d 85 ed 0f 84 86 00 00 00 <41> 8b 45 30 25 80 00 00 f0 3d 00 00 00 f0 0f 84 28 01 00 00 80 7b
RSP: 0018:ffffa248c0763458 EFLAGS: 00010286
RAX: 0000000000000001 RBX: ffffa248c0763640 RCX: 000000000000003c
RDX: 80000000000ffc00 RSI: 0000000000000000 RDI: ffffa0553fffa900
RBP: 0000000003ff0000 R08: 0000000000000000 R09: 0000000000000000
R10: ffffa248c07634b0 R11: ffffffff99c72438 R12: 8000000000100000
R13: ffffebe783ff0000 R14: ffffffff99c72200 R15: 80000000000ffc00
FS:  00007ff4be952700(0000) GS:ffffa0552fa80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffebe783ff0030 CR3: 000000046ab8a000 CR4: 00000000003426e0
Call Trace:
? move_freelist_tail+0xc0/0xc0
migrate_pages+0x20a/0x790
? isolate_freepages_block+0x340/0x340
compact_zone+0x4d4/0xae0
compact_zone_order+0xda/0x120
? try_to_compact_pages+0x107/0x220
try_to_compact_pages+0x107/0x220
__alloc_pages_direct_compact+0x65/0x140
__alloc_pages_slowpath+0x37f/0xc40
__alloc_pages_nodemask+0x20c/0x260
do_huge_pmd_anonymous_page+0x142/0x5a0
? cpumask_next_and+0x19/0x20
__handle_mm_fault+0xb3c/0xee0
__get_user_pages+0x178/0x6b0
get_user_pages_unlocked+0x143/0x1f0
__gfn_to_pfn_memslot+0x13b/0x3d0 [kvm]
? kvm_irq_delivery_to_apic_fast+0x124/0x3d0 [kvm]
? __switch_to_asm+0x40/0x70
? __switch_to_asm+0x34/0x70
? __switch_to_asm+0x40/0x70
try_async_pf+0x82/0x190 [kvm]
tdp_page_fault+0x12d/0x270 [kvm]
? vmx_vmexit+0xf/0x30 [kvm_intel]
kvm_mmu_page_fault+0x69/0x4a0 [kvm]
? vmx_vmexit+0xf/0x30 [kvm_intel]
? vmx_vmexit+0x1b/0x30 [kvm_intel]
? vmx_vmexit+0xf/0x30 [kvm_intel]
? vmx_vmexit+0x1b/0x30 [kvm_intel]
? vmx_vmexit+0xf/0x30 [kvm_intel]
kvm_arch_vcpu_ioctl_run+0xa77/0x1910 [kvm]
? __sched_clock_gtod_offset+0x11/0x40
? kvm_vcpu_ioctl+0x366/0x560 [kvm]
kvm_vcpu_ioctl+0x366/0x560 [kvm]
? __wake_up_common+0x91/0x170
do_vfs_ioctl+0x9c/0x620
ksys_ioctl+0x35/0x60
__x64_sys_ioctl+0x11/0x20
do_syscall_64+0x4a/0x100
entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7ff4c891c017
Code: 00 00 00 48 8b 05 81 7e 2b 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 51 7e 2b 00 f7 d8 64 89 01 48
RSP: 002b:00007ff4be9518b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 000000000000ae80 RCX: 00007ff4c891c017
RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 0000000000000019
RBP: 0000561754ae9460 R08: 000056175279a0b0 R09: 00005617549fac90
R10: 00007ff4b42dcc70 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ff4ce157000 R14: 0000000000000000 R15: 0000561754ae9460
Modules linked in: vhost_net vhost tap tun ip6t_REJECT nf_reject_ipv6 nf_log_ipv6 ip6table_nat ip6table_mangle xt_mark xt_conntrack ipt_REJECT nf_reject_ipv4 xt_tcpudp xt_nat xt_multiport nf_log_ipv4 nf_log_common xt_LOG iptable_mangle iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter bpfilter algif_skcipher af_alg binfmt_misc nls_utf8 nls_cp437 vfat fat bridge stp llc hid_generic iTCO_wdt evdev qat_c3xxx pnd2_edac edac_core intel_qat intel_rapl x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul snd_pcm ghash_clmulni_intel snd_timer snd efi_pstore soundcore cdc_ether usbnet pcspkr usbhid efivars r8152 hid i2c_i801 i2c_ismt sg dh_generic authenc button pcc_cpufreq acpi_cpufreq efivarfs ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2 dm_crypt dm_mod raid10 raid0 multipath mii raid456 libcrc32c crc32c_generic async_raid6_recov async_memcpy async_pq
async_xor xor async_tx raid6_pq raid1 md_mod crc32c_intel aesni_intel ahci libahci aes_x86_64 crypto_simd r8169 cryptd glue_helper realtek libata libphy thermal
CR2: ffffebe783ff0030
---[ end trace f21ef296e31afc3d ]---
RIP: 0010:compaction_alloc+0x4ce/0x910
Code: 48 c1 e5 06 e9 ca 00 00 00 41 80 be 3d 04 00 00 00 0f 84 dc 00 00 00 49 89 ed 4c 03 2d 9b bd ad 00 4d 85 ed 0f 84 86 00 00 00 <41> 8b 45 30 25 80 00 00 f0 3d 00 00 00 f0 0f 84 28 01 00 00 80 7b
RSP: 0018:ffffa248c0763458 EFLAGS: 00010286
RAX: 0000000000000001 RBX: ffffa248c0763640 RCX: 000000000000003c
RDX: 80000000000ffc00 RSI: 0000000000000000 RDI: ffffa0553fffa900
RBP: 0000000003ff0000 R08: 0000000000000000 R09: 0000000000000000
R10: ffffa248c07634b0 R11: ffffffff99c72438 R12: 8000000000100000
R13: ffffebe783ff0000 R14: ffffffff99c72200 R15: 80000000000ffc00
FS:  00007ff4be952700(0000) GS:ffffa0552fa80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffebe783ff0030 CR3: 000000046ab8a000 CR4: 00000000003426e0



BUG: unable to handle kernel paging request at ffffecb4c3ff0030
#PF error: [normal kernel read fault]
PGD 46fff9067 P4D 46fff9067 PUD 46fff8067 PMD 0 
Oops: 0000 [#1] SMP NOPTI
CPU: 0 PID: 7794 Comm: CPU 2/KVM Not tainted 5.1.2+ #135
Hardware name: empty empty/S32272NR-C538, BIOS V2.00 08/04/2017
RIP: 0010:compaction_alloc+0x4ce/0x920
Code: 48 c1 e5 06 e9 ca 00 00 00 41 80 be 3d 04 00 00 00 0f 84 dc 00 00 00 49 89 ed 4c 03 2d 9b bd ad 00 4d 85 ed 0f 84 86 00 00 00 <41> 8b 45 30 25 80 00 00 f0 3d 00 00 00 f0 0f 84 28 01 00 00 80 7b
RSP: 0018:ffffa62ac16cf458 EFLAGS: 00010286
RAX: 0000000000000001 RBX: ffffa62ac16cf640 RCX: 000000000000003c
RDX: 80000000000ffc00 RSI: 0000000000000000 RDI: ffffa1283fffa900
RBP: 0000000003ff0000 R08: 0000000000000000 R09: 0000000000000000
R10: ffffa62ac16cf4b0 R11: ffffffff986723f0 R12: 8000000000100000
R13: ffffecb4c3ff0000 R14: ffffffff98672200 R15: 80000000000ffc00
FS:  00007f451e582700(0000) GS:ffffa1282fa00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffecb4c3ff0030 CR3: 00000004356cc000 CR4: 00000000003426f0
Call Trace:
? move_freelist_tail+0xc0/0xc0
migrate_pages+0x20a/0x790
? isolate_freepages_block+0x340/0x340
compact_zone+0x4d4/0xae0
compact_zone_order+0xda/0x120
? try_to_compact_pages+0x107/0x220
try_to_compact_pages+0x107/0x220
__alloc_pages_direct_compact+0x65/0x140
__alloc_pages_slowpath+0x37f/0xc40
__alloc_pages_nodemask+0x20c/0x260
do_huge_pmd_anonymous_page+0x142/0x5a0
? cpumask_next_and+0x19/0x20
__handle_mm_fault+0xb3c/0xee0
__get_user_pages+0x178/0x6b0
get_user_pages_unlocked+0x143/0x1f0
__gfn_to_pfn_memslot+0x13b/0x3d0 [kvm]
? kvm_irq_delivery_to_apic_fast+0x124/0x3d0 [kvm]
? __switch_to_asm+0x40/0x70
try_async_pf+0x82/0x190 [kvm]
tdp_page_fault+0x12d/0x270 [kvm]
? vmx_vmexit+0xf/0x30 [kvm_intel]
kvm_mmu_page_fault+0x69/0x4a0 [kvm]
? vmx_vmexit+0xf/0x30 [kvm_intel]
? vmx_vmexit+0x1b/0x30 [kvm_intel]
? vmx_vmexit+0xf/0x30 [kvm_intel]
? vmx_vmexit+0x1b/0x30 [kvm_intel]
? vmx_vmexit+0xf/0x30 [kvm_intel]
kvm_arch_vcpu_ioctl_run+0xa77/0x1910 [kvm]
? kvm_vcpu_ioctl+0x366/0x560 [kvm]
kvm_vcpu_ioctl+0x366/0x560 [kvm]
? __switch_to_asm+0x40/0x70
? __switch_to_asm+0x34/0x70
? __switch_to_asm+0x40/0x70
? __switch_to_asm+0x34/0x70
? __switch_to_asm+0x40/0x70
? __switch_to_asm+0x34/0x70
? __switch_to_asm+0x40/0x70
? __switch_to_asm+0x34/0x70
? __switch_to_asm+0x40/0x70
? __switch_to_asm+0x34/0x70
do_vfs_ioctl+0x9c/0x620
? __schedule+0x1dd/0x740
ksys_ioctl+0x35/0x60
__x64_sys_ioctl+0x11/0x20
do_syscall_64+0x4a/0x100
entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7f452854c017
Code: 00 00 00 48 8b 05 81 7e 2b 00 64 c7 00 26 00 00 00 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 b8 10 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 51 7e 2b 00 f7 d8 64 89 01 48
RSP: 002b:00007f451e5818b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 000000000000ae80 RCX: 00007f452854c017
RDX: 0000000000000000 RSI: 000000000000ae80 RDI: 0000000000000018
RBP: 000055c6dc1c5460 R08: 000055c6daae50b0 R09: 000055c6dc0d6c90
R10: 00007f450c2dcce0 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f452dd87000 R14: 0000000000000000 R15: 000055c6dc1c5460
Modules linked in: cpuid vhost_net vhost tap tun ip6t_REJECT nf_reject_ipv6 nf_log_ipv6 ip6table_nat ebtable_filter ebtables ip6table_filter ip6table_mangle ip6_tables xt_mark xt_conntrack ipt_REJECT nf_reject_ipv4 xt_tcpudp xt_nat xt_multiport nf_log_ipv4 nf_log_common xt_LOG iptable_mangle iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_filter bpfilter algif_skcipher af_alg bridge stp llc binfmt_misc nls_utf8 nls_cp437 vfat fat hid_generic iTCO_wdt evdev qat_c3xxx intel_qat pnd2_edac edac_core intel_rapl x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul ghash_clmulni_intel snd_pcm efi_pstore snd_timer cdc_ether snd usbnet soundcore usbhid hid efivars r8152 pcspkr i2c_i801 i2c_ismt sg dh_generic authenc button pcc_cpufreq acpi_cpufreq efivarfs ip_tables x_tables autofs4 ext4 crc16 mbcache jbd2 dm_crypt dm_mod raid10 raid0 multipath mii raid456 libcrc32c crc32c_generic async_raid6_recov async_memcpy
async_pq async_xor xor async_tx raid1 raid6_pq md_mod crc32c_intel aesni_intel ahci libahci aes_x86_64 crypto_simd cryptd glue_helper r8169 libata realtek libphy thermal
CR2: ffffecb4c3ff0030
---[ end trace 8eb576fb4a5bab98 ]---
RIP: 0010:compaction_alloc+0x4ce/0x920
Code: 48 c1 e5 06 e9 ca 00 00 00 41 80 be 3d 04 00 00 00 0f 84 dc 00 00 00 49 89 ed 4c 03 2d 9b bd ad 00 4d 85 ed 0f 84 86 00 00 00 <41> 8b 45 30 25 80 00 00 f0 3d 00 00 00 f0 0f 84 28 01 00 00 80 7b
RSP: 0018:ffffa62ac16cf458 EFLAGS: 00010286
RAX: 0000000000000001 RBX: ffffa62ac16cf640 RCX: 000000000000003c
RDX: 80000000000ffc00 RSI: 0000000000000000 RDI: ffffa1283fffa900
RBP: 0000000003ff0000 R08: 0000000000000000 R09: 0000000000000000
R10: ffffa62ac16cf4b0 R11: ffffffff986723f0 R12: 8000000000100000
R13: ffffecb4c3ff0000 R14: ffffffff98672200 R15: 80000000000ffc00
FS:  00007f451e582700(0000) GS:ffffa1282fa00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffecb4c3ff0030 CR3: 00000004356cc000 CR4: 00000000003426f0

-- 
Kind regards,

Sakari Ailus
