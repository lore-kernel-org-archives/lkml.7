Return-Path: <SRS0=fWiu=Y6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0040C5DF62
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 07:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86CC82173B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Nov 2019 07:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="eH7ppx4b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731274AbfKFH1k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Nov 2019 02:27:40 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:60082 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729695AbfKFH1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Nov 2019 02:27:40 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id xA67RcT8102506;
        Wed, 6 Nov 2019 01:27:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1573025258;
        bh=G7b/P+TF83hk/Y8sQQ7gTdJSUvMaW2bpoyLdR8mF0Ss=;
        h=From:To:CC:Subject:Date;
        b=eH7ppx4bFepW4Ktpl8I8MOFJ1Ui1OZX+9lAakVMHiikJ/xGaXNQVklHjCxLNGssQX
         RmmLUv4bj8W0cgZNGU589bIILo2IlSx+KqPyK65cVd88f+fpxeStINHSl+w8gGdxBT
         7dfklsYe7+qAB240uiwQGrzIT7NTEwhLtO5F+Hfs=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xA67RbpG081184
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 6 Nov 2019 01:27:38 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Wed, 6 Nov
 2019 01:27:22 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Wed, 6 Nov 2019 01:27:22 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id xA67Ra3q032711;
        Wed, 6 Nov 2019 01:27:36 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>, <kishon@ti.com>
CC:     <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] PHY: For 5.5 merge window
Date:   Wed, 6 Nov 2019 12:57:02 +0530
Message-ID: <20191106072702.19675-1-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Please find the pull request for 5.5 merge window below.

It adds two new PHY drivers, one for USB3 PHY on Allwinner H6 SoC and the other
video combo PHY on Rockchip Innosilicon. It includes cleanup on some of the
drivers by using helpers like platform_ioremap_resource() and
regulator_bulk_set_supply_names() to simplify code. It also fixes some
of the smatch/sparse warnings.

For the complete list of changes, please see the tag message below.

Let me know if I have to make any changes.

Thanks
Kishon

The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:

  Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kishon/linux-phy.git tags/phy-for-5.5

for you to fetch changes up to 4569e64ab6a590dec418f2cd98fbe907a08fd452:

  phy: phy-rockchip-inno-usb2: add phy description for px30 (2019-10-31 18:27:47 +0530)

----------------------------------------------------------------
phy: for 5.5

  *) Add a new PHY driver for USB3 PHY on Allwinner H6 SoC
  *) Add a new PHY driver for Innosilicon Video Combo PHY(MIPI/LVDS/TTL)
  *) Add support in xusb-tegra210 PHY driver to get USB device mode functional
     in Tegra 210
  *) Add support for SM8150 QMP UFS PHY in phy-qcom-qmp PHY driver
  *) Fix smatch warning (array off by one) in phy-rcar-gen2 PHY driver
  *) Enable mac tx internal delay for rgmii-rxid in phy-gmii-sel driver
  *) Fix phy-qcom-usb-hs from registering multiple extcon notifiers during PHY
     power cycle
  *) Use devm_platform_ioremap_resource() in phy-mvebu-a3700-utmi,
     phy-hisi-inno-usb2, phy-histb-combphy and regulator_bulk_set_supply_names()
     in xusb to simplify code
  *) Remove unused variable in xusb-tegra210 and phy-dm816x-usb
  *) Fix sparse warnings in phy-brcm-usb-init

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>

----------------------------------------------------------------
Bartosz Golaszewski (1):
      phy: tegra: use regulator_bulk_set_supply_names()

Ben Dooks (2):
      phy: phy-brcm-usb-init: fix __iomem annotations
      phy: phy-brcm-usb-init: fix use of integer as pointer

Biju Das (1):
      phy: renesas: phy-rcar-gen2: Fix the array off by one warning

Chunfeng Yun (1):
      phy: tegra: xusb: remove unused variable

Colin Ian King (1):
      phy: xgene: make array serdes_reg static const, makes object smaller

Fabrizio Castro (2):
      dt-bindings: rcar-gen3-phy-usb2: Add r8a774b1 support
      dt-bindings: rcar-gen3-phy-usb3: Add r8a774b1 support

Geert Uytterhoeven (1):
      phy: renesas: rcar-gen3-usb2: Use platform_get_irq_optional() for optional irq

Grygorii Strashko (1):
      phy: ti: gmii-sel: fix mac tx internal delay for rgmii-rxid

Heiko Stuebner (3):
      phy: add PHY_MODE_LVDS
      dt-bindings: phy: add yaml binding for rockchip,px30-dsi-dphy
      phy: phy-rockchip-inno-usb2: add phy description for px30

Icenowy Zheng (1):
      phy: allwinner: add phy driver for USB3 PHY on Allwinner H6 SoC

Markus Elfring (1):
      phy-mvebu-a3700-utmi: Use devm_platform_ioremap_resource() in mvebu_a3700_utmi_phy_probe()

Nagarjuna Kristam (4):
      phy: tegra: xusb: Add XUSB dual mode support on Tegra210
      phy: tegra: xusb: Add usb3 port fake support on Tegra210
      phy: tegra: xusb: Add vbus override support on Tegra210
      phy: tegra: xusb: Add vbus override support on Tegra186

Ondrej Jirman (1):
      dt-bindings: Add bindings for USB3 phy on Allwinner H6

Stephan Gerhold (1):
      phy: qcom-usb-hs: Fix extcon double register after power cycle

Vinod Koul (2):
      dt-bindings: phy-qcom-qmp: Add sm8150 UFS phy compatible string
      phy: qcom-qmp: Add SM8150 QMP UFS PHY support

Wei Yongjun (1):
      phy: lantiq: vrx200-pcie: fix error return code in ltq_vrx200_pcie_phy_power_on()

Wyon Bi (1):
      phy/rockchip: Add support for Innosilicon MIPI/LVDS/TTL PHY

Yoshihiro Shimoda (1):
      phy: renesas: rcar-gen3-usb2: Fix sysfs interface of "role"

YueHaibing (2):
      phy: hisilicon: use devm_platform_ioremap_resource() to simplify code
      phy: ti: dm816x: remove set but not used variable 'phy_data'

 Documentation/devicetree/bindings/phy/allwinner,sun50i-h6-usb3-phy.yaml |  47 ++++++++
 Documentation/devicetree/bindings/phy/phy-rockchip-inno-usb2.txt        |   1 +
 Documentation/devicetree/bindings/phy/qcom-qmp-phy.txt                  |   7 +-
 Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb2.txt            |   2 +
 Documentation/devicetree/bindings/phy/rcar-gen3-phy-usb3.txt            |   2 +
 Documentation/devicetree/bindings/phy/rockchip,px30-dsi-dphy.yaml       |  75 ++++++++++++
 drivers/phy/allwinner/Kconfig                                           |  11 ++
 drivers/phy/allwinner/Makefile                                          |   1 +
 drivers/phy/allwinner/phy-sun50i-usb3.c                                 | 190 ++++++++++++++++++++++++++++++
 drivers/phy/broadcom/phy-brcm-usb-init.c                                |  10 +-
 drivers/phy/hisilicon/phy-hisi-inno-usb2.c                              |   4 +-
 drivers/phy/hisilicon/phy-histb-combphy.c                               |   4 +-
 drivers/phy/lantiq/phy-lantiq-vrx200-pcie.c                             |   3 +-
 drivers/phy/marvell/phy-mvebu-a3700-utmi.c                              |   9 +-
 drivers/phy/phy-xgene.c                                                 |   2 +-
 drivers/phy/qualcomm/phy-qcom-qmp.c                                     | 120 +++++++++++++++++++
 drivers/phy/qualcomm/phy-qcom-qmp.h                                     |  96 +++++++++++++++
 drivers/phy/qualcomm/phy-qcom-usb-hs.c                                  |   7 +-
 drivers/phy/renesas/phy-rcar-gen2.c                                     |   5 +-
 drivers/phy/renesas/phy-rcar-gen3-usb2.c                                |   7 +-
 drivers/phy/rockchip/Kconfig                                            |   8 ++
 drivers/phy/rockchip/Makefile                                           |   1 +
 drivers/phy/rockchip/phy-rockchip-inno-dsidphy.c                        | 805 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/phy/rockchip/phy-rockchip-inno-usb2.c                           |   1 +
 drivers/phy/tegra/xusb-tegra186.c                                       |  23 ++++
 drivers/phy/tegra/xusb-tegra210.c                                       | 137 ++++++++++++++++++++-
 drivers/phy/tegra/xusb.c                                                |  93 ++++++++++++++-
 drivers/phy/tegra/xusb.h                                                |   4 +
 drivers/phy/ti/phy-dm816x-usb.c                                         |   3 -
 drivers/phy/ti/phy-gmii-sel.c                                           |   2 +-
 include/linux/phy/phy.h                                                 |   3 +-
 include/linux/phy/tegra/xusb.h                                          |   4 +-
 32 files changed, 1645 insertions(+), 42 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/allwinner,sun50i-h6-usb3-phy.yaml
 create mode 100644 Documentation/devicetree/bindings/phy/rockchip,px30-dsi-dphy.yaml
 create mode 100644 drivers/phy/allwinner/phy-sun50i-usb3.c
 create mode 100644 drivers/phy/rockchip/phy-rockchip-inno-dsidphy.c
-- 
2.17.1

