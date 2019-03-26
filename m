Return-Path: <SRS0=4nbc=R5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D2BC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 23:01:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53691208E4
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Mar 2019 23:01:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nn9q3ZFa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732911AbfCZXBn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Mar 2019 19:01:43 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:33403 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732883AbfCZXBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Mar 2019 19:01:41 -0400
Received: by mail-pl1-f194.google.com with SMTP id bg8so2326308plb.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2019 16:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YwwzX2Ckb5IfO36KXFpoRn0bgcwJZJMjsrMm/Tj5wmQ=;
        b=Nn9q3ZFaAD/c1+ZSBu573k//eegbkL8oLW4s44qOduajMYZ21kIvPvakhZ0S5rv4QB
         tJnGB7JqGFkcFhJ4Xcnl1T94Uzhdg5SUmHGXHq9IzLJ4oa+vRIGN0MF8fznY7AjLo161
         M4mwwCYDcNkdNq/I0W4PRkG597A/r+FLTt94H8HrzDzqFQ8roUk3SO3mZbUG3AHgV45w
         VW7bgYKIeZ9LKh5xsktkTHnYZ5svDQ+6FdZYNk2Qv7cGP0YkZDTuNHNP5emgFZpMqqwr
         e9G3wJbgWu2utDgh+a5fXLTaKac2Je2evrrANpmaSszlhOrX6XujofGDF+rELW4LogUS
         ghMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YwwzX2Ckb5IfO36KXFpoRn0bgcwJZJMjsrMm/Tj5wmQ=;
        b=QhdCU46p/fpc3QkjsaZyE+Sid2nBqb1EAc2064EvvFZ6mXdBgFYdzsNnv4oIx0Id4a
         rb2C3nqo0zZNbesFogdyEKcI5dg2M8qYAMfEx9bAGqVFXs5oDjfLD1CqxmOgsiISOIpb
         PBN6rOBpndHQ+Hg1cWONfeDDYsT2Daosyu551G1RYYO774f97k5beJkVwgkLHCTVvNrh
         3jdhhhZiF5PsONVRjNxQ0V2V5tzztBqnUtJkqSLwgJbciGFe80HyUfhS/EvMhTZqBRB3
         BK+qSED180gfS21uFNh09NqGtdR9+SUpKxIZZ6mwfI12k7Zj15RDeiQJ09C7jq0oGAc5
         ccYA==
X-Gm-Message-State: APjAAAU0imV7Icp6GCp+uJ74SFMmfPx9s4Bad8wjVbwo5OShbmF56H7l
        hV348Adg6fexrry5VzC7sp8=
X-Google-Smtp-Source: APXvYqwos9GlWk8aPE/h4lNoYQAEJzJM0q9VFoHFIolVkeadZjxjBGqN/o6Xk9M/LFnA64Pau6O61g==
X-Received: by 2002:a17:902:8643:: with SMTP id y3mr33347145plt.195.1553641300615;
        Tue, 26 Mar 2019 16:01:40 -0700 (PDT)
Received: from Asurada-Nvidia.nvidia.com (thunderhill.nvidia.com. [216.228.112.22])
        by smtp.gmail.com with ESMTPSA id n24sm43832587pfi.123.2019.03.26.16.01.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Mar 2019 16:01:40 -0700 (PDT)
From:   Nicolin Chen <nicoleotsuka@gmail.com>
To:     hch@lst.de, robin.murphy@arm.com
Cc:     vdumpa@nvidia.com, linux@armlinux.org.uk, catalin.marinas@arm.com,
        will.deacon@arm.com, joro@8bytes.org, m.szyprowski@samsung.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux-foundation.org, tony@atomide.com
Subject: [PATCH v2 RFC/RFT 2/5] dma-remap: Run alloc_pages() on failure
Date:   Tue, 26 Mar 2019 16:01:28 -0700
Message-Id: <20190326230131.16275-3-nicoleotsuka@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190326230131.16275-1-nicoleotsuka@gmail.com>
References: <20190326230131.16275-1-nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CMA allocation will skip allocations of single pages to save CMA
resource. This requires its callers to rebound those page allocations
from normal area.

So this patch moves the alloc_pages() call to the fallback routines.

Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
Changlog
v1->v2:
 * PATCH-2: Initialized page pointer to NULL

 kernel/dma/remap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/dma/remap.c b/kernel/dma/remap.c
index 2b750f13bc8f..c2076c6d6c17 100644
--- a/kernel/dma/remap.c
+++ b/kernel/dma/remap.c
@@ -109,14 +109,14 @@ int __init dma_atomic_pool_init(gfp_t gfp, pgprot_t prot)
 {
 	unsigned int pool_size_order = get_order(atomic_pool_size);
 	unsigned long nr_pages = atomic_pool_size >> PAGE_SHIFT;
-	struct page *page;
+	struct page *page = NULL;
 	void *addr;
 	int ret;
 
 	if (dev_get_cma_area(NULL))
 		page = dma_alloc_from_contiguous(NULL, nr_pages,
 						 pool_size_order, false);
-	else
+	if (!page)
 		page = alloc_pages(gfp, pool_size_order);
 	if (!page)
 		goto out;
-- 
2.17.1

