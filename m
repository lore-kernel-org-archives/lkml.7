Return-Path: <SRS0=Exau=WQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E08AC3A5A0
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 03:23:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E67822CE8
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Aug 2019 03:23:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="Z8aZcK0S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QDO+YqPO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729176AbfHTDXW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 23:23:22 -0400
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:53323 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729095AbfHTDXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 23:23:18 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 21154353B;
        Mon, 19 Aug 2019 23:23:17 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 19 Aug 2019 23:23:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm3; bh=tuQrtgFJDi3rt
        CNY0leoagNnY3nRZhaV8CR1RVhP8Us=; b=Z8aZcK0SJgG/NtWJbKYt+qm7Qv678
        1Eeyx5gaERmKy5h2LBrjUvrupf0bei0vU8QWrG5zCuPbUa3nn7JlfPkOq32/RRXC
        yN15Rax5hzLPPUJR1TghNvQTY2UnvhSXrPdBRnYyk1e1nNUYxCof3qIV5ymbv10D
        yWjCdBMWbr0HuLIowuPcMLX1Kfw9Epc2vC7swwnifLziKx+lw2YY/s3b51YmfAw3
        LdJuX/6dh//3G3S7sXOvGEXc7STmMUu+7HMuOG94QazJXg/yumvGscPpaHrPXaaQ
        dpbOH3kPVNz4hL892rS0oZXTlXIDDxVugkIOGP0pIe7ykjA4khDgAV4Sw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; bh=tuQrtgFJDi3rtCNY0leoagNnY3nRZhaV8CR1RVhP8Us=; b=QDO+YqPO
        Sfx49dsLnLF5BjC+D1DX+hEnKlJrTlj+s4FH5v3nnwGKPpuiVt5tPRRFq7pbE1gL
        E9LlYqvwr02+niw6y6xBA0Xcyt1yuwLvAK4hRaRHCnScCYUOMU66AUXsmT9E+C+h
        fkzV8iHdcDkbBOLMcKdrHz0kkwnwEHCCvpr/WbzZDL1LKCx6hBxBHpJABXWgbf03
        zgfh7hqRzDed2mQe1aZHnqzmDEzp07y9NBO8xSz89WCHJsUnKxI/FSRo0514unH4
        vPQMfBjPzoa8pi6+L/JMZ5vKbPZ7DLwW56LYYl2hdQwa2oYIDUTibKoG8B7Z32UC
        0B3JJCwesajCFg==
X-ME-Sender: <xms:pGdbXQclp1vZhL71xEx3Rv8xlY-iOmPixbEJyyxX0VPOaG110QciTQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduvddrudegtddgjeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucfkph
    epjedtrddufeehrddugeekrdduhedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghm
    uhgvlhesshhhohhllhgrnhgurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:pGdbXapopq4fR-pX4tTT1yzDNsniU2EDfEG1E__v0zztSCFob9I-Mg>
    <xmx:pGdbXR-8iKtlhjBaerDfuZ_ldQvsQlZF-IB1u8ZJ8rkTJOeQuQ9VPg>
    <xmx:pGdbXWfCRZdnqvPIWNppYQROL6BcVmVEGq2cGGN5_EuKqz29HLNjsw>
    <xmx:pWdbXbPQgCL-orUsTGZIMFS-9pV-uQAjXQfegQs1lE9p8fXftCx6qA>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1F0098005B;
        Mon, 19 Aug 2019 23:23:16 -0400 (EDT)
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
Subject: [PATCH v4 07/10] ARM: dts: sunxi: h3/h5: Add msgbox node
Date:   Mon, 19 Aug 2019 22:23:08 -0500
Message-Id: <20190820032311.6506-8-samuel@sholland.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190820032311.6506-1-samuel@sholland.org>
References: <20190820032311.6506-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The H3 and H5 SoCs contain a message box that can be used to send
messages and interrupts back and forth between the ARM application CPUs
and the ARISC coprocessor. Add a device tree node for it.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 arch/arm/boot/dts/sunxi-h3-h5.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/sunxi-h3-h5.dtsi b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
index 224e105a994a..f25876a8021a 100644
--- a/arch/arm/boot/dts/sunxi-h3-h5.dtsi
+++ b/arch/arm/boot/dts/sunxi-h3-h5.dtsi
@@ -232,6 +232,16 @@
 			reg = <0x1c14000 0x400>;
 		};
 
+		msgbox: mailbox@1c17000 {
+			compatible = "allwinner,sun8i-h3-msgbox",
+				     "allwinner,sun6i-a31-msgbox";
+			reg = <0x01c17000 0x1000>;
+			clocks = <&ccu CLK_BUS_MSGBOX>;
+			resets = <&ccu RST_BUS_MSGBOX>;
+			interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
+			#mbox-cells = <1>;
+		};
+
 		usb_otg: usb@1c19000 {
 			compatible = "allwinner,sun8i-h3-musb";
 			reg = <0x01c19000 0x400>;
-- 
2.21.0

