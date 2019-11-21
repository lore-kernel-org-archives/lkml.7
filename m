Return-Path: <SRS0=lLEG=ZN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C7CC432C0
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 00:14:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 295E720885
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Nov 2019 00:14:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PmTUpgmc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726784AbfKUAOd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 19:14:33 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:32924 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbfKUAO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 19:14:28 -0500
Received: by mail-pf1-f195.google.com with SMTP id c184so667052pfb.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Nov 2019 16:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=udQXwBqwVUeF6xC6dQa8BSO4hgjarlIB0Nc7lZHwUEA=;
        b=PmTUpgmcsZD3GF/gHlUVnQ7Wd6qGzBXJRebg41O5KVp5B4SGj1iQoNT6vrG16K1vWv
         PMW+ss1KwBjjxcowPxX0G5tfmjwtDcoxYWSqXxGzroRbZ7+ReUh5wNat1j67hfHawzPy
         l5xUJpSiqCwH+BdW8gVIEMDYEv6S6X4xCId+oIOFcRvlf50SDCGE9o58neccf4tXAnEs
         Sz62fIvYg0WHp4Ade1Vfm0ToGQ26feG2MYMWjgmrAn+xJweDd/aN43V5GrGNfAS+ga9X
         VrjormozWMpTexqanVuLBV1MtPIsvqzloBjV4DEdsDLZT2uNeWG32eNAsY1glpl9Humz
         gGKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=udQXwBqwVUeF6xC6dQa8BSO4hgjarlIB0Nc7lZHwUEA=;
        b=MDb2fdDv184WU+NP6o4S/MFWg0XIpf1M6Mt1QHvqnZHtQlPkSLOhfKfeIN/O1rxv3b
         uMXb/cL1AeE4eqS0Na3EPCz5Ubz6QZOdQeUeXnky9uC35g4wqal9jsHxrcXGkVGYNzT9
         VZkWhA2ztP4fSdkeEYF1n8x82GC7aqssAB4oK8wFIbrB3Oa3YFnVgI1yhZ6YYfwrjwFQ
         zd2rq2w+a3jc2BH69gLlOv3WNeuE2J+EzZT6IsBaxHgpj6exigZzOytc630fC6yhlHdK
         7IB3XyY4XnpqDahiBd+8q5BY7144HYjUiz5SS1LnVo24QUopUUSvQ01AL5liSj395Duq
         g0gA==
X-Gm-Message-State: APjAAAWsaF3Oy/mQVJlyieLYk7BlCryPdue/KNN99aDvngC9O+Jzba5g
        74fOED4I1s2VA1oiO3wEdXL9iYV97Bs=
X-Google-Smtp-Source: APXvYqx70jN/lPvZpOJJEJjwiAVrjv2LEdf58Rsl9gZ8a1GGPTbJPowBV+wmAhPAjJGY0xKjB0p9Ag==
X-Received: by 2002:a63:5551:: with SMTP id f17mr6048190pgm.287.1574295267007;
        Wed, 20 Nov 2019 16:14:27 -0800 (PST)
Received: from tw-172-25-31-76.office.twttr.net ([8.25.197.24])
        by smtp.gmail.com with ESMTPSA id r4sm565981pfl.61.2019.11.20.16.14.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Nov 2019 16:14:26 -0800 (PST)
From:   Cong Wang <xiyou.wangcong@gmail.com>
To:     iommu@lists.linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, joro@8bytes.org,
        Cong Wang <xiyou.wangcong@gmail.com>
Subject: [PATCH 3/3] iommu: avoid taking iova_rbtree_lock twice
Date:   Wed, 20 Nov 2019 16:13:48 -0800
Message-Id: <20191121001348.27230-4-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191121001348.27230-1-xiyou.wangcong@gmail.com>
References: <20191121001348.27230-1-xiyou.wangcong@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both find_iova() and __free_iova() take iova_rbtree_lock,
there is no reason to take and release it twice inside
free_iova().

Fold them into the critical section by calling the unlock
versions instead.

Cc: Joerg Roedel <joro@8bytes.org>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 drivers/iommu/iova.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index b82c6f1cbfc2..ba6bd33f2b16 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -390,10 +390,14 @@ EXPORT_SYMBOL_GPL(__free_iova);
 void
 free_iova(struct iova_domain *iovad, unsigned long pfn)
 {
-	struct iova *iova = find_iova(iovad, pfn);
+	unsigned long flags;
+	struct iova *iova;
 
+	spin_lock_irqsave(&iovad->iova_rbtree_lock, flags);
+	iova = private_find_iova(iovad, pfn);
 	if (iova)
-		__free_iova(iovad, iova);
+		private_free_iova(iovad, iova);
+	spin_unlock_irqrestore(&iovad->iova_rbtree_lock, flags);
 
 }
 EXPORT_SYMBOL_GPL(free_iova);
-- 
2.21.0

