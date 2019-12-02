Return-Path: <SRS0=LniW=ZY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9177EC432C3
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 10:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 719BC20718
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Dec 2019 10:29:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727414AbfLBK3V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Dec 2019 05:29:21 -0500
Received: from mx2.suse.de ([195.135.220.15]:57468 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726330AbfLBK3U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 05:29:20 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id BAD3EB220;
        Mon,  2 Dec 2019 10:29:18 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        James Tai <james.tai@realtek.com>
Subject: [PATCH v2 0/9] arm64: dts: realtek: Initial RTD1395 and BPi-M4 / Lion Skin support
Date:   Mon,  2 Dec 2019 11:29:01 +0100
Message-Id: <20191202102910.26916-1-afaerber@suse.de>
X-Mailer: git-send-email 2.16.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch series adds initial Device Trees for Realtek RTD1395 SoC and
Banana Pi BPI-M4 SBC and (new in v2) Realtek Lion Skin EVB.

It is based on my RTD1195 series and James' RTD1619 series.

It starts with some refactorings to align the various SoCs and then
introduces an r-bus node and goes on to properly shadow RAM areas.

RTD1395 family seems pretty similar to RTD1295 family, but allows for more RAM,
and it uses a different reserved memory region for RPC.
RTD1295 resets appear sufficiently compatible for now (no documentation yet).

More details at:
https://en.opensuse.org/HCL:BananaPi_M4

Latest experimental patches at:
https://github.com/afaerber/linux/commits/rtd1295-next

Have a lot of fun!

Cheers,
Andreas

v1 -> v2:
* RTD1195 patches squashed/moved into RTD1195 v3 series
* Fixed RTD1295 r-bus size (James)
* Use #address-cells/#size-cells of 1 (James)
* Add/update patches to carve out boot ROM from RAM (Rob/James)
* Add patches adding RTD1395 Lion Skin EVB

Cc: devicetree@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>
Cc: James Tai <james.tai@realtek.com>

Andreas Färber (9):
  arm64: dts: realtek: rtd129x: Fix GIC CPU masks for RTD1293
  arm64: dts: realtek: rtd129x: Use reserved-memory for RPC regions
  arm64: dts: realtek: rtd129x: Introduce r-bus
  arm64: dts: realtek: rtd129x: Carve out boot ROM from memory
  arm64: dts: realtek: rtd16xx: Carve out boot ROM from memory
  dt-bindings: arm: realtek: Add RTD1395 and Banana Pi BPI-M4
  arm64: dts: realtek: Add RTD1395 and BPi-M4
  dt-bindings: arm: realtek: Add Realtek Lion Skin EVB
  arm64: dts: realtek: rtd1395: Add Realtek Lion Skin EVB

 Documentation/devicetree/bindings/arm/realtek.yaml |   7 +
 arch/arm64/boot/dts/realtek/Makefile               |   3 +
 arch/arm64/boot/dts/realtek/rtd1293-ds418j.dts     |   6 +-
 arch/arm64/boot/dts/realtek/rtd1293.dtsi           |  12 +-
 arch/arm64/boot/dts/realtek/rtd1295-mele-v9.dts    |   6 +-
 .../arm64/boot/dts/realtek/rtd1295-probox2-ava.dts |   6 +-
 arch/arm64/boot/dts/realtek/rtd1295-zidoo-x9s.dts  |   4 +-
 arch/arm64/boot/dts/realtek/rtd1295.dtsi           |  21 +--
 arch/arm64/boot/dts/realtek/rtd1296-ds418.dts      |   4 +-
 arch/arm64/boot/dts/realtek/rtd1296.dtsi           |   8 +-
 arch/arm64/boot/dts/realtek/rtd129x.dtsi           | 170 ++++++++++++---------
 arch/arm64/boot/dts/realtek/rtd1395-bpi-m4.dts     |  30 ++++
 arch/arm64/boot/dts/realtek/rtd1395-lionskin.dts   |  36 +++++
 arch/arm64/boot/dts/realtek/rtd1395.dtsi           |  65 ++++++++
 arch/arm64/boot/dts/realtek/rtd139x.dtsi           | 142 +++++++++++++++++
 arch/arm64/boot/dts/realtek/rtd1619-mjolnir.dts    |   5 +-
 arch/arm64/boot/dts/realtek/rtd16xx.dtsi           |   4 +-
 17 files changed, 417 insertions(+), 112 deletions(-)
 create mode 100644 arch/arm64/boot/dts/realtek/rtd1395-bpi-m4.dts
 create mode 100644 arch/arm64/boot/dts/realtek/rtd1395-lionskin.dts
 create mode 100644 arch/arm64/boot/dts/realtek/rtd1395.dtsi
 create mode 100644 arch/arm64/boot/dts/realtek/rtd139x.dtsi

-- 
2.16.4

