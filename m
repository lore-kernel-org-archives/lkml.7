Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91593C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 22:50:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A3EE2087E
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 22:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d8d9SI6U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732567AbfCZWuN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 18:50:13 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37294 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732358AbfCZWuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 18:50:11 -0400
Received: by mail-pf1-f195.google.com with SMTP id 8so8749123pfr.4
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 15:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Pbdwi/63Agi4s6Tt6RAM0FtL+bzJWgpn5Dncpfelpvo=;
        b=d8d9SI6Uzq+6pA3O9Jx8nnoiwqY60LZWCoNccnt0K7MvApqO2DcuOeGIS12uMabsmD
         AVNmdPvCM7YIMEcl2cUEIm2v9GWUIyfQq9VG+d5LIXDM4dW0NLdPhncvUSknr3U/9kFv
         NDLoqxOvdImnulMbZg6hbB3W4gLKeKa1F8iu6zS2HhLmr/NnNhgeNlY7fledAXgxev9y
         TUKEYIvrbQeYpqZ0jx6tqnDs+MD2mKsVgClr2Ru08YK55y7RZffVEdSLFwTeeI0kGzpF
         Dkf3kQo7NldEVDFowISnKphyjF7fLk1CnVMtcNyC6K65TDNcCjNEW7qeXDngWOVlHObv
         /sJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Pbdwi/63Agi4s6Tt6RAM0FtL+bzJWgpn5Dncpfelpvo=;
        b=kpNZyOAluZQr59beGVVUKQf72cyt/CF6yqwwGeSvlGkjEXIpDLcb3vV0ETjr2Z+6BX
         JOdYREcb+cgKDQAi1L3WHySryMwqTSfT2B7zV8OSCoREwGDVuzxn3Q61H88XVKAE9mPn
         tBFt3cMjlp7/xRQGWgZaGnwVzc66IPItxCrsaY5ti6igvOZbiZ2WEV19TbcEGY7nk7Yu
         F0h/EvLXiBD1dHJbobRcH8zgwwcZ+xPJXkZpSP2LDsBZVTCWp9Q1sz4nlXOfvwYk4DFG
         BqvVT/l4k9SDHIi3LShaEVHT1biC/C6CmI9YaEKW5edtoi+iAhBimLdOtzT+Ti+IKlQc
         w4kQ==
X-Gm-Message-State: APjAAAVEHMZPPac2IMMsdxN5cnllPgnt8VubMjkVAORH/L2Sx9t+08PN
        rh9pRujKyBFR/e2/DFkK9wQ=
X-Google-Smtp-Source: APXvYqxjrn23ApvCQzafM7tMebJ15yXX6D1flXgkxPRKN9E+zV3h/+BemsDAd4R1MIaYDAjaf6LTwg==
X-Received: by 2002:a63:4620:: with SMTP id t32mr29273831pga.363.1553640610294;
        Tue, 26 Mar 2019 15:50:10 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id 8sm56937368pfs.50.2019.03.26.15.50.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 15:50:09 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     hch@lst.de, robin.murphy@arm.com
Cc:     vdumpa@nvidia.com, linux@armlinux.org.uk, catalin.marinas@arm.com,
        will.deacon@arm.com, joro@8bytes.org, m.szyprowski@samsung.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, tony@atomide.com
Subject: [PATCH RFC/RFT 3/5] iommu: amd_iommu: Add fallback normal page allocations
Date:   Tue, 26 Mar 2019 15:49:57 -0700
Message-Id: <20190326224959.9656-4-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190326224959.9656-1-nicoleotsuka@gmail.com>
References: <20190326224959.9656-1-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CMA allocation will skip allocations of single pages to save CMA
resource. This requires its callers to rebound those page allocations
from normal area. So this patch adds fallback routines.

Note: amd_iommu driver uses dma_alloc_from_contiguous() as a fallback
      allocation and uses alloc_pages() as its first round allocation.
      This's in reverse order than other callers. So the alloc_pages()
      added by this change becomes a second fallback, though it likely
      won't succeed since the alloc_pages() has failed once.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 drivers/iommu/amd_iommu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 21cb088d6687..2aa4818f5249 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -2701,6 +2701,9 @@ static void *alloc_coherent(struct device *dev, size_t size,
 
 		page = dma_alloc_from_contiguous(dev, size >> PAGE_SHIFT,
 					get_order(size), flag & __GFP_NOWARN);
+		if (!page)
+			page = alloc_pages(flag | __GFP_NOWARN,
+					   get_order(size));
 		if (!page)
 			return NULL;
 	}
-- 
2.17.1

