Return-Path: <SRS0=WmnE=2X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06F00C2D0C2
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 20:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B2C3C21655
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jan 2020 20:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="viC6Ou7s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725883AbgABUyJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jan 2020 15:54:09 -0500
Received: from mail-wr1-f48.google.com ([209.85.221.48]:46719 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgABUyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jan 2020 15:54:09 -0500
Received: by mail-wr1-f48.google.com with SMTP id z7so40463750wrl.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jan 2020 12:54:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=bNVjaLdjurpC3ZEi3taa9UctN3S9hFHxflOsdG/Big4=;
        b=viC6Ou7sM/IWehVA/4ISE7ho1BxEq05i8Y4zwVNvy0iEEh6VVvt/sQWV+wGGYBqs8H
         0QUYi66b2wc6BTIt7fL7jbbOATWG9aciccg0JvxbPjfyn7b59ALQITROdRzDuyFURgm7
         BriaWSWZHq+vTripXeDxWy0FzZ3bm0eTV2bfJtDeeroUW0h22bvH9t7QZjqw0ne8EcJO
         CWNHgoC3rv6vrxy6RUZIddyj3gqQt4cpFzdint8aXfgehNkLS0DwKXp02bc4356xvNns
         MOTFQat5/vIXJBDWcvnbPScHD9pjEcGachGVWDa15ewlbrSmKBVgyZtDugc0/JDnXU+W
         6QFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=bNVjaLdjurpC3ZEi3taa9UctN3S9hFHxflOsdG/Big4=;
        b=IuKDTHkskzoj8XHc1Ey34UISyadMHQcxWOo6yAXsHW/7mGz3k4Wt3bJPhlVuxuqJKa
         FiQuBm98QTgdW+WngZRd/VyK7N/1u3DM68AsKWEAdfwGoKCzNJullA+RDRZDPhhlBdCg
         DEY6zub5+9RWrsQTW6JSUJ7OsaPJB3ReRBCCKTHYx8D+w0rsaHQMtovhrmpyYIMlAgza
         +H5u56ktsCHOG63MiBjXPzYAvh6jqW46oKg+lc3VlkLFuSztBiXty/0tbRfOQWqx2F5x
         U1OGXcnT1gzsWJG9Smnvz9QhQFriQ8+j6qadMimSvjauyfCCmtR8fjzPptjV3XdQwzzr
         3Tng==
X-Gm-Message-State: APjAAAUGcTiRyimdpPTppOR3BDKRHCwDvhPOQ1vGePJPJuzBiYy928bL
        ++fJ7WIdf5mT4EEi4BjkN2i70Zzh
X-Google-Smtp-Source: APXvYqzITWQsYoMrQKCPR8vWCxY5pmFeqwlUkgfh3KRYRogA8RcCqK0j732hvO6yatyuSoBNAzsJvQ==
X-Received: by 2002:adf:f5cb:: with SMTP id k11mr80719817wrp.71.1577998445511;
        Thu, 02 Jan 2020 12:54:05 -0800 (PST)
Received: from [10.248.0.37] ([155.4.14.18])
        by smtp.gmail.com with ESMTPSA id p17sm9761009wmk.30.2020.01.02.12.54.04
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jan 2020 12:54:05 -0800 (PST)
To:     linux-kernel@vger.kernel.org
From:   A L <crimsoncottage@gmail.com>
Subject: AMDGPU crash on 5.4.7 on AMD Athlon 3000G APU
Message-ID: <f9cef3e4-bcc1-7d87-6663-82f4d84396e1@gmail.com>
Date:   Thu, 2 Jan 2020 21:54:05 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

There seems to be a regression between kernel 5.4.6 and 5.4.7. When I 
change from kernel 5.4.6 to kernel 5.4.7 I can no longer load the AMDGPU 
driver. The kernel immediately crashes with the following stack trace 
and errors. The system has to be hard reset to boot again.

[  320.086318] [drm] amdgpu kernel modesetting enabled.
[  320.086382] Parsing CRAT table with 1 nodes
[  320.086388] Creating topology SYSFS entries
[  320.086425] Topology: Add APU node [0x0:0x0]
[  320.086427] Finished initializing topology
[  320.086545] amdgpu 0000:06:00.0: remove_conflicting_pci_framebuffers: 
bar 0: 0xe0000000 -> 0xefffffff
[  320.086549] amdgpu 0000:06:00.0: remove_conflicting_pci_framebuffers: 
bar 2: 0xf0000000 -> 0xf01fffff
[  320.086552] amdgpu 0000:06:00.0: remove_conflicting_pci_framebuffers: 
bar 5: 0xfce00000 -> 0xfce7ffff
[  320.086554] checking generic (e0000000 7f0000) vs hw (e0000000 10000000)
[  320.086557] fb0: switching to amdgpudrmfb from VESA VGA
[  320.086647] Console: switching to colour dummy device 80x25
[  320.086673] amdgpu 0000:06:00.0: vgaarb: deactivate vga console
[  320.086839] [drm] initializing kernel modesetting (RAVEN 
0x1002:0x15D8 0x1002:0x15D8 0xCC).
[  320.086850] [drm] register mmio base: 0xFCE00000
[  320.086851] [drm] register mmio size: 524288
[  320.086868] [drm] add ip block number 0 <soc15_common>
[  320.086869] [drm] add ip block number 1 <gmc_v9_0>
[  320.086869] [drm] add ip block number 2 <vega10_ih>
[  320.086870] [drm] add ip block number 3 <psp>
[  320.086870] [drm] add ip block number 4 <gfx_v9_0>
[  320.086871] [drm] add ip block number 5 <sdma_v4_0>
[  320.086871] [drm] add ip block number 6 <powerplay>
[  320.086872] [drm] add ip block number 7 <dm>
[  320.086873] [drm] add ip block number 8 <vcn_v1_0>
[  320.112116] [drm] BIOS signature incorrect 0 0
[  320.112142] ATOM BIOS: 113-RAVEN2-115
[  320.112773] [drm] VCN decode is enabled in VM mode
[  320.112774] [drm] VCN encode is enabled in VM mode
[  320.112774] [drm] VCN jpeg decode is enabled in VM mode
[  320.112807] [drm] vm size is 262144 GB, 3 levels, block size is 
9-bit, fragment size is 9-bit
[  320.112813] amdgpu 0000:06:00.0: VRAM: 2048M 0x000000F400000000 - 
0x000000F47FFFFFFF (2048M used)
[  320.112814] amdgpu 0000:06:00.0: GART: 1024M 0x0000000000000000 - 
0x000000003FFFFFFF
[  320.112815] amdgpu 0000:06:00.0: AGP: 267419648M 0x000000F800000000 - 
0x0000FFFFFFFFFFFF
[  320.112818] [drm] Detected VRAM RAM=2048M, BAR=2048M
[  320.112818] [drm] RAM width 128bits DDR4
[  320.112858] [TTM] Zone  kernel: Available graphics memory: 3052426 KiB
[  320.112858] [TTM] Zone   dma32: Available graphics memory: 2097152 KiB
[  320.112859] [TTM] Initializing pool allocator
[  320.112861] [TTM] Initializing DMA pool allocator
[  320.112913] [drm] amdgpu: 2048M of VRAM memory ready
[  320.112915] [drm] amdgpu: 3072M of GTT memory ready.
[  320.112923] [drm] GART: num cpu pages 262144, num gpu pages 262144
[  320.113067] [drm] PCIE GART of 1024M enabled (table at 
0x000000F400900000).
[  320.119226] [drm] use_doorbell being set to: [true]
[  320.119270] amdgpu: [powerplay] hwmgr_sw_init smu backed is smu10_smu
[  320.121347] [drm] Found VCN firmware Version: 1.86 Family ID: 18
[  320.121354] [drm] PSP loading VCN firmware
[  320.142076] [drm] reserve 0x400000 from 0xf47fc00000 for PSP TMR
[  320.202902] [drm] failed to load ucode id (18)
[  320.202904] [drm] psp command failed and response status is (0x300F)
[  320.205881] [drm] failed to load ucode id (19)
[  320.205883] [drm] psp command failed and response status is (0xF)
[  320.208882] [drm] failed to load ucode id (20)
[  320.208883] [drm] psp command failed and response status is (0xF)
[  320.229776] [drm] DM_PPLIB: values for F clock
[  320.229778] [drm] DM_PPLIB:     0 in kHz, 3649 in mV
[  320.229779] [drm] DM_PPLIB:     0 in kHz, 0 in mV
[  320.229780] [drm] DM_PPLIB:     0 in kHz, 0 in mV
[  320.229780] [drm] DM_PPLIB:     0 in kHz, 0 in mV
[  320.229797] ------------[ cut here ]------------
[  320.229949] WARNING: CPU: 1 PID: 5908 at 
drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c:1464 
dcn_bw_update_from_pplib+0x94/0x2c0 [amdgpu]
[  320.229950] Modules linked in: amdgpu(+) gpu_sched ttm ip_set_hash_ip 
xt_state ip6t_REJECT nf_reject_ipv6 ip6table_filter ip6table_raw 
ip6table_mangle xt_multiport ip6table_nat nfnetlink_log xt_limit 
xt_NFLOG ipt_REJECT nf_reject_ipv4 xt_conntrack iptable_filter 
iptable_mangle xt_nat iptable_nat xt_CT iptable_raw ip_set_bitmap_port 
ip_set_hash_net nf_nat_pptp nf_conntrack_pptp nf_nat xt_sctp 
nf_conntrack_sip nf_conntrack_irc nf_conntrack_ftp nf_conntrack_h323 
nf_conntrack_netbios_ns nf_conntrack_broadcast nf_conntrack_bridge 
nf_conntrack nf_defrag_ipv6 ip6_tables ip_tables xt_recent xt_set ip_set 
nfnetlink nf_defrag_ipv4 nf_socket_ipv4 uas pinctrl_amd
[  320.229974] CPU: 1 PID: 5908 Comm: modprobe Not tainted 
5.4.7-gentoo-test2 #3
[  320.229975] Hardware name: Gigabyte Technology Co., Ltd. B450M 
DS3H/B450M DS3H-CF, BIOS F50 11/27/2019
[  320.230113] RIP: 0010:dcn_bw_update_from_pplib+0x94/0x2c0 [amdgpu]
[  320.230116] Code: 0c 24 85 c9 74 24 8d 71 ff 48 8d 44 24 04 48 8d 54 
f4 0c eb 0d 48 83 c0 08 48 39 d0 0f 84 13 01 00 00 44 8b 00 45 85 c0 75 
eb <0f> 0b e8 65 3e d4 e0 4c 89 e2 be 04 00 00 00 4c 89 ef e8 a5 9b fe
[  320.230117] RSP: 0018:ffffc9000045b700 EFLAGS: 00010246
[  320.230119] RAX: ffffc9000045b704 RBX: ffff88812c700000 RCX: 
0000000000000004
[  320.230120] RDX: ffffc9000045b724 RSI: 0000000000000003 RDI: 
ffff888218856350
[  320.230121] RBP: ffffc9000045b840 R08: 0000000000000000 R09: 
00000000000003c5
[  320.230122] R10: 0000000000000001 R11: 0000000000000000 R12: 
ffffc9000045b790
[  320.230123] R13: ffff8881341c8980 R14: 0000000000000001 R15: 
000000000000000b
[  320.230125] FS:  00007ff865e7db80(0000) GS:ffff888218840000(0000) 
knlGS:0000000000000000
[  320.230126] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  320.230127] CR2: 00007fd68de9f540 CR3: 000000012c4f8000 CR4: 
00000000003406e0
[  320.230128] Call Trace:
[  320.230135]  ? kmem_cache_alloc+0xe6/0x180
[  320.230271]  dcn10_create_resource_pool+0x7d9/0xb10 [amdgpu]
[  320.230406]  ? firmware_parser_create+0x6fb/0x720 [amdgpu]
[  320.230533]  dc_create_resource_pool+0x21/0x100 [amdgpu]
[  320.230660]  dc_create+0x206/0x680 [amdgpu]
[  320.230663]  ? kmem_cache_alloc+0xe6/0x180
[  320.230795]  amdgpu_dm_init+0x138/0x1c0 [amdgpu]
[  320.230800]  ? common_interrupt+0xa/0xf
[  320.230929]  ? phm_wait_for_register_unequal.part.0+0x44/0x70 [amdgpu]
[  320.231059]  dm_hw_init+0x9/0x20 [amdgpu]
[  320.231191]  amdgpu_device_init.cold+0xf47/0x129e [amdgpu]
[  320.231194]  ? __alloc_pages_nodemask+0x128/0x240
[  320.231300]  amdgpu_driver_load_kms+0x44/0xe0 [amdgpu]
[  320.231305]  drm_dev_register+0x109/0x150
[  320.231410]  amdgpu_pci_probe+0xe9/0x150 [amdgpu]
[  320.231414]  ? __pm_runtime_resume+0x44/0x50
[  320.231417]  local_pci_probe+0x38/0x70
[  320.231419]  ? pci_match_device+0xd2/0x100
[  320.231422]  pci_device_probe+0xe4/0x190
[  320.231425]  really_probe+0xdf/0x290
[  320.231427]  driver_probe_device+0x4b/0xc0
[  320.231430]  device_driver_attach+0x4e/0x60
[  320.231432]  __driver_attach+0x44/0xb0
[  320.231434]  ? device_driver_attach+0x60/0x60
[  320.231436]  bus_for_each_dev+0x5c/0x90
[  320.231438]  bus_add_driver+0x16d/0x1c0
[  320.231440]  driver_register+0x67/0xb0
[  320.231442]  ? 0xffffffffa0597000
[  320.231444]  do_one_initcall+0x44/0x16f
[  320.231447]  ? __vunmap+0x223/0x260
[  320.231449]  ? kmem_cache_alloc+0xe6/0x180
[  320.231452]  do_init_module+0x51/0x200
[  320.231455]  load_module+0x20d6/0x23d0
[  320.231458]  ? vfs_read+0x117/0x140
[  320.231461]  ? __do_sys_finit_module+0x9b/0xb0
[  320.231464]  __do_sys_finit_module+0x9b/0xb0
[  320.231466]  do_syscall_64+0x3d/0x100
[  320.231469]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  320.231471] RIP: 0033:0x7ff865f9e289
[  320.231474] Code: 00 00 00 75 05 48 83 c4 18 c3 e8 c2 5f 01 00 66 90 
48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 
05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d7 4b 09 00 f7 d8 64 89 01 48
[  320.231475] RSP: 002b:00007ffe140b9878 EFLAGS: 00000246 ORIG_RAX: 
0000000000000139
[  320.231476] RAX: ffffffffffffffda RBX: 000055eeb9140ab0 RCX: 
00007ff865f9e289
[  320.231477] RDX: 0000000000000000 RSI: 000055eeb8c5533c RDI: 
0000000000000005
[  320.231478] RBP: 0000000000040000 R08: 0000000000000000 R09: 
000055eeb9140ca0
[  320.231479] R10: 0000000000000005 R11: 0000000000000246 R12: 
000055eeb8c5533c
[  320.231480] R13: 0000000000000000 R14: 000055eeb9140be0 R15: 
000055eeb9140ab0
[  320.231482] ---[ end trace 4d7f7927484d9651 ]---
[  320.231529] [drm] DM_PPLIB: values for DCF clock
[  320.231530] [drm] DM_PPLIB:     300000 in kHz, 3649 in mV
[  320.231531] [drm] DM_PPLIB:     600000 in kHz, 3974 in mV
[  320.231532] [drm] DM_PPLIB:     626000 in kHz, 4174 in mV
[  320.231532] [drm] DM_PPLIB:     654000 in kHz, 4325 in mV
[  320.237932] [drm] Display Core initialized with v3.2.48!
[  320.238368] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[  320.238369] [drm] Driver supports precise vblank timestamp query.
[  320.249980] [drm] VCN decode and encode initialized 
successfully(under SPG Mode).
[  320.251158] kfd kfd: Allocated 3969056 bytes on gart
[  320.251662] kfd kfd: Failed to resume IOMMU for device 1002:15d8
[  320.251891] kfd kfd: device 1002:15d8 NOT added due to errors
[  320.251962] [drm] Cannot find any crtc or sizes
[  320.252163] amdgpu 0000:06:00.0: ring gfx uses VM inv eng 0 on hub 0
[  320.252167] amdgpu 0000:06:00.0: ring comp_1.0.0 uses VM inv eng 1 on 
hub 0
[  320.252169] amdgpu 0000:06:00.0: ring comp_1.1.0 uses VM inv eng 4 on 
hub 0
[  320.252172] amdgpu 0000:06:00.0: ring comp_1.2.0 uses VM inv eng 5 on 
hub 0
[  320.252174] amdgpu 0000:06:00.0: ring comp_1.3.0 uses VM inv eng 6 on 
hub 0
[  320.252176] amdgpu 0000:06:00.0: ring comp_1.0.1 uses VM inv eng 7 on 
hub 0
[  320.252178] amdgpu 0000:06:00.0: ring comp_1.1.1 uses VM inv eng 8 on 
hub 0
[  320.252181] amdgpu 0000:06:00.0: ring comp_1.2.1 uses VM inv eng 9 on 
hub 0
[  320.252183] amdgpu 0000:06:00.0: ring comp_1.3.1 uses VM inv eng 10 
on hub 0
[  320.252185] amdgpu 0000:06:00.0: ring kiq_2.1.0 uses VM inv eng 11 on 
hub 0
[  320.252186] amdgpu 0000:06:00.0: ring sdma0 uses VM inv eng 0 on hub 1
[  320.252188] amdgpu 0000:06:00.0: ring vcn_dec uses VM inv eng 1 on hub 1
[  320.252190] amdgpu 0000:06:00.0: ring vcn_enc0 uses VM inv eng 4 on hub 1
[  320.252192] amdgpu 0000:06:00.0: ring vcn_enc1 uses VM inv eng 5 on hub 1
[  320.252194] amdgpu 0000:06:00.0: ring vcn_jpeg uses VM inv eng 6 on hub 1
[  320.401903] AMD-Vi: Completion-Wait loop timed out
[  320.542017] AMD-Vi: Completion-Wait loop timed out
[  320.682015] AMD-Vi: Completion-Wait loop timed out
[  320.822091] AMD-Vi: Completion-Wait loop timed out
[  320.962130] AMD-Vi: Completion-Wait loop timed out
[  321.088018] AMD-Vi: Completion-Wait loop timed out
[  321.214038] AMD-Vi: Completion-Wait loop timed out
[  321.263146] iommu ivhd0: AMD-Vi: Event logged [IOTLB_INV_TIMEOUT 
device=06:00.0 address=0x217879410]
[  322.278079] clocksource: timekeeping watchdog on CPU3: Marking 
clocksource 'tsc' as unstable because the skew is too large:
[  322.278081] clocksource:                       'hpet' wd_now: 
1327ac6e wd_last: 129c4f3c mask: ffffffff
[  322.278082] clocksource:                       'tsc' cs_now: 
11ce84c06c0 cs_last: 11c76631aad mask: ffffffffffffffff
[  322.278084] tsc: Marking TSC unstable due to clocksource watchdog
[  322.369132] TSC found unstable after boot, most likely due to broken 
BIOS. Use 'tsc=unstable'.
[  322.369134] sched_clock: Marking unstable (322385637527, 
-16091409)<-(322450384861, -81255237)
[  322.734191] clocksource: Switched to clocksource hpet
[  336.585879] hpet: Lost 4 RTC interrupts

* The full paste is available at (1)
* lspci -vk paste is available at (2)
* kernel .config is available at (3)
* sys-kernel/linux-firmware-20191215 is installed.

The previous kernel 5.4.6 worked with no crashes. There was still the 
same stack trace, but no "Wait loop timed out" or "iommu ivhd0: AMD-Vi" 
error. Same kernel .config was used for both kernels.

The system is small headless machine with the new low-power AMD Athlon 
3000G APU with integrated VEGA 3 graphics (4)
Motherboard is a Gigabyte B450M. Two intel PCIe NICs are present.

1) http://dpaste.com/0X9FWCW
2) http://dpaste.com/10R7J9H
3) http://dpaste.com/064XG5E
4) https://www.amd.com/en/products/apu/amd-athlon-3000g

Regards,
Anders


