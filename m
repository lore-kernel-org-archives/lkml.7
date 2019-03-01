Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D63C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 05:30:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5AB82087E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 05:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="WuIVe8b8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xyG7ldRw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731489AbfCAFal (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 00:30:41 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:48751 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726051AbfCAF3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 00:29:52 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 605DF22089;
        Fri,  1 Mar 2019 00:29:51 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 01 Mar 2019 00:29:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=7M5K78LB7EYmNUrCPEf3BoEpQl
        6rAR21E72L070cDCk=; b=WuIVe8b85SsESF/Vr5yiX3pI9jT3SQisfFcJq+9pDw
        /GU2hbLLHQ4TEw424dk/ufEfxNNmw2M5jtFWO/L0JHvaDgn+oWCyx60HqEFdJD9M
        98dYBiK6SK/g4TBoct2Pi1ou1VOH9USBA3TGlF42Grq44Lo2lSEaIe/x8r3LnqF3
        rPzgsZ6gL5A1jCMAezc70fkv864oeXDW2+K4BgzWMuGJQrNAlLhiks5h9NlNRIly
        UyiQ2QlxDzXew4DzcrBaPVZN1TmMNJwA1rOvUBgYs44rlRc6G2ciYuCOGEBnvbaC
        zYoax7ycroM6NC1RwM+u2HBgk9kYQT+e5A1C2X90qGrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=7M5K78LB7EYmNUrCP
        Ef3BoEpQl6rAR21E72L070cDCk=; b=xyG7ldRwSV5nevCxWuuFXha6BqjL4Pacn
        5CBHuflhTFjst9ZUYPkclefbrF1UzPwOhpbPLRQcxznDn2FCWBlgwRJxvtUs2dWH
        aJAgH/iQ8VvngC3SFLOAl0chnFy3DZ0/vkH9zxNHMpMPM98Dm4l8pRxkBQG5r8T3
        MgFuUY7apUL0g4VY49r0xfnfhYbhiCEWSUuVkI1VPGw2Qu1jpbvwk0rUkMhfRE7I
        68FWEhAF4JMcrNdwYnmxhkmWtwycqIV7aRYqzFnRp6wSEavE6jYydDndjmVre3ov
        8hYGdXo94zJ9lA6JwCAPWSlutD/+yUbs2L+McgTVa55iVSQ301wjA==
X-ME-Sender: <xms:TcN4XCK09Cv5EWnnzfYcIlj2tV47zt5YezJoI_hcrz1p6Xe_E9CrDg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrvdeggdekjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghlucfj
    ohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecukfhppeejtd
    drudefhedrudegkedrudehudenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghl
    sehshhholhhlrghnugdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:TcN4XGcrCt5Rd__l9_X3Ai0MhgDzPVfDUBOHCIVd6V25kEhthFd7AQ>
    <xmx:TcN4XFcORhGcpwDwEMgqgVpq-ZkVItRZFM88_HOZQ69pFGNF_tUVcA>
    <xmx:TcN4XJPkfc4CJEM7pfjzm-jb33FVvto8qm6otNTZnUQPDLReR2iCZQ>
    <xmx:T8N4XMRPUuph0rENZJdWo3k8sGYaPyOhVFrTVzajAMkJD2MjDdURBQ>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 923A1E40C1;
        Fri,  1 Mar 2019 00:29:48 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Samuel Holland <samuel@sholland.org>
Subject: [PATCH v2 00/10] Allwinner sunxi message box support
Date:   Thu, 28 Feb 2019 23:29:37 -0600
Message-Id: <20190301052947.32032-1-samuel@sholland.org>
X-Mailer: git-send-email 2.19.2
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
on the ARISC CPU, or to use the mailbox to forward NMIs that the
firmware picks up from R_INTC.

Changes from v1:
  - Marked message box clocks as critical instead of hacks in the driver
  - 8 unidirectional channels instead of 4 bidirectional pairs
  - Use per-SoC compatible strings and an A31 fallback compatible
  - Dropped the mailbox framework patch
  - Include DT patches for SoCs that document the message box

Samuel Holland (10):
  clk: sunxi-ng: sun8i: Mark the msgbox clock as critical
  clk: sunxi-ng: sun9i: Mark the msgbox clock as critical
  clk: sunxi-ng: sun50i: Mark the msgbox clock as critical
  dt-bindings: mailbox: Add a sunxi message box binding
  mailbox: sunxi-msgbox: Add a new mailbox driver
  ARM: dts: sunxi: a80: Add msgbox node
  ARM: dts: sunxi: a83t: Add msgbox node
  ARM: dts: sunxi: h3/h5: Add msgbox node
  arm64: dts: allwinner: a64: Add msgbox node
  arm64: dts: allwinner: h6: Add msgbox node

 .../bindings/mailbox/sunxi-msgbox.txt         |  44 +++
 arch/arm/boot/dts/sun8i-a83t.dtsi             |  10 +
 arch/arm/boot/dts/sun9i-a80.dtsi              |  10 +
 arch/arm/boot/dts/sunxi-h3-h5.dtsi            |  10 +
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi |  10 +
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  |  10 +
 drivers/clk/sunxi-ng/ccu-sun50i-a64.c         |   2 +-
 drivers/clk/sunxi-ng/ccu-sun50i-h6.c          |   2 +-
 drivers/clk/sunxi-ng/ccu-sun8i-a23.c          |   2 +-
 drivers/clk/sunxi-ng/ccu-sun8i-a33.c          |   2 +-
 drivers/clk/sunxi-ng/ccu-sun8i-a83t.c         |   2 +-
 drivers/clk/sunxi-ng/ccu-sun8i-h3.c           |   2 +-
 drivers/clk/sunxi-ng/ccu-sun9i-a80.c          |   2 +-
 drivers/mailbox/Kconfig                       |  11 +
 drivers/mailbox/Makefile                      |   2 +
 drivers/mailbox/sunxi-msgbox.c                | 315 ++++++++++++++++++
 16 files changed, 429 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mailbox/sunxi-msgbox.txt
 create mode 100644 drivers/mailbox/sunxi-msgbox.c

-- 
2.19.2

