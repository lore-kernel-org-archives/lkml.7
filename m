Return-Path: <SRS0=E2Zf=ZP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C295BC432C3
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 20:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A43BC204FD
	for <linux-kernel@archiver.kernel.org>; Sat, 23 Nov 2019 20:38:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfKWUiK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 Nov 2019 15:38:10 -0500
Received: from mx2.suse.de ([195.135.220.15]:34298 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726638AbfKWUiK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Nov 2019 15:38:10 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A8DD3ADB3;
        Sat, 23 Nov 2019 20:38:08 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        James Tai <james.tai@realtek.com>
Subject: [PATCH v4 0/8] ARM: Initial RTD1195 and MeLE X1000 & Horseradish support
Date:   Sat, 23 Nov 2019 21:37:51 +0100
Message-Id: <20191123203759.20708-1-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series adds initial support for Realtek RTD1195 SoC
and adds a Device Tree for the MeLE X1000 TV set-top-box.

v4 includes more memory range related cleanups, adds a DT
and drops the reset patches again for a follow-up series.

The final patch is still in need of feedback from Realtek
for how to name and handle this magic register and bit(s).

SMP (i.e., the second core) is still dependent on two new
bindings/drivers.

More details on the device at:
https://en.opensuse.org/HCL:Mele_X1000

Latest experimental patches at:
https://github.com/afaerber/linux/commits/rtd1295-next

Have a lot of fun!

Cheers,
Andreas

v3 -> v4:
* Insert memory range between r-bus and NOR flash
* Exclude boot ROM from memory ranges
* Add Horseradish EVB
* Drop reset patches (James)

v2 -> v3:
* Incorporate cleanup patches from RTD1395 series
* Fixed r-bus size (James)
* Fixed r-bus node name (Rob)
* Include reset patches from RTD1295 reset series, rebased onto r-bus

v1 -> v2:
* Do not redundantly select COMMON_CLK (Arnd)
* Drop further unneeded selects
* Clean up memory reservations (Rob)
* Enable arch timer

Cc: devicetree@vger.kernel.org
Cc: Rob Herring <robh@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: James Tai <james.tai@realtek.com>

Andreas Färber (8):
  dt-bindings: arm: realtek: Add RTD1195 and MeLE X1000
  ARM: Prepare Realtek RTD1195
  ARM: dts: Prepare Realtek RTD1195 and MeLE X1000
  ARM: dts: rtd1195: Exclude boot ROM from memory ranges
  ARM: dts: rtd1195: Introduce r-bus
  dt-bindings: arm: realtek: Add Realtek Horseradish EVB
  ARM: dts: rtd1195: Add Realtek Horseradish EVB
  ARM: realtek: Enable RTD1195 arch timer

 Documentation/devicetree/bindings/arm/realtek.yaml |   7 ++
 arch/arm/Kconfig                                   |   2 +
 arch/arm/Makefile                                  |   3 +
 arch/arm/boot/dts/Makefile                         |   3 +
 arch/arm/boot/dts/rtd1195-horseradish.dts          |  32 +++++
 arch/arm/boot/dts/rtd1195-mele-x1000.dts           |  32 +++++
 arch/arm/boot/dts/rtd1195.dtsi                     | 139 +++++++++++++++++++++
 arch/arm/mach-realtek/Kconfig                      |  11 ++
 arch/arm/mach-realtek/Makefile                     |   2 +
 arch/arm/mach-realtek/rtd1195.c                    |  56 +++++++++
 10 files changed, 287 insertions(+)
 create mode 100644 arch/arm/boot/dts/rtd1195-horseradish.dts
 create mode 100644 arch/arm/boot/dts/rtd1195-mele-x1000.dts
 create mode 100644 arch/arm/boot/dts/rtd1195.dtsi
 create mode 100644 arch/arm/mach-realtek/Kconfig
 create mode 100644 arch/arm/mach-realtek/Makefile
 create mode 100644 arch/arm/mach-realtek/rtd1195.c

-- 
2.16.4

