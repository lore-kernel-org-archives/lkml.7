Return-Path: <SRS0=MEBR=WM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF3F8C3A59C
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 06:54:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 920DF21655
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Aug 2019 06:54:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="n3fHfmab"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbfHPGyw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Aug 2019 02:54:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:60688 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727004AbfHPGys (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Aug 2019 02:54:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=qQpdkoFgBNKt05/BTaCVo55DV3oVIJ72YaRKec/bRIA=; b=n3fHfmabOdIqLDx0EgREHzIU4N
        vuwec044XQulEeYedbLIwYzeglhe2XxTuHNPpqpIcM0LvUx+JLvlBU1uEkLrf9kTjaFPOAl79B01J
        EmvPDsCvsQFxNgNyTtqDe9NMx9hYr2v34TsUxQgCqDOYvz2lNHwb7FeGo/ayNU0YxMg3y/7wJSSB4
        /PO7oDwLg6lE6qqbuCUAqgECkcVZKZQNTeEfhfqaI55/N0WjxagTxCSIMD8QDGccSrwbyaPm0NMgL
        oRDfVtEJHjIRo5715GkJoKvdAkhmPAtEqYNcEXhvg/LckgAJaCwNSnuRqRlqA3N6pyYkmiWLvG/iI
        dP7Wd/fg==;
Received: from [2001:4bb8:18c:28b5:44f9:d544:957f:32cb] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hyW8L-0008HQ-Rt; Fri, 16 Aug 2019 06:54:46 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Bharata B Rao <bharata@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org
Subject: [PATCH 2/4] memremap: remove the dev field in struct dev_pagemap
Date:   Fri, 16 Aug 2019 08:54:32 +0200
Message-Id: <20190816065434.2129-3-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190816065434.2129-1-hch@lst.de>
References: <20190816065434.2129-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dev field in struct dev_pagemap is only used to print dev_name in
two places, which are at best nice to have.  Just remove the field
and thus the name in those two messages.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/memremap.h | 1 -
 mm/memremap.c            | 6 +-----
 mm/page_alloc.c          | 2 +-
 3 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index f8a5b2a19945..8f0013e18e14 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -109,7 +109,6 @@ struct dev_pagemap {
 	struct percpu_ref *ref;
 	struct percpu_ref internal_ref;
 	struct completion done;
-	struct device *dev;
 	enum memory_type type;
 	unsigned int flags;
 	u64 pci_p2pdma_bus_offset;
diff --git a/mm/memremap.c b/mm/memremap.c
index 86432650f829..416b4129acbb 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -102,7 +102,6 @@ static void dev_pagemap_cleanup(struct dev_pagemap *pgmap)
 static void devm_memremap_pages_release(void *data)
 {
 	struct dev_pagemap *pgmap = data;
-	struct device *dev = pgmap->dev;
 	struct resource *res = &pgmap->res;
 	unsigned long pfn;
 	int nid;
@@ -129,8 +128,7 @@ static void devm_memremap_pages_release(void *data)
 
 	untrack_pfn(NULL, PHYS_PFN(res->start), resource_size(res));
 	pgmap_array_delete(res);
-	dev_WARN_ONCE(dev, pgmap->altmap.alloc,
-		      "%s: failed to free all reserved pages\n", __func__);
+	WARN_ONCE(pgmap->altmap.alloc, "failed to free all reserved pages\n");
 }
 
 static void dev_pagemap_percpu_release(struct percpu_ref *ref)
@@ -251,8 +249,6 @@ void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
 		goto err_array;
 	}
 
-	pgmap->dev = dev;
-
 	error = xa_err(xa_store_range(&pgmap_array, PHYS_PFN(res->start),
 				PHYS_PFN(res->end), pgmap, GFP_KERNEL));
 	if (error)
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 272c6de1bf4e..b39baa2b1faf 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5982,7 +5982,7 @@ void __ref memmap_init_zone_device(struct zone *zone,
 		}
 	}
 
-	pr_info("%s initialised, %lu pages in %ums\n", dev_name(pgmap->dev),
+	pr_info("%s initialised %lu pages in %ums\n", __func__,
 		size, jiffies_to_msecs(jiffies - start));
 }
 
-- 
2.20.1

