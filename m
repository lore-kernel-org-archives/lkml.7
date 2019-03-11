Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F9DC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 22:15:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 79ABE20657
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 22:15:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728271AbfCKWPz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 18:15:55 -0400
Received: from mga01.intel.com ([192.55.52.88]:33616 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727898AbfCKWPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 18:15:54 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2019 15:15:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,468,1544515200"; 
   d="scan'208";a="141133769"
Received: from tthayer-hp-z620.an.intel.com ([10.122.105.146])
  by orsmga002.jf.intel.com with ESMTP; 11 Mar 2019 15:15:52 -0700
From:   thor.thayer@linux.intel.com
To:     lee.jones@linaro.org, arnd@arndb.de, dinguyen@kernel.org,
        linux@armlinux.org.uk, catalin.marinas@arm.com,
        will.deacon@arm.com, peppe.cavallaro@st.com,
        alexandre.torgue@st.com, joabreu@synopsys.com, olof@lixom.net
Cc:     davem@davemloft.net, mcoquelin.stm32@gmail.com,
        mchehab+samsung@kernel.org, mark.rutland@arm.com,
        bjorn.andersson@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        netdev@vger.kernel.org, Thor Thayer <thor.thayer@linux.intel.com>
Subject: [RESEND PATCHv4 0/6] Add SOCFPGA System Manager
Date:   Mon, 11 Mar 2019 17:18:02 -0500
Message-Id: <1552342688-6663-1-git-send-email-thor.thayer@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thor Thayer <thor.thayer@linux.intel.com>

Add MFD driver for SOCFPGA System Manager to handle
System Manager calls differently for ARM32 vs ARM64.
The SOCFPGA System Manager includes registers from several
SOC peripherals.

On ARM32, syscon handles this aggregated register grouping.
Implement System Manager calls as regmap_mmio similar to syscon
for ARM32 SOCFPGA systems.

The ARM64 System Manager can only be accessed from priority
level EL3 so this new MFD driver handles the calls to EL3.

v2 Changes:
Change socfpga_is_s10() to check compatible string.
Add new compatible string for Stratix10 in bindings
    and add proper detection method.
Replace base cast with resource_size_t member.
Change s10_sysmgr_regmap_cfg to altr_sysmgr_regmap_cfg to
    be generic.
Always use 4 byte width.
Initialize the .reg_read and .reg_write in S10 case only.
Remove call to syscon in 32bit ARM case and handle both
    ARM32 and ARM64 in of_sysmgr_register().
Replace IS_ERR_OR_NULL() with IS_ERR().
Remove compatible check functions except phandle function.

v3 Changes:
Create and register regmap in probe().
Lookup functions find registered regmap.
Cleanup of header file.
Fix copyright dates.
Replace global pointer with traditional probe() methodology.

v4 Changes:
Add missing of_node_put().
Add Reviewed-by from v2 for devicetree patch
Add Acked-by for net patch

Thor Thayer (6):
  mfd: altera-sysmgr: Add SOCFPGA System Manager
  Documentation: dt: socfpga: Add S10 System Manager binding
  ARM: socfpga_defconfig: Enable CONFIG_MTD_ALTERA_SYSMGR
  arm64: defconfig: Enable CONFIG_MTD_ALTERA_SYSMGR
  net: stmmac: socfpga: Use shared System Manager driver
  arm64: dts: stratix10: New System Manager compatible

 .../bindings/arm/altera/socfpga-system.txt         |  12 ++
 MAINTAINERS                                        |   6 +
 arch/arm/configs/socfpga_defconfig                 |   1 +
 arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi  |   2 +-
 arch/arm64/configs/defconfig                       |   1 +
 drivers/mfd/Kconfig                                |  10 +
 drivers/mfd/Makefile                               |   1 +
 drivers/mfd/altera-sysmgr.c                        | 211 +++++++++++++++++++++
 .../net/ethernet/stmicro/stmmac/dwmac-socfpga.c    |   5 +-
 include/linux/mfd/altera-sysmgr.h                  |  29 +++
 10 files changed, 275 insertions(+), 3 deletions(-)
 create mode 100644 drivers/mfd/altera-sysmgr.c
 create mode 100644 include/linux/mfd/altera-sysmgr.h

-- 
2.7.4

