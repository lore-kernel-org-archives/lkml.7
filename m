Return-Path: <SRS0=Ba5y=Y3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1559CA9EC7
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 01:37:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AC32220663
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Nov 2019 01:37:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727715AbfKCBhh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Nov 2019 21:37:37 -0400
Received: from mx2.suse.de ([195.135.220.15]:59400 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727335AbfKCBgy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Nov 2019 21:36:54 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6EF21AF23;
        Sun,  3 Nov 2019 01:36:52 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
Subject: [RFC 00/11] ARM: Realtek RTD1195/RTD1295 SoC info
Date:   Sun,  3 Nov 2019 02:36:34 +0100
Message-Id: <20191103013645.9856-1-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series adds a soc bus driver for Realtek RTD1195 and RTD1295 SoC families.

The detection magic for RTD1295 family was mostly borrowed from downstream code
and the bit meanings are entirely undocumented. In case of RTD1293 I had to
invent my own detection logic, possibly flawed.
It is expected that this driver will need to be tweaked as new models emerge.

One general consideration here is that some register accesses are not well
self-contained within a block so that a syscon might in theory help - but
for lack of documentation we don't really have an overview of the IP blocks
and their names, starts and sizes; downstream trees just hardcoded addresses.

I therefore split off the DT change to add a second/third reg entry for now,
so that we could move ahead with a basic driver initially.

We have no RTD1294 DT, so it is included here mainly for illustration of the
unpredictable register dependencies affecting this binding/driver.

Using reg-names might clean this up a little but would blow up the driver code
as there appears to be no handy helper function provided.

Finally, I've been struggling to find an overarching name for the SoC families.
Realtek.com groups them as "Digital Home Center" - not sure whether that fits?
For now I use Phoenix/Kylin/etc. with DHC only as fallback, but I wonder
whether those family names should rather be soc_id than family contents?

Prepared but not included here is:
* RTD1395 family, which we don't have a DT for yet,
* RTD1619 family, which we don't have a DT for yet, Chip ID to be verified,
* RTD1319 family, which we don't have a DT for yet, with TODO for its Chip ID.

Latest experimental patches at:
https://github.com/afaerber/linux/commits/rtd1295-next

Have a lot of fun!

Cheers,
Andreas

Cc: devicetree@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>

Andreas Färber (11):
  dt-bindings: soc: Add Realtek RTD1195 chip info binding
  soc: Add Realtek chip info driver for RTD1195 and RTD1295
  arm64: dts: realtek: rtd129x: Add chip info node
  ARM: dts: rtd1195: Add chip info node
  dt-bindings: soc: realtek: rtd1195-chip: Extend reg property
  soc: realtek: chip: Detect RTD1296
  arm64: dts: realtek: rtd129x: Extend chip-info reg with CHIP_INFO1
  soc: realtek: chip: Detect RTD1293
  dt-bindings: soc: realtek: rtd1195-chip: Extend reg node again
  soc: realtek: chip: Detect RTD1294
  arm64: dts: realtek: rtd129x: Extend chip-info reg with efuse

 .../bindings/soc/realtek/realtek,rtd1195-chip.yaml |  47 +++++
 MAINTAINERS                                        |   1 +
 arch/arm/boot/dts/rtd1195.dtsi                     |   5 +
 arch/arm64/boot/dts/realtek/rtd129x.dtsi           |   7 +
 drivers/soc/Kconfig                                |   1 +
 drivers/soc/Makefile                               |   1 +
 drivers/soc/realtek/Kconfig                        |  13 ++
 drivers/soc/realtek/Makefile                       |   2 +
 drivers/soc/realtek/chip.c                         | 190 +++++++++++++++++++++
 9 files changed, 267 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/realtek/realtek,rtd1195-chip.yaml
 create mode 100644 drivers/soc/realtek/Kconfig
 create mode 100644 drivers/soc/realtek/Makefile
 create mode 100644 drivers/soc/realtek/chip.c

-- 
2.16.4

