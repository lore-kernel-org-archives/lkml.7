Return-Path: <SRS0=GgR0=RR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45172C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 12:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1433F2085A
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Mar 2019 12:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="OHgqCt7/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727572AbfCNMAJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Mar 2019 08:00:09 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:33014 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbfCNMAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Mar 2019 08:00:09 -0400
Received: by mail-ed1-f68.google.com with SMTP id d12so4388860edp.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2019 05:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=googlenew;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=VhknBVjh5NXsr+stejP/bMuc5mZ9IrfgJROxth5MnKc=;
        b=OHgqCt7/0cJvpqwK/ebWyVIQfd2t5JS9QQOktzk9StSAp9NtJ9sKS1eN0KLzfJq0v+
         XNpoXvpKmv6cpKv8Nkkf5v2DgT3YdipRX18AxRQdAfWa5vhmKFHeTzfC/nqFtY1Jl9Ch
         Q/0mE15tVxDQFKRRW2j96VBo34xIDq/BPcnpzyJCkBRx59ERuotz4RKU+AUqcLBDEFEb
         oqky1YvJc66UDSSYKvYi9+GWe2Znz/QfKbZXupsL6Iu98MlzI6ayG24s+6ZujBv46RE7
         iEMzWTD27V6moIKUAKttrNuTMx1Q902OB5fWXr1snlMhjzbxZxWnw6XCDYJIEH+JGIoa
         nspQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=VhknBVjh5NXsr+stejP/bMuc5mZ9IrfgJROxth5MnKc=;
        b=hir6cLNGJvprSDUGP8MpcErZ3wSMc8++Aq+b4jDZZv3vgd1VjV/WiUVaSf1TKB5aCS
         vN40EVtzaf75/XoxTnqE+Fi7C9fqPgh1sWdXrb11xgZ1x6TgBIWwy9RsCPAyyl7vDw7t
         tqoPvwYRDQ9RqlnZGhyujOEhFed1S/09et51dsuwCUDBGdcy589wylh3VX2HbwkSjgbu
         V6f9aR7wxb2S3+GHlBW8or3lyxGQS8zKgZ8y3CFnwI1wJ2mckztss35m3oF6/z+m3uqG
         OggPYfCyYHa8DVxRFxQlsMwemkh9Qqi91/TYqJUASm3TytNPipkfviUGorJFXP2tkWRr
         MuXw==
X-Gm-Message-State: APjAAAXpHt0mO1rNweX5B5FIoGinIH1wgVVgWYcnM1BuObPTbg12URPB
        3lNQfmOJ/81BikWYEX8RFFzRKg==
X-Google-Smtp-Source: APXvYqygZndTnY1MdW11dkSQhi0gy6p1xuvPD5M0s8CJSV0bsAdrC0M18fzwo6VDjOChnrcizgNi9Q==
X-Received: by 2002:a17:906:2001:: with SMTP id 1mr13555292ejo.243.1552564807266;
        Thu, 14 Mar 2019 05:00:07 -0700 (PDT)
Received: from [10.83.32.113] ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id w6sm1360862eds.0.2019.03.14.05.00.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 05:00:06 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.2 \(3445.102.3\))
Subject: [PATCH v2 5/7] iommu/vt-d: Enable DMA remapping after rmrr mapped
From:   James Sewart <jamessewart@arista.com>
In-Reply-To: <83B82113-8AE5-4B0C-A079-F389520525BD@arista.com>
Date:   Thu, 14 Mar 2019 11:58:59 +0000
Cc:     Tom Murphy <tmurphy@arista.com>, Dmitry Safonov <dima@arista.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        linux-kernel@vger.kernel.org, Lu Baolu <baolu.lu@linux.intel.com>
Content-Transfer-Encoding: 7bit
Message-Id: <8880D5C8-8CEF-41C0-BD0D-1643945AD910@arista.com>
References: <0F0C82BE-86E5-4BAC-938C-6F7629E18D27@arista.com>
 <83B82113-8AE5-4B0C-A079-F389520525BD@arista.com>
To:     iommu@lists.linux-foundation.org
X-Mailer: Apple Mail (2.3445.102.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rmrr devices require identity map of the rmrr regions before
enabling DMA remapping. Otherwise, there will be a window during
which DMA from/to the rmrr regions will be blocked. In order to
alleviate this, we move enabling DMA remapping after all rmrr
regions get mapped.

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 104d36f225a7..35821df70f78 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -3518,11 +3518,6 @@ static int __init init_dmars(void)
 		ret = dmar_set_interrupt(iommu);
 		if (ret)
 			goto free_iommu;
-
-		if (!translation_pre_enabled(iommu))
-			iommu_enable_translation(iommu);
-
-		iommu_disable_protect_mem_regions(iommu);
 	}
 
 	return 0;
@@ -4912,7 +4907,6 @@ int __init intel_iommu_init(void)
 		goto out_free_reserved_range;
 	}
 	up_write(&dmar_global_lock);
-	pr_info("Intel(R) Virtualization Technology for Directed I/O\n");
 
 #if defined(CONFIG_X86) && defined(CONFIG_SWIOTLB)
 	swiotlb = 0;
@@ -4935,6 +4929,16 @@ int __init intel_iommu_init(void)
 		register_memory_notifier(&intel_iommu_memory_nb);
 	cpuhp_setup_state(CPUHP_IOMMU_INTEL_DEAD, "iommu/intel:dead", NULL,
 			  intel_iommu_cpu_dead);
+
+	/* Finally, we enable the DMA remapping hardware. */
+	for_each_iommu(iommu, drhd) {
+		if (!translation_pre_enabled(iommu))
+			iommu_enable_translation(iommu);
+
+		iommu_disable_protect_mem_regions(iommu);
+	}
+	pr_info("Intel(R) Virtualization Technology for Directed I/O\n");
+
 	intel_iommu_enabled = 1;
 	intel_iommu_debugfs_init();
 
-- 
2.17.1

