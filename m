Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B5FFC2D0C2
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 11:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49174206DB
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 11:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="LZMes3ac"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbfL3LNj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 06:13:39 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:19379 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbfL3LNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 06:13:39 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e09dbd40000>; Mon, 30 Dec 2019 03:13:24 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 30 Dec 2019 03:13:38 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 30 Dec 2019 03:13:38 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 30 Dec
 2019 11:13:37 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 30 Dec 2019 11:13:37 +0000
Received: from nkristam-ubuntu.nvidia.com (Not Verified[10.19.64.167]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e09dbde0000>; Mon, 30 Dec 2019 03:13:37 -0800
From:   Nagarjuna Kristam <nkristam@nvidia.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <mark.rutland@arm.com>, <robh+dt@kernel.org>, <kishon@ti.com>
CC:     <devicetree@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Nagarjuna Kristam <nkristam@nvidia.com>
Subject: [Patch V3 00/18] Tegra XUSB OTG support
Date:   Mon, 30 Dec 2019 16:39:37 +0530
Message-ID: <1577704195-2535-1-git-send-email-nkristam@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1577704404; bh=evRY4LcwVlsf9GhnD1/KSLXkWzEvRtLNadVq9ItdddI=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=LZMes3acl+VwvWbDQSNZovc1Y1f9jq6pvXQmUqjnk3eVtuWtQrI69Enju7nQCejB4
         AkFMJCKket12dmXEG668VduzxsMy6AIRQ2k9epc8BoUQWwxH3VphCisqtqz/2ECDZK
         bVodNXW+DU2cmGU2UsP8ezOuatmwieKYxTXxiEt9SZzZCAKzcNLIgo6ZlGfUsZkN4T
         CVPABQURkqg51z9WUMTyIsNbxcTZLaG61td1LKMPuJPSooWL9xDeli9e7XyAvYov1F
         LLWdCua4ZzObzMCqnPqt7LC5BlfNlIFnHZ/Jbk64fJPQTVaV0/kW57b8SVM4AJNnhT
         a5ncYtIz8MHsQ==
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
   host and DUT on micro-AB port
 - host mode support by connecting pen-drive to micro-AB USB port on DUT
   using standard-A to micro-A converter.
 - toggling between these 2 modes by hot plugging corresponding cables.

DUT: Jetson-tx1, Jetson tx2.

V3:
 - Port and cable names updated in "Tests done" section of cover letter as
   per JC inputs.
 - Fixed arguments allignments in USB padctl driver.
 - Padctl driver aborts if usb-role-switch is not present in dt for
   peripheral/otg roles.
 - Added Reviewed and ACKed details for corresponding patches.
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
 drivers/phy/tegra/xusb.c                           | 152 ++++++++++++
 drivers/phy/tegra/xusb.h                           |   5 +
 drivers/usb/gadget/udc/tegra-xudc.c                | 276 ++++++++++++++-------
 drivers/usb/host/xhci-tegra.c                      | 225 ++++++++++++++++-
 include/linux/phy/tegra/xusb.h                     |   2 +
 14 files changed, 1049 insertions(+), 138 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/usb/nvidia,tegra-xudc.yaml

-- 
2.7.4

