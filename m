Return-Path: <SRS0=qvRn=2F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 162FAC4741C
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 04:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1F0720663
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Dec 2019 04:25:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="LZgPBbm5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U+kL8qcP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726787AbfLOEZF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Dec 2019 23:25:05 -0500
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:48173 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726049AbfLOEZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Dec 2019 23:25:04 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id D28375AD4;
        Sat, 14 Dec 2019 23:25:02 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sat, 14 Dec 2019 23:25:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=bDy4CFknF9Jl+
        PVBjSI9cqXdvgnSOo0SV6PphkH8UTw=; b=LZgPBbm5M2VjJSlwLAVQ8nO/CO0oa
        M9J2VcU0BMKrUI52BKC2sq8Pvp7lvVxKgyHEaha2PMjK0zk6+jLUllAKi2rRLJdb
        Sw/6FFcr6umWrJBXysKqWmmvA59DyOnZCAQwuQer/wJ0BImvkiWXSacsPdmBRXNo
        FTodb5CGOWHg5XYZt5Q/6VXiynRov92jGvWdfN+W/fMQduyE8UtcdFGPH2DlMkEy
        Z/aTjhRCBZbMT4yb2AbpOJrCZ75YRpsrOE631m9kO5ZjFn6CdXelKODXpiUT38ji
        ZFDQU/KecI1PIKFkbXq1MDWFtAUlNA+R9O49SePYNVrDZhOnPM7tufOSg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=bDy4CFknF9Jl+PVBjSI9cqXdvgnSOo0SV6PphkH8UTw=; b=U+kL8qcP
        AgdD+YUKTOlqTuVIIgVb6ekbTdsGikTbgPhhfod10VwdB5yzhfvQyReapR0xT0SF
        FpMCBpkuPR54OTjo94j8CHooGhO2DhJXLJoswM7psCjO2SJQWNzOr7pMVUkhTfpW
        JTVSF0JK2aF9V+4LEzj4VFH0uFCHc7Ef3aAiDphqcW1ZWDeQrj5LHr8k4gyfKCY1
        py92hUqIZwHMQZVLMw2q/BL/+OnkbItYyRrq0lOadNoGbdJYfvjIRQq5ihaqK5vT
        bGA3KH/kiueOLvCOyh8yOzoHFGro00DpoSG+wTp2qdGf75cSt44hPShyTuaP9fPz
        D008NU11xZs5tw==
X-ME-Sender: <xms:nrX1XUM1_brYRZiUfFcsbFaNhduepsbE3OkmwT84UEf_VNCL-PVD0A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvddtvddgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucfkph
    epjedtrddufeehrddugeekrdduhedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghm
    uhgvlhesshhhohhllhgrnhgurdhorhhgnecuvehluhhsthgvrhfuihiivgepvd
X-ME-Proxy: <xmx:nrX1XVSGG-L9bGFfoetks_iq_qqUDvAx5RJYrMWGtgwWMPn44OYakQ>
    <xmx:nrX1XSyaavD7-7sO5VutgFsVxluRtF80eiammAmSgZ0PUNqGUyM7jA>
    <xmx:nrX1XbdhJ0ADbHLRH3wwu0W2fiYP9CHrAbKTdPib3Xo2VSeKIyEYbA>
    <xmx:nrX1XdjwjHR1c_bjDRW5lqMq_IHHPgZUeQO2sJNZwIalhaI9x49a6A>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 60A3180059;
        Sat, 14 Dec 2019 23:25:01 -0500 (EST)
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
Subject: [PATCH v5 6/8] arm64: dts: allwinner: a64: Add msgbox node
Date:   Sat, 14 Dec 2019 22:24:53 -0600
Message-Id: <20191215042455.51001-7-samuel@sholland.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191215042455.51001-1-samuel@sholland.org>
References: <20191215042455.51001-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The A64 SoC contains a message box that can be used to send messages and
interrupts back and forth between the ARM application CPUs and the ARISC
coprocessor. Add a device tree node for it.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 27e48234f1c2..10edb4b59203 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -496,6 +496,16 @@
 			resets = <&ccu RST_BUS_CE>;
 		};
 
+		msgbox: mailbox@1c17000 {
+			compatible = "allwinner,sun50i-a64-msgbox",
+				     "allwinner,sun6i-a31-msgbox";
+			reg = <0x01c17000 0x1000>;
+			clocks = <&ccu CLK_BUS_MSGBOX>;
+			resets = <&ccu RST_BUS_MSGBOX>;
+			interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
+			#mbox-cells = <1>;
+		};
+
 		usb_otg: usb@1c19000 {
 			compatible = "allwinner,sun8i-a33-musb";
 			reg = <0x01c19000 0x0400>;
-- 
2.23.0

