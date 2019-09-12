Return-Path: <SRS0=nCuq=XH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2137EC49ED9
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 09:24:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D61472084F
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Sep 2019 09:24:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DBbJsAAZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730758AbfILJYx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Sep 2019 05:24:53 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:44416 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730175AbfILJYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 05:24:52 -0400
Received: by mail-lf1-f66.google.com with SMTP id q11so3806312lfc.11
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2019 02:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yHQnV9O9yrLOCUG3Vr898tC1TxZ1cDR4UaNF7upy7JA=;
        b=DBbJsAAZDVIjUKR7ohKRWrSZsn/K7qLiMHwWz+bc7dLhhWl5NypE8lYkowVBHrJj+Q
         k12L3KMFQdCH/aDsivkH0oqDvm/sy1uHlTAnO5QPZlBNtsd1UF2e0bhWN5d/kZyzlka+
         2EKab7J3W/4r54nB+6gXksXBufzoeDfDchCOBO5m6+G3LTWjoYXby+BTbt7FUc8eCTs+
         dBygoYZzj0HfFPMdiQGhO68B7fNNDqy3Wkcfi+zRCm941BZEQwYfgKdcOMW8ROspD/cP
         1hV2Ji1a6jh5/m/IWcXr0Sy7ndMfvqG88+NqsPhMixncSmxskJZV+jnG3HidWHwRpDWR
         +JuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yHQnV9O9yrLOCUG3Vr898tC1TxZ1cDR4UaNF7upy7JA=;
        b=fxkOsFjQiqY37iZbdb6Bc41AZZvKqdO6yNAguFE2DgQ6eWhTS6k4tQpKfg/lNTukse
         QyIW3PBmqvQenmVsTQlNa6Ra0fTtGF4+4eu6mwQbl4kSws72kxedowlmK0Y4Pk+9X5GZ
         I54sPu88MEykQhzJG2F79IHcgVAFlhJDgK4lBqvgd7Xn6Hb06VBNiQ6s854LjlBGmlWm
         7QEhhPkhEM7y2MG/cFTgB1yuf755/lhrhvKjGNqfpy8ox9HD1X8V/yVGpyGfCtstaeNl
         okiML4OxU/6H6iErWjiv/0spF7quSZ89GO9lD6E6Y/4UdFwmzgdCDGeJdxo1/r8GSFxI
         U5lQ==
X-Gm-Message-State: APjAAAWm27yRiChB5nlUKzJ/gm7AiF9mXoKoKMeWcw9JAMI0S+JX6mpD
        uKV8seSG1751Qat44m+oDDM6sS1QNsHXCWEbRQ==
X-Google-Smtp-Source: APXvYqw8LV6WBXXCSed18FikGz+Bsc7kDpDCooXPCBOam9zJuGc0Z3FaOdxPALOOIR5UbsS0/3YFWdKWcCh9vADW1s4=
X-Received: by 2002:a19:2c1:: with SMTP id 184mr27057695lfc.100.1568280289888;
 Thu, 12 Sep 2019 02:24:49 -0700 (PDT)
MIME-Version: 1.0
References: <CAEJqkggcnW98Sk3BEBCCZf57Uwd9rdqD5Da0tmuTaNfkJN5kVg@mail.gmail.com>
 <CACVXFVNiRX+K8toexRfykazVnpC1sNYj2UbUtnqNeqkqUfs8TA@mail.gmail.com>
In-Reply-To: <CACVXFVNiRX+K8toexRfykazVnpC1sNYj2UbUtnqNeqkqUfs8TA@mail.gmail.com>
From:   Gabriel C <nix.or.die@gmail.com>
Date:   Thu, 12 Sep 2019 11:24:23 +0200
Message-ID: <CAEJqkgii81G8_=ddVb92TFAcsr5LCEOi08aBfQ2RAu2UPAYpwg@mail.gmail.com>
Subject: Re: nvme vs. hibernation ( again )
To:     Ming Lei <tom.leiming@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        linux-nvme <linux-nvme@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Do., 12. Sept. 2019 um 02:51 Uhr schrieb Ming Lei <tom.leiming@gmail.com>:
>
> On Thu, Sep 12, 2019 at 12:27 AM Gabriel C <nix.or.die@gmail.com> wrote:
> >
> > Hi Christoph,
> >
> > I see this was already discussed in 2 threads:
> >
> >  https://lists.infradead.org/pipermail/linux-nvme/2019-April/023234.html
> >  https://lkml.org/lkml/2019/5/24/668
> >
> > but in latest git the issue still exists.
> >
> > I hit that on each resume on my Acer Nitro 5 (AN515-43-R8BF) Laptop.
> >
> > .....
> > Sep 11 16:16:30 nitro5 kernel: Freezing remaining freezable tasks ...
> > (elapsed 0.000 seconds) done.
> > Sep 11 16:16:30 nitro5 kernel: printk: Suspending console(s) (use
> > no_console_suspend to debug)
> > Sep 11 16:16:30 nitro5 kernel: WARNING: CPU: 0 PID: 882 at
> > kernel/irq/chip.c:210 irq_startup+0xe6/0xf0
> > Sep 11 16:16:30 nitro5 kernel: Modules linked in: af_packet bnep
> > amdgpu ath10k_pci ath10k_core ath mac80211 joydev uvcvideo
> > videobuf2_vmalloc videobuf2_memops edac_mce_amd videobuf2_v4l2
> > amd_iommu_v2 kvm_amd gpu_sched btusb snd_hda_codec_realtek ttm btrtl
> > btbcm btintel hid_multitouch ccp snd_hda_codec_generic nls_utf8
> > bluetooth drm_kms_helper hid_generic videobuf2_common ledtrig_audio
> > snd_hda_codec_hdmi nls_cp437 cfg80211 drm kvm snd_hda_intel vfat
> > videodev fat agpgart efi_pstore r8169 snd_hda_codec ecdh_generic
> > i2c_algo_bit realtek irqbypass pcspkr mc rfkill fb_sys_fops efivars
> > syscopyarea snd_hda_core ecc k10temp wmi_bmof sysfillrect tpm_crb
> > crc16 libphy i2c_piix4 libarc4 snd_hwdep hwmon sysimgblt tpm_tis
> > tpm_tis_core evdev ac tpm battery mac_hid i2c_designware_platform
> > pinctrl_amd i2c_designware_core rng_core acer_wireless button
> > acpi_cpufreq ppdev sch_fq_codel fuse snd_pcm_oss snd_mixer_oss snd_pcm
> > snd_seq_dummy snd_seq_oss snd_seq_midi_event snd_seq snd_seq_device
> > snd_timer snd soundcore lp parport_pc
> > Sep 11 16:16:30 nitro5 kernel:  parport xfs libcrc32c crc32c_generic
> > crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel ahci
> > libahci libata xhci_pci xhci_hcd aesni_intel usbcore scsi_mod
> > aes_x86_64 crypto_simd cryptd glue_helper serio_raw i2c_hid hid video
> > i2c_core wmi dm_mirror dm_region_hash dm_log dm_mod unix sha1_ssse3
> > sha1_generic hmac ipv6 nf_defrag_ipv6 autofs4
> > Sep 11 16:16:30 nitro5 kernel: CPU: 0 PID: 882 Comm: kworker/u32:9 Not
> > tainted 5.3.0-rc8-00007-g3120b9a6a3f7-dirty #2
> > Sep 11 16:16:30 nitro5 kernel: Hardware name: Acer Nitro
> > AN515-43/Octavia_PKS, BIOS V1.05 08/07/2019
> > Sep 11 16:16:30 nitro5 kernel: Workqueue: events_unbound async_run_entry_fn
> > Sep 11 16:16:30 nitro5 kernel: RIP: 0010:irq_startup+0xe6/0xf0
> > Sep 11 16:16:30 nitro5 kernel: Code: e8 7f 3c 00 00 85 c0 0f 85 e3 09
> > 00 00 4c 89 e7 31 d2 4c 89 ee e8 1a cf ff ff 48 89 ef e8 b2 fe ff ff
> > 41 89 c4 e9 51 ff ff ff <0f> 0b eb b2 66 0f 1f 44 00 00 0f 1f 44 00 00
> > 55 48 89 fd 53 48 8b
> > Sep 11 16:16:30 nitro5 kernel: RSP: 0018:ffffbe9b00793c38 EFLAGS: 00010002
> > Sep 11 16:16:30 nitro5 kernel: RAX: 0000000000000010 RBX:
> > 0000000000000001 RCX: 0000000000000040
> > Sep 11 16:16:30 nitro5 kernel: RDX: 0000000000000000 RSI:
> > ffffffff9d1b8800 RDI: ffff9c9d9e136598
> > Sep 11 16:16:30 nitro5 kernel: RBP: ffff9c9d981e5400 R08:
> > 0000000000000000 R09: ffff9c9d9e8003f0
> > Sep 11 16:16:30 nitro5 kernel: R10: 0000000000000000 R11:
> > ffffffff9d057688 R12: 0000000000000001
> > Sep 11 16:16:30 nitro5 kernel: R13: ffff9c9d9e136598 R14:
> > 0000000000000000 R15: ffff9c9d9e346000
> > Sep 11 16:16:30 nitro5 kernel: FS:  0000000000000000(0000)
> > GS:ffff9c9da0800000(0000) knlGS:0000000000000000
> > Sep 11 16:16:30 nitro5 kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > Sep 11 16:16:30 nitro5 kernel: CR2: 00005633ad8d0060 CR3:
> > 00000003db8d0000 CR4: 00000000003406f0
> > Sep 11 16:16:30 nitro5 kernel: Call Trace:
> > Sep 11 16:16:30 nitro5 kernel:  enable_irq+0x48/0x90
> > Sep 11 16:16:30 nitro5 kernel:  nvme_poll_irqdisable+0x20c/0x280
> > Sep 11 16:16:30 nitro5 kernel:  __nvme_disable_io_queues+0x19d/0x1d0
> > Sep 11 16:16:30 nitro5 kernel:  ? nvme_del_queue_end+0x20/0x20
> > Sep 11 16:16:30 nitro5 kernel:  nvme_dev_disable+0x15c/0x210
> > Sep 11 16:16:30 nitro5 kernel:  nvme_suspend+0x40/0x130
> > Sep 11 16:16:30 nitro5 kernel:  pci_pm_suspend+0x72/0x130
> > Sep 11 16:16:30 nitro5 kernel:  ? pci_pm_freeze+0xb0/0xb0
> > Sep 11 16:16:30 nitro5 kernel:  dpm_run_callback+0x29/0x120
> > Sep 11 16:16:30 nitro5 kernel:  __device_suspend+0x1b2/0x400
> > Sep 11 16:16:30 nitro5 kernel:  async_suspend+0x1b/0x90
> > Sep 11 16:16:30 nitro5 kernel:  async_run_entry_fn+0x37/0xe0
> > Sep 11 16:16:30 nitro5 kernel:  process_one_work+0x1d1/0x3a0
> > Sep 11 16:16:30 nitro5 kernel:  worker_thread+0x4a/0x3d0
> > Sep 11 16:16:30 nitro5 kernel:  kthread+0xf9/0x130
> > Sep 11 16:16:30 nitro5 kernel:  ? process_one_work+0x3a0/0x3a0
> > Sep 11 16:16:30 nitro5 kernel:  ? kthread_park+0x80/0x80
> > Sep 11 16:16:30 nitro5 kernel:  ret_from_fork+0x22/0x40
> > Sep 11 16:16:30 nitro5 kernel: ---[ end trace c598a86b44574730 ]---
> >
> > ...
> >
> > The patch from Dongli Zhang was rejected the time without any other fix
> > or work on this issue I could find.
> >
> > Are there any plans to fix that or any code to test?
>
> I guess the following patchset may address it:
>
> https://lore.kernel.org/linux-block/20190812134312.16732-1-ming.lei@redhat.com/
>

Thx Ming Lei.

Can you tell me on what branch/tree they are based on?

Best Regards,

Gabriel C
