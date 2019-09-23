Return-Path: <SRS0=bmbz=XS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACED6C3A5A6
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 08:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 759C420835
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Sep 2019 08:26:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="gioQp35V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406900AbfIWI0i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Sep 2019 04:26:38 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:8051 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406738AbfIWI0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Sep 2019 04:26:38 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d8881c20000>; Mon, 23 Sep 2019 01:26:42 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 23 Sep 2019 01:26:36 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 23 Sep 2019 01:26:36 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 23 Sep
 2019 08:26:35 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 23 Sep 2019 08:26:35 +0000
Received: from nkristam-ubuntu.nvidia.com (Not Verified[10.19.65.118]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d8881b80002>; Mon, 23 Sep 2019 01:26:35 -0700
From:   Nagarjuna Kristam <nkristam@nvidia.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>, <kishon@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Nagarjuna Kristam <nkristam@nvidia.com>
Subject: [Patch V10 0/8] Tegra XUSB gadget driver support
Date:   Mon, 23 Sep 2019 13:55:44 +0530
Message-ID: <1569227152-3030-1-git-send-email-nkristam@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1569227202; bh=TQWUu3EvPEvMja19g0StMEbdSblEghIIYzuVtM1CCvs=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=gioQp35VTOkU8bF//Qv3L08/FaOc5Gf/sQYVTCKUmTwQ0qNq8Kz78LYxDqTasNjx1
         h1TY2ztYb9IWh/Y4pE4Za6kSuMn3UCDqvZkTbqZ4v5MUlVxqEQsO/OZa9OvkwQBZ7C
         FSlyFHQURQ7y3IAM3f8wrYmpfLdFNtTwX/v3Is7yQqEm743+gd/DugHa//r5hz1qWF
         sYa5ohz9CYNc2OuAjZJx4h2EzW5BZjs+B9g8I2QgYdk1oYc7XMMMoHXCbVzOUowRTO
         xdVXDIzcx7LoZOzxAthyv79dhUl2k/hmzJDUuAeA19gUIWhCx7ZLSOG4OyzSEJss+Y
         PXDPVBTHQFl8A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patches 1-3 are phy driver changes to add support for device
mode.
Patches 4-7 are changes related to XUSB device mode
controller driver.
Patch 8 is to enable drivers for XUDC support in defconfig

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
---
v10:
* Patches 1,2,4,5,7,8 - No changes.
* Patch 3 has braces added to one single line else condition.
* Patch 6 has update on compatible string as per suggestion from Chunfeng.
---
v9:
* Patches 1,2,3,4,5 - No changes.
* Patch 6 has update on compatible string as per suggestion from Chunfeng.
* Patch 7 has comment fixes as suggested by Chunfeng.
* Patch 8 has CONFIG_USB_GPIO enabled as module additionally.
---
v8:
* Patches 1,2,3,4,5,8 - No changes.
* Patch 6 has update on compatible string as per change done in [1].
* Patch 7 has issue fix, where device mode didnot got enabled after resume
  from suspend.
---
v7:
* Patches 1,2,3,4,5,6,8 - No changes.
* Patch 7 - Comments from Balbi and Chunfun adrresed.
  Added COMPILE_TEST in Kconfig and updated dependencies.
---
v6:
* Patches 1,2,3,7,8 - No changes.
* Patch 4,5,6 - Comments from Rob addressed, updated usb connector driver
  compatibility string.
---
v5:
* Patches 1-3 - Commit subject updated as per inputs from Thierry.
* Patch 4 - Added reg-names used on Tegra210 in the bindings doc
* Enabled xudc driver as module instead of part of kernel in patch 8.
* Patched 5-8 - No changes.
---
v4:
* patch 1 - no changes.
* corrected companion device search based on inputs from Thierry in patch 2.
* removed unneeded dev variable and corrected value read in
  tegra210_utmi_port_reset function in patch 3.
* dt binding doc and dtb files are corrected for alignments.
  Replaced extcon-usb-gpio with usb role switch.
* Added support for USB role switch instead of extcon-usb-gpio and other minor
  comments as suggested by Chunfeng.
* Enabled xudc driver as module instead of part of kernel in patch 8.
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
  arm64: defconfig: Enable tegra XUDC support

 .../devicetree/bindings/usb/nvidia,tegra-xudc.txt  |  110 +
 arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi     |   31 +-
 arch/arm64/boot/dts/nvidia/tegra210.dtsi           |   19 +
 arch/arm64/configs/defconfig                       |    2 +
 drivers/phy/tegra/xusb-tegra210.c                  |  134 +-
 drivers/phy/tegra/xusb.c                           |   87 +
 drivers/phy/tegra/xusb.h                           |    4 +
 drivers/usb/gadget/udc/Kconfig                     |   11 +
 drivers/usb/gadget/udc/Makefile                    |    1 +
 drivers/usb/gadget/udc/tegra-xudc.c                | 3787 ++++++++++++++++++++
 include/linux/phy/tegra/xusb.h                     |    4 +-
 11 files changed, 4186 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/nvidia,tegra-xudc.txt
 create mode 100644 drivers/usb/gadget/udc/tegra-xudc.c

-- 
2.7.4

