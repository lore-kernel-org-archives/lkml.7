Return-Path: <SRS0=sd1o=XD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5418CC433EF
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 21:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A3E220854
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Sep 2019 21:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QzD+MNVQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730717AbfIHVYi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Sep 2019 17:24:38 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:37834 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727235AbfIHVYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 17:24:37 -0400
Received: by mail-io1-f68.google.com with SMTP id r4so24324902iop.4
        for <linux-kernel@vger.kernel.org>; Sun, 08 Sep 2019 14:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GWbpeKBeu9OGZtEEvz/24qNjOcdqH99ei/4m31vL26I=;
        b=QzD+MNVQOCiw2/A4Uvu9zniA7/poNoU6oR7Cl5WekPOgm2A76cafCBE+xan58Zgn9P
         ZWImKfn3JnnEDGyZX1OST44cTIKZ2ebuomqJ2/7VaaWQFkuSKO+8Nrl0rknW456kXNAb
         fnfMT3dnhunmGiYpyS83sEjrccAUodpBnuQVDqcVPZlytRhdahhZ6Mj4BCUSZvl9q6Nx
         smTmpdCvUvhgfoLtMKW2dHYPuYPO5rQD5Op/xfs98fGKbXLyeC2xyVcSHqMe0ihxzyh5
         sP7Whk5xY8PAWaQYkBiTJac8l1WUf1dtGhuSkcPDqHxM2IA97oxrv/No2GxNgR6j0JWn
         mvQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GWbpeKBeu9OGZtEEvz/24qNjOcdqH99ei/4m31vL26I=;
        b=KCi9++wfl6fZKR3+vJHS+DcZrdAnsYq4AW5hnaRNsXRzlcMrDPcQ4tcjV8GjUR0KtL
         +BrHcopSN2RjEWzzqozvwc0QtYGDh8+e+EuLocNAi4HVCFnoOa7MFrrKGp5OjjAkl0WZ
         vGtE3ViSQocoAghZpKoyJJU/co0o+V9iHC2NWDExbgCs0b1gwmwnLLka2GoB6cTa4nhG
         1EewA41gutrtPu80br4x7yi1CWV127vUEDOk7VQcQkPc1hA8El8vBBZabV5YRepchafi
         cZ+aqxI/o8Qwj5FnGTwScFugjPzYgDErnRQzkRECHHshI2OnMazonpgNN5FRlyfryLfT
         UI1Q==
X-Gm-Message-State: APjAAAVJZIlgmKo3lqO74OzfDQ5+tfduprgMIoLVC8U74CmRHQQO/EOh
        mGS++5XC9ymr3RgbR+F+eNAiM9/Azdp/V+Ko/IQ=
X-Google-Smtp-Source: APXvYqyP2J8cd/URoep2i+AIeY29x+JNfzarIttbwEqQc8tHhd5hdtQVYZSfzOWwUaueudBn8aB+ZQaVAkvfbrdm2so=
X-Received: by 2002:a6b:c8cf:: with SMTP id y198mr29900iof.179.1567977876171;
 Sun, 08 Sep 2019 14:24:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190830032948.13516-1-hdanton@sina.com> <CABXGCsNywbo90+wgiZ64Srm-KexypTbjiviwTW_BsO9Pm11GKQ@mail.gmail.com>
 <5d6e2298.1c69fb81.b5532.8395SMTPIN_ADDED_MISSING@mx.google.com>
 <CABXGCsMG2YrybO4_5jHaFQQxy2ywB53pY63qRfXK=ZKx5qc2Bw@mail.gmail.com>
 <CAKMK7uH9q09XadTV5Ezm=9aODErD=w_+8feujviVnF5LO_fggA@mail.gmail.com>
 <5d6f10a6.1c69fb81.6b104.af73SMTPIN_ADDED_MISSING@mx.google.com>
 <20190904083747.GE2112@phenom.ffwll.local> <CABXGCsMEjP-UQ5A1xpL-xWHxtFEsOUO14+cmWJUS1ff1hgReFA@mail.gmail.com>
 <CAKMK7uHQFpQjE8qxw5UUDg6xdbzcr0zaZ7P6WsBK7m0ksKdg3g@mail.gmail.com>
In-Reply-To: <CAKMK7uHQFpQjE8qxw5UUDg6xdbzcr0zaZ7P6WsBK7m0ksKdg3g@mail.gmail.com>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Mon, 9 Sep 2019 02:24:25 +0500
Message-ID: <CABXGCsN_r6614xDft_FY5N-B1QRFkhz27Q5U7nnr=mwtOWyCUw@mail.gmail.com>
Subject: Re: gnome-shell stuck because of amdgpu driver [5.3 RC5]
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Hillf Danton <hdanton@sina.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Linux kernel <linux-kernel@vger.kernel.org>,
        Alex Deucher <alexdeucher@gmail.com>,
        Harry Wentland <hwentlan@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Sep 2019 at 12:58, Daniel Vetter <daniel@ffwll.ch> wrote:
>
> I think those fences are only emitted for CS, not display related.
> Adding Christian K=C3=B6nig.

More fresh kernel log with 5.3RC7 - the issue still happens.
https://pastebin.com/tyxkWJYV


--
Best Regards,
Mike Gavrilov.

On Thu, 5 Sep 2019 at 12:58, Daniel Vetter <daniel@ffwll.ch> wrote:
>
> On Thu, Sep 5, 2019 at 12:27 AM Mikhail Gavrilov
> <mikhail.v.gavrilov@gmail.com> wrote:
> >
> > On Wed, 4 Sep 2019 at 13:37, Daniel Vetter <daniel@ffwll.ch> wrote:
> > >
> > > Extend your backtrac warning slightly like
> > >
> > >         WARN(r, "we're stuck on fence %pS\n", fence->ops);
> > >
> > > Also adding Harry and Alex, I'm not really working on amdgpu ...
> >
> > [ 3511.998320] ------------[ cut here ]------------
> > [ 3511.998714] we're stuck on fence
> > amdgpu_fence_ops+0x0/0xffffffffffffc220 [amdgpu]$
>
> I think those fences are only emitted for CS, not display related.
> Adding Christian K=C3=B6nig.
> -Daniel
>
> > [ 3511.998991] WARNING: CPU: 10 PID: 1811 at
> > drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c:332
> > amdgpu_fence_wait_empty+0x1c6/0x240 [amdgpu]
> > [ 3511.999009] Modules linked in: rfcomm fuse xt_CHECKSUM
> > xt_MASQUERADE nf_nat_tftp nf_conntrack_tftp tun bridge stp llc
> > nf_conntrack_netbios_ns nf_conntrack_broadcast xt_CT ip6t_REJECT
> > nf_reject_ipv6 ip6t_rpfilter ipt_REJECT nf_reject_ipv4 xt_conntrack
> > ebtable_nat ip6table_nat ip6table_mangle ip6table_raw
> > ip6table_security iptable_nat nf_nat iptable_mangle iptable_raw
> > iptable_security nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 libcrc32c
> > ip_set nfnetlink ebtable_filter ebtables ip6table_filter ip6_tables
> > iptable_filter cmac bnep sunrpc vfat fat edac_mce_amd kvm_amd
> > snd_hda_codec_realtek rtwpci snd_hda_codec_generic kvm ledtrig_audio
> > snd_hda_codec_hdmi uvcvideo rtw88 videobuf2_vmalloc snd_hda_intel
> > videobuf2_memops videobuf2_v4l2 irqbypass snd_usb_audio snd_hda_codec
> > videobuf2_common crct10dif_pclmul snd_usbmidi_lib crc32_pclmul
> > mac80211 snd_rawmidi videodev snd_hda_core ghash_clmulni_intel btusb
> > snd_hwdep btrtl snd_seq btbcm btintel snd_seq_device eeepc_wmi
> > bluetooth xpad joydev mc snd_pcm
> > [ 3511.999076]  asus_wmi ff_memless cfg80211 sparse_keymap video
> > wmi_bmof ecdh_generic snd_timer ecc sp5100_tco k10temp snd i2c_piix4
> > ccp rfkill soundcore libarc4 gpio_amdpt gpio_generic acpi_cpufreq
> > binfmt_misc ip_tables hid_logitech_hidpp hid_logitech_dj amdgpu
> > amd_iommu_v2 gpu_sched ttm drm_kms_helper drm crc32c_intel igb dca
> > nvme i2c_algo_bit nvme_core wmi pinctrl_amd
> > [ 3511.999126] CPU: 10 PID: 1811 Comm: Xorg Not tainted
> > 5.3.0-0.rc6.git2.1c.fc32.x86_64 #1
> > [ 3511.999131] Hardware name: System manufacturer System Product
> > Name/ROG STRIX X470-I GAMING, BIOS 2703 08/20/2019
> > [ 3511.999253] RIP: 0010:amdgpu_fence_wait_empty+0x1c6/0x240 [amdgpu]
> > [ 3511.999278] Code: fe ff ff 31 c0 c3 48 89 ef e8 36 29 04 cb 84 c0
> > 74 08 48 89 ef e8 8a a9 21 cb 48 8b 75 08 48 c7 c7 2c 16 86 c0 e8 82
> > b8 b9 ca <0f> 0b b8 ea ff ff ff 5d c3 e8 ec 57 c3 ca 84 c0 0f 85 6f ff
> > ff ff
> > [ 3511.999282] RSP: 0018:ffffb9c04170f798 EFLAGS: 00210282
> > [ 3511.999288] RAX: 0000000000000000 RBX: ffff8d2ce5205a80 RCX: 0000000=
000000006
> > [ 3511.999292] RDX: 0000000000000007 RSI: ffff8d2c5bea4070 RDI: ffff8d2=
cfb5d9e00
> > [ 3511.999296] RBP: ffff8d28becae480 R08: 00000331b36fd503 R09: 0000000=
000000000
> > [ 3511.999299] R10: 0000000000000000 R11: 0000000000000000 R12: ffff8d2=
ce5200000
> > [ 3511.999303] R13: 0000000000000000 R14: 0000000000000000 R15: ffff8d2=
ce1540000
> > [ 3511.999308] FS:  00007f59a5bc6f00(0000) GS:ffff8d2cfb400000(0000)
> > knlGS:0000000000000000
> > [ 3511.999311] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [ 3511.999315] CR2: 00001108bc475960 CR3: 000000075bf32000 CR4: 0000000=
0003406e0
> > [ 3511.999319] Call Trace:
> > [ 3511.999394]  amdgpu_pm_compute_clocks+0x70/0x5f0 [amdgpu]
> > [ 3511.999503]  dm_pp_apply_display_requirements+0x1a8/0x1c0 [amdgpu]
> > [ 3511.999609]  dce12_update_clocks+0xd8/0x110 [amdgpu]
> > [ 3511.999712]  dc_commit_state+0x414/0x590 [amdgpu]
> > [ 3511.999725]  ? find_held_lock+0x32/0x90
> > [ 3511.999832]  amdgpu_dm_atomic_commit_tail+0xd18/0x1cf0 [amdgpu]
> > [ 3511.999844]  ? reacquire_held_locks+0xed/0x210
> > [ 3511.999859]  ? ttm_eu_backoff_reservation+0xa5/0x160 [ttm]
> > [ 3511.999866]  ? find_held_lock+0x32/0x90
> > [ 3511.999872]  ? find_held_lock+0x32/0x90
> > [ 3511.999881]  ? __lock_acquire+0x247/0x1910
> > [ 3511.999893]  ? find_held_lock+0x32/0x90
> > [ 3511.999901]  ? mark_held_locks+0x50/0x80
> > [ 3511.999907]  ? _raw_spin_unlock_irq+0x29/0x40
> > [ 3511.999913]  ? lockdep_hardirqs_on+0xf0/0x180
> > [ 3511.999919]  ? _raw_spin_unlock_irq+0x29/0x40
> > [ 3511.999924]  ? wait_for_completion_timeout+0x75/0x190
> > [ 3511.999952]  ? commit_tail+0x3c/0x70 [drm_kms_helper]
> > [ 3511.999966]  commit_tail+0x3c/0x70 [drm_kms_helper]
> > [ 3511.999979]  drm_atomic_helper_commit+0xe3/0x150 [drm_kms_helper]
> > [ 3512.000002]  drm_mode_atomic_ioctl+0x793/0x9b0 [drm]
> > [ 3512.000014]  ? __lock_acquire+0x247/0x1910
> > [ 3512.000044]  ? drm_atomic_set_property+0xa50/0xa50 [drm]
> > [ 3512.000066]  drm_ioctl_kernel+0xaa/0xf0 [drm]
> > [ 3512.000088]  drm_ioctl+0x208/0x390 [drm]
> > [ 3512.000108]  ? drm_atomic_set_property+0xa50/0xa50 [drm]
> > [ 3512.000120]  ? lockdep_hardirqs_on+0xf0/0x180
> > [ 3512.000205]  amdgpu_drm_ioctl+0x49/0x80 [amdgpu]
> > [ 3512.000216]  do_vfs_ioctl+0x411/0x750
> > [ 3512.000229]  ksys_ioctl+0x5e/0x90
> > [ 3512.000237]  __x64_sys_ioctl+0x16/0x20
> > [ 3512.000242]  do_syscall_64+0x5c/0xb0
> > [ 3512.000249]  entry_SYSCALL_64_after_hwframe+0x49/0xbe
> > [ 3512.000254] RIP: 0033:0x7f59a603d00b
> > [ 3512.000259] Code: 0f 1e fa 48 8b 05 7d 9e 0c 00 64 c7 00 26 00 00
> > 00 48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 10 00 00
> > 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 4d 9e 0c 00 f7 d8 64 89
> > 01 48
> > [ 3512.000263] RSP: 002b:00007ffc493bcc08 EFLAGS: 00000246 ORIG_RAX:
> > 0000000000000010
> > [ 3512.000267] RAX: ffffffffffffffda RBX: 00007ffc493bcc50 RCX: 00007f5=
9a603d00b
> > [ 3512.000271] RDX: 00007ffc493bcc50 RSI: 00000000c03864bc RDI: 0000000=
00000000e
> > [ 3512.000275] RBP: 00000000c03864bc R08: 000055aa62e41d00 R09: 0000000=
000000001
> > [ 3512.000278] R10: 0000000000000001 R11: 0000000000000246 R12: 000055a=
a61a99d00
> > [ 3512.000282] R13: 000000000000000e R14: 000055aa628f7430 R15: 000055a=
a62e34540
> > [ 3512.000297] irq event stamp: 258283232
> > [ 3512.000303] hardirqs last  enabled at (258283231):
> > [<ffffffff8b170beb>] console_unlock+0x46b/0x5d0
> > [ 3512.000309] hardirqs last disabled at (258283232):
> > [<ffffffff8b0038da>] trace_hardirqs_off_thunk+0x1a/0x20
> > [ 3512.000314] softirqs last  enabled at (258282448):
> > [<ffffffff8be0035d>] __do_softirq+0x35d/0x45d
> > [ 3512.000319] softirqs last disabled at (258282413):
> > [<ffffffff8b0f1e57>] irq_exit+0xf7/0x100
> > [ 3512.000323] ---[ end trace 55ed0c80b95aef99 ]---
> >
> > https://pastebin.com/DfqVGDgc
>
>
>
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> +41 (0) 79 365 57 48 - http://blog.ffwll.ch
