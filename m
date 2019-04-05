Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 387B8C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 00:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04370217D4
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 00:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="A3nvBv7L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731077AbfDEAOx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 20:14:53 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:11333 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730762AbfDEAOi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 20:14:38 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ca69deb0000>; Thu, 04 Apr 2019 17:14:35 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 04 Apr 2019 17:14:37 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 04 Apr 2019 17:14:37 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 5 Apr
 2019 00:14:37 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 5 Apr 2019 00:14:37 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.103.48]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ca69dec0001>; Thu, 04 Apr 2019 17:14:36 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <talho@nvidia.com>, <skomatineni@nvidia.com>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <kyarlagadda@nvidia.com>
CC:     <ldewangan@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH V2 19/20] DT bindings: spi: document tx/rx clock delay properties
Date:   Thu, 4 Apr 2019 17:14:18 -0700
Message-ID: <1554423259-26056-19-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554423259-26056-1-git-send-email-skomatineni@nvidia.com>
References: <1554423259-26056-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1554423275; bh=UI55pKb+sdPb0XZNgJdTj04yVil0AOFyMJLcyBa3hBg=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=A3nvBv7LMSJxcYh/FOSRrSZZJWA3k47qR+eWNoKbHsA+9WetpafyUwv9ppkNWrppz
         fulVDOeprn9gD1m/ETLiyFYU4oYh47kb8YrAPPOvECs9QPtY94sh7sLsuP1ZXV9gWy
         I8frshjitX+8gK4D3SX6qXpoCmB2LDPcHGS3pHUZ6IjyJf4oXB/i+wy5+iijCw9Yc1
         z3qdVZls4rRuFbWLRI48WWFOBG3Y+u7sU1k8JprRxkGguOe2qE8BQdXP6oZjd3tSl5
         XKeElRAKCxraqTyo+qKuf383lD9f2DMqc1ZS3iLaZxtHCkrw1lavglKUeZtFnF480R
         BSv24yp3C8XJA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra SPI controller has TX and RX trimmers to tuning the delay of
SPI master clock with respect to the data.

TX and RX tap values are based on the platform validation across the
PVT and the trimmer values vary based on the trace lengths to the
corresponding SPI devices.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 .../devicetree/bindings/spi/nvidia,tegra114-spi.txt  | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.txt b/Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.txt
index 9ba7c5a273b4..db8e0d71c5bc 100644
--- a/Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.txt
+++ b/Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.txt
@@ -23,6 +23,18 @@ Required properties:
 Recommended properties:
 - spi-max-frequency: Definition as per
                      Documentation/devicetree/bindings/spi/spi-bus.txt
+Optional properties:
+- nvidia,tx-clk-tap-delay: Delays the clock going out to the external device
+  with this tap value. This property is used to tune the outgoing data from
+  Tegra SPI master with respect to outgoing Tegra SPI master clock.
+  Tap values vary based on the platform design trace lengths from Tegra SPI
+  to corresponding slave devices. Valid tap values are from 0 thru 63.
+- nvidia,rx-clk-tap-delay: Delays the clock coming in from the external device
+  with this tap value. This property is used to adjust the Tegra SPI master
+  clock with respect to the data from the SPI slave device.
+  Tap values vary based on the platform design trace lengths from Tegra SPI
+  to corresponding slave devices. Valid tap values are from 0 thru 63.
+
 Example:
 
 spi@7000d600 {
@@ -38,4 +50,12 @@ spi@7000d600 {
 	reset-names = "spi";
 	dmas = <&apbdma 16>, <&apbdma 16>;
 	dma-names = "rx", "tx";
+	<spi-client>@<bus_num> {
+		...
+		...
+		nvidia,rx-clk-tap-delay = <0>;
+		nvidia,tx-clk-tap-delay = <16>;
+		...
+	};
+
 };
-- 
2.7.4

