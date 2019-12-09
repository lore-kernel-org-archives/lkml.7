Return-Path: <SRS0=ag/Q=Z7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E047C43603
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 02:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D572C206F4
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Dec 2019 02:50:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B9zS2We3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726983AbfLICuI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Dec 2019 21:50:08 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:35194 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726748AbfLICuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Dec 2019 21:50:08 -0500
Received: by mail-io1-f65.google.com with SMTP id v18so13186773iol.2
        for <linux-kernel@vger.kernel.org>; Sun, 08 Dec 2019 18:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=rYe5nnlUsFYYX6GaWz776k3HrnehVS8S8OkniF4A7aQ=;
        b=B9zS2We3y0kan4OvmKhVdBd6qvGdmr8xglaB4ncnishBCGGSIFtFoGEDKRh2Q9h8BM
         cj1OCEVBCJ1cRX6CcWbP+W3030/M0CW0p2NkGQUuxyS/XqxG35rdc7w+LH6YwGfOLep7
         cJ0RmBtufo4TmXVT5IGKAuKknfWseSC3dai9f2PaQGNjBRraRsDxf2Aqm3mwEKaPldiw
         6G6a42TdYT0wdjyEOwbpLRcLpQ2aO8ue0z+Trs+TzIhkLsIZEwxLBzSljFOM4cHeO6ls
         9HxhYqtZ0VBEJzUa5QFehG+lcy+lkqjpTG1uwdL1Db3YSX2Ma5kLiaUKo+IwlHNCGS6p
         9X4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=rYe5nnlUsFYYX6GaWz776k3HrnehVS8S8OkniF4A7aQ=;
        b=it1p9FfcgegwqdQc06PFgrlKbU47O3sKSTaC1g/ULUv+Auq8/5u3LCOcpJPVKe07g1
         4StbN8sPJBkW8ngIlBPZUL+5s72FQDnkN/+4gYt/SsZ4lItByDFAVs93nJ41rV3HehKo
         Ygg7Tq9D7kly/fXbVyqkps/8+lOHG8xxc9pdPAmV1uq7W5iEghcoRYGg+ZEf/vHxiu0C
         hhkQmBPT1i9obS10mRmC8QLTeothjH3KKlaMVceD1JPOyf9qdJq7mbZAoNACcLf+dteG
         OyIDbLS5BCM7spqxVu51aK3pjVnK6X4B2rucMTfBT3+q/fNW4LtU7cEvrwtIklXShnQp
         V9MA==
X-Gm-Message-State: APjAAAX+a0B84oOcLymGQ2VMbl1pBIipqMoyawhXGwkfHtE9exY2cHZI
        cFfbwYTatYhGtj4EbtBRTn+sAmnxhRzexp/DjY+jZnZL
X-Google-Smtp-Source: APXvYqx7xn3bUhH0hypLcGU66XSeHFgZMM6PyCQr4D2Jj39bH5gZzCwuzQ/BuWPAmQDZ7vETK4aDa3SeveOaEPaFwRo=
X-Received: by 2002:a02:7102:: with SMTP id n2mr25284951jac.76.1575859807026;
 Sun, 08 Dec 2019 18:50:07 -0800 (PST)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Sun, 8 Dec 2019 20:49:56 -0600
Message-ID: <CAH2r5mvZ=S0FHGP+Y_r5f37TXVehv2shj9f6w67zBxfjR+Zt-Q@mail.gmail.com>
Subject: 5.5-rc1 oops on boot in 802.11 kernel driver
To:     LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Noticed this crash in the Linux kernel Wifi driver on boot a few
minutes ago immediately after updating to latest mainline kernel about
an hour ago. I didn't see it last week and certainly not in 5.4.

[   36.904191] ------------[ cut here ]------------
[   36.904192] STA e0:3f:49:98:14:80 AC 2 txq pending airtime
underflow: 4294967132, 260
[   36.904231] WARNING: CPU: 11 PID: 680 at
net/mac80211/sta_info.c:1931
ieee80211_sta_update_pending_airtime+0x115/0x120 [mac80211]
[   36.904232] Modules linked in: uinput ccm xt_CHECKSUM xt_MASQUERADE
nf_nat_tftp nf_conntrack_tftp tun bridge stp llc
nf_conntrack_netbios_ns nf_conntrack_broadcast xt_CT ip6t_REJECT
nf_reject_ipv6 ip6t_rpfilter ipt_REJECT nf_reject_ipv4 xt_conntrack
ebtable_nat ebtable_broute ip6table_nat ip6table_mangle ip6table_raw
ip6table_security iptable_nat nf_nat iptable_mangle iptable_raw
iptable_security nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 ip_set
nfnetlink ebtable_filter ebtables ip6table_filter ip6_tables
iptable_filter bnep sunrpc xfs vfat fat libcrc32c typec_displayport
elan_i2c x86_pkg_temp_thermal intel_powerclamp coretemp kvm_intel
snd_soc_skl kvm snd_hda_codec_hdmi snd_soc_hdac_hda snd_hda_ext_core
snd_soc_sst_ipc irqbypass snd_soc_sst_dsp snd_soc_acpi_intel_match
snd_soc_acpi snd_soc_core crct10dif_pclmul snd_hda_codec_realtek
iTCO_wdt crc32_pclmul iwlmvm snd_hda_codec_generic snd_compress
iTCO_vendor_support ac97_bus snd_pcm_dmaengine mei_hdcp mei_wdt
ghash_clmulni_intel
[   36.904245]  intel_rapl_msr snd_hda_intel snd_intel_dspcfg mac80211
snd_hda_codec intel_cstate snd_hda_core intel_uncore uvcvideo libarc4
btusb intel_rapl_perf snd_hwdep videobuf2_vmalloc btrtl snd_seq
videobuf2_memops btbcm videobuf2_v4l2 btintel videobuf2_common pcspkr
snd_seq_device wmi_bmof intel_wmi_thunderbolt bluetooth i2c_i801
iwlwifi videodev snd_pcm thinkpad_acpi thunderbolt mei_me
intel_lpss_pci cfg80211 ecdh_generic intel_lpss ledtrig_audio joydev
mei snd_timer mc ecc idma64 snd ucsi_acpi processor_thermal_device
typec_ucsi intel_rapl_common int3403_thermal soundcore
intel_pch_thermal intel_soc_dts_iosf typec rfkill int340x_thermal_zone
int3400_thermal acpi_pad acpi_thermal_rel ip_tables wacom nouveau
mxm_wmi i2c_algo_bit rtsx_pci_sdmmc mmc_core drm_kms_helper ttm nvme
drm e1000e crc32c_intel nvme_core serio_raw rtsx_pci wmi
pinctrl_cannonlake video pinctrl_intel fuse
[   36.904263] CPU: 11 PID: 680 Comm: irq/162-iwlwifi Not tainted
5.5.0-0.rc0.git7.1.vanilla.knurd.1.fc31.x86_64 #1
[   36.904263] Hardware name: LENOVO 20MAS08500/20MAS08500, BIOS
N2CET48W (1.31 ) 11/04/2019
[   36.904271] RIP:
0010:ieee80211_sta_update_pending_airtime+0x115/0x120 [mac80211]
[   36.904272] Code: 3f e3 0f 0b 8b 44 24 04 eb 9d 48 83 c6 40 41 89
e8 89 c1 48 c7 c7 20 dd d5 c0 89 44 24 04 c6 05 35 99 0b 00 01 e8 bd
cc 3f e3 <0f> 0b 8b 44 24 04 eb 8c 0f 1f 00 0f 1f 44 00 00 55 89 f5 53
48 89
[   36.904273] RSP: 0018:ffffa4e3809c7ba8 EFLAGS: 00010286
[   36.904273] RAX: 0000000000000000 RBX: 00000000fffffefc RCX: 0000000000000000
[   36.904274] RDX: 0000000000000049 RSI: ffffffffa6150489 RDI: 0000000000000246
[   36.904274] RBP: 0000000000000104 R08: 0000000897a94ba5 R09: 0000000000000049
[   36.904275] R10: 0000000000000002 R11: 00000000a6150443 R12: ffff8a0774e607c0
[   36.904275] R13: 0000000000000002 R14: ffff8a07778025c8 R15: ffff8a07044f3000
[   36.904276] FS:  0000000000000000(0000) GS:ffff8a077bcc0000(0000)
knlGS:0000000000000000
[   36.904276] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   36.904277] CR2: 00003446319a8000 CR3: 000000042c60a004 CR4: 00000000003606e0
[   36.904277] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[   36.904277] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[   36.904278] Call Trace:
[   36.904286]  __ieee80211_tx_status+0x720/0x900 [mac80211]
[   36.904293]  ieee80211_tx_status+0x6a/0x90 [mac80211]
[   36.904299]  iwl_mvm_tx_reclaim+0x2a2/0x3c0 [iwlmvm]
[   36.904304]  iwl_mvm_rx_ba_notif+0xff/0x2e0 [iwlmvm]
[   36.904307]  ? __switch_to_asm+0x40/0x70
[   36.904311]  iwl_mvm_rx_common+0xdd/0x2c0 [iwlmvm]
[   36.904317]  iwl_pcie_rx_handle+0x3af/0x9c0 [iwlwifi]
[   36.904319]  ? irq_finalize_oneshot.part.0+0xf0/0xf0
[   36.904322]  iwl_pcie_irq_rx_msix_handler+0x45/0x80 [iwlwifi]
[   36.904323]  irq_thread_fn+0x20/0x60
[   36.904325]  irq_thread+0xdc/0x170
[   36.904326]  ? irq_forced_thread_fn+0x80/0x80
[   36.904327]  kthread+0xf9/0x130
[   36.904328]  ? irq_thread_check_affinity+0xf0/0xf0
[   36.904329]  ? kthread_park+0x90/0x90
[   36.904330]  ret_from_fork+0x35/0x40
[   36.904332] ---[ end trace ce4946b8661ca7fd ]---
[   36.904332] ------------[ cut here ]------------


-- 
Thanks,

Steve
