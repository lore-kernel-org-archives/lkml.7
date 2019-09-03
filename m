Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 650E6C3A5A2
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 23:17:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20F5822CED
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 23:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sequielo-com-ar.20150623.gappssmtp.com header.i=@sequielo-com-ar.20150623.gappssmtp.com header.b="RqpcJh4+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727651AbfICXRw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 19:17:52 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:47014 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726451AbfICXRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 19:17:52 -0400
Received: by mail-qk1-f193.google.com with SMTP id 201so8281127qkd.13
        for <linux-kernel@vger.kernel.org>; Tue, 03 Sep 2019 16:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sequielo-com-ar.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to;
        bh=tQ7K+3HWKbiik3/g1SEzQSIcjPNYZUGislFT51VG5eQ=;
        b=RqpcJh4+I0IItH0ck73674aoE4yFlQwrCCNS+6tsi5GkORY8GHLF7GPDtVfPUGFjpl
         KQj237UDJ00Rv/oyZ6UsPtjT0iNnDi7I+jSDkXU9Hj1qPAk1Xa6Y0sCVSdBM9sOM7ROd
         bFWNbU0EQuHvEBjR9jlnLKCKkztXVYjNce2WK9qch4LkLvimXvOHKewbsYfp5g1InvSa
         Dy0pKL+T1vNXV1aKDWJb1yLkgZrPUO2D8T6Jk/nGCbEyFysRIdXyL9zU9QNTnOWenakK
         ppXAKRiqyVUaRZdLkCNDA67DmU7sUzqYOIn7duQi7CU4xfJHZxzsc9Z4kbLus8aXoBKF
         kGsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=tQ7K+3HWKbiik3/g1SEzQSIcjPNYZUGislFT51VG5eQ=;
        b=GKX3GSuMVCFFk3bgJLTInTGvbOTndRcC/aoe02AWKDfKw6LPm/aI/i7NZ1it+J0nRp
         UyKwXsgAFjt06TWTv3yemPHe/rM9YZI8FlWxiyhkkMyfDay7DovYadRgjR8fdBWdLV1j
         x/tambOst+oeU1g4zCuPW+AQuYKd4jCTNVxVbua8b86JeU89j7aHM6L9ju8ybO0RsImw
         oIkAXWCo66sfCz+xwYbgb+rh+D54w9nSj4YAuCEsxsgusAsSavabueDmh6gj+0UPGc3u
         qCKFrX7AKsQPCZU/9xT3NK4WB8nv/lPgMdTKNv7aMcSML4gmnBHfxMjM8iApK6qbyfe4
         J5aQ==
X-Gm-Message-State: APjAAAUilkJ8n6Uqz6CDz8XdbEP68VU+wDOoj92Ivz08tkiGt1EOwh7y
        aTf8sq6fFgSxDTR4KqlJgNtzRldamCRFF/dF/71MXbHbLmk=
X-Google-Smtp-Source: APXvYqxv9+t1J7IyggnKChvWwzadNh/2BRvXvvxlRspZQhSreRH3nC3SdaaEMmRt8MKrtybmfytD1NuwfePbQwsmeuc=
X-Received: by 2002:a37:d287:: with SMTP id f129mr37115614qkj.490.1567552670656;
 Tue, 03 Sep 2019 16:17:50 -0700 (PDT)
MIME-Version: 1.0
From:   Developer sequielo <dev@sequielo.com.ar>
Date:   Tue, 3 Sep 2019 20:17:39 -0300
Message-ID: <CAH9j2i1R5cfvXh=7TEy44xitODSQdMqcVJi3_B2qo_rJwt3gTA@mail.gmail.com>
Subject: Several errors on my dmesg on kernel 4.15.18
To:     linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[    0.000000] Linux version 4.15.0-60-generic
(buildd@lgw01-amd64-030) (gcc version 7.4.0 (Ubuntu
7.4.0-1ubuntu1~18.04.1)) #67-Ubuntu SMP Thu Aug 22 16:55:30 UTC 2019
(Ubuntu 4.15.0-60.67-generic 4.15.18)
[    0.000000] Command line:
BOOT_IMAGE=/boot/vmlinuz-4.15.0-60-generic
root=UUID=1d57aaf7-8a07-4a4b-a82b-35839ff47585 ro quiet splash
amd_iommu=on iommu=pt kvm_amd.npt=1 vt.handoff=1

------

[    2.559734] ------------[ cut here ]------------
[    2.559777] WARNING: CPU: 5 PID: 325 at
/build/linux-5mCauq/linux-4.15.0/drivers/gpu/drm/amd/amdgpu/../display/dc/dc_helper.c:190
generic_reg_wait+0xf9/0x140 [amdgpu]
[    2.559777] Modules linked in: dm_mirror dm_region_hash dm_log
hid_generic hid_logitech_hidpp hid_logitech_dj usbhid hid amdkfd
amd_iommu_v2 amdgpu chash i2c_algo_bit ttm drm_kms_helper syscopyarea
sysfillrect sysimgblt fb_sys_fops nvme drm i2c_piix4 r8169 nvme_core
ahci mii libahci wmi gpio_amdpt video gpio_generic
[    2.559792] CPU: 5 PID: 325 Comm: plymouthd Not tainted
4.15.0-60-generic #67-Ubuntu
[    2.559793] Hardware name: Micro-Star International Co., Ltd.
MS-7A40/B450I GAMING PLUS AC (MS-7A40), BIOS A.80 07/22/2019
[    2.559822] RIP: 0010:generic_reg_wait+0xf9/0x140 [amdgpu]
[    2.559823] RSP: 0018:ffffbd7e0253b930 EFLAGS: 00010286
[    2.559824] RAX: 0000000000000024 RBX: 0000000000000065 RCX: ffffffffa8863a28
[    2.559825] RDX: 0000000000000000 RSI: 0000000000000082 RDI: 0000000000000247
[    2.559826] RBP: ffffbd7e0253b970 R08: 00000000000003da R09: 0000000000000004
[    2.559826] R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000001
[    2.559827] R13: ffff9a900e70f600 R14: 0000000000000100 R15: 0000000000000001
[    2.559828] FS:  00007f09c7e75740(0000) GS:ffff9a901e940000(0000)
knlGS:0000000000000000
[    2.559828] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.559829] CR2: 000055ac97c3cf58 CR3: 0000000402376000 CR4: 00000000003406e0
[    2.559830] Call Trace:
[    2.559863]  tgn10_lock+0xa2/0xb0 [amdgpu]
[    2.559893]  program_all_pipe_in_tree+0x7f3/0x8f0 [amdgpu]
[    2.559920]  ? generic_reg_update_ex+0xf1/0x1e0 [amdgpu]
[    2.559946]  ? generic_reg_wait+0x76/0x140 [amdgpu]
[    2.559974]  ? amdgpu_cgs_write_register+0x14/0x20 [amdgpu]
[    2.560000]  ? generic_reg_update_ex+0xf1/0x1e0 [amdgpu]
[    2.560025]  ? amdgpu_cgs_read_register+0x14/0x20 [amdgpu]
[    2.560053]  dcn10_apply_ctx_for_surface+0x4bf/0x510 [amdgpu]
[    2.560080]  dc_commit_state+0x2aa/0x500 [amdgpu]
[    2.560110]  amdgpu_dm_atomic_commit_tail+0x2ea/0xb20 [amdgpu]
[    2.560128]  ? amdgpu_bo_pin_restricted+0x1bb/0x2a0 [amdgpu]
[    2.560134]  commit_tail+0x42/0x70 [drm_kms_helper]
[    2.560138]  drm_atomic_helper_commit+0x10c/0x120 [drm_kms_helper]
[    2.560165]  amdgpu_dm_atomic_commit+0x8d/0xa0 [amdgpu]
[    2.560175]  drm_atomic_commit+0x51/0x60 [drm]
[    2.560179]  restore_fbdev_mode_atomic+0x17f/0x1f0 [drm_kms_helper]
[    2.560183]  restore_fbdev_mode+0x32/0x140 [drm_kms_helper]
[    2.560186]  ? _cond_resched+0x19/0x40
[    2.560189]
drm_fb_helper_restore_fbdev_mode_unlocked.part.32+0x28/0x80
[drm_kms_helper]
[    2.560192]  drm_fb_helper_restore_fbdev_mode_unlocked+0x26/0x30
[drm_kms_helper]
[    2.560210]  amdgpu_fbdev_restore_mode+0x1f/0x50 [amdgpu]
[    2.560226]  amdgpu_driver_lastclose_kms+0x12/0x20 [amdgpu]
[    2.560232]  drm_lastclose+0x3c/0xf0 [drm]
[    2.560238]  drm_release+0x2cf/0x390 [drm]
[    2.560241]  __fput+0xea/0x220
[    2.560242]  ____fput+0xe/0x10
[    2.560245]  task_work_run+0x9d/0xc0
[    2.560251]  exit_to_usermode_loop+0xc0/0xd0
[    2.560252]  do_syscall_64+0x121/0x130
[    2.560254]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
[    2.560255] RIP: 0033:0x7f09c75488d4
[    2.560255] RSP: 002b:00007ffe3088be98 EFLAGS: 00000246 ORIG_RAX:
0000000000000003
[    2.560256] RAX: 0000000000000000 RBX: 000055ac97c3a470 RCX: 00007f09c75488d4
[    2.560257] RDX: 000055ac97c496a0 RSI: 0000000000000000 RDI: 0000000000000009
[    2.560257] RBP: 0000000000000009 R08: 000055ac97c496b0 R09: 0000000000000000
[    2.560258] R10: 000055ac97c30010 R11: 0000000000000246 R12: 000000000000e200
[    2.560258] R13: 0000000000000000 R14: 00007f09c783bb80 R15: 00007f09c783bad0
[    2.560259] Code: 72 c0 48 c7 c7 8e 04 73 c0 44 89 55 d4 50 e8 8f
d1 d4 ff 41 83 7d 20 01 44 8b 55 d4 58 74 12 48 c7 c7 c0 89 72 c0 e8
27 ac e4 e6 <0f> 0b 44 8b 55 d4 48 8d 65 d8 44 89 d0 5b 41 5c 41 5d 41
5e 41
[    2.560278] ---[ end trace 7a4a80512ef462da ]---


-----
[  189.323433] ------------[ cut here ]------------
[  189.323496] WARNING: CPU: 7 PID: 1111 at
/build/linux-5mCauq/linux-4.15.0/drivers/gpu/drm/amd/amdgpu/../display/dc/dc_helper.c:190
generic_reg_wait+0xf9/0x140 [amdgpu]
[  189.323496] Modules linked in: ccm cmac bnep btusb btrtl btbcm
input_leds btintel bluetooth ecdh_generic bridge stp llc devlink aufs
overlay snd_hda_codec_realtek edac_mce_amd snd_hda_codec_generic
kvm_amd snd_hda_codec_hdmi arc4 kvm snd_hda_intel irqbypass
snd_hda_codec crct10dif_pclmul crc32_pclmul snd_hda_core snd_hwdep
ghash_clmulni_intel snd_seq_midi snd_seq_midi_event pcbc snd_pcm
snd_rawmidi iwlmvm mac80211 aesni_intel aes_x86_64 crypto_simd
glue_helper cryptd snd_seq snd_seq_device iwlwifi snd_timer snd
wmi_bmof k10temp soundcore cfg80211 shpchp mac_hid sch_fq_codel
nct6775 hwmon_vid parport_pc ppdev lp parport ip_tables x_tables
autofs4 btrfs xor zstd_compress uas usb_storage raid6_pq dm_mirror
dm_region_hash dm_log hid_generic hid_logitech_hidpp hid_logitech_dj
usbhid hid amdkfd amd_iommu_v2
[  189.323525]  amdgpu chash i2c_algo_bit ttm drm_kms_helper
syscopyarea sysfillrect sysimgblt fb_sys_fops nvme drm i2c_piix4 r8169
nvme_core ahci mii libahci wmi gpio_amdpt video gpio_generic
[  189.323536] CPU: 7 PID: 1111 Comm: Xorg Tainted: G        W
4.15.0-60-generic #67-Ubuntu
[  189.323537] Hardware name: Micro-Star International Co., Ltd.
MS-7A40/B450I GAMING PLUS AC (MS-7A40), BIOS A.80 07/22/2019
[  189.323566] RIP: 0010:generic_reg_wait+0xf9/0x140 [amdgpu]
[  189.323567] RSP: 0018:ffffbd7e03f777c8 EFLAGS: 00010282
[  189.323568] RAX: 0000000000000024 RBX: 0000000000000065 RCX: 0000000000000006
[  189.323569] RDX: 0000000000000000 RSI: 0000000000000096 RDI: ffff9a901e9d6490
[  189.323569] RBP: ffffbd7e03f77808 R08: 00000000000004ce R09: 0000000000000004
[  189.323570] R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000001
[  189.323570] R13: ffff9a900e70f600 R14: 0000000000000100 R15: 0000000000000001
[  189.323571] FS:  00007f1918081600(0000) GS:ffff9a901e9c0000(0000)
knlGS:0000000000000000
[  189.323572] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  189.323572] CR2: 000055f409bb97b0 CR3: 00000004081be000 CR4: 00000000003406e0
[  189.323573] Call Trace:
[  189.323607]  tgn10_lock+0xa2/0xb0 [amdgpu]
[  189.323635]  program_all_pipe_in_tree+0x7f3/0x8f0 [amdgpu]
[  189.323638]  ? free_one_page+0x76/0x400
[  189.323659]  ? amdgpu_cgs_read_register+0x14/0x20 [amdgpu]
[  189.323681]  dcn10_apply_ctx_for_surface+0x4bf/0x510 [amdgpu]
[  189.323703]  dc_commit_state+0x2aa/0x500 [amdgpu]
[  189.323727]  amdgpu_dm_atomic_commit_tail+0x2ea/0xb20 [amdgpu]
[  189.323741]  ? amdgpu_bo_pin_restricted+0x1bb/0x2a0 [amdgpu]
[  189.323743]  ? wait_for_completion_interruptible+0x35/0x180
[  189.323744]  ? ww_mutex_unlock+0x26/0x30
[  189.323748]  commit_tail+0x42/0x70 [drm_kms_helper]
[  189.323752]  drm_atomic_helper_commit+0x10c/0x120 [drm_kms_helper]
[  189.323773]  amdgpu_dm_atomic_commit+0x8d/0xa0 [amdgpu]
[  189.323782]  drm_atomic_commit+0x51/0x60 [drm]
[  189.323785]  drm_atomic_helper_set_config+0x7c/0x90 [drm_kms_helper]
[  189.323791]  __drm_mode_set_config_internal+0x6b/0x120 [drm]
[  189.323796]  drm_mode_setcrtc+0x17a/0x6c0 [drm]
[  189.323802]  ? drm_mode_getcrtc+0x190/0x190 [drm]
[  189.323806]  drm_ioctl_kernel+0x5f/0xb0 [drm]
[  189.323811]  drm_ioctl+0x38e/0x460 [drm]
[  189.323816]  ? drm_mode_getcrtc+0x190/0x190 [drm]
[  189.323829]  amdgpu_drm_ioctl+0x4f/0x90 [amdgpu]
[  189.323831]  do_vfs_ioctl+0xa8/0x630
[  189.323832]  SyS_ioctl+0x79/0x90
[  189.323834]  do_syscall_64+0x73/0x130
[  189.323835]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
[  189.323836] RIP: 0033:0x7f191547e5d7
[  189.323837] RSP: 002b:00007ffc3ca12108 EFLAGS: 00003246 ORIG_RAX:
0000000000000010
[  189.323838] RAX: ffffffffffffffda RBX: 00007ffc3ca12140 RCX: 00007f191547e5d7
[  189.323838] RDX: 00007ffc3ca12140 RSI: 00000000c06864a2 RDI: 000000000000000f
[  189.323839] RBP: 00007ffc3ca12140 R08: 0000000000000000 R09: 000055f40a4a18d0
[  189.323839] R10: 00007ffc3ca12200 R11: 0000000000003246 R12: 00000000c06864a2
[  189.323839] R13: 000000000000000f R14: 0000000000000000 R15: 000055f40a4a18d0
[  189.323840] Code: 72 c0 48 c7 c7 8e 04 73 c0 44 89 55 d4 50 e8 8f
d1 d4 ff 41 83 7d 20 01 44 8b 55 d4 58 74 12 48 c7 c7 c0 89 72 c0 e8
27 ac e4 e6 <0f> 0b 44 8b 55 d4 48 8d 65 d8 44 89 d0 5b 41 5c 41 5d 41
5e 41
[  189.323858] ---[ end trace 7a4a80512ef462db ]---
