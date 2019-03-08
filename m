Return-Path: <SRS0=vL1f=RL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89BFDC43381
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 04:12:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49AB520851
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Mar 2019 04:12:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessm-com.20150623.gappssmtp.com header.i=@endlessm-com.20150623.gappssmtp.com header.b="1oeeU/Hr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbfCHEMU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Mar 2019 23:12:20 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34302 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbfCHEMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Mar 2019 23:12:20 -0500
Received: by mail-pf1-f196.google.com with SMTP id u9so13142732pfn.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2019 20:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=cpCMmvPBPPW5pHDli55D9fJSKZeS7QOV0FG7Gk4Xsc4=;
        b=1oeeU/HrlTFtyjiInwbvbV7mbQ5enS/nDYJxD/Jhc7hothF8dHw7NZsfQMHtNYImHa
         1bEBNd67gAZWomtUvHIlGRRca1CIcSzRgwG7/3K3wDZXFSwi+bcNJuGG4IvNOwShSyEX
         kmFE652gn0/lUgb61x9adZ3LD3d6d0zEj7Awl0DiBsN7pVvNkdsnWC8mrDuFHOQ1vIe+
         8wOlxCVIFTkNb7UvOTJZI+LT4aMfhDhoVeAdZhF2zmqPw9KRdgMixvmfJwNwA3clsoau
         I96DB0yJkP+nUyjDQirfbWeldGhnrFeDR1EWUIJENUYVgZXXffTJb3+86+S3HSFT5QLq
         wSSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cpCMmvPBPPW5pHDli55D9fJSKZeS7QOV0FG7Gk4Xsc4=;
        b=rUby6O6/Nm8ZTEWNgnZARKX/X/Mom9D61C0RFPMZxWcY45x7i2C4N9s9ACTslJk0aJ
         XBGKsCXwdCM+cl52P8+fmGcOgo8WyV57+AdZ/ALDUlYI13vslOdJcj6MIx4O7L1yPl9z
         ZoWDaCmbo1PRN/50glUwtGTsiQN/lpXNmMePOC9pFOYn8K6VUZ/uT2Qq5iFLRR+FYy+n
         mxxinT1zUQbvjoFY9tqdou28yJip4d6gulQAz0XltYgcfHQxe9ykdA8gshLDLZ1LXmnL
         g9ffPYQFXqz+iNHbmD7vCQ72SDntl7gunFcpTv4bUecBODpmaHXZnx01DBahR8oZh/IT
         h8hw==
X-Gm-Message-State: APjAAAVzTVwMBGgAyXGX/n01UAyAOPhIcXrim/luI9AI+0lqDWKXElzp
        AIr53k9dSq/wjVlgPCFAb/VlWw==
X-Google-Smtp-Source: APXvYqxdNDGgVE/W9zDn0acSQGRBfDlREQJz4V98OTaiyR0fqnvCBvgM3o1EE8mbix7cETta7yv1BQ==
X-Received: by 2002:a63:2004:: with SMTP id g4mr14859877pgg.337.1552018339243;
        Thu, 07 Mar 2019 20:12:19 -0800 (PST)
Received: from localhost.localdomain (220-133-8-232.HINET-IP.hinet.net. [220.133.8.232])
        by smtp.gmail.com with ESMTPSA id a20sm11955683pfj.5.2019.03.07.20.12.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 07 Mar 2019 20:12:18 -0800 (PST)
From:   Chris Chiu <chiu@endlessm.com>
To:     joro@8bytes.org, iommu@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux@endlessm.com,
        Chris Chiu <chiu@endlessm.com>
Subject: [PATCH] iommu/amd: Fix a null pointer dereference for ACPI devices
Date:   Fri,  8 Mar 2019 12:12:10 +0800
Message-Id: <20190308041210.84518-1-chiu@endlessm.com>
X-Mailer: git-send-email 2.17.2 (Apple Git-113)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On ASUS laptop X512DK with the realtek USB card reader, the NULL
pointer dereference happens while bringing up the rtsx_usb driver.

[    1.782281] BUG: unable to handle kernel NULL pointer dereference at 0000000000000090
[    1.782283] PGD 0 P4D 0
[    1.782285] Oops: 0000 [#1] SMP NOPTI
[    1.782287] CPU: 6 PID: 290 Comm: systemd-udevd Not tainted 4.20.0-2-generic #3+dev91.add2285bem1
[    1.782288] Hardware name: ASUSTeK COMPUTER INC. VivoBook_ASUSLaptop X512DK_X512DK/X512DK, BIOS X512DK.200 01/04/2019
[    1.782292] RIP: 0010:acpi_device_hid+0x6/0x30
[    1.782293] Code: ff ff 5b 31 c0 41 5c 5d c3 49 8b 84 24 20 02 00 00 48 85 c0 74 e4 48 8b 40 38 48 85 c0 75 d3 eb d9 90 90 90 0f 1f 44 00 00 55 <48> 8b 97 90 00 00 00 48 8d 8f 90 00 00 00 48 c7 c0 f7 4a ba b9 48
[    1.782294] RSP: 0018:ffffb1c40209f7a8 EFLAGS: 00010246
[    1.782295] RAX: 0000000000000000 RBX: ffff9ed23446b200 RCX: 0000000000000000
[    1.782296] RDX: ffff9ed22ab23010 RSI: 0000000000000001 RDI: 0000000000000000
[    1.782297] RBP: ffffb1c40209f7e0 R08: 0000000000000000 R09: 0000000000000228
[    1.782297] R10: 0000000000000000 R11: ffff9ed2288c5ed8 R12: fffffffffffffff0
[    1.782298] R13: ffff9ed22ab23010 R14: 0000000000000000 R15: 0000000000000000
[    1.782299] FS:  00007f9aa61988c0(0000) GS:ffff9ed234b80000(0000) knlGS:0000000000000000
[    1.782300] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.782300] CR2: 0000000000000090 CR3: 00000002aaafc000 CR4: 00000000003406e0
[    1.782301] Call Trace:
[    1.782307]  ? check_device.part.19+0x5e/0x140
[    1.782308]  amd_iommu_add_device+0x2d/0x4a0
[    1.782310]  ? acpi_match_device+0x30/0x70
[    1.782312]  iommu_bus_notifier+0xc5/0xe0
[    1.782315]  notifier_call_chain+0x4c/0x70
[    1.782316]  blocking_notifier_call_chain+0x43/0x60
[    1.782319]  device_add+0x392/0x6a0
[    1.782321]  platform_device_add+0x111/0x260
[    1.782323]  mfd_add_device+0x445/0x570
[    1.782326]  ? urb_destroy+0x1b/0x40
[    1.782329]  ? _cond_resched+0x19/0x30
[    1.782330]  mfd_add_devices+0xab/0x120
[    1.782333]  rtsx_usb_probe+0x256/0x300 [rtsx_usb]
[    1.782336]  usb_probe_interface+0xf1/0x300
[    1.782338]  really_probe+0xfe/0x3b0
[    1.782339]  driver_probe_device+0xba/0x100
[    1.782341]  __driver_attach+0xe4/0x110
[    1.782343]  ? driver_probe_device+0x100/0x100
[    1.782345]  bus_for_each_dev+0x79/0xc0
[    1.782347]  ? kmem_cache_alloc_trace+0x15e/0x1e0
[    1.782348]  driver_attach+0x1e/0x20
[    1.782350]  bus_add_driver+0x159/0x230
[    1.782351]  driver_register+0x70/0xc0
[    1.782353]  usb_register_driver+0x7f/0x140
[    1.782356]  rtsx_usb_driver_init+0x23/0x1000 [rtsx_usb]
[    1.782359]  do_one_initcall+0x4a/0x1c4
[    1.782377] localhost kernel: RIP: 0033:0x7f9aa6806299
[    1.782379] localhost kernel: Code: 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d c7 6b 0c 00 f7 d8 64 89 01 48
[    1.782379] localhost kernel: RSP: 002b:00007fff6471bd48 EFLAGS: 00000246 ORIG_RAX: 0000000000000139
[    1.782380] localhost kernel: RAX: ffffffffffffffda RBX: 000056264b3ba4a0 RCX: 00007f9aa6806299
[    1.782381] localhost kernel: RDX: 0000000000000000 RSI: 00007f9aa670acad RDI: 000000000000000e
[    1.782381] localhost kernel: RBP: 00007f9aa670acad R08: 0000000000000000 R09: 000056264b3ba4a0
[    1.782382] localhost kernel: R10: 000000000000000e R11: 0000000000000246 R12: 0000000000000000
[    1.782383] localhost kernel: R13: 000056264b3acc10 R14: 0000000000020000 R15: 000056264b3ba4a0
[    1.782384] localhost kernel: Modules linked in: rtsx_usb(+) uas usb_storage hid_multitouch hid_generic amdgpu(+) chash amd_iommu_v2 gpu_sched i2c_algo_bit serio_raw drm_kms_helper syscopyarea ahci sysfillrect sysimgblt fb_sys_fops libahci ttm drm wmi video i2c_hid hid
[    1.782391] localhost kernel: CR2: 0000000000000090
[    1.782392] localhost kernel: ---[ end trace ba1c82e36e279e13 ]---

The reason is the card reader attached to the USB and doesn't have
corresponding ACPI device. So the ACPI_COMPANION(dev) passed to
acpi_device_hid() is NULL which results in null derefernce at the
consequent device->pnp.ids.

Fix this by validating the ACPI companion of the device first.

Signed-off-by: Chris Chiu <chiu@endlessm.com>
---
 drivers/iommu/amd_iommu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 1167ff0416cf..7737d184a185 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -168,6 +168,9 @@ static inline int get_acpihid_device_id(struct device *dev,
 {
 	struct acpihid_map_entry *p;
 
+	if (!has_acpi_companion(dev))
+		return -ENODEV;
+
 	list_for_each_entry(p, &acpihid_map, list) {
 		if (!match_hid_uid(dev, p)) {
 			if (entry)
-- 
2.20.1

