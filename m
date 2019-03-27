Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FD9AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:58:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 683C62070D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 05:58:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387508AbfC0F62 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 01:58:28 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:6258 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733221AbfC0F5f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 01:57:35 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c9b10cd0000>; Tue, 26 Mar 2019 22:57:33 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 26 Mar 2019 22:57:35 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 26 Mar 2019 22:57:35 -0700
Received: from HQMAIL112.nvidia.com (172.18.146.18) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 27 Mar
 2019 05:57:34 +0000
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL112.nvidia.com
 (172.18.146.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 27 Mar
 2019 05:57:34 +0000
Received: from hqnvemgw01.nvidia.com (172.20.150.20) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Wed, 27 Mar 2019 05:57:34 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.161.83]) by hqnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c9b10cc0000>; Tue, 26 Mar 2019 22:57:33 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <talho@nvidia.com>, <skomatineni@nvidia.com>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <kyarlagadda@nvidia.com>
CC:     <ldewangan@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH V1 19/26] DT bindings: spi: add spi client device properties
Date:   Tue, 26 Mar 2019 22:56:40 -0700
Message-ID: <1553666207-11414-19-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553666207-11414-1-git-send-email-skomatineni@nvidia.com>
References: <1553666207-11414-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds below cs timing properties to allow SPI master configuring
setup, hold and time interval between two SPI transactions to meet specific
SPI client device requirements.
 CS setup time
 CS hold time
 CS inactive delay
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
	t=1553666253; bh=TbJVgRAIkjok3TkKNkfcvYc4WGyZhOpiH6sUZvadGrQ=;
	h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:X-NVConfidentiality:MIME-Version:
	 Content-Type;
	b=Tud9guY5XCzkjKA2k2n0+xO/vTfMTNhH1e0viAyYmlgoG/j+uSBAAmOeZucVUlmEa
	 rwqxlSm+rkYMUfgSWqmJXqEjgRIAqMhA32FOJmhgpblGwYUR22hnbdhbk4TcqMNsIO
	 mXBgiIq3sOB7dKCDIv4+YSUreRrnXrvrDN0NE9zN7D+AQWYLF5dI4v+UDalNYJU2hz
	 TusNrURxuHgtpModvYVQRPgPDv+nJ2QE6L7yZH/M6XP7jYprtQHWnHAiMwqqSXBcrf
	 8vlhV96anQSaGkioOUTp8ThlHSwBKLRFHRofVlrhT53K0xvTCvVst4aHvA1aq3QPw0
	 sVr25yohIPq7w==

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.txt | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.txt b/Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.txt
index 9ba7c5a273b4..6167c5234b64 100644
--- a/Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.txt
+++ b/Documentation/devicetree/bindings/spi/nvidia,tegra114-spi.txt
@@ -23,6 +23,13 @@ Required properties:
 Recommended properties:
 - spi-max-frequency: Definition as per
                      Documentation/devicetree/bindings/spi/spi-bus.txt
+
+spi-client device controller properties:
+- nvidia,cs-setup-clk-count: CS setup timing parameter.
+- nvidia,cs-hold-clk-count: CS hold timing parameter.
+- nvidia,cs-inactive-cycles: CS inactive delay in terms of clock between
+  transfers.
+
 Example:
 
 spi@7000d600 {
-- 
2.7.4

