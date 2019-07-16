Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D4DBC7618F
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 21:38:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE9F1206C2
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 21:38:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="Ytei0mxZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387751AbfGPViM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 17:38:12 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41044 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728517AbfGPViL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 17:38:11 -0400
Received: by mail-wr1-f66.google.com with SMTP id c2so19300926wrm.8
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2019 14:38:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DV9WVVOv8wO0ip68P+ATuW8HVCr+cq/h0WK6TYHXz40=;
        b=Ytei0mxZsdGPH15bJ5E6+IRRrJxdxQYweXTsmG304a32ncCq2Zut6fnD0ChH5Rvdtx
         7n6+DYDocRt6dRmIcVNoCLeoIcxBf9WuRyBQXdXzUUcpLypJZ9lDrWzEqaT2nVQGzfiC
         mVgjxuRUg+tQ/4P4NSYTmApq7fGyu58dVFukzcTj0PlPhdSEh2IXElqTspqi3RsqXq0E
         FurxiRjg3Ld5pWQ3inzN4xST/LNDvAVe78IvafxHU3I7W340xX7UpqT+aL5jutSmbufz
         /F4OJz4UhgALcV279ytC7ELlQGB3Jk+7ymtI3RUJPMOIhtaR/IFCQuMDKBSB5zENjg/C
         1fJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DV9WVVOv8wO0ip68P+ATuW8HVCr+cq/h0WK6TYHXz40=;
        b=iEX+ILZBDmvGz57ilPNye6qttoUSRn918dPGmGN3Exn2KqISmWM13x2QRFCxukzU4s
         lRJ/LZZQHUnzNixX8QJd6GWwmSgOqn2ekDUwvm3JyYZpis/yk1jyldPG8BT+KjYnsqKu
         taL0UieHig7k2vNn2yFsfTe3ZJ7QA2enRv0vUV8CFfjLSPZbA4e7BT3KOQ66M7NA+JQI
         Z4C2QLydvrALbGSYd9DqGCQJqgvmONXnVS9yBUJxvYPDrRp1HMhjD2zr5+3Wj0thQ6C1
         MG6pVcGFN5Y89fkEXLwjTO4Wh6r1spPxvphtLYi5nUYLu91g6l+1Fbk7B4gbR2OeAoPK
         Lkgg==
X-Gm-Message-State: APjAAAWggf6ZgoOQxanM4zBw7NNoWest36DoqaELpknaauaJBIED2AKu
        nrV2tzeoI/bPi+BD2dnllOE5qwnJUU6fwrzA1fsDdM87AX3vN9r2UUEsRY5aNxER1lH+UxPpFw8
        rN6lCuATVN0+rMDvtSbft/9A6luwcHG1DhRFF27H2RtUUmU5jyEejEFIPF+ZNcpy2E7CxZ2zlet
        K6eRzXSNHExA3af+Goa2hJZiK3S61+GTQS1kK3SMo=
X-Google-Smtp-Source: APXvYqw5ALrLIvtEXCM8Di+Utbf0l1rDDBeCT8Gy5U19bxE+NT36mjnIOBhk5/4UBMToMi+XbbXN7g==
X-Received: by 2002:adf:ef8d:: with SMTP id d13mr36651521wro.60.1563313089468;
        Tue, 16 Jul 2019 14:38:09 -0700 (PDT)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id v5sm22496878wre.50.2019.07.16.14.38.08
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 16 Jul 2019 14:38:08 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Joerg Roedel <joro@8bytes.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org
Subject: [PATCH 2/2] iommu/vt-d: Check if domain->pgd was allocated
Date:   Tue, 16 Jul 2019 22:38:06 +0100
Message-Id: <20190716213806.20456-2-dima@arista.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190716213806.20456-1-dima@arista.com>
References: <20190716213806.20456-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CLOUD-SEC-AV-Info: arista,google_mail,monitor
X-CLOUD-SEC-AV-Sent: true
X-Gm-Spam: 0
X-Gm-Phishy: 0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a couple of places where on domain_init() failure domain_exit()
is called. While currently domain_init() can fail only if
alloc_pgtable_page() has failed.

Make domain_exit() check if domain->pgd present, before calling
domain_unmap(), as it theoretically should crash on clearing pte entries
in dma_pte_clear_level().

Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux-foundation.org
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 drivers/iommu/intel-iommu.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 6d1510284d21..698cc40355ef 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -1835,7 +1835,6 @@ static inline int guestwidth_to_adjustwidth(int gaw)
 
 static void domain_exit(struct dmar_domain *domain)
 {
-	struct page *freelist;
 
 	/* Remove associated devices and clear attached or cached domains */
 	domain_remove_dev_info(domain);
@@ -1843,9 +1842,12 @@ static void domain_exit(struct dmar_domain *domain)
 	/* destroy iovas */
 	put_iova_domain(&domain->iovad);
 
-	freelist = domain_unmap(domain, 0, DOMAIN_MAX_PFN(domain->gaw));
+	if (domain->pgd) {
+		struct page *freelist;
 
-	dma_free_pagelist(freelist);
+		freelist = domain_unmap(domain, 0, DOMAIN_MAX_PFN(domain->gaw));
+		dma_free_pagelist(freelist);
+	}
 
 	free_domain_mem(domain);
 }
-- 
2.22.0

