Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27E6FC10F03
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 05:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFC462087E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 05:30:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="mtWQVhUx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tIUL/aDr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbfCAF3x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 00:29:53 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:42113 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726189AbfCAF3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 00:29:52 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 8046522098;
        Fri,  1 Mar 2019 00:29:51 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 01 Mar 2019 00:29:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=LsAmdVWXGGKSd
        xtImpsZNqV8mKGJx6ggOMkI4cJuZzQ=; b=mtWQVhUxvO4d20W4/OC86a15U3ocr
        hzqhyKG9pXoOL0Kk+3CjJnDo1PA3n72IrGPTseZA86axqFbwQhlKOTlB+uRzzFSM
        y/EhOw8XQYp3UPrWTkwdhhYiDB8XeeJEuYBggbGPENj3BHMwPOqM9Kh3CZQh4lDv
        lojyd5ezoT2H0JqPWd0tkIp/8QJx5FZ4ljY8I0+4hLYjyq6HPL6D+bgX9q88mGhT
        6yNAqBudmtGIoJB4uimmEVXN9it8oXzqxBJ0D9nJ30H3VbulZ5F+ZXK1A6S2NtNg
        f5H9MkgdSQwhoI5ahgdaVa3RGrFeX1XtRkU/3myo1n44+SuRYtDeG2Unw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=LsAmdVWXGGKSdxtImpsZNqV8mKGJx6ggOMkI4cJuZzQ=; b=tIUL/aDr
        +vMXXEMJvQ85Ug0F+6tSuppjb2pG9B+JAVgElFJqTN5AW7n+/6AsProgiM9toLsb
        OXxFXMpmkYl5ii9TUmzzQetv0reR3KFBWIm7SErbB7usvMEzFrwV9VTg3HW4Z3Ci
        g1KOU8Rt75vyF4F7vajHNcXo//l2Q/35j7uowYLtGREWUpUtbWpt43HLu/Uw5Ylt
        K1WtQxhP1XwAEWKNy5l8p28h97aZA0DOTX3aqDdf9eE/FezOuvQdInV3B4HbNeRm
        +x8WnXZtf78eraRMQA+7js3caTeVYRlTVG8tdLEaL8NVtnxghj2crAk/rnLoWR8Y
        /6TfaZsbI6jyQQ==
X-ME-Sender: <xms:T8N4XLUjm7zGjxmv-RT9MTBZYTU4M9uBptl1hb7Z8frRvA71dvQDCQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrvdeggdekjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecukfhppe
    ejtddrudefhedrudegkedrudehudenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhu
    vghlsehshhholhhlrghnugdrohhrghenucevlhhushhtvghrufhiiigvpedv
X-ME-Proxy: <xmx:T8N4XJ9QaeNckCniIbYptf-5SM5J-LAcQOelFYF57ZZ7tYurj9dSOg>
    <xmx:T8N4XDpPyiN5pvPMkz-tOrMkvaY47xmYlIm68JzLU_fLDmMxWzT7fA>
    <xmx:T8N4XEJ3N7tuUSk81LMlblrVsMddF1RzrAOLi4G3SSbhdfr1n7UJWA>
    <xmx:T8N4XKown-fTvHIh3V02_Ma5U1nLTi5Cm8C_Ea6XRwKEb72wyLUU8w>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5FD3BE457F;
        Fri,  1 Mar 2019 00:29:50 -0500 (EST)
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
Subject: [PATCH v2 03/10] clk: sunxi-ng: sun50i: Mark the msgbox clock as critical
Date:   Thu, 28 Feb 2019 23:29:40 -0600
Message-Id: <20190301052947.32032-4-samuel@sholland.org>
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

At this time, such power management firmware only exists for the A64.
However, it makes sense to take care of all CCU drivers now for
consistency, and to ease the transition in the future, once firmware is
ported to the other SoCs.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 drivers/clk/sunxi-ng/ccu-sun50i-a64.c | 2 +-
 drivers/clk/sunxi-ng/ccu-sun50i-h6.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
index 932836d26e2b..7780e855c56f 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
@@ -350,7 +350,7 @@ static SUNXI_CCU_GATE(bus_de_clk,	"bus-de",	"ahb1",
 static SUNXI_CCU_GATE(bus_gpu_clk,	"bus-gpu",	"ahb1",
 		      0x064, BIT(20), 0);
 static SUNXI_CCU_GATE(bus_msgbox_clk,	"bus-msgbox",	"ahb1",
-		      0x064, BIT(21), 0);
+		      0x064, BIT(21), CLK_IS_CRITICAL);
 static SUNXI_CCU_GATE(bus_spinlock_clk,	"bus-spinlock",	"ahb1",
 		      0x064, BIT(22), 0);
 
diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
index 139e8389615c..a7fee407a1c8 100644
--- a/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
+++ b/drivers/clk/sunxi-ng/ccu-sun50i-h6.c
@@ -340,7 +340,7 @@ static SUNXI_CCU_GATE(bus_dma_clk, "bus-dma", "psi-ahb1-ahb2",
 		      0x70c, BIT(0), 0);
 
 static SUNXI_CCU_GATE(bus_msgbox_clk, "bus-msgbox", "psi-ahb1-ahb2",
-		      0x71c, BIT(0), 0);
+		      0x71c, BIT(0), CLK_IS_CRITICAL);
 
 static SUNXI_CCU_GATE(bus_spinlock_clk, "bus-spinlock", "psi-ahb1-ahb2",
 		      0x72c, BIT(0), 0);
-- 
2.19.2

