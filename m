Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6200DC43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 11:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 241842070B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 11:47:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DC/dEYxr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726546AbfCDLrb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 06:47:31 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36310 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbfCDLra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 06:47:30 -0500
Received: by mail-lj1-f193.google.com with SMTP id v10so4052268lji.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2019 03:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=IHiotxtwlmlvKt7gcYC96XDzhqUhKaqAcVOVnztmt2s=;
        b=DC/dEYxr7G0XJaYIfB1p0SuvBWiAW1UaE2qFQpyJSEiqg7kpNRSw7pL4Qy9uJVyllB
         D1xudWhiNVe0hW3FZYOCZ/rOfg5+EBk38baKwtJ258wUg1h3hwGtqLSBTZmGMCn34UAb
         A1KuGiZFnmU45N5IM4/dzc/0VN9kNy/V7S4pvdx/c6fB2XxeYDqMdlGkcfO6fb5J8Xtx
         JklTx3AwqqALM4D86FJ1LCg8uZGHwp/iktoMw0Y0+Jb16zxidQ4/LzqL61rdHodQ4PeS
         wm6/a7XLtwKtnclc98lwzvWyB2aRJ4qtg85HYy45laxuUg2aPRmZocg9j4naexgdGyyB
         ft3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=IHiotxtwlmlvKt7gcYC96XDzhqUhKaqAcVOVnztmt2s=;
        b=IAQ+Oe7U+R7Dopf6uWVtMkbc1HcUPaRrxXdG6iPdevTusS+tdu78kqSSre0ipmQqBo
         cVhDMQoot8zlOYcIMZTXtFMm6Y+hMS9WFfdZ8AH3bG01mhn0Fr825S8eY/IeZ+Sbmjkl
         AjTleOBziuObE8fhXMHTRuB0CrHiDPkP7Fbx4eOXTKu6TxJAk5IPrjUsL7Pia8c4f/lh
         8rWjzs9Pj3bDtA0qS5hR7m/MFYDN5FzPkEKj5bgLIlDdrJeZdb9rtH+ycilFn3MlaH4y
         NSegnHvTeUDIs8FOgc1XoP8TjK8Vl9YuUCCL2L/t0tom7W9maioK5v9++dfmkhfFeCXf
         jPJg==
X-Gm-Message-State: APjAAAXQVl2ZCUmDUQ4ANSorKW9Fe1HREIU0jtyE9SNQRGdM0wGZ27gA
        CPqgFMaO7piaMzWv7Ar6uLG6YsmOIidKQTbAPQ==
X-Google-Smtp-Source: APXvYqx5Xz3e0P9r1Tea5sLfH/UQ/sj39yhQQLVaevCIQjyRHpIAmqGrZXZkKso8EblLx95UUbhrDV/XSSM5kFhanKM=
X-Received: by 2002:a2e:89d9:: with SMTP id c25mr11118386ljk.105.1551700048776;
 Mon, 04 Mar 2019 03:47:28 -0800 (PST)
MIME-Version: 1.0
References: <362a9b5f-8908-17f5-3594-6c3c68789dea@molgen.mpg.de>
In-Reply-To: <362a9b5f-8908-17f5-3594-6c3c68789dea@molgen.mpg.de>
From:   Gabriel C <nix.or.die@gmail.com>
Date:   Mon, 4 Mar 2019 12:47:40 +0100
Message-ID: <CAEJqkggKGTn0ojWzuYGfoYehDnOf=je5L-7-M1kWogutPGMg3g@mail.gmail.com>
Subject: Re: Warning at drivers/net/wireless/ath/ath10k/mac.c:5625 ath10k_bss_info_changed
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Kalle Valo <kvalo@codeaurora.org>, ath10k@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mo., 4. M=C3=A4rz 2019 um 12:28 Uhr schrieb Paul Menzel <pmenzel@molgen.=
mpg.de>:
>
> Dear Linux folks,
>
>
> Resuming from ACPI S3 on the Dell XPS 13 9370 with Debian Sid/unstable,
> Linux 4.19.20 showed the warning below. It=E2=80=99s not reproducible.
>
> ```
> [    0.000000] Linux version 4.19.0-3-amd64 (debian-kernel@lists.debian.o=
rg) (gcc version 8.2.0 (Debian 8.2.0-20)) #1 SMP Debian 4.19.20-1 (2019-02-=
11)
> [=E2=80=A6]
> [ 3018.972060] ath10k_pci 0000:02:00.0: Unknown eventid: 118809
> [ 3018.992848] WARNING: CPU: 6 PID: 3953 at drivers/net/wireless/ath/ath1=
0k/mac.c:5625 ath10k_bss_info_changed+0xd2e/0xe70 [ath10k_core]
> [ 3018.992849] Modules linked in: ctr ccm fuse snd_hda_codec_hdmi snd_hda=
_codec_realtek snd_hda_codec_generic arc4 bnep uvcvideo btusb btrtl videobu=
f2_vmalloc btbcm videobuf2_memops btintel videobuf2_v4l2 videobuf2_common b=
luetooth videodev media ecdh_generic xfrm_user xfrm4_tunnel tunnel4 ipcomp =
xfrm_ipcomp esp4 ah4 af_key l2tp_ppp xfrm_algo l2tp_netlink l2tp_core ip6_u=
dp_tunnel udp_tunnel pppox ppp_generic slhc hid_multitouch hid_generic mei_=
wdt binfmt_misc intel_rapl nls_ascii dell_wmi x86_pkg_temp_thermal intel_po=
werclamp dell_laptop nls_cp437 rtsx_pci_sdmmc iTCO_wdt dell_smbios rtsx_pci=
_ms iTCO_vendor_support vfat memstick mmc_core wmi_bmof dcdbas coretemp del=
l_wmi_descriptor fat joydev kvm_intel kvm ath10k_pci irqbypass snd_soc_skl =
crct10dif_pclmul snd_soc_skl_ipc ath10k_core crc32_pclmul snd_soc_sst_ipc
> [ 3018.992871]  snd_soc_sst_dsp snd_hda_ext_core ghash_clmulni_intel ath =
snd_soc_acpi_intel_match mac80211 snd_soc_acpi intel_cstate snd_soc_core i9=
15 intel_uncore snd_compress cfg80211 snd_hda_intel xhci_pci snd_hda_codec =
efi_pstore intel_rapl_perf xhci_hcd idma64 rtsx_pci drm_kms_helper snd_hda_=
core rfkill pcspkr i2c_hid efivars hid usbcore snd_hwdep drm snd_pcm mei_me=
 snd_timer ucsi_acpi processor_thermal_device usb_common i2c_i801 mei typec=
_ucsi intel_lpss_pci snd intel_soc_dts_iosf typec i2c_algo_bit intel_lpss s=
oundcore intel_pch_thermal wmi battery video int3403_thermal intel_hid int3=
400_thermal sparse_keymap acpi_thermal_rel acpi_pad int340x_thermal_zone ac=
 button pcc_cpufreq parport_pc ppdev lp parport efivarfs ip_tables x_tables=
 autofs4 ext4 crc16 mbcache jbd2 crc32c_generic fscrypto ecb dm_crypt
> [ 3018.992896]  dm_mod crc32c_intel nvme aesni_intel aes_x86_64 psmouse c=
rypto_simd cryptd glue_helper evdev serio_raw nvme_core thermal
> [ 3018.992902] CPU: 6 PID: 3953 Comm: kworker/u16:30 Not tainted 4.19.0-3=
-amd64 #1 Debian 4.19.20-1
> [ 3018.992903] Hardware name: Dell Inc. XPS 13 9370/0F6P3V, BIOS 1.5.1 08=
/09/2018
> [ 3018.992906] Workqueue: events_unbound async_run_entry_fn
> [ 3018.992909] RIP: 0010:ath10k_bss_info_changed+0xd2e/0xe70 [ath10k_core=
]
> [ 3018.992910] Code: 89 c1 89 f2 4c 89 d7 48 c7 c6 38 cd cc c0 4c 89 4c 2=
4 10 89 44 24 08 e8 c0 32 00 00 8b 44 24 08 4c 8b 4c 24 10 e9 a1 f8 ff ff <=
0f> 0b e9 d5 f5 ff ff 8b b3 58 01 00 00 89 f2 89 c1 48 c7 c6 f8 cc
> [ 3018.992911] RSP: 0000:ffffb9dc841ebcc0 EFLAGS: 00010246
> [ 3018.992912] RAX: 0000000000000000 RBX: ffff9673015b1380 RCX: 000000000=
0000000
> [ 3018.992912] RDX: ffff96730ed718b8 RSI: 0000000000000212 RDI: 000000000=
0000212
> [ 3018.992913] RBP: 0000000002000000 R08: 0000000000200000 R09: 000000000=
0000000
> [ 3018.992913] R10: ffff9672b00c0a00 R11: 0000000034834800 R12: ffff96730=
15b1388
> [ 3018.992914] R13: ffff96730ed71540 R14: ffff96730ed71540 R15: ffff96730=
15b14c8
> [ 3018.992914] FS:  0000000000000000(0000) GS:ffff96731e580000(0000) knlG=
S:0000000000000000
> [ 3018.992915] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 3018.992916] CR2: 0000000000000000 CR3: 000000013fa0a001 CR4: 000000000=
03606e0
> [ 3018.992916] Call Trace:
> [ 3018.992921]  ? ath10k_conf_tx+0x7a/0x4b0 [ath10k_core]
> [ 3018.992937]  ieee80211_bss_info_change_notify+0xab/0x1a0 [mac80211]
> [ 3018.992946]  ieee80211_reconfig+0x661/0x12a0 [mac80211]
> [ 3018.992962]  wiphy_resume+0x7f/0x120 [cfg80211]
> [ 3018.992969]  ? wiphy_suspend+0x270/0x270 [cfg80211]
> [ 3018.992971]  dpm_run_callback+0x59/0x150
> [ 3018.992972]  device_resume+0x97/0x190
> [ 3018.992973]  async_resume+0x19/0x30
> [ 3018.992974]  async_run_entry_fn+0x39/0x160
> [ 3018.992976]  process_one_work+0x1a7/0x3a0
> [ 3018.992978]  worker_thread+0x30/0x390
> [ 3018.992979]  ? pwq_unbound_release_workfn+0xd0/0xd0
> [ 3018.992980]  kthread+0x112/0x130
> [ 3018.992981]  ? kthread_bind+0x30/0x30
> [ 3018.992983]  ret_from_fork+0x35/0x40
> [ 3018.992984] ---[ end trace 3af618ca97bd4a0a ]---
> ```
>
> Please find all Linux messages attached.

I reported that twice and no one seems to care about.

http://lists.infradead.org/pipermail/ath10k/2018-November/012398.html
http://lists.infradead.org/pipermail/ath10k/2018-December/012658.html

BR,

Gabriel C
