Return-Path: <SRS0=BPXs=SN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41969C10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 18:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E7EC20663
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Apr 2019 18:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="KrxWIEik"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727042AbfDKStc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Apr 2019 14:49:32 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:41968 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727020AbfDKSta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Apr 2019 14:49:30 -0400
Received: by mail-ed1-f67.google.com with SMTP id g6so2176586edc.8
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2019 11:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DMnZhta68iAX33CpRchMA+yMZHDHOGcPtQBVqQabrNw=;
        b=KrxWIEikxDdZvLu8UnFVjW0EcG/PU1SormZHDInUdtOAg+J8UeRfz2zXDqrYBYevOn
         JwyWhZgYwU6QtoPuE0mXZ1Oe5eYGnMUIagbCpUNbdwOBGj5GuTN3H7Op5ODJ3yxVBy4a
         HJv3vGEEQWldc4EKVLOm7+5le7P2BEiIWuDF1OhwdjSym2xlj9kWG98u6Ge2wHvP8QAZ
         tWipMQtzFYHT0eFwweBjtWhr2X29dn3Z6GXvM4PStsLb8BJAl2VsSyrgiCcO2JqfpiLQ
         mZIfb9bKl4Awxr45GpXcPVoobD3hUoYj2Adz7S2v77C2kyg4y/sYDgRpJl/SvI0brDXa
         u9JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DMnZhta68iAX33CpRchMA+yMZHDHOGcPtQBVqQabrNw=;
        b=kC7NCuNa6NRwC627uX1Nq/mktIBzzi3qI0SMgGP4qIzdrEM8lJxNeY5ufH3HdbMN76
         g5pkDFbrhHKNJbKuc44zOQQE9du8Vo3w5klov9QvJLtdCVr7KmQyFsZouwiiVkqe+tgT
         eihtx3TmYWmziTPNZCaBF51HIA7KRBh+IO3AWXFjxzFqqlkicndKdRErxSDd1jnTFqtm
         WT1B4eAFJagSuaynslNVUb2BIjfRmjyX2jSfNzbs315W2Cn1YD1qYQpkQo0vSTvuEBx+
         T2jMocscLtZ3luWa7SLArvlCfY/iTATSPwfjfVNnEXvgzfqdvEdRlj5oEXj4j6fujVZF
         z4vA==
X-Gm-Message-State: APjAAAX/SJosUmFYxHQY+1RjBQp1fDjQJHFPbFjNzbC77/iStQ0o5X/Z
        ffThgeU7iL6/Adeo/niJNLe1Bw==
X-Google-Smtp-Source: APXvYqxGXfYCaCRlvVgksxX9b5Eab0yr+jZV0UQmnyepRxSCDJinf+ClgjALBi9ceksiejLlB/1QXw==
X-Received: by 2002:a17:906:e285:: with SMTP id gg5mr27392064ejb.229.1555008568161;
        Thu, 11 Apr 2019 11:49:28 -0700 (PDT)
Received: from localhost.localdomain ([80.233.32.123])
        by smtp.gmail.com with ESMTPSA id b10sm1285130edi.28.2019.04.11.11.49.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2019 11:49:27 -0700 (PDT)
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
Subject: [PATCH 9/9] iommu/amd: Add allocated domain to global list earlier
Date:   Thu, 11 Apr 2019 19:47:38 +0100
Message-Id: <20190411184741.27540-10-tmurphy@arista.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190411184741.27540-1-tmurphy@arista.com>
References: <20190411184741.27540-1-tmurphy@arista.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dma_ops_domain_free() expects domain to be in a global list.
Arguably, could be called before protection_domain_init().

Signed-off-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Tom Murphy <tmurphy@arista.com>
---
 drivers/iommu/amd_iommu.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
index 02b351834a3b..bfb021d656aa 100644
--- a/drivers/iommu/amd_iommu.c
+++ b/drivers/iommu/amd_iommu.c
@@ -1801,8 +1801,12 @@ static struct protection_domain *dma_ops_domain_alloc(void)
 	if (!domain)
 		return NULL;
 
-	if (protection_domain_init(domain))
-		goto free_domain;
+	if (protection_domain_init(domain)) {
+		kfree(domain);
+		return NULL;
+	}
+
+	add_domain_to_list(domain);
 
 	domain->mode = PAGE_MODE_3_LEVEL;
 	domain->pt_root = (void *)get_zeroed_page(GFP_KERNEL);
@@ -1824,8 +1828,6 @@ static struct protection_domain *dma_ops_domain_alloc(void)
 	/* Initialize reserved ranges */
 	iommu_dma_copy_reserved_iova(&reserved_iova_ranges, &domain->domain);
 
-	add_domain_to_list(domain);
-
 	return domain;
 
 free_cookie:
-- 
2.17.1

