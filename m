Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB2DC10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:37:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6631420818
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 14:37:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727199AbfDHOhb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 10:37:31 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:37760 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726806AbfDHOhb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 10:37:31 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id A9C373A24A1CB72BAFA4;
        Mon,  8 Apr 2019 22:37:28 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.408.0; Mon, 8 Apr 2019
 22:37:20 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <gregkh@linuxfoundation.org>, <rubini@gnudd.co>,
        <federico.vaga@cern.ch>, <riehecky@fnal.gov>
CC:     <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] fmc: Fix possible NULL pointer dereference
Date:   Mon, 8 Apr 2019 22:37:01 +0800
Message-ID: <20190408143701.15372-1-yuehaibing@huawei.com>
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

Syzkaller report this:

kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] SMP KASAN PTI
CPU: 0 PID: 3692 Comm: syz-executor.0 Tainted: G         C        5.0.0+ #5
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
RIP: 0010:ff_dev_create+0xf7/0x2e0 [fmc_fakedev]
Code: 00 e8 4d 2d a7 f6 ba c0 0c 00 00 48 c7 c7 00 20 15 c1 be e8 04 00 00 e8 e7 8e c7 f6 48 8d b8 a8 04 00 00 48 89 fa 48 c1 ea 03 <80> 3c 1a 00 0f 85 90 01 00 00 48 8d 78 50 4c 89 b0 a8 04 00 00 48
RSP: 0018:ffff8881ea7a78e8 EFLAGS: 00010206
RAX: 0000000000000000 RBX: dffffc0000000000 RCX: ffffffff815c9540
RDX: 0000000000000095 RSI: ffffc900013ec000 RDI: 00000000000004a8
RBP: 0000000000000000 R08: ffffed103ee458b8 R09: ffffed103ee458b8
R10: 0000000000000001 R11: ffffed103ee458b7 R12: ffff8881e4865d80
R13: dffffc0000000000 R14: ffff8881e4865da0 R15: ffffffffc115b0b0
FS:  00007fb08a226700(0000) GS:ffff8881f7200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6bd5a37890 CR3: 00000001c5632006 CR4: 00000000007606f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 ff_init+0x10b/0x3a0 [fmc_fakedev]
 do_one_initcall+0xbc/0x47d init/main.c:887
 do_init_module+0x1b5/0x547 kernel/module.c:3456
 load_module+0x6405/0x8c10 kernel/module.c:3804
 __do_sys_finit_module+0x162/0x190 kernel/module.c:3898
 do_syscall_64+0x9f/0x450 arch/x86/entry/common.c:290
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x462e99
Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fb08a225c58 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
RAX: ffffffffffffffda RBX: 000000000073bf00 RCX: 0000000000462e99
RDX: 0000000000000000 RSI: 0000000020000100 RDI: 0000000000000003
RBP: 00007fb08a225c70 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fb08a2266bc
R13: 00000000004bcefa R14: 00000000006f6fb0 R15: 0000000000000004
Modules linked in: fmc_fakedev(+) fmc iptable_security iptable_raw iptable_mangle iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_filter bpfilter ip6_vti ip_vti ip_gre ipip sit tunnel4 ip_tunnel hsr veth netdevsim vxcan batman_adv cfg80211 rfkill chnl_net caif nlmon dummy team bonding vcan bridge stp llc ip6_gre gre ip6_tunnel tunnel6 tun joydev mousedev ppdev tpm kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel aesni_intel ide_pci_generic piix aes_x86_64 crypto_simd cryptd ide_core psmouse glue_helper input_leds intel_agp serio_raw intel_gtt i2c_piix4 ata_generic agpgart pata_acpi rtc_cmos parport_pc floppy parport sch_fq_codel ip_tables x_tables sha1_ssse3 sha1_generic ipv6 [last unloaded: lib80211]
Dumping ftrace buffer:
   (ftrace buffer empty)
---[ end trace 297e0e50d0ab9883 ]---

If kmemdup failed, we should rollback all the alloced resources.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 6c62a895e572 ("FMC: add a software carrier driver")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/fmc/fmc-fakedev.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/fmc/fmc-fakedev.c b/drivers/fmc/fmc-fakedev.c
index 941d093..43d99fe 100644
--- a/drivers/fmc/fmc-fakedev.c
+++ b/drivers/fmc/fmc-fakedev.c
@@ -273,15 +273,18 @@ static struct ff_dev *ff_dev_create(void)
 	ff->dev.release = ff_dev_release;
 
 	ret = device_register(&ff->dev);
-	if (ret < 0) {
-		put_device(&ff->dev);
-		return ERR_PTR(ret);
-	}
+	if (ret < 0)
+		goto failed_register;
 
 	/* Create fmc structures that refer to this new "hw" device */
 	for (i = 0; i < ff_nr_dev; i++) {
 		fmc = kmemdup(&ff_template_fmc, sizeof(ff_template_fmc),
 			      GFP_KERNEL);
+		if (!fmc) {
+			ret = -ENOMEM
+			goto free_fmc;
+		}
+
 		fmc->hwdev = &ff->dev;
 		fmc->carrier_data = ff;
 		fmc->nr_slots = ff_nr_dev;
@@ -294,6 +297,13 @@ static struct ff_dev *ff_dev_create(void)
 		ff_template_fmc.device_id++;
 	}
 	return ff;
+
+free_fmc:
+	for (i--; i >= 0; i--)
+		kfree(ff->fmc[i]);
+failed_register:
+	put_device(&ff->dev);
+	return ERR_PTR(ret);
 }
 
 /* init and exit */
-- 
2.7.4


