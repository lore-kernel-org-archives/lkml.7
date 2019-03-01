Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB3CC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 05:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 801A62186A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 05:29:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="JT/A7mXN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h+a2NI2N"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727713AbfCAF3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 00:29:54 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:54155 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726066AbfCAF3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 00:29:52 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 60C1B22094;
        Fri,  1 Mar 2019 00:29:51 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 01 Mar 2019 00:29:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=TTwkUtJ9PY83X
        cQmX2n6BAa0PkEZyFKMbWTQxj8EjRw=; b=JT/A7mXNrL0ezHxSycWhLLM3lVkUh
        ns4Wh1d9bcxgVqBI1IOwa+o2UzcBX4ZF7JrFrKiSD4jSYT2g08z0lsdMG6qjXe8I
        Nbjb0KFVoxA79ighDK7pf5srkiNXIvrliKezsEWd2ll+3YzT1UY0RVmxnJYeBX0/
        /iP7U1CrqWei2gW6mIzdApukljilpkAWRbdu+XGaUsYIr+6Uwx1zYN71qhS+LKsS
        ElMKSFK13WNETOCiPgXGkpQLHd4zlKoHfTzJ5cQMXnd4FXM+jgdBEcrf6zeZn1JY
        exnWelZgks6TEC69cUewSODU/f2k0KSgUW3Xe8eUQfQD7ub7twFVH3ocw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=TTwkUtJ9PY83XcQmX2n6BAa0PkEZyFKMbWTQxj8EjRw=; b=h+a2NI2N
        aYGwF7T4BilhMabMgkpAiiyxN6N1M/2hV63u6vbYcOG+2OrUJPjEQo1Wnuch5T9C
        Vjvt1NsZPhrF/Z7rr8oOLEfGRrriVoslRK+PI4/r4qGnrLqa2pOCLppJIB2iWZcz
        IBh1Shs06G70sdhtUQ9Z/3GNZMmVB7aAZKewBCCgSdxl17V4WakyBvwxjnMKSrrg
        478aZGFoEtL25OljaFuF7Ja7bJNDbed5rKwDDpEgK6IF0kWVdnGGwGXCwE5XYIbn
        ZCOAcnemaTPuBONrsWzMRnCCRHjWqXOsJBValGLmRyULeLsPaObLywuigGHXksyS
        tHxbmssRCrF/gQ==
X-ME-Sender: <xms:TcN4XBJG_vr0o_jdIq6eBSwLQZ-RRE4pW6IBiEVOfpA_Way4dzXfLw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrvdeggdekjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecukfhppe
    ejtddrudefhedrudegkedrudehudenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhu
    vghlsehshhholhhlrghnugdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:TcN4XLAHpf57_4NXHyGU3P51RiFX35GEqn-YmtxHpD5fdxANcmCrwg>
    <xmx:TcN4XCzaQRPuyIK5Wt7GNg2zbMAu2h4MecbUT-qr3eOB6TdLTXa8hA>
    <xmx:TcN4XDrKr0CoCx9zlYYDLWZgqqllBy4jFoJv50-2rf_JFczieEiKDQ>
    <xmx:T8N4XDTQBOsuXhNrTrce6eOKROTYtnKiz5xn-Jg20K8nT5Hw1ka6wg>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3EAA8E427E;
        Fri,  1 Mar 2019 00:29:49 -0500 (EST)
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
Subject: [PATCH v2 01/10] clk: sunxi-ng: sun8i: Mark the msgbox clock as critical
Date:   Thu, 28 Feb 2019 23:29:38 -0600
Message-Id: <20190301052947.32032-2-samuel@sholland.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190301052947.32032-1-samuel@sholland.org>
References: <20190301052947.32032-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The msgbox clock is critical because the hardware is shared between
Linux and system firmware. The message box may be used by the EL3 secure
monitor's PSCI implementation. On 64-bit sunxi SoCs, this is provided by
ARM TF-A; 32-bit SoCs use a different implementation. The secure monitor
uses the message box to forward requests to power management firmware
running on a separate CPU.

It is not enough for the secure monitor to enable the clock each time
Linux performs a SMC into EL3, as both the firmware and Linux can run
concurrently on separate CPUs. So it is never safe for Linux to turn
this clock off, and it should be marked as critical.

At this time, such power management firmware only exists for the H5.
However, it makes sense to take care of all CCU drivers now for
consistency, and to ease the transition in the future, once firmware is
ported to the other SoCs.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 drivers/clk/sunxi-ng/ccu-sun8i-a23.c  | 2 +-
 drivers/clk/sunxi-ng/ccu-sun8i-a33.c  | 2 +-
 drivers/clk/sunxi-ng/ccu-sun8i-a83t.c | 2 +-
 drivers/clk/sunxi-ng/ccu-sun8i-h3.c   | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-a23.c b/drivers/clk/sunxi-ng/ccu-sun8i-a23.c
index a4fa2945f230..22d09cb20326 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-a23.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-a23.c
@@ -263,7 +263,7 @@ static SUNXI_CCU_GATE(bus_de_fe_clk,	"bus-de-fe",	"ahb1",
 static SUNXI_CCU_GATE(bus_gpu_clk,	"bus-gpu",	"ahb1",
 		      0x064, BIT(20), 0);
 static SUNXI_CCU_GATE(bus_msgbox_clk,	"bus-msgbox",	"ahb1",
-		      0x064, BIT(21), 0);
+		      0x064, BIT(21), CLK_IS_CRITICAL);
 static SUNXI_CCU_GATE(bus_spinlock_clk,	"bus-spinlock",	"ahb1",
 		      0x064, BIT(22), 0);
 static SUNXI_CCU_GATE(bus_drc_clk,	"bus-drc",	"ahb1",
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-a33.c b/drivers/clk/sunxi-ng/ccu-sun8i-a33.c
index c7bf814dfd2b..6d25b7a1c81e 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-a33.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-a33.c
@@ -275,7 +275,7 @@ static SUNXI_CCU_GATE(bus_de_fe_clk,	"bus-de-fe",	"ahb1",
 static SUNXI_CCU_GATE(bus_gpu_clk,	"bus-gpu",	"ahb1",
 		      0x064, BIT(20), 0);
 static SUNXI_CCU_GATE(bus_msgbox_clk,	"bus-msgbox",	"ahb1",
-		      0x064, BIT(21), 0);
+		      0x064, BIT(21), CLK_IS_CRITICAL);
 static SUNXI_CCU_GATE(bus_spinlock_clk,	"bus-spinlock",	"ahb1",
 		      0x064, BIT(22), 0);
 static SUNXI_CCU_GATE(bus_drc_clk,	"bus-drc",	"ahb1",
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-a83t.c b/drivers/clk/sunxi-ng/ccu-sun8i-a83t.c
index 2d6555d73170..85809c454b1f 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-a83t.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-a83t.c
@@ -347,7 +347,7 @@ static SUNXI_CCU_GATE(bus_de_clk,	"bus-de",	"ahb1",
 static SUNXI_CCU_GATE(bus_gpu_clk,	"bus-gpu",	"ahb1",
 		      0x064, BIT(20), 0);
 static SUNXI_CCU_GATE(bus_msgbox_clk,	"bus-msgbox",	"ahb1",
-		      0x064, BIT(21), 0);
+		      0x064, BIT(21), CLK_IS_CRITICAL);
 static SUNXI_CCU_GATE(bus_spinlock_clk,	"bus-spinlock",	"ahb1",
 		      0x064, BIT(22), 0);
 
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c b/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
index e71e2451c2e3..d09629688fd4 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
@@ -281,7 +281,7 @@ static SUNXI_CCU_GATE(bus_de_clk,	"bus-de",	"ahb1",
 static SUNXI_CCU_GATE(bus_gpu_clk,	"bus-gpu",	"ahb1",
 		      0x064, BIT(20), 0);
 static SUNXI_CCU_GATE(bus_msgbox_clk,	"bus-msgbox",	"ahb1",
-		      0x064, BIT(21), 0);
+		      0x064, BIT(21), CLK_IS_CRITICAL);
 static SUNXI_CCU_GATE(bus_spinlock_clk,	"bus-spinlock",	"ahb1",
 		      0x064, BIT(22), 0);
 
-- 
2.19.2

