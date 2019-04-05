Return-Path: <SRS0=EIds=SH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B7DFC4360F
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 00:15:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC8E42184E
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Apr 2019 00:15:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="FKf4N9qE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731153AbfDEAPT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Apr 2019 20:15:19 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:7981 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730720AbfDEAOg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Apr 2019 20:14:36 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5ca69ddf0000>; Thu, 04 Apr 2019 17:14:23 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 04 Apr 2019 17:14:35 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 04 Apr 2019 17:14:35 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 5 Apr
 2019 00:14:34 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Fri, 5 Apr 2019 00:14:34 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.103.48]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5ca69dea0003>; Thu, 04 Apr 2019 17:14:34 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <talho@nvidia.com>, <skomatineni@nvidia.com>, <broonie@kernel.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <kyarlagadda@nvidia.com>
CC:     <ldewangan@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH V2 16/20] spi-summary: document set_cs_timing
Date:   Thu, 4 Apr 2019 17:14:15 -0700
Message-ID: <1554423259-26056-16-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1554423259-26056-1-git-send-email-skomatineni@nvidia.com>
References: <1554423259-26056-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1554423264; bh=SeheiGgbZQ3sAEdPuy9I5oZgWuzzAgW+yk04I+5zoG0=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=FKf4N9qEYoNiSPcd3JFWHjjkCnAwWAeLb+VJxx+mlRUytHAYSj2mV3ZNjuPWuy3H1
         JyPzgACa47nCxqOi6+7caK4OzjINJxGBOl4LXM1N0opox6j4wSSslHq24kzAj5GRZ5
         nwDEKEdrswutPUhwzPbd8CsQvqnDsxpbofMfWjJbvl5usi5aDxZW01lsirvTx39rYP
         GE4eNVv1w6AA89nxdgD9pCUqpZKMnfbUP6ldPe1WHuigwb0yxV99/2VPGUYkcTcl3N
         yJ8abxcCqn1wy9PwK1FVqhstLPe5FglIdfBe3zFr1BzJCSZm4BrZkpJk/NGR3e4m4r
         lSGXrKR9q83WA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch documents set_cs_timing SPI master method.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 Documentation/spi/spi-summary | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/spi/spi-summary b/Documentation/spi/spi-summary
index 1721c1b570c3..1a63194b74d7 100644
--- a/Documentation/spi/spi-summary
+++ b/Documentation/spi/spi-summary
@@ -572,6 +572,12 @@ SPI MASTER METHODS
 	0: transfer is finished
 	1: transfer is still in progress
 
+    master->set_cs_timing(struct spi_device *spi, u8 setup_clk_cycles,
+			      u8 hold_clk_cycles, u8 inactive_clk_cycles)
+	This method allows SPI client drivers to request SPI master controller
+	for configuring device specific CS setup, hold and inactive timing
+	requirements.
+
     DEPRECATED METHODS
 
     master->transfer(struct spi_device *spi, struct spi_message *message)
-- 
2.7.4

