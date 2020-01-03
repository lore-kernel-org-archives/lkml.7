Return-Path: <SRS0=3Pgh=2Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44E56C32767
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 08:18:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BF5A222C4
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jan 2020 08:18:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="He0cTCOw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbgACISV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jan 2020 03:18:21 -0500
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:17270 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbgACISU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jan 2020 03:18:20 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e0ef8a00000>; Fri, 03 Jan 2020 00:17:36 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 03 Jan 2020 00:18:19 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 03 Jan 2020 00:18:19 -0800
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 3 Jan
 2020 08:18:19 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 3 Jan 2020 08:18:19 +0000
Received: from jckuo-lt.nvidia.com (Not Verified[10.19.108.118]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e0ef8c90000>; Fri, 03 Jan 2020 00:18:18 -0800
From:   JC Kuo <jckuo@nvidia.com>
To:     <gregkh@linuxfoundation.org>, <thierry.reding@gmail.com>,
        <robh@kernel.org>, <jonathanh@nvidia.com>, <kishon@ti.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <nkristam@nvidia.com>, JC Kuo <jckuo@nvidia.com>
Subject: [PATCH v5 0/5] add Tegra194 XUSB host and pad controller support
Date:   Fri, 3 Jan 2020 16:18:09 +0800
Message-ID: <20200103081814.9848-1-jckuo@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1578039456; bh=X4mjGDVLvOOMu/CS3QJZ3IdBByzNIMa6AL45A4t9lns=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=He0cTCOwtP8g6qSPimI+NDkH7F+JLDLil9kihoklJw0rJ3eHBXe14F9kXpF/UoBZs
         ryKacQfOzrf2uxRHGSPjeOlRW0CKwK3beXbbBgBUwyGFttfpemaNhpMpO53fYaP/B2
         QOA1RXpbx7uBMttqhCT3pEhb7ibaFjZ/DdAECdE7UN1ltl3GnLgxOMo0D9zKHul6Ie
         447mKg6LkvlhYL5aWKQxsgiEF2teJyY9IJDbRg0LDgXLPGTPIhRZFwadQjFXZGJzpP
         GDd/FjafmHzzKv3go38Ca3ybcWu8qhLxaVU3SEjVUnx0Pl/b9IWZZT4uod1WuAJmsS
         PIfNiXBA56ueA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series introduces support for Tegra194 XUSB host and pad
controller. Tegra194 XUSB host and pad controller are highly
similar to the controllers found on Tegra186. Therefore, it's
possible to resue xhci-tegra.c and xusb-tegra186.c for Tegra194.

Changelog:
v5:
  phy: tegra: xusb: Protect Tegra186 soc with config
   - no change

  phy: tegra: xusb: Add Tegra194 support
   - re-use "maximum-speed" instead of adding "nvidia,disable-gen2"

  dt-bindings: phy: tegra: Add Tegra194 support
   - re-use "maximum-speed" instead of adding "nvidia,disable-gen2"

  arm64: tegra: Add XUSB and pad controller on Tegra194
   - no change

  arm64: tegra: Enable XUSB host in P2972-0000 board
   - no change

v4:
  xhci: tegra: Parameterize mailbox register addresses
   - removed from v4 as it has been accepted in v3
  
  usb: host: xhci-tegra: Add Tegra194 XHCI support
   - removed from v4 as it has been accepted in v3

  phy: tegra: xusb: Add Tegra194 support
   - no change

  dt-bindings: phy: tegra: Add Tegra194 support
   - no change

  arm64: tegra: Add XUSB and pad controller on Tegra194
   - no change

  arm64: tegra: Enable XUSB host in P2972-0000 board
   - no change

v3:
  add change log to cover latter

v2:
  xhci: tegra: Parameterize mailbox register addresses
   - no change

  usb: host: xhci-tegra: Add Tegra194 XHCI support
   - no change

  phy: tegra: xusb: Protect Tegra186 soc with config
   - new patch to protect Tegra186 soc data with config

  phy: tegra: xusb: Add Tegra194 support
   - removed unnecessary #if/#endif pairs
   - introduce new soc->supports_gen2 flag which indicate whether or not
     a soc supports USB 3.1 Gen 2 speed

  dt-bindings: phy: tegra: Add Tegra194 support
   - fix a typo

  arm64: tegra: Add XUSB and pad controller on Tegra194
   - renamed xhci@3610000 with usb@3610000
   - moved padctl@3520000 and usb@3610000 inside /cbb
   - cleaned up "clocks" property of usb@3610000 node
   - added blanks lines to visually separate blocks

  arm64: tegra: Enable XUSB host in P2972-0000 board
   - use capitalization of regulator names
   - fix gpio property of VDD_5V_SATA regulator

JC Kuo (5):
  phy: tegra: xusb: Protect Tegra186 soc with config
  phy: tegra: xusb: Add Tegra194 support
  dt-bindings: phy: tegra: Add Tegra194 support
  arm64: tegra: Add XUSB and pad controller on Tegra194
  arm64: tegra: Enable XUSB host in P2972-0000 board

 .../phy/nvidia,tegra124-xusb-padctl.txt       |  18 +++
 .../arm64/boot/dts/nvidia/tegra194-p2888.dtsi |  36 ++++-
 .../boot/dts/nvidia/tegra194-p2972-0000.dts   |  63 ++++++++
 arch/arm64/boot/dts/nvidia/tegra194.dtsi      | 139 +++++++++++++++++
 drivers/phy/tegra/Makefile                    |   1 +
 drivers/phy/tegra/xusb-tegra186.c             | 143 +++++++++++++-----
 drivers/phy/tegra/xusb.c                      |  17 +++
 drivers/phy/tegra/xusb.h                      |   5 +
 8 files changed, 387 insertions(+), 35 deletions(-)

-- 
2.17.1

