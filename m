Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD887C433FF
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 23:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D1F2206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 23:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="izk76Jg7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbfHMXgT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 19:36:19 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:58944 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbfHMXgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 19:36:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1565739379; x=1597275379;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hJ0wcybIy8p5lozhUIdtK566sZh2c4A4f6FV+GFHlHc=;
  b=izk76Jg7uzPl9TTanVLCxw+kb8tMYBp1fdYa0J5bPGd3ehBkzw2e3W54
   TL8pZb4fpK1pc0Zt/gzOdA1YpbYQ4Xb/pah5dpZn2osFaziLhfinNhoEq
   Hj3LvnGGG9FePLY2pC5u2b2yqyw5niQiTfQas5vOC2pp2bmkGd0up/DK7
   7pWXE+taDSnmg3xgXvMCmRzEGQF8gC5Z37v30m/jlCbUlft4t3KqSnKo5
   oWvvkkL4E/NltYSarQjZDapRNJuofaiv3FzW4Zh9tF4pvAgOwQ9HrNCl5
   POyZQa2QRh392XBN5ivBztNpVg0s/w3KlxjYc/5RsRLiogCfzC8I/7njV
   A==;
IronPort-SDR: D/8LcQ6T+0QqG/0frjsX0n85iA5vtb2d9NLirVVFFli1Gpd1tsofqM0QCyrE4dviRRxpAPKLrl
 RvUELTJIsWSkuAHEokk8L+yT3VmNoRGQa8Qi4nPJXwLmO54GrlQN0H7Nmy7/X/GtxeJyw4qih/
 kF7ItpKQdGpNAXOvBKy3K4SZZFQ9aharUcm2LtyBH7Rd9RLIp50FTgJYT+4gA45hElzhGsdKYC
 7/XDCogMPrMmD15c06hfgsc9cGRLClcDnireKMsx1CqByvbrzxHlZ63YMG5LVTv2Zv99lzLNIg
 VTc=
X-IronPort-AV: E=Sophos;i="5.64,382,1559491200"; 
   d="scan'208";a="120378575"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 14 Aug 2019 07:36:19 +0800
IronPort-SDR: JO6W7a+S/HJmWgqKzy6HyUz73paSJNE+JzMJRrT/UsJu+7W+IpH6vScYp6uufJ2/rF3Bk1zuc8
 9zWdbLWo85mAp1m9W50B+S9VfuWDIy9+HEegCqFno2RBuRkQG0F2jDrWr7J3YFvn9VqzK24E9V
 Zw2HNZ4bbmBD1cGL8KNWwdqlN0d1X6TSkL4vHegX7q3xooSOJhXPFHM6pHT2IeBzGdsCJXg2tF
 /ZYJDL/iR/2q55XLit40lm+mwVsP1+HIYEhu8ouDE2JJpVZ1ua316pDYgFA+OKk+u3l62anH5W
 HTGeb/UDkLqzj0h5oBOgU65B
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2019 16:33:53 -0700
IronPort-SDR: ynWM70NmSGSvm/NBmL4NJAHKIplLilDhmM0Icvg9oUo2nD7XK7CY1V7Xtlq1hKhgdt7gMKOcVo
 xwyOruqZ1/sWh9jdqv942QJsZgxOpMb9Fy2ECnCJKchmDbNBVLpHZ8op+Exa3K7WAyMIKRBnR5
 rq/hh5QY4tcCW5zefAvYI2F4KLsxfbGXM0CD7Te0dYo4/AZhZ2fkiQEOINbdEndJ3qhudjQy8H
 2beb3ouwLSBCofBJtZN9spTyo2PkQHkd6AUOD501Mv/xVpRseLZGM4a+eA1lobG0HZZwLUPTGI
 ssY=
Received: from risc6-mainframe.sdcorp.global.sandisk.com (HELO risc6-mainframe.int.fusionio.com) ([10.196.157.58])
  by uls-op-cesaip02.wdc.com with ESMTP; 13 Aug 2019 16:36:19 -0700
From:   Alistair Francis <alistair.francis@wdc.com>
To:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Cc:     alistair23@gmail.com, Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 1/2] riscv: rv32_defconfig: Update the defconfig
Date:   Tue, 13 Aug 2019 16:32:29 -0700
Message-Id: <20190813233230.21804-1-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the rv32_defconfig:
 - Add 'CONFIG_DEVTMPFS_MOUNT=y' to match the RISC-V defconfig
 - Add CONFIG_HW_RANDOM=y and CONFIG_HW_RANDOM_VIRTIO=y to enable
   VirtIORNG when running on QEMU

Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 arch/riscv/configs/rv32_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/riscv/configs/rv32_defconfig b/arch/riscv/configs/rv32_defconfig
index d5449ef805a3..7da93e494445 100644
--- a/arch/riscv/configs/rv32_defconfig
+++ b/arch/riscv/configs/rv32_defconfig
@@ -34,6 +34,7 @@ CONFIG_PCIEPORTBUS=y
 CONFIG_PCI_HOST_GENERIC=y
 CONFIG_PCIE_XILINX=y
 CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_BLK_DEV_LOOP=y
 CONFIG_VIRTIO_BLK=y
 CONFIG_BLK_DEV_SD=y
@@ -53,6 +54,8 @@ CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_OF_PLATFORM=y
 CONFIG_SERIAL_EARLYCON_RISCV_SBI=y
 CONFIG_HVC_RISCV_SBI=y
+CONFIG_HW_RANDOM=y
+CONFIG_HW_RANDOM_VIRTIO=y
 # CONFIG_PTP_1588_CLOCK is not set
 CONFIG_DRM=y
 CONFIG_DRM_RADEON=y
-- 
2.22.0

