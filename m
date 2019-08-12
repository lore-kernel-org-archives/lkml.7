Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD216C433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 11:29:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF132214C6
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 11:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="PmicpmM7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbfHLL3U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 07:29:20 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:4820 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728231AbfHLL3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 07:29:19 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d514d900000>; Mon, 12 Aug 2019 04:29:20 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 12 Aug 2019 04:29:18 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 12 Aug 2019 04:29:18 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 12 Aug
 2019 11:29:17 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 12 Aug 2019 11:29:17 +0000
Received: from kyarlagadda-linux.nvidia.com (Not Verified[10.19.64.169]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5d514d8a0001>; Mon, 12 Aug 2019 04:29:17 -0700
From:   Krishna Yarlagadda <kyarlagadda@nvidia.com>
To:     <gregkh@linuxfoundation.org>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <ldewangan@nvidia.com>, <jslaby@suse.com>
CC:     <linux-serial@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: [PATCH 11/14] serial: tegra: DT for Adjusted baud rates
Date:   Mon, 12 Aug 2019 16:58:20 +0530
Message-ID: <1565609303-27000-12-git-send-email-kyarlagadda@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1565609303-27000-1-git-send-email-kyarlagadda@nvidia.com>
References: <1565609303-27000-1-git-send-email-kyarlagadda@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1565609360; bh=4UeP0Rj/2fy+DXTDk/rfHZROT3r4UmZzIz9aDaSr6Lg=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=PmicpmM7CJIE7JI10GKaUN4qeYz0zXEQatPXMpDZ3n8ZJnE8nzeWEy74vUmMy79Di
         KtfHSu5q7cy0K7SJmqojKZtaFgqNttFQvHnVNZe5S2ENiIxtQCPRhZg53Dq9kmxWSF
         lfgF/bPrOZChriWerpM7Q3KJRamwFf4o7mjfXyrYouLhLB1jOBWC1fvTsAy5SumyiH
         7LkQ1x+lXh2pi/JWx0c4Y2PABXNVh4lUOuPJgv7GYzOLvjUbGajuv/WiDbvauvBQt6
         oGfnzZWJ6NqGlcALtLBwcl6IxzuoDbR4GZJ915fftNmYnzeHNhCtXb+qg8UZBKTqzp
         ppT8O2R8qgqtQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra186 chip has a hardware issue resulting in frame errors when
tolerance level for baud rate is negative. Provided entries to adjust
baud rate to be within acceptable range and work with devices that
can send negative baud rate. Also report error when baud rate set is
out of tolerance range of controller updated in device tree.

Signed-off-by: Krishna Yarlagadda <kyarlagadda@nvidia.com>
---
 .../bindings/serial/nvidia,tegra20-hsuart.txt      | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/nvidia,tegra20-hsuart.txt b/Documentation/devicetree/bindings/serial/nvidia,tegra20-hsuart.txt
index 187ec78..1ce3fd4 100644
--- a/Documentation/devicetree/bindings/serial/nvidia,tegra20-hsuart.txt
+++ b/Documentation/devicetree/bindings/serial/nvidia,tegra20-hsuart.txt
@@ -20,6 +20,37 @@ Required properties:
 Optional properties:
 - nvidia,enable-modem-interrupt: Enable modem interrupts. Should be enable
 		only if all 8 lines of UART controller are pinmuxed.
+- nvidia,adjust-baud-rates: List of entries providing percentage of baud rate
+  adjustment within a range.
+  Each entry contains sets of 3 values. Range low/high and adjusted rate.
+  <range_low range_high adjusted_rate>
+  When baud rate set on controller falls within the range mentioned in this
+  field, baud rate will be adjusted by percentage mentioned here.
+  Ex: <9600 115200 200>
+  Increase baud rate by 2% when set baud rate falls within range 9600 to 115200
+
+Baud Rate tolerance:
+  Standard UART devices are expected to have tolerance for baud rate error by
+  -4 to +4 %. All Tegra devices till Tegra210 had this support. However,
+  Tegra186 chip has a known hardware issue. UART Rx baud rate tolerance level
+  is 0% to +4% in 1-stop config. Otherwise, the received data will have
+  corruption/invalid framing errors. Parker errata suggests adjusting baud
+  rate to be higher than the deviations observed in Tx.
+
+  Tx deviation of connected device can be captured over scope (or noted from
+  its spec) for valid range and Tegra baud rate has to be set above actual
+  Tx baud rate observed. To do this we use nvidia,adjust-baud-rates
+
+  As an example, consider there is deviation observed in Tx for baud rates as
+  listed below.
+  0 to 9600 has 1% deviation
+  9600 to 115200 2% deviation
+  This slight deviation is expcted and Tegra UART is expected to handle it. Due
+  to the issue stated above, baud rate on Tegra UART should be set equal to or
+  above deviation observed for avoiding frame errors.
+  Property should be set like this
+  nvidia,adjust-baud-rates = <0 9600 100>,
+  			     <9600 115200 200>;
 
 Example:
 
@@ -34,4 +65,5 @@ serial@70006000 {
 	reset-names = "serial";
 	dmas = <&apbdma 8>, <&apbdma 8>;
 	dma-names = "rx", "tx";
+	nvidia,adjust-baud-rates = <1000000 4000000 136>; /* 1.36% shift */
 };
-- 
2.7.4

