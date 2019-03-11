Return-Path: <SRS0=FxTY=RO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E53C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:03:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 540962084F
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Mar 2019 18:03:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="rnQArLjm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbfCKSDE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Mar 2019 14:03:04 -0400
Received: from hqemgate14.nvidia.com ([216.228.121.143]:9789 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbfCKSCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Mar 2019 14:02:48 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c86a2c90003>; Mon, 11 Mar 2019 11:02:49 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Mon, 11 Mar 2019 11:02:48 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Mon, 11 Mar 2019 11:02:48 -0700
Received: from HQMAIL101.nvidia.com (172.20.187.10) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 11 Mar
 2019 18:02:47 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Mon, 11 Mar 2019 18:02:47 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.110.103.53]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c86a2c70003>; Mon, 11 Mar 2019 11:02:47 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <riteshh@codeaurora.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <anrao@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>
Subject: [PATCH V2 08/10] mmc: cqhci: add CQHCI_SSC1 register CBC field mask
Date:   Mon, 11 Mar 2019 11:02:37 -0700
Message-ID: <1552327359-8036-8-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1552327359-8036-1-git-send-email-skomatineni@nvidia.com>
References: <1552327359-8036-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1552327369; bh=TwpArjuWnifXXs3ybDOnTi1/AhLiHJwWI8PiFVZYz+g=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=rnQArLjmnutbNGjoX7ccEycvl7ovM3FXxMpVAKoo4Ncn7iOsq1GXzrOQa/ze3O0j4
         kyUnaOH31MCUY8ChFj4mK2sScdW7dnEw5tAVQ37Bha4Jhb1445+v5x7yIH988Qukv+
         prDfe9oUuMwG9JxvbOrhSoc9dxSNwnruSMkTE34UzLePh7f0i9g6ZcVOGtjoZrok+x
         UBN6mTP+tM6UbSCTkMqjZhaQEI7Xns5pBXgcDMTtFSvBQUnkUqoiZU+bf/MBUJTNNy
         6BEz333r1iGd97ZD3eJK2fk2fLJfVY4jDSiFhwbH6AR3n9Jus4Dg2bjbCyNh4Fi5g5
         OdfVFO7SBvh0w==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds define for CBC field mask of the register
CQHCI_SSC1.

Tested-by: Jon Hunter <jonathanh@nvidia.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/mmc/host/cqhci.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/cqhci.h b/drivers/mmc/host/cqhci.h
index 981158da3326..9fb2bb638884 100644
--- a/drivers/mmc/host/cqhci.h
+++ b/drivers/mmc/host/cqhci.h
@@ -88,6 +88,7 @@
 
 /* send status config 1 */
 #define CQHCI_SSC1			0x40
+#define CQHCI_SSC1_CBC_MASK		GENMASK(19, 16)
 
 /* send status config 2 */
 #define CQHCI_SSC2			0x44
-- 
2.7.4

