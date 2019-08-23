Return-Path: <SRS0=31nU=WT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB94C41514
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 22:00:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B8AB206E0
	for <linux-kernel@archiver.kernel.org>; Fri, 23 Aug 2019 22:00:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YqQ08/6I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406238AbfHWWA2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 23 Aug 2019 18:00:28 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:36356 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390764AbfHWWA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Aug 2019 18:00:27 -0400
Received: by mail-vs1-f67.google.com with SMTP id y16so7230984vsc.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2019 15:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=VhaIC65mSyrN1pwrufGVcQhuSkf6rtyzwQMcKbA+Oj4=;
        b=YqQ08/6IgqW9Coi1le9ZFMzfFJ11C0fs0Dk2iRCtfNh1EITJ0R60X5q9wgJB+VeK57
         8mPQr8Bdke33DvmlYpQBju3Qppef6cy1XHpDdMrZLeVM/hiBmKJyupzRTHqhs5izYfCH
         Dtxjk1QHqDFrmWB8PioNgMAyl81fO5Rqi1bGCmF2A7odF7mf6k4P40j9eIqhDZl9DSk3
         ktYuD7SOB+meRNgtYw/X4PvEuqSQy5+1g4KsGV/lmm7g+AtZKaqv0Wdfr5aa/4amIqwA
         1QRP09wiNG2V6gA4p0/CyTiyRcCkh8X1Y9edDidmLIMsqTfJ9Hh4/zrr66KLTnlBv4jJ
         28Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=VhaIC65mSyrN1pwrufGVcQhuSkf6rtyzwQMcKbA+Oj4=;
        b=EVkhYZp1TGBSEN0RmenQ6nLd4XW3loIerhDMO58iPj+MFgBgrbCwdpB5y1gG3jsPfz
         IIwSWEq4PJJuAUBopqvN6JolapaBEW6b0PIvc6nOSjUMK/bMT1Jz8cZJoR4OHe4YgRgW
         Dy5VWdngf+QAfGNPKaZshRB8DXsCQbZiVCqaurwu91oA7Ni4rkt/fDzAz43lnLehSSmU
         vcpyHeCBOm55inFG9dm7Apvezrqm+0qFpa3Vnw1v8JgyNVjW7QYpAJ6ZXO12ghPkP+y3
         2tts4YiKVyMLd7KxmlGVx3dldIpJGZ5wRdCA5TCzB0vExif0RCrQtSKOyopk+gjxZtpW
         JghQ==
X-Gm-Message-State: APjAAAVguSGOxiYb2hGbXuW3DdIkBZXF9deV/l+F5dBBYY14zzeZNHm6
        rUQ0KgP1A5akt49auPYkZYym2DlfInmReW4EzIvIjmtL
X-Google-Smtp-Source: APXvYqy8l/r/yF43nwH1CWMLmo54Oskwow9hNomasBfFex9m0LxNWDAVYWaXAaxU31/EfoeIdT8LEMgWUA9i8J6jUlY=
X-Received: by 2002:a05:6102:10da:: with SMTP id t26mr4388122vsr.101.1566597626305;
 Fri, 23 Aug 2019 15:00:26 -0700 (PDT)
MIME-Version: 1.0
From:   Adric Blake <promarbler14@gmail.com>
Date:   Fri, 23 Aug 2019 18:00:15 -0400
Message-ID: <CAE1jjeePxYPvw1mw2B3v803xHVR_BNnz0hQUY_JDMN8ny29M6w@mail.gmail.com>
Subject: WARNINGs in set_task_reclaim_state with memory cgroup and full memory usage
To:     akpm@linux-foundation.org
Cc:     ktkhai@virtuozzo.com, hannes@cmpxchg.org, mhocko@suse.com,
        daniel.m.jordan@oracle.com, laoar.shao@gmail.com,
        yang.shi@linux.alibaba.com, mgorman@techsingularity.net,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Synopsis:
A WARN_ON_ONCE is hit twice in set_task_reclaim_state under the
following conditions:
- a memory cgroup has been created and a task assigned it it
- memory.limit_in_bytes has been set
- memory has filled up, likely from cache

In my usage, I create a cgroup under the current session scope and
assign a task to it. I then set memory.limit_in_bytes and
memory.soft_limit_in_bytes for the cgroup to reasonable values, say
1G/512M. The program accesses large files frequently and gradually
fills memory with the page cache. The warnings appears when the
entirety of the system memory is filled, presumably from other
programs.

If I wait until the program has filled the entirety of system memory
with cache and then assign a memory limit, the warnings appear
immediately.

I am building the linux git. I first noticed this issue with the
drm-tip 5.3rc3 and 5.3rc4 kernels, and tested linux master after
5.3rc5 to confirm the bug more resoundingly.

Here are the warnings.

[38491.963105] WARNING: CPU: 7 PID: 175 at mm/vmscan.c:245
set_task_reclaim_state+0x1e/0x40
[38491.963106] Modules linked in: iwlmvm mac80211 libarc4 iwlwifi
cfg80211 xt_comment nls_iso8859_1 nls_cp437 vfat fat xfs jfs btrfs xor
raid6_pq libcrc32c ccm tun rfcomm fuse xt_tcpudp ip6t_REJECT
nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_multiport xt_owner
snd_hda_codec_hdmi ip6table_filter ip6_tables iptable_filter bnep ext4
crc32c_generic mbcache jbd2 snd_hda_codec_realtek
snd_hda_codec_generic snd_soc_skl snd_soc_hdac_hda snd_hda_ext_core
snd_soc_skl_ipc x86_pkg_temp_thermal intel_powerclamp snd_soc_sst_ipc
coretemp snd_soc_sst_dsp snd_soc_acpi_intel_match kvm_intel
snd_soc_acpi i915 snd_soc_core kvm snd_compress ac97_bus
snd_pcm_dmaengine snd_hda_intel i2c_algo_bit btusb irqbypass
drm_kms_helper btrtl snd_hda_codec dell_laptop btbcm crct10dif_pclmul
snd_hda_core crc32c_intel btintel iTCO_wdt ghash_clmulni_intel drm
ledtrig_audio aesni_intel iTCO_vendor_support snd_hwdep dell_wmi
rtsx_usb_ms r8169 dell_smbios aes_x86_64 mei_hdcp crypto_simd
intel_gtt bluetooth snd_pcm cryptd dcdbas
[38491.963155]  wmi_bmof dell_wmi_descriptor intel_rapl_msr
glue_helper snd_timer joydev intel_cstate snd realtek memstick
dell_smm_hwmon mousedev psmouse input_leds libphy intel_uncore
ecdh_generic ecc crc16 rfkill intel_rapl_perf soundcore i2c_i801
agpgart mei_me tpm_crb syscopyarea sysfillrect sysimgblt mei
intel_xhci_usb_role_switch fb_sys_fops idma64 tpm_tis roles
processor_thermal_device intel_rapl_common i2c_hid tpm_tis_core
int3403_thermal intel_soc_dts_iosf battery wmi intel_lpss_pci
intel_lpss intel_pch_thermal tpm int3400_thermal int3402_thermal
acpi_thermal_rel int340x_thermal_zone rng_core intel_hid ac
sparse_keymap evdev mac_hid crypto_user ip_tables x_tables
hid_multitouch rtsx_usb_sdmmc mmc_core rtsx_usb hid_logitech_hidpp
sr_mod cdrom sd_mod uas usb_storage hid_logitech_dj hid_generic usbhid
hid ahci serio_raw libahci atkbd libps2 libata xhci_pci scsi_mod
xhci_hcd crc32_pclmul i8042 serio f2fs [last unloaded: cfg80211]
[38491.963221] CPU: 7 PID: 175 Comm: kswapd0 Not tainted
5.3.0-rc5+149+gbb7ba8069de9 #1
[38491.963222] Hardware name: Dell Inc. Inspiron 5570/09YTN7, BIOS
1.2.3 05/15/2019
[38491.963226] RIP: 0010:set_task_reclaim_state+0x1e/0x40
[38491.963228] Code: 78 a9 e7 ff 0f 1f 84 00 00 00 00 00 0f 1f 44 00
00 55 48 89 f5 53 48 89 fb 48 85 ed 48 8b 83 08 08 00 00 74 11 48 85
c0 74 02 <0f> 0b 48 89 ab 08 08 00 00 5b 5d c3 48 85 c0 75 f1 0f 0b 48
89 ab
[38491.963229] RSP: 0018:ffff8c898031fc60 EFLAGS: 00010286
[38491.963230] RAX: ffff8c898031fe28 RBX: ffff892aa04ddc40 RCX: 0000000000000000
[38491.963231] RDX: ffff8c898031fc60 RSI: ffff8c898031fcd0 RDI: ffff892aa04ddc40
[38491.963233] RBP: ffff8c898031fcd0 R08: ffff8c898031fd48 R09: ffff89279674b800
[38491.963234] R10: 00000000ffffffff R11: 0000000000000000 R12: ffff8c898031fd48
[38491.963235] R13: ffff892a842ef000 R14: ffff892aaf7fc000 R15: 0000000000000000
[38491.963236] FS:  0000000000000000(0000) GS:ffff892aa33c0000(0000)
knlGS:0000000000000000
[38491.963238] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[38491.963239] CR2: 00007f90628fa000 CR3: 000000027ee0a002 CR4: 00000000003606e0
[38491.963239] Call Trace:
[38491.963246]  mem_cgroup_shrink_node+0x9b/0x1d0
[38491.963250]  mem_cgroup_soft_limit_reclaim+0x10c/0x3a0
[38491.963254]  balance_pgdat+0x276/0x540
[38491.963258]  kswapd+0x200/0x3f0
[38491.963261]  ? wait_woken+0x80/0x80
[38491.963265]  kthread+0xfd/0x130
[38491.963267]  ? balance_pgdat+0x540/0x540
[38491.963269]  ? kthread_park+0x80/0x80
[38491.963273]  ret_from_fork+0x35/0x40
[38491.963276] ---[ end trace 727343df67b2398a ]---
[38492.129877] WARNING: CPU: 7 PID: 175 at mm/vmscan.c:248
set_task_reclaim_state+0x2f/0x40
[38492.129879] Modules linked in: iwlmvm mac80211 libarc4 iwlwifi
cfg80211 xt_comment nls_iso8859_1 nls_cp437 vfat fat xfs jfs btrfs xor
raid6_pq libcrc32c ccm tun rfcomm fuse xt_tcpudp ip6t_REJECT
nf_reject_ipv6 ipt_REJECT nf_reject_ipv4 xt_multiport xt_owner
snd_hda_codec_hdmi ip6table_filter ip6_tables iptable_filter bnep ext4
crc32c_generic mbcache jbd2 snd_hda_codec_realtek
snd_hda_codec_generic snd_soc_skl snd_soc_hdac_hda snd_hda_ext_core
snd_soc_skl_ipc x86_pkg_temp_thermal intel_powerclamp snd_soc_sst_ipc
coretemp snd_soc_sst_dsp snd_soc_acpi_intel_match kvm_intel
snd_soc_acpi i915 snd_soc_core kvm snd_compress ac97_bus
snd_pcm_dmaengine snd_hda_intel i2c_algo_bit btusb irqbypass
drm_kms_helper btrtl snd_hda_codec dell_laptop btbcm crct10dif_pclmul
snd_hda_core crc32c_intel btintel iTCO_wdt ghash_clmulni_intel drm
ledtrig_audio aesni_intel iTCO_vendor_support snd_hwdep dell_wmi
rtsx_usb_ms r8169 dell_smbios aes_x86_64 mei_hdcp crypto_simd
intel_gtt bluetooth snd_pcm cryptd dcdbas
[38492.129919]  wmi_bmof dell_wmi_descriptor intel_rapl_msr
glue_helper snd_timer joydev intel_cstate snd realtek memstick
dell_smm_hwmon mousedev psmouse input_leds libphy intel_uncore
ecdh_generic ecc crc16 rfkill intel_rapl_perf soundcore i2c_i801
agpgart mei_me tpm_crb syscopyarea sysfillrect sysimgblt mei
intel_xhci_usb_role_switch fb_sys_fops idma64 tpm_tis roles
processor_thermal_device intel_rapl_common i2c_hid tpm_tis_core
int3403_thermal intel_soc_dts_iosf battery wmi intel_lpss_pci
intel_lpss intel_pch_thermal tpm int3400_thermal int3402_thermal
acpi_thermal_rel int340x_thermal_zone rng_core intel_hid ac
sparse_keymap evdev mac_hid crypto_user ip_tables x_tables
hid_multitouch rtsx_usb_sdmmc mmc_core rtsx_usb hid_logitech_hidpp
sr_mod cdrom sd_mod uas usb_storage hid_logitech_dj hid_generic usbhid
hid ahci serio_raw libahci atkbd libps2 libata xhci_pci scsi_mod
xhci_hcd crc32_pclmul i8042 serio f2fs [last unloaded: cfg80211]
[38492.129961] CPU: 7 PID: 175 Comm: kswapd0 Tainted: G        W
  5.3.0-rc5+149+gbb7ba8069de9 #1
[38492.129962] Hardware name: Dell Inc. Inspiron 5570/09YTN7, BIOS
1.2.3 05/15/2019
[38492.129965] RIP: 0010:set_task_reclaim_state+0x2f/0x40
[38492.129968] Code: 55 48 89 f5 53 48 89 fb 48 85 ed 48 8b 83 08 08
00 00 74 11 48 85 c0 74 02 0f 0b 48 89 ab 08 08 00 00 5b 5d c3 48 85
c0 75 f1 <0f> 0b 48 89 ab 08 08 00 00 5b 5d c3 0f 1f 44 00 00 55 48 89
fd 53
[38492.129969] RSP: 0018:ffff8c898031fd88 EFLAGS: 00010246
[38492.129971] RAX: 0000000000000000 RBX: ffff892aa04ddc40 RCX: 0000000000000000
[38492.129972] RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff892aa04ddc40
[38492.129973] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
[38492.129974] R10: ffff892aa33d7544 R11: 0000000000000000 R12: ffff8c898031fe40
[38492.129974] R13: 0000000000000200 R14: ffff8c898031fe40 R15: 0000000000000001
[38492.129976] FS:  0000000000000000(0000) GS:ffff892aa33c0000(0000)
knlGS:0000000000000000
[38492.129977] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[38492.129978] CR2: 00007fc3a2787010 CR3: 000000035c794001 CR4: 00000000003606e0
[38492.129979] Call Trace:
[38492.129985]  balance_pgdat+0x4e6/0x540
[38492.129991]  kswapd+0x200/0x3f0
[38492.129994]  ? wait_woken+0x80/0x80
[38492.129997]  kthread+0xfd/0x130
[38492.130000]  ? balance_pgdat+0x540/0x540
[38492.130001]  ? kthread_park+0x80/0x80
[38492.130005]  ret_from_fork+0x35/0x40
[38492.130008] ---[ end trace 727343df67b2398b ]---

Thanks for reading. Please be gentle.
