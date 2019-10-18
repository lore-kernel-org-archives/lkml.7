Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40547CA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 22:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F34F920679
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 22:40:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="GRlEguce"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405946AbfJRWkr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 18:40:47 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42007 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbfJRWkr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 18:40:47 -0400
Received: by mail-lf1-f65.google.com with SMTP id z12so5818653lfj.9
        for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2019 15:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=gHVartuIfgfDcZeVIQcCqFey7NJZ/JHLXs38iykWqqo=;
        b=GRlEguceFgE4MYenSJvagBI+m35baf3koqZYSoMZ2ZBIHiArSCi2kJpZIB1rA8E8Uk
         LFqhqdg0sUI93J7oxhy3SjhdfDPTLtamWLwhnNXMWOznEeNmterN50mCKbVPxgp6zasv
         hPsyhfiR/deU1FBFFedrHnO9H4vA2rFmT2VfN43aTSYIbIYsZNoMncCBO0v8hJeq23EE
         Uh2SaBxyvIMCeWESUbulIkv33+cCFvR0zhMAu2ceGyRmTjfXN5MtTOJEcEzbFMjoDP0K
         3R9P8tPdYDm2OwG8t3mpfTh3nEBQzyEQgsh0FnJG2SxykYTLkmv6oqkkRcB+1sR7f/+C
         3LGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=gHVartuIfgfDcZeVIQcCqFey7NJZ/JHLXs38iykWqqo=;
        b=BaqHX6+dwB0FoscHPecjjujt1W2jVB7NTc7Dzs4l0d8lMcZSSInJN1MtzBQK2Wzjew
         MP3ix+VTizhWP+7gpQo+trRmZKj0Zc+59NpCPAcmSKcjfv9+OShS4ngtHaO3aOe9ldwN
         ET4/Mbwjc9qJeacMCQT17DnkAkP9iP89mBKlrkxrVy0oasidIKgPWCifJrmJHMoNK47N
         qgY08MbSWrUOef9omblCcC5xICeybukwV7U5S9Yv+TjQZMFlsm66xbEa3cYOf7BmGKnK
         vkcMqXKTElBvitACmkjINJqoIGgUyJIPbHb4qF3LfBjyyCpXqliwqH22k1YOO1RaZE9M
         8myA==
X-Gm-Message-State: APjAAAV8OPW9ExQgb5bzDJNIzTa02blcxhOmJgPC2ztndJab54b/t2qu
        wDcJXhgtz0oSSu4YItS205fZpJp6B2XnmTe5xng=
X-Google-Smtp-Source: APXvYqxxKsAEsIOi7KzSZzV0qUButikocVrgeE2Lj/vNfw0shOc87rbB4PdLZ6diYZF1pZ81dN1cpcR/eBfw1b9obRo=
X-Received: by 2002:ac2:4c83:: with SMTP id d3mr7442709lfl.102.1571438443340;
 Fri, 18 Oct 2019 15:40:43 -0700 (PDT)
MIME-Version: 1.0
From:   Ken Moffat <zarniwhoop73@googlemail.com>
Date:   Fri, 18 Oct 2019 23:40:32 +0100
Message-ID: <CANVEwpbdQ65ry=jNUbU_YZvnZKHFC=dQcOmgewqZNGmiLt_AiA@mail.gmail.com>
Subject: amdgpu dumping during boot in picasso
To:     alexander.deucher@amd.com, christian.koenig@amd.com,
        David1.Zhou@amd.com
Cc:     amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I recently upgraded the mobo in an old machine to now use a Ryzen 5
3400G (Picasso APU). With 5.3 kernels it seems to be running well, but
an unrelated issue caused me to look at dmesg: it dumps during boot,
and then there may be related dumps later, possibly from resuming from
suspend or hibernation. The earliest usable kernel is 5.0 (Picasso is
too new for original 4.19 which doesn't load amdgpu) and it turns out
that all kernels up to and including linus's tree of a few hours ago
do this. From linus's tree:

[    2.445827] [drm] DM_PPLIB: values for F clock
[    2.445828] [drm] DM_PPLIB:   0 in kHz, 3099 in mV
[    2.445829] [drm] DM_PPLIB:   0 in kHz, 3099 in mV
[    2.445829] [drm] DM_PPLIB:   0 in kHz, 3099 in mV
[    2.445830] [drm] DM_PPLIB:   1500000 in kHz, 4399 in mV
[    2.445839] ------------[ cut here ]------------
[    2.445914] WARNING: CPU: 5 PID: 287 at
drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c:1464
dcn_bw_update_from_pplib+0xa1/0x2e0 [amdgpu]
[    2.445914] Modules linked in: amdgpu(+) k10temp mfd_core gpu_sched ttm
[    2.445920] CPU: 5 PID: 287 Comm: udevd Tainted: G                T
5.4.0-rc3-00124-g7571438a4868 #28
[    2.445921] Hardware name: Gigabyte Technology Co., Ltd. A320M-S2H
V2/A320M-S2H V2-CF, BIOS F31 04/15/2019
[    2.446006] RIP: 0010:dcn_bw_update_from_pplib+0xa1/0x2e0 [amdgpu]
[    2.446008] Code: 24 10 85 c9 74 24 8d 71 ff 48 8d 44 24 14 48 8d
54 f4 1c eb 0d 48 83 c0 08 48 39 d0 0f 84 3e 01 00 00 44 8b 00 45 85
c0 75 eb <0f> 0b e8 c8 4c b6 c9 48 89 ef 4c 89 e2 be 04 00 00 00 e8 28
8d fe
[    2.446009] RSP: 0018:ffffb60480533638 EFLAGS: 00010246
[    2.446010] RAX: ffffb6048053364c RBX: ffffa17c0a040000 RCX: 00000000000=
00004
[    2.446011] RDX: ffffb6048053366c RSI: 0000000000000003 RDI: ffffffff8b0=
08d08
[    2.446012] RBP: ffffa17c0bb03500 R08: 0000000000000000 R09: ffffffff8b7=
963b4
[    2.446013] R10: 0000000000000353 R11: 000000000002e208 R12: ffffb604805=
336d8
[    2.446013] R13: 0000000000000001 R14: 000000000000000a R15: ffffa17c0bb=
03500
[    2.446015] FS:  00007fb95ab5c780(0000) GS:ffffa17c10f40000(0000)
knlGS:0000000000000000
[    2.446015] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.446016] CR2: 00007fff52ec2348 CR3: 000000040d330000 CR4: 00000000003=
406e0
[    2.446017] Call Trace:
[    2.446022]  ? preempt_count_add+0x44/0xa0
[    2.446108]  dcn10_create_resource_pool+0x832/0xb50 [amdgpu]
[    2.446177]  ? get_smu_clock_info_v3_1+0x48/0x70 [amdgpu]
[    2.446241]  dc_create_resource_pool+0xd5/0x140 [amdgpu]
[    2.446308]  ? dal_gpio_service_create+0x84/0x100 [amdgpu]
[    2.446371]  dc_create+0x255/0x730 [amdgpu]
[    2.446374]  ? lock_timer_base+0x5c/0x80
[    2.446376]  ? apic_timer_interrupt+0xa/0x20
[    2.446378]  ? kmem_cache_alloc_trace+0x3a/0x1e0
[    2.446443]  amdgpu_dm_init+0x161/0x210 [amdgpu]
[    2.446509]  ?
phm_wait_for_register_unequal.part.0+0x4b/0x80 [amdgpu]
[    2.446574]  dm_hw_init+0x9/0x20 [amdgpu]
[    2.446638]  amdgpu_device_init.cold+0x117a/0x1325 [amdgpu]
[    2.446692]  amdgpu_driver_load_kms+0x55/0x110 [amdgpu]
[    2.446695]  drm_dev_register+0x13c/0x180
[    2.446748]  amdgpu_pci_probe+0xd4/0x130 [amdgpu]
[    2.446749]  ? __pm_runtime_resume+0x54/0x70
[    2.446751]  pci_device_probe+0xc6/0x130
[    2.446753]  really_probe+0xfc/0x2d0
[    2.446754]  driver_probe_device+0x59/0xd0
[    2.446756]  device_driver_attach+0x68/0x70
[    2.446757]  __driver_attach+0x54/0xc0
[    2.446758]  ? device_driver_attach+0x70/0x70
[    2.446758]  bus_for_each_dev+0x87/0xd0
[    2.446760]  bus_add_driver+0x18b/0x1e0
[    2.446761]  driver_register+0x67/0xb0
[    2.446762]  ? 0xffffffffc072d000
[    2.446763]  do_one_initcall+0x41/0x21f
[    2.446765]  ? kmem_cache_alloc_trace+0x3a/0x1e0
[    2.446767]  do_init_module+0x59/0x210
[    2.446769]  load_module+0x20f5/0x2420
[    2.446770]  ? frob_text.isra.0+0x20/0x20
[    2.446772]  __do_sys_finit_module+0xfd/0x120
[    2.446774]  do_syscall_64+0x43/0x110
[    2.446775]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    2.446777] RIP: 0033:0x7fb95acbede9
[    2.446778] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00
00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24
08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 77 a0 0c 00 f7 d8 64 89
01 48
[    2.446779] RSP: 002b:00007fff52ec1568 EFLAGS: 00000246 ORIG_RAX:
0000000000000139
[    2.446780] RAX: ffffffffffffffda RBX: 0000000000e78450 RCX: 00007fb95ac=
bede9
[    2.446781] RDX: 0000000000000000 RSI: 00007fb95ada084d RDI: 00000000000=
0000d
[    2.446781] RBP: 0000000000020000 R08: 0000000000000000 R09: 00007fff52e=
c1ad0
[    2.446782] R10: 000000000000000d R11: 0000000000000246 R12: 00007fb95ad=
a084d
[    2.446782] R13: 0000000000000000 R14: 0000000000e69c40 R15: 0000000000e=
78450
[    2.446783] ---[ end trace ba451112660fe31d ]---

Full dmesg and config available if required.

Any ideas, please ?

=C4=B8en
