Return-Path: <SRS0=xa+R=Y4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A87CA9ED0
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 01:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00A6C222C7
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Nov 2019 01:40:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728661AbfKDBk2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Nov 2019 20:40:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:55712 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728288AbfKDBk2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Nov 2019 20:40:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 4DDCFB1A5;
        Mon,  4 Nov 2019 01:40:25 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: [RFC 0/7] ARM: dts: Mali for Realtek RTD1195/RTD1295
Date:   Mon,  4 Nov 2019 02:39:25 +0100
Message-Id: <20191104013932.22505-1-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series adds the Mali GPU to Realtek RTD1195 and RTD1295 SoC DTs.

DT patches depend on RTD1295 clk series, to be resent; RTD1195 clk to be sent.
RTD1395 and RTD1619 DTs have not yet been prepared, only bindings while at it.

My testing was unsuccessful so far...

For RTD1195 I don't have a mali-supply yet, the bus clk was picked randomly
to make binding/driver happy, and the address/size is not clear.
For RTD1295 I don't have a bus clk specified; later patches add mali-supply
as G2227 PMIC's DCDC3 for Zidoo X9S.

RTD1295:

[    2.451713] panfrost 98050000.gpu: clock rate = 503929687
[    2.457326] panfrost 98050000.gpu: failed to get regulator: -517
[    2.463527] panfrost 98050000.gpu: regulator init failed -517
[    2.755320] panfrost 98050000.gpu: clock rate = 503929687
[    2.771280] panfrost 98050000.gpu: gpu soft reset timed out
[    2.777050] panfrost 98050000.gpu: Fatal error during GPU init
[    2.783236] panfrost: probe of 98050000.gpu failed with error -110

RTD1195 with 0x18030000:

[    3.722075] lima 18030000.gpu: IRQ pmu not found
[    3.727315] lima 18030000.gpu: mmu gpmmu dte write test fail
[    3.733237] lima: probe of 18030000.gpu failed with error -5

RTD1195 with 0x18003000:

[    3.722861] lima 18003000.gpu: IRQ pmu not found
[    3.728099] 8<--- cut here ---
[    3.731235] Unable to handle kernel paging request at virtual address f0879000
[    3.738685] pgd = (ptrval)
[    3.741461] [f0879000] *pgd=80000000107003, *pmd=2b008003, *pte=00000000
[    3.748396] Internal error: Oops: a07 [#1] PREEMPT SMP ARM
[    3.754019] Modules linked in:
[    3.757157] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.4.0-rc5-next-20191031+ #202
[    3.765000] Hardware name: Realtek RTD1195
[    3.769210] PC is at lima_mmu_init+0x2c/0x200
[    3.773678] LR is at lima_device_init+0x1e0/0x644
[    3.778498] pc : [<c0667f20>]    lr : [<c0667664>]    psr: 80000013
[    3.784919] sp : eb041db0  ip : eac00200  fp : 00000007
[    3.790274] r10: eb2c3088  r9 : eb2c3058  r8 : 00000001
[    3.795630] r7 : c101b650  r6 : c101b634  r5 : eb2c3040  r4 : eb2c3088
[    3.802318] r3 : f0879000  r2 : cafebabe  r1 : 0000001f  r0 : eb2c3088
[    3.809007] Flags: Nzcv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
[    3.816320] Control: 30c5387d  Table: 00103000  DAC: fffffffd
[    3.822207] Process swapper/0 (pid: 1, stack limit = 0x(ptrval))
[    3.828361] Stack: (0xeb041db0 to 0xeb042000)
[    3.832832] 1da0:                                     00000001 c1003e50 eb175800 c06733d0
[    3.841215] 1dc0: 00000001 00000001 eb2c3040 c101b634 c101b650 00000001 eb2c3058 c0667664
[    3.849599] 1de0: eac152d0 c063df04 ea858800 00000000 c10700d0 eb2c3070 ea858800 eb175810
[    3.857981] 1e00: eb2c3040 ea858800 c1070158 00000000 c101b4f4 00000000 00000007 c066706c
[    3.866365] 1e20: 00000000 eb175810 c101b4f4 c0673868 eb175810 c1070154 00000000 c1070158
[    3.874750] 1e40: 00000000 c0671a64 eb175810 c101b4f4 c101b4f4 c101be00 c0e31834 c0e31854
[    3.883134] 1e60: 000000bc c0671d44 000000bc c0791fb4 c0a6affc eb175810 00000000 c101b4f4
[    3.891518] 1e80: c101be00 c0e31834 c0e31854 000000bc 00000007 c0671ff0 00000000 c101b4f4
[    3.899903] 1ea0: eb175810 c0672050 00000000 c101b4f4 c0671ff8 c066fdc4 00000007 eb035e58
[    3.908287] 1ec0: eb0d70b4 c1003e50 c101b4f4 ea85dc00 00000000 c0670e10 c0bf306c c0e1b4b0
[    3.916669] 1ee0: ffffe000 c101b4f4 c0e1b4b0 ffffe000 00000000 c06728b0 c1037700 c0e1b4b0
[    3.925053] 1f00: ffffe000 c0202770 000000bc c02595e8 00000000 c0c76b00 c0c080f0 c0e004a4
[    3.933437] 1f20: 00000000 00000006 00000006 c0bc22bc c0bb68d4 c0bb6888 00000000 ef5f5120
[    3.941822] 1f40: ef5f5127 c1003e50 cccccccd 00000006 c1037700 c1003e50 c0e004a4 c0e40568
[    3.950206] 1f60: c1037700 c1037700 c0e004a4 c0e00f24 00000006 00000006 00000000 c0e004a4
[    3.958590] 1f80: c092052c 00000000 c092052c 00000000 00000000 00000000 00000000 00000000
[    3.966972] 1fa0: 00000000 c0920534 00000000 c02011f8 00000000 00000000 00000000 00000000
[    3.975356] 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    3.983739] 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
[    3.992134] [<c0667f20>] (lima_mmu_init) from [<c0667664>] (lima_device_init+0x1e0/0x644)
[    4.000521] [<c0667664>] (lima_device_init) from [<c066706c>] (lima_pdev_probe+0x7c/0xc4)
[    4.008908] [<c066706c>] (lima_pdev_probe) from [<c0673868>] (platform_drv_probe+0x48/0x98)
[    4.017473] [<c0673868>] (platform_drv_probe) from [<c0671a64>] (really_probe+0x1e0/0x34c)
[    4.025949] [<c0671a64>] (really_probe) from [<c0671d44>] (driver_probe_device+0x60/0x16c)
[    4.034424] [<c0671d44>] (driver_probe_device) from [<c0671ff0>] (device_driver_attach+0x58/0x60)
[    4.043523] [<c0671ff0>] (device_driver_attach) from [<c0672050>] (__driver_attach+0x58/0xcc)
[    4.052264] [<c0672050>] (__driver_attach) from [<c066fdc4>] (bus_for_each_dev+0x78/0xc0)
[    4.060651] [<c066fdc4>] (bus_for_each_dev) from [<c0670e10>] (bus_add_driver+0x184/0x1dc)
[    4.069127] [<c0670e10>] (bus_add_driver) from [<c06728b0>] (driver_register+0x74/0x108)
[    4.077425] [<c06728b0>] (driver_register) from [<c0202770>] (do_one_initcall+0x58/0x1c4)
[    4.085814] [<c0202770>] (do_one_initcall) from [<c0e00f24>] (kernel_init_freeable+0x138/0x1d4)
[    4.094735] [<c0e00f24>] (kernel_init_freeable) from [<c0920534>] (kernel_init+0x8/0x110)
[    4.103122] [<c0920534>] (kernel_init) from [<c02011f8>] (ret_from_fork+0x14/0x3c)
[    4.110878] Exception stack(0xeb041fb0 to 0xeb041ff8)
[    4.116059] 1fa0:                                     00000000 00000000 00000000 00000000
[    4.124442] 1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
[    4.132823] 1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
[    4.139607] Code: f57ff04e e30b2abe e590300c e34c2afe (e5832000) 
[    4.146186] ---[ end trace 26997bb6f978b400 ]---
[    4.150936] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
[    4.158791] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b ]---

Latest experimental patches at:
https://github.com/afaerber/linux/commits/rtd1295-next

Have a lot of fun!

Cheers,
Andreas

Cc: devicetree@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>

Andreas Färber (7):
  dt-bindings: gpu: mali-midgard: Tidy up conversion to YAML
  dt-bindings: gpu: mali-midgard: Add Realtek RTD1295
  arm64: dts: realtek: rtd1295: Add Mali node
  dt-bindings: gpu: mali-utgard: Add Realtek RTD1195
  ARM: dts: rtd1195: Add Mali node
  dt-bindings: gpu: mali-utgard: Add Realtek RTD1395
  dt-bindings: gpu: arm-bifrost: Add Realtek RTD1619

 .../devicetree/bindings/gpu/arm,mali-bifrost.yaml  |  1 +
 .../devicetree/bindings/gpu/arm,mali-midgard.yaml  | 33 ++++-----
 .../devicetree/bindings/gpu/arm,mali-utgard.yaml   |  5 ++
 arch/arm/boot/dts/rtd1195.dtsi                     | 19 +++++
 arch/arm64/boot/dts/realtek/rtd1295.dtsi           | 85 ++++++++++++++++++++++
 5 files changed, 125 insertions(+), 18 deletions(-)

-- 
2.16.4

