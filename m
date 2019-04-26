Return-Path: <SRS0=fl2C=S4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1ECCC43219
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 23:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8787221537
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Apr 2019 23:07:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727156AbfDZXHT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Apr 2019 19:07:19 -0400
Received: from smtp-out.xnet.cz ([178.217.244.18]:24777 "EHLO smtp-out.xnet.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727008AbfDZXHT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Apr 2019 19:07:19 -0400
Received: from meh.true.cz (meh.true.cz [108.61.167.218])
        (Authenticated sender: petr@true.cz)
        by smtp-out.xnet.cz (Postfix) with ESMTPSA id 6BF9236B8;
        Sat, 27 Apr 2019 01:07:14 +0200 (CEST)
Received: by meh.true.cz (OpenSMTPD) with ESMTP id 6680faef;
        Sat, 27 Apr 2019 01:07:12 +0200 (CEST)
From:   =?UTF-8?q?Petr=20=C5=A0tetiar?= <ynezz@true.cz>
To:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Alban Bedel <albeu@free.fr>,
        =?UTF-8?q?Petr=20=C5=A0tetiar?= <ynezz@true.cz>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 0/4] of_net: Add NVMEM support to of_get_mac_address
Date:   Sat, 27 Apr 2019 01:06:38 +0200
Message-Id: <1556320002-26213-1-git-send-email-ynezz@true.cz>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this patch series is a continuation of my previous attempt[1], where I've
tried to wire MTD layer into of_get_mac_address, so it would be possible to
load MAC addresses from various NVMEMs as EEPROMs etc.

Predecessor of this patch which used directly MTD layer has originated in
OpenWrt some time ago and supports already about 497 use cases in 357
device tree files.

During the review process of my 1st attempt I was told, that I shouldn't be
using MTD directly, but I should rather use new NVMEM subsystem, so this
patch series tries to accommodate that.

First patch is wiring NVMEM support directly into of_get_mac_address as
it's obvious, that adding support for NVMEM into every other driver would
mean adding a lot of repetitive code. This patch allows us to configure MAC
addresses in various devices like ethernet and wireless adapters directly
from of_get_mac_address, which is used by quite a lot of drivers in the
tree already.

Second patch is simply updating documentation with NVMEM bits, also adding
some missing bits like mac-address and local-mac-address properties, which
are currently supported by of_get_mac_address.

Third and fourth patches are simply removing duplicate NVMEM code which is
no longer needed as the first patch has added NVMEM support directly into
of_get_mac_address.

Just for a better picture, this patch series and one simple patch[2] on top
of it, allows me to configure 8Devices Carambola2 board's MAC addresses
with following DTS (simplified):

 &spi {
 	flash@0 {
 		partitions {
			art: partition@ff0000 {
				label = "art";
				reg = <0xff0000 0x010000>;
				read-only;

				nvmem-cells {
					compatible = "nvmem-cells";
					#address-cells = <1>;
					#size-cells = <1>;

					eth0_addr: eth-mac-addr@0 {
						reg = <0x0 0x6>;
					};

					eth1_addr: eth-mac-addr@6 {
						reg = <0x6 0x6>;
					};

					wmac_addr: wifi-mac-addr@1002 {
						reg = <0x1002 0x6>;
					};
				};
			};
		};
	};
 };

 &eth0 {
	nvmem-cells = <&eth0_addr>;
	nvmem-cell-names = "mac-address";
 };

 &eth1 {
	nvmem-cells = <&eth1_addr>;
	nvmem-cell-names = "mac-address";
 };

 &wmac {
	nvmem-cells = <&wmac_addr>;
	nvmem-cell-names = "mac-address";
 };


1. https://patchwork.ozlabs.org/patch/1086628/
2. https://patchwork.ozlabs.org/patch/890738/

-- ynezz

Petr Štetiar (4):
  of_net: Add NVMEM support to of_get_mac_address
  dt-bindings: doc: Reflect new NVMEM of_get_mac_address behaviour
  net: macb: Drop nvmem_get_mac_address usage
  net: davinci_emac: Drop nvmem_get_mac_address usage

 .../devicetree/bindings/net/altera_tse.txt         |  3 ++
 Documentation/devicetree/bindings/net/arc_emac.txt |  4 ++
 .../devicetree/bindings/net/brcm,amac.txt          |  3 ++
 .../devicetree/bindings/net/brcm,bcmgenet.txt      |  5 +++
 .../devicetree/bindings/net/brcm,systemport.txt    |  4 ++
 .../devicetree/bindings/net/cavium-mix.txt         |  7 +++-
 .../devicetree/bindings/net/cavium-pip.txt         |  5 +++
 Documentation/devicetree/bindings/net/cpsw.txt     |  3 ++
 .../devicetree/bindings/net/davicom-dm9000.txt     |  4 ++
 .../devicetree/bindings/net/davinci_emac.txt       |  2 +
 Documentation/devicetree/bindings/net/dsa/dsa.txt  |  7 ++--
 .../devicetree/bindings/net/emac_rockchip.txt      |  4 ++
 Documentation/devicetree/bindings/net/ethernet.txt |  2 +
 .../devicetree/bindings/net/ezchip_enet.txt        |  6 +++
 Documentation/devicetree/bindings/net/fsl-fec.txt  |  4 ++
 .../devicetree/bindings/net/fsl-tsec-phy.txt       |  4 ++
 .../devicetree/bindings/net/hisilicon-femac.txt    |  3 ++
 .../bindings/net/hisilicon-hix5hd2-gmac.txt        |  3 ++
 .../devicetree/bindings/net/keystone-netcp.txt     |  9 ++--
 Documentation/devicetree/bindings/net/macb.txt     |  8 ++--
 .../devicetree/bindings/net/marvell-orion-net.txt  |  3 ++
 .../devicetree/bindings/net/marvell-pxa168.txt     |  3 ++
 .../devicetree/bindings/net/microchip,enc28j60.txt |  3 ++
 .../devicetree/bindings/net/microchip,lan78xx.txt  |  2 +
 .../devicetree/bindings/net/opencores-ethoc.txt    |  4 ++
 .../devicetree/bindings/net/oxnas-dwmac.txt        |  6 +++
 .../devicetree/bindings/net/qca,qca7000.txt        |  3 ++
 .../devicetree/bindings/net/samsung-sxgbe.txt      |  3 ++
 .../bindings/net/snps,dwc-qos-ethernet.txt         |  2 +
 .../devicetree/bindings/net/socfpga-dwmac.txt      |  4 ++
 .../bindings/net/socionext,uniphier-ave4.txt       |  3 ++
 .../devicetree/bindings/net/socionext-netsec.txt   |  2 +
 Documentation/devicetree/bindings/net/stmmac.txt   |  4 ++
 .../bindings/net/wireless/mediatek,mt76.txt        |  2 +
 .../devicetree/bindings/net/wireless/qca,ath9k.txt |  2 +
 .../devicetree/bindings/soc/fsl/cpm_qe/qe/ucc.txt  |  3 ++
 drivers/net/ethernet/cadence/macb_main.c           | 12 ++----
 drivers/net/ethernet/ti/davinci_emac.c             | 14 +++----
 drivers/of/of_net.c                                | 48 +++++++++++++++++++---
 39 files changed, 179 insertions(+), 34 deletions(-)

-- 
1.9.1

