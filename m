Return-Path: <SRS0=tMFY=W7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D1C0C3A5A7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 08:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6061022CED
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Sep 2019 08:24:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="WxEOfFh+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728238AbfIDIYT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Sep 2019 04:24:19 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:12904 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726010AbfIDIYT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Sep 2019 04:24:19 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d6f74b20000>; Wed, 04 Sep 2019 01:24:18 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 04 Sep 2019 01:24:17 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 04 Sep 2019 01:24:17 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 4 Sep
 2019 08:24:16 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 4 Sep 2019 08:24:16 +0000
Received: from nkristam-ubuntu.nvidia.com (Not Verified[10.19.65.118]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d6f74ad0000>; Wed, 04 Sep 2019 01:24:16 -0700
From:   Nagarjuna Kristam <nkristam@nvidia.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>, <kishon@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Nagarjuna Kristam <nkristam@nvidia.com>
Subject: [Patch V8 0/8] Tegra XUSB gadget driver support
Date:   Wed, 4 Sep 2019 13:53:52 +0530
Message-ID: <1567585440-13751-1-git-send-email-nkristam@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1567585458; bh=a5NVT8a3FAkhRV1mnONnoA05aOdsPdpCwhqLGvSRatY=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=WxEOfFh+uiA4PNXmtNhXYvEnwYiTLCP157I6UcSnD+45yH33/UwD7xk2L+YtAUHAp
         blGm/zOgs2dzxhzSv2evkT644APeWM73oIfYNiR2DcZ6thXo7WhQNkFmRnK9TXks9b
         O72rTe8GCIYei0y/euqBTKwQAeIfWnWuK4Si/gAe6S0qlGIBBPoDVEl0Yn2HwViG3D
         91orF+Ge1nxBU9AdC6riTAVhwL2S7PuNm+o0F3kBbgJhcYR/PFmyJqp5JmVw6qm4g2
         C2L5OcGUNI+bEAM+8S8Jqw/ag29isZk2j5Xl1CQuUuN9lxRSb5fcPrYiiSbl+R9jVl
         Gt2b6wIYcznXg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the seventh version of series "Tegra XUSB gadget driver support"

Patches 1-3 are phy driver changes to add support for device
mode.
Patches 4-7 are changes related to XUSB device mode
controller driver.
Patch 8 is to enable XUDC driver in defconfig

Test Steps(USB 2.0):
- Enable "USB Gadget precomposed configurations" in defconfig
- Build, flash and boot Jetson TX1
- Connect Jetson TX1 and Ubuntu device using USB A to Micro B
  cable
- After boot on Jetson TX1 terminal usb0 network device should be
  enumerated
- Assign static ip to usb0 on Jetson TX1 and corresponding net
  device on ubuntu
- Run ping test and transfer test(used scp) to check data transfer
  communication

SS mode is verified by enabling Type A port as peripheral

This patch series is dependent on [1] for functionality of hot plug
triggers to xudc driver.

[1] https://patchwork.kernel.org/cover/11120723/
---
v8:
* Patches 1,2,3,4,5,8 - No changes
* Patch 6 has update on compatible string as per change done in [1].
* Patch 7 has issue fix, where device mode didnot got enabled after resume
  from suspend.
---
v7:
* Patches 1,2,3,4,5,6,8 - No changes
* Patch 7 - Comments from Balbi and Chunfun adrresed.
  Added COMPILE_TEST in Kconfig and updated dependencies.
---
v6:
* Patches 1,2,3,7,8 - No changes
* Patch 4,5,6 - Comments from Rob addressed, updated usb connector driver
  compatibility string.
---
v5:
* Patches 1-3 - Commit subject updated as per inputs from Thierry
* Patch 4 - Added reg-names used on Tegra210 in the bindings doc
* Enabled xudc driver as module instead of part of kernel in patch 8
* Patched 5-8 - No changes
---
v4:
* patch 1 - no changes
* corrected companion device search based on inputs from Thierry in patch 2
* removed unneeded dev variable and corrected value read in
  tegra210_utmi_port_reset function in patch 3
* dt binding doc and dtb files are corrected for alignments.
  Replaced extcon-usb-gpio with usb role switch.
* Added support for USB role switch instead of extcon-usb-gpio and other minor
  comments as suggested by Chunfeng.
* Enabled xudc driver as module instead of part of kernel in patch 8
---
V3:
* Rebased patch 1 to top of tree.
* Fixed bug in patch 2, where xudc interrupts dont get generated if USB host
  mode fails to probe. Moved fake port detection logic to generic xusb.c. fake
  usb port data is updated based on soc flag need_fake_usb3_port.
* Added extra lines whereever necessary to make code more readable in patch 3
  and 7.
* dt binding doc is corrected for typos and extcon references. Also added
  details for clocks and removed xusb_ references to clock and power-domain
  names and accordingly patch 5 is updated.
* removed avdd-pll-utmip-supply in patch 6, as its now part of padctl driver.
* Patch 8 has no changes.
---
V2:
* Patches 1-3 are new patches in this series, which splits unified features
  patch to speprated features and removes need of port-fake entry in DT.
* Patch 4 is re-arragend dt-bindings patch which incorporates previous
  patch comments to sort DT entries alphabetically, addresses name changes
  and PM domain details added.
* Patch 5-6 are re-arranged DT patches with major changes - sort entries
  alphabetically, and adds clock names.
* Patch 7 is UDC driver tegra XUSB device mode controller with major
  changes - remove un-used module params, lockinng for device_mode flag,
  moving un-needed info logs to debug level, making changes feature flag
  dependent rather than SOC based macros and other error handling in probe.
* Patch 8 has no changes.

Nagarjuna Kristam (8):
  phy: tegra: xusb: Add XUSB dual mode support on Tegra210
  phy: tegra: xusb: Add usb3 port fake support on Tegra210
  phy: tegra: xusb: Add vbus override support on Tegra210
  dt-bindings: usb: Add NVIDIA Tegra XUSB device mode controller binding
  arm64: tegra: Add xudc node for Tegra210
  arm64: tegra: Enable xudc on Jetson TX1
  usb: gadget: Add UDC driver for tegra XUSB device mode controller
  arm64: defconfig: Enable tegra XUDC driver

 .../devicetree/bindings/usb/nvidia,tegra-xudc.txt  |  110 +
 arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi     |   31 +-
 arch/arm64/boot/dts/nvidia/tegra210.dtsi           |   19 +
 arch/arm64/configs/defconfig                       |    1 +
 drivers/phy/tegra/xusb-tegra210.c                  |  133 +-
 drivers/phy/tegra/xusb.c                           |   87 +
 drivers/phy/tegra/xusb.h                           |    4 +
 drivers/usb/gadget/udc/Kconfig                     |   12 +
 drivers/usb/gadget/udc/Makefile                    |    1 +
 drivers/usb/gadget/udc/tegra-xudc.c                | 3791 ++++++++++++++++++++
 include/linux/phy/tegra/xusb.h                     |    4 +-
 11 files changed, 4189 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/nvidia,tegra-xudc.txt
 create mode 100644 drivers/usb/gadget/udc/tegra-xudc.c

-- 
2.7.4

