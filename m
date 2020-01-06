Return-Path: <SRS0=pFUE=23=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E25EC33C8C
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 15:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDBF6207FD
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jan 2020 15:27:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="DsPu+SD2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726569AbgAFP1j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jan 2020 10:27:39 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33437 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbgAFP1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jan 2020 10:27:39 -0500
Received: by mail-qk1-f193.google.com with SMTP id d71so31882376qkc.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jan 2020 07:27:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EFnpNY+6QaoLE3QL0daZSOcFms2OzGtmAouUn+Z/oVc=;
        b=DsPu+SD2lOfczXptpS0IMN16HQIFVV9+QMxOZ2iDWyHPWcgFyZKhupGFKDnYdPvKb/
         GI7aEfCS5r8YkNaHLaIKjfRsDE9rCssKskjnqtp3UnpFGqcFnIdYvLTWHs1vUkBTVjG6
         yG8I9Kl9AjqqOyaf+IAS+EINi61EBVwEk6Xj8n3tT1XneH7pk2sQ5qFkvB73YFiVr3jO
         +nLBfK/p4Fv12xb+MjV2H0c231T6yGyeowOVhN4Fg8kSHukx4iHJd6+wfxZPzscCXrtv
         qoSSuWXOHxaare3odrncmLp1/Ub4QJ+qBLaMAg4e8ztbRfsuCGDDSDyg0lYJUqWhGxh5
         xPmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EFnpNY+6QaoLE3QL0daZSOcFms2OzGtmAouUn+Z/oVc=;
        b=p60yJNp3sZL4iDZHmMN6lVFoCoN0npM4NX6uPQw0YLJr3KBZP+MidkXb1zPHD/WXcE
         nY9Q1EtqFv0MwoOi3hmI/4asXdXWoUUGv1GEmCCV76EsOiBVcA3yE7y3SDDkJNFgf3Qv
         xo8VoqQ4TfiDmzxgnZhCCWBHv+MeZbBuAbfK7zcmfzTjrD9zbUZ5ODj6NGfCQIaqrEwa
         WsPZmgbab3YqXzAgJU388qn90BiLO5RF6AByn61lkl5EA2IMhY8uM9jaSH7LZuXaGRE5
         Prgc8wPpDvFbWMKR02MPzCvv3u8B/Ds9IjzN7ii0peFYu0VVRXln4Uvc8/Uxca8diJR+
         +6cg==
X-Gm-Message-State: APjAAAXInuKuk7mS8xkmwPe7buw83pisoXApsq5Kb/0lqgeLLlw9p3n+
        Dus3/CLGPivuTuJw4N4Cl5euVA==
X-Google-Smtp-Source: APXvYqzfojOxjHxLFLBXN8zM7+ZD66O2Wx2gD4w5lRbMNdGv7OEevDWI5WnfDzJwZBY8yMi2hNt69A==
X-Received: by 2002:ae9:ea08:: with SMTP id f8mr77776178qkg.489.1578324458269;
        Mon, 06 Jan 2020 07:27:38 -0800 (PST)
Received: from ovpn-121-70.rdu2.redhat.com (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id f23sm20757695qke.104.2020.01.06.07.27.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Jan 2020 07:27:37 -0800 (PST)
From:   Qian Cai <cai@lca.pw>
To:     jroedel@suse.de
Cc:     robin.murphy@arm.com, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, Qian Cai <cai@lca.pw>
Subject: [PATCH] iommu/dma: fix variable 'cookie' set but not used
Date:   Mon,  6 Jan 2020 10:27:27 -0500
Message-Id: <20200106152727.1589-1-cai@lca.pw>
X-Mailer: git-send-email 2.21.0 (Apple Git-122.2)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit c18647900ec8 ("iommu/dma: Relax locking in
iommu_dma_prepare_msi()") introduced a compliation warning,

drivers/iommu/dma-iommu.c: In function 'iommu_dma_prepare_msi':
drivers/iommu/dma-iommu.c:1206:27: warning: variable 'cookie' set but
not used [-Wunused-but-set-variable]
  struct iommu_dma_cookie *cookie;
                           ^~~~~~

Fixes: c18647900ec8 ("iommu/dma: Relax locking in iommu_dma_prepare_msi()")
Signed-off-by: Qian Cai <cai@lca.pw>
---
 drivers/iommu/dma-iommu.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index c363294b3bb9..a2e96a5fd9a7 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -1203,7 +1203,6 @@ int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
 {
 	struct device *dev = msi_desc_to_dev(desc);
 	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
-	struct iommu_dma_cookie *cookie;
 	struct iommu_dma_msi_page *msi_page;
 	static DEFINE_MUTEX(msi_prepare_lock); /* see below */
 
@@ -1212,8 +1211,6 @@ int iommu_dma_prepare_msi(struct msi_desc *desc, phys_addr_t msi_addr)
 		return 0;
 	}
 
-	cookie = domain->iova_cookie;
-
 	/*
 	 * In fact the whole prepare operation should already be serialised by
 	 * irq_domain_mutex further up the callchain, but that's pretty subtle
-- 
2.21.0 (Apple Git-122.2)

