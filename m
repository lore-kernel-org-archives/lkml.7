Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3125BC33C9A
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 08:43:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 068C020656
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 08:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1578300184;
	bh=GyMtO6oRWPq3+Hr+8BFljMOSlSlAK0b+OtMogPrfuWQ=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=UVQEHbIsGs/MTjPZ4TOT0EsClL6KhejPRedxXDYX8nu/bzxdEwC7lcr2P5Tk08cST
	 RM0Dn2Ui0/eqq/IZiJuKEycLM+vDhS3v9M33Ghn6LZapALgKLfhWjL/gsJCmuUjyki
	 DFhQg2GmWHSJjCq349hZuD/MrwSjV6ZlqVCihE2o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbgAFInC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 03:43:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:40110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726080AbgAFImo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 03:42:44 -0500
Received: from wens.tw (mirror2.csie.ntu.edu.tw [140.112.30.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C7EB20656;
        Mon,  6 Jan 2020 08:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578300163;
        bh=GyMtO6oRWPq3+Hr+8BFljMOSlSlAK0b+OtMogPrfuWQ=;
        h=From:To:Cc:Subject:Date:From;
        b=Zn5UiXsAtWD4qD796sVyJoLSKjO0SAI5FLpo3LlbuonQrebo2np2BDkx7sUmWRcSv
         nY8kO0U5p7NNRuK3qhp6q+L1uwvp8r9rxsK1dpy5vmQk94LahC5fj2azRApbE+iwg8
         AkExBPM/v4TBuDD4d1KilJeAteBWrP4bZ25I7/Qs=
Received: by wens.tw (Postfix, from userid 1000)
        id 49CE25FC12; Mon,  6 Jan 2020 16:42:41 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/7] media: sun4i-csi: A10/A20 CSI1 and R40 CSI0 support
Date:   Mon,  6 Jan 2020 16:42:33 +0800
Message-Id: <20200106084240.1076-1-wens@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

Hi everyone,

This is v2 of my A10/A20 CSI1 and R40 CSI0 series. v2 is simply the
remaining patches rebased on top of linux-next 20200106, with the
MBUS device tree binding changes converted to YAML format.

This series adds basic support for CSI1 on Allwinner A10/A20 and CSI0 on
Allwinner R40. The CSI1 block has the same structure and layout as the
CSI0 block. Differences include:

  - Only one channel in BT.656 instead of four in CSI0
  - 10-bit raw data input vs 8-bit in CSI0
  - 24-bit RGB888/YUV444 input vs 16-bit RGB565/YUV422 in CSI0
  - No ISP hardware (CSI SCLK not needed)

The CSI0 block in the Allwinner R40 SoC looks to be the same as the one
in the A20. The register maps line up, and they support the same
features. The R40 appears to support BT.1120 based on the feature
overview, but it is not mentioned anywhere else. Also like the A20, the
ISP is not mentioned, but the CSI special clock needs to be enabled for
the hardware to function. The manual does state that the CSI special
clock is the TOP clock for all CSI hardware, but currently no hardware
exists for us to test if CSI1 also depends on it or not.

Included are a couple of fixes for signal polarity and DRAM offset
handling.

Patches 1 and 2 add CSI1 to A10 (sun4i) and A20 (sun7i) dtsi files.

Patch 3 adds a compatible string for the R40's MBUS (memory bus).
This patch needs to go through Rob's tree as it now depends on
the patch "dt-bindings: interconnect: Convert Allwinner MBUS
controller to a schema" that was already merged.

Patch 4 adds CSI0 to the R40 dtsi file

Patches 5 through 7 are examples of cameras hooked up to boards.


Regards
ChenYu


Chen-Yu Tsai (7):
  ARM: dts: sun4i: Add CSI1 controller and pinmux options
  ARM: dts: sun7i: Add CSI1 controller and pinmux options
  dt-bindings: bus: sunxi: Add R40 MBUS compatible
  ARM: dts: sun8i: r40: Add device node for CSI0
  [DO NOT MERGE] ARM: dts: sun4i: cubieboard: Enable OV7670 camera on
    CSI1
  [DO NOT MERGE] ARM: dts: sun7i: cubieboard2: Enable OV7670 camera on
    CSI1
  [DO NOT MERGE] ARM: dts: sun8i-r40: bananapi-m2-ultra: Enable OV5640
    camera

 .../arm/sunxi/allwinner,sun4i-a10-mbus.yaml   |  1 +
 arch/arm/boot/dts/sun4i-a10-cubieboard.dts    | 42 ++++++++++++
 arch/arm/boot/dts/sun4i-a10.dtsi              | 35 ++++++++++
 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts   | 42 ++++++++++++
 arch/arm/boot/dts/sun7i-a20.dtsi              | 36 ++++++++++
 .../boot/dts/sun8i-r40-bananapi-m2-ultra.dts  | 67 +++++++++++++++++++
 arch/arm/boot/dts/sun8i-r40.dtsi              | 36 ++++++++++
 7 files changed, 259 insertions(+)

-- 
2.24.1

