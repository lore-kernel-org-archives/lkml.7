Return-Path: <SRS0=kjqD=WY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2056DC3A5A1
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 15:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F229F22CED
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Aug 2019 15:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbfH1PTw convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Aug 2019 11:19:52 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:55500 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726415AbfH1PTw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 11:19:52 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 18292894-1500050 
        for multiple; Wed, 28 Aug 2019 16:19:35 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Chris Clayton <chris2553@googlemail.com>,
        LKML <linux-kernel@vger.kernel.org>
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <c2706468-6f88-7276-b791-e9573394aa18@gmail.com>
Cc:     tj@kernel.org, intel-gfx@lists.freedesktop.org
References: <c2706468-6f88-7276-b791-e9573394aa18@gmail.com>
Message-ID: <156700557283.15406.5823286371997423740@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [Intel-gfx] Workqueue - warning splat
Date:   Wed, 28 Aug 2019 16:19:32 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Chris Clayton (2019-08-28 16:14:20)
> Hi,
> 
> I've just copying 319G of data from a partition on one USB-attached (/dev/sdb3) to a partition on another USB-attached
> drive (/dev/sdc1). It's not quite finished but as it's progressed, I have been reading email and browsing web sites, so
> switching between windows from time to time.
> 
> I found the splat below at the end the output from dmesg:

> [ 6048.070148] workqueue: PF_MEMALLOC task 148(kswapd0) is flushing !WQ_MEM_RECLAIM events:gen6_pm_rps_work [i915]
> [ 6048.070152] WARNING: CPU: 6 PID: 148 at kernel/workqueue.c:2598 check_flush_dependency+0x105/0x120
> [ 6048.070152] Modules linked in: uas rfcomm bnep iptable_filter xt_conntrack iptable_nat xt_MASQUERADE nf_nat
> nf_conntrack nf_defrag_ipv4 coretemp hwmon snd_hda_codec_hdmi snd_hda_codec_generic iwlmvm mac80211 uvcvideo
> videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 videobuf2_common snd_hda_intel iwlwifi usbhid snd_hda_codec btusb
> btintel snd_hwdep x86_pkg_temp_thermal snd_hda_core cfg80211 i915
> [ 6048.070162] CPU: 6 PID: 148 Comm: kswapd0 Tainted: G     U            5.3.0-rc6+ #40
> [ 6048.070163] Hardware name: PC Specialist LTD N8xxEZ                         /N8xxEZ                         , BIOS
> 1.07.08 10/04/2018
> [ 6048.070165] RIP: 0010:check_flush_dependency+0x105/0x120
> [ 6048.070166] Code: 8d 8a c0 05 00 00 49 89 e8 48 c7 c7 90 61 b5 b0 48 8d 8b b0 00 00 00 4c 89 ca 48 89 04 24 c6 05 02
> 8f 00 01 01 e8 b2 97 fe ff <0f> 0b 48 8b 04 24 e9 63 ff ff ff 80 3d eb 8e 00 01 00 0f 85 56 ff
> [ 6048.070167] RSP: 0018:ffffa6e4003679a0 EFLAGS: 00010086
> [ 6048.070167] RAX: 0000000000000000 RBX: ffff8a188d414000 RCX: 0000000000000000
> [ 6048.070168] RDX: 0000000000000063 RSI: ffffffffb125f723 RDI: ffffffffb125d28c
> [ 6048.070169] RBP: ffffffffc0466390 R08: 000005802d12a057 R09: 0000000000000063
> [ 6048.070169] R10: ffffffffb125faa0 R11: 00000000b125f70b R12: ffff8a188c809a80
> [ 6048.070170] R13: ffff8a1890a23e00 R14: 0000000000000001 R15: 0000000000000000
> [ 6048.070170] FS:  0000000000000000(0000) GS:ffff8a1890b80000(0000) knlGS:0000000000000000
> [ 6048.070171] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [ 6048.070172] CR2: 00000000025d1fa0 CR3: 00000004d700a004 CR4: 00000000003606e0
> [ 6048.070172] Call Trace:
> [ 6048.070175]  __flush_work+0x8d/0x1d0
> [ 6048.070176]  ? try_to_wake_up+0x1b9/0x3b0
> [ 6048.070177]  __cancel_work_timer+0xfb/0x180
> [ 6048.070179]  ? synchronize_irq+0x30/0xa0
> [ 6048.070204]  ? fwtable_write32+0xf1/0x180 [i915]
> [ 6048.070212]  gen6_disable_rps_interrupts+0x79/0xa0 [i915]
> [ 6048.070220]  gen6_rps_idle+0xe/0xd0 [i915]
> [ 6048.070230]  intel_gt_park+0x4f/0x60 [i915]
> [ 6048.070239]  __intel_wakeref_put_last+0x12/0x40 [i915]
> [ 6048.070248]  __engine_park+0xb7/0xc0 [i915]
> 
> It might be difficult to create it again, but I guess a heads up might be useful.

Should be fixed by 

commit c7302f204490f3eb4ef839bec228315bcd3ba43f
Author: Chris Wilson <chris@chris-wilson.co.uk>
Date:   Thu Aug 8 21:27:58 2019 +0100

    drm/i915: Defer final intel_wakeref_put to process context

-Chris
