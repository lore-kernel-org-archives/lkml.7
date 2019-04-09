Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60895C10F0E
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 15:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D59120883
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 15:37:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfDIPhw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 11:37:52 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:58074 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726372AbfDIPhw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 11:37:52 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D6E24C80DB848A6B8CA8;
        Tue,  9 Apr 2019 23:37:46 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.408.0; Tue, 9 Apr 2019
 23:37:40 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <mcgrof@kernel.org>, <keescook@chromium.org>,
        <adobriyan@gmail.com>, <viro@zeniv.linux.org.uk>,
        <ebiederm@xmission.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] fs/proc/proc_sysctl.c: Fix a NULL pointer dereference
Date:   Tue, 9 Apr 2019 23:36:22 +0800
Message-ID: <20190409153622.28112-1-yuehaibing@huawei.com>
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

sysctl could not get directory: /net//bridge -12
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] SMP KASAN PTI
CPU: 1 PID: 7027 Comm: syz-executor.0 Tainted: G         C        5.1.0-rc3+ #8
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
RIP: 0010:__write_once_size include/linux/compiler.h:220 [inline]
RIP: 0010:__rb_change_child include/linux/rbtree_augmented.h:144 [inline]
RIP: 0010:__rb_erase_augmented include/linux/rbtree_augmented.h:186 [inline]
RIP: 0010:rb_erase+0x5f4/0x19f0 lib/rbtree.c:459
Code: 00 0f 85 60 13 00 00 48 89 1a 48 83 c4 18 5b 5d 41 5c 41 5d 41 5e 41 5f c3 48 89 f2 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c 02 00 0f 85 75 0c 00 00 4d 85 ed 4c 89 2e 74 ce 4c 89 ea 48
RSP: 0018:ffff8881bb507778 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: ffff8881f224b5b8 RCX: ffffffff818f3f6a
RDX: 000000000000000a RSI: 0000000000000050 RDI: ffff8881f224b568
RBP: 0000000000000000 R08: ffffed10376a0ef4 R09: ffffed10376a0ef4
R10: 0000000000000001 R11: ffffed10376a0ef4 R12: ffff8881f224b558
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  00007f3e7ce13700(0000) GS:ffff8881f7300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd60fbe9398 CR3: 00000001cb55c001 CR4: 00000000007606e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 erase_entry fs/proc/proc_sysctl.c:178 [inline]
 erase_header+0xe3/0x160 fs/proc/proc_sysctl.c:207
 start_unregistering fs/proc/proc_sysctl.c:331 [inline]
 drop_sysctl_table+0x558/0x880 fs/proc/proc_sysctl.c:1631
 get_subdir fs/proc/proc_sysctl.c:1022 [inline]
 __register_sysctl_table+0xd65/0x1090 fs/proc/proc_sysctl.c:1335
 ? 0xffffffffc1a88000
 br_netfilter_init+0x68/0x1000 [br_netfilter]
 do_one_initcall+0xbc/0x47d init/main.c:901
 do_init_module+0x1b5/0x547 kernel/module.c:3456
 load_module+0x6405/0x8c10 kernel/module.c:3804
 __do_sys_finit_module+0x162/0x190 kernel/module.c:3898
 do_syscall_64+0x9f/0x450 arch/x86/entry/common.c:290
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x462e99
Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f3e7ce12c58 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
RAX: ffffffffffffffda RBX: 000000000073bf00 RCX: 0000000000462e99
RDX: 0000000000000000 RSI: 0000000020000280 RDI: 0000000000000003
RBP: 00007f3e7ce12c70 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f3e7ce136bc
R13: 00000000004bcefa R14: 00000000006f6fb0 R15: 0000000000000004
Modules linked in: br_netfilter(+) backlight comedi(C) hid_sensor_hub max3100 ti_ads8688 udc_core fddi snd_mona leds_gpio rc_streamzap mtd pata_netcell nf_log_common rc_winfast udp_tunnel snd_usbmidi_lib snd_usb_toneport snd_usb_line6 snd_rawmidi snd_seq_device snd_hwdep videobuf2_v4l2 videobuf2_common videodev media videobuf2_vmalloc videobuf2_memops rc_gadmei_rm008z 8250_of smm665 hid_tmff hid_saitek hwmon_vid rc_ati_tv_wonder_hd_600 rc_core pata_pdc202xx_old dn_rtmsg as3722 ad714x_i2c ad714x snd_soc_cs4265 hid_kensington panel_ilitek_ili9322 drm drm_panel_orientation_quirks ipack cdc_phonet usbcore phonet hid_jabra hid extcon_arizona can_dev industrialio_triggered_buffer kfifo_buf industrialio adm1031 i2c_mux_ltc4306 i2c_mux ipmi_msghandler mlxsw_core snd_soc_cs35l34 snd_soc_core snd_pcm_dmaengine snd_pcm snd_timer ac97_bus snd_compress snd soundcore gpio_da9055 uio ecdh_generic mdio_thunder of_mdio fixed_phy libphy mdio_cavium iptable_security iptable_raw iptable_mangle
 iptable_nat nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 iptable_filter bpfilter ip6_vti ip_vti ip_gre ipip sit tunnel4 ip_tunnel hsr veth netdevsim vxcan batman_adv cfg80211 rfkill chnl_net caif nlmon dummy team bonding vcan bridge stp llc ip6_gre gre ip6_tunnel tunnel6 tun joydev mousedev ppdev tpm kvm_intel kvm irqbypass crct10dif_pclmul crc32_pclmul crc32c_intel ghash_clmulni_intel aesni_intel ide_pci_generic piix aes_x86_64 crypto_simd cryptd ide_core glue_helper input_leds psmouse intel_agp intel_gtt serio_raw ata_generic i2c_piix4 agpgart pata_acpi parport_pc parport floppy rtc_cmos sch_fq_codel ip_tables x_tables sha1_ssse3 sha1_generic ipv6 [last unloaded: br_netfilter]
Dumping ftrace buffer:
   (ftrace buffer empty)
---[ end trace 68741688d5fbfe85 ]---

commit 23da9588037e forget handle start_unregistering() case,
while header->parent is NULL, it calls erase_header
as above syzkaller call Trace, accessing &header->parent->root
will tigger another NULL pointer dereference. 
As commit 23da9588037e explained, there also no need call
start_unregistering() if header->parent is NULL.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 23da9588037e ("fs/proc/proc_sysctl.c: fix NULL pointer dereference in put_links")
Fixes: 0e47c99d7fe25 ("sysctl: Replace root_list with links between sysctl_table_sets")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 fs/proc/proc_sysctl.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/proc/proc_sysctl.c b/fs/proc/proc_sysctl.c
index d653907..7325baa 100644
--- a/fs/proc/proc_sysctl.c
+++ b/fs/proc/proc_sysctl.c
@@ -1626,9 +1626,11 @@ static void drop_sysctl_table(struct ctl_table_header *header)
 	if (--header->nreg)
 		return;
 
-	if (parent)
+	if (parent) {
 		put_links(header);
-	start_unregistering(header);
+		start_unregistering(header);
+	}
+
 	if (!--header->count)
 		kfree_rcu(header, rcu);
 
-- 
2.7.0


