Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2DF9C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:58:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F3972070D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="EaIXBjrR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387481AbfC0F6N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 01:58:13 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:17626 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733260AbfC0F5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 01:57:39 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c9b10d50000>; Tue, 26 Mar 2019 22:57:41 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 26 Mar 2019 22:57:38 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 26 Mar 2019 22:57:38 -0700
Received: from HQMAIL108.nvidia.com (172.18.146.13) by HQMAIL105.nvidia.com
 (172.20.187.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 27 Mar
 2019 05:57:38 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 27 Mar 2019 05:57:38 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.161.83]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c9b10d00001>; Tue, 26 Mar 2019 22:57:37 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <talho@nvidia.com>, <skomatineni@nvidia.com>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <kyarlagadda@nvidia.com>
CC:     <ldewangan@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH V1 21/26] DT bindings: spi: add tx/rx clock delay SPI client properties
Date:   Tue, 26 Mar 2019 22:56:42 -0700
Message-ID: <1553666207-11414-21-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553666207-11414-1-git-send-email-skomatineni@nvidia.com>
References: <1553666207-11414-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1553666261; bh=ZhooVT7e7y0UvpyK4jtj0c+ZzgA5KeS46L9eKsUYhhg=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=EaIXBjrRc3l56FkjN08LgIdJx2fncM3u/HK2HdHZQ58GjFTe/H9xkcBSqns7hgSUy
         NVWe5AzzbfxyKBME1wHZyAO2zFOKWVzHtK8z2FarQp+lzZOqU9GZM5TyY4P9JFiot1
         gMntU+KZVeWxgwJHPTw7RnDPJKRk62kWCJlldYQ3qLxTXl25STC/JZaDDsVD+i1Vg0
         ddfdwSsLhmxVIfkAOuE2CgTcL1edecoDQHgWhcRSyajDhiF+eDAI3dJpwnKrSzTO+L
         01iagCH6gD2FST0ilngLddvmtJdCK7pJG2Ytjp3waXEUVV3qTz3LXrNWJbErRPe8zK
         qml8x2nDgfBtw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds Tegra SPI master tx and rx clock delay properties.

TX/RX clock delays may vary depending on the platform design trace lengths
for each client on the Tegra SPI bus. These properties helps to tune the
clock delays.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 .../devicetree/bindings/spi/nvidia,tegra114-spi.txt      | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.txt b/Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.txt
index 6167c5234b64..2b84b7b726ce 100644
--- a/Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.txt
+++ b/Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.txt
@@ -29,6 +29,12 @@ spi-client device controller properties:
 - nvidia,cs-hold-clk-count: CS hold timing parameter.
 - nvidia,cs-inactive-cycles: CS inactive delay in terms of clock between
   transfers.
+- nvidia,tx-clk-tap-delay: Delays the clock going out to the external device
+  with this tap value. This property is used to tune the outgoing data from
+  Tegra SPI master with respect to outgoing Tegra SPI master clock.
+- nvidia,rx-clk-tap-delay: Delays the clock coming in from the external device
+  with this tap value. This property is used to adjust the Tegra SPI master
+  clock with respect to the data from the SPI slave device.
 
 Example:
 
@@ -45,4 +51,14 @@ spi@7000d600 {
 	reset-names = "spi";
 	dmas = <&apbdma 16>, <&apbdma 16>;
 	dma-names = "rx", "tx";
+
+	<spi-client>@<bus_num> {
+		...
+		...
+		nvidia,cs-setup-clk-count = <10>;
+		nvidia,cs-hold-clk-count = <10>;
+		nvidia,rx-clk-tap-delay = <0>;
+		nvidia,tx-clk-tap-delay = <16>;
+		...
+	};
 };
-- 
2.7.4

