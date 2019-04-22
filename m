Return-Path: <SRS0=BnvS=SY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7AF1C10F11
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:43:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89B532175B
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Apr 2019 19:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555962188;
	bh=MRJ1qOTwXruQV9MqbWARRrXTg1Y63EZTx63jFZgIbbw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=giwV3nZfLnEETsy+0VtEMBnVfY5pe930zkVbuBe0sy//IrOLwibUqWD366iaJp7l/
	 m2/H2sQEMzCYt62xJ/hILEsdAYpYboxCsKTykcaGqFpAWeSHQ6pqn3PtaZtwDqEVke
	 wNinOFmm+i72u/HA9w0AALMwssqPWGPFyg3gRseM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729101AbfDVTnH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Apr 2019 15:43:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:43572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729071AbfDVTnE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Apr 2019 15:43:04 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5418217D4;
        Mon, 22 Apr 2019 19:43:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555962183;
        bh=MRJ1qOTwXruQV9MqbWARRrXTg1Y63EZTx63jFZgIbbw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xrPVQ84IgSfatjnmJV94U7rBww6Uf5JJAhA4or/4WAfFcBmqSOBiAd7Kfs6ei7KkP
         eXXwdr0j96TnwgWQyB4XZEqMsRH5eZMHpzsM1ooIkvoeQgCeu0Z7P8vClCKPOq3Jx3
         WFjUFZgzIjW6VpLSaknuRevUWbETev2iVZxBN7R8=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Marco Felsch <m.felsch@pengutronix.de>,
        Stefan Christ <s.christ@phytec.de>,
        Christian Hemp <c.hemp@phytec.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 34/98] ARM: dts: pfla02: increase phy reset duration
Date:   Mon, 22 Apr 2019 15:41:01 -0400
Message-Id: <20190422194205.10404-34-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190422194205.10404-1-sashal@kernel.org>
References: <20190422194205.10404-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marco Felsch <m.felsch@pengutronix.de>

[ Upstream commit 032f85c9360fb1a08385c584c2c4ed114b33c260 ]

Increase the reset duration to ensure correct phy functionality. The
reset duration is taken from barebox commit 52fdd510de ("ARM: dts:
pfla02: use long enough reset for ethernet phy"):

  Use a longer reset time for ethernet phy Micrel KSZ9031RNX. Otherwise a
  small percentage of modules have 'transmission timeouts' errors like

  barebox@Phytec phyFLEX-i.MX6 Quad Carrier-Board:/ ifup eth0
  warning: No MAC address set. Using random address 7e:94:4d:02:f8:f3
  eth0: 1000Mbps full duplex link detected
  eth0: transmission timeout
  T eth0: transmission timeout
  T eth0: transmission timeout
  T eth0: transmission timeout
  T eth0: transmission timeout

Cc: Stefan Christ <s.christ@phytec.de>
Cc: Christian Hemp <c.hemp@phytec.de>
Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
Fixes: 3180f956668e ("ARM: dts: Phytec imx6q pfla02 and pbab01 support")
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin (Microsoft) <sashal@kernel.org>
---
 arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
index 1b50b01e9bac..65d03c5d409b 100644
--- a/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-phytec-pfla02.dtsi
@@ -90,6 +90,7 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_enet>;
 	phy-mode = "rgmii";
+	phy-reset-duration = <10>; /* in msecs */
 	phy-reset-gpios = <&gpio3 23 GPIO_ACTIVE_LOW>;
 	phy-supply = <&vdd_eth_io_reg>;
 	status = "disabled";
-- 
2.19.1

