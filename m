Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9864FC3A5A0
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 03:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 643D722CF5
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 03:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="4M37PdQB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Ygys0yOa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729264AbfHTDXt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 23:23:49 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:56153 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728734AbfHTDXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 23:23:14 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 893FA3510;
        Mon, 19 Aug 2019 23:23:12 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 19 Aug 2019 23:23:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm3; bh=9DYoy8NT9Ve7hFzyo3H6iPPmEA
        CpZOYKDnCzHCSrpbQ=; b=4M37PdQBCN/w6RTxxDoqh8EXYO5p4e3lRIbFwuRFpx
        xFN2vbw5G1DuPYMDJ1SKOpVrLfHxkdl3X1G93HgwHSVioOg63/micK86dWFRw0jE
        vaqJYzCDGdu+x39wFXjpqrOiR/NhEn20fAr4IK8z8hlRx+f5QLvyaimyef1UIiHJ
        dmtFD/e7m1BT+Rskj6EmHduJcxLiF/6ROGf6EZvhY8/s4iF2a7crTfu2jEKVQPTy
        LfxHV7DHBzGcaf7yaAw5+spV95x/NMnvnr04a1llb7nDlU8lQdtBh5Ma4D/yv8U5
        Sm4cPMmg8HVQCHsaGSTe4KbOUnxaf+MoHkF2RWnNdPMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=9DYoy8NT9Ve7hFzyo
        3H6iPPmEACpZOYKDnCzHCSrpbQ=; b=Ygys0yOa27lYONkNyUqaJ0xRhBRCmHouO
        ms0Y9NviXXDmwmyFFRZtHxj2stQLzwDLXHdkRhvQmNjmQamB9Lt/GmYGWFSCuGt5
        n2uZvPm6IL2dgWkpoWHFpa1pyt23On0FQqzm+ThHUznjz1WSUZDd6AhEISvd06aH
        AB4xiqmXfMYfRm+6JyS9FnQ8Kkwjdg4NAAL/VPhriLCaFQosPXnT3raPYR9OEGGi
        EEb7BWIHHLSB7U7dPeYO7fSYKrXp1R1d/bsbwGAKRn6DSyWMtRM102ZOh5hQOz1z
        Iqo+agaukFYVOBs9FA9WhZRB/oNzv4KMBILau1z4OW/kkfkLthW+w==
X-ME-Sender: <xms:n2dbXXEsXSS3x9kPpQyV5o-MSjkYRIZ7XSamxV-ILJqOTLVT1lRI6Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudegtddgjeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgvlhcu
    jfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucffohhmrg
    hinhepghhithhhuhgsrdgtohhmnecukfhppeejtddrudefhedrudegkedrudehudenucfr
    rghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghnugdrohhrghenuc
    evlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:n2dbXYln6shx_YGrmWhxqsz81-p18uZ7tYpm7TgAYtv8kuOGZxR23A>
    <xmx:n2dbXUIYyiaFSA3_N0Wwa1XupWFv3RvXEnr4yh08WP97zQPaz_HUBA>
    <xmx:n2dbXZaprr3dAZARO1jWYZSAVXq4JIY_y51SyJn4LhIn5vayVF31-A>
    <xmx:oGdbXYmoo9G4d1TqUl-0LKunnaY7WbhJIp0i1S3cgTwMYlpCcHdeYQ>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 38A688005C;
        Mon, 19 Aug 2019 23:23:10 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Corentin Labbe <clabbe.montjoie@gmail.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Samuel Holland <samuel@sholland.org>
Subject: [PATCH v4 00/10] Allwinner sunxi message box support
Date:   Mon, 19 Aug 2019 22:23:01 -0500
Message-Id: <20190820032311.6506-1-samuel@sholland.org>
X-Mailer: git-send-email 2.21.0
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
on the AR100 CPU, or to use the mailbox to forward NMIs that the
firmware picks up from R_INTC.

Unfortunately, the ARM SCPI client no longer works with this driver
since it now exposes all 8 hardware FIFOs individually. The SCPI client
could be made to work (and I posted proof-of-concept code to that effect
with v1 of this series), but that is a low priority, as Linux does not
directly use SCPI with the current firmware version; all SCPI use goes
through ATF via PSCI.

As requested in the comments to v3 of this patchset, a demo client is
provided in the final patch. This demo goes along with a toy firmware
which shows that the driver does indeed work for two-way communication
on all channels. To build the firmware component, run:

  git clone https://github.com/crust-firmware/meta meta
  git clone -b mailbox-demo https://github.com/crust-firmware/crust meta/crust
  cd meta
  make

That will by default produce a U-Boot + ATF + SCP firmware image in
[meta/]build/pinebook/u-boot-sunxi-with-spl.bin. See the top-level
README.md for more information, such as cross-compiler setup.

I've now used this driver with three separate clients over the past two
years, and they all work. If there are no remaining concerns with the
driver, I'd like it to get merged.

Even without the driver, the clock patches (1-2) can go in at any time.

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

Samuel Holland (10):
  clk: sunxi-ng: Mark msgbox clocks as critical
  clk: sunxi-ng: Mark AR100 clocks as critical
  dt-bindings: mailbox: Add a sunxi message box binding
  mailbox: sunxi-msgbox: Add a new mailbox driver
  ARM: dts: sunxi: a80: Add msgbox node
  ARM: dts: sunxi: a83t: Add msgbox node
  ARM: dts: sunxi: h3/h5: Add msgbox node
  arm64: dts: allwinner: a64: Add msgbox node
  arm64: dts: allwinner: h6: Add msgbox node
  [DO NOT MERGE] drivers: firmware: msgbox demo

 .../mailbox/allwinner,sunxi-msgbox.yaml       |  79 +++++
 arch/arm/boot/dts/sun8i-a83t.dtsi             |  10 +
 arch/arm/boot/dts/sun9i-a80.dtsi              |  10 +
 arch/arm/boot/dts/sunxi-h3-h5.dtsi            |  10 +
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi |  34 ++
 arch/arm64/boot/dts/allwinner/sun50i-h5.dtsi  |  24 ++
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  |  10 +
 drivers/clk/sunxi-ng/ccu-sun50i-a64.c         |   3 +-
 drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c        |   2 +-
 drivers/clk/sunxi-ng/ccu-sun50i-h6.c          |   3 +-
 drivers/clk/sunxi-ng/ccu-sun8i-a23.c          |   3 +-
 drivers/clk/sunxi-ng/ccu-sun8i-a33.c          |   3 +-
 drivers/clk/sunxi-ng/ccu-sun8i-a83t.c         |   3 +-
 drivers/clk/sunxi-ng/ccu-sun8i-h3.c           |   3 +-
 drivers/clk/sunxi-ng/ccu-sun8i-r.c            |   2 +-
 drivers/clk/sunxi-ng/ccu-sun9i-a80.c          |   3 +-
 drivers/firmware/Kconfig                      |   6 +
 drivers/firmware/Makefile                     |   1 +
 drivers/firmware/sunxi_msgbox_demo.c          | 307 +++++++++++++++++
 drivers/mailbox/Kconfig                       |  10 +
 drivers/mailbox/Makefile                      |   2 +
 drivers/mailbox/sunxi-msgbox.c                | 323 ++++++++++++++++++
 22 files changed, 842 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/mailbox/allwinner,sunxi-msgbox.yaml
 create mode 100644 drivers/firmware/sunxi_msgbox_demo.c
 create mode 100644 drivers/mailbox/sunxi-msgbox.c

-- 
2.21.0
