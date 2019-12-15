Return-Path: <SRS0=qvRn=2F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1486C2D0D2
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 04:25:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83B362467C
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 04:25:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="PoYyfY0Z";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UOwzkyb1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbfLOEZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 23:25:01 -0500
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:50529 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726019AbfLOEZA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 23:25:00 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 89E8A5A9C;
        Sat, 14 Dec 2019 23:24:58 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 14 Dec 2019 23:24:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=/BdBX9KpJW198
        Ta1eCmzbMoGLXCd9rn/ML7K+vXiTBU=; b=PoYyfY0Z2wOnxJ8T64U5fgfhHP2na
        C0S9/nz57fJVrTX9chWlhA7PC4QDkxe5RcxM7O2kp4QnpFTbOCF08EL1Xka8i4Dm
        ioI2TUQlWEE88b4hBwYcXEZgfTxJd8LyDPRadPamk2epnyrJAixBtBO92b5J5Mw7
        nyuF0FzO9uQrnotrmAVb78pbvFSiIjbftzJITJfCjKACEYmtV7vFuNwFtGmthZJa
        MOyifVKpvx7wQ++nAsht/jltLkrqzx1uRUegHzpHpIwChI2d9duLX+o8tkY5/BoK
        KR0OMBFTqnL8Y2NG33/P5krRyhse1Ff35B1Q0god0XimJOMzLGK3nFe5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=/BdBX9KpJW198Ta1eCmzbMoGLXCd9rn/ML7K+vXiTBU=; b=UOwzkyb1
        BHbL528JZoJp4w0mcdWwJJdn0/Z+qV4mHnDxERdqgxM9Bssdq9LnD8qPk07ZMU0x
        0E6PQWD7gkee+MLw0NjxpHR2McUFPEu6Mv5TZRri6PM2J536Bt8Pz508nD0tjVKZ
        ZTaCP1jzgxfQCyuG3MyZA8C507RkhAbb1iXSum7X7x8eAkHxQsjNKgRERtKC9VAL
        sTvTs9sr495z+uSPi2/VzUjvrqOpoMzqY99tQx9Fmmhan64qG2+hA/BlDN5fjK36
        u4AUiZR05t4WaOKrWRA/mE7awDyRjMiRYGWBlr6Ku262HtkeQfP9JM6daYb5HSH2
        YU2x8XMCTapkSA==
X-ME-Sender: <xms:mrX1XcS0FaOkvGIdam0i_ovkGa74Er5MwDRQT4pKO1J_Ao9wks4BCQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvddtvddgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucfkph
    epjedtrddufeehrddugeekrdduhedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghm
    uhgvlhesshhhohhllhgrnhgurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:mrX1XSl_aeTe3tdWhMXra3SzVk68iAmH8fAdgrHQK30vDyVUP4c9Zw>
    <xmx:mrX1XQy1ytLeevpf-OSm2_FKLrAry4MP1PFZE4w7miRTE3Ro-JKuDA>
    <xmx:mrX1XZkTe_jZkA9SkGXfhsQqOnRWYlYPjDH7kPs0PBLlw40Te4Bm2g>
    <xmx:mrX1XUFI2LCYMkrA5nWVgT-aOT8X3Z2DsbYa8bbPRdUqO1_AYlWhPA>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6F7548005C;
        Sat, 14 Dec 2019 23:24:57 -0500 (EST)
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
Subject: [PATCH v5 1/8] clk: sunxi-ng: Mark msgbox clocks as critical
Date:   Sat, 14 Dec 2019 22:24:48 -0600
Message-Id: <20191215042455.51001-2-samuel@sholland.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191215042455.51001-1-samuel@sholland.org>
References: <20191215042455.51001-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The msgbox clock is critical because the hardware it controls is shared
between Linux and system firmware. The message box may be used by the
EL3 secure monitor's PSCI implementation. On 64-bit sunxi SoCs, this is
provided by ARM TF-A; 32-bit SoCs use a different implementation. The
secure monitor uses the message box to forward requests to power
management firmware running on a separate CPU.

It is not enough for the secure monitor to enable the clock each time
Linux performs a SMC into EL3, as both the firmware and Linux can run
concurrently on separate CPUs. So it is never safe for Linux to turn
this clock off, and it should be marked as critical.

At this time, such power management firmware only exists for the A64 and
H5 SoCs.  However, it makes sense to take care of all CCU drivers now
for consistency, and to ease the transition in the future once firmware
is ported to the other SoCs.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 drivers/clk/sunxi-ng/ccu-sun50i-a64.c | 3 ++-
 drivers/clk/sunxi-ng/ccu-sun50i-h6.c  | 3 ++-
 drivers/clk/sunxi-ng/ccu-sun8i-a23.c  | 3 ++-
 drivers/clk/sunxi-ng/ccu-sun8i-a33.c  | 3 ++-
 drivers/clk/sunxi-ng/ccu-sun8i-a83t.c | 3 ++-
 drivers/clk/sunxi-ng/ccu-sun8i-h3.c   | 3 ++-
 drivers/clk/sunxi-ng/ccu-sun9i-a80.c  | 3 ++-
 7 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
index 49bd7a4c015c..045121b50da3 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
@@ -342,8 +342,9 @@ static SUNXI_CCU_GATE(bus_de_clk,	"bus-de",	"ahb1",
 		      0x064, BIT(12), 0);
 static SUNXI_CCU_GATE(bus_gpu_clk,	"bus-gpu",	"ahb1",
 		      0x064, BIT(20), 0);
+/* Used for communication between firmware components at runtime */
 static SUNXI_CCU_GATE(bus_msgbox_clk,	"bus-msgbox",	"ahb1",
-		      0x064, BIT(21), 0);
+		      0x064, BIT(21), CLK_IS_CRITICAL);
 static SUNXI_CCU_GATE(bus_spinlock_clk,	"bus-spinlock",	"ahb1",
 		      0x064, BIT(22), 0);
 
diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
index f2497d0a4683..91da52ca3c75 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
@@ -349,8 +349,9 @@ static SUNXI_CCU_GATE(bus_vp9_clk, "bus-vp9", "psi-ahb1-ahb2",
 static SUNXI_CCU_GATE(bus_dma_clk, "bus-dma", "psi-ahb1-ahb2",
 		      0x70c, BIT(0), 0);
 
+/* Used for communication between firmware components at runtime */
 static SUNXI_CCU_GATE(bus_msgbox_clk, "bus-msgbox", "psi-ahb1-ahb2",
-		      0x71c, BIT(0), 0);
+		      0x71c, BIT(0), CLK_IS_CRITICAL);
 
 static SUNXI_CCU_GATE(bus_spinlock_clk, "bus-spinlock", "psi-ahb1-ahb2",
 		      0x72c, BIT(0), 0);
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-a23.c b/drivers/clk/sunxi-ng/ccu-sun8i-a23.c
index 103aa504f6c8..5a28583f57e2 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-a23.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-a23.c
@@ -255,8 +255,9 @@ static SUNXI_CCU_GATE(bus_de_fe_clk,	"bus-de-fe",	"ahb1",
 		      0x064, BIT(14), 0);
 static SUNXI_CCU_GATE(bus_gpu_clk,	"bus-gpu",	"ahb1",
 		      0x064, BIT(20), 0);
+/* Used for communication between firmware components at runtime */
 static SUNXI_CCU_GATE(bus_msgbox_clk,	"bus-msgbox",	"ahb1",
-		      0x064, BIT(21), 0);
+		      0x064, BIT(21), CLK_IS_CRITICAL);
 static SUNXI_CCU_GATE(bus_spinlock_clk,	"bus-spinlock",	"ahb1",
 		      0x064, BIT(22), 0);
 static SUNXI_CCU_GATE(bus_drc_clk,	"bus-drc",	"ahb1",
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-a33.c b/drivers/clk/sunxi-ng/ccu-sun8i-a33.c
index 91838cd11037..50cf3726ef30 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-a33.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-a33.c
@@ -267,8 +267,9 @@ static SUNXI_CCU_GATE(bus_de_fe_clk,	"bus-de-fe",	"ahb1",
 		      0x064, BIT(14), 0);
 static SUNXI_CCU_GATE(bus_gpu_clk,	"bus-gpu",	"ahb1",
 		      0x064, BIT(20), 0);
+/* Used for communication between firmware components at runtime */
 static SUNXI_CCU_GATE(bus_msgbox_clk,	"bus-msgbox",	"ahb1",
-		      0x064, BIT(21), 0);
+		      0x064, BIT(21), CLK_IS_CRITICAL);
 static SUNXI_CCU_GATE(bus_spinlock_clk,	"bus-spinlock",	"ahb1",
 		      0x064, BIT(22), 0);
 static SUNXI_CCU_GATE(bus_drc_clk,	"bus-drc",	"ahb1",
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-a83t.c b/drivers/clk/sunxi-ng/ccu-sun8i-a83t.c
index 2b434521c5cc..4ab3a76f4ffa 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-a83t.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-a83t.c
@@ -339,8 +339,9 @@ static SUNXI_CCU_GATE(bus_de_clk,	"bus-de",	"ahb1",
 		      0x064, BIT(12), 0);
 static SUNXI_CCU_GATE(bus_gpu_clk,	"bus-gpu",	"ahb1",
 		      0x064, BIT(20), 0);
+/* Used for communication between firmware components at runtime */
 static SUNXI_CCU_GATE(bus_msgbox_clk,	"bus-msgbox",	"ahb1",
-		      0x064, BIT(21), 0);
+		      0x064, BIT(21), CLK_IS_CRITICAL);
 static SUNXI_CCU_GATE(bus_spinlock_clk,	"bus-spinlock",	"ahb1",
 		      0x064, BIT(22), 0);
 
diff --git a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c b/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
index 6b636362379e..7429d3fe8fb7 100644
--- a/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
+++ b/drivers/clk/sunxi-ng/ccu-sun8i-h3.c
@@ -273,8 +273,9 @@ static SUNXI_CCU_GATE(bus_de_clk,	"bus-de",	"ahb1",
 		      0x064, BIT(12), 0);
 static SUNXI_CCU_GATE(bus_gpu_clk,	"bus-gpu",	"ahb1",
 		      0x064, BIT(20), 0);
+/* Used for communication between firmware components at runtime */
 static SUNXI_CCU_GATE(bus_msgbox_clk,	"bus-msgbox",	"ahb1",
-		      0x064, BIT(21), 0);
+		      0x064, BIT(21), CLK_IS_CRITICAL);
 static SUNXI_CCU_GATE(bus_spinlock_clk,	"bus-spinlock",	"ahb1",
 		      0x064, BIT(22), 0);
 
diff --git a/drivers/clk/sunxi-ng/ccu-sun9i-a80.c b/drivers/clk/sunxi-ng/ccu-sun9i-a80.c
index ef29582676f6..471e841aabdf 100644
--- a/drivers/clk/sunxi-ng/ccu-sun9i-a80.c
+++ b/drivers/clk/sunxi-ng/ccu-sun9i-a80.c
@@ -748,8 +748,9 @@ static SUNXI_CCU_GATE(bus_usb_clk,	"bus-usb",	"ahb1",
 		      0x584, BIT(1), 0);
 static SUNXI_CCU_GATE(bus_gmac_clk,	"bus-gmac",	"ahb1",
 		      0x584, BIT(17), 0);
+/* Used for communication between firmware components at runtime */
 static SUNXI_CCU_GATE(bus_msgbox_clk,	"bus-msgbox",	"ahb1",
-		      0x584, BIT(21), 0);
+		      0x584, BIT(21), CLK_IS_CRITICAL);
 static SUNXI_CCU_GATE(bus_spinlock_clk,	"bus-spinlock",	"ahb1",
 		      0x584, BIT(22), 0);
 static SUNXI_CCU_GATE(bus_hstimer_clk,	"bus-hstimer",	"ahb1",
-- 
2.23.0

