Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95836C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 16:18:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6023B20835
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 16:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555604292;
	bh=J0XTsTAf6bGgDoyWYFO25/qLcdpD54CZrPAfbazfix8=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=A8N65abzdVeaBgpwgiejOpegYboDHHCns7DyRR6vWSyq5+0aeV3anr0afer/AY6Fz
	 Q5PitrcR1l2Z9aS/jNqsD2zKFRtAtHvpZ047BGFhNP4yJ5FH3OrKNLKV6/pjGEHTwe
	 /1SUn6yys42Lwf6Kxxak56YSuhn7cTwx1mFw0Xew=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389657AbfDRQSL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 12:18:11 -0400
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:34376 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388097AbfDRQSI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 12:18:08 -0400
Received: by wens.csie.org (Postfix, from userid 1000)
        id 478295FDF9; Fri, 19 Apr 2019 00:18:05 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] arm64: allwinner: Enable AXP803's USB power supply
Date:   Fri, 19 Apr 2019 00:18:01 +0800
Message-Id: <20190418161804.17723-1-wens@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

Hi everyone,

This series follows up on the A83T USB OTG series. The USB power supply
portion of the AXP803, the PMIC used with the A64, is identical to the
part in the AXP813/AXP818, used with the A83T.

This series enables the USB power supply in the AXP803 using the AXP813's
compatible string as a fallback. The per-model compatible string is still
added as a contigency.

Patch 1 adds an mfd cell for the USB power supply, to the AXP803.

Patch 2 adds a device node for the USB power supply.

Patch 3 enables the USB power supply on the Bananapi M64.

Unfortunately the original Pine64 does not wire up the USB power supply,
and I don't have any other A64 boards.

The mfd patch can go in through the mfd tree. There are no compile-time
dependencies. We, sunxi, can take the DT patches.

Please have a look.


Regards
ChenYu


Chen-Yu Tsai (3):
  mfd: axp20x: add USB power supply mfd cell to AXP803
  arm64: dts: allwinner: axp803: add USB power supply node
  arm64: dts: allwinner: a64: bananapi-m64: Enable PMIC USB power supply

 arch/arm64/boot/dts/allwinner/axp803.dtsi                 | 6 ++++++
 arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts | 5 +++++
 drivers/mfd/axp20x.c                                      | 5 +++++
 3 files changed, 16 insertions(+)

-- 
2.20.1

