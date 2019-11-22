Return-Path: <SRS0=i7el=ZO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61BE2C432C0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3586E20718
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Nov 2019 10:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574420198;
	bh=IeNKQvy9juCc7xi7oxqa/oqAhGZngI0NECDQy/pOYzg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=iKSC/BPJtDEklmmUwQn1CU5nvZXXadLUPcrvV7pgXo1dciYhgD6rTWW9JH8gY8Lnu
	 8xxsTDyMn0cXHJUAlSffm60P4C5RcmS5DPFfwNpdoKfZPa5CW9S9ec0jmkksxMfKJg
	 /NbgkIZrubr2656yuJNzuwhDYdXJbl1fHZGwpvsI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730614AbfKVK4g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Nov 2019 05:56:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:44520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730161AbfKVK43 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Nov 2019 05:56:29 -0500
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAA2A2071F;
        Fri, 22 Nov 2019 10:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574420189;
        bh=IeNKQvy9juCc7xi7oxqa/oqAhGZngI0NECDQy/pOYzg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FiGxExORJ7E8Pu1QRBRgUPea8QuV9MlUJdZfEdo415IscypIoovdKmH1rk6exw0tK
         V/NR+hU6Jd3l29BfyUww3QsYP5kSukQB58hWSEeCU7JrWR8cxF4z47OywWt76lcttV
         lrZz42qnTk9ripxsvlUFtWbK62mjHDQEIzn2Cx6I=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 023/220] ARM: dts: sun8i: h3: bpi-m2-plus: Fix address for external RGMII Ethernet PHY
Date:   Fri, 22 Nov 2019 11:26:28 +0100
Message-Id: <20191122100914.164336048@linuxfoundation.org>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191122100912.732983531@linuxfoundation.org>
References: <20191122100912.732983531@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chen-Yu Tsai <wens@csie.org>

[ Upstream commit db9fd9d13e30fc67737ac9893a82e6b095e85a64 ]

The external RTL8211E RGMII Ethernet PHY is configured via external
resistors to use the address 0x1. The 0x0 address is a broadcast address
for this family of PHYs, and should not be used explicitly.

Fixes: 8c7ba536e709 ("ARM: sun8i: bananapi-m2-plus: Enable dwmac-sun8i")
Fixes: 4904337fe34f ("ARM: dts: sunxi: Restore EMAC changes (boards)")
Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts b/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts
index 30540dc8e0c5f..bdda0d99128e5 100644
--- a/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts
+++ b/arch/arm/boot/dts/sun8i-h3-bananapi-m2-plus.dts
@@ -140,7 +140,7 @@
 &external_mdio {
 	ext_rgmii_phy: ethernet-phy@1 {
 		compatible = "ethernet-phy-ieee802.3-c22";
-		reg = <0>;
+		reg = <1>;
 	};
 };
 
-- 
2.20.1



