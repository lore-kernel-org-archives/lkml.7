Return-Path: <SRS0=6SCO=RE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA0D3C43381
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 05:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 966392087E
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Mar 2019 05:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sholland.org header.i=@sholland.org header.b="JbtRncGu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BpSDFUek"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728026AbfCAF3y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Mar 2019 00:29:54 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:42897 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726189AbfCAF3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Mar 2019 00:29:54 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id EBDF121AB4;
        Fri,  1 Mar 2019 00:29:52 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 01 Mar 2019 00:29:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm2; bh=4sJ0QvbHFrHgY
        YKLnD6Nl7ke1xODL6daE8lQX6XAObc=; b=JbtRncGu+yhytt7cBt5Hxk0zpbqoI
        beXS0M7yYj9dBBaSGw0qdI0WSz1q6bk556myFExT32CjCJ2QutJdtPPLBZMKlJrW
        2VnalN2GCRu/6gVLSRw2LJbqDc+Hb612h3QPgnc/lvSyqcr7GTpzc+EajdOgCcrW
        drDkd++cCZ8PfCUQ+/NBTkGZlFdS8JA7/h5M3PEndJDybwaG46K/Q3F0yv4utyXy
        j6cQCMGQgqJTqpdSk5VME5Hwzz/4gtSSMhDgwmSJFOs80nNsSGtEkc/CNs/RG3/w
        K+NZSFyPoZPjqD96fZWn8MxamkqbUQdfVb79NKxOWxbBZcg2N61i+QL9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=4sJ0QvbHFrHgYYKLnD6Nl7ke1xODL6daE8lQX6XAObc=; b=BpSDFUek
        mPKmEUrzdJnnwWejOfpZ2t8V0OXyCqnJYsCkz84RPeP2DxhSET4FCr93fc6M/Pvd
        39Bfly5qcaXzjUur14VdfOa+KFlga3d+/DMwtQc2TpW5RrI+y6qZRaWYT9EsPwe7
        WigvBZp06ICNZr4leiKEfzigSop3Vo1NKzBKkwx6xkdHZbbU89vO6UOo1JHBQkUM
        UdYz6xMtNumcZvAKLKjxt4KVb0uZtH1SRDSyKw9v6w1hkL2n2TqnD+RTfVembXxD
        m0FXINaxnKLIUGKg9kBLpz2cuDDYXdEzCOoxl+u4ygu6iyrmy6vfeBF+TChJZBYM
        pLbao5MRjNBylA==
X-ME-Sender: <xms:UMN4XA8uK2__Kzehku3KmfLynh0KGgRUejXNdR2N24Kq-jKQOAqPjA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedutddrvdeggdekjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecukfhppe
    ejtddrudefhedrudegkedrudehudenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhu
    vghlsehshhholhhlrghnugdrohhrghenucevlhhushhtvghrufhiiigvpedv
X-ME-Proxy: <xmx:UMN4XNIkdexZxk9ieVQvL5CzGAnfYgluncdWOwVWy6hRIs57Vepkqg>
    <xmx:UMN4XBVuxtYN8B5-QpPVAU08zfuvdzaPiyMhNVQnwi8wwQsuvvoH2w>
    <xmx:UMN4XNxoZE2gdS-DpYd1UOzHmUrU50zYRsE-Ip4C_nbbPkSOHKuWNw>
    <xmx:UMN4XEOOPr9hjQ-J2sgHw51NkNQFGUIJ10H0oKq0kcsrGauG5iW1dA>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 215FBE427E;
        Fri,  1 Mar 2019 00:29:52 -0500 (EST)
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
Subject: [PATCH v2 06/10] ARM: dts: sunxi: a80: Add msgbox node
Date:   Thu, 28 Feb 2019 23:29:43 -0600
Message-Id: <20190301052947.32032-7-samuel@sholland.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20190301052947.32032-1-samuel@sholland.org>
References: <20190301052947.32032-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The A80 SoC contains a message box that can be used to send messages and
interrupts back and forth between the ARM application CPUs and the ARISC
coprocessor. Add a device tree node for it.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 arch/arm/boot/dts/sun9i-a80.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/sun9i-a80.dtsi b/arch/arm/boot/dts/sun9i-a80.dtsi
index d9532fb1ef65..10e878f94fc0 100644
--- a/arch/arm/boot/dts/sun9i-a80.dtsi
+++ b/arch/arm/boot/dts/sun9i-a80.dtsi
@@ -283,6 +283,16 @@
 			};
 		};
 
+		msgbox: mailbox@803000 {
+			compatible = "allwinner,sun9i-a80-msgbox",
+				     "allwinner,sun6i-a31-msgbox";
+			reg = <0x00803000 0x1000>;
+			clocks = <&ccu CLK_BUS_MSGBOX>;
+			resets = <&ccu RST_BUS_MSGBOX>;
+			interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
+			#mbox-cells = <1>;
+		};
+
 		ehci0: usb@a00000 {
 			compatible = "allwinner,sun9i-a80-ehci", "generic-ehci";
 			reg = <0x00a00000 0x100>;
-- 
2.19.2

