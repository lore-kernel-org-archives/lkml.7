Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B76A4C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 18:49:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8425E20663
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 18:49:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Kz0209+s"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbfDKStL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 14:49:11 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44030 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbfDKStI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 14:49:08 -0400
Received: by mail-ed1-f65.google.com with SMTP id w3so6123507edu.10
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 11:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0ptM0TW5MEf0wZjhcNVg+kVepdW4r8Z6tyROfJJShQo=;
        b=Kz0209+sKNZfmB0yWwNPjjrMA+GYb4rsz3YQ+7qzCBKV0K8VKU+rELf+Zl1rDwGfGG
         UDqhVf2LzXA6K1Mp+V7RE4dqFrJsHX5w+JbTNVOgDNMqnsvq1/Svzxa1O30Nwx4bNza7
         xhOejAKAbe35ytPwR0TZVkNIacGaIechwtfh4zN2DCFIKQ4M9BguB3dgKppQ9rukI4fk
         jwu4Kh6E1Kp4KE4cvVyzWTm9dLB+7BauhZN2nsIMnKgsjVX0U/GpqN2Ak+4MJtwQ7Rct
         vag21Of0Bv8JJEz+PXrI7LQkFSMnYl4wWcIJZDQCt3rzHh/G7O3Wjvfv8J/dr1KSZ6iE
         ULLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0ptM0TW5MEf0wZjhcNVg+kVepdW4r8Z6tyROfJJShQo=;
        b=QibtQlw7C4EfV36ZQooN+ANxCJVXXCH31fPF5dOpBQvZfJOmYtPtYuSY3FhkCVsxPb
         VUKhzvx1mecA/eCfewncxET3rAYWlZIcduiYmSDkttCUSjJw4FbB44tMKmczIaHPX5dX
         eiO0u5EMm/6IiGjL1QxOCUVGh3J1dSqanWP1ltoOUi5iGS9umk8K53uI8ObWy33cWzAQ
         7ay33C1/FSyAI1k83XgxodAMjDA9L9j/jrQcQR+6M0x84VzAIEn0grI+1wXynAQzbCYd
         J68PBxzcVKSo/X7p24Ln6dj3zLvH9O0ci4iRHZkbbGXsugfIeRdH3OYVghLxy8n425lF
         Aidg==
X-Gm-Message-State: APjAAAXipFlZCV2wCLY/u5WSCZ+aKuVEk5iiBDlqXGAxdHkA3+pEbaHW
        ISFyFoEXQH6mTcV1kn9rmBRONw==
X-Google-Smtp-Source: APXvYqxPgBo+MMzWroNLnpmi2H77XJDBCOGidMozjjYD68K8alQvz4uZiMPtc7ZU8Kl0PrPPn+MeYg==
X-Received: by 2002:a05:6402:558:: with SMTP id i24mr26522920edx.51.1555008547040;
        Thu, 11 Apr 2019 11:49:07 -0700 (PDT)
Received: from localhost.localdomain ([80.233.32.123])
        by smtp.gmail.com with ESMTPSA id b10sm1285130edi.28.2019.04.11.11.49.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 11:49:06 -0700 (PDT)
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
        Rob Clark <robdclark@gmail.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Subject: [PATCH 5/9] iommu/amd: Implement .flush_np_cache
Date:   Thu, 11 Apr 2019 19:47:34 +0100
Message-Id: <20190411184741.27540-6-tmurphy@arista.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190411184741.27540-1-tmurphy@arista.com>
References: <20190411184741.27540-1-tmurphy@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement flush_np_cache for the AMD iommu driver. This allows the amd
iommu non present cache to be flushed if amd_iommu_np_cache is set.

Signed-off-by: Tom Murphy <tmurphy@arista.com>
---
 drivers/iommu/amd_iommu.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index b319e51c379b..2d4ee10626b4 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1319,6 +1319,18 @@ static void domain_flush_devices(struct protection_domain *domain)
 		device_flush_dte(dev_data);
 }
 
+static void amd_iommu_flush_np_cache(struct iommu_domain *domain,
+		unsigned long iova, size_t size)
+{
+	struct protection_domain *dom = to_pdomain(domain);
+
+	if (unlikely(amd_iommu_np_cache)) {
+		domain_flush_pages(dom, iova, size);
+		domain_flush_complete(dom);
+	}
+}
+
+
 /****************************************************************************
  *
  * The functions below are used the create the page table mappings for
@@ -3263,6 +3275,7 @@ const struct iommu_ops amd_iommu_ops = {
 	.flush_iotlb_all = amd_iommu_flush_iotlb_all,
 	.iotlb_range_add = amd_iommu_iotlb_range_add,
 	.iotlb_sync = amd_iommu_flush_iotlb_all,
+	.flush_np_cache = amd_iommu_flush_np_cache,
 };
 
 /*****************************************************************************
-- 
2.17.1

