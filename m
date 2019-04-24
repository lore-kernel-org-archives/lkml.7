Return-Path: <SRS0=L2S5=S2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 057BEC10F11
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C6004206BA
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Apr 2019 17:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1556126055;
	bh=nI1ajxEB7wkS77/8ZM+TP+j9M/ZTzaUDKO2yvcje0JY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=eWVmzNa7wgCvkJn25cHMReYdwRtfHnVj5rDayKG1+FMS1cjJB3q9Bb5AYVNSiqbg9
	 ZKmwCp+ymbiB8Kz3fe9PFY+Sn+2QREHvWCsBpE1IGLCFICbk3kC/8zzwFa1Lw5KHaU
	 eB8+HZu6UnF8ftPQRpfX4pRHEercwVWYcQzgHHmc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388038AbfDXROO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 13:14:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:38360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388016AbfDXROL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 13:14:11 -0400
Received: from localhost (62-193-50-229.as16211.net [62.193.50.229])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7DDC218B0;
        Wed, 24 Apr 2019 17:14:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556126050;
        bh=nI1ajxEB7wkS77/8ZM+TP+j9M/ZTzaUDKO2yvcje0JY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cX2PevNmb1thk7m4izrESNs6YqLoaJXXDTUglgzklMfirkmlWyPrLKnhP0BmPUxwC
         HpFT+MogycY8X0r1j9yLfiMzA5zAeP5MelDMWH8g8XO3aVbtSz9DHLhXS7edJXFD1p
         CsL1who/3vicbEFU8/dqhoQzNOMSVgzaEWpWOdjo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jacob Pan <jacob.jun.pan@linux.intel.com>,
        mark gross <mgross@intel.com>, Ashok Raj <ashok.raj@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <jroedel@suse.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 074/104] iommu/vt-d: Check capability before disabling protected memory
Date:   Wed, 24 Apr 2019 19:09:31 +0200
Message-Id: <20190424170906.218147775@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190424170839.996641496@linuxfoundation.org>
References: <20190424170839.996641496@linuxfoundation.org>
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
index 2068cb59f7ed..b1966269f26a 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1402,6 +1402,9 @@ static void iommu_disable_protect_mem_regions(struct intel_iommu *iommu)
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



