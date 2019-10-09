Return-Path: <SRS0=kpxk=YC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19CFFC10F14
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 02:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4E06206C2
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Oct 2019 02:43:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="etjhv8PE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730107AbfJICn4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Oct 2019 22:43:56 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:9888 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbfJICn4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Oct 2019 22:43:56 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d9d496f0000>; Tue, 08 Oct 2019 19:43:59 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 08 Oct 2019 19:43:55 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 08 Oct 2019 19:43:55 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 9 Oct
 2019 02:43:55 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 9 Oct 2019 02:43:55 +0000
Received: from jckuo-lt.nvidia.com (Not Verified[10.19.101.249]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d9d49690001>; Tue, 08 Oct 2019 19:43:54 -0700
From:   JC Kuo <jckuo@nvidia.com>
To:     <gregkh@linuxfoundation.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <kishon@ti.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <nkristam@nvidia.com>, JC Kuo <jckuo@nvidia.com>
Subject: [PATCH v4 0/5] add Tegra194 XUSB host and pad controller support
Date:   Wed, 9 Oct 2019 10:43:38 +0800
Message-ID: <20191009024343.30218-1-jckuo@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1570589039; bh=wD0YW0tDOExnpPAsceTfuNKeWgMo82hLq4A8J+5gNc4=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=etjhv8PEUWcTtdTbnFIDvrkIs6iw0TgUGqR6Z7pi7/fZQSynlYDqRHN00tmvPiylb
         mGbM4hZM7FAU/qr8Quo4TmoZYmHDYegkcvi6CCcLfcx2RfhmI4zrkpCn6DTJCEtQ8j
         TsF/x1rqyt+dGG9FyOkdumOLRi+FYqpi7X+tyV+VJHkNIt1FgfJ/R2PqoElebykDWG
         xJAtR5VTAevMSPPHyZJ0nvIceJGymSDw73TK2CF8+rryhXewf7KhLvQbp0U5rpJyzc
         AquILkPy+h05focfk3DKl4+dkclZgzzyFe5TB5IW0VPWsXcQlqU02BKlrSIgi+l9eV
         z5eoaXWB+jeDQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series introduces support for Tegra194 XUSB host and pad
controller. Tegra194 XUSB host and pad controller are highly
similar to the controllers found on Tegra186. Therefore, it's
possible to resue xhci-tegra.c and xusb-tegra186.c for Tegra194.

Changelog:
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

 .../phy/nvidia,tegra124-xusb-padctl.txt       |  16 ++
 .../arm64/boot/dts/nvidia/tegra194-p2888.dtsi |  36 ++++-
 .../boot/dts/nvidia/tegra194-p2972-0000.dts   |  62 ++++++++
 arch/arm64/boot/dts/nvidia/tegra194.dtsi      | 139 +++++++++++++++++
 drivers/phy/tegra/Makefile                    |   1 +
 drivers/phy/tegra/xusb-tegra186.c             | 144 +++++++++++++-----
 drivers/phy/tegra/xusb.c                      |   7 +
 drivers/phy/tegra/xusb.h                      |   6 +
 8 files changed, 376 insertions(+), 35 deletions(-)

-- 
2.17.1

