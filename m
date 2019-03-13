Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE77C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2E3E20657
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:32:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552505529;
	bh=NBulQS9k1r3B2mJEeIVlwvy8lKHBF8pERRAsHNeXc8s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=foK1YiaX6zl+Z+ZxQcrXWUxCWpQNuBPzDCuxVHHr/1Nms3oGDL6iWa71kP54ypCA0
	 pbFuceLFbXlHPuSevy7e47tCZIlZ/8PLs6OvM8sKdicvjEY9yGk6oCOe4E0gx04BgE
	 +8EDeDkklmleau9kVsxgPLN7KV39symsCndi9rKk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727446AbfCMTLX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:11:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:41900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727402AbfCMTLU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:11:20 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 08D4B213A2;
        Wed, 13 Mar 2019 19:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552504279;
        bh=NBulQS9k1r3B2mJEeIVlwvy8lKHBF8pERRAsHNeXc8s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dFZUKDGDBcBw5p71ZIuFdS10bbgFT76dC+YwcFBx0Jw0Y5i1CiorZ2ps4d1QELCba
         EHW8O6AfO9Ro54kUy3Ti+8wmv5LR+P43CSYWA/l6XM9DW1g/M3wq/DOG8eWvW7t6ut
         8dB6aqKpC47gZcyVA8oeItX7dBy8Ghsx2XC39/ME=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 28/60] ARM: dts: am335x-evmsk: Fix PHY mode for ethernet
Date:   Wed, 13 Mar 2019 15:09:49 -0400
Message-Id: <20190313191021.158171-28-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190313191021.158171-1-sashal@kernel.org>
References: <20190313191021.158171-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Ujfalusi <peter.ujfalusi@ti.com>

[ Upstream commit 759c962d3c9bb1a60e3b4b780daa66ee6d4be13a ]

The PHY must add both tx and rx delay and not only on the tx clock.
The board uses AR8031_AL1A PHY where the rx delay is enabled by default,
the tx dealy is disabled.

The reason why rgmii-txid worked because the rx delay was not disabled by
the driver so essentially we ended up with rgmii-id PHY mode.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/am335x-evmsk.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/am335x-evmsk.dts b/arch/arm/boot/dts/am335x-evmsk.dts
index 245868f58fe3..583f83b1742d 100644
--- a/arch/arm/boot/dts/am335x-evmsk.dts
+++ b/arch/arm/boot/dts/am335x-evmsk.dts
@@ -651,13 +651,13 @@
 
 &cpsw_emac0 {
 	phy-handle = <&ethphy0>;
-	phy-mode = "rgmii-txid";
+	phy-mode = "rgmii-id";
 	dual_emac_res_vlan = <1>;
 };
 
 &cpsw_emac1 {
 	phy-handle = <&ethphy1>;
-	phy-mode = "rgmii-txid";
+	phy-mode = "rgmii-id";
 	dual_emac_res_vlan = <2>;
 };
 
-- 
2.19.1

