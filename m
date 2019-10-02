Return-Path: <SRS0=zem1=X3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62A8AC352AA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 08:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33B7A20659
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Oct 2019 08:01:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="f/kfJ2Z4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbfJBIBK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Oct 2019 04:01:10 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:10645 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfJBIBK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Oct 2019 04:01:10 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d94594d0001>; Wed, 02 Oct 2019 01:01:17 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Wed, 02 Oct 2019 01:01:09 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Wed, 02 Oct 2019 01:01:09 -0700
Received: from HQMAIL109.nvidia.com (172.20.187.15) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 2 Oct
 2019 08:01:09 +0000
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 2 Oct
 2019 08:01:08 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 2 Oct 2019 08:01:08 +0000
Received: from jckuo-lt.nvidia.com (Not Verified[10.19.108.102]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d9459420001>; Wed, 02 Oct 2019 01:01:08 -0700
From:   JC Kuo <jckuo@nvidia.com>
To:     <gregkh@linuxfoundation.org>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>
CC:     <linux-tegra@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <nkristam@nvidia.com>, <skomatineni@nvidia.com>,
        JC Kuo <jckuo@nvidia.com>
Subject: [PATCH 0/6] Add Tegra194 XUSB host and pad controller support
Date:   Wed, 2 Oct 2019 16:00:45 +0800
Message-ID: <20191002080051.11142-1-jckuo@nvidia.com>
X-Mailer: git-send-email 2.17.1
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1570003277; bh=GPsfBTidovLb2EyOvodPKq1ls7/+8VJte+CoYWlCP9U=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=f/kfJ2Z4WLBQvca2iLEg7VNTHZcvk3N00+I2egWM6rdpbMhms9ec+3VchiWvsbIys
         iYu6pOqLeue1kmDUDttxTIzmTn7VEkYkf6tM4KQRwADdol0nAkwdTVF5crXhVDYeq6
         pOqwP7uunoMkPx5O73iLLW0lhypMtJ1cKFElbOCulEY3pOmtvVdBraoMQ2jJ2iC26Z
         AUMRhvJ2vWepYymNAKoOG1Qe35wM9xde306TTkHj2QCZENN1/ei/foj1GkQPg2//tA
         gMAm9UHI/iHB5ksQNvaIkm4SgtI7Iv7sLiIQK1RUnwzK272yQ9Y83JetgyedtoELw1
         ATGBvSpgwkRlw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series introduces support for Tegra194 XUSB host and pad 
controller. Tegra194 XUSB host and pad controller are highly
similar to the controllers found on Tegra186. Therefore, we
decided to resue xhci-tegra.c and xusb-tegra186.c for Tegra194.

JC Kuo (6):
  xhci: tegra: Parameterize mailbox register addresses
  usb: host: xhci-tegra: Add Tegra194 XHCI support
  phy: tegra: xusb: Add Tegra194 support
  dt-bindings: phy: tegra: Add Tegra194 support
  arm64: tegra: Add XUSB and pad controller on Tegra194
  arm64: tegra: Enable XUSB host in P2972-0000 board

 .../phy/nvidia,tegra124-xusb-padctl.txt       |  16 +++
 .../arm64/boot/dts/nvidia/tegra194-p2888.dtsi |  31 ++++-
 .../boot/dts/nvidia/tegra194-p2972-0000.dts   |  59 ++++++++
 arch/arm64/boot/dts/nvidia/tegra194.dtsi      | 130 ++++++++++++++++++
 drivers/phy/tegra/Makefile                    |   1 +
 drivers/phy/tegra/xusb-tegra186.c             |  77 +++++++++++
 drivers/phy/tegra/xusb.c                      |  13 ++
 drivers/phy/tegra/xusb.h                      |   4 +
 drivers/usb/host/xhci-tegra.c                 |  88 +++++++++---
 9 files changed, 402 insertions(+), 17 deletions(-)

-- 
2.17.1

