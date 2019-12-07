Return-Path: <SRS0=Iet2=Z5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40B0EC2D0BE
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 19:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04CA42176D
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Dec 2019 19:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="HSWfbL1R";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nMRjGBn3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfLGTW5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Dec 2019 14:22:57 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:47997 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726473AbfLGTW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Dec 2019 14:22:56 -0500
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 25A3960B;
        Sat,  7 Dec 2019 14:22:55 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Sat, 07 Dec 2019 14:22:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=Z2PjyZf3136gCvtJS7r8XhFYol
        pFs7Qq0QrFZubMpCM=; b=HSWfbL1RCQWIFnBsdrVRkQaLS2TYI0LaPj/VDRTvnT
        ldIZsB2gupLuHbodKyMnKt1kQd/Pr7X1L3U1RDZPmgbGTlfkwiJgcRPuRNuTRN5D
        H5A9m31TJnU0wqh+80QlYCu8jxVIkTw0UAR55hN2G/iScfKDGv5Izbv59K4s68Wt
        WPQmtkyt2tWwuo8R+X5XB1bAqFWEkCbNGIMJ5xvv2QAkS659Zi9nDYY31cm2T/Ff
        va1BkoKdRz2gKk5Rz3Wx4cNWt6xUkZpyu+6riqGG931gKTIBhpitmleqNyuepa+b
        jzRF6CjMtxwtyu6HUZnOJTKAG468Vt0XIx5m3SMAU2lA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=Z2PjyZf3136gCvtJS
        7r8XhFYolpFs7Qq0QrFZubMpCM=; b=nMRjGBn3tzAClgnICYBySrm/ENoibw3u6
        tx2fC1IAGxGKmqKajoP+0SsT7vg6qAHP8RcxEC3OFr9xhzf7M+dgTwCcZ/K10c6D
        xsPSOI5Uw1wTihZWdVN3RADyBz8SV6nYiLji0Wj+5ccohR00Ai+2+XRtVNhK+tsy
        1n2OKWgDq4J8VLHra/KqFT0VRYpxRqbGROlGun3eZyjOOkbWiJT3EKWdE9x2WSEy
        eAem2dUQLQR/8M0jsREiciqyNJj3Q1qqKmimA1WC7CtjYAJ1unel1OiCYK4copT6
        Z7pkP6tPXhmybRAXCq0Y6qohi+k8GlHvCQUhAdtx/KCX6VZZP2h4A==
X-ME-Sender: <xms:DfzrXRmpJRN1AyywKk3kYG79Eg5bpc5ViuUbW1HA7sToh0gWZvKKRw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudekhedguddvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpeetlhhishhtrghirhcuhfhrrghntghishcuoegrlhhishhtrghi
    rhesrghlihhsthgrihhrvdefrdhmvgeqnecukfhppeejfedrleefrdekgedrvddtkeenuc
    frrghrrghmpehmrghilhhfrhhomheprghlihhsthgrihhrsegrlhhishhtrghirhdvfedr
    mhgvnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:DvzrXaqDIWey4LD3tIiJ70YiTXjivHNS_kuFndwt3rMoxX9S3aIfTg>
    <xmx:DvzrXSEBiX_6Di5fnn1lT8q4LAVeDMWjQpohdvoONgp0cq3LZXYbjQ>
    <xmx:DvzrXexuW1uHyS8qlDMhp7T0BVv63nIGTCmgPUCfjEHvMvoF_o80_A>
    <xmx:DvzrXfpMp_j_rK60mgG68zfbChFE1hv5ztTxxqh5X7XH0qxREg-yig>
Received: from alistair-xps-14z.alistair23.me (c-73-93-84-208.hsd1.ca.comcast.net [73.93.84.208])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0CDEE80062;
        Sat,  7 Dec 2019 14:22:52 -0500 (EST)
From:   Alistair Francis <alistair@alistair23.me>
To:     linux-kernel@vger.kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        wens@csie.org, mripard@kernel.org, alistair23@gmail.com,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH] arm64: allwinner: Enable Bluetooth and WiFi on sopine baseboard
Date:   Sat,  7 Dec 2019 11:22:49 -0800
Message-Id: <20191207192249.8346-1-alistair@alistair23.me>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sopine board has an optional RTL8723BS WiFi + BT module that can be
connected to UART1. Add this to the device tree so that it will work for
users if connected.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 .../dts/allwinner/sun50i-a64-sopine-baseboard.dts  | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
index 920103ec0046..0a91f9d8ed47 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
@@ -214,6 +214,20 @@ &uart0 {
 	status = "okay";
 };
 
+&uart1 {
+        pinctrl-names = "default";
+        pinctrl-0 = <&uart1_pins>, <&uart1_rts_cts_pins>;
+        status = "okay";
+
+        bluetooth {
+                compatible = "realtek,rtl8723bs-bt";
+                reset-gpios = <&r_pio 0 4 GPIO_ACTIVE_LOW>; /* PL4 */
+                device-wake-gpios = <&r_pio 0 5 GPIO_ACTIVE_HIGH>; /* PL5 */
+                host-wake-gpios = <&r_pio 0 6 GPIO_ACTIVE_HIGH>; /* PL6 */
+                firmware-postfix = "pine64";
+        };
+};
+
 /* On Pi-2 connector */
 &uart2 {
 	pinctrl-names = "default";
-- 
2.24.0

