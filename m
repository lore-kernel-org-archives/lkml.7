Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B12E6C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 05:30:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7A5EB2087E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 05:30:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="FwSwP0LM";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HO83+WTM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727445AbfCAF3x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 00:29:53 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:60011 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726088AbfCAF3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 00:29:52 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 62F7F22096;
        Fri,  1 Mar 2019 00:29:51 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 01 Mar 2019 00:29:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=yryg0tD/bXbuw
        sX4giILeR1x3xJOYHPxD4a8sc7UekA=; b=FwSwP0LMLYMroz+Lqw8UuB8gBJLyo
        uIFh4F2qKwAXmnMrgclRXGbJDAtZHW3Eo9ZpSvu3/L/FoJf68a2zFYXN86clmysM
        2mjk8CpzN72Hra5uO8CIoMHBIU7CQLEbPmDFUC++1ZdjL1UU/Kd+j0Mp00UIqQUU
        g4B0vkFePKkyrvwf1KZlCsKZ4mPix+0QkNaUITHtntQIMODa965EJcl0PJ/xpX3R
        +oPJXM8Hn5zcp8GZiKUqeGSre91DhIjUSGXoeziYTXLA6gwcX+22/3EwktIxvp79
        /p1Pzi7/DtPkliVqgG3ORPsEZLH1mLlecE714LNCKbdaM+Ovm9MZn0LRA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=yryg0tD/bXbuwsX4giILeR1x3xJOYHPxD4a8sc7UekA=; b=HO83+WTM
        ogLjdbs06hh1xYXJFob11pI5tU9H0ElAOm40M8INISRf2UUqGmCCy/vJyOsRqj8x
        yvK/67SPo5SITy2iQrK/o8azrwd5JCvcMkUn6P/3udpVDHoYeO6eopc/yoIu2Xd/
        OEEJubH0+5iN4O7RsLMlyDg2Rku+l0uIX4ny2JLNm+//nafy/tSXQguvTtTbiMuI
        CWJK6+ZZZZ2cvfnKV27+dFq8o7pIa8H8PjAGU+jC35s5apib3aAMp8x0+nBHY5oa
        U/A71Xb/c5Z9UhEQOWUazZYtzCuy4HgCOjI1ai6AVmywogisODL5EOqqeDXsI3xr
        NXSwhu4/iPEjNA==
X-ME-Sender: <xms:TsN4XOPWpTsBQpBFW48kmPkyLFL2yhtL9Zr0RoyluMG2WgaWYIs-iQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrvdeggdekjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecukfhppe
    ejtddrudefhedrudegkedrudehudenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhu
    vghlsehshhholhhlrghnugdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:TsN4XBNmFfmTlyCjBKSitGy4bLeF9LNj8RtUtPqL69O-ob12LsKnJQ>
    <xmx:TsN4XAR1AJ3trxn_8MTJHId6arAHe7A64X6MaCygmOa0wYXu6F97oA>
    <xmx:TsN4XDB0Aqlv5xbn6c3400x2rj019Kg81O9sMrjLxzFvHhjLrnWGwg>
    <xmx:T8N4XHJM3dLcEjV8FwQQ-Nn0Sv5CUOfDKcZ1fjPHOfaTHA0kbN3g2Q>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id CEB25E4546;
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
Subject: [PATCH v2 02/10] clk: sunxi-ng: sun9i: Mark the msgbox clock as critical
Date:   Thu, 28 Feb 2019 23:29:39 -0600
Message-Id: <20190301052947.32032-3-samuel@sholland.org>
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

At this time, such power management firmware does not exist for the A80.
However, it makes sense to take care of all CCU drivers now for
consistency, and to ease the transition in the future, once firmware is
ported to this SoC.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 drivers/clk/sunxi-ng/ccu-sun9i-a80.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/sunxi-ng/ccu-sun9i-a80.c b/drivers/clk/sunxi-ng/ccu-sun9i-a80.c
index 8936ef87652c..f9309782e7d8 100644
--- a/drivers/clk/sunxi-ng/ccu-sun9i-a80.c
+++ b/drivers/clk/sunxi-ng/ccu-sun9i-a80.c
@@ -756,7 +756,7 @@ static SUNXI_CCU_GATE(bus_usb_clk,	"bus-usb",	"ahb1",
 static SUNXI_CCU_GATE(bus_gmac_clk,	"bus-gmac",	"ahb1",
 		      0x584, BIT(17), 0);
 static SUNXI_CCU_GATE(bus_msgbox_clk,	"bus-msgbox",	"ahb1",
-		      0x584, BIT(21), 0);
+		      0x584, BIT(21), CLK_IS_CRITICAL);
 static SUNXI_CCU_GATE(bus_spinlock_clk,	"bus-spinlock",	"ahb1",
 		      0x584, BIT(22), 0);
 static SUNXI_CCU_GATE(bus_hstimer_clk,	"bus-hstimer",	"ahb1",
-- 
2.19.2

