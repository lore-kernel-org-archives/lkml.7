Return-Path: <SRS0=JAXG=U7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E70C06510
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 16:40:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16AD120989
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jul 2019 16:40:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="KuxZdBhb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726636AbfGBQkn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jul 2019 12:40:43 -0400
Received: from smtprelay-out1.synopsys.com ([198.182.47.102]:39170 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725972AbfGBQkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jul 2019 12:40:43 -0400
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 23AC0C0BE5;
        Tue,  2 Jul 2019 16:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1562085642; bh=9IoJlF0bpOR5UbhByS88AdDEz43pdCkSBVjHAo4Jav0=;
        h=From:To:Cc:Subject:Date:From;
        b=KuxZdBhbSw2w0rHtbuX+g5sQGuRW6Y8bhNAGbPqR7vdfL+DwzjAhHjqlwQu/zHFGh
         eQ7InYW9hWVzNRcicRoZDnCpysZ0xp/x5xiyKgFGO76fGzSLowUj288cbkWQKApI3C
         MJrJiI6k++K73xJYpmXZ7RC5TrxrIss2ewNQTfbqzI4EVCmIHljwfUW7cALp2CYzAo
         AX7eMAdybeyRMYzG3fJMgTvAmXf66HaEPIdeIUnrvOQgYiJEvCE8nqnXA8OOr9I3yx
         nuVRWEzdlSASeWuXnBHUTDJGr/AYslBArXqzTlx7MtVw0uwtmzBeMqgNgr9SnH3esJ
         fc2LcARFvIBfQ==
Received: from ru20arcgnu1.internal.synopsys.com (ru20arcgnu1.internal.synopsys.com [10.121.9.48])
        by mailhost.synopsys.com (Postfix) with ESMTP id 4DF49A0057;
        Tue,  2 Jul 2019 16:40:39 +0000 (UTC)
From:   Alexey Brodkin <Alexey.Brodkin@synopsys.com>
To:     linux-snps-arc@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH] ARC: [haps] Add Virtio support
Date:   Tue,  2 Jul 2019 19:40:33 +0300
Message-Id: <20190702164033.43933-1-abrodkin@synopsys.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a preparation for QEMU usage for ARC let's add basic Virtio-MMIO
peripherals support for the platform we're going to use.

For now we add 5 Virtio slots in .dts and enable block and network devices
via Virtio-MMIO.

Note even though typically Virtio register set fits in 0x200 bytes
we "allocate" here 0x2000 so that it matches ARC's default 8KiB page size
and so remapping of that area is done clearly.

We also enable DEVTMPFS automount for more convenient use
of external root file-stystem. Before that we used to use built-in
Initramfs which didn't automount DEVTMPFS anyways so we didn't need
that option, while now it starts making sense.

Signed-off-by: Alexey Brodkin <abrodkin@synopsys.com>
Cc: Rob Herring <robh+dt@kernel.org>
---
 arch/arc/boot/dts/haps_hs.dts      | 30 ++++++++++++++++++++++++++++++
 arch/arc/configs/haps_hs_defconfig |  5 ++++-
 2 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/arch/arc/boot/dts/haps_hs.dts b/arch/arc/boot/dts/haps_hs.dts
index 1ebfa046492b..44bc522fdec8 100644
--- a/arch/arc/boot/dts/haps_hs.dts
+++ b/arch/arc/boot/dts/haps_hs.dts
@@ -62,5 +62,35 @@
 			#interrupt-cells = <1>;
 			interrupts = <20>;
 		};
+
+		virtio0: virtio@f0100000 {
+			compatible = "virtio,mmio";
+			reg = <0xf0100000 0x2000>;
+			interrupts = <31>;
+		};
+
+		virtio1: virtio@f0102000 {
+			compatible = "virtio,mmio";
+			reg = <0xf0102000 0x2000>;
+			interrupts = <32>;
+		};
+
+		virtio2: virtio@f0104000 {
+			compatible = "virtio,mmio";
+			reg = <0xf0104000 0x2000>;
+			interrupts = <33>;
+		};
+
+		virtio3: virtio@f0106000 {
+			compatible = "virtio,mmio";
+			reg = <0xf0106000 0x2000>;
+			interrupts = <34>;
+		};
+
+		virtio4: virtio@f0108000 {
+			compatible = "virtio,mmio";
+			reg = <0xf0108000 0x2000>;
+			interrupts = <35>;
+		};
 	};
 };
diff --git a/arch/arc/configs/haps_hs_defconfig b/arch/arc/configs/haps_hs_defconfig
index b117e6c16d41..436f2135bdc1 100644
--- a/arch/arc/configs/haps_hs_defconfig
+++ b/arch/arc/configs/haps_hs_defconfig
@@ -35,10 +35,12 @@ CONFIG_INET=y
 # CONFIG_IPV6 is not set
 # CONFIG_WIRELESS is not set
 CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
 # CONFIG_STANDALONE is not set
 # CONFIG_PREVENT_FIRMWARE_BUILD is not set
-# CONFIG_BLK_DEV is not set
+CONFIG_VIRTIO_BLK=y
 CONFIG_NETDEVICES=y
+CONFIG_VIRTIO_NET=y
 # CONFIG_NET_VENDOR_ARC is not set
 # CONFIG_NET_VENDOR_BROADCOM is not set
 # CONFIG_NET_VENDOR_INTEL is not set
@@ -68,6 +70,7 @@ CONFIG_FRAMEBUFFER_CONSOLE=y
 CONFIG_LOGO=y
 # CONFIG_HID is not set
 # CONFIG_USB_SUPPORT is not set
+CONFIG_VIRTIO_MMIO=y
 # CONFIG_IOMMU_SUPPORT is not set
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
-- 
2.16.2

