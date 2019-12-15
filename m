Return-Path: <SRS0=qvRn=2F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 183E4C47409
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 04:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDEC02072B
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 04:25:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="BV/CcvtM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TTQOvW6r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbfLOEZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 23:25:01 -0500
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:59753 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726036AbfLOEZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 23:25:00 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 9B5E45AC7;
        Sat, 14 Dec 2019 23:24:58 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 14 Dec 2019 23:24:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm1; bh=yF1ILw6fVT9Ms/aRvWhr5GmNy8
        yCGr3pdt2J77P8Ksg=; b=BV/CcvtMaUwJ5Xkmrafcunww9v4v4S5kcTx99tU1EB
        sOPSEYwERghframe5KVWMwobt2PY4HQNQQu2M1chgX+ubpFEf3J8XO3qD4JJxmln
        RflPCYFWyHYjDGPo78fb47HlR078gaPkLsEdr9P9jqliVCTo1SY7AJ6Hp6rWd8r7
        W5DBV/pMMSJkh1q0OIQIBhbSExv75caTPQgBunbHvXNqGH4vSRUFdyKso0gdEgM8
        0onhPU13x8uBGlfOA8LWsEv03wWaPsxzbIfiZnlnV6Fy7uI7HbSi6igzK+X/cb3n
        zvG7ebfYEYT56dV/G5nuOu1eYZqjq36OhZCZy7RGnQAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=yF1ILw6fVT9Ms/aRv
        Whr5GmNy8yCGr3pdt2J77P8Ksg=; b=TTQOvW6r9Mi392k9GGi6muC4N+pNtQ0Xm
        GdWhR+xYvDth+aBUAQdmPL/NmyJcHOcCwhhdoqed8QlH0hqrAVK6M9vJ+iolQ51o
        tybj41uNSMpYU/HPiznEFifdy/VzsCUbOLw87LXXKwB0dJANNXhQwfGCu4pb8GD6
        7zoDYpbfXvxsFgVmUnoXCrhPGyIlKQkH5Bn0uPnpn6N6WFpjuezhxMmYUXUwUuX0
        btYLyeaZ7K1D8fKxLnGrrTEEsQIv/cqF6UiOCt+EXXNDtVdLGzmkkVrhNnAGUY4z
        63iWDlkgSRUlLr7ZDRAV2K7d/mD5Qid43lMtdemyYwn+tBfg4yB/A==
X-ME-Sender: <xms:mbX1XSkQcijX_Y6EzV-uhI2a9R45QZY5H9LY2SSO8tivwy6LVJIpbA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvddtvddgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgvlhcu
    jfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucfkphepje
    dtrddufeehrddugeekrdduhedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgv
    lhesshhhohhllhgrnhgurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:mbX1XfHA4DWZTjW_wQrEfGKPsFvCpNrWl6sarDuEFlgi5KMgA1K4_Q>
    <xmx:mbX1XSVMypIjxbOqYHykcFy4kPMrcwFCew_zUWsipqB1yqKG1kG8kg>
    <xmx:mbX1Xeyf8LwH_9K-1dQEO830eTGigJUaAxK_Zx2PTGAq6J1Yas7iHA>
    <xmx:mrX1XYRbkjBPBJSJfIXXEqhDzpdYk8PWkZBxxL5FMcffXggFEGcI6A>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id B5ACC80060;
        Sat, 14 Dec 2019 23:24:56 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Ondrej Jirman <megous@megous.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Samuel Holland <samuel@sholland.org>
Subject: [PATCH v5 0/8] Allwinner sun6i message box support
Date:   Sat, 14 Dec 2019 22:24:47 -0600
Message-Id: <20191215042455.51001-1-samuel@sholland.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for the "hardware message box" in sun8i, sun9i,
and sun50i SoCs, used for communication with the ARISC management
processor (the platform's equivalent of the ARM SCP). The end goal is to
use the arm_scpi driver as a client, communicating with firmware running
on the ARISC CPU.

I have tested this driver with various firmware programs on the A64, H5,
and H6 SoCs (including specifically this arm_scpi patch on A64 and H6),
and Ondrej Jirman has tested the driver on the A83T (using a similar
patch to arm_scpi).

The change to make the arm_scpi compatible with unidirectional mailbox
controllers is attached to the end of this patch series. While it would
be nice to get this merged too, I don't consider it a prerequisite to
getting the driver merged. And even without the driver, the clock change
(patch #1) can go in at any time.

Thanks,
Samuel

Changes from v4:
  - Rebased on sunxi-next
  - Dropped AR100 clock patch, as it was controversial and unnecessary
  - Renamed sunxi-msgbox to sun6i-msgbox and sun6i-a31-msgbox
  - Added comments about not asserting the reset line
  - Dropped A80 DTS changes as they were untested
  - Added Ondrej's Tested-by for A83T
  - Dropped the demo; replaced with a real arm_scpi fix

Changes from v3:
  - Rebased on sunxi-next
  - Added Rob's Reviewed-by for patch 3
  - Fixed a crash when receiving a message on a disabled channel
  - Cleaned up some comments/formatting in the driver
  - Fixed #mbox-cells in sunxi-h3-h5.dtsi (patch 7)
  - Removed the irqchip example (no longer relevant to the fw design)
  - Added a demo/example client that uses the driver and a toy firmware

Changes from v2:
  - Merge patches 1-3
  - Add a comment in the code explaining the CLK_IS_CRITICAL usage
  - Add a patch to mark the AR100 clocks as critical
  - Use YAML for the device tree binding
  - Include a not-for-merge example usage of the mailbox

Changes from v1:
  - Marked message box clocks as critical instead of hacks in the driver
  - 8 unidirectional channels instead of 4 bidirectional pairs
  - Use per-SoC compatible strings and an A31 fallback compatible
  - Dropped the mailbox framework patch
  - Include DT patches for SoCs that document the message box

Samuel Holland (8):
  clk: sunxi-ng: Mark msgbox clocks as critical
  dt-bindings: mailbox: Add a sun6i message box binding
  mailbox: sun6i-msgbox: Add a new mailbox driver
  ARM: dts: sunxi: a83t: Add msgbox node
  ARM: dts: sunxi: h3/h5: Add msgbox node
  arm64: dts: allwinner: a64: Add msgbox node
  arm64: dts: allwinner: h6: Add msgbox node
  firmware: arm_scpi: Support unidirectional mailbox channels

 .../mailbox/allwinner,sun6i-a31-msgbox.yaml   |  78 ++++
 arch/arm/boot/dts/sun8i-a83t.dtsi             |  10 +
 arch/arm/boot/dts/sunxi-h3-h5.dtsi            |  10 +
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi |  10 +
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  |  10 +
 drivers/clk/sunxi-ng/ccu-sun50i-a64.c         |   3 +-
 drivers/clk/sunxi-ng/ccu-sun50i-h6.c          |   3 +-
 drivers/clk/sunxi-ng/ccu-sun8i-a23.c          |   3 +-
 drivers/clk/sunxi-ng/ccu-sun8i-a33.c          |   3 +-
 drivers/clk/sunxi-ng/ccu-sun8i-a83t.c         |   3 +-
 drivers/clk/sunxi-ng/ccu-sun8i-h3.c           |   3 +-
 drivers/clk/sunxi-ng/ccu-sun9i-a80.c          |   3 +-
 drivers/firmware/arm_scpi.c                   |  58 ++-
 drivers/mailbox/Kconfig                       |   9 +
 drivers/mailbox/Makefile                      |   2 +
 drivers/mailbox/sun6i-msgbox.c                | 332 ++++++++++++++++++
 16 files changed, 520 insertions(+), 19 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mailbox/allwinner,sun6i-a31-msgbox.yaml
 create mode 100644 drivers/mailbox/sun6i-msgbox.c

-- 
2.23.0

