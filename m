Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB86C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 04:45:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6F294218D0
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 04:45:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="aOCXfQbr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728432AbfCXEpx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 00:45:53 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:17599 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728190AbfCXEpb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 00:45:31 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5c970b680001>; Sat, 23 Mar 2019 21:45:28 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Sat, 23 Mar 2019 21:45:31 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Sat, 23 Mar 2019 21:45:31 -0700
Received: from HQMAIL102.nvidia.com (172.18.146.10) by HQMAIL106.nvidia.com
 (172.18.146.12) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 24 Mar
 2019 04:45:30 +0000
Received: from HQMAIL104.nvidia.com (172.18.146.11) by HQMAIL102.nvidia.com
 (172.18.146.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 24 Mar
 2019 04:45:30 +0000
Received: from hqnvemgw02.nvidia.com (172.16.227.111) by HQMAIL104.nvidia.com
 (172.18.146.11) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Sun, 24 Mar 2019 04:45:30 +0000
Received: from skomatineni-linux.nvidia.com (Not Verified[10.2.168.175]) by hqnvemgw02.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5c970b680001>; Sat, 23 Mar 2019 21:45:30 -0700
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <riteshh@codeaurora.org>
CC:     <skomatineni@nvidia.com>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <anrao@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mmc@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH V4 08/10] mmc: cqhci: add CQHCI_SSC1 register CBC field mask
Date:   Sat, 23 Mar 2019 21:45:25 -0700
Message-ID: <1553402727-23130-8-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1553402727-23130-1-git-send-email-skomatineni@nvidia.com>
References: <1553402727-23130-1-git-send-email-skomatineni@nvidia.com>
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1553402728; bh=1E/aKL5dAwXeUso0BUekNK3/GCv07P7t6OT7SY6WVpQ=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         In-Reply-To:References:X-NVConfidentiality:MIME-Version:
         Content-Type;
        b=aOCXfQbrhYnmDb3gPJxORXX5H5TLKSUJL1Cq58y0uh/LwHj6HbpslhK9rP8aD+KtH
         gh5v93QlLkJac+9GaQV/IiJ8ByjRfe2F5YVRpgq2r6oKrtAYI8VloD6VxHlrYZxlJB
         fOvh4z0uTDRUuFBns7NxuPttC1g1dSHys7UIsybpK2nYRJnRBbtG+2Nq3+KTTQLSjv
         sgM2hw4wiBLD232O8KJ0plHTD1UXE1ycK3dP44qqj028MWfM/roVWjVvKIXdMa2Mfc
         PxbBINQ6KEMTgRfrkOM8/06TeReXp+heQadCkVRdlNPlFPCA+CXaP7iNVi7Zv+fH+x
         NKtp8nEBdD3IQ==
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
index 928ec491eecf..1e8e01d81015 100644
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

