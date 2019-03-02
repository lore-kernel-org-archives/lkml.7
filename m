Return-Path: <SRS0=OfNL=RF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DCCBC43381
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 05:21:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C7102085A
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Mar 2019 05:21:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="cnAZ9UVa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728290AbfCBFVO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Mar 2019 00:21:14 -0500
Received: from hqemgate14.nvidia.com ([216.228.121.143]:9841 "EHLO
        hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728120AbfCBFU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Mar 2019 00:20:56 -0500
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate14.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c7a12c00000>; Fri, 01 Mar 2019 21:21:04 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Fri, 01 Mar 2019 21:20:55 -0800
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Fri, 01 Mar 2019 21:20:55 -0800
Received: from HQMAIL106.nvidia.com (172.18.146.12) by HQMAIL103.nvidia.com
 (172.20.187.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 2 Mar
 2019 05:20:55 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1395.4 via Frontend
 Transport; Sat, 2 Mar 2019 05:20:55 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.172.134]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c7a12b40002>; Fri, 01 Mar 2019 21:20:54 -0800
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <riteshh@codeaurora.org>
CC:     <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <anrao@nvidia.com>, <linux-tegra@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-mmc@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Sowjanya Komatineni <skomatineni@nvidia.com>
Subject: [PATCH V1 09/11] mmc: cqhci: add CQHCI_SSC1 register CBC field mask
Date:   Fri, 1 Mar 2019 21:20:23 -0800
Message-ID: <1551504025-3541-9-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551504025-3541-1-git-send-email-skomatineni@nvidia.com>
References: <1551504025-3541-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1551504064; bh=wkx3HuTJxIWb28BfsCb9mlzWzWFwJ4pnX4Z3RHL7NaQ=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=cnAZ9UVaGYuv0VtH4efT6tOehUYcwsVVjfb87WvWQC2whKsdqoswASKC0jqGeWCXU
         vCznwDwAp3D0KfwDocygT+FZdRECpGC3OTyontolHFV1ZqlgpDQc4snKjRjT+T27j2
         kvtwZqFuinZn1pvCc6TaHWohTQpKqXRsr5rT03HBRIZePApImfpM8Mwb/8gvc95bvX
         VE4Rjwu/hifyw3T/aUn4giBQN4D1TfXyGX8G4tX+FYVP2zUKR7pHSU9fvb23LmainE
         pHWO6b31A0fzHAVXiXi79S8ZUKM/J+S4/1VZbYEy9n88oLczbdwY5moanzH7j/gnwL
         DU/rWcQPlVBfA==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds define for CBC field mask of the register
CQHCI_SSC1.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 drivers/mmc/host/cqhci.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mmc/host/cqhci.h b/drivers/mmc/host/cqhci.h
index f96d8565cc07..f1dc48c7436f 100644
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

