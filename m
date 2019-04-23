Return-Path: <SRS0=LehB=SZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF31AC10F14
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 12:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FB48206A3
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Apr 2019 12:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ntz8QP/G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727649AbfDWMLi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Apr 2019 08:11:38 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:52580 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbfDWMLh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Apr 2019 08:11:37 -0400
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id x3NCBaFv031632;
        Tue, 23 Apr 2019 07:11:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1556021496;
        bh=gCFtj3+WheW7cVLoPALJGp7zPZjObzBqpjz1XouuMfE=;
        h=From:To:CC:Subject:Date;
        b=ntz8QP/GskoIUhq9tXGeAUwKlnsjPU+Bp38w1iNSH5XmKnl0ejTsyKtgXkPpcI2cA
         AFd4pH3StUEkCgs9OoTVBDJurFpn/uxtVU21FW2Bs+/mt+/bQvGXefF+OvGImRDvpP
         GQO0sEvURZF2P9GcsRvSf7khIKlCaYH89gzS8XAw=
Received: from DLEE106.ent.ti.com (dlee106.ent.ti.com [157.170.170.36])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x3NCBa5i126248
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 23 Apr 2019 07:11:36 -0500
Received: from DLEE105.ent.ti.com (157.170.170.35) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Tue, 23
 Apr 2019 07:11:35 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Tue, 23 Apr 2019 07:11:35 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id x3NCBXfc046701;
        Tue, 23 Apr 2019 07:11:34 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>, <kishon@ti.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] PHY: For 5.2
Date:   Tue, 23 Apr 2019 17:40:32 +0530
Message-ID: <20190423121032.3910-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Please find the pull request of 5.2 merge window below.

It adds a new PHY ops to _release_ the PHY which can be used by PHY drivers
for cleaning up any initializations done during phy_get.
It adds a number of new PHY driver including Amlogic's USB2 PHY and a
shared USB3 + PCIE PHY, Broadcom's Stingray USB PHY, Hisilicon's USB PHY
in hi3660, MediaTek's UFS M-PHY, Nvidia's XUSB pad controller in
Tegra186 and TI's AM654 SERDES.

For the complete list of changes, see the tag message below.

There is a change in ufs-qcom.c (SCSI subsystem) which now exposes the
reset controller to be used by PHY. This is required to disable the
regulator that powers UFS in order to save power during system suspend
while following the PHY initialization sequence.

All of these were present in linux-next for quite a while and shouldn't
have any conflicts.

Let me know If I have to make any changes.

Thanks
Kishon

The following changes since commit 9e98c678c2d6ae3a17cb2de55d17f69dddaa231b:

  Linux 5.1-rc1 (2019-03-17 14:22:26 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kishon/linux-phy.git tags/phy-for-5.2

for you to fetch changes up to 708310711e6cdc1f5d8fb1d3fb531fba09ebae2e:

  dt-bindings: phy-qcom-qmp: Tweak qcom,msm8998-qmp-ufs-phy (2019-04-22 17:14:39 +0530)

----------------------------------------------------------------
phy: for 5.2

  *) Add a new *release* phy_ops invoked when the consumer relinquishes PHY
     that can be used to undo the operation performed in xlate
  *) Add new driver to support USB2 PHY and shared USB3 + PCIE PHY in Amlogic
     G12A SoC Family.
  *) Add new driver to support for Broadcom's Stingray USB PHY (Type 1 has
     one super speed PHY and one high speed PHY, Type 2 has one high speed PHY)
  *) Add new driver to support USB PHY in hi3660 SoC of Hisilicon
  *) Add new driver to support UFS M-PHY in MediaTek SoC
  *) Add new driver to support XUSB pad controller in Tegra186 SoCs
  *) Add new driver to support SERDES in TI's AM654 platform
  *) Add support for generation 2 USB2 PHY and gneration 3 USB2 PHY in r8a77470
     to phy-rcar-gen2.c and phy-rcar-gen3-usb2.c respectively
  *) Add support for PCIe QMP PHY support in msm8998 to phy-qcom-qmp.c
  *) Add support for SERDES6G in phy-ocelot-serdes.c
  *) Add support to set drive impedance from device tree in phy-rockchip-emmc.c
  *) Add support to power up/down the VBUS voltage rail in phy-fsl-imx8mq-usb.c
  *) Add support to shut off regulators that power UFS during system suspend
  *) Re-design phy-rcar-gen3-usb2.c to create separate PHY instances for each
     channel which helps to enable/disable interrupts for each instance
     independently
  *) Fix PCIe power up sequence to follow the TRM in order to ensure the DPLL &
     PHY operates correctly over the entire temperature range.
  *) Use devm_clk_get_optional to get optional clocks instead of adding
     custom error checks

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

----------------------------------------------------------------
Biju Das (4):
      dt-bindings: phy: rcar-gen2: Add r8a77470 support
      dt-bindings: rcar-gen3-phy-usb2: Add r8a77470 support
      phy: renesas: phy-rcar-gen2: Add support for r8a77470
      phy: rcar-gen3-usb2: Add support for r8a77470

Christoph Muellner (2):
      phy: rockchip-emmc: Allow to set drive impedance via DTS.
      dt-bindings: phy: Add a new property drive-impedance-ohm for RK's emmc PHY

Chunfeng Yun (4):
      phy: phy-mtk-tphy: get optional clock by devm_clk_get_optional()
      phy: qcom-qusb2: get optional clock by devm_clk_get_optional()
      phy: socionext: get optional clock by devm_clk_get_optional()
      phy: phy-meson-gxl-usb2: get optional clock by devm_clk_get_optional()

Colin Ian King (2):
      phy: ti-pipe3: fix missing bit-wise or operator when assigning val
      scsi: phy: mediatek: fix typo in author's email address

Evan Green (6):
      dt-bindings: ufs: Add #reset-cells for Qualcomm controllers
      dt-bindings: phy-qcom-qmp: Add UFS PHY reset
      dt-bindings: phy: qcom-ufs: Add resets property
      scsi: ufs: qcom: Expose the reset controller for PHY
      phy: qcom: Utilize UFS reset controller
      phy: ufs-qcom: Refactor all init steps into phy_poweron

JC Kuo (2):
      phy: tegra: xusb: Skip single function lane programming
      phy: tegra: xusb: Add Tegra186 support

Kavya Sree Kotagiri (1):
      phy: ocelot-serdes: Add support for SERDES6G muxing

Kishon Vijay Abraham I (4):
      phy: core: Add *release* phy_ops invoked when the consumer relinquishes PHY
      phy: core: Invoke pm_runtime_get_*/pm_runtime_put_* before invoking reset callback
      dt-bindings: phy: ti: Add dt binding documentation for SERDES in AM654x SoC
      phy: ti: Add a new SERDES driver for TI's AM654x SoC

Lucas Stach (2):
      dt-bindings: phy-imx8mq-usb: add optional vbus supply regulator
      phy: fsl-imx8mq-usb: add support for VBUS power control

Marc Gonzalez (3):
      phy: qcom-qmp: Add msm8998 PCIe QMP PHY support
      dt-bindings: phy-qcom-qmp: Add qcom,msm8998-qmp-pcie-phy
      dt-bindings: phy-qcom-qmp: Tweak qcom,msm8998-qmp-ufs-phy

Neil Armstrong (4):
      dt-bindings: phy: Add Amlogic G12A USB2 PHY Bindings
      dt-bindings: phy: Add Amlogic G12A USB3+PCIE Combo PHY Bindings
      phy: amlogic: add Amlogic G12A USB2 PHY Driver
      phy: amlogic: Add Amlogic G12A USB3 + PCIE Combo PHY Driver

Roger Quadros (5):
      phy: ti-pipe3: Introduce mode property in driver data
      phy: ti-pipe3: improve DPLL stability for SATA & USB
      phy: ti-pipe3: Fix SATA & USB PHY power up sequence
      phy: ti-pipe3: Fix PCIe power up sequence
      phy: ti: am654-serdes: Support all clksel values

Srinath Mannam (2):
      dt-bindings: phy: Add Stingray USB PHY binding document
      phy: sr-usb: Add Stingray USB PHY driver

Stanley Chu (2):
      dt-bindings: phy: Add document for phy-mtk-ufs
      phy: mediatek: Add UFS M-PHY driver

Thierry Reding (3):
      dt-bindings: phy: tegra: Add Tegra186 support
      phy: tegra: xusb: Parse dual-role mode property
      phy: tegra: xusb: Add support for power supplies

Yoshihiro Shimoda (3):
      dt-bindings: phy: rcar-gen3-phy-usb2: Revise #phy-cells property
      phy: renesas: rcar-gen3-usb2: Use pdev's device pointer on dev_vdbg()
      phy: renesas: rcar-gen3-usb2: enable/disable independent irqs

Yu Chen (2):
      dt-bindings: phy: Add support for HiSilicon's hi3660 USB PHY
      phy: Add usb phy support for hi3660 Soc of Hisilicon

 Documentation/devicetree/bindings/phy/brcm,stingray-usb-phy.txt       |  32 +++++
 Documentation/devicetree/bindings/phy/fsl,imx8mq-usb-phy.txt          |   3 +
 Documentation/devicetree/bindings/phy/meson-g12a-usb2-phy.txt         |  22 ++++
 Documentation/devicetree/bindings/phy/meson-g12a-usb3-pcie-phy.txt    |  22 ++++
 Documentation/devicetree/bindings/phy/nvidia,tegra124-xusb-padctl.txt |   9 ++
 Documentation/devicetree/bindings/phy/phy-hi3660-usb3.txt             |  26 ++++
 Documentation/devicetree/bindings/phy/phy-mtk-ufs.txt                 |  38 ++++++
 Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt                |  14 +-
 Documentation/devicetree/bindings/phy/rcar-gen2-phy.txt               |  57 +++++++-
 Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt          |  14 +-
 Documentation/devicetree/bindings/phy/rockchip-emmc-phy.txt           |   8 +-
 Documentation/devicetree/bindings/phy/ti,phy-am654-serdes.txt         |  82 ++++++++++++
 Documentation/devicetree/bindings/ufs/ufs-qcom.txt                    |   5 +-
 Documentation/devicetree/bindings/ufs/ufshcd-pltfrm.txt               |   3 +
 MAINTAINERS                                                           |  13 ++
 drivers/phy/amlogic/Kconfig                                           |  22 ++++
 drivers/phy/amlogic/Makefile                                          |   2 +
 drivers/phy/amlogic/phy-meson-g12a-usb2.c                             | 341 ++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.c                        | 413 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/phy/amlogic/phy-meson-gxl-usb2.c                              |  11 +-
 drivers/phy/broadcom/Kconfig                                          |  11 ++
 drivers/phy/broadcom/Makefile                                         |   1 +
 drivers/phy/broadcom/phy-bcm-sr-usb.c                                 | 394 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/phy/freescale/phy-fsl-imx8mq-usb.c                            |  12 ++
 drivers/phy/hisilicon/Kconfig                                         |  10 ++
 drivers/phy/hisilicon/Makefile                                        |   1 +
 drivers/phy/hisilicon/phy-hi3660-usb3.c                               | 233 +++++++++++++++++++++++++++++++++
 drivers/phy/mediatek/Kconfig                                          |  10 ++
 drivers/phy/mediatek/Makefile                                         |   1 +
 drivers/phy/mediatek/phy-mtk-tphy.c                                   |  10 +-
 drivers/phy/mediatek/phy-mtk-ufs.c                                    | 245 +++++++++++++++++++++++++++++++++++
 drivers/phy/mscc/phy-ocelot-serdes.c                                  | 240 +++++++++++++++++++++++++++++++++-
 drivers/phy/phy-core.c                                                |  11 ++
 drivers/phy/qualcomm/phy-qcom-qmp.c                                   | 222 +++++++++++++++++++++++--------
 drivers/phy/qualcomm/phy-qcom-qmp.h                                   |  12 ++
 drivers/phy/qualcomm/phy-qcom-qusb2.c                                 |  11 +-
 drivers/phy/qualcomm/phy-qcom-ufs-i.h                                 |   5 +-
 drivers/phy/qualcomm/phy-qcom-ufs-qmp-14nm.c                          |  25 +---
 drivers/phy/qualcomm/phy-qcom-ufs-qmp-20nm.c                          |  25 +---
 drivers/phy/qualcomm/phy-qcom-ufs.c                                   |  57 +++++---
 drivers/phy/renesas/Kconfig                                           |   2 +-
 drivers/phy/renesas/phy-rcar-gen2.c                                   | 130 +++++++++++++++++--
 drivers/phy/renesas/phy-rcar-gen3-usb2.c                              | 232 ++++++++++++++++++++++++++++-----
 drivers/phy/rockchip/phy-rockchip-emmc.c                              |  30 ++++-
 drivers/phy/socionext/phy-uniphier-usb3hs.c                           |  10 +-
 drivers/phy/socionext/phy-uniphier-usb3ss.c                           |  10 +-
 drivers/phy/tegra/Makefile                                            |   1 +
 drivers/phy/tegra/xusb-tegra186.c                                     | 899 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/phy/tegra/xusb.c                                              |  67 +++++++++-
 drivers/phy/tegra/xusb.h                                              |  35 +++++
 drivers/phy/ti/Kconfig                                                |  12 ++
 drivers/phy/ti/Makefile                                               |   1 +
 drivers/phy/ti/phy-am654-serdes.c                                     | 658 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/phy/ti/phy-ti-pipe3.c                                         | 362 +++++++++++++++++++++++++++++++++++++--------------
 drivers/scsi/ufs/Kconfig                                              |   1 +
 drivers/scsi/ufs/ufs-qcom.c                                           | 114 +++++++++-------
 drivers/scsi/ufs/ufs-qcom.h                                           |   4 +
 include/dt-bindings/phy/phy-am654-serdes.h                            |  13 ++
 include/linux/phy/phy.h                                               |   2 +
 59 files changed, 4889 insertions(+), 367 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/brcm,stingray-usb-phy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/meson-g12a-usb2-phy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/meson-g12a-usb3-pcie-phy.txt
 create mode 100644 Documentation/devicetree/bindings/phy/phy-hi3660-usb3.txt
 create mode 100644 Documentation/devicetree/bindings/phy/phy-mtk-ufs.txt
 create mode 100644 Documentation/devicetree/bindings/phy/ti,phy-am654-serdes.txt
 create mode 100644 drivers/phy/amlogic/phy-meson-g12a-usb2.c
 create mode 100644 drivers/phy/amlogic/phy-meson-g12a-usb3-pcie.c
 create mode 100644 drivers/phy/broadcom/phy-bcm-sr-usb.c
 create mode 100644 drivers/phy/hisilicon/phy-hi3660-usb3.c
 create mode 100644 drivers/phy/mediatek/phy-mtk-ufs.c
 create mode 100644 drivers/phy/tegra/xusb-tegra186.c
 create mode 100644 drivers/phy/ti/phy-am654-serdes.c
 create mode 100644 include/dt-bindings/phy/phy-am654-serdes.h
