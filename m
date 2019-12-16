Return-Path: <SRS0=TLrx=2G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 797C4C43603
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5197620CC7
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Dec 2019 18:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1576521175;
	bh=ymG65eyYvOkGT/a1o3YdUCpKSlzLO0odxHAPgjHBxno=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=VWKCjZ9P2uDyDGj8LpuffmIUuhTQh3d9D3IpCdYR82Fr76bMRTv0QslLAZ5oV7flQ
	 8kOGjaqk980ENXHaKoPIFta24kS09F/UiABQYAm0Mxff1IMn+saX3KvwoE31InxYoP
	 o3PhTaJb72ukeY4o7N6TRPUm+Ywr0OO0IXHE0K2M=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730519AbfLPScy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Dec 2019 13:32:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:60232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728309AbfLPScv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 13:32:51 -0500
Received: from localhost.localdomain (unknown [122.182.192.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C1A44207FF;
        Mon, 16 Dec 2019 18:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576521171;
        bh=ymG65eyYvOkGT/a1o3YdUCpKSlzLO0odxHAPgjHBxno=;
        h=From:To:Cc:Subject:Date:From;
        b=2Bn0vV2zeXZU42Qw/Iw9TpgoDoWqkVhKIjIuQJH4XiImIpywXcXN9r6B/r9yN8nxN
         UNdyhISxhr5AgbOi71Oe3VEUwchQi9DKK026Cj5gmyebGmfAnRa5zAvmAmGO7qvzK7
         1vy46WuyaWgjjgx2ElTXOTWZXfS5RcmtXxFg0qq4=
From:   Vinod Koul <vkoul@kernel.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] arm64: dts: qcom: sm8150: Update UFS resets
Date:   Tue, 17 Dec 2019 00:02:31 +0530
Message-Id: <20191216183232.1570675-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The reset described is the phy reset so it should be named ufsphy, so
update it and add the UFS card reset

Earlier reset description was incorrect as phy reset was pointed to
'rst' as well as 'ufsphy' so both phy and core attempted to reset this
causing UFS to not come up. This was discovered with 870b1279c7a0
("scsi: ufs-qcom: Add reset control support for host controller")

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/boot/dts/qcom/sm8150.dtsi | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
index f36d621a53e2..6a351e0cb3a6 100644
--- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
@@ -517,8 +517,9 @@
 			phy-names = "ufsphy";
 			lanes-per-direction = <2>;
 			#reset-cells = <1>;
-			resets = <&gcc GCC_UFS_PHY_BCR>;
-			reset-names = "rst";
+			resets = <&gcc GCC_UFS_PHY_BCR>,
+				 <&gcc GCC_UFS_CARD_BCR>;
+			reset-names = "ufsphy", "rst";
 
 			clock-names =
 				"core_clk",
-- 
2.23.0

