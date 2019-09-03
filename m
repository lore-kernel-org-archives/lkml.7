Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B52C3A5A5
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 06:48:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62946217D7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 06:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NevHvjFb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbfICGsZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 02:48:25 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:34283 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726016AbfICGsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 02:48:25 -0400
Received: by mail-io1-f67.google.com with SMTP id s21so33531436ioa.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2019 23:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yi1hA5766L9XPvfKks2T1nSg6qw+64H+tsOFf1m8dEY=;
        b=NevHvjFb6YRUU/c6mhCSbcwTFhxC9x5kMvBYF9cITxk/Nc93ydey0Uef9bMzhuSCtz
         Xzm03HJONc+9K5lXMVkr/RXUo1VNnp0js5WzYKsI4mRr/KJ8icYK5vuOX41z6YYvcPf7
         CfijmmXxmiiewjjKoPdpYKiUvaXRGu3Uxai4hplFYvm/fmGHMmIpT12RZ/CfKskiwDtP
         WWmJEa0rRJYAY+RFe7w0tSRKuxcpKegu/cxcpCjeP8p5hjRUReKjgvRsuS0ZT6GbgppC
         j5Zb6Jez0/r4/NmHWshY7uQG/m+ZpqdI6qrZuZ+qO9mOMLE/oJfpFWP5jOMpA0Fja/Wr
         B1JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yi1hA5766L9XPvfKks2T1nSg6qw+64H+tsOFf1m8dEY=;
        b=Lpa9gRCzSdB11TxLbTY7VqwZFQVcYrnjYm3CHxDYopvUT9ytYHiZmuKzX6YRerCV8+
         MYCUvI7gyqkvCxtstxkaILiaYJ2P+mRbVdY37WsEI0p0rhkFNAFsoQf/9El6BWsUfIMM
         2ZA5xGLBeM1GA7QbpW98FKM9C/5C0UEUQ49lnE3fZTs8GdaB/MCt/xQP70h0kYK9vNYI
         wiYSdHQYL2yav8GC9pBB4zh1cBAyGxhvZifuaU/pxK/SbAUoaJ2sLFs7UV8SkndFt37N
         1ywTIi3EogVeB2lofj0H+uykL9JW1+FfqAyg7aLYJFHrOji0brOmO6Phw+OXV6ml5RHB
         o7+w==
X-Gm-Message-State: APjAAAV8yG1a8iBlpi3Dk3yPV9gDT2i9BW2auQIO3nbAWl72MUXcS+ED
        W9qlnv1RqugANrLHwrRkI171PYqyFu+Jm0J5zt0=
X-Google-Smtp-Source: APXvYqy+HcB4fBT9K9v3gy+DAYtqV+r02+0NmM0bZNkTXWFg9RJ92aF1u1TipPvnQFj9aUKW1ZVB12ERHaNUHBqc2oM=
X-Received: by 2002:a5e:9314:: with SMTP id k20mr796792iom.245.1567493303790;
 Mon, 02 Sep 2019 23:48:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190830032948.13516-1-hdanton@sina.com>
In-Reply-To: <20190830032948.13516-1-hdanton@sina.com>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Tue, 3 Sep 2019 11:48:12 +0500
Message-ID: <CABXGCsNywbo90+wgiZ64Srm-KexypTbjiviwTW_BsO9Pm11GKQ@mail.gmail.com>
Subject: Re: gnome-shell stuck because of amdgpu driver [5.3 RC5]
To:     Hillf Danton <hdanton@sina.com>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Linux kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 30 Aug 2019 at 08:30, Hillf Danton <hdanton@sina.com> wrote:
>
> Add a warning to show if it makes sense in field: neither regression nor
> problem will have been observed with the warning printed.
>

I caught the problem.

[21793.094289] ------------[ cut here ]------------
[21793.094296] gnome shell stuck warning
[21793.094391] WARNING: CPU: 14 PID: 1768 at
drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c:332
amdgpu_fence_wait_empty+0x1c2/0x230 [amdgpu]
[21793.094394] Modules linked in: rfcomm fuse xt_CHECKSUM
xt_MASQUERADE nf_nat_tftp nf_conntrack_tftp tun bridge stp llc
nf_conntrack_netbios_ns nf_conntrack_broadcast xt_CT ip6t_REJECT
nf_reject_ipv6 ip6t_rpfilter ipt_REJECT nf_reject_ipv4 xt_conntrack
ebtable_nat ip6table_nat ip6table_mangle ip6table_raw
ip6table_security iptable_nat nf_nat iptable_mangle iptable_raw
iptable_security nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c
ip_set nfnetlink ebtable_filter ebtables ip6table_filter ip6_tables
iptable_filter cmac bnep sunrpc vfat fat edac_mce_amd kvm_amd
snd_hda_codec_realtek rtwpci rtw88 snd_hda_codec_generic snd_usb_audio
kvm ledtrig_audio snd_hda_codec_hdmi snd_hda_intel mac80211
snd_hda_codec snd_usbmidi_lib irqbypass uvcvideo snd_rawmidi
snd_hda_core videobuf2_vmalloc videobuf2_memops crct10dif_pclmul btusb
videobuf2_v4l2 snd_hwdep crc32_pclmul btrtl videobuf2_common snd_seq
eeepc_wmi btbcm xpad asus_wmi btintel snd_seq_device
ghash_clmulni_intel cfg80211 sparse_keymap
[21793.094426]  ff_memless joydev bluetooth videodev video snd_pcm
wmi_bmof mc ecdh_generic snd_timer ecc snd ccp rfkill libarc4
soundcore sp5100_tco k10temp i2c_piix4 gpio_amdpt gpio_generic
acpi_cpufreq binfmt_misc ip_tables hid_logitech_hidpp hid_logitech_dj
amdgpu amd_iommu_v2 gpu_sched ttm drm_kms_helper igb drm nvme dca
crc32c_intel i2c_algo_bit nvme_core wmi pinctrl_amd
[21793.094449] CPU: 14 PID: 1768 Comm: Xorg Tainted: G        W
 5.3.0-0.rc6.git2.1b.fc32.x86_64 #1
[21793.094452] Hardware name: System manufacturer System Product
Name/ROG STRIX X470-I GAMING, BIOS 2406 06/21/2019
[21793.094499] RIP: 0010:amdgpu_fence_wait_empty+0x1c2/0x230 [amdgpu]
[21793.094502] Code: b5 f4 e9 c1 fe ff ff 31 c0 c3 48 89 ef e8 36 69
f8 f4 84 c0 74 08 48 89 ef e8 8a e9 15 f5 48 c7 c7 2c d6 91 c0 e8 86
f8 ad f4 <0f> 0b b8 ea ff ff ff 5d c3 e8 f0 97 b7 f4 84 c0 0f 85 73 ff
ff ff
[21793.094505] RSP: 0018:ffffae13418c3798 EFLAGS: 00010282
[21793.094508] RAX: 0000000000000000 RBX: ffff8aa065f85a80 RCX: 0000000000000006
[21793.094511] RDX: 0000000000000007 RSI: ffff8a9fe32ec070 RDI: ffff8aa07bdd9e00
[21793.094513] RBP: ffff8aa069469d00 R08: 000013d219a4ead6 R09: 0000000000000000
[21793.094516] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8aa065f80000
[21793.094518] R13: 0000000000000000 R14: 0000000000000000 R15: ffff8aa065fb0000
[21793.094521] FS:  00007f586201cf00(0000) GS:ffff8aa07bc00000(0000)
knlGS:0000000000000000
[21793.094524] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[21793.094526] CR2: 00007f57fc5b5000 CR3: 0000000763340000 CR4: 00000000003406e0
[21793.094528] Call Trace:
[21793.094580]  amdgpu_pm_compute_clocks+0x70/0x5f0 [amdgpu]
[21793.094655]  dm_pp_apply_display_requirements+0x1a8/0x1c0 [amdgpu]
[21793.094728]  dce12_update_clocks+0xd8/0x110 [amdgpu]
[21793.094799]  dc_commit_state+0x414/0x590 [amdgpu]
[21793.094807]  ? find_held_lock+0x32/0x90
[21793.094880]  amdgpu_dm_atomic_commit_tail+0xd18/0x1cf0 [amdgpu]
[21793.094888]  ? reacquire_held_locks+0xed/0x210
[21793.094898]  ? ttm_eu_backoff_reservation+0xa5/0x160 [ttm]
[21793.094903]  ? find_held_lock+0x32/0x90
[21793.094906]  ? find_held_lock+0x32/0x90
[21793.094912]  ? __lock_acquire+0x247/0x1910
[21793.094920]  ? find_held_lock+0x32/0x90
[21793.094925]  ? mark_held_locks+0x50/0x80
[21793.094929]  ? _raw_spin_unlock_irq+0x29/0x40
[21793.094933]  ? lockdep_hardirqs_on+0xf0/0x180
[21793.094937]  ? _raw_spin_unlock_irq+0x29/0x40
[21793.094941]  ? wait_for_completion_timeout+0x75/0x190
[21793.094954]  ? commit_tail+0x3c/0x70 [drm_kms_helper]
[21793.094962]  commit_tail+0x3c/0x70 [drm_kms_helper]
[21793.094971]  drm_atomic_helper_commit+0xe3/0x150 [drm_kms_helper]
[21793.094986]  drm_mode_atomic_ioctl+0x793/0x9b0 [drm]
[21793.094994]  ? __lock_acquire+0x247/0x1910
[21793.095013]  ? drm_atomic_set_property+0xa50/0xa50 [drm]
[21793.095025]  drm_ioctl_kernel+0xaa/0xf0 [drm]
[21793.095039]  drm_ioctl+0x208/0x390 [drm]
[21793.095053]  ? drm_atomic_set_property+0xa50/0xa50 [drm]
[21793.095060]  ? lockdep_hardirqs_on+0xf0/0x180
[21793.095108]  amdgpu_drm_ioctl+0x49/0x80 [amdgpu]
[21793.095114]  do_vfs_ioctl+0x411/0x750
[21793.095121]  ksys_ioctl+0x5e/0x90
[21793.095126]  __x64_sys_ioctl+0x16/0x20
[21793.095130]  do_syscall_64+0x5c/0xb0
[21793.095135]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
[21793.095138] RIP: 0033:0x7f586249300b
[21793.095142] Code: 0f 1e fa 48 8b 05 7d 9e 0c 00 64 c7 00 26 00 00
00 48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 10 00 00
00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 4d 9e 0c 00 f7 d8 64 89
01 48
[21793.095144] RSP: 002b:00007ffcfa7f6c08 EFLAGS: 00000246 ORIG_RAX:
0000000000000010
[21793.095147] RAX: ffffffffffffffda RBX: 00007ffcfa7f6c50 RCX: 00007f586249300b
[21793.095149] RDX: 00007ffcfa7f6c50 RSI: 00000000c03864bc RDI: 000000000000000e
[21793.095152] RBP: 00000000c03864bc R08: 00005647f11aab00 R09: 0000000000000001
[21793.095154] R10: 0000000000000001 R11: 0000000000000246 R12: 00005647f05870e0
[21793.095156] R13: 000000000000000e R14: 00005647f08df6a0 R15: 00005647f09d7940
[21793.095166] irq event stamp: 822588868
[21793.095170] hardirqs last  enabled at (822588867):
[<ffffffffb5170beb>] console_unlock+0x46b/0x5d0
[21793.095173] hardirqs last disabled at (822588868):
[<ffffffffb50038da>] trace_hardirqs_off_thunk+0x1a/0x20
[21793.095177] softirqs last  enabled at (822588724):
[<ffffffffb5e0035d>] __do_softirq+0x35d/0x45d
[21793.095181] softirqs last disabled at (822588717):
[<ffffffffb50f1e57>] irq_exit+0xf7/0x100
[21793.095183] ---[ end trace 67af5f8c4c325f95 ]---


Full dmesg log here https://pastebin.com/2Nab7AC3
Any idea how completely to fix it ?

--
Best Regards,
Mike Gavrilov.
