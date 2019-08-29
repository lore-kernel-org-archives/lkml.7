Return-Path: <SRS0=brkd=WZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1F02C3A59F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 11:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A35262166E
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Aug 2019 11:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o9IDb9wx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbfH2LSJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Aug 2019 07:18:09 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40492 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfH2LSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 07:18:03 -0400
Received: by mail-ed1-f67.google.com with SMTP id h8so3640636edv.7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2019 04:18:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zCsgPCFvt5f0JhV5AAX71J7KrOE6T7Mwp2HnksazGlw=;
        b=o9IDb9wxTMVYl4Pw8eOl4MN8lrxcZAgdJUKaGojaGYK4aXQr34VjDZVfYu/QzbxvqH
         jcCWwyi0BumBzhg17grPUPMX9d7OIgI5av0bWjFUbC977dHLo8th+91iEI5NqBvmCODo
         2I3V9bM1lkU74SfOvgyAH+sAwFQaQIwE71r0I8lfv/K+OUYHnZS9/sjDBKzPpsDxCoCn
         WgY397r5bRinjlufn59iqnqRz6E+fEu4qAdIk6TUiefpKTyqVSbCUYkNOe3WtgxV1IBt
         qYjcwXUI9MXenjs8NrD+DbvJhsyZkQBDBJupkrQjvHkmXTxgcdrcmmtuR0K+kKiHNVj1
         gkmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zCsgPCFvt5f0JhV5AAX71J7KrOE6T7Mwp2HnksazGlw=;
        b=T+k9GB/6FlQ+IL7rM5kCcFgDRg0FGjQKrE1E2YXLUp3r0r8wKs18G6lO7iu0RViqYx
         CojOaVFWkV1RTTbTOw/ka7bqhhWRGpx554pkpMhyV8ElQuV+hmeACXfJoAD866RQd8v1
         HTW1gTk45YaftnSJp3uGvUPC6QG/dBwJjZtGvk+ASqWk3S3S3iM1ETZeN0mzCHwZmGnn
         WWpOR04fxAc9DURTE5DPPIMvnE96M8GcpncKguSrmZ99OJlc9iwRwsetqRE27QEZ4llH
         lwJKOncF/ppVe/hFAgXUp0AjKiDIJaH712jCFuTl0JiceaARkxO+xU+P2Vr5JrXA0/6E
         wKEA==
X-Gm-Message-State: APjAAAVZJfLe8krxj+cnTr37NTOnf6fw3oBOvxax+xo0zAOGVlHt12Ul
        /0SySk9epiT0oAoff1CAGyY=
X-Google-Smtp-Source: APXvYqwM8CVbq0FXN38b8oxKuaYKC/x8VDD3uqRU7eQrkpe6K2cwtpE+e448Jg8Ofr+6OyhLfBDXpw==
X-Received: by 2002:a17:906:6bc4:: with SMTP id t4mr7875881ejs.256.1567077481688;
        Thu, 29 Aug 2019 04:18:01 -0700 (PDT)
Received: from localhost (pD9E51890.dip0.t-ipconnect.de. [217.229.24.144])
        by smtp.gmail.com with ESMTPSA id n93sm215670edc.5.2019.08.29.04.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 04:18:00 -0700 (PDT)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        iommu@lists.linux-foundation.org,
        linux-arm-kernel@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] iommu: intel: Use iommu_put_resv_regions_simple()
Date:   Thu, 29 Aug 2019 13:17:51 +0200
Message-Id: <20190829111752.17513-5-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190829111752.17513-1-thierry.reding@gmail.com>
References: <20190829111752.17513-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thierry Reding <treding@nvidia.com>

Use the new standard function instead of open-coding it.

Cc: David Woodhouse <dwmw2@infradead.org>
Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/iommu/intel-iommu.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 4658cda6f3d2..2fe5da41c786 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5386,15 +5386,6 @@ static void intel_iommu_get_resv_regions(struct device *device,
 	list_add_tail(&reg->list, head);
 }
 
-static void intel_iommu_put_resv_regions(struct device *dev,
-					 struct list_head *head)
-{
-	struct iommu_resv_region *entry, *next;
-
-	list_for_each_entry_safe(entry, next, head, list)
-		kfree(entry);
-}
-
 int intel_iommu_enable_pasid(struct intel_iommu *iommu, struct device *dev)
 {
 	struct device_domain_info *info;
@@ -5629,7 +5620,7 @@ const struct iommu_ops intel_iommu_ops = {
 	.add_device		= intel_iommu_add_device,
 	.remove_device		= intel_iommu_remove_device,
 	.get_resv_regions	= intel_iommu_get_resv_regions,
-	.put_resv_regions	= intel_iommu_put_resv_regions,
+	.put_resv_regions	= iommu_put_resv_regions_simple,
 	.apply_resv_region	= intel_iommu_apply_resv_region,
 	.device_group		= pci_device_group,
 	.dev_has_feat		= intel_iommu_dev_has_feat,
-- 
2.22.0

