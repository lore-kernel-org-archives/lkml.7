Return-Path: <SRS0=P610=TX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E609BC282DD
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 09:28:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A16C320675
	for <linux-kernel@archiver.kernel.org>; Thu, 23 May 2019 09:28:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20150623.gappssmtp.com header.i=@baylibre-com.20150623.gappssmtp.com header.b="hYKtS8T0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730278AbfEWJ2L (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 May 2019 05:28:11 -0400
Received: from mail-oi1-f171.google.com ([209.85.167.171]:44773 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726309AbfEWJ2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 May 2019 05:28:11 -0400
Received: by mail-oi1-f171.google.com with SMTP id z65so3834447oia.11
        for <linux-kernel@vger.kernel.org>; Thu, 23 May 2019 02:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=c/SMHZzanmqLbST3VVXeo8wq1O/tN0AtnObLl/V0SPU=;
        b=hYKtS8T0pVBWDOFmv8JMQ/pAEol8RyYwVvl/LTbdAuN7KQLdSo3XJJ98LwTWIFMpSY
         fMxYMmEt9agKUoT/udUdEbGeLZp95aZ1guNpVaY/cOciMCJYaIKSva2wD4feOQjawx9U
         2zMP9yP+b/sSlbDBpCc48VpS08WOlaTbVjrJ2sHKkfKzww2V3dauftR7QvPclq4SLDiY
         zgEN3ftI92/YcrOosukcMh8lugWSrkQDU0AoUdV5h6WP0ja4AzWB5uH67xMAPMf2iVVq
         LZLpWw3+2WYpuAF2S2dtvxkE7u4AB6AIGwXaznHXXgHxGWjR0cvNyuHziLz5YaTvm8Gv
         vVRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=c/SMHZzanmqLbST3VVXeo8wq1O/tN0AtnObLl/V0SPU=;
        b=WgX5ZGbZ5WZbZ6nZMELa8dp6XVyXVc0kBJCvW6c9vAmcrBLg8maIEh1PqG+139Y4ez
         Z/jgiFcb74IxleziTk9UFCaWhu8e1phQy2hyMz38urLxBEZZ2dL9KEyd9sulvCzCiV4m
         SWsjyTj9yfDsAbW0A/uS0bgXWeKyIcyaIqU/YKrwcZ032OGUoxfVZozhiUFUreQ4Krh/
         lj88S0bBFLnZCtF03jt9mZ4eHyED8fVChTnZrX9o2/pJlgPzC9tON61M5QCVC1I33l3Q
         PPAhT/IyEA0IF2YN5b/lOO+RFtXuI6EfJxXUmG7xUa7vsPJDkTb2jNU0WuBSmVK3Fbu+
         883w==
X-Gm-Message-State: APjAAAX/SmFEMHlQ8DZNv07aQALMFVD6KdywkoiU0QcL2iPmIOrLQwTp
        sIMIOjwATVHCxUtxFkXY2GhX7Z0aTesaiOBO5y/UIA==
X-Google-Smtp-Source: APXvYqyF0VYYjeXV273NmKdxm81Ys/f21DdSiiGf6UiaHP7S2rnsGx8HlgvXi7WQ6CAzJJySwW17gIexl4xKmFEOlf4=
X-Received: by 2002:aca:5943:: with SMTP id n64mr2115413oib.175.1558603690259;
 Thu, 23 May 2019 02:28:10 -0700 (PDT)
MIME-Version: 1.0
From:   Bartosz Golaszewski <bgolaszewski@baylibre.com>
Date:   Thu, 23 May 2019 11:27:59 +0200
Message-ID: <CAMpxmJWDJiLZA7NQ12VkxqV9nKV-9idn3JsZGdXhz0e19NX54w@mail.gmail.com>
Subject: regulator: NULL-pointer dereference in tps6507x
To:     Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
Cc:     Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@baylibre.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Axel,

commit f979c08f7624 ("regulator: tps6507x: Convert to regulator core's
simplified DT parsing code") causes the following crash on da850-evm
board with linux v5.2-rc1:

Unable to handle kernel NULL pointer dereference at virtual address 00000164
pgd = (ptrval)
[00000164] *pgd=00000000
Internal error: Oops: 5 [#1] PREEMPT ARM
Modules linked in:
CPU: 0 PID: 13 Comm: kworker/0:1 Not tainted 5.1.0-rc1-00068-gf979c08f7624 #45
Hardware name: Generic DA850/OMAP-L138/AM18x
Workqueue: events deferred_probe_work_func
PC is at tps6507x_pmic_probe+0xa8/0x1b4
LR is at devres_add+0x54/0x84
pc : [<c0299010>]    lr : [<c02cfe8c>]    psr: 20000013
sp : c68a1a40  ip : 00000002  fp : 00000000
r10: c6b4c820  r9 : c6b7c9e0  r8 : c6b4cc64
r7 : 00000001  r6 : 000000b4  r5 : c0631a94  r4 : c6b4c8f8
r3 : 00000000  r2 : 00000000  r1 : 00000001  r0 : c6b53c00
Flags: nzCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
Control: 0005317f  Table: c0004000  DAC: 00000053
Process kworker/0:1 (pid: 13, stack limit = 0x(ptrval))
Stack: (0xc68a1a40 to 0xc68a2000)
1a40: c6b95210 c6b95200 00000000 c6b95020 00000000 c6b4c820 00000000 00000000
1a60: 00000000 37c6032f 00000000 c6b95210 00000000 c0631a38 c0631a38 00000009
1a80: 00000000 00000000 c6b899c0 c02ce698 c6b95210 c0661218 00000000 c02cca3c
1aa0: c6b95210 c0631a38 c02cce20 c0609008 00000001 00000000 c06368b8 c02ccc64
1ac0: c0631a38 c68a1b1c c6b95210 00000000 c68a1b1c c02cce20 c0609008 00000001
1ae0: 00000000 c06368b8 c6b899c0 c02cad34 c6b95210 c68222a0 c68f32d4 37c6032f
1b00: c6b899c0 c6b95210 c6b95244 c0609008 c6b95210 c02cc7b4 00000000 c6b95210
1b20: 00000001 37c6032f c6b95218 c0635b78 c6b95210 c6b95210 c0609008 c02cbb94
1b40: c6b95218 c6b95020 00000000 c02c8a74 c6b95210 c0482dc8 c0609008 c6b95020
1b60: c6b95200 37c6032f c04d19c0 00000000 c6b95200 c6b95210 c6b95210 00000010
1b80: 00000000 c02ce4c4 c04d19c0 c6b95020 c6b95200 00000000 c6b95210 00000010
1ba0: 00000000 c02eb90c 00000000 a0000013 c7eea1e0 a0000013 fffffffe c6b899c0
1bc0: c04d19c0 00000000 00000002 c6b95020 ffffffff 00000000 00000000 c02eba74
1be0: 00000000 00000000 00000000 c0561df4 c6b899c0 c00db368 c6b95020 c6b95020
1c00: c6b7ca20 ffffffff c04d19c0 00000002 00000000 00000000 c06292e0 c02ebb40
1c20: 00000000 00000000 00000000 c6b7c9e0 c6b95020 c6b95000 c063685c c6b95000
1c40: 00000000 c02eb5d4 00000000 00000000 00000000 c02e0904 c6b95020 c6b95020
1c60: c02eb570 c031395c c6b95020 c0661218 00000000 c063685c 00000009 c02cca3c
1c80: c6b95020 c063685c c02cce20 c0609008 00000001 00000000 c0638390 c02ccc64
1ca0: c063685c c68a1cfc c6b95020 00000000 c68a1cfc c02cce20 c0609008 00000001
1cc0: 00000000 c0638390 c06292e0 c02cad34 c6b95020 c68be420 c68f33f4 37c6032f
1ce0: c06292e0 c6b95020 c6b95054 c0609008 c6b95020 c02cc7b4 c0609008 c6b95020
1d00: 00000001 37c6032f c6b95028 c06383d0 c6b95020 c6b95020 c0609008 c02cbb94
1d20: c6b95028 c6b538b0 00000000 c02c8a74 c6b95020 c06611f4 c6b95020 c0609008
1d40: c6b538b0 37c6032f c6b95000 c68a1d9c c6b95020 c0609008 c6b538b0 c6b95004
1d60: 00000000 c0314c50 c68a1d9c c0316984 00000048 37c6032f c7eea1e0 c7ee9f98
1d80: c6b53850 c6b538b0 c0609008 c0566690 c056666c c0316c98 00000000 36737074
1da0: 78373035 00000000 00000000 00000000 00480000 00000000 00000000 c7eea1e0
1dc0: 00000000 00000000 00000000 00000000 00000000 37c6032f c6b53850 00000000
1de0: c6b538b0 c0609008 00000000 c68c9010 00000000 c0315220 00000000 37c6032f
1e00: c6b53850 c6b53820 00000000 c6b53850 c0609008 c68c9000 c68c9010 c0317fdc
1e20: 00000000 c68c4400 c6b53820 00000000 000186a0 37c6032f c68c9010 00000000
1e40: c0638578 c0638578 00000009 00000000 00000000 c02ce698 c68c9010 c0661218
1e60: 00000000 c02cca3c c68c9010 c0638578 c02cce20 c0609008 00000001 00000000
1e80: c0635964 c02ccc64 c0638578 c68a1ee4 c68c9010 00000000 c68a1ee4 c02cce20
1ea0: c0609008 00000001 00000000 c0635964 c06292e0 c02cad34 c063593c c68222a0
1ec0: c68f35d4 37c6032f c06292e0 c68c9010 c68c9044 c0609008 c063593c c02cc7b4
1ee0: c06292e0 c68c9010 00000001 37c6032f c68c9010 c0635b78 c68c9010 c063593c
1f00: c0623a28 c02cbb94 c68c9010 c063592c c063592c c02cc014 c0635960 c68204e0
1f20: c7edc300 00000000 c0623a28 c003116c 00000008 c0623a28 c68204e0 c0623a28
1f40: c68204f4 c68a0000 c0623a3c 00000008 c0623a28 c0031630 c6891440 00000040
1f60: c684beb8 c6891440 c6887ca0 00000000 c68a0000 c68204e0 c00313b0 c6891458
1f80: c684beb8 c0036c84 00000000 c6887ca0 c0036b90 00000000 00000000 00000000
1fa0: 00000000 00000000 00000000 c00090e0 00000000 00000000 00000000 00000000
1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
1fe0: 00000000 00000000 00000000 00000000 00000013 00000000 00000000 00000000
[<c0299010>] (tps6507x_pmic_probe) from [<c02ce698>]
(platform_drv_probe+0x48/0x9c)
[<c02ce698>] (platform_drv_probe) from [<c02cca3c>] (really_probe+0x20c/0x2d8)
[<c02cca3c>] (really_probe) from [<c02ccc64>] (driver_probe_device+0x5c/0x168)
[<c02ccc64>] (driver_probe_device) from [<c02cad34>]
(bus_for_each_drv+0x70/0xb8)
[<c02cad34>] (bus_for_each_drv) from [<c02cc7b4>] (__device_attach+0xc8/0x13c)
[<c02cc7b4>] (__device_attach) from [<c02cbb94>] (bus_probe_device+0x84/0x8c)
[<c02cbb94>] (bus_probe_device) from [<c02c8a74>] (device_add+0x374/0x5e4)
[<c02c8a74>] (device_add) from [<c02ce4c4>] (platform_device_add+0x100/0x20c)
[<c02ce4c4>] (platform_device_add) from [<c02eb90c>]
(mfd_add_device+0x2b0/0x330)
[<c02eb90c>] (mfd_add_device) from [<c02eba74>] (mfd_add_devices+0x94/0xfc)
[<c02eba74>] (mfd_add_devices) from [<c02ebb40>]
(devm_mfd_add_devices+0x60/0xa4)
[<c02ebb40>] (devm_mfd_add_devices) from [<c02eb5d4>]
(tps6507x_i2c_probe+0x64/0x80)
[<c02eb5d4>] (tps6507x_i2c_probe) from [<c031395c>]
(i2c_device_probe+0x1c0/0x24c)
[<c031395c>] (i2c_device_probe) from [<c02cca3c>] (really_probe+0x20c/0x2d8)
[<c02cca3c>] (really_probe) from [<c02ccc64>] (driver_probe_device+0x5c/0x168)
[<c02ccc64>] (driver_probe_device) from [<c02cad34>]
(bus_for_each_drv+0x70/0xb8)
[<c02cad34>] (bus_for_each_drv) from [<c02cc7b4>] (__device_attach+0xc8/0x13c)
[<c02cc7b4>] (__device_attach) from [<c02cbb94>] (bus_probe_device+0x84/0x8c)
[<c02cbb94>] (bus_probe_device) from [<c02c8a74>] (device_add+0x374/0x5e4)
[<c02c8a74>] (device_add) from [<c0314c50>] (i2c_new_device+0x158/0x2dc)
[<c0314c50>] (i2c_new_device) from [<c0316c98>]
(of_i2c_register_devices+0x104/0x134)
[<c0316c98>] (of_i2c_register_devices) from [<c0315220>]
(i2c_register_adapter+0x150/0x3ec)
[<c0315220>] (i2c_register_adapter) from [<c0317fdc>]
(davinci_i2c_probe+0x1a0/0x410)
[<c0317fdc>] (davinci_i2c_probe) from [<c02ce698>]
(platform_drv_probe+0x48/0x9c)
[<c02ce698>] (platform_drv_probe) from [<c02cca3c>] (really_probe+0x20c/0x2d8)
[<c02cca3c>] (really_probe) from [<c02ccc64>] (driver_probe_device+0x5c/0x168)
[<c02ccc64>] (driver_probe_device) from [<c02cad34>]
(bus_for_each_drv+0x70/0xb8)
[<c02cad34>] (bus_for_each_drv) from [<c02cc7b4>] (__device_attach+0xc8/0x13c)
[<c02cc7b4>] (__device_attach) from [<c02cbb94>] (bus_probe_device+0x84/0x8c)
[<c02cbb94>] (bus_probe_device) from [<c02cc014>]
(deferred_probe_work_func+0x60/0x8c)
[<c02cc014>] (deferred_probe_work_func) from [<c003116c>]
(process_one_work+0x204/0x448)
[<c003116c>] (process_one_work) from [<c0031630>] (worker_thread+0x280/0x62c)
[<c0031630>] (worker_thread) from [<c0036c84>] (kthread+0xf4/0x130)
[<c0036c84>] (kthread) from [<c00090e0>] (ret_from_fork+0x14/0x34)
Exception stack(0xc68a1fb0 to 0xc68a1ff8)
1fa0:                                     00000000 00000000 00000000 00000000
1fc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
1fe0: 00000000 00000000 00000000 00000000 00000013 00000000
Code: e58a9438 e3560000 e4885004 0a000003 (e59620b0)
---[ end trace 6cda45ba3f4bbd9d ]---

I just bisected it, but didn't have time to look into the culprit yet.

Best regards,
Bartosz
