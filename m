Return-Path: <SRS0=U1ji=ZC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A00C43331
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 02:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEDD2225AD
	for <linux-kernel@archiver.kernel.org>; Sun, 10 Nov 2019 02:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573354283;
	bh=wFarCmC1vgEJ83u0SNHI/6bTj2VuSACrgAQl9SOjl9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kgvcfD4cCDs6dzfxp3P0x+k2KmXmoD2seUS1U87xCs6VglR+bFY64/Dcjfz+GDOgn
	 ohaBBs01/X3fYvgY5rxO9Bl0NMbIOQOrd/U/ZIE2yBrjbpYcg3/7cGaV2nux/viOb0
	 bgYIAzDGXdD34y1HwaMXyocdOSiIcbbadLTuNGPA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729958AbfKJCvW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 Nov 2019 21:51:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:35400 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729889AbfKJCvH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Nov 2019 21:51:07 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C980122790;
        Sun, 10 Nov 2019 02:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573354266;
        bh=wFarCmC1vgEJ83u0SNHI/6bTj2VuSACrgAQl9SOjl9w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sa2mIf8Ya/7kPaHCxl47bThOIu0HR94tA4m4pZyoRoEsUPlvgImOBJCusFzu6nHDd
         FwX2zx8NhQpn5UtAYdas48T2FsZrl/7WGN3n3J7xcfPQTVVZUnN+CpF7618Y7erTmJ
         +ps3vq74JLL23pD9ZKBHu//maSvTuwgeexbk/dQI=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Grygorii Strashko <grygorii.strashko@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 15/40] ARM: dts: am335x-evm: fix number of cpsw
Date:   Sat,  9 Nov 2019 21:50:07 -0500
Message-Id: <20191110025032.827-15-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191110025032.827-1-sashal@kernel.org>
References: <20191110025032.827-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Grygorii Strashko <grygorii.strashko@ti.com>

[ Upstream commit dcbf6b18d81bcdc51390ca1b258c17e2e13b7d0c ]

am335x-evm has only one CPSW external port physically wired, but DT defines
2 ext. ports. As result, PHY connection failure reported for the second
ext. port.

Update DT to reflect am335x-evm board HW configuration, and, while here,
switch to use phy-handle instead of phy_id.

Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/am335x-evm.dts | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index d9d00ab863a21..2b8614e406f03 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -697,6 +697,7 @@
 	pinctrl-0 = <&cpsw_default>;
 	pinctrl-1 = <&cpsw_sleep>;
 	status = "okay";
+	slaves = <1>;
 };
 
 &davinci_mdio {
@@ -704,15 +705,14 @@
 	pinctrl-0 = <&davinci_mdio_default>;
 	pinctrl-1 = <&davinci_mdio_sleep>;
 	status = "okay";
-};
 
-&cpsw_emac0 {
-	phy_id = <&davinci_mdio>, <0>;
-	phy-mode = "rgmii-txid";
+	ethphy0: ethernet-phy@0 {
+		reg = <0>;
+	};
 };
 
-&cpsw_emac1 {
-	phy_id = <&davinci_mdio>, <1>;
+&cpsw_emac0 {
+	phy-handle = <&ethphy0>;
 	phy-mode = "rgmii-txid";
 };
 
-- 
2.20.1

