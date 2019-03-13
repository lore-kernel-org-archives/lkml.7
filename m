Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E497BC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0EAF2184C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 19:11:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1552504287;
	bh=P+bjVQ6VAGQEXm/HwpZWc8c6O8zhLEFDZAFvpIuP+IE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YgJ3hRaWF4d+pBHj1URIDZQ+dMSzClUMHgY8EMLQKVZqp9hqjYF83JYSBRXzShYbE
	 lnBR3TNBveC5IRCl3zh69ZLkE/QAhwEf7shzO9nrOeuhf9Rb6K8V7kAHRFwPLuY8pP
	 HfHivU2BwuEN8S3xHax3vOeDzHVDtPyDI+z3bldc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbfCMTL0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 15:11:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:41916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727404AbfCMTLV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 15:11:21 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 143672173C;
        Wed, 13 Mar 2019 19:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1552504281;
        bh=P+bjVQ6VAGQEXm/HwpZWc8c6O8zhLEFDZAFvpIuP+IE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vzImk+3ZNpVso3BXXwsGw9o57TDvuUIzpxfCbTOkY0CON7rcsyQ8Ke7YzkTelsqOt
         AkPaOTXVRyW4U2Wj1bNJPRF5sv84dyBLPkzXcuZy7aB6DYDhlhpeAHmeCP4qgQ+GLf
         br19Zt06RE8iaskWoz0yf1gRDIkspoansF7amGDk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 29/60] ARM: dts: am335x-evm: Fix PHY mode for ethernet
Date:   Wed, 13 Mar 2019 15:09:50 -0400
Message-Id: <20190313191021.158171-29-sashal@kernel.org>
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

[ Upstream commit 37685f6a63eeca2135d1f704e7638409a071b1f6 ]

The PHY must add both tx and rx delay and not only on the tx clock.
The board uses AR8031_AL1A PHY where the rx delay is enabled by default,
the tx dealy is disabled.

The reason why rgmii-txid worked because the rx delay was not disabled by
the driver so essentially we ended up with rgmii-id PHY mode.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/am335x-evm.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/am335x-evm.dts b/arch/arm/boot/dts/am335x-evm.dts
index 98ec9c3e49ba..8399bc983416 100644
--- a/arch/arm/boot/dts/am335x-evm.dts
+++ b/arch/arm/boot/dts/am335x-evm.dts
@@ -729,7 +729,7 @@
 
 &cpsw_emac0 {
 	phy-handle = <&ethphy0>;
-	phy-mode = "rgmii-txid";
+	phy-mode = "rgmii-id";
 };
 
 &tscadc {
-- 
2.19.1

