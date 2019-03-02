Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2254C00319
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 04:30:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F1D32085A
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 04:30:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="hpHyY9IV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UziwOdgY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727960AbfCBE35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 23:29:57 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:52857 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726693AbfCBE3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 23:29:55 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 0D5BF22102;
        Fri,  1 Mar 2019 23:29:54 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Fri, 01 Mar 2019 23:29:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=6wxraRm1tf0iqprrxkQWCK7za3
        ofjuzsdLJXXH6XaDU=; b=hpHyY9IVi8062UihAai0ChkVdK18aEOvJ1vprNoAa1
        c6ITqZU18+0XG/Os1eZalls0CriamtSZ1cYtp6o3fSCfti4wRm291FwP7VEcI+Qh
        RjMTz/9PfAp/0TumqzP7lB1Dcy0dDiDvP7xkfLQUgyG4LoR4q35GsRBqMCmqjhl+
        G9YaDu68yKnayTrJ037LGN7wbUsaB+UDyjRqvBxNlv3JNGi76i1u6f/s3xLEkxym
        ERyuAYaQn3S9NeyKZjSLai0JgaF2ggGDtL/5QfguEJq0VI1LvT/+cOsbxN/DlMzP
        DnOt3YTLV16lY7B0AjYrcYWEjTkUN/4bR2tPj1MSsgGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=6wxraRm1tf0iqprrx
        kQWCK7za3ofjuzsdLJXXH6XaDU=; b=UziwOdgY/0/FoXCTrAzf6i5BvmeeYNdku
        pB81qxAba0sz+rP2p1SYBtyqotmXkj910Ga2qh46uvxPksXGFwKKBn1Xtn4nOX4c
        cVS+GOilW9mCW67L0Z4eAEOVWjDVnEti4oZ+aO3w0iy7631L193SkygkiJg9IdS3
        Jque0Zk7v9x7XYe0ig8xBnIy00BGi1QXAjLVACjQXOINr+m9U5ekrRin1USNyqVH
        FGMTINmVyc/NLqx2s21kJAvM02+TvEclCYZrXSWTwAcRpY+w6Z+OCQkuK9T9l7dy
        3DqKCxUbBS2PgAKSwwHO1YvWv5VX7qqYInQAVrNlwz7Ssf96Upy1A==
X-ME-Sender: <xms:wAZ6XKZGLEvtVcvujsGbf1L3xHkZGiFaQC3Cy-4k7dl0P7_qIa7QMw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrvdeigdejtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghlucfj
    ohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuffhomhgrih
    hnpehgihhthhhusgdrtghomhenucfkphepjedtrddufeehrddugeekrdduhedunecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgnecuve
    hluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:wAZ6XCnHmQaz9QZ_GjodN2fOnElqtbsSXpcYULi6uS-sG_5TPwl7nA>
    <xmx:wAZ6XF2g7ADyQB3lzl612i9hc02c1Mg1kLy8zRD_AfIaK1XC0F3zdA>
    <xmx:wAZ6XC0mU_u_iB9GW-xT3VOtkvuMcxSyhqwDeVlBx3-MkezjZdMLNg>
    <xmx:wQZ6XJosX9vyx4Cqt3r5H7rS4TtHgaQ90Acvl9mMo5CtyS5aewnU-Q>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0F9A310310;
        Fri,  1 Mar 2019 23:29:52 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Samuel Holland <samuel@sholland.org>
Subject: [PATCH v3 00/15] Allwinner sunxi message box support
Date:   Fri,  1 Mar 2019 22:29:36 -0600
Message-Id: <20190302042951.53671-1-samuel@sholland.org>
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
on the AR100 CPU, or to use the mailbox to forward NMIs that the
firmware picks up from R_INTC.

Unfortunately, the ARM SCPI client no longer works with this driver
since it now exposes all 8 hardware FIFOs individually. The SCPI client
could be made to work (and I posted proof-of-concept code to that effect
with v1 of this series), but that is a low priority, as Linux does not
directly use SCPI with the current firmware version; all SCPI use goes
through ATF via PSCI.

An example usage is included at the end of this patch series. The IRQ
forwarding code is WIP and not even RFC quality yet, but it does work.
To build the firmware component, run:

  git clone https://github.com/crust-firmware/meta meta
  git clone https://github.com/smaeul/crust -b linux-mailbox-example meta/crust
  cd meta
  make

That will by default produce a U-Boot + ATF + SCP firmware image in
[meta/]build/pinebook/u-boot-sunxi-with-spl.bin. See the top-level README.md
for more information (like cross-compiler setup). The IRQ-forwarding mailbox
server is implemented in [meta/crust/]common/irqf.c.

With that firmware and the full patch series here (on top of
torvalds/master), Linux boots and is able to receive NMIs from the PMIC
(i.e. use `showkey` to see that the power button works, and see that
/proc/interrupts updates). As an added bonus, suspend/resume also mostly
works :)

Changes from v2:
  - Merge patches 1-3
  - Add a comment in the code explaining the CLK_IS_CRITICAL usage
  - Add a patch to mark the AR100 clocks as critical
  - Use YAML for the device tree binding
  - Include a not-for-merge example usage of the mailbox.

Changes from v1:
  - Marked message box clocks as critical instead of hacks in the driver
  - 8 unidirectional channels instead of 4 bidirectional pairs
  - Use per-SoC compatible strings and an A31 fallback compatible
  - Dropped the mailbox framework patch
  - Include DT patches for SoCs that document the message box

Samuel Holland (15):
  clk: sunxi-ng: Mark msgbox clocks as critical
  clk: sunxi-ng: Mark AR100 clocks as critical
  dt-bindings: mailbox: Add a sunxi message box binding
  mailbox: sunxi-msgbox: Add a new mailbox driver
  ARM: dts: sunxi: a80: Add msgbox node
  ARM: dts: sunxi: a83t: Add msgbox node
  ARM: dts: sunxi: h3/h5: Add msgbox node
  arm64: dts: allwinner: a64: Add msgbox node
  arm64: dts: allwinner: h6: Add msgbox node
  [NOT FOR MERGE] clk: sunxi-ng: sun8i: Avoid turning off unused PRCM
    gates
  [NOT FOR MERGE] dt-bindings: Add a binding for a mailbox-backed
    interrupt controller
  [NOT FOR MERGE] irqchip/mbox: Introduce a mailbox-backed irqchip
    driver
  [NOT FOR MERGE] arm64: dts: allwinner: a64: Add interrupt controller
    node
  [NOT FOR MERGE] arm64: dts: allwinner: a64: Convert DTS to use
    msgbox_intc
  [NOT FOR MERGE] arm64: dts: allwinner: a64: Remove unused r_intc

 .../interrupt-controller/mbox-intc.txt        |  33 ++
 .../mailbox/allwinner,sunxi-msgbox.yaml       |  79 +++++
 arch/arm/boot/dts/sun8i-a83t.dtsi             |  10 +
 arch/arm/boot/dts/sun9i-a80.dtsi              |  10 +
 arch/arm/boot/dts/sunxi-h3-h5.dtsi            |  10 +
 .../allwinner/sun50i-a64-amarula-relic.dts    |   4 +-
 .../dts/allwinner/sun50i-a64-bananapi-m64.dts |   4 +-
 .../dts/allwinner/sun50i-a64-nanopi-a64.dts   |   4 +-
 .../dts/allwinner/sun50i-a64-olinuxino.dts    |   4 +-
 .../dts/allwinner/sun50i-a64-orangepi-win.dts |   4 +-
 .../boot/dts/allwinner/sun50i-a64-pine64.dts  |   4 +-
 .../dts/allwinner/sun50i-a64-pinebook.dts     |   4 +-
 .../boot/dts/allwinner/sun50i-a64-sopine.dtsi |   4 +-
 .../boot/dts/allwinner/sun50i-a64-teres-i.dts |   4 +-
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi |  27 +-
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi  |  10 +
 drivers/clk/sunxi-ng/ccu-sun50i-a64.c         |   3 +-
 drivers/clk/sunxi-ng/ccu-sun50i-h6-r.c        |   2 +-
 drivers/clk/sunxi-ng/ccu-sun50i-h6.c          |   3 +-
 drivers/clk/sunxi-ng/ccu-sun8i-a23.c          |   3 +-
 drivers/clk/sunxi-ng/ccu-sun8i-a33.c          |   3 +-
 drivers/clk/sunxi-ng/ccu-sun8i-a83t.c         |   3 +-
 drivers/clk/sunxi-ng/ccu-sun8i-h3.c           |   3 +-
 drivers/clk/sunxi-ng/ccu-sun8i-r.c            |  20 +-
 drivers/clk/sunxi-ng/ccu-sun9i-a80.c          |   3 +-
 drivers/irqchip/Kconfig                       |   9 +
 drivers/irqchip/Makefile                      |   1 +
 drivers/irqchip/irq-mbox.c                    | 199 +++++++++++
 drivers/mailbox/Kconfig                       |  11 +
 drivers/mailbox/Makefile                      |   2 +
 drivers/mailbox/sunxi-msgbox.c                | 315 ++++++++++++++++++
 31 files changed, 750 insertions(+), 45 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/mbox-intc.txt
 create mode 100644 Documentation/devicetree/bindings/mailbox/allwinner,sunxi-msgbox.yaml
 create mode 100644 drivers/irqchip/irq-mbox.c
 create mode 100644 drivers/mailbox/sunxi-msgbox.c

-- 
2.19.2

