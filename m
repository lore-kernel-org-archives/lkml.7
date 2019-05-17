Return-Path: <SRS0=M1fl=TR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A1B1C04E84
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 01:00:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF946206BF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 May 2019 01:00:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="yAzMLwXz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbfEQBAZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 May 2019 21:00:25 -0400
Received: from mx.aristanetworks.com ([162.210.129.12]:42693 "EHLO
        prod-mx.aristanetworks.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726901AbfEQBAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 May 2019 21:00:24 -0400
Received: from prod-mx.aristanetworks.com (localhost [127.0.0.1])
        by prod-mx.aristanetworks.com (Postfix) with ESMTP id DD66B41CAC0;
        Thu, 16 May 2019 17:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
        s=Arista-A; t=1558054427;
        bh=0YAEwRV8pxaKDZriNp5u14v56Dsy6P+WWcBl+ItO2zQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=yAzMLwXztwgoG54qdkpjOlajk7uFBwFv2KEytXFrkmlS7SD5EHt+FP7QcUEinc6l3
         vqVjwE9+4RzVVITPiEK1hwsg2tL1jEvRn3LHepmF8S+TwsSfI5pi8EGV22Yx2mUZOU
         5bZE+JhNROjg68WSlWv1RLBQ3WNzRBnb9jHoW63bAnOm3OfcduzAlsjdMBL7+PaayW
         g1LemAio75Ug6p9bgCoJM4PO7gItqfusdpnqDrsgKY4IfLlDdlOs2vtgo35OmM7pwe
         qqu0k9tcDvF6CMX0gybCwgoa9rO9UDRjLFpPVnLequ77jynRoZ5r6dLpt70g/KhtwZ
         BGVRhTxmaPbug==
Received: from chmeee (unknown [10.95.92.211])
        by prod-mx.aristanetworks.com (Postfix) with ESMTP id D141D41CABA;
        Thu, 16 May 2019 17:53:47 -0700 (PDT)
Received: from kevmitch by chmeee with local (Exim 4.92)
        (envelope-from <kevmitch@chmeee>)
        id 1hRR7o-0001le-HJ; Thu, 16 May 2019 17:53:28 -0700
From:   Kevin Mitchell <kevmitch@arista.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Kevin Mitchell <kevmitch@arista.com>
Subject: [PATCH 1/3] iommu/amd: make iommu_disable safer
Date:   Thu, 16 May 2019 17:52:40 -0700
Message-Id: <20190517005242.20257-2-kevmitch@arista.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190517005242.20257-1-kevmitch@arista.com>
References: <20190517005242.20257-1-kevmitch@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make it safe to call iommu_disable during early init error conditions
before mmio_base is set, but after the struct amd_iommu has been added
to the amd_iommu_list. For example, this happens if firmware fails to
fill in mmio_phys in the ACPI table leading to a NULL pointer
dereference in iommu_feature_disable.

Signed-off-by: Kevin Mitchell <kevmitch@arista.com>
---
 drivers/iommu/amd_iommu_init.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/amd_iommu_init.c b/drivers/iommu/amd_iommu_init.c
index f773792d77fd..3798d7303c99 100644
--- a/drivers/iommu/amd_iommu_init.c
+++ b/drivers/iommu/amd_iommu_init.c
@@ -424,6 +424,9 @@ static void iommu_enable(struct amd_iommu *iommu)
 
 static void iommu_disable(struct amd_iommu *iommu)
 {
+	if (!iommu->mmio_base)
+		return;
+
 	/* Disable command buffer */
 	iommu_feature_disable(iommu, CONTROL_CMDBUF_EN);
 
-- 
2.20.1

