Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7D92C3A5A4
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 15:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A99EC22CED
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 15:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="PRSEgBAK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfH1POc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 11:14:32 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33374 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbfH1PO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 11:14:29 -0400
Received: by mail-wr1-f65.google.com with SMTP id u16so228695wrr.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 08:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:subject:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=CxGTUahJN2mM1Rm5O90rTtaK5X6lZOBkH0dKQJB6nxs=;
        b=PRSEgBAKriPA7rmeceu8jCXy7cRD461/bPXl7TRzdUaXhioFwYMiFFqpJi1HSYwL4m
         5e+TP39ZwFsZQ+shNPOrv6ecFGIxGWcnUBmYn/ScM1M2H1Zuqw7l0aCz5+LIzrq7iQvR
         9grqNfdSP4Yl4aC0+Dy0f4sgRit27QrsujZYTId/G3hGbJzQVj6x7bRVYraAFhaNRqzC
         CkZFCsMDwki3392DCEKHIWOxYrQhO0+GyV+ObXaSGxbFUtecB78jQJ8pguu1GiWATFcR
         3tax3c5AdKrrVCKThQBGH+tZrzax7XSpNzn4ljHzcnTi1uxRp9PMMcVKYLlhoEH1wXHz
         9Ubg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=CxGTUahJN2mM1Rm5O90rTtaK5X6lZOBkH0dKQJB6nxs=;
        b=hSGdfV7hvao+uJ8KaJeeuDdb1l1q/DNxXt3SL7a5I3snnDNrA3iqtwukVh4XfU+Qs5
         4y3m+jNKzq/+lUjbo91Mk8ZOYKs6FVYuZv9KsiYe4/QAVnaKbiFdivaA8mOMB2QEW+/+
         xiekVJjRfePsPqKfSQUB+v+F/u1UZJyVFX+4G4fE63FuX9yAMRmnSQwPCb9NrhEIvHoF
         I2nGXyCx5e8oG8jqG5P3vU/CLqMzDgA1FkP8Tlkc9JBkGfL01nbneB1q+mYF62hH0ZK+
         qEQGUxEeRc4GVm6k3puJ0Le7k37eSUSqRJfMw+nmB0YIj6YdC8BqZp3J91O6eP4LTCAI
         khHw==
X-Gm-Message-State: APjAAAUpAFRS5/DqYoLwHnRu7kdOy5rkiwkkHrg7uW4dqynOqkzhXBWB
        XQQFdzbI2Ch+XCQuBlNovFE0ewAU
X-Google-Smtp-Source: APXvYqyjiVfUOziWjPbBVlvEWT3EI60KGz1U0uEbx1tdZn8IKK1Vga5HJ3djcIQkDAWqC3a7pM5PwA==
X-Received: by 2002:a05:6000:12c9:: with SMTP id l9mr4517773wrx.163.1567005265956;
        Wed, 28 Aug 2019 08:14:25 -0700 (PDT)
Received: from [192.168.1.20] (host109-153-59-46.range109-153.btcentralplus.com. [109.153.59.46])
        by smtp.googlemail.com with ESMTPSA id t8sm6915144wra.73.2019.08.28.08.14.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Aug 2019 08:14:25 -0700 (PDT)
From:   Chris Clayton <chris2553@googlemail.com>
X-Google-Original-From: Chris Clayton <chris2553@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Subject: Workqueue - warning splat
Cc:     tj@kernel.org, intel-gfx@lists.freedesktop.org
Message-ID: <c2706468-6f88-7276-b791-e9573394aa18@gmail.com>
Date:   Wed, 28 Aug 2019 16:14:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've just copying 319G of data from a partition on one USB-attached (/dev/sdb3) to a partition on another USB-attached
drive (/dev/sdc1). It's not quite finished but as it's progressed, I have been reading email and browsing web sites, so
switching between windows from time to time.

I found the splat below at the end the output from dmesg:

[ 1578.086588] usb 2-5: new SuperSpeed Gen 1 USB device number 3 using xhci_hcd
[ 1578.107688] usb 2-5: New USB device found, idVendor=0080, idProduct=a001, bcdDevice= 2.04
[ 1578.107691] usb 2-5: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[ 1578.107691] usb 2-5: Product: External USB 3.0
[ 1578.107692] usb 2-5: Manufacturer: TOSHIBA
[ 1578.107693] usb 2-5: SerialNumber: 201503310007F
[ 1578.111610] scsi host5: uas
[ 1578.111951] scsi 5:0:0:0: Direct-Access     TO Exter nal USB 3.0      0204 PQ: 0 ANSI: 6
[ 1578.112422] sd 5:0:0:0: Attached scsi generic sg1 type 0
[ 1578.113132] sd 5:0:0:0: [sdb] 3907029168 512-byte logical blocks: (2.00 TB/1.82 TiB)
[ 1578.113133] sd 5:0:0:0: [sdb] 4096-byte physical blocks
[ 1578.113280] sd 5:0:0:0: [sdb] Write Protect is off
[ 1578.113281] sd 5:0:0:0: [sdb] Mode Sense: 53 00 00 08
[ 1578.113570] sd 5:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1578.113846] sd 5:0:0:0: [sdb] Optimal transfer size 33553920 bytes not a multiple of physical block size (4096 bytes)
[ 1578.192462]  sdb: sdb1 sdb2 sdb3
[ 1578.195765] sd 5:0:0:0: [sdb] Attached SCSI disk
[ 1579.080448] EXT4-fs (sdb1): mounted filesystem with ordered data mode. Opts: (null)
[ 1579.588368] EXT4-fs (sdb3): mounted filesystem with ordered data mode. Opts: (null)
[ 1639.062480] usb 1-1: new high-speed USB device number 6 using xhci_hcd
[ 1639.314611] usb 1-1: New USB device found, idVendor=152d, idProduct=0578, bcdDevice= 5.08
[ 1639.314613] usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[ 1639.314614] usb 1-1: Product: USB to ATA/ATAPI Bridge
[ 1639.314615] usb 1-1: Manufacturer: JMicron
[ 1639.314615] usb 1-1: SerialNumber: 0123456789ABCDEF
[ 1639.341742] scsi host6: uas
[ 1639.352633] scsi 6:0:0:0: Direct-Access     JMicron  Generic          0508 PQ: 0 ANSI: 6
[ 1639.353140] sd 6:0:0:0: Attached scsi generic sg2 type 0
[ 1642.388518] sd 6:0:0:0: [sdc] 1953525168 512-byte logical blocks: (1.00 TB/932 GiB)
[ 1642.388520] sd 6:0:0:0: [sdc] 4096-byte physical blocks
[ 1642.388801] sd 6:0:0:0: [sdc] Write Protect is off
[ 1642.388802] sd 6:0:0:0: [sdc] Mode Sense: 5f 00 00 08
[ 1642.389117] sd 6:0:0:0: [sdc] Disabling FUA
[ 1642.389118] sd 6:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1642.389342] sd 6:0:0:0: [sdc] Optimal transfer size 33553920 bytes not a multiple of physical block size (4096 bytes)
[ 1642.418255]  sdc: sdc1
[ 1642.421158] sd 6:0:0:0: [sdc] Attached SCSI disk
[ 1643.970443] EXT4-fs (sdc1): mounted filesystem with ordered data mode. Opts: (null)
[ 6048.070133] ------------[ cut here ]------------
[ 6048.070148] workqueue: PF_MEMALLOC task 148(kswapd0) is flushing !WQ_MEM_RECLAIM events:gen6_pm_rps_work [i915]
[ 6048.070152] WARNING: CPU: 6 PID: 148 at kernel/workqueue.c:2598 check_flush_dependency+0x105/0x120
[ 6048.070152] Modules linked in: uas rfcomm bnep iptable_filter xt_conntrack iptable_nat xt_MASQUERADE nf_nat
nf_conntrack nf_defrag_ipv4 coretemp hwmon snd_hda_codec_hdmi snd_hda_codec_generic iwlmvm mac80211 uvcvideo
videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 videobuf2_common snd_hda_intel iwlwifi usbhid snd_hda_codec btusb
btintel snd_hwdep x86_pkg_temp_thermal snd_hda_core cfg80211 i915
[ 6048.070162] CPU: 6 PID: 148 Comm: kswapd0 Tainted: G     U            5.3.0-rc6+ #40
[ 6048.070163] Hardware name: PC Specialist LTD N8xxEZ                         /N8xxEZ                         , BIOS
1.07.08 10/04/2018
[ 6048.070165] RIP: 0010:check_flush_dependency+0x105/0x120
[ 6048.070166] Code: 8d 8a c0 05 00 00 49 89 e8 48 c7 c7 90 61 b5 b0 48 8d 8b b0 00 00 00 4c 89 ca 48 89 04 24 c6 05 02
8f 00 01 01 e8 b2 97 fe ff <0f> 0b 48 8b 04 24 e9 63 ff ff ff 80 3d eb 8e 00 01 00 0f 85 56 ff
[ 6048.070167] RSP: 0018:ffffa6e4003679a0 EFLAGS: 00010086
[ 6048.070167] RAX: 0000000000000000 RBX: ffff8a188d414000 RCX: 0000000000000000
[ 6048.070168] RDX: 0000000000000063 RSI: ffffffffb125f723 RDI: ffffffffb125d28c
[ 6048.070169] RBP: ffffffffc0466390 R08: 000005802d12a057 R09: 0000000000000063
[ 6048.070169] R10: ffffffffb125faa0 R11: 00000000b125f70b R12: ffff8a188c809a80
[ 6048.070170] R13: ffff8a1890a23e00 R14: 0000000000000001 R15: 0000000000000000
[ 6048.070170] FS:  0000000000000000(0000) GS:ffff8a1890b80000(0000) knlGS:0000000000000000
[ 6048.070171] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 6048.070172] CR2: 00000000025d1fa0 CR3: 00000004d700a004 CR4: 00000000003606e0
[ 6048.070172] Call Trace:
[ 6048.070175]  __flush_work+0x8d/0x1d0
[ 6048.070176]  ? try_to_wake_up+0x1b9/0x3b0
[ 6048.070177]  __cancel_work_timer+0xfb/0x180
[ 6048.070179]  ? synchronize_irq+0x30/0xa0
[ 6048.070204]  ? fwtable_write32+0xf1/0x180 [i915]
[ 6048.070212]  gen6_disable_rps_interrupts+0x79/0xa0 [i915]
[ 6048.070220]  gen6_rps_idle+0xe/0xd0 [i915]
[ 6048.070230]  intel_gt_park+0x4f/0x60 [i915]
[ 6048.070239]  __intel_wakeref_put_last+0x12/0x40 [i915]
[ 6048.070248]  __engine_park+0xb7/0xc0 [i915]
[ [ 1578.086588] usb 2-5: new SuperSpeed Gen 1 USB device number 3 using xhci_hcd
[ 1578.107688] usb 2-5: New USB device found, idVendor=0080, idProduct=a001, bcdDevice= 2.04
[ 1578.107691] usb 2-5: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[ 1578.107691] usb 2-5: Product: External USB 3.0
[ 1578.107692] usb 2-5: Manufacturer: TOSHIBA
[ 1578.107693] usb 2-5: SerialNumber: 201503310007F
[ 1578.111610] scsi host5: uas
[ 1578.111951] scsi 5:0:0:0: Direct-Access     TO Exter nal USB 3.0      0204 PQ: 0 ANSI: 6
[ 1578.112422] sd 5:0:0:0: Attached scsi generic sg1 type 0
[ 1578.113132] sd 5:0:0:0: [sdb] 3907029168 512-byte logical blocks: (2.00 TB/1.82 TiB)
[ 1578.113133] sd 5:0:0:0: [sdb] 4096-byte physical blocks
[ 1578.113280] sd 5:0:0:0: [sdb] Write Protect is off
[ 1578.113281] sd 5:0:0:0: [sdb] Mode Sense: 53 00 00 08
[ 1578.113570] sd 5:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1578.113846] sd 5:0:0:0: [sdb] Optimal transfer size 33553920 bytes not a multiple of physical block size (4096 bytes)
[ 1578.192462]  sdb: sdb1 sdb2 sdb3
[ 1578.195765] sd 5:0:0:0: [sdb] Attached SCSI disk
[ 1579.080448] EXT4-fs (sdb1): mounted filesystem with ordered data mode. Opts: (null)
[ 1579.588368] EXT4-fs (sdb3): mounted filesystem with ordered data mode. Opts: (null)
[ 1639.062480] usb 1-1: new high-speed USB device number 6 using xhci_hcd
[ 1639.314611] usb 1-1: New USB device found, idVendor=152d, idProduct=0578, bcdDevice= 5.08
[ 1639.314613] usb 1-1: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[ 1639.314614] usb 1-1: Product: USB to ATA/ATAPI Bridge
[ 1639.314615] usb 1-1: Manufacturer: JMicron
[ 1639.314615] usb 1-1: SerialNumber: 0123456789ABCDEF
[ 1639.341742] scsi host6: uas
[ 1639.352633] scsi 6:0:0:0: Direct-Access     JMicron  Generic          0508 PQ: 0 ANSI: 6
[ 1639.353140] sd 6:0:0:0: Attached scsi generic sg2 type 0
[ 1642.388518] sd 6:0:0:0: [sdc] 1953525168 512-byte logical blocks: (1.00 TB/932 GiB)
[ 1642.388520] sd 6:0:0:0: [sdc] 4096-byte physical blocks
[ 1642.388801] sd 6:0:0:0: [sdc] Write Protect is off
[ 1642.388802] sd 6:0:0:0: [sdc] Mode Sense: 5f 00 00 08
[ 1642.389117] sd 6:0:0:0: [sdc] Disabling FUA
[ 1642.389118] sd 6:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[ 1642.389342] sd 6:0:0:0: [sdc] Optimal transfer size 33553920 bytes not a multiple of physical block size (4096 bytes)
[ 1642.418255]  sdc: sdc1
[ 1642.421158] sd 6:0:0:0: [sdc] Attached SCSI disk
[ 1643.970443] EXT4-fs (sdc1): mounted filesystem with ordered data mode. Opts: (null)
[ 6048.070133] ------------[ cut here ]------------
[ 6048.070148] workqueue: PF_MEMALLOC task 148(kswapd0) is flushing !WQ_MEM_RECLAIM events:gen6_pm_rps_work [i915]
[ 6048.070152] WARNING: CPU: 6 PID: 148 at kernel/workqueue.c:2598 check_flush_dependency+0x105/0x120
[ 6048.070152] Modules linked in: uas rfcomm bnep iptable_filter xt_conntrack iptable_nat xt_MASQUERADE nf_nat
nf_conntrack nf_defrag_ipv4 coretemp hwmon snd_hda_codec_hdmi snd_hda_codec_generic iwlmvm mac80211 uvcvideo
videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 videobuf2_common snd_hda_intel iwlwifi usbhid snd_hda_codec btusb
btintel snd_hwdep x86_pkg_temp_thermal snd_hda_core cfg80211 i915
[ 6048.070162] CPU: 6 PID: 148 Comm: kswapd0 Tainted: G     U            5.3.0-rc6+ #40
[ 6048.070163] Hardware name: PC Specialist LTD N8xxEZ                         /N8xxEZ                         , BIOS
1.07.08 10/04/2018
[ 6048.070165] RIP: 0010:check_flush_dependency+0x105/0x120
[ 6048.070166] Code: 8d 8a c0 05 00 00 49 89 e8 48 c7 c7 90 61 b5 b0 48 8d 8b b0 00 00 00 4c 89 ca 48 89 04 24 c6 05 02
8f 00 01 01 e8 b2 97 fe ff <0f> 0b 48 8b 04 24 e9 63 ff ff ff 80 3d eb 8e 00 01 00 0f 85 56 ff
[ 6048.070167] RSP: 0018:ffffa6e4003679a0 EFLAGS: 00010086
[ 6048.070167] RAX: 0000000000000000 RBX: ffff8a188d414000 RCX: 0000000000000000
[ 6048.070168] RDX: 0000000000000063 RSI: ffffffffb125f723 RDI: ffffffffb125d28c
[ 6048.070169] RBP: ffffffffc0466390 R08: 000005802d12a057 R09: 0000000000000063
[ 6048.070169] R10: ffffffffb125faa0 R11: 00000000b125f70b R12: ffff8a188c809a80
[ 6048.070170] R13: ffff8a1890a23e00 R14: 0000000000000001 R15: 0000000000000000
[ 6048.070170] FS:  0000000000000000(0000) GS:ffff8a1890b80000(0000) knlGS:0000000000000000
[ 6048.070171] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 6048.070172] CR2: 00000000025d1fa0 CR3: 00000004d700a004 CR4: 00000000003606e0
[ 6048.070172] Call Trace:
[ 6048.070175]  __flush_work+0x8d/0x1d0
[ 6048.070176]  ? try_to_wake_up+0x1b9/0x3b0
[ 6048.070177]  __cancel_work_timer+0xfb/0x180
[ 6048.070179]  ? synchronize_irq+0x30/0xa0
[ 6048.070204]  ? fwtable_write32+0xf1/0x180 [i915]
[ 6048.070212]  gen6_disable_rps_interrupts+0x79/0xa0 [i915]
[ 6048.070220]  gen6_rps_idle+0xe/0xd0 [i915]
[ 6048.070230]  intel_gt_park+0x4f/0x60 [i915]
[ 6048.070239]  __intel_wakeref_put_last+0x12/0x40 [i915]
[ 6048.070248]  __engine_park+0xb7/0xc0 [i915]
[ 6048.070256]  __intel_wakeref_put_last+0x12/0x40 [i915]
[ 6048.070267]  i915_request_retire+0x260/0x2f0 [i915]
[ 6048.070278]  ring_retire_requests+0x49/0x50 [i915]
[ 6048.070288]  i915_retire_requests+0x3e/0x80 [i915]
[ 6048.070298]  i915_gem_shrink+0xc2/0x450 [i915]
[ 6048.070309]  i915_gem_shrinker_scan+0x5e/0x110 [i915]
[ 6048.070311]  shrink_slab.constprop.0+0x1ab/0x260
[ 6048.070313]  shrink_node+0x6f/0x1d0
[ 6048.070314]  balance_pgdat+0x215/0x470
[ 6048.070316]  kswapd+0x153/0x2e0
[ 6048.070317]  ? wait_woken+0x70/0x70
[ 6048.070318]  kthread+0xf1/0x130
[ 6048.070320]  ? balance_pgdat+0x470/0x470
[ 6048.070321]  ? kthread_park+0x70/0x70
[ 6048.070322]  ret_from_fork+0x1f/0x40
[ 6048.070323] ---[ end trace 5178932352001727 ]---

It might be difficult to create it again, but I guess a heads up might be useful.

Chris


