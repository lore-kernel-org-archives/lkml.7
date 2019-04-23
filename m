Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22844C10F03
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:58:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E72A120674
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 14:58:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728339AbfDWO57 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 10:57:59 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:53048 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727180AbfDWO57 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 10:57:59 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 028106232E58A0112775;
        Tue, 23 Apr 2019 22:57:56 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Tue, 23 Apr 2019
 22:57:48 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <dmitry.torokhov@gmail.com>, <sudip@vectorindia.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-input@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] Input: walkera0701 - Fix possible NULL pointer dereference in walkera0701_detach
Date:   Tue, 23 Apr 2019 22:56:37 +0800
Message-ID: <20190423145637.35004-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

KASAN report this:

walkera0701: failed to allocate input device
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] SMP KASAN PTI
CPU: 1 PID: 5324 Comm: syz-executor.0 Tainted: G         C        5.1.0-rc3+ #8
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
RIP: 0010:input_unregister_device+0x21/0xe0 drivers/input/input.c:2192
Code: 2e 0f 1f 84 00 00 00 00 00 53 48 89 fb e8 07 41 f6 fe 48 8d bb 20 07 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04 02 84 c0 74 08 84 c0 0f 8e 92 00 00 00 80 bb 20 07 00 00
RSP: 0018:ffff8881f58dfd30 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff82460ca9
RDX: 00000000000000e4 RSI: ffffc900013d3000 RDI: 0000000000000720
RBP: 0000000000000000 R08: ffffed103d30caf7 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: dffffc0000000000
R13: ffffffffc1633000 R14: ffffffffc086b320 R15: 1ffff1103eb1bfaf
FS:  00007fa407200700(0000) GS:ffff8881f7300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b33924000 CR3: 00000001e270c006 CR4: 00000000007606e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 walkera0701_detach+0x8e/0xba [walkera0701]
 port_detach+0x73/0x90 [parport]
 bus_for_each_dev+0x154/0x1e0 drivers/base/bus.c:304
 parport_unregister_driver+0x1f8/0x270 [parport]
 __do_sys_delete_module kernel/module.c:1018 [inline]
 __se_sys_delete_module kernel/module.c:961 [inline]
 __x64_sys_delete_module+0x30c/0x480 kernel/module.c:961
 do_syscall_64+0x9f/0x450 arch/x86/entry/common.c:290
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x462e99
Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa4071ffc58 EFLAGS: 00000246 ORIG_RAX: 00000000000000b0
RAX: ffffffffffffffda RBX: 000000000073bf00 RCX: 0000000000462e99
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000200001c0
RBP: 0000000000000002 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fa4072006bc
R13: 00000000004bcca9 R14: 00000000006f6b48 R15: 00000000ffffffff
Modules linked in: walkera0701(-) tps65090_regulator intel_th mptbase adm1031 snd_soc_wm8753 snd_soc_core snd_pcm_dmaengine snd_pcm ac97_bus snd_compress rtc_ds1286 snd_seq_dummy snd_seq snd_timer snd_seq_device snd soundcore comedi(C) i2c_mux_ltc4306 i2c_mux max14577_regulator max14577 usbcore hid cmac mc13783_regulator mc13xxx_regulator_core mc13xxx_core of_mdio fixed_phy libphy iptable_security iptable_raw iptable_mangle iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_filter bpfilter ip6_vti ip_vti ip_gre ipip sit tunnel4 ip_tunnel hsr veth netdevsim vxcan batman_adv cfg80211 rfkill chnl_net caif nlmon dummy team bonding vcan bridge stp llc ip6_gre gre ip6_tunnel tunnel6 tun joydev mousedev ppdev tpm kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel ide_pci_generic aesni_intel aes_x86_64 piix crypto_simd cryptd input_leds ide_core psmouse glue_helper intel_agp serio_raw intel_gtt ata_generic agpgart i2c_piix4
 pata_acpi parport_pc parport floppy rtc_cmos sch_fq_codel ip_tables x_tables sha1_ssse3 sha1_generic ipv6 [last unloaded: walkera0701]
Dumping ftrace buffer:
   (ftrace buffer empty)
---[ end trace 17f6dd401f34af3e ]---

In walkera0701_attach(), if input_allocate_device failed,
w->input_dev is set to NULL. But in walkera0701_detach it
is not checked while passing to input_unregister_device(),
this will trigger a NULL pointer dereference issue.

There is also another possible use-after-free issue, when
input_register_device() fails, input_free_device be
called to free input dev, then in walkera0701_detach()
calling input_unregister_device will trigger use-after-free
while accessing input dev

This patch set w->parport to NULL on walkera0701_attach failed,
and only do detach in case attach success.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 221bcb24c653 ("Input: walkera0701 - use parallel port device model")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/input/joystick/walkera0701.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/input/joystick/walkera0701.c b/drivers/input/joystick/walkera0701.c
index dce313d..852b8c5 100644
--- a/drivers/input/joystick/walkera0701.c
+++ b/drivers/input/joystick/walkera0701.c
@@ -207,13 +207,13 @@ static void walkera0701_attach(struct parport *pp)
 
 	if (pp->number != walkera0701_pp_no) {
 		pr_debug("Not using parport%d.\n", pp->number);
-		return;
+		goto err_out;
 	}
 
 	if (pp->irq == -1) {
 		pr_err("parport %d does not have interrupt assigned\n",
 			pp->number);
-		return;
+		goto err_out;
 	}
 
 	w->parport = pp;
@@ -228,7 +228,7 @@ static void walkera0701_attach(struct parport *pp)
 
 	if (!w->pardevice) {
 		pr_err("failed to register parport device\n");
-		return;
+		goto err_out;
 	}
 
 	if (parport_negotiate(w->pardevice->port, IEEE1284_MODE_COMPAT)) {
@@ -279,13 +279,15 @@ static void walkera0701_attach(struct parport *pp)
 	input_free_device(w->input_dev);
 err_unregister_device:
 	parport_unregister_device(w->pardevice);
+err_out:
+	w->parport = NULL;
 }
 
 static void walkera0701_detach(struct parport *port)
 {
 	struct walkera_dev *w = &w_dev;
 
-	if (!w->pardevice || w->parport->number != port->number)
+	if (!w->parport)
 		return;
 
 	input_unregister_device(w->input_dev);
-- 
2.7.0


