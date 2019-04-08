Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BBE4C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 15:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2AB722148E
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 15:14:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728729AbfDHPOF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 11:14:05 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6710 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726228AbfDHPOF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 11:14:05 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 540ACDEB728420DDA3A4;
        Mon,  8 Apr 2019 23:13:59 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.408.0; Mon, 8 Apr 2019
 23:13:49 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <ralf@linux-mips.org>, <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] net: netrom: Fix error cleanup path of nr_proto_init
Date:   Mon, 8 Apr 2019 23:12:00 +0800
Message-ID: <20190408151200.14984-1-yuehaibing@huawei.com>
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

BUG: unable to handle kernel paging request at fffffbfff830524b
PGD 237fe8067 P4D 237fe8067 PUD 237e64067 PMD 1c9716067 PTE 0
Oops: 0000 [#1] SMP KASAN PTI
CPU: 1 PID: 4465 Comm: syz-executor.0 Not tainted 5.0.0+ #5
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
RIP: 0010:__list_add_valid+0x21/0xe0 lib/list_debug.c:23
Code: 8b 0c 24 e9 17 fd ff ff 90 55 48 89 fd 48 8d 7a 08 53 48 89 d3 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 48 83 ec 08 <80> 3c 02 00 0f 85 8b 00 00 00 48 8b 53 08 48 39 f2 75 35 48 89 f2
RSP: 0018:ffff8881ea2278d0 EFLAGS: 00010282
RAX: dffffc0000000000 RBX: ffffffffc1829250 RCX: 1ffff1103d444ef4
RDX: 1ffffffff830524b RSI: ffffffff85659300 RDI: ffffffffc1829258
RBP: ffffffffc1879250 R08: fffffbfff0acb269 R09: fffffbfff0acb269
R10: ffff8881ea2278f0 R11: fffffbfff0acb268 R12: ffffffffc1829250
R13: dffffc0000000000 R14: 0000000000000008 R15: ffffffffc187c830
FS:  00007fe0361df700(0000) GS:ffff8881f7300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffbfff830524b CR3: 00000001eb39a001 CR4: 00000000007606e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 __list_add include/linux/list.h:60 [inline]
 list_add include/linux/list.h:79 [inline]
 proto_register+0x444/0x8f0 net/core/sock.c:3375
 nr_proto_init+0x73/0x4b3 [netrom]
 ? 0xffffffffc1628000
 ? 0xffffffffc1628000
 do_one_initcall+0xbc/0x47d init/main.c:887
 do_init_module+0x1b5/0x547 kernel/module.c:3456
 load_module+0x6405/0x8c10 kernel/module.c:3804
 __do_sys_finit_module+0x162/0x190 kernel/module.c:3898
 do_syscall_64+0x9f/0x450 arch/x86/entry/common.c:290
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x462e99
Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe0361dec58 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
RAX: ffffffffffffffda RBX: 000000000073bf00 RCX: 0000000000462e99
RDX: 0000000000000000 RSI: 0000000020000100 RDI: 0000000000000003
RBP: 00007fe0361dec70 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fe0361df6bc
R13: 00000000004bcefa R14: 00000000006f6fb0 R15: 0000000000000004
Modules linked in: netrom(+) ax25 fcrypt pcbc af_alg arizona_ldo1 v4l2_common videodev media v4l2_dv_timings hdlc ide_cd_mod snd_soc_sigmadsp_regmap snd_soc_sigmadsp intel_spi_platform intel_spi mtd spi_nor snd_usbmidi_lib usbcore lcd ti_ads7950 hi6421_regulator snd_soc_kbl_rt5663_max98927 snd_soc_hdac_hdmi snd_hda_ext_core snd_hda_core snd_soc_rt5663 snd_soc_core snd_pcm_dmaengine snd_compress snd_soc_rl6231 mac80211 rtc_rc5t583 spi_slave_time leds_pwm hid_gt683r hid industrialio_triggered_buffer kfifo_buf industrialio ir_kbd_i2c rc_core led_class_flash dwc_xlgmac snd_ymfpci gameport snd_mpu401_uart snd_rawmidi snd_ac97_codec snd_pcm ac97_bus snd_opl3_lib snd_timer snd_seq_device snd_hwdep snd soundcore iptable_security iptable_raw iptable_mangle iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_filter bpfilter ip6_vti ip_vti ip_gre ipip sit tunnel4 ip_tunnel hsr veth netdevsim vxcan batman_adv cfg80211 rfkill chnl_net caif nlmon dummy team bonding vcan
 bridge stp llc ip6_gre gre ip6_tunnel tunnel6 tun joydev mousedev ppdev tpm kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel ide_pci_generic piix aesni_intel aes_x86_64 crypto_simd cryptd glue_helper ide_core psmouse input_leds i2c_piix4 serio_raw intel_agp intel_gtt ata_generic agpgart pata_acpi parport_pc rtc_cmos parport floppy sch_fq_codel ip_tables x_tables sha1_ssse3 sha1_generic ipv6 [last unloaded: rxrpc]
Dumping ftrace buffer:
   (ftrace buffer empty)
CR2: fffffbfff830524b
---[ end trace 039ab24b305c4b19 ]---

If nr_proto_init failed, it may forget to call proto_unregister,
tiggering this issue. This patch rearrange code of nr_proto_init
to avoid such issues.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 include/net/netrom.h           |  2 +-
 net/netrom/af_netrom.c         | 75 +++++++++++++++++++++++++++++-------------
 net/netrom/sysctl_net_netrom.c |  5 ++-
 3 files changed, 58 insertions(+), 24 deletions(-)

diff --git a/include/net/netrom.h b/include/net/netrom.h
index 5a0714f..80f15b1 100644
--- a/include/net/netrom.h
+++ b/include/net/netrom.h
@@ -266,7 +266,7 @@ void nr_stop_idletimer(struct sock *);
 int nr_t1timer_running(struct sock *);
 
 /* sysctl_net_netrom.c */
-void nr_register_sysctl(void);
+int nr_register_sysctl(void);
 void nr_unregister_sysctl(void);
 
 #endif
diff --git a/net/netrom/af_netrom.c b/net/netrom/af_netrom.c
index 1d3144d..062a16a 100644
--- a/net/netrom/af_netrom.c
+++ b/net/netrom/af_netrom.c
@@ -1392,18 +1392,21 @@ static int __init nr_proto_init(void)
 	int i;
 	int rc = proto_register(&nr_proto, 0);
 
-	if (rc != 0)
-		goto out;
+	if (rc)
+		return rc;
 
 	if (nr_ndevs > 0x7fffffff/sizeof(struct net_device *)) {
-		printk(KERN_ERR "NET/ROM: nr_proto_init - nr_ndevs parameter to large\n");
-		return -1;
+		pr_err("NET/ROM: %s - nr_ndevs parameter to large\n", __func__);
+		rc = -EINVAL;
+		goto unregister_proto;
 	}
 
 	dev_nr = kcalloc(nr_ndevs, sizeof(struct net_device *), GFP_KERNEL);
-	if (dev_nr == NULL) {
-		printk(KERN_ERR "NET/ROM: nr_proto_init - unable to allocate device array\n");
-		return -1;
+	if (!dev_nr) {
+		pr_err("NET/ROM: %s - unable to allocate device array\n",
+		       __func__);
+		rc = -ENOMEM;
+		goto unregister_proto;
 	}
 
 	for (i = 0; i < nr_ndevs; i++) {
@@ -1413,13 +1416,13 @@ static int __init nr_proto_init(void)
 		sprintf(name, "nr%d", i);
 		dev = alloc_netdev(0, name, NET_NAME_UNKNOWN, nr_setup);
 		if (!dev) {
-			printk(KERN_ERR "NET/ROM: nr_proto_init - unable to allocate device structure\n");
+			rc = -ENOMEM;
 			goto fail;
 		}
 
 		dev->base_addr = i;
-		if (register_netdev(dev)) {
-			printk(KERN_ERR "NET/ROM: nr_proto_init - unable to register network device\n");
+		rc = register_netdev(dev);
+		if (rc) {
 			free_netdev(dev);
 			goto fail;
 		}
@@ -1427,36 +1430,64 @@ static int __init nr_proto_init(void)
 		dev_nr[i] = dev;
 	}
 
-	if (sock_register(&nr_family_ops)) {
-		printk(KERN_ERR "NET/ROM: nr_proto_init - unable to register socket family\n");
+	rc = sock_register(&nr_family_ops);
+	if (rc)
 		goto fail;
-	}
 
-	register_netdevice_notifier(&nr_dev_notifier);
+	rc = register_netdevice_notifier(&nr_dev_notifier);
+	if (rc)
+		goto out_sock;
 
 	ax25_register_pid(&nr_pid);
 	ax25_linkfail_register(&nr_linkfail_notifier);
 
 #ifdef CONFIG_SYSCTL
-	nr_register_sysctl();
+	rc = nr_register_sysctl();
+	if (rc)
+		goto out_sysctl;
 #endif
 
 	nr_loopback_init();
 
-	proc_create_seq("nr", 0444, init_net.proc_net, &nr_info_seqops);
-	proc_create_seq("nr_neigh", 0444, init_net.proc_net, &nr_neigh_seqops);
-	proc_create_seq("nr_nodes", 0444, init_net.proc_net, &nr_node_seqops);
-out:
-	return rc;
+	rc = -ENOMEM;
+	if (!proc_create_seq("nr", 0444, init_net.proc_net, &nr_info_seqops))
+		goto proc_remove1;
+	if (!proc_create_seq("nr_neigh", 0444, init_net.proc_net,
+			     &nr_neigh_seqops))
+		goto proc_remove2;
+	if (!proc_create_seq("nr_nodes", 0444, init_net.proc_net,
+			     &nr_node_seqops))
+		goto proc_remove3;
+
+	return 0;
+
+proc_remove3:
+	remove_proc_entry("nr_neigh", init_net.proc_net);
+proc_remove2:
+	remove_proc_entry("nr", init_net.proc_net);
+proc_remove1:
+
+	nr_loopback_clear();
+	nr_rt_free();
+
+#ifdef CONFIG_SYSCTL
+	nr_unregister_sysctl();
+out_sysctl:
+#endif
+	ax25_linkfail_release(&nr_linkfail_notifier);
+	ax25_protocol_release(AX25_P_NETROM);
+	unregister_netdevice_notifier(&nr_dev_notifier);
+out_sock:
+	sock_unregister(PF_NETROM);
 fail:
 	while (--i >= 0) {
 		unregister_netdev(dev_nr[i]);
 		free_netdev(dev_nr[i]);
 	}
 	kfree(dev_nr);
+unregister_proto:
 	proto_unregister(&nr_proto);
-	rc = -1;
-	goto out;
+	return rc;
 }
 
 module_init(nr_proto_init);
diff --git a/net/netrom/sysctl_net_netrom.c b/net/netrom/sysctl_net_netrom.c
index ba1c368..771011b 100644
--- a/net/netrom/sysctl_net_netrom.c
+++ b/net/netrom/sysctl_net_netrom.c
@@ -146,9 +146,12 @@ static struct ctl_table nr_table[] = {
 	{ }
 };
 
-void __init nr_register_sysctl(void)
+int __init nr_register_sysctl(void)
 {
 	nr_table_header = register_net_sysctl(&init_net, "net/netrom", nr_table);
+	if (!nr_table_header)
+		return -ENOMEM;
+	return 0;
 }
 
 void nr_unregister_sysctl(void)
-- 
2.7.4


