Return-Path: <SRS0=B1dt=RW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB90C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 08:24:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D276520854
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Mar 2019 08:24:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727399AbfCSIYy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Mar 2019 04:24:54 -0400
Received: from mx2.cyber.ee ([193.40.6.72]:48580 "EHLO mx2.cyber.ee"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbfCSIYy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Mar 2019 04:24:54 -0400
To:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
From:   Meelis Roos <mroos@linux.ee>
Subject: 5.1-rc1: radeon WARNING: CPU: 1 PID: 160 at
 drivers/gpu/drm/drm_fourcc.c:278 drm_format_info+0x74/0xe0 [drm]
Message-ID: <05d8d52e-a9ce-d502-fff0-d1d951acd206@linux.ee>
Date:   Tue, 19 Mar 2019 10:24:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: et-EE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am seeing the following warning on at least 2 different servers with onboard radeon graphics.
It was not there with 5.0.

[    4.764838] [drm] radeon kernel modesetting enabled.
[    4.765334] radeon 0000:01:01.0: vgaarb: deactivate vga console
[    4.767746] Console: switching to colour dummy device 80x25
[    4.768285] [drm] initializing kernel modesetting (RV100 0x1002:0x515E 0x1014:0x0305 0x02).
[    4.768492] radeon 0000:01:01.0: VRAM: 128M 0x00000000D0000000 - 0x00000000D7FFFFFF (16M used)
[    4.768498] radeon 0000:01:01.0: GTT: 512M 0x00000000B0000000 - 0x00000000CFFFFFFF
[    4.769756] [drm] Detected VRAM RAM=128M, BAR=128M
[    4.769760] [drm] RAM width 16bits DDR
[    4.771231] [TTM] Zone  kernel: Available graphics memory: 2023308 kiB
[    4.771238] [TTM] Initializing pool allocator
[    4.771247] [TTM] Initializing DMA pool allocator
[    4.771282] [drm] radeon: 16M of VRAM memory ready
[    4.771285] [drm] radeon: 512M of GTT memory ready.
[    4.771308] [drm] GART: num cpu pages 131072, num gpu pages 131072
[    4.792356] [drm] PCI GART of 512M enabled (table at 0x00000000BBA00000).
[    4.792476] radeon 0000:01:01.0: WB disabled
[    4.792486] radeon 0000:01:01.0: fence driver on ring 0 use gpu addr 0x00000000b0000000 and cpu addr 0x(____ptrval____)
[    4.792492] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    4.792495] [drm] Driver supports precise vblank timestamp query.
[    4.792518] [drm] radeon: irq initialized.
[    4.792537] [drm] Loading R100 Microcode
[    4.809842] [drm] radeon: ring at 0x00000000B0001000
[    4.809886] [drm] ring test succeeded in 1 usecs
[    4.810559] [drm] ib test succeeded in 0 usecs
[    4.811424] [drm] No valid Ext TMDS info found in BIOS
[    4.811472] [drm] Radeon Display Connectors
[    4.811476] [drm] Connector 0:
[    4.811479] [drm]   VGA-1
[    4.811482] [drm]   DDC: 0x60 0x60 0x60 0x60 0x60 0x60 0x60 0x60
[    4.811485] [drm]   Encoders:
[    4.811488] [drm]     CRT1: INTERNAL_DAC1
[    4.811491] [drm] Connector 1:
[    4.811494] [drm]   DVI-D-1
[    4.811496] [drm]   HPD2
[    4.811499] [drm]   DDC: 0x64 0x64 0x64 0x64 0x64 0x64 0x64 0x64
[    4.811502] [drm]   Encoders:
[    4.811504] [drm]     DFP2: INTERNAL_DVO1
[    4.857555] [drm] requested bpp 16, scaled depth down to 0
[    4.857643] WARNING: CPU: 1 PID: 160 at drivers/gpu/drm/drm_fourcc.c:278 drm_format_info+0x74/0xe0 [drm]
[    4.857659] Modules linked in: radeon(+) coretemp kvm_intel ses kvm i2c_algo_bit drm_kms_helper syscopyarea sysfillrect iTCO_wdt sysimgblt fb_sys_fops iTCO_vendor_support ttm bnx2 enclosure ipmi_ssif drm lpc_ich irqbypass drm_panel_orientation_quirks scsi_transport_sas i2c_i801 evdev psmouse ibmpex mfd_core ibmaem pcspkr ata_piix ipmi_devintf libata ipmi_msghandler i5000_edac i5k_amb button rng_core ip_tables x_tables autofs4
[    4.857698] CPU: 1 PID: 160 Comm: systemd-udevd Not tainted 5.1.0-rc1 #11
[    4.857702] Hardware name: IBM IBM System x3550 -[7978E2G]-/System Planar, BIOS -[GFE149BUS-1.17]- 02/14/2011
[    4.857717] RIP: 0010:drm_format_info+0x74/0xe0 [drm]
[    4.857722] Code: 4a 8d 14 33 48 89 d8 48 81 fa f0 05 00 00 77 41 45 39 ef 75 d3 49 83 fc 4c 77 5b 48 83 c4 08 5b 5d 41 5c 41 5d 41 5e 41 5f c3 <0f> 0b 48 83 c4 08 31 c0 5b 5d 41 5c 41 5d 41 5e 41 5f c3 48 89 cf
[    4.857729] RSP: 0018:ffffa5e4002278b8 EFLAGS: 00010246
[    4.857733] RAX: ffffffffc03e99bc RBX: ffffffffc03e99d0 RCX: ffffffffc0412600
[    4.857736] RDX: 00000000000005e0 RSI: 0000000000000000 RDI: 0000000000000000
[    4.857740] RBP: 000000000000004c R08: ffffffffc04e6a60 R09: 0000000000000000
[    4.857743] R10: 0000000000000002 R11: 0000000000000000 R12: 000000000000004b
[    4.857747] R13: 0000000036313050 R14: 000000003fc16c24 R15: 0000000000000000
[    4.857751] FS:  00007fb1a5852d40(0000) GS:ffff9c1f3fd00000(0000) knlGS:0000000000000000
[    4.857755] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    4.857759] CR2: 00005619ca47603c CR3: 0000000139abc000 CR4: 00000000000006e0
[    4.857762] Call Trace:
[    4.857783]  drm_format_plane_cpp+0xa/0x40 [drm]
[    4.857946]  radeonfb_create+0x74/0x4a0 [radeon]
[    4.857960]  ? printk+0x53/0x6a
[    4.857978]  __drm_fb_helper_initial_config_and_unlock+0x2d6/0x510 [drm_kms_helper]
[    4.858026]  radeon_fbdev_init+0x106/0x130 [radeon]
[    4.858075]  radeon_modeset_init.cold.16+0x2a2/0xac5 [radeon]
[    4.858116]  radeon_driver_load_kms+0xa0/0x1e0 [radeon]
[    4.858129]  drm_dev_register+0x10c/0x1a0 [drm]
[    4.858144]  drm_get_pci_dev+0x90/0x190 [drm]
[    4.858152]  pci_device_probe+0xa1/0x110
[    4.858159]  really_probe+0xe6/0x2a0
[    4.858163]  driver_probe_device+0x59/0xe0
[    4.858167]  device_driver_attach+0x4b/0x50
[    4.858170]  __driver_attach+0x46/0xb0
[    4.858174]  ? device_driver_attach+0x50/0x50
[    4.858178]  bus_for_each_dev+0x72/0xb0
[    4.858183]  bus_add_driver+0xff/0x1f0
[    4.858187]  ? 0xffffffffc0791000
[    4.858191]  driver_register+0x56/0xe0
[    4.858194]  ? 0xffffffffc0791000
[    4.858200]  do_one_initcall+0x7e/0x19b
[    4.858207]  do_init_module+0x59/0x1e0
[    4.858211]  load_module+0x2030/0x2820
[    4.858216]  ? __do_sys_finit_module+0xba/0xe0
[    4.858220]  __do_sys_finit_module+0xba/0xe0
[    4.858224]  do_syscall_64+0x4a/0xf0
[    4.858231]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[    4.858236] RIP: 0033:0x7fb1a603d2a9
[    4.858240] Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d b7 6b 0c 00 f7 d8 64 89 01 48
[    4.858246] RSP: 002b:00007ffd46f1bbd8 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[    4.858251] RAX: ffffffffffffffda RBX: 0000559eddfec720 RCX: 00007fb1a603d2a9
[    4.858254] RDX: 0000000000000000 RSI: 00007fb1a5f41cad RDI: 0000000000000017
[    4.858258] RBP: 00007fb1a5f41cad R08: 0000000000000000 R09: 0000000000000000
[    4.858262] R10: 0000000000000017 R11: 0000000000000246 R12: 0000000000000000
[    4.858265] R13: 0000559eddfe7060 R14: 0000000000020000 R15: 0000559eddfec720
[    4.858271] ---[ end trace 42222ae78d4354eb ]---
[    4.858281] [TTM] Illegal buffer object size
[    4.858287] [TTM] Illegal buffer object size
[    4.858336] [drm:radeon_gem_object_create [radeon]] *ERROR* Failed to allocate GEM object (0, 6, 4096, -22)
[    4.858340] failed to allocate framebuffer (0)
[    4.858385] [drm:radeonfb_create [radeon]] *ERROR* failed to create fbcon object -12
[    4.858416] [drm] Initialized radeon 2.50.0 20080528 for 0000:01:01.0 on minor 0


-- 
Meelis Roos <mroos@linux.ee>
