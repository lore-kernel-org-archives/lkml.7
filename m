Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD5FC2D0C2
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 19:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DECDD20866
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 19:42:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IySEcK1l"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728582AbgACTmo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 14:42:44 -0500
Received: from mail-wr1-f47.google.com ([209.85.221.47]:42056 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728488AbgACTmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 14:42:43 -0500
Received: by mail-wr1-f47.google.com with SMTP id q6so43348827wro.9
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jan 2020 11:42:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Fjb7N/fdoS0jI2HUD7uX5BlKf2gShPEqjRXoq+fkmhg=;
        b=IySEcK1lm4mpAKZkNSKnTD9/YLoLb5j/9pE54M5Du1AzTrgGVNsoK+B5xM373eFENm
         yBsGVNWkB06m1YK5G1jxML3htMTyMePWQj5Z4RZjJfv9VIkLOZhEfKmt1xEYxGkaceSJ
         Uj7dMmM7ksZj+9/VJnholCB7y6V54Ai0SKaXbL95Bm8c3j8E93+HZjS7h334MgOQnwZs
         IIxAIswl78dqn62fhObzsOinZqsz3OxdN81LPCwnHxF7NOP5U9cM4cTNkgsrADN7/5SG
         yHkOpoUqW1e/kp2qPFarU+uC89SiUE49CbI9wPCOvLdHukaECThiNAj7ETRjnqCghAne
         wBxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Fjb7N/fdoS0jI2HUD7uX5BlKf2gShPEqjRXoq+fkmhg=;
        b=IoT1ZmFAhtl6aHg3cJFITwvw+PleXdqmrGd1nraypMjPNmDdzxPIx1zcF1wj01tzrN
         fYibJ5tfe/HDRV4QOJWYIBXDEqhQ3GfN8YvEFcGQcLH1fabhhaASI09Aj6ZO5z/P2Xg9
         fcbIBa9u4jCF/wUsl3Cs06cnOdqquojpV8MVRY0+Jm5imDD3hki8TZ/+Ci40MbQ0Q01A
         5Aot3wSQuRZKyRRdbMGnzA5C/KJxVFuKpntZ0sB5ea9Tt8fkeKeaUZweic9gO8wIet3z
         FB+lZg96BQiDM0A/rQbka/mQRL+rI+cQnoMwXkoGsULYq2ww3JApVm9H7htVz7OBQV8L
         UNSA==
X-Gm-Message-State: APjAAAUbnkUZKyphRulR/rJrywIgdaFQhBmUfcQ0ZClpBIAcLBUX7xY6
        V2FyN8nuxC0e/vO5Sdb4hNG+0DQ5p0R5O5FLhaWy772v
X-Google-Smtp-Source: APXvYqwq5oQrPAANej2wcBxSBKBfNCHarjJIfZBHLjxpTirgIhd6tmWLVy4q1fAVIwFkTpcqDt0nww8OpLW6C+zLoAk=
X-Received: by 2002:adf:e8ca:: with SMTP id k10mr90875238wrn.50.1578080558842;
 Fri, 03 Jan 2020 11:42:38 -0800 (PST)
MIME-Version: 1.0
References: <f9cef3e4-bcc1-7d87-6663-82f4d84396e1@gmail.com> <0fac45fb-7673-d987-34f8-859b81a3da63@gmail.com>
In-Reply-To: <0fac45fb-7673-d987-34f8-859b81a3da63@gmail.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Fri, 3 Jan 2020 14:42:25 -0500
Message-ID: <CADnq5_M0sty58j8MCxOvjh_TMVx5KUE2uicKDFWg0EoxjaeqYA@mail.gmail.com>
Subject: Re: AMDGPU crash on 5.4.7 on AMD Athlon 3000G APU
To:     A L <crimsoncottage@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 3, 2020 at 2:34 PM A L <crimsoncottage@gmail.com> wrote:
>
>
> On 2020-01-02 21:54, A L wrote:
> > Dear all,
> >
> > There seems to be a regression between kernel 5.4.6 and 5.4.7. When I
> > change from kernel 5.4.6 to kernel 5.4.7 I can no longer load the
> > AMDGPU driver. The kernel immediately crashes with the following stack
> > trace and errors. The system has to be hard reset to boot again.

dcn_calcs.c just a warning and not related to the problem.  Can you
bisect to see what is causing the failure?

Alex

> >
> > [  320.086318] [drm] amdgpu kernel modesetting enabled.
> > [  320.086382] Parsing CRAT table with 1 nodes
> > [  320.086388] Creating topology SYSFS entries
> > [  320.086425] Topology: Add APU node [0x0:0x0]
> > [  320.086427] Finished initializing topology
> > [  320.086545] amdgpu 0000:06:00.0:
> > remove_conflicting_pci_framebuffers: bar 0: 0xe0000000 -> 0xefffffff
> > [  320.086549] amdgpu 0000:06:00.0:
> > remove_conflicting_pci_framebuffers: bar 2: 0xf0000000 -> 0xf01fffff
> > [  320.086552] amdgpu 0000:06:00.0:
> > remove_conflicting_pci_framebuffers: bar 5: 0xfce00000 -> 0xfce7ffff
> > [  320.086554] checking generic (e0000000 7f0000) vs hw (e0000000
> > 10000000)
> > [  320.086557] fb0: switching to amdgpudrmfb from VESA VGA
> > [  320.086647] Console: switching to colour dummy device 80x25
> > [  320.086673] amdgpu 0000:06:00.0: vgaarb: deactivate vga console
> > [  320.086839] [drm] initializing kernel modesetting (RAVEN
> > 0x1002:0x15D8 0x1002:0x15D8 0xCC).
> > [  320.086850] [drm] register mmio base: 0xFCE00000
> > [  320.086851] [drm] register mmio size: 524288
> > [  320.086868] [drm] add ip block number 0 <soc15_common>
> > [  320.086869] [drm] add ip block number 1 <gmc_v9_0>
> > [  320.086869] [drm] add ip block number 2 <vega10_ih>
> > [  320.086870] [drm] add ip block number 3 <psp>
> > [  320.086870] [drm] add ip block number 4 <gfx_v9_0>
> > [  320.086871] [drm] add ip block number 5 <sdma_v4_0>
> > [  320.086871] [drm] add ip block number 6 <powerplay>
> > [  320.086872] [drm] add ip block number 7 <dm>
> > [  320.086873] [drm] add ip block number 8 <vcn_v1_0>
> > [  320.112116] [drm] BIOS signature incorrect 0 0
> > [  320.112142] ATOM BIOS: 113-RAVEN2-115
> > [  320.112773] [drm] VCN decode is enabled in VM mode
> > [  320.112774] [drm] VCN encode is enabled in VM mode
> > [  320.112774] [drm] VCN jpeg decode is enabled in VM mode
> > [  320.112807] [drm] vm size is 262144 GB, 3 levels, block size is
> > 9-bit, fragment size is 9-bit
> > [  320.112813] amdgpu 0000:06:00.0: VRAM: 2048M 0x000000F400000000 -
> > 0x000000F47FFFFFFF (2048M used)
> > [  320.112814] amdgpu 0000:06:00.0: GART: 1024M 0x0000000000000000 -
> > 0x000000003FFFFFFF
> > [  320.112815] amdgpu 0000:06:00.0: AGP: 267419648M 0x000000F800000000
> > - 0x0000FFFFFFFFFFFF
> > [  320.112818] [drm] Detected VRAM RAM=2048M, BAR=2048M
> > [  320.112818] [drm] RAM width 128bits DDR4
> > [  320.112858] [TTM] Zone  kernel: Available graphics memory: 3052426 KiB
> > [  320.112858] [TTM] Zone   dma32: Available graphics memory: 2097152 KiB
> > [  320.112859] [TTM] Initializing pool allocator
> > [  320.112861] [TTM] Initializing DMA pool allocator
> > [  320.112913] [drm] amdgpu: 2048M of VRAM memory ready
> > [  320.112915] [drm] amdgpu: 3072M of GTT memory ready.
> > [  320.112923] [drm] GART: num cpu pages 262144, num gpu pages 262144
> > [  320.113067] [drm] PCIE GART of 1024M enabled (table at
> > 0x000000F400900000).
> > [  320.119226] [drm] use_doorbell being set to: [true]
> > [  320.119270] amdgpu: [powerplay] hwmgr_sw_init smu backed is smu10_smu
> > [  320.121347] [drm] Found VCN firmware Version: 1.86 Family ID: 18
> > [  320.121354] [drm] PSP loading VCN firmware
> > [  320.142076] [drm] reserve 0x400000 from 0xf47fc00000 for PSP TMR
> > [  320.202902] [drm] failed to load ucode id (18)
> > [  320.202904] [drm] psp command failed and response status is (0x300F)
> > [  320.205881] [drm] failed to load ucode id (19)
> > [  320.205883] [drm] psp command failed and response status is (0xF)
> > [  320.208882] [drm] failed to load ucode id (20)
> > [  320.208883] [drm] psp command failed and response status is (0xF)
> > [  320.229776] [drm] DM_PPLIB: values for F clock
> > [  320.229778] [drm] DM_PPLIB:     0 in kHz, 3649 in mV
> > [  320.229779] [drm] DM_PPLIB:     0 in kHz, 0 in mV
> > [  320.229780] [drm] DM_PPLIB:     0 in kHz, 0 in mV
> > [  320.229780] [drm] DM_PPLIB:     0 in kHz, 0 in mV
> > [  320.229797] ------------[ cut here ]------------
> > [  320.229949] WARNING: CPU: 1 PID: 5908 at
> > drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c:1464
> > dcn_bw_update_from_pplib+0x94/0x2c0 [amdgpu]
> > [  320.229950] Modules linked in: amdgpu(+) gpu_sched ttm
> > ip_set_hash_ip xt_state ip6t_REJECT nf_reject_ipv6 ip6table_filter
> > ip6table_raw ip6table_mangle xt_multiport ip6table_nat nfnetlink_log
> > xt_limit xt_NFLOG ipt_REJECT nf_reject_ipv4 xt_conntrack
> > iptable_filter iptable_mangle xt_nat iptable_nat xt_CT iptable_raw
> > ip_set_bitmap_port ip_set_hash_net nf_nat_pptp nf_conntrack_pptp
> > nf_nat xt_sctp nf_conntrack_sip nf_conntrack_irc nf_conntrack_ftp
> > nf_conntrack_h323 nf_conntrack_netbios_ns nf_conntrack_broadcast
> > nf_conntrack_bridge nf_conntrack nf_defrag_ipv6 ip6_tables ip_tables
> > xt_recent xt_set ip_set nfnetlink nf_defrag_ipv4 nf_socket_ipv4 uas
> > pinctrl_amd
> > [  320.229974] CPU: 1 PID: 5908 Comm: modprobe Not tainted
> > 5.4.7-gentoo-test2 #3
> > [  320.229975] Hardware name: Gigabyte Technology Co., Ltd. B450M
> > DS3H/B450M DS3H-CF, BIOS F50 11/27/2019
> > [  320.230113] RIP: 0010:dcn_bw_update_from_pplib+0x94/0x2c0 [amdgpu]
> > [  320.230116] Code: 0c 24 85 c9 74 24 8d 71 ff 48 8d 44 24 04 48 8d
> > 54 f4 0c eb 0d 48 83 c0 08 48 39 d0 0f 84 13 01 00 00 44 8b 00 45 85
> > c0 75 eb <0f> 0b e8 65 3e d4 e0 4c 89 e2 be 04 00 00 00 4c 89 ef e8 a5
> > 9b fe
> > [  320.230117] RSP: 0018:ffffc9000045b700 EFLAGS: 00010246
> > [  320.230119] RAX: ffffc9000045b704 RBX: ffff88812c700000 RCX:
> > 0000000000000004
> > [  320.230120] RDX: ffffc9000045b724 RSI: 0000000000000003 RDI:
> > ffff888218856350
> > [  320.230121] RBP: ffffc9000045b840 R08: 0000000000000000 R09:
> > 00000000000003c5
> > [  320.230122] R10: 0000000000000001 R11: 0000000000000000 R12:
> > ffffc9000045b790
> > [  320.230123] R13: ffff8881341c8980 R14: 0000000000000001 R15:
> > 000000000000000b
> > [  320.230125] FS:  00007ff865e7db80(0000) GS:ffff888218840000(0000)
> > knlGS:0000000000000000
> > [  320.230126] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [  320.230127] CR2: 00007fd68de9f540 CR3: 000000012c4f8000 CR4:
> > 00000000003406e0
> > [  320.230128] Call Trace:
> > [  320.230135]  ? kmem_cache_alloc+0xe6/0x180
> > [  320.230271]  dcn10_create_resource_pool+0x7d9/0xb10 [amdgpu]
> > [  320.230406]  ? firmware_parser_create+0x6fb/0x720 [amdgpu]
> > [  320.230533]  dc_create_resource_pool+0x21/0x100 [amdgpu]
> > [  320.230660]  dc_create+0x206/0x680 [amdgpu]
> > [  320.230663]  ? kmem_cache_alloc+0xe6/0x180
> > [  320.230795]  amdgpu_dm_init+0x138/0x1c0 [amdgpu]
> > [  320.230800]  ? common_interrupt+0xa/0xf
> > [  320.230929]  ? phm_wait_for_register_unequal.part.0+0x44/0x70 [amdgpu]
> > [  320.231059]  dm_hw_init+0x9/0x20 [amdgpu]
> > [  320.231191]  amdgpu_device_init.cold+0xf47/0x129e [amdgpu]
> > [  320.231194]  ? __alloc_pages_nodemask+0x128/0x240
> > [  320.231300]  amdgpu_driver_load_kms+0x44/0xe0 [amdgpu]
> > [  320.231305]  drm_dev_register+0x109/0x150
> > [  320.231410]  amdgpu_pci_probe+0xe9/0x150 [amdgpu]
> > [  320.231414]  ? __pm_runtime_resume+0x44/0x50
> > [  320.231417]  local_pci_probe+0x38/0x70
> > [  320.231419]  ? pci_match_device+0xd2/0x100
> > [  320.231422]  pci_device_probe+0xe4/0x190
> > [  320.231425]  really_probe+0xdf/0x290
> > [  320.231427]  driver_probe_device+0x4b/0xc0
> > [  320.231430]  device_driver_attach+0x4e/0x60
> > [  320.231432]  __driver_attach+0x44/0xb0
> > [  320.231434]  ? device_driver_attach+0x60/0x60
> > [  320.231436]  bus_for_each_dev+0x5c/0x90
> > [  320.231438]  bus_add_driver+0x16d/0x1c0
> > [  320.231440]  driver_register+0x67/0xb0
> > [  320.231442]  ? 0xffffffffa0597000
> > [  320.231444]  do_one_initcall+0x44/0x16f
> > [  320.231447]  ? __vunmap+0x223/0x260
> > [  320.231449]  ? kmem_cache_alloc+0xe6/0x180
> > [  320.231452]  do_init_module+0x51/0x200
> > [  320.231455]  load_module+0x20d6/0x23d0
> > [  320.231458]  ? vfs_read+0x117/0x140
> > [  320.231461]  ? __do_sys_finit_module+0x9b/0xb0
> > [  320.231464]  __do_sys_finit_module+0x9b/0xb0
> > [  320.231466]  do_syscall_64+0x3d/0x100
> > [  320.231469]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> > [  320.231471] RIP: 0033:0x7ff865f9e289
> > [  320.231474] Code: 00 00 00 75 05 48 83 c4 18 c3 e8 c2 5f 01 00 66
> > 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24
> > 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d7 4b 09 00 f7 d8 64 89
> > 01 48
> > [  320.231475] RSP: 002b:00007ffe140b9878 EFLAGS: 00000246 ORIG_RAX:
> > 0000000000000139
> > [  320.231476] RAX: ffffffffffffffda RBX: 000055eeb9140ab0 RCX:
> > 00007ff865f9e289
> > [  320.231477] RDX: 0000000000000000 RSI: 000055eeb8c5533c RDI:
> > 0000000000000005
> > [  320.231478] RBP: 0000000000040000 R08: 0000000000000000 R09:
> > 000055eeb9140ca0
> > [  320.231479] R10: 0000000000000005 R11: 0000000000000246 R12:
> > 000055eeb8c5533c
> > [  320.231480] R13: 0000000000000000 R14: 000055eeb9140be0 R15:
> > 000055eeb9140ab0
> > [  320.231482] ---[ end trace 4d7f7927484d9651 ]---
> > [  320.231529] [drm] DM_PPLIB: values for DCF clock
> > [  320.231530] [drm] DM_PPLIB:     300000 in kHz, 3649 in mV
> > [  320.231531] [drm] DM_PPLIB:     600000 in kHz, 3974 in mV
> > [  320.231532] [drm] DM_PPLIB:     626000 in kHz, 4174 in mV
> > [  320.231532] [drm] DM_PPLIB:     654000 in kHz, 4325 in mV
> > [  320.237932] [drm] Display Core initialized with v3.2.48!
> > [  320.238368] [drm] Supports vblank timestamp caching Rev 2
> > (21.10.2013).
> > [  320.238369] [drm] Driver supports precise vblank timestamp query.
> > [  320.249980] [drm] VCN decode and encode initialized
> > successfully(under SPG Mode).
> > [  320.251158] kfd kfd: Allocated 3969056 bytes on gart
> > [  320.251662] kfd kfd: Failed to resume IOMMU for device 1002:15d8
> > [  320.251891] kfd kfd: device 1002:15d8 NOT added due to errors
> > [  320.251962] [drm] Cannot find any crtc or sizes
> > [  320.252163] amdgpu 0000:06:00.0: ring gfx uses VM inv eng 0 on hub 0
> > [  320.252167] amdgpu 0000:06:00.0: ring comp_1.0.0 uses VM inv eng 1
> > on hub 0
> > [  320.252169] amdgpu 0000:06:00.0: ring comp_1.1.0 uses VM inv eng 4
> > on hub 0
> > [  320.252172] amdgpu 0000:06:00.0: ring comp_1.2.0 uses VM inv eng 5
> > on hub 0
> > [  320.252174] amdgpu 0000:06:00.0: ring comp_1.3.0 uses VM inv eng 6
> > on hub 0
> > [  320.252176] amdgpu 0000:06:00.0: ring comp_1.0.1 uses VM inv eng 7
> > on hub 0
> > [  320.252178] amdgpu 0000:06:00.0: ring comp_1.1.1 uses VM inv eng 8
> > on hub 0
> > [  320.252181] amdgpu 0000:06:00.0: ring comp_1.2.1 uses VM inv eng 9
> > on hub 0
> > [  320.252183] amdgpu 0000:06:00.0: ring comp_1.3.1 uses VM inv eng 10
> > on hub 0
> > [  320.252185] amdgpu 0000:06:00.0: ring kiq_2.1.0 uses VM inv eng 11
> > on hub 0
> > [  320.252186] amdgpu 0000:06:00.0: ring sdma0 uses VM inv eng 0 on hub 1
> > [  320.252188] amdgpu 0000:06:00.0: ring vcn_dec uses VM inv eng 1 on
> > hub 1
> > [  320.252190] amdgpu 0000:06:00.0: ring vcn_enc0 uses VM inv eng 4 on
> > hub 1
> > [  320.252192] amdgpu 0000:06:00.0: ring vcn_enc1 uses VM inv eng 5 on
> > hub 1
> > [  320.252194] amdgpu 0000:06:00.0: ring vcn_jpeg uses VM inv eng 6 on
> > hub 1
> > [  320.401903] AMD-Vi: Completion-Wait loop timed out
> > [  320.542017] AMD-Vi: Completion-Wait loop timed out
> > [  320.682015] AMD-Vi: Completion-Wait loop timed out
> > [  320.822091] AMD-Vi: Completion-Wait loop timed out
> > [  320.962130] AMD-Vi: Completion-Wait loop timed out
> > [  321.088018] AMD-Vi: Completion-Wait loop timed out
> > [  321.214038] AMD-Vi: Completion-Wait loop timed out
> > [  321.263146] iommu ivhd0: AMD-Vi: Event logged [IOTLB_INV_TIMEOUT
> > device=06:00.0 address=0x217879410]
> > [  322.278079] clocksource: timekeeping watchdog on CPU3: Marking
> > clocksource 'tsc' as unstable because the skew is too large:
> > [  322.278081] clocksource:                       'hpet' wd_now:
> > 1327ac6e wd_last: 129c4f3c mask: ffffffff
> > [  322.278082] clocksource:                       'tsc' cs_now:
> > 11ce84c06c0 cs_last: 11c76631aad mask: ffffffffffffffff
> > [  322.278084] tsc: Marking TSC unstable due to clocksource watchdog
> > [  322.369132] TSC found unstable after boot, most likely due to
> > broken BIOS. Use 'tsc=unstable'.
> > [  322.369134] sched_clock: Marking unstable (322385637527,
> > -16091409)<-(322450384861, -81255237)
> > [  322.734191] clocksource: Switched to clocksource hpet
> > [  336.585879] hpet: Lost 4 RTC interrupts
> >
> > * The full paste is available at (1)
> > * lspci -vk paste is available at (2)
> > * kernel .config is available at (3)
> > * sys-kernel/linux-firmware-20191215 is installed.
> >
> > The previous kernel 5.4.6 worked with no crashes. There was still the
> > same stack trace, but no "Wait loop timed out" or "iommu ivhd0:
> > AMD-Vi" error. Same kernel .config was used for both kernels.
> >
> > The system is small headless machine with the new low-power AMD Athlon
> > 3000G APU with integrated VEGA 3 graphics (4)
> > Motherboard is a Gigabyte B450M. Two intel PCIe NICs are present.
> >
> > 1) http://dpaste.com/0X9FWCW
> > 2) http://dpaste.com/10R7J9H
> > 3) http://dpaste.com/064XG5E
> > 4) https://www.amd.com/en/products/apu/amd-athlon-3000g
> >
> > Regards,
> > Anders
> >
>
> I booted with an older kernel 5.3.0 on the Ubuntu LiveDVD. There is no
> crash, but still the stack trace. I have cut the relevant part from the
> dmesg output here:
>
> [    3.046913] AMD-Vi: AMD IOMMUv2 driver by Joerg Roedel <jroedel@suse.de>
> [    3.091033] [drm] amdgpu kernel modesetting enabled.
> [    3.091107] Parsing CRAT table with 1 nodes
> [    3.091110] Creating topology SYSFS entries
> [    3.091128] Topology: Add APU node [0x0:0x0]
> [    3.091128] Finished initializing topology
> [    3.091191] amdgpu 0000:06:00.0: remove_conflicting_pci_framebuffers:
> bar 0: 0xe0000000 -> 0xefffffff
> [    3.091192] amdgpu 0000:06:00.0: remove_conflicting_pci_framebuffers:
> bar 2: 0xf0000000 -> 0xf01fffff
> [    3.091194] amdgpu 0000:06:00.0: remove_conflicting_pci_framebuffers:
> bar 5: 0xfce00000 -> 0xfce7ffff
> [    3.091196] amdgpu 0000:06:00.0: vgaarb: deactivate vga console
> [    3.092292] Console: switching to colour dummy device 80x25
> [    3.093357] [drm] initializing kernel modesetting (RAVEN
> 0x1002:0x15D8 0x1002:0x15D8 0xCC).
> [    3.093370] [drm] register mmio base: 0xFCE00000
> [    3.093370] [drm] register mmio size: 524288
> [    3.093393] [drm] add ip block number 0 <soc15_common>
> [    3.093393] [drm] add ip block number 1 <gmc_v9_0>
> [    3.093394] [drm] add ip block number 2 <vega10_ih>
> [    3.093394] [drm] add ip block number 3 <psp>
> [    3.093395] [drm] add ip block number 4 <gfx_v9_0>
> [    3.093396] [drm] add ip block number 5 <sdma_v4_0>
> [    3.093396] [drm] add ip block number 6 <powerplay>
> [    3.093397] [drm] add ip block number 7 <dm>
> [    3.093397] [drm] add ip block number 8 <vcn_v1_0>
> [    3.116538] [drm] BIOS signature incorrect 5b 7
> [    3.116571] ATOM BIOS: 113-RAVEN2-115
> [    3.116609] [drm] VCN decode is enabled in VM mode
> [    3.116609] [drm] VCN encode is enabled in VM mode
> [    3.116610] [drm] VCN jpeg decode is enabled in VM mode
> [    3.116650] [drm] vm size is 262144 GB, 3 levels, block size is
> 9-bit, fragment size is 9-bit
> [    3.116663] amdgpu 0000:06:00.0: VRAM: 2048M 0x000000F400000000 -
> 0x000000F47FFFFFFF (2048M used)
> [    3.116665] amdgpu 0000:06:00.0: GART: 1024M 0x0000000000000000 -
> 0x000000003FFFFFFF
> [    3.116666] amdgpu 0000:06:00.0: AGP: 267419648M 0x000000F800000000 -
> 0x0000FFFFFFFFFFFF
> [    3.116671] [drm] Detected VRAM RAM=2048M, BAR=2048M
> [    3.116672] [drm] RAM width 128bits DDR4
> [    3.116710] [TTM] Zone  kernel: Available graphics memory: 3049520 KiB
> [    3.116711] [TTM] Zone   dma32: Available graphics memory: 2097152 KiB
> [    3.116711] [TTM] Initializing pool allocator
> [    3.116715] [TTM] Initializing DMA pool allocator
> [    3.116803] [drm] amdgpu: 2048M of VRAM memory ready
> [    3.116806] [drm] amdgpu: 3072M of GTT memory ready.
> [    3.116820] [drm] GART: num cpu pages 262144, num gpu pages 262144
> [    3.116959] [drm] PCIE GART of 1024M enabled (table at
> 0x000000F400900000).
> [    3.118554] [drm] use_doorbell being set to: [true]
> [    3.118588] amdgpu: [powerplay] hwmgr_sw_init smu backed is smu10_smu
> [    3.118712] [drm] Found VCN firmware Version: 1.86 Family ID: 18
> [    3.118715] [drm] PSP loading VCN firmware
> [    3.139499] [drm] reserve 0x400000 from 0xf400c00000 for PSP TMR
> [    3.305092] [drm] failed to load ucode id (12)
> [    3.305093] [drm] psp command failed and response status is (-53233)
> [    3.317092] [drm] failed to load ucode id (13)
> [    3.317094] [drm] psp command failed and response status is (-65521)
> [    3.329085] [drm] failed to load ucode id (14)
> [    3.329086] [drm] psp command failed and response status is (-65521)
> [    3.368639] [drm] DM_PPLIB: values for F clock
> [    3.368641] [drm] DM_PPLIB:     0 in kHz, 3649 in mV
> [    3.368641] [drm] DM_PPLIB:     0 in kHz, 0 in mV
> [    3.368642] [drm] DM_PPLIB:     0 in kHz, 0 in mV
> [    3.368642] [drm] DM_PPLIB:     0 in kHz, 0 in mV
> [    3.368643] ------------[ cut here ]------------
> [    3.368756] WARNING: CPU: 1 PID: 215 at
> drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c:1452
> dcn_bw_update_from_pplib.cold+0x7f/0xa8 [amdgpu]
> [    3.368756] Modules linked in: uas usb_storage crct10dif_pclmul
> crc32_pclmul ghash_clmulni_intel amdgpu(+) amd_iommu_v2 gpu_sched
> i2c_algo_bit ttm drm_kms_helper aesni_intel syscopyarea sysfillrect
> aes_x86_64 sysimgblt crypto_simd fb_sys_fops cryptd glue_helper drm
> e1000e ahci libahci r8169 i2c_piix4 realtek wmi video gpio_amdpt
> gpio_generic
> [    3.368769] CPU: 1 PID: 215 Comm: systemd-udevd Not tainted
> 5.3.0-18-generic #19-Ubuntu
> [    3.368770] Hardware name: Gigabyte Technology Co., Ltd. B450M
> DS3H/B450M DS3H-CF, BIOS F50 11/27/2019
> [    3.368862] RIP: 0010:dcn_bw_update_from_pplib.cold+0x7f/0xa8 [amdgpu]
> [    3.368864] Code: 48 8b 93 60 03 00 00 db 42 78 83 f9 02 77 37 b8 02
> 00 00 00 8d 71 ff e9 fb bf f3 ff 48 c7 c7 80 64 b6 c0 31 c0 e8 4c 09 c6
> d5 <0f> 0b e9 96 c0 f3 ff 48 c7 c7 80 64 b6 c0 31 c0 e8 37 09 c6 d5 0f
> [    3.368865] RSP: 0018:ffffa1af0057f598 EFLAGS: 00010246
> [    3.368866] RAX: 0000000000000024 RBX: ffff8d47c4f70000 RCX:
> 000000000000035c
> [    3.368867] RDX: 0000000000000000 RSI: 0000000000000092 RDI:
> 0000000000000247
> [    3.368868] RBP: ffffa1af0057f6e8 R08: 000000000000035c R09:
> 0000000000000004
> [    3.368868] R10: 0000000000000000 R11: 0000000000000001 R12:
> ffffa1af0057f638
> [    3.368869] R13: ffff8d47c493a980 R14: 0000000000000001 R15:
> ffff8d47d5b1d8c0
> [    3.368870] FS:  00007f06b6048880(0000) GS:ffff8d47d8640000(0000)
> knlGS:0000000000000000
> [    3.368871] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [    3.368872] CR2: 00007f275d071e04 CR3: 000000020717a000 CR4:
> 00000000003406e0
> [    3.368873] Call Trace:
> [    3.368968]  construct+0x994/0xa50 [amdgpu]
> [    3.368972]  ? _cond_resched+0x19/0x30
> [    3.368974]  ? kmem_cache_alloc_trace+0x19c/0x230
> [    3.369063]  dcn10_create_resource_pool+0x41/0x60 [amdgpu]
> [    3.369151]  dc_create_resource_pool+0x1b0/0x1d0 [amdgpu]
> [    3.369241]  ? dal_gpio_service_create+0x9f/0xe0 [amdgpu]
> [    3.369326]  construct+0x21a/0x590 [amdgpu]
> [    3.369329]  ? kmalloc_order_trace+0x24/0xa0
> [    3.369413]  dc_create+0x3b/0x100 [amdgpu]
> [    3.369501]  amdgpu_dm_init+0x129/0x1a0 [amdgpu]
> [    3.369587]  dm_hw_init+0x13/0x30 [amdgpu]
> [    3.369676]  amdgpu_device_ip_init+0x345/0x3df [amdgpu]
> [    3.369763]  amdgpu_device_init.cold+0x7e0/0xbb4 [amdgpu]
> [    3.369827]  amdgpu_driver_load_kms+0x8d/0x200 [amdgpu]
> [    3.369839]  drm_dev_register+0x12f/0x170 [drm]
> [    3.369901]  amdgpu_pci_probe+0xc6/0x130 [amdgpu]
> [    3.369904]  ? __pm_runtime_resume+0x60/0x80
> [    3.369906]  local_pci_probe+0x48/0x80
> [    3.369908]  pci_device_probe+0x10f/0x1b0
> [    3.369910]  really_probe+0xfb/0x3a0
> [    3.369912]  driver_probe_device+0x5f/0xe0
> [    3.369914]  device_driver_attach+0x5d/0x70
> [    3.369916]  __driver_attach+0x8f/0x150
> [    3.369917]  ? device_driver_attach+0x70/0x70
> [    3.369919]  bus_for_each_dev+0x7e/0xc0
> [    3.369920]  driver_attach+0x1e/0x20
> [    3.369922]  bus_add_driver+0x14f/0x1f0
> [    3.369924]  driver_register+0x74/0xc0
> [    3.369925]  __pci_register_driver+0x57/0x60
> [    3.369992]  amdgpu_init+0x83/0x8d [amdgpu]
> [    3.369994]  ? 0xffffffffc0c5a000
> [    3.369996]  do_one_initcall+0x4a/0x1fa
> [    3.369998]  ? kfree+0x1ef/0x210
> [    3.369999]  ? _cond_resched+0x19/0x30
> [    3.370001]  ? kmem_cache_alloc_trace+0x19c/0x230
> [    3.370003]  do_init_module+0x62/0x250
> [    3.370005]  load_module+0x10d4/0x1220
> [    3.370008]  __do_sys_finit_module+0xbe/0x120
> [    3.370009]  ? __do_sys_finit_module+0xbe/0x120
> [    3.370012]  __x64_sys_finit_module+0x1a/0x20
> [    3.370013]  do_syscall_64+0x5a/0x130
> [    3.370015]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [    3.370017] RIP: 0033:0x7f06b65bb94d
> [    3.370018] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa
> 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f
> 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 13 e5 0c 00 f7 d8 64 89 01 48
> [    3.370019] RSP: 002b:00007ffec39a34d8 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000139
> [    3.370020] RAX: ffffffffffffffda RBX: 000056352f169ca0 RCX:
> 00007f06b65bb94d
> [    3.370021] RDX: 0000000000000000 RSI: 00007f06b6498cad RDI:
> 0000000000000014
> [    3.370022] RBP: 00007f06b6498cad R08: 0000000000000000 R09:
> 000056352f169ca0
> [    3.370022] R10: 0000000000000014 R11: 0000000000000246 R12:
> 0000000000000000
> [    3.370023] R13: 000056352f160720 R14: 0000000000020000 R15:
> 000056352f169ca0
> [    3.370025] ---[ end trace 95b4936742504bed ]---
> [    3.370030] [drm] DM_PPLIB: values for DCF clock
> [    3.370031] [drm] DM_PPLIB:     300000 in kHz, 3649 in mV
> [    3.370032] [drm] DM_PPLIB:     600000 in kHz, 3974 in mV
> [    3.370032] [drm] DM_PPLIB:     626000 in kHz, 4174 in mV
> [    3.370033] [drm] DM_PPLIB:     654000 in kHz, 4325 in mV
> [    3.372628] [drm] Display Core initialized with v3.2.35!
> [    3.397737] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
> [    3.397738] [drm] Driver supports precise vblank timestamp query.
> [    3.410902] [drm] VCN decode and encode initialized
> successfully(under SPG Mode).
> [    3.412071] kfd kfd: Allocated 3969056 bytes on gart
> [    3.412648] kfd kfd: Failed to resume IOMMU for device 1002:15d8
> [    3.412803] kfd kfd: device 1002:15d8 NOT added due to errors
> [    3.414026] [drm] fb mappable at 0x61000000
> [    3.414026] [drm] vram apper at 0x60000000
> [    3.414027] [drm] size 8294400
> [    3.414027] [drm] fb depth is 24
> [    3.414027] [drm]    pitch is 7680
> [    3.414074] fbcon: amdgpudrmfb (fb0) is primary device
> [    3.435129] Console: switching to colour frame buffer device 240x67
> [    3.453891] amdgpu 0000:06:00.0: fb0: amdgpudrmfb frame buffer device
> [    3.477163] amdgpu 0000:06:00.0: ring gfx uses VM inv eng 0 on hub 0
> [    3.477165] amdgpu 0000:06:00.0: ring comp_1.0.0 uses VM inv eng 1 on
> hub 0
> [    3.477167] amdgpu 0000:06:00.0: ring comp_1.1.0 uses VM inv eng 4 on
> hub 0
> [    3.477168] amdgpu 0000:06:00.0: ring comp_1.2.0 uses VM inv eng 5 on
> hub 0
> [    3.477169] amdgpu 0000:06:00.0: ring comp_1.3.0 uses VM inv eng 6 on
> hub 0
> [    3.477170] amdgpu 0000:06:00.0: ring comp_1.0.1 uses VM inv eng 7 on
> hub 0
> [    3.477171] amdgpu 0000:06:00.0: ring comp_1.1.1 uses VM inv eng 8 on
> hub 0
> [    3.477172] amdgpu 0000:06:00.0: ring comp_1.2.1 uses VM inv eng 9 on
> hub 0
> [    3.477173] amdgpu 0000:06:00.0: ring comp_1.3.1 uses VM inv eng 10
> on hub 0
> [    3.477174] amdgpu 0000:06:00.0: ring kiq_2.1.0 uses VM inv eng 11 on
> hub 0
> [    3.477175] amdgpu 0000:06:00.0: ring sdma0 uses VM inv eng 0 on hub 1
> [    3.477177] amdgpu 0000:06:00.0: ring vcn_dec uses VM inv eng 1 on hub 1
> [    3.477178] amdgpu 0000:06:00.0: ring vcn_enc0 uses VM inv eng 4 on hub 1
> [    3.477179] amdgpu 0000:06:00.0: ring vcn_enc1 uses VM inv eng 5 on hub 1
> [    3.477180] amdgpu 0000:06:00.0: ring vcn_jpeg uses VM inv eng 6 on hub 1
>
> Full kernel dmesg is available at http://dpaste.com/1K7JRV3
>
> _______________________________________________
> amd-gfx mailing list
> amd-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/amd-gfx
