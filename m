Return-Path: <SRS0=PwuH=ZJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C42D9C432C0
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 07:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9309C2084C
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Nov 2019 07:21:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbfKQHVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Nov 2019 02:21:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:40736 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725901AbfKQHVU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 02:21:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 11345B221;
        Sun, 17 Nov 2019 07:21:19 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        James Tai <james.tai@realtek.com>
Subject: [PATCH v3 0/8] ARM: Initial RTD1195 and MeLE X1000 support
Date:   Sun, 17 Nov 2019 08:21:01 +0100
Message-Id: <20191117072109.20402-1-afaerber@suse.de>
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

v3 includes various memory range related cleanups and
collects follow-up patches from multiple other series.

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
  ARM: dts: rtd1195: Introduce r-bus
  dt-bindings: reset: Add Realtek RTD1195
  ARM: dts: rtd1195: Add reset nodes
  ARM: dts: rtd1195: Add UART resets
  ARM: realtek: Enable RTD1195 arch timer

 Documentation/devicetree/bindings/arm/realtek.yaml |   6 +
 arch/arm/Kconfig                                   |   2 +
 arch/arm/Makefile                                  |   3 +
 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/rtd1195-mele-x1000.dts           |  31 ++++
 arch/arm/boot/dts/rtd1195.dtsi                     | 162 +++++++++++++++++++++
 arch/arm/mach-realtek/Kconfig                      |  11 ++
 arch/arm/mach-realtek/Makefile                     |   2 +
 arch/arm/mach-realtek/rtd1195.c                    |  53 +++++++
 include/dt-bindings/reset/realtek,rtd1195.h        |  74 ++++++++++
 10 files changed, 346 insertions(+)
 create mode 100644 arch/arm/boot/dts/rtd1195-mele-x1000.dts
 create mode 100644 arch/arm/boot/dts/rtd1195.dtsi
 create mode 100644 arch/arm/mach-realtek/Kconfig
 create mode 100644 arch/arm/mach-realtek/Makefile
 create mode 100644 arch/arm/mach-realtek/rtd1195.c
 create mode 100644 include/dt-bindings/reset/realtek,rtd1195.h

-- 
2.16.4

