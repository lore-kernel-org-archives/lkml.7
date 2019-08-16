Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77112C3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 10:18:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A7DF2133F
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 10:18:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbfHPKSJ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 06:18:09 -0400
Received: from esa1.mentor.iphmx.com ([68.232.129.153]:22089 "EHLO
        esa1.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbfHPKSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 06:18:08 -0400
IronPort-SDR: PDnJJa7DDiSOSK7KoZN4+EptBS5ZW4qjCHw8GSe+2i8QzWfsJS+xB75zO0qodCkksstXqIb336
 rAVflerOy8IQIlTOrAAg1q86SjIoQA+aVYRBuPZhPj3Bt6RQaWu9TrjnMSww1pUbr/xMdrypl6
 ljwhTwdeLFFJ82Yi+C2KbUbeYlLqaHTwOLk2HDvNrY7tHzujLWuT3qyudhJvqqUJSsg7+0zTk+
 zdROCSnTBf0s/fpW+cZXmikriCY8SrmWJkbZsBTdaGnpgt40ML1LVF5V8azMejZLg6fIdnrE5R
 VvU=
X-IronPort-AV: E=Sophos;i="5.64,391,1559548800"; 
   d="scan'208";a="42313159"
Received: from orw-gwy-02-in.mentorg.com ([192.94.38.167])
  by esa1.mentor.iphmx.com with ESMTP; 16 Aug 2019 02:18:08 -0800
IronPort-SDR: YA6e3/+IyvtyHvPWkS26ZuqDnClMuiDNqBhEzbl0oFZgpr14TXeMdZyCxbaZ7srJaVqriq/UrN
 449WZdc5opViCUJ5MAyNQC2efZZozGADBT+3TOE5+Og1VjidoIjEgbJOcYWgeMaviDq7qUP3v+
 O6/zIK6YhYg5l5GDylsBaT9K/h+hkLZVJ48PeWJiNcPc7GVg9w7L16niLpXO+c2B9qIZOPObBe
 QsQQr8XHGbaAcnwWZYsRqN17O93yo1bzmocohH3yoiYQReAEdbHM3pyZI3ef3TbF7CrRtBvLyj
 rSk=
From:   "Schmid, Carsten" <Carsten_Schmid@mentor.com>
To:     Wei Yang <richard.weiyang@gmail.com>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        "bp@suse.de" <bp@suse.de>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "richardw.yang@linux.intel.com" <richardw.yang@linux.intel.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH] kernel/resource.c: warn if released region has children
Thread-Topic: [PATCH] kernel/resource.c: warn if released region has children
Thread-Index: AQHVVBpEMvry7L9pAUeVGuhI/tzOaQ==
Date:   Fri, 16 Aug 2019 10:18:02 +0000
Message-ID: <1565950682464.83682@mentor.com>
References: <1565278859475.1962@mentor.com> <1565358624103.3694@mentor.com>
 <20190809223831.fk4uyrzscr366syr@master>
 <CAHk-=wi_9sdMxurjZ1MbNnxt-pA=dqoyf8Fdn9aYc8xvjjnTBg@mail.gmail.com>
 <1565794104204.54092@mentor.com> <20190814162932.alwo7g4664c2dtp3@master>
 <c925c7d1041f478c99863da56c24b8a7@SVR-IES-MBX-03.mgc.mentorg.com>
 <20190815130328.yk4cybuuqnzb7xrx@master>,<ff78412f81494678bb7685dc2604002e@SVR-IES-MBX-03.mgc.mentorg.com>
In-Reply-To: <ff78412f81494678bb7685dc2604002e@SVR-IES-MBX-03.mgc.mentorg.com>
Accept-Language: de-DE, en-IE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [137.202.0.90]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When a resource region is released and has children,
the children are left without any hint that their
parent is no more valid.

This was observed on a use-after-free fault in the xhci-hcd
when xhci-hcd released his iomem region before
platform code released resources of platform devices
giving a random racy failure; one of the stacks observed:

[  230.412493] xhci_hcd 0000:00:15.0: USB bus 1 deregistered
[  230.416021] general protection fault: 0000 [#1] PREEMPT SMP NOPTI
[  230.422836] Modules linked in: bcmdhd(O-) ebtable_filter ebtables xfrm_user xfrm_algo cls_u32 sch_htb intel_tfm_governor cdc_acm ecryptfs intel_ipu4_psys intel_ipu4_psys_csslib snd_soc_apl_mgu_hu intel_xhci_usb_role_switch roles dwc3 adv728x udc_core snd_soc_skl sdw_cnl intel_ipu4_isys snd_soc_acpi_intel_match videobuf2_dma_contig videobuf2_memops snd_soc_acpi ipu4_acpi intel_ipu4_isys_csslib snd_soc_core snd_compress videobuf2_v4l2 videobuf2_core snd_soc_skl_ipc sdw_bus crc8 snd_soc_sst_ipc snd_soc_sst_dsp ahci snd_hda_ext_core coretemp snd_hda_core sbi_apl intel_ipu4_mmu i2c_i801 snd_pcm xhci_pci snd_timer xhci_hcd libahci cfg80211 mei_me snd usbcore libata intel_ipu4 rfkill soundcore usb_common mei dwc3_pci scsi_mod iova nfsd auth_rpcgss lockd grace sunrpc loop fuse 8021q bridge stp llc inap560t(O)
[  230.502258]  i915 video backlight intel_gtt i2c_algo_bit drm_kms_helper drm firmware_class igb_avb(O) ptp hwmon spi_pxa2xx_platform pps_core [last unloaded: bcmdhd]
[  230.518695] CPU: 1 PID: 20364 Comm: unbind-usb-str. Tainted: G     U     O    4.14.67-apl #1
[  230.528124] task: ffffa106ea869900 task.stack: ffffa24c84970000
[  230.534741] RIP: 0010:__release_resource+0x25/0x90
[  230.540090] RSP: 0018:ffffa24c84973c18 EFLAGS: 00010212
[  230.545924] RAX: f7410001b577e8a8 RBX: ffffa10731b4b700 RCX: ffffa10731b4a6c0
[  230.553893] RDX: f7410001b577e8a8 RSI: 0000000000000001 RDI: ffffa10731b4b700
[  230.561864] RBP: ffffa24c84973c18 R08: 0000000000000000 R09: 0000000000000000
[  230.569825] R10: ffffa24c8493b978 R11: 00000000000006c0 R12: ffffa106f1355000
[  230.577794] R13: ffffa24c84973c98 R14: ffffa24c84973c98 R15: 0000000000000001
[  230.585757] FS:  00007f365c48a740(0000) GS:ffffa10777c80000(0000) knlGS:0000000000000000
[  230.594794] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  230.601203] CR2: 000055562a2f0e88 CR3: 00000001f1108000 CR4: 00000000003406a0
[  230.609174] Call Trace:
[  230.611896]  release_resource+0x21/0x40
[  230.616181]  platform_device_del.part.1+0x4f/0x80
[  230.621433]  platform_device_unregister+0x12/0x20
[  230.626683]  xhci_intel_unregister_pdev+0x9/0x10 [xhci_hcd]
[  230.632906]  devm_action_release+0x10/0x20
[  230.637478]  release_nodes+0x10b/0x1f0
[  230.641663]  devres_release_all+0x37/0x50
[  230.646139]  device_release_driver_internal+0x19d/0x240
[  230.651974]  device_release_driver+0xd/0x10
[  230.656644]  unbind_store+0xb8/0x190
[  230.660633]  drv_attr_store+0x22/0x30
[  230.664720]  sysfs_kf_write+0x37/0x40
[  230.668807]  kernfs_fop_write+0x114/0x190
[  230.673283]  __vfs_write+0x35/0x160
[  230.677176]  vfs_write+0xb0/0x1a0
[  230.680873]  SyS_write+0x50/0xc0
[  230.684476]  do_syscall_64+0x79/0x340
[  230.688566]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2
[  230.694208] RIP: 0033:0x7f365bb91144
[  230.698198] RSP: 002b:00007ffe3da9eae8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[  230.706655] RAX: ffffffffffffffda RBX: 000000000000000d RCX: 00007f365bb91144
[  230.714628] RDX: 000000000000000d RSI: 000055562a2efe80 RDI: 0000000000000001
[  230.722599] RBP: 000055562a2efe80 R08: 000000000000000a R09: 00007f365be5acd0
[  230.730568] R10: 000000000000000a R11: 0000000000000246 R12: 00007f365be5b760
[  230.738538] R13: 000000000000000d R14: 00007f365be56760 R15: 000000000000000d
[  230.746501] Code: 84 00 00 00 00 00 48 8b 4f 28 55 b8 ea ff ff ff 48 89 e5 48 8b 51 38 48 85 d2 74 1d 48 39 d7 75 0a eb 62 48 39 c7 74 13 48 89 c2 <48> 8b 42 30 48 85 c0 75 ef b8 ea ff ff ff 5d c3 48 83 c2 30 40
[  230.767628] RIP: __release_resource+0x25/0x90 RSP: ffffa24c84973c18

Because the root cause - iomem area was released earlier -
could not be seen on analysis easily, a warning in the
release_region helps to detect such cases (if any exist).

xhci-hcd driver fix is issued separately.

Signed-off-by: Carsten Schmid <carsten_schmid@mentor.com>
Tested-by: Carsten Schmid <carsten_schmid@mentor.com>
---
Rationale:
- Changed title according to reduced functionality.
  Original title:
  kernel/resource.c: invalidate parent when freed resource has childs
- Added more information about why issuing this patch
---
 kernel/resource.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/kernel/resource.c b/kernel/resource.c
index c3cc6d85ec52..0db374029627 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -1172,7 +1172,19 @@ EXPORT_SYMBOL(__request_region);
  * @n: resource region size
  *
  * The described resource region must match a currently busy region.
+ * If the region has children warn.
  */
+static void check_children(struct resource *parent)
+{
+	write_lock(&resource_lock);
+
+	if (parent->child)
+		WARN_ONCE(1, "%s: %s still has children, at least %s\n",
+				__func__, parent->name, parent->child->name);
+
+	write_unlock(&resource_lock);
+}
+
 void __release_region(struct resource *parent, resource_size_t start,
 		      resource_size_t n)
 {
@@ -1200,6 +1212,10 @@ void __release_region(struct resource *parent, resource_size_t start,
 			write_unlock(&resource_lock);
 			if (res->flags & IORESOURCE_MUXED)
 				wake_up(&muxed_resource_wait);
+
+			/* You should'nt release a resource that has children */
+			check_children(res);
+
 			free_resource(res);
 			return;
 		}
-- 
2.17.1
