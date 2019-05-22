Return-Path: <SRS0=sxVn=TW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50CBDC282CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 16:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2680E21473
	for <linux-kernel@archiver.kernel.org>; Wed, 22 May 2019 16:21:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="hJkryzLG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730143AbfEVQVU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 May 2019 12:21:20 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:49362 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730067AbfEVQVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 May 2019 12:21:09 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id x4MGKdr8102263;
        Wed, 22 May 2019 11:20:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1558542039;
        bh=Gpb1vaUdYj+cDL8YzUJEgAabIosE4tzV3esirEzT5bc=;
        h=From:To:CC:Subject:Date;
        b=hJkryzLGiqUHyZsDkaWVfinO/co2x5l0xtABReY1fM9yvC2pLvFu68aNHRfIE+j6m
         3F7pCq5vpxFYQFEzOAVSxEvQdhG1wqbQ5LEZp6+UwLGDUFHKJpfFRz0gEYZNs2fwoK
         Gk5/RUivXFH7r8IUST5s9Bwwqi6WT76wgNQHdpao=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id x4MGKdFP099352
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 22 May 2019 11:20:39 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5; Wed, 22
 May 2019 11:20:38 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1713.5 via
 Frontend Transport; Wed, 22 May 2019 11:20:38 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id x4MGKceh104530;
        Wed, 22 May 2019 11:20:38 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-serial@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tony Lindgren <tony@atomide.com>,
        Russell King <linux@armlinux.org.uk>,
        Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>
Subject: [PATCH 0/6] arm64: Initial support Texas Instrument's J721E Platform
Date:   Wed, 22 May 2019 11:19:15 -0500
Message-ID: <20190522161921.20750-1-nm@ti.com>
X-Mailer: git-send-email 2.21.0.777.g83232e38648b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series adds support for the latest new SoC, J721E, from Texas Instruments.

The series is an based off v5.2-rc1 and has the following driver
dependencies for a successful boot:
1.  https://lore.kernel.org/lkml/20190429131533.25122-1-afd@ti.com (for newer firmware)
2.  https://lore.kernel.org/linux-arm-kernel/1555093342-428-1-git-send-email-t-kristo@ti.com/
    - Clock IDs cannot be guarenteed to be sequential, has to be
      discovered from hardware description in dts
    - Clock IDs on this massive chip also exceeds 255, so, the support
      for the same is expected in follow on patches.

The full series is available here (including dependencies):
https://github.com/nmenon/linux-2.6-playground/commits/upstream/v5.2-rc1/j7es-base-v1

Boot Log: https://pastebin.ubuntu.com/p/j3NtfF8FQr/

NOTE:
 - If Greg is ok, we can pick up the uart compatibility via the k3 tree,
   else, I can spawn it off the series.
 - I will resubmit patch 6 (defconfig update) separately once again once
   patches 1-5 hit the next tree or for 5.3-rc2 which ever is convenient.

The J721E SoC belongs to the K3 Multicore SoC architecture platform
for automotive applications such as infotainment, cluster, premium
Audio, Gateway, industrial and a range of broad market applications.
This SoC is designed around reducing the system cost by eliminating
the need of an external system MCU and is targeted towards ASIL-B/C
certification/requirements in addition to allowing complex software
and system use-cases.

The Linux development follows AM654 in most of the configurations, but
adds new capabilities (details in follow on patches).

See J721E Technical Reference Manual (SPRUIL1, May 2019)
for further details: http://www.ti.com/lit/pdf/spruil1

Nishanth Menon (6):
  dt-bindings: arm: ti: Add bindings for J721E SoC
  dt-bindings: serial: 8250_omap: Add compatible for J721E UART
    controller
  arm64: dts: ti: Add Support for J721E SoC
  soc: ti: Add Support for J721E SoC config option
  arm64: dts: ti: Add support for J721E Common Processor Board
  arm64: defconfig: Enable TI's J721E SoC platform

 .../devicetree/bindings/arm/ti/k3.txt         |   3 +
 .../bindings/serial/omap_serial.txt           |   1 +
 arch/arm64/boot/dts/ti/Makefile               |   2 +
 .../dts/ti/k3-j721e-common-proc-board.dts     |  50 +++++
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi     | 202 ++++++++++++++++++
 .../boot/dts/ti/k3-j721e-mcu-wakeup.dtsi      |  72 +++++++
 arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi   |  29 +++
 arch/arm64/boot/dts/ti/k3-j721e.dtsi          | 176 +++++++++++++++
 arch/arm64/configs/defconfig                  |   1 +
 drivers/soc/ti/Kconfig                        |   5 +
 10 files changed, 541 insertions(+)
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721e-common-proc-board.dts
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721e.dtsi

-- 
2.21.0.777.g83232e38648b

