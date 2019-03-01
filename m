Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86633C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 05:30:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D6EA2186A
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 05:30:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="MVZtHRov";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NnO4M3BL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731721AbfCAFar (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 00:30:47 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:53759 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726243AbfCAF3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 00:29:52 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id C197F2208C;
        Fri,  1 Mar 2019 00:29:51 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 01 Mar 2019 00:29:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=M96FGgsCu/e2E
        q9aZjdotyD+op/vvfCg0VjjMXQ7q3w=; b=MVZtHRovNtHd5Rht0mmeJFLkpO1Sm
        1Monlk3sWsxdlMT0ugXncKRvQFfMLXipC9kQsLMJ0U9DaEuLoo7ZGgO7DrIuiCp2
        W3mufIqi8uSue4cN+PK2VJk7bpbYRBPEXte0ZzrPl4T+l6ZnAbkdSXe/qPzT9+fv
        kmTTopP4fZrfqWtv89JiSNnegx5UmCHV/B6bTOHB1j8bgDFmufuWXUnnCqL5yVUF
        vYLbvAqWovvnj9+xCp1DUg07ZTjUVM6YgeAPsS6J3dIU9scftGRSRyQh3WXEXSvT
        VGy150SuTVQ9XXIwZuz114icG+O43lbE/cjgxrKKxUouHlRw197XCkq+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=M96FGgsCu/e2Eq9aZjdotyD+op/vvfCg0VjjMXQ7q3w=; b=NnO4M3BL
        H6Y/PQj8Yz4Da5Yeh88hoTkTFDj1wlSQhagd3XjU5wYh5Fup9lZ7mw597U5+pDI7
        PUXTz7xzYfResNYcaeLQkzKnHoPtFvXa7qB46nue5AGwqqklmUSgywFViOhAsioD
        JhYDZvTRMEIP6yMqnmMYI42gZ27H9G8QVYqlkAFCwk7ZGPFy5rRqz/zsvqmh/pML
        y2IOEhXsotpRuiiH7KJedMugRxwR8M6wmMM8keVFWrkruLvJfMEoYavhKo9fDMP6
        clskPLTl2jmkWRmltUdYEMbTwXIKe8RtAL8VgmxQj/PNLxjdO7n1zO+5Ca511llq
        lAQrC3GJJ98tYw==
X-ME-Sender: <xms:T8N4XJwopTW13xC1WHos9JsAAjvu-5d7kAyDr2tv2LUdCYnZsUyiWQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrvdeggdekjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecukfhppe
    ejtddrudefhedrudegkedrudehudenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhu
    vghlsehshhholhhlrghnugdrohhrghenucevlhhushhtvghrufhiiigvpedv
X-ME-Proxy: <xmx:T8N4XNhnw5InnMDbhj9IFN7UElOBseAT3WWD6HWO4srIlnMAcO133Q>
    <xmx:T8N4XOUzStkxpn1cxk13eqbRm_xU3cwXsCkjI9w-igbmKMEewS1HMA>
    <xmx:T8N4XP3fUqvpx8m_u6IRAJW0L2sO3OCAZbpAficZ98-toncsIeZ-Hg>
    <xmx:T8N4XH9FBMNrM0DV_zE0OqbEx9b6mY3KDp2N1Vr7-kTBzIJp4Pw1HA>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id E5453E4662;
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
Subject: [PATCH v2 04/10] dt-bindings: mailbox: Add a sunxi message box binding
Date:   Thu, 28 Feb 2019 23:29:41 -0600
Message-Id: <20190301052947.32032-5-samuel@sholland.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190301052947.32032-1-samuel@sholland.org>
References: <20190301052947.32032-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This mailbox hardware is present in Allwinner sun8i, sun9i, and sun50i
SoCs. Add a device tree binding for it.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 .../bindings/mailbox/sunxi-msgbox.txt         | 44 +++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/mailbox/sunxi-msgbox.txt

diff --git a/Documentation/devicetree/bindings/mailbox/sunxi-msgbox.txt b/Documentation/devicetree/bindings/mailbox/sunxi-msgbox.txt
new file mode 100644
index 000000000000..4560ab8efeca
--- /dev/null
+++ b/Documentation/devicetree/bindings/mailbox/sunxi-msgbox.txt
@@ -0,0 +1,44 @@
+Allwinner sun6i Message Box
+===========================
+
+The hardware message box on sun6i and newer sunxi SoCs is a two-user mailbox
+controller containing 8 unidirectional FIFOs. An interrupt is raised for
+received messages, but software must poll to know when a transmitted message has
+been acknowledged by the remote user.
+
+Refer to ./mailbox.txt for generic information about mailbox device-tree
+bindings.
+
+Mailbox Device Node:
+====================
+
+Required properties:
+--------------------
+- compatible:		Must contain at least "allwinner,sun6i-a31-msgbox".
+			Should also contain another SoC-specific string when
+			used on other SoCs which are compatible, e.g.
+			- allwinner,sun6i-a31-msgbox
+			- allwinner,sun8i-a83t-msgbox, allwinner,sun6i-a31-msgbox
+			- allwinner,sun8i-h3-msgbox, allwinner,sun6i-a31-msgbox
+			- allwinner,sun9i-a80-msgbox, allwinner,sun6i-a31-msgbox
+			- allwinner,sun50i-a64-msgbox, allwinner,sun6i-a31-msgbox
+			- allwinner,sun50i-h6-msgbox, allwinner,sun6i-a31-msgbox
+- reg:			Contains the mailbox register address range (base
+			address and length).
+- clocks:		phandle for the bus clock controller and specifier.
+- resets:		phandle for the bus reset controller and specifier.
+- interrupts:		Contains interrupt information for the mailbox.
+- #mbox-cells:		Must be 1.
+
+Example:
+--------
+
+	msgbox: mailbox@1c17000 {
+		compatible = "allwinner,sun8i-h3-msgbox",
+		             "allwinner,sun6i-a31-msgbox";
+		reg = <0x01c17000 0x1000>;
+		clocks = <&ccu CLK_BUS_MSGBOX>;
+		resets = <&ccu RST_BUS_MSGBOX>;
+		interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
+		#mbox-cells = <1>;
+	};
-- 
2.19.2

