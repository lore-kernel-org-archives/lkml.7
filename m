Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25FA8C17443
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 03:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E92CD2075C
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 03:04:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfKKDEu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 Nov 2019 22:04:50 -0500
Received: from mx2.suse.de ([195.135.220.15]:54276 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726742AbfKKDEt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Nov 2019 22:04:49 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 224DDAE55;
        Mon, 11 Nov 2019 03:04:48 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        James Tai <james.tai@realtek.com>
Subject: [PATCH 0/7] arm64: dts: Initial RTD1395 and BPi-M4 support
Date:   Mon, 11 Nov 2019 04:04:27 +0100
Message-Id: <20191111030434.29977-1-afaerber@suse.de>
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
Banana Pi BPI-M4 SBC.

It is based on my RTD1195 series and James' pending RTD1619 DT bindings patch.

It starts with some refactorings to align the various SoCs and to demonstrate
to James what I meant with the r-bus node and GIC mask in RTD1619 DT v1 review.

RTD1395 family seems pretty similar to RTD1295 family, but allows for more RAM
and therefore uses #address-cells of 2 vs. 1, and it uses a different reserved
memory region for RPC. RTD1295 resets appear sufficiently compatible for now.

More details at:
https://en.opensuse.org/HCL:BananaPi_M4

Latest experimental patches at:
https://github.com/afaerber/linux/commits/rtd1295-next

Have a lot of fun!

Cheers,
Andreas

Cc: devicetree@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>
Cc: James Tai <james.tai@realtek.com>

Andreas Färber (7):
  arm64: dts: realtek: rtd129x: Fix GIC CPU masks for RTD1293
  arm64: dts: realtek: rtd129x: Use reserved-memory for RPC regions
  arm64: dts: realtek: rtd129x: Introduce r-bus
  ARM: dts: rtd1195: Fix GIC CPU mask
  ARM: dts: rtd1195: Introduce r-bus
  dt-bindings: arm: realtek: Add RTD1395 and Banana Pi BPI-M4
  arm64: dts: realtek: Add RTD1395 and BPi-M4

 Documentation/devicetree/bindings/arm/realtek.yaml |   6 +
 arch/arm/boot/dts/rtd1195.dtsi                     |  60 ++++----
 arch/arm64/boot/dts/realtek/Makefile               |   2 +
 arch/arm64/boot/dts/realtek/rtd1293.dtsi           |  12 +-
 arch/arm64/boot/dts/realtek/rtd1295.dtsi           |  21 +--
 arch/arm64/boot/dts/realtek/rtd1296.dtsi           |   8 +-
 arch/arm64/boot/dts/realtek/rtd129x.dtsi           | 159 ++++++++++++---------
 arch/arm64/boot/dts/realtek/rtd1395-bpi-m4.dts     |  30 ++++
 arch/arm64/boot/dts/realtek/rtd1395.dtsi           |  65 +++++++++
 arch/arm64/boot/dts/realtek/rtd139x.dtsi           | 141 ++++++++++++++++++
 10 files changed, 387 insertions(+), 117 deletions(-)
 create mode 100644 arch/arm64/boot/dts/realtek/rtd1395-bpi-m4.dts
 create mode 100644 arch/arm64/boot/dts/realtek/rtd1395.dtsi
 create mode 100644 arch/arm64/boot/dts/realtek/rtd139x.dtsi

-- 
2.16.4

