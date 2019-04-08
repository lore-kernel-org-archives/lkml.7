Return-Path: <SRS0=N68d=SK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76767C10F13
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:58:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B6B320880
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Apr 2019 16:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554742688;
	bh=Ovbk5NnERGD9eHR7BB7c9vkrIGTKLOik64wPRDbJKJU=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=b9nI4cUgWgR85byDsH1gkN3W/K8O+XIVYsa9Dlaa1dqfkGfB6mRolBYYkvYbR/dwF
	 hNTHJjV6Z/WaNRJFs9yCis7eA3xFv4u9R7SWKvO1bmTk9pA4H6B7R3Wf6zQfDIVWc5
	 CiyApVdvMBQ75BlxtZ/tZJJZXPVQiYjKBxa/E6go=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729160AbfDHQ6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Apr 2019 12:58:07 -0400
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:43692 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728635AbfDHQ5u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Apr 2019 12:57:50 -0400
Received: by wens.csie.org (Postfix, from userid 1000)
        id 96D4B5FCC3; Tue,  9 Apr 2019 00:57:46 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Yong Deng <yong.deng@magewell.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Chen-Yu Tsai <wens@csie.org>, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Subject: [PATCH 0/6] ARM: sun8i: a83t: Support Camera Sensor Interface controller
Date:   Tue,  9 Apr 2019 00:57:38 +0800
Message-Id: <20190408165744.11672-1-wens@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

Hi everyone,

This series adds support for the camera sensor interface controller
found on the Allwinner A83T SoC. The controller is similar to the one
found on  the H3, with the addition of a MIPI CSI-2 interface. However,
this series only supports parallel and BT.656 interfaces, based on the
existing driver.

Patch 1 adds an undocumented clock parent of the CSI MCLK. This was
found after finding the default value to sometimes work and sometimes
not, and then comparing against BSP code.

Patch 2 adds a compatible string for the A83T variant.

Patch 3 adds support for the A83T variant to the existing sun6i-csi
driver.

Patch 4 adds a device node for the controller, as well as commonly
used pin muxing options.

Patch 5 adds a pin muxing option for I2C1 on the PE pins, used in
conjunction with the CSI pins.

Patch 6 provides an example usage of the CSI controller: the Bananapi M3
with its camera module attached.

Please have a look.


Regards
ChenYu


Chen-Yu Tsai (6):
  clk: sunxi-ng: a83t: Add pll-video0 as parent of csi-mclk
  dt-bindings: media: sun6i-csi: Add compatible string for A83T variant
  media: sun6i: Support A83T variant
  ARM: dts: sun8i: a83t: Add device node for CSI (Camera Sensor
    Interface)
  ARM: dts: sun8i: a83t: Add I2C2 pinmux setting for PE pins
  [DO NOT MERGE] ARM: dts: sun8i: a83t: bananapi-m3: Enable BPI OV5640
    camera

 .../devicetree/bindings/media/sun6i-csi.txt   |   1 +
 arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts  | 101 ++++++++++++++++++
 arch/arm/boot/dts/sun8i-a83t.dtsi             |  37 +++++++
 drivers/clk/sunxi-ng/ccu-sun8i-a83t.c         |   5 +-
 .../platform/sunxi/sun6i-csi/sun6i_csi.c      |   1 +
 5 files changed, 143 insertions(+), 2 deletions(-)

-- 
2.20.1

