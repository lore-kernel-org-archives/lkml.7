Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72ABEC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:11:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3136720675
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:11:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555611115;
	bh=6XNOU3Y9X5FNw5JRFbkYBWvR/i0mEH+JkI4WxxHBV74=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Crte5EOIujLTo64dkZpC0HiZp90t2RgJkjaeIV+a6MFmzrC2jl9x7jnpeNeznf4XA
	 Zbz0T8jlKQT44FZDU4xTZdqit8DBYEQdwdwIRabB0wv8uwWDrEv2EG/KAVrPFWX/zc
	 4pdjLTcECSzvlW1vHDNxRGq6I5peFnCMOa+XVlUU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403953AbfDRSLx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:11:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:44150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391963AbfDRSLv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:11:51 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF83220675;
        Thu, 18 Apr 2019 18:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555611110;
        bh=6XNOU3Y9X5FNw5JRFbkYBWvR/i0mEH+JkI4WxxHBV74=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E5Svwfw8MI9QItrnMengMouNIS2AEI1YZb5g9VAzNiez4Wut5Ijp1Vdk9Ao+ssVv4
         4cO7Kt2juwxUJddRSbMZsidSS0NTE8nbbspCil2xJSPDkPW9qoXjx1HvhchsLkQj38
         Q2oNOgN5iY1zaPbYQqwR+DlPsJ7BjB0ZBnlGEha0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ashok Raj <ashok.raj@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.0 61/93] iommu/vt-d: Save the right domain ID used by hardware
Date:   Thu, 18 Apr 2019 19:57:39 +0200
Message-Id: <20190418160443.647899370@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160436.781762249@linuxfoundation.org>
References: <20190418160436.781762249@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
index 68a21c49c562..53b1fbadc496 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5331,7 +5331,7 @@ int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct intel_svm_dev *sd
 
 	ctx_lo = context[0].lo;
 
-	sdev->did = domain->iommu_did[iommu->seq_id];
+	sdev->did = FLPT_DEFAULT_DID;
 	sdev->sid = PCI_DEVID(info->bus, info->devfn);
 
 	if (!(ctx_lo & CONTEXT_PASIDE)) {
-- 
2.19.1



