Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5142EC282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 18:49:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1FD0120663
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 18:49:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="eQ4Yac+o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbfDKStQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 14:49:16 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45813 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726931AbfDKStN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 14:49:13 -0400
Received: by mail-ed1-f66.google.com with SMTP id o26so6113049edv.12
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 11:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lX2MVOfiam4gxtJM5rz0M+xQIQGKu992FM3+lagPerc=;
        b=eQ4Yac+opjGEBMpNwcIhE+BWp72NvMbMpxtmojUTpE9/rOYjMILcbpoRJOSkm78WBk
         Aff06hpFM7720IPoJiqJyT63C+/E8qw6EX81NozIpVIX1tteropdJH6LFlD3Eh/+bnxp
         TqdoMoiwgIxQtWMiOGAc90uv+qOUf34JAI/T0ybJD/E7UmC1cFWzDvL9PTwU99FOa2Cq
         uBtmAEg9IcB2Z+rtiVJG0Mt+tgtzmiJ3TreKGg24TfCmsdd0CwQJXJinK6O+48LvF5v/
         TMCo/yA7WVatb4O5GCP0DxBkXEFa1ZseoyB+vX5EoAJETdaxDHDXc+uPIuWnEbhC9q2H
         SvUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lX2MVOfiam4gxtJM5rz0M+xQIQGKu992FM3+lagPerc=;
        b=JYUs+PAnwKD9cNyiKHmKNm6EH4tABXjPLBY1WQp3mfKikWYVE3I9e3gHPFOliTEd2G
         qnaUfBK/NXQy5KK6FpbSRPSkbrSPTflgTIC7RxgoPyU7DZGwPEywX6/djjf1fig1pEBq
         SePf0Do05EYgEWIAQMKBxV8P5buTvm/K1WyY5n/TGF3cp6xUkLXl3WDsUZOv6T8MkwvI
         RzNB7NbeOrZo6vza2t9iir2dFOgFI2QaMRbv/Oc4OYuNNugKok0dGtRc22GtaD1jHQ08
         3eVaT7g4UfFTUna42gBAC3t2rlCDKAM47VwH+zJpYdiILFsVol2yRJRz5oWcBh93SZcM
         eJaw==
X-Gm-Message-State: APjAAAXGiOE3Jse7bFHZp1pb7EOIRF8u6XOKpq7dpsFpD1Ag4mS7iQIi
        J7MFMyRyzThDvZAcSJc6Hxv/Aw==
X-Google-Smtp-Source: APXvYqw1ZpBKkZJS1pdF6BGZGDt7JAfIqiI9pMC84S3fxuGG7Kvy3jG4mkJy+S81q/cfVwljARoScw==
X-Received: by 2002:aa7:d954:: with SMTP id l20mr32634023eds.156.1555008551931;
        Thu, 11 Apr 2019 11:49:11 -0700 (PDT)
Received: from localhost.localdomain ([80.233.32.123])
        by smtp.gmail.com with ESMTPSA id b10sm1285130edi.28.2019.04.11.11.49.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 11:49:11 -0700 (PDT)
From:   Tom Murphy <tmurphy@arista.com>
To:     iommu@lists.linux-foundation.org
Cc:     dima@arista.com, jamessewart@arista.com, murphyt7@tcd.ie,
        Tom Murphy <tmurphy@arista.com>,
        Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will.deacon@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rob Clark <robdclark@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH 6/9] iommu/amd: Implement map_atomic
Date:   Thu, 11 Apr 2019 19:47:35 +0100
Message-Id: <20190411184741.27540-7-tmurphy@arista.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190411184741.27540-1-tmurphy@arista.com>
References: <20190411184741.27540-1-tmurphy@arista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of using a spin lock I removed the mutex lock from both the
amd_iommu_map and amd_iommu_unmap path as well. iommu_map doesn’t lock
while mapping and so if iommu_map is called by two different threads on
the same iova region it results in a race condition even with the locks.
So the locking in amd_iommu_map and amd_iommu_unmap doesn't add any real
protection. The solution to this is for whatever manages the allocated
iova’s externally to make sure iommu_map isn’t called twice on the same
region at the same time.

Signed-off-by: Tom Murphy <tmurphy@arista.com>
---
 drivers/iommu/amd_iommu.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 2d4ee10626b4..b45e0e033adc 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -3089,12 +3089,12 @@ static int amd_iommu_attach_device(struct iommu_domain *dom,
 	return ret;
 }
 
-static int amd_iommu_map(struct iommu_domain *dom, unsigned long iova,
-			 phys_addr_t paddr, size_t page_size, int iommu_prot)
+static int __amd_iommu_map(struct iommu_domain *dom, unsigned long iova,
+			 phys_addr_t paddr, size_t page_size, int iommu_prot,
+			 gfp_t gfp)
 {
 	struct protection_domain *domain = to_pdomain(dom);
 	int prot = 0;
-	int ret;
 
 	if (domain->mode == PAGE_MODE_NONE)
 		return -EINVAL;
@@ -3104,11 +3104,21 @@ static int amd_iommu_map(struct iommu_domain *dom, unsigned long iova,
 	if (iommu_prot & IOMMU_WRITE)
 		prot |= IOMMU_PROT_IW;
 
-	mutex_lock(&domain->api_lock);
-	ret = iommu_map_page(domain, iova, paddr, page_size, prot, GFP_KERNEL);
-	mutex_unlock(&domain->api_lock);
+	return iommu_map_page(domain, iova, paddr, page_size, prot, gfp);
+}
 
-	return ret;
+static int amd_iommu_map(struct iommu_domain *dom, unsigned long iova,
+			 phys_addr_t paddr, size_t page_size, int iommu_prot)
+{
+	return __amd_iommu_map(dom, iova, paddr, page_size, iommu_prot,
+			GFP_KERNEL);
+}
+
+static int amd_iommu_map_atomic(struct iommu_domain *dom, unsigned long iova,
+			 phys_addr_t paddr, size_t page_size, int iommu_prot)
+{
+	return __amd_iommu_map(dom, iova, paddr, page_size, iommu_prot,
+			GFP_ATOMIC);
 }
 
 static size_t amd_iommu_unmap(struct iommu_domain *dom, unsigned long iova,
@@ -3262,6 +3272,7 @@ const struct iommu_ops amd_iommu_ops = {
 	.attach_dev = amd_iommu_attach_device,
 	.detach_dev = amd_iommu_detach_device,
 	.map = amd_iommu_map,
+	.map_atomic = amd_iommu_map_atomic,
 	.unmap = amd_iommu_unmap,
 	.iova_to_phys = amd_iommu_iova_to_phys,
 	.add_device = amd_iommu_add_device,
-- 
2.17.1

