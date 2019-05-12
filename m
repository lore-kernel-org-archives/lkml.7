Return-Path: <SRS0=t4ha=TM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 503B1C04AB4
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 19:34:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CD132084A
	for <linux-kernel@archiver.kernel.org>; Sun, 12 May 2019 19:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727037AbfELTcF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 May 2019 15:32:05 -0400
Received: from torres.zugschlus.de ([85.214.131.164]:45216 "EHLO
        torres.zugschlus.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbfELTcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 May 2019 15:32:04 -0400
Received: from mh by torres.zugschlus.de with local (Exim 4.92)
        (envelope-from <mh+linux-kernel@zugschlus.de>)
        id 1hPuCZ-0004eL-IH
        for linux-kernel@vger.kernel.org; Sun, 12 May 2019 21:32:03 +0200
Date:   Sun, 12 May 2019 21:32:03 +0200
From:   Marc Haber <mh+linux-kernel@zugschlus.de>
To:     linux-kernel@vger.kernel.org
Subject: Linux 5.1 on APU runs in circles with Call Traces
Message-ID: <20190512193203.GA1402@torres.zugschlus.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I regret to inform you that I have now the third crippling issue in
Linux 5.1, with the fourth one in the process of being isolated.

This time, it's a PC Engines APU2 running in circles right after
booting:
May 12 20:56:01 prom kernel: CPU: 2 PID: 657 Comm: kworker/2:2 Tainted: G        W         5.1.1-zgsrv20080 #5.1.1.20190511.0
May 12 20:56:01 prom kernel: Hardware name: PC Engines apu2/apu2, BIOS 88a4f96 03/11/2016
May 12 20:56:01 prom kernel: Workqueue: events_freezable input_polled_device_work [input_polldev]
May 12 20:56:01 prom kernel: RIP: 0010:gpio_keys_polled_check_state.isra.1+0xa/0x60 [gpio_keys_polled]
May 12 20:56:01 prom kernel: Code: 48 8b 17 48 8b 42 10 48 8b 40 20 48 85 c0 74 09 48 8b 7a 08 e9 f7 fa 6e e1 c3 66 0f 1f 44 00 00 41 54 55 48 89 cd 53 48 89 d3 <0f> 0b 8b 46 18 85 c0 74 20 8d 50 fe 83 fa 01 77 1d 8b 03 85 c0 74
May 12 20:56:01 prom kernel: RSP: 0018:ffffc9000081fe20 EFLAGS: 00010286
May 12 20:56:01 prom kernel: RAX: 0000000000000000 RBX: ffff888117ca6548 RCX: ffff888117ca654c
May 12 20:56:01 prom kernel: RDX: ffff888117ca6548 RSI: ffffffffa03e9040 RDI: ffff888116043000
May 12 20:56:01 prom kernel: RBP: ffff888117ca654c R08: 0000000000000010 R09: 0000000000000000
May 12 20:56:01 prom kernel: R10: 8080808080808080 R11: 0000000000000018 R12: ffff888117ca6538
May 12 20:56:01 prom kernel: R13: 0000000000000001 R14: ffff888117ca6530 R15: ffff8881161ece40
May 12 20:56:01 prom kernel: FS:  0000000000000000(0000) GS:ffff88811ab00000(0000) knlGS:0000000000000000
May 12 20:56:01 prom kernel: CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
May 12 20:56:01 prom kernel: CR2: 000055572f98a251 CR3: 0000000117dd6000 CR4: 00000000000406e0
May 12 20:56:01 prom kernel: Call Trace:
May 12 20:56:01 prom kernel: gpio_keys_polled_poll+0xd0/0x240 [gpio_keys_polled]
May 12 20:56:01 prom kernel: ? __switch_to+0x171/0x410
May 12 20:56:01 prom kernel: ? finish_task_switch+0x6f/0x260
May 12 20:56:01 prom kernel: input_polled_device_work+0x11/0x20 [input_polldev]
May 12 20:56:01 prom kernel: process_one_work+0x171/0x300
May 12 20:56:01 prom kernel: worker_thread+0x2b/0x370
May 12 20:56:01 prom kernel: ? process_one_work+0x300/0x300
May 12 20:56:01 prom kernel: kthread+0x108/0x120
May 12 20:56:01 prom kernel: ? kthread_park+0x80/0x80
May 12 20:56:01 prom kernel: ret_from_fork+0x22/0x40
May 12 20:56:01 prom kernel: ---[ end trace 72a086f2949e1d45 ]---
May 12 20:56:01 prom kernel: leds-gpio leds-gpio: Skipping unavailable LED gpio 0 (apu:green:1)
May 12 20:56:01 prom kernel: leds-gpio leds-gpio: Skipping unavailable LED gpio 0 (apu:green:2)
May 12 20:56:01 prom kernel: leds-gpio leds-gpio: Skipping unavailable LED gpio 0 (apu:green:3)
May 12 20:56:01 prom kernel: WARNING: CPU: 2 PID: 657 at include/linux/gpio/consumer.h:421 gpio_keys_polled_check_state.isr
a.1+0xa/0x60 [gpio_keys_polled]
May 12 20:56:01 prom kernel: Modules linked in: 8021q crct10dif_pclmul(+) crc32_pclmul leds_gpio ghash_clmulni_intel pcengi
nes_apuv2 gpio_keys_polled aesni_intel input_polldev aes_x86_64 crypto_simd cryptd glue_helper fam15h_power k10temp input_l
eds sp5100_tco led_class sg ccp pcc_cpufreq acpi_cpufreq bridge stp llc ip_tables x_tables autofs4 ext4 mbcache usbhid jbd2
 dm_mod usb_storage sd_mod ehci_pci ehci_hcd xhci_pci xhci_hcd ahci crc32c_intel libahci igb i2c_algo_bit usbcore i2c_piix4
 ptp libata i2c_core usb_common pps_core hwmon

This thing repeats indefinetely at the speed the serial console is able
to print. Going back to 5.0.13 immediately fixes this.

Any idea short of bisecting? I am sorry, but I am running out of time
for kernel debugging this month.

Greetings
Marc

-- 
-----------------------------------------------------------------------------
Marc Haber         | "I don't trust Computers. They | Mailadresse im Header
Leimen, Germany    |  lose things."    Winona Ryder | Fon: *49 6224 1600402
Nordisch by Nature |  How to make an American Quilt | Fax: *49 6224 1600421
