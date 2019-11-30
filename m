Return-Path: <SRS0=Z/Yg=ZW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF0DC432C0
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 21:20:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D7CE2075A
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Nov 2019 21:20:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=wylie.me.uk header.i=@wylie.me.uk header.b="DRO0rhpW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbfK3VSR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 30 Nov 2019 16:18:17 -0500
Received: from rfvt.org.uk ([37.187.119.221]:47326 "EHLO rfvt.org.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727025AbfK3VSR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 16:18:17 -0500
X-Greylist: delayed 355 seconds by postgrey-1.27 at vger.kernel.org; Sat, 30 Nov 2019 16:18:16 EST
Received: from wylie.me.uk (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by rfvt.org.uk (Postfix) with ESMTPS id 7D79E80260;
        Sat, 30 Nov 2019 21:12:18 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=wylie.me.uk;
        s=mydkim005; t=1575148338;
        bh=YtJM749/Vc+jTOlaIpWSNCP5WEMhROS91Wq3rksFUGw=;
        h=Date:From:To:Subject;
        b=DRO0rhpW46eO0JbbDENSIbWgjxkJwC09Sr0t/CHGtJJKwC3/rchRI9AI5l0U5xBti
         E6gCSv/ty4s+LV8H8wZc9MEVPgCuoBLrzZyEOIaXlG+kq/NNZclKgEhco57X9N5tOS
         POxIsJGGdxY6GUvAzR2iaQLyF7fgjSUcAMWz+n3zJJKBjEYYtr0K9mtk+TSZi1Trbv
         qLcDeOc2/XWFsf+gY+K/gehpJb0IU5bZ3sSLj49acFxkdRi+5VUQwfapKYTNsTKuok
         VZxeTFP6eZ8EwvKUHIX7KD3dFT2bUK5M/vm3fymlQLzsw+RCgNz6EU7wImGSdV5Uia
         3je+6AY6HkfEw==
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <24034.56114.248207.524177@wylie.me.uk>
Date:   Sat, 30 Nov 2019 21:12:18 +0000
From:   "Alan J. Wylie" <alan@wylie.me.uk>
X-Mailer: VM 8.2.0b under 26.3 (x86_64-pc-linux-gnu)
To:     Heiner Kallweit <hkallweit1@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: 5.4 Regression in r8169 with jumbo frames - packet loss/delays
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


I have a Realtek ethernet interface (rtl8168e ?) using the r8169 driver

It uses Jumbo frames (6000 bytes) and has a bridge on it.

With 5.4 I saw repeated packet loss / very long delays. Also with 5.4.1.

There were also some kernel messages at about the same time as the
pings stopped: "r8169 transmit queue timed out".

I was unable to reproduce the issue on another system with a different
network card.

I've run a fairly targeted bisect - see below.

If there is any more information I can provide, or testing to be done
I'll be glad to help.

Regards
Alan


git bisect start '--' 'drivers/net/ethernet/realtek'
# good: [b8e167066e85c9e1e9c5d27b82a858d96e6ba22c] Linux 5.3.14
git bisect good b8e167066e85c9e1e9c5d27b82a858d96e6ba22c
# bad: [219d54332a09e8d8741c1e1982f5eae56099de85] Linux 5.4
git bisect bad 219d54332a09e8d8741c1e1982f5eae56099de85
# good: [4d856f72c10ecb060868ed10ff1b1453943fc6c8] Linux 5.3
git bisect good 4d856f72c10ecb060868ed10ff1b1453943fc6c8
# good: [2e779ddb5617928ee09842758c4734682264279d] r8169: use the generic EEE management functions
git bisect good 2e779ddb5617928ee09842758c4734682264279d
# good: [ae84bc18733752e9bf47227bd80b3c0f3649b8d0] r8169: don't use bit LastFrag in tx descriptor after send
git bisect good ae84bc18733752e9bf47227bd80b3c0f3649b8d0
# good: [dc161162e42ca51daff50e86a4a4bb8395d60501] r8169: don't set bit RxVlan on RTL8125
git bisect good dc161162e42ca51daff50e86a4a4bb8395d60501
# bad: [4ebcb113edcc498888394821bca2e60ef89c6ff3] r8169: fix jumbo packet handling on resume from suspend
git bisect bad 4ebcb113edcc498888394821bca2e60ef89c6ff3
# good: [299d14d4c31aff3b37a03894e012edf8421676ee] Merge tag 'pci-v5.4-changes' of git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci
git bisect good 299d14d4c31aff3b37a03894e012edf8421676ee
# first bad commit: [4ebcb113edcc498888394821bca2e60ef89c6ff3] r8169: fix jumbo packet handling on resume from suspend


2: enp3s0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 6000 qdisc pfifo_fast master br0 state UP mode DEFAULT group default qlen 1000
    link/ether 90:2b:34:9d:ed:6f brd ff:ff:ff:ff:ff:ff

3: br0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 6000 qdisc noqueue state UP mode DEFAULT group default qlen 1000
    link/ether 90:2b:34:9d:ed:6f brd ff:ff:ff:ff:ff:ff


03:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8111/8168/8411 PCI Express Gigabit Ethernet Controller (rev 06)
	Subsystem: Gigabyte Technology Co., Ltd Onboard Ethernet
	Flags: bus master, fast devsel, latency 0, IRQ 17, NUMA node 0
	I/O ports at de00 [size=256]
	Memory at fdeff000 (64-bit, prefetchable) [size=4K]
	Memory at fdef8000 (64-bit, prefetchable) [size=16K]
	Capabilities: <access denied>
	Kernel driver in use: r8169

# ethtool -i enp3s0
driver: r8169
version:
firmware-version: rtl8168e-3_0.0.4 03/27/12
expansion-rom-version:
bus-info: 0000:03:00.0
supports-statistics: yes
supports-test: no
supports-eeprom-access: no
supports-register-dump: yes
supports-priv-flags: no

# mii-tool -v enp3s0
enp3s0: negotiated 1000baseT-FD flow-control, link ok
  product info: vendor 00:07:32, model 17 rev 5
  basic mode:   autonegotiation enabled
  basic status: autonegotiation complete, link ok
  capabilities: 1000baseT-HD 1000baseT-FD 100baseTx-FD 100baseTx-HD 10baseT-FD 10baseT-HD
  advertising:  1000baseT-HD 1000baseT-FD 100baseTx-FD 100baseTx-HD 10baseT-FD 10baseT-HD flow-control
  link partner: 1000baseT-FD 100baseTx-FD 100baseTx-HD 10baseT-FD 10baseT-HD flow-control


[  203.908724] NETDEV WATCHDOG: enp3s0 (r8169): transmit queue 0 timed out
[  203.908831] WARNING: CPU: 7 PID: 0 at net/sched/sch_generic.c:447 dev_watchdog+0x256/0x260
[  203.908883] Modules linked in: cpuid i2c_dev asus_atk0110 acpi_power_meter it87 hwmon_vid af_packet bridge stp llc usbhid xhci_pci ohci_pci xhci_hcd ohci_hcd ehci_pci ehci_hcd sr_mod usbcore 8250 cdrom i2c_piix4 k10temp fam15h_power usb_common 8250_base serial_core acpi_cpufreq ghash_clmulni_intel cryptd evdev softdog
[  203.908995] CPU: 7 PID: 0 Comm: swapper/7 Not tainted 5.4.0-rc1-00312-g4ebcb113edcc #4
[  203.909046] Hardware name: Gigabyte Technology Co., Ltd. GA-990XA-UD3/GA-990XA-UD3, BIOS F12 05/30/2012
[  203.909103] RIP: 0010:dev_watchdog+0x256/0x260
[  203.909150] Code: ff 0f 1f 00 eb 85 4c 89 f7 c6 05 0a 3e b3 00 01 e8 df 40 fc ff 44 89 e9 48 89 c2 4c 89 f6 48 c7 c7 60 b3 db aa e8 ea e0 aa ff <0f> 0b e9 63 ff ff ff 0f 1f 00 0f 1f 44 00 00 48 c7 47 08 00 00 00
[  203.909218] RSP: 0018:ffff9198801f8e70 EFLAGS: 00010282
[  203.909266] RAX: 0000000000000000 RBX: ffff88b7b5100600 RCX: 0000000000000000
[  203.909315] RDX: ffff88b7b6be1900 RSI: ffff88b7b6bd1aa8 RDI: 0000000000000300
[  203.909365] RBP: ffff88b7b59a439c R08: ffff88b7b6bd1aa8 R09: 0000000000000004
[  203.909414] R10: 0000000000000774 R11: 0000000000000000 R12: ffff88b7b59a43b8
[  203.909463] R13: 0000000000000000 R14: ffff88b7b59a4000 R15: ffff88b7b5100680
[  203.909513] FS:  0000000000000000(0000) GS:ffff88b7b6bc0000(0000) knlGS:0000000000000000
[  203.909565] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  203.909612] CR2: 00007f7f2310d020 CR3: 0000000232fc4000 CR4: 00000000000406e0
[  203.909673] Call Trace:
[  203.909730]  <IRQ>
[  203.909789]  ? qdisc_put_unlocked+0x30/0x30
[  203.909850]  ? qdisc_put_unlocked+0x30/0x30
[  203.909910]  call_timer_fn+0x32/0x170
[  203.909969]  run_timer_softirq+0x195/0x4f0
[  203.910029]  ? tick_sched_do_timer+0x60/0x60
[  203.910088]  ? tick_sched_timer+0x45/0x90
[  203.910147]  ? __hrtimer_run_queues+0x11c/0x2f0
[  203.910209]  __do_softirq+0xe4/0x319
[  203.910269]  irq_exit+0xa5/0xb0
[  203.910327]  smp_apic_timer_interrupt+0x78/0x170
[  203.910388]  apic_timer_interrupt+0xf/0x20
[  203.911558]  </IRQ>
[  203.911616] RIP: 0010:cpuidle_enter_state+0xbf/0x480
[  203.911676] Code: 85 c0 0f 8f fe 02 00 00 31 ff e8 0c 4c b6 ff 45 84 f6 74 12 9c 58 f6 c4 02 0f 85 95 03 00 00 31 ff e8 95 96 bb ff fb 45 85 e4 <0f> 88 82 01 00 00 49 63 cc 4d 29 fd 48 8d 04 49 48 c1 e0 05 8b 74
[  203.911781] RSP: 0018:ffff9198800bbe70 EFLAGS: 00000202 ORIG_RAX: ffffffffffffff13
[  203.911845] RAX: ffff88b7b6be4080 RBX: ffffffffab09b460 RCX: 000000000000001f
[  203.911907] RDX: 0000000000000000 RSI: 000000001fc92d00 RDI: 0000000000000000
[  203.911969] RBP: ffff88b7b0103800 R08: 0000002f79e6984e R09: 00000000000f930c
[  203.912031] R10: ffff88b7b6be31a0 R11: ffff88b7b6be3180 R12: 0000000000000002
[  203.912093] R13: 0000002f79e6984e R14: 0000000000000000 R15: 0000002f740057dd
[  203.912161]  cpuidle_enter+0x37/0x60
[  203.912220]  do_idle+0x1ce/0x270
[  203.912278]  cpu_startup_entry+0x19/0x20
[  203.912337]  start_secondary+0x14d/0x180
[  203.912397]  secondary_startup_64+0xa4/0xb0
[  203.912457] ---[ end trace 1c807a8b2eb1f6b6 ]---


-- 
Alan J. Wylie                                          https://www.wylie.me.uk/

Dance like no-one's watching. / Encrypt like everyone is.
Security is inversely proportional to convenience
