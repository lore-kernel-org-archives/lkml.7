Return-Path: <SRS0=yJb2=SB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E4ABC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6574218D8
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Mar 2019 00:52:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553907172;
	bh=LIK/0C7UQzYmiVpQCPyLhyxZYHqpQcEYbBXUy9LIK1s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hZwbuD7+Uo3pSs7VpDdlanlXQdhn8QkD0reiYWcOpz/pNvA6SAVuJAmIGUpTK/je3
	 /ruTKZyFJyYuwz4hvlJTVtRQTgypTHdmAs8cmM6wqQ9Awfwx5pcZrYxNtyETG01a3V
	 XpiGwpBo3RfO7u/nnrz9en3sulOKbj5IhVT4LJ9o=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731128AbfC3Awu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Mar 2019 20:52:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:59534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731111AbfC3Awr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Mar 2019 20:52:47 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2DB56218FC;
        Sat, 30 Mar 2019 00:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553907167;
        bh=LIK/0C7UQzYmiVpQCPyLhyxZYHqpQcEYbBXUy9LIK1s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ITw/VP8XdEl1YDjkdym5g1sbYoFKzSuzBqyc4qY7q7p1QEW8P/j8DF3XzR/E6KmXw
         B3BAq14+UnvsgLtMdUWYbsh3qpFUdWKoqG4qJkKo/W9C5CdZBI8qoCNnlVNJ2/FDvC
         YdOu2rCFcdJyguTCl34K4ZZP9idDIWHEliizjiOY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Joerg Roedel <jroedel@suse.de>,
        Sasha Levin <sashal@kernel.org>,
        iommu@lists.linux-foundation.org
Subject: [PATCH AUTOSEL 5.0 61/67] iommu/vt-d: Save the right domain ID used by hardware
Date:   Fri, 29 Mar 2019 20:50:41 -0400
Message-Id: <20190330005047.25998-61-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190330005047.25998-1-sashal@kernel.org>
References: <20190330005047.25998-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lu Baolu <baolu.lu@linux.intel.com>

[ Upstream commit 84c11e4df5aa4955acaa441f0cf1cb2e50daf64b ]

The driver sets a default domain id (FLPT_DEFAULT_DID) in the
first level only pasid entry, but saves a different domain id
in @sdev->did. The value saved in @sdev->did will be used to
invalidate the translation caches. Hence, the driver might
result in invalidating the caches with a wrong domain id.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Fixes: 1c4f88b7f1f92 ("iommu/vt-d: Shared virtual address in scalable mode")
Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/intel-iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 63b427cc13d5..331504d8259f 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5330,7 +5330,7 @@ int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct intel_svm_dev *sd
 
 	ctx_lo = context[0].lo;
 
-	sdev->did = domain->iommu_did[iommu->seq_id];
+	sdev->did = FLPT_DEFAULT_DID;
 	sdev->sid = PCI_DEVID(info->bus, info->devfn);
 
 	if (!(ctx_lo & CONTEXT_PASIDE)) {
-- 
2.19.1

