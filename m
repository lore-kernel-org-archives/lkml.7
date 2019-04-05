Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28720C4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 00:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1181217D4
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 00:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="QdHTP3ap"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731215AbfDEAPt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 20:15:49 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:11313 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730586AbfDEAOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 20:14:30 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ca69de30002>; Thu, 04 Apr 2019 17:14:27 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 04 Apr 2019 17:14:30 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 04 Apr 2019 17:14:30 -0700
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 5 Apr
 2019 00:14:29 +0000
Received: from HQMAIL108.nvidia.com (172.18.146.13) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 5 Apr
 2019 00:14:29 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL108.nvidia.com
 (172.18.146.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 5 Apr 2019 00:14:29 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.103.48]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ca69de40005>; Thu, 04 Apr 2019 17:14:28 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <talho@nvidia.com>, <skomatineni@nvidia.com>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <kyarlagadda@nvidia.com>
CC:     <ldewangan@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH V2 10/20] Documentation: devicetree: spi: add spi-lsbyte-first propery
Date:   Thu, 4 Apr 2019 17:14:09 -0700
Message-ID: <1554423259-26056-10-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554423259-26056-1-git-send-email-skomatineni@nvidia.com>
References: <1554423259-26056-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1554423268; bh=5uHypwSY4U3j8OtijhVLMmN6YMehZClSYoL4TmfKe/U=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=QdHTP3apOQyTw/q05IM3ohUlig+0MsNJOYyk0JcyqMPG4VvkQLZIjnLMyfqUuinwM
         o3OGzHVaIHml2drK8CPrPKyCqqd8Wj8sDjSc62p0+f2E+qVvb354/i+CRAxPgii7CX
         p+tm/MqVLEJJN8TtzVDCs91OmuunL0lZVKgllBIRrB3LFBZ+7aoN+rWkg9KqyeB92i
         wVqXfG93jtN6k5QkCJCqG0kIBTe2GTsbFcMLOYrMAvgKuEe/6WqweZ8yG1RCFxJCHO
         7sM+X5c1Aqrqed8+3LGhk6f4AD6kNkX1z+wc0omHQTfW7Orto3Aklg8V8pL6qvmURa
         aF9tlGxV2kk/A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

spi-lsbyte-first optional property allows SPI slaves to choose byte
order of little endian for transfers.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 Documentation/devicetree/bindings/spi/spi-bus.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/spi/spi-bus.txt b/Documentation/devicetree/bindings/spi/spi-bus.txt
index 1f6e86f787ef..b455c24a80df 100644
--- a/Documentation/devicetree/bindings/spi/spi-bus.txt
+++ b/Documentation/devicetree/bindings/spi/spi-bus.txt
@@ -71,6 +71,7 @@ All slave nodes can contain the following optional properties:
 		    active high.
 - spi-3wire       - Empty property indicating device requires 3-wire mode.
 - spi-lsb-first   - Empty property indicating device requires LSB first mode.
+- spi-lsbyte-first - Empty property indicating device requires LSByte first mode.
 - spi-tx-bus-width - The bus width (number of data wires) that is used for MOSI.
 		    Defaults to 1 if not present.
 - spi-rx-bus-width - The bus width (number of data wires) that is used for MISO.
-- 
2.7.4

