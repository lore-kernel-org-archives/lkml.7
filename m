Return-Path: <SRS0=avfD=SQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.6 required=3.0 tests=FORGED_MUA_MOZILLA,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99111C10F13
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 22:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4FD3B204FD
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Apr 2019 22:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726111AbfDNWYA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Apr 2019 18:24:00 -0400
Received: from [195.159.176.226] ([195.159.176.226]:47978 "EHLO
        blaine.gmane.org" rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S1725497AbfDNWX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Apr 2019 18:23:59 -0400
Received: from list by blaine.gmane.org with local (Exim 4.89)
        (envelope-from <glk-linux-kernel-4@m.gmane.org>)
        id 1hFnXX-0009xc-1U
        for linux-kernel@vger.kernel.org; Mon, 15 Apr 2019 00:23:55 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-kernel@vger.kernel.org
From:   "U.Mutlu" <for-gmane@mutluit.com>
Subject: BUG: Internal error: Oops: 17 [#1] SMP / _raw_spin_lock()
Date:   Mon, 15 Apr 2019 00:23:44 +0200
Organization: mutluit.com
Message-ID: <q90bth$14kj$1@blaine.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:40.0) Gecko/20100101
 Firefox/40.0 SeaMonkey/2.37a1
X-Mozilla-News-Host: news://news.gmane.org:119
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

while issuing the command "dd if=/dev/zero of=test2 bs=8k count=64k conv=sync"
in /tmp3 on the rootfs (/dev/sda1; a SSD drive), the system
sometime crashes (maybe in 5% of the cases)

The device is a Banana Pi using Allwinner A20 SoC (sunxi/sun7i/ARM),
the kernel in use is the stock 5.0.5 kernel w/o any modifications, but 
compiled by myself.

Could a kind kernel developer/tester please briefly check the following
serial output whether the bug is in the SATA driver (ahci-sunxi[1c18000.sata]) 
or is it perhaps a kernel bug?
That driver is linked into the kernel. A coredump was not generated.

I'm new to kernel debugging. Is this a problem with _raw_spin_lock()
(--> https://lwn.net/Articles/14473/ ), or a NULL pointer issue?


Here's the serial debug output, interrupt list and iomem list:

[  262.990731] random: crng init done
[  262.994158] random: 7 urandom warning(s) missed due to ratelimiting
[  263.720319] Unable to handle kernel NULL pointer dereference at virtual 
address 00000000
[  263.728442] pgd = aaea8072
[  263.731161] [00000000] *pgd=7f213835
[  263.734762] Internal error: Oops: 17 [#1] SMP THUMB2
[  263.739730] Modules linked in: b53_mdio b53_common dsa_core phylink devlink 
bridge nvmem_sunxi_sid sun4i_ts input_leds sun4i_ss cpufreq_dt uio_pdrv_genirq 
uio evdev
[  263.754491] CPU: 1 PID: 568 Comm: dd Not tainted 5.0.5-my11 #1
[  263.760327] Hardware name: Allwinner sun7i (A20) Family
[  263.765582] PC is at _raw_spin_lock+0x4/0x30
[  263.769869] LR is at __queue_work+0x133/0x2c8
[  263.774234] pc : [<c0770314>]    lr : [<c01288c7>]    psr: 000701b3
[  263.780506] sp : ee27fad0  ip : c0c10748  fp : ef10ab00
[  263.785736] r10: c0b51324  r9 : ee27e000  r8 : c0c6fcf8
[  263.790970] r7 : ef6b2f80  r6 : 00000004  r5 : ee5ac840  r4 : ef6b7b00
[  263.797503] r3 : 000012c1  r2 : 000012c0  r1 : 00000000  r0 : 00000000
[  263.804039] Flags: nzcv  IRQs off  FIQs on  Mode SVC_32  ISA Thumb  Segment 
none
[  263.811442] Control: 50c5387d  Table: 6e29c06a  DAC: 00000051
[  263.817196] Process dd (pid: 568, stack limit = 0xe5362e05)
[  263.822776] Stack: (0xee27fad0 to 0xee280000)
[  263.827150] fac0:                                     03024100 c056a955 
00000001 00000014
[  263.835345] fae0: ee27fad0 c0b51324 00000001 00000000 ee5ac840 00000004 
ef10ab00 00000000
[  263.843540] fb00: 00000000 ee27fbe0 c0c03080 c0129e2d 20070113 c0c08d48 
c0ca6cc8 ee5ac840
[  263.851736] fb20: 00000001 eeba0588 eeba09d4 c049c67f 33333335 ee5ac800 
00000001 c04a33fb
[  263.859930] fb40: eeba0588 00000000 00000000 00000000 eeba0588 c04a3497 
ee5ceb00 00000000
[  263.868125] fb60: eead8800 c056b6bf 00000000 ffffffe1 ee5cebb8 ee5ceb00 
00000000 00000000
[  263.876322] fb80: 00000100 c056b7d5 ee5cebb8 00100000 ee4ef418 ef05d800 
ee27e000 c0c08d48
[  263.884498] fba0: ee27fbe0 ee27fbc4 ee5ceb38 00000004 c0c03090 ee27e000 
00000100 c04a1b2b
[  263.892666] fbc0: ee27fc00 ee27fbc4 ee27fbc4 c0c08d48 00000025 40000004 
00000000 c0102263
[  263.900835] fbe0: 00000001 ef134a00 ef134a64 c0c03080 c0b51380 0000000a 
c0b58d40 c0b58d40
[  263.909003] fc00: c0b51310 fffff1d4 c0c03d00 00440000 c0c091f0 c0b58cfc 
00000000 00000000
[  263.917171] fc20: 00000001 ef00c000 f0803000 efb8fc74 00000000 c011c17b 
0000008a c01506c7
[  263.925340] fc40: 00000048 c0c091f0 ee27fc78 f080200c f0802000 c04f7c15 
ecac9a00 c01efaca
[  263.933509] fc60: 00070033 ffffffff ee27fcac 0000c39e ee27e000 c0101a65 
0000c39f ee27fcc8
[  263.941677] fc80: ef6b6b84 ef6b6b80 ef003a80 ecac99c0 00708840 2eb5a000 
0000c39e ffffffff
[  263.949846] fca0: efb8fc74 00000000 a0070013 ee27fcc8 ecac9a00 c01efaca 
00070033 ffffffff
[  263.958014] fcc0: 00000051 bf000000 00000000 00000000 00001000 00700840 
ffffffff c0224429
[  263.966182] fce0: 00000000 c02244f3 00000000 ef058800 ef058800 efb8fc74 
00000000 efb8fc74
[  263.974350] fd00: ed482330 00001000 00000000 ed48242c 00001000 c02245c9 
00000000 00000000
[  263.982518] fd20: efb8fc74 c026f839 00000000 c0c08d48 00000000 eed430a0 
ee5ba000 c0270899
[  263.990686] fd40: ed482330 00001000 c0ca02ac ed48242c 00001000 c02981d3 
00600040 ee5b9400
[  263.998854] fd60: 00000001 00000c12 00000002 c0c08d48 00000000 efb8fc74 
00000000 eed430a0
[  264.007022] fd80: ed482330 176ca000 00000000 ed48242c 00001000 c0275787 
00001000 c0270899
[  264.015190] fda0: efb8fc50 00000000 176cb000 00000000 ee27fe0c 000176ca 
00000000 c0c08d48
[  264.023358] fdc0: 0656d5cd ee27fef8 ed48242c ee1fb480 c02756ad 00000000 
c081276c 00001000
[  264.031526] fde0: 00001000 c01b8941 00001000 00000000 ee27fe0c ee27fe10 
176ca000 00000000
[  264.039695] fe00: 00000000 ee27e000 5cb39559 00000000 00000000 c0c08d48 
ef39db80 00000000
[  264.047863] fe20: ee27ff10 00000000 ed48242c ed482330 00000000 ee1fb480 
ee27fef8 c01b9959
[  264.056031] fe40: ed482330 00000000 00000004 c01b65ff ee27fe58 c0b59180 
00002000 ee27ff10
[  264.064200] fe60: ed482330 ee27fef8 ed4823b0 ed482330 00000000 00002000 
00000000 c0267475
[  264.072368] fe80: 00000000 c0760167 00001000 c04bdc43 ee5cd380 00000000 
c01032b5 00000000
[  264.080536] fea0: ffffffff c0c08d48 ffffffff ee27fef0 00001000 ee27e000 
00000000 c0c08d48
[  264.088704] fec0: 00002000 ee1fb480 00002000 ee27ff78 00080000 176ca000 
00000000 00000004
[  264.096873] fee0: 00000400 c01fee0d 00002000 00002000 0002c000 00002000 
00000001 00000000
[  264.105042] ff00: 00002000 ee27fef0 00000001 00000000 ee1fb480 00000000 
176ca000 00000000
[  264.113210] ff20: 00000000 ee27fe9c 00000000 00000000 00002000 c0c08d48 
0002c000 00002000
[  264.121378] ff40: ee1fb480 00000000 0002c000 ee27ff78 00002000 c01fef8d 
ee2b6780 0002c000
[  264.129546] ff60: ee1fb480 0002c000 176ca000 00000000 ee1fb480 c01ff14b 
176ca000 00000000
[  264.137715] ff80: ee27ffb0 c0c08d48 f0802000 00000000 0002a1f0 00002000 
00000004 c0101224
[  264.145883] ffa0: ee27e000 c0101001 00000000 0002a1f0 00000001 0002c000 
00002000 620ec300
[  264.154050] ffc0: 00000000 0002a1f0 00002000 00000004 0002c000 00000000 
00000001 00000400
[  264.162218] ffe0: 00000000 bec734e4 00013bb9 b6f3ef26 60070030 00000001 
00000000 00000000
[  264.170399] [<c0770314>] (_raw_spin_lock) from [<c01288c7>] 
(__queue_work+0x133/0x2c8)
[  264.178314] [<c01288c7>] (__queue_work) from [<c0129e2d>] 
(mod_delayed_work_on+0x41/0x68)
[  264.186490] [<c0129e2d>] (mod_delayed_work_on) from [<c049c67f>] 
(kblockd_mod_delayed_work_on+0x17/0x18)
[  264.195964] [<c049c67f>] (kblockd_mod_delayed_work_on) from [<c04a33fb>] 
(blk_mq_run_hw_queue+0x37/0xb4)
[  264.205436] [<c04a33fb>] (blk_mq_run_hw_queue) from [<c04a3497>] 
(blk_mq_run_hw_queues+0x1f/0x2c)
[  264.214304] [<c04a3497>] (blk_mq_run_hw_queues) from [<c056b6bf>] 
(scsi_end_request+0xe7/0x158)
[  264.222997] [<c056b6bf>] (scsi_end_request) from [<c056b7d5>] 
(scsi_io_completion+0x4d/0x4fc)
[  264.231515] [<c056b7d5>] (scsi_io_completion) from [<c04a1b2b>] 
(blk_done_softirq+0x5b/0x78)
[  264.239947] [<c04a1b2b>] (blk_done_softirq) from [<c0102263>] 
(__do_softirq+0xcb/0x1d0)
[  264.247948] [<c0102263>] (__do_softirq) from [<c011c17b>] (irq_exit+0x87/0xb8)
[  264.255170] [<c011c17b>] (irq_exit) from [<c01506c7>] 
(__handle_domain_irq+0x3f/0x78)
[  264.262997] [<c01506c7>] (__handle_domain_irq) from [<c04f7c15>] 
(gic_handle_irq+0x35/0x68)
[  264.271340] [<c04f7c15>] (gic_handle_irq) from [<c0101a65>] 
(__irq_svc+0x65/0x94)
[  264.278810] Exception stack(0xee27fc78 to 0xee27fcc0)
[  264.283855] fc60: 
0000c39f ee27fcc8
[  264.292022] fc80: ef6b6b84 ef6b6b80 ef003a80 ecac99c0 00708840 2eb5a000 
0000c39e ffffffff
[  264.300190] fca0: efb8fc74 00000000 a0070013 ee27fcc8 ecac9a00 c01efaca 
00070033 ffffffff
[  264.308364] [<c0101a65>] (__irq_svc) from [<c01efaca>] 
(kmem_cache_alloc+0x92/0xfc)
[  264.316017] [<c01efaca>] (kmem_cache_alloc) from [<c0224429>] 
(alloc_buffer_head+0x15/0x38)
[  264.324360] [<c0224429>] (alloc_buffer_head) from [<c02244f3>] 
(alloc_page_buffers+0x6f/0x138)
[  264.332963] [<c02244f3>] (alloc_page_buffers) from [<c02245c9>] 
(create_empty_buffers+0xd/0xf8)
[  264.341656] [<c02245c9>] (create_empty_buffers) from [<c026f839>] 
(ext4_block_write_begin+0x271/0x348)
[  264.350958] [<c026f839>] (ext4_block_write_begin) from [<c0275787>] 
(ext4_da_write_begin+0xdb/0x2c8)
[  264.360083] [<c0275787>] (ext4_da_write_begin) from [<c01b8941>] 
(generic_perform_write+0x85/0x148)
[  264.369121] [<c01b8941>] (generic_perform_write) from [<c01b9959>] 
(__generic_file_write_iter+0xf1/0x158)
[  264.378680] [<c01b9959>] (__generic_file_write_iter) from [<c0267475>] 
(ext4_file_write_iter+0x99/0x378)
[  264.388153] [<c0267475>] (ext4_file_write_iter) from [<c01fee0d>] 
(__vfs_write+0xd9/0x110)
[  264.396411] [<c01fee0d>] (__vfs_write) from [<c01fef8d>] (vfs_write+0x71/0x13c)
[  264.403713] [<c01fef8d>] (vfs_write) from [<c01ff14b>] (ksys_write+0x3b/0x84)
[  264.410842] [<c01ff14b>] (ksys_write) from [<c0101001>] 
(ret_fast_syscall+0x1/0x62)
[  264.418486] Exception stack(0xee27ffa8 to 0xee27fff0)
[  264.423533] ffa0:                   00000000 0002a1f0 00000001 0002c000 
00002000 620ec300
[  264.431700] ffc0: 00000000 0002a1f0 00002000 00000004 0002c000 00000000 
00000001 00000400
[  264.439864] ffe0: 00000000 bec734e4 00013bb9 b6f3ef26
[  264.444914] Code: 0000 0000 f8b0 f000 (e850) 3f00
[  264.449702] ---[ end trace d5d1098913ee9dc7 ]---
[  264.454313] Kernel panic - not syncing: Fatal exception in interrupt
[  264.460665] CPU0: stopping
[  264.463378] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G      D 
5.0.5-my11 #1
[  264.471021] Hardware name: Allwinner sun7i (A20) Family
[  264.476253] [<c010bb39>] (unwind_backtrace) from [<c0109253>] 
(show_stack+0xb/0xc)
[  264.483820] [<c0109253>] (show_stack) from [<c075cf0f>] (dump_stack+0x67/0x74)
[  264.491038] [<c075cf0f>] (dump_stack) from [<c010ae1b>] 
(handle_IPI+0x13b/0x164)
[  264.498428] [<c010ae1b>] (handle_IPI) from [<c04f7c47>] 
(gic_handle_irq+0x67/0x68)
[  264.505991] [<c04f7c47>] (gic_handle_irq) from [<c0101a65>] 
(__irq_svc+0x65/0x94)
[  264.513461] Exception stack(0xc0c01f18 to 0xc0c01f60)
[  264.518505] 1f00: 
00000000 0000d938
[  264.526673] 1f20: ef6a39e0 c0113fc1 c0c00000 00000000 c0c08d70 c0c08db0 
c0b58470 00000000
[  264.534841] 1f40: c0c01f70 00000000 005f2f58 c0c01f68 c01070f5 c01070f6 
40070033 ffffffff
[  264.543012] [<c0101a65>] (__irq_svc) from [<c01070f6>] 
(arch_cpu_idle+0x22/0x24)
[  264.550406] [<c01070f6>] (arch_cpu_idle) from [<c0137029>] 
(do_idle+0x195/0x1dc)
[  264.557798] [<c0137029>] (do_idle) from [<c013725b>] 
(cpu_startup_entry+0x13/0x18)
[  264.565363] [<c013725b>] (cpu_startup_entry) from [<c0b00a65>] 
(start_kernel+0x345/0x364)
[  264.573535] Rebooting in 10 seconds..


# cat /proc/interrupts
            CPU0       CPU1
  18:          0          0     GICv2  29 Level     arch_timer
  19:      26533      28068     GICv2  30 Level     arch_timer
  22:          0          0     GICv2  54 Level     timer@1c20c00
  23:          0          0     GICv2 113 Level     sun5i_timer0
  24:          0          0     GICv2 152 Level     arm-pmu
  25:          0          0     GICv2 153 Level     arm-pmu
  26:          0          0     GICv2  59 Level     1c02000.dma-controller
  27:          0          0     GICv2  42 Level     sun4i-spi
  31:        158          0     GICv2  64 Level     sunxi-mmc
  32:          0          0     GICv2  70 Level     musb-hdrc.1.auto
  33:          2          0     GICv2  71 Level     ehci_hcd:usb1
  34:         34          0     GICv2  96 Level     ohci_hcd:usb3
  37:       3656          0     GICv2  88 Level     ahci-sunxi[1c18000.sata]
  38:         19          0     GICv2  72 Level     ehci_hcd:usb2
  41:          0          0     GICv2  56 Level     1c20d00.rtc
  47:       2294          0     GICv2  61 Level     sun4i-ts
  48:        348          0     GICv2  33 Level     ttyS0
  51:       1832          0     GICv2  39 Level     mv64xxx_i2c
  52:          0          0     GICv2  41 Level     mv64xxx_i2c
  60:       2632          0     GICv2 117 Level     eth0
  70:          1          0  sunxi_pio_edge   4 Edge      usb0-id-det
  76:          0          0  sunxi_pio_edge  10 Edge      1c0f000.mmc cd
  98:          0          0  sunxi-nmi   0 Level     axp20x_irq_chip
104:          0          0  axp20x_irq_chip   5 Edge      axp20x-usb-power-supply
105:          0          0  axp20x_irq_chip   6 Edge      axp20x-usb-power-supply
125:          0          0  axp20x_irq_chip  26 Edge      axp20x-usb-power-supply
126:          0          0  axp20x_irq_chip  27 Edge      axp20x-usb-power-supply
132:          0          0  axp20x_irq_chip  33 Edge      axp20x-pek-dbr
133:          0          0  axp20x_irq_chip  34 Edge      axp20x-pek-dbf
IPI0:          0          0  CPU wakeup interrupts
IPI1:          0          0  Timer broadcast interrupts
IPI2:       2965       8365  Rescheduling interrupts
IPI3:          2          5  Function call interrupts
IPI4:          0          0  CPU stop interrupts
IPI5:      20161      21560  IRQ work interrupts
IPI6:          0          0  completion interrupts
Err:          0


# cat /proc/iomem
01c00000-01c0002f : system-control@1c00000
01c00030-01c0003b : interrupt-controller@1c00030
01c02000-01c02fff : dma-controller@1c02000
01c05000-01c05fff : spi@1c05000
01c0f000-01c0ffff : mmc@1c0f000
01c13000-01c133ff : usb@1c13000
   01c13000-01c133ff : usb@1c13000
01c13400-01c1340f : phy_ctrl
01c14000-01c140ff : usb@1c14000
01c14400-01c144ff : usb@1c14400
01c14800-01c14803 : pmu1
01c15000-01c15fff : crypto-engine@1c15000
01c18000-01c18fff : sata@1c18000
01c1c000-01c1c0ff : usb@1c1c000
01c1c800-01c1c803 : pmu2
01c20000-01c203ff : clock@1c20000
01c20800-01c20bff : pinctrl@1c20800
01c20c90-01c20c9f : watchdog@1c20c90
01c20d00-01c20d1f : rtc@1c20d00
01c23800-01c239ff : eeprom@1c23800
01c25000-01c250ff : rtp@1c25000
01c28000-01c2801f : serial
01c28c00-01c28c1f : serial
01c29c00-01c29c1f : serial
01c2ac00-01c2afff : i2c@1c2ac00
01c2b400-01c2b7ff : i2c@1c2b400
01c50000-01c5ffff : ethernet@1c50000
01c60000-01c60fff : hstimer@1c60000
40000000-7fafffff : System RAM
   40008000-40afffff : Kernel code
   40c00000-40cb5a8f : Kernel data



