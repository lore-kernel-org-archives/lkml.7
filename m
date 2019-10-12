Return-Path: <SRS0=7jSw=YF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AE94C4360C
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 20:07:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DB1020679
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Oct 2019 20:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alistair23.me header.i=@alistair23.me header.b="W/W+rJpI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wk991iMX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729689AbfJLUFa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Oct 2019 16:05:30 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:52799 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728338AbfJLUF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Oct 2019 16:05:29 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 79C2F21385;
        Sat, 12 Oct 2019 16:05:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Sat, 12 Oct 2019 16:05:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
         h=from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding; s=fm2; bh=OvzfG8zhdZT1F4AotrdKLjvY01
        WSIUt9Ce8DLglbjK4=; b=W/W+rJpIPleM+iUaW+8YgGmLkreSetZBcVOUYfU1cP
        H4yfVXNosTPzMqMy8ZzkxKk3j/PwwH1YNAOu5J0cg9PFOgagZ227c89i1AmkvpeW
        /y/ENoZET1MgkYjkU1saxNVi+dISHvw9ua7hQo30xSMRz0p1o869FIqBy0oqqfkH
        IAYEDz9dE0TSILNSc/qOh5HALhC++gEXVErc4NUJcgxxUjv1FwJIp6B0D/RCApdx
        WABeOSc3bHCF/3LcInTnIdkpKOIYNYVN0FrmoeaKtYdDCUPipa+OGlKhzIlt3JpP
        Nf7W13FzYG7I7YExQifOy/9FS7SUYgmKqVPTEmZwdx1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=OvzfG8zhdZT1F4Aot
        rdKLjvY01WSIUt9Ce8DLglbjK4=; b=Wk991iMXPO+a9X/pYazh57Nh8BDyAt14g
        +qiM+GBf6iYK1O1DRkg4YLMsVMnXPd9k+OzzNkgp0KnOX9Qo9LYy7rHqraWlRhea
        8x1y8BPRXor6A9I6Nu7t+8Mw8FIopU1f1GKXlJSlHY8hbxr0XahaN+B2I/r4EX+t
        j6QPjXTSvHyGtlQc49uM9euRj90IXz8DDBu0XZ1Sw4BRrxrhG8Pt2qX/Hm5qbiD0
        KE2v6Vjs2MPjUrsdCdzRBw0clrw2GoRp/vtMZKH3gUM0vxAZ9SW2UbJPJcpxyYl2
        CAKk95rmDHQUupLcZXbYjc1MxilnnAdxOv2Ejzlha39jQrONXxUAA==
X-ME-Sender: <xms:BzKiXa1iVBxZ4sp6o8UocD1dKwGBMGdRCAZ9lxwKQe6haAcTr1zbzg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrieejgddugeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvffufffkofgggfestdekredtre
    dttdenucfhrhhomheptehlihhsthgrihhrucfhrhgrnhgtihhsuceorghlihhsthgrihhr
    segrlhhishhtrghirhdvfedrmhgvqeenucfkphepjeefrdelfedrkeegrddvtdeknecurf
    grrhgrmhepmhgrihhlfhhrohhmpegrlhhishhtrghirhesrghlihhsthgrihhrvdefrdhm
    vgenucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:BzKiXZZevJ8A3IXvN_MXan054Rz1MwhbpZtEoNkqiFi_gymdHXyIlw>
    <xmx:BzKiXVoTdpXooHgfEcRyQDgBmfE9cWhmoPyB8t05eekBuFnB_F0XOg>
    <xmx:BzKiXdq4NHQ6_kTTW49-0b1aL7ZhMUEFALbd2TF7wePG5NQ6Gmry4g>
    <xmx:CDKiXclACE5AvIwWq51pgAS_gg_yalbrOgY_mAPbB0fvbqOVA4HbUw>
Received: from alistair-xps-14z.alistair23.me (c-73-93-84-208.hsd1.ca.comcast.net [73.93.84.208])
        by mail.messagingengine.com (Postfix) with ESMTPA id C901CD6005D;
        Sat, 12 Oct 2019 16:05:26 -0400 (EDT)
From:   Alistair Francis <alistair@alistair23.me>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     wens@csie.org, mripard@kernel.org, alistair23@gmail.com,
        Alistair Francis <alistair@alistair23.me>
Subject: [PATCH] arm64: dts: sun50i: sopine-baseboard: Expose serial1, serial2 and serial3
Date:   Sat, 12 Oct 2019 13:05:24 -0700
Message-Id: <20191012200524.23512-1-alistair@alistair23.me>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Follow what the sun50i-a64-pine64.dts does and expose all 5 serial
connections.

Signed-off-by: Alistair Francis <alistair@alistair23.me>
---
 .../allwinner/sun50i-a64-sopine-baseboard.dts | 25 +++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
index 124b0b030b28..49c37b21ab36 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
@@ -56,6 +56,10 @@
 	aliases {
 		ethernet0 = &emac;
 		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+		serial3 = &uart3;
+		serial4 = &uart4;
 	};
 
 	chosen {
@@ -280,6 +284,27 @@
 	};
 };
 
+/* On Pi-2 connector */
+&uart2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart2_pins>;
+	status = "disabled";
+};
+
+/* On Euler connector */
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart3_pins>;
+	status = "disabled";
+};
+
+/* On Euler connector, RTS/CTS optional */
+&uart4 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart4_pins>;
+	status = "disabled";
+};
+
 &usb_otg {
 	dr_mode = "host";
 	status = "okay";
-- 
2.23.0

