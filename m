Return-Path: <SRS0=eolO=2I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 642DFC2D0CD
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 09:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 389E520717
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Dec 2019 09:16:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="PiRGIeV0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbfLRJQw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Dec 2019 04:16:52 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:7957 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfLRJQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Dec 2019 04:16:52 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5df9ee790000>; Wed, 18 Dec 2019 01:16:41 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Wed, 18 Dec 2019 01:16:50 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Wed, 18 Dec 2019 01:16:50 -0800
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 18 Dec
 2019 09:16:50 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 18 Dec
 2019 09:16:50 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 18 Dec 2019 09:16:49 +0000
Received: from nkristam-ubuntu.nvidia.com (Not Verified[10.19.64.167]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5df9ee7e0001>; Wed, 18 Dec 2019 01:16:49 -0800
From:   Nagarjuna Kristam <nkristam@nvidia.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>, <kishon@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Nagarjuna Kristam" <nkristam@nvidia.com>
Subject: [Patch V2 00/18] Tegra XUSB OTG support
Date:   Wed, 18 Dec 2019 14:46:13 +0530
Message-ID: <1576660591-10383-1-git-send-email-nkristam@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1576660601; bh=GAnpkDa8+C6kSVdl8u+FhFXJGwVJnbN0tZE24YWzkCs=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=PiRGIeV0nwrQ8DXtQqkchaRNJXDDISpfenvOw5LLi4gffmdQpkkKZnxwmvgzuHb/t
         33i0vlzCIdhyOsFxWrJYEatVLx+BsJ4LYBd/5Z7roKbxyeTin2YAQ8H/UYzz0aE4gg
         7R6+7ax151rdX0FI/QPp7An5XgRlELRGLyl+lgygqgTk4mDkgG5JtBM/z24uVawVfQ
         gXAc2oDYRkbogwtEGP6dlGOloSGLGc+f7jHAesDDOVEFTss5lPPKcuKtNDkGHdQ+2r
         M+VUqqskOVBINhoXQPoLv4T0w5ZQlkP9d4GGfTC79cKNWoVSpG7vWRwCrqiX7HDthP
         U/mCPYOKS4bNg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds OTG support on XUSB hardware used in Tegra210 and
Tegra186 SoCs.

This patchset is composed with :
 - dt bindings of XUSB Pad Controller
 - dt bindings for XUSB device Driver
 - Tegra PHY driver for usb-role-switch and usb-phy
 - Tegra XUSB host mode driver to support OTG mode
 - Tegra XUSB device mode driver to use usb-phy and multi device mode
 - dts for XUSB pad controller
 - dts for xudc

Tegra Pad controller driver register for role switch updates for
OTG/peripheral capable USB ports and adds usb-phy for that corresponding
USB ports.

Host and Device mode drivers gets usb-phy from USB2's phy and registers
notifier for role changes to perform corresponding role tasks.

Tests done:
 - device mode support using micro-B USB cable connection between ubuntu
   host and DUT on micro-B port
 - host mode support by connecting pen-drive to micro USB port on DUT
   using micro-B OTG cable.
 - toggling between these 2 modes by hot plugging corresponding cables.

DUT: Jetson-tx1, Jetson tx2.

V2:
 - Updated usb-role-switch documentation for Padctl driver.
 - Update XUDC bindings doc as suggested by Rob.
 - Used standard error codes for error return.
 - Added of_platform_depopulate during error and driver removal.
 - Updated error variable during phy initialization in XUDC driver.
 - Updated Tegra210 soc dtb file as per changes to binding doc.

Nagarjuna Kristam (18):
  dt-bindings: phy: tegra-xusb: Add usb-role-switch
  dt-bindings: usb: Add NVIDIA Tegra XUSB device mode controller binding
  phy: tegra: xusb: Add usb-role-switch support
  phy: tegra: xusb: Add usb-phy support
  phy: tegra: xusb: Add support to get companion USB 3 port
  phy: tegra: xusb: Add set_mode support for USB 2 phy on Tegra210
  phy: tegra: xusb: Add set_mode support for utmi phy on Tegra186
  usb: xhci-tegra: Add OTG support
  usb: gadget: tegra-xudc: Remove usb-role-switch support
  usb: gadget: tegra-xudc: Add usb-phy support
  usb: gadget: tegra-xudc: use phy_set_mode to set/unset device mode
  usb: gadget: tegra-xudc: support multiple device modes
  arm64: tegra: update OTG port entries for jetson-tx1
  arm64: tegra: update OTG port entries for jetson-tx2
  arm64: tegra: Add xudc node for Tegra210
  arm64: tegra: Enable xudc on Jetson TX1
  arm64: tegra: Add xudc node for Tegra186
  arm64: tegra: Enable xudc node on Jetson TX2

 .../bindings/phy/nvidia,tegra124-xusb-padctl.txt   |   6 +
 .../devicetree/bindings/usb/nvidia,tegra-xudc.yaml | 190 ++++++++++++++
 arch/arm64/boot/dts/nvidia/tegra186-p2771-0000.dts |  23 +-
 arch/arm64/boot/dts/nvidia/tegra186.dtsi           |  19 ++
 arch/arm64/boot/dts/nvidia/tegra210-p2597.dtsi     |  34 ++-
 arch/arm64/boot/dts/nvidia/tegra210.dtsi           |  19 ++
 drivers/phy/tegra/Kconfig                          |   1 +
 drivers/phy/tegra/xusb-tegra186.c                  | 109 ++++++--
 drivers/phy/tegra/xusb-tegra210.c                  | 126 ++++++++--
 drivers/phy/tegra/xusb.c                           | 134 ++++++++++
 drivers/phy/tegra/xusb.h                           |   5 +
 drivers/usb/gadget/udc/tegra-xudc.c                | 276 ++++++++++++++-------
 drivers/usb/host/xhci-tegra.c                      | 225 ++++++++++++++++-
 include/linux/phy/tegra/xusb.h                     |   2 +
 14 files changed, 1031 insertions(+), 138 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/nvidia,tegra-xudc.yaml

-- 
2.7.4

