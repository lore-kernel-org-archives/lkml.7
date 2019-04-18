Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE45EC10F0E
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BD5B21872
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 18:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555610775;
	bh=4aMD0gt2hOby66WhzlYPb17NOACY3IThpbQrM2gJQtw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=cY7hxSfKr0pS5f0xze42TGXScmHTAl0otjIypywp8542X5vuVgvzb0RnXL4ranova
	 dMMrbW3aqiZlFmD37/BoyrxjA/lQ3YC7Y1dkZGnRXWHUUzEDaQkU42ZoqPVr55H7EH
	 Vt9Tg1weVuQtvRW/rpfe5coWVcNjn7C7hbmLO9aY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390845AbfDRSGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 14:06:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:35848 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391436AbfDRSGK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 14:06:10 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 004452186A;
        Thu, 18 Apr 2019 18:06:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555610769;
        bh=4aMD0gt2hOby66WhzlYPb17NOACY3IThpbQrM2gJQtw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2hxHAThtdXlOwqNrGY47ecfM69paWB+HuMQiVw2M7+JIzoBPNpwr8ikMs+fn1DcxJ
         nzm1vu1x+gAW/3q9vzNlbvxVBUcdsnERN64aMvtoVDkPAF9U47R0Ym2dSAaZeB4IEf
         ti838cUOV1rKaMMRnPZe9v/OZVFp+bhvpSf2/+BY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jacob Pan <jacob.jun.pan@linux.intel.com>,
        mark gross <mgross@intel.com>, Ashok Raj <ashok.raj@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 34/92] iommu/vt-d: Check capability before disabling protected memory
Date:   Thu, 18 Apr 2019 19:56:52 +0200
Message-Id: <20190418160433.364478818@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190418160430.325165109@linuxfoundation.org>
References: <20190418160430.325165109@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Upstream commit 5bb71fc790a88d063507dc5d445ab8b14e845591 ]

The spec states in 10.4.16 that the Protected Memory Enable
Register should be treated as read-only for implementations
not supporting protected memory regions (PLMR and PHMR fields
reported as Clear in the Capability register).

Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: mark gross <mgross@intel.com>
Suggested-by: Ashok Raj <ashok.raj@intel.com>
Fixes: f8bab73515ca5 ("intel-iommu: PMEN support")
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/intel-iommu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 802ba7b16e09..fe935293fa7b 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1646,6 +1646,9 @@ static void iommu_disable_protect_mem_regions(struct intel_iommu *iommu)
 	u32 pmen;
 	unsigned long flags;
 
+	if (!cap_plmr(iommu->cap) && !cap_phmr(iommu->cap))
+		return;
+
 	raw_spin_lock_irqsave(&iommu->register_lock, flags);
 	pmen = readl(iommu->reg + DMAR_PMEN_REG);
 	pmen &= ~DMA_PMEN_EPM;
-- 
2.19.1



