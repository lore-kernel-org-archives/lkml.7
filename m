Return-Path: <SRS0=J8hU=TI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAFA0C04AAD
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 00:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5FEC20675
	for <linux-kernel@archiver.kernel.org>; Wed,  8 May 2019 00:10:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbfEHAJ7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 20:09:59 -0400
Received: from mga09.intel.com ([134.134.136.24]:64953 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbfEHAJ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 20:09:57 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 May 2019 17:09:57 -0700
X-ExtLoop1: 1
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.16])
  by orsmga002.jf.intel.com with ESMTP; 07 May 2019 17:09:57 -0700
Subject: [PATCH v2 2/6] mm/devm_memremap_pages: Introduce devm_memunmap_pages
From:   Dan Williams <dan.j.williams@intel.com>
To:     akpm@linux-foundation.org
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Christoph Hellwig <hch@lst.de>,
        Ira Weiny <ira.weiny@intel.com>, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-mm@kvack.org
Date:   Tue, 07 May 2019 16:56:10 -0700
Message-ID: <155727337088.292046.5774214552136776763.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <155727335978.292046.12068191395005445711.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <155727335978.292046.12068191395005445711.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new devm_relase_action() facility to allow
devm_memremap_pages_release() to be manually triggered.

Cc: Logan Gunthorpe <logang@deltatee.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Christoph Hellwig <hch@lst.de>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 include/linux/memremap.h |    6 ++++++
 kernel/memremap.c        |    6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index f0628660d541..7601ee314c4a 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -100,6 +100,7 @@ struct dev_pagemap {
 
 #ifdef CONFIG_ZONE_DEVICE
 void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap);
+void devm_memunmap_pages(struct device *dev, struct dev_pagemap *pgmap);
 struct dev_pagemap *get_dev_pagemap(unsigned long pfn,
 		struct dev_pagemap *pgmap);
 
@@ -118,6 +119,11 @@ static inline void *devm_memremap_pages(struct device *dev,
 	return ERR_PTR(-ENXIO);
 }
 
+static inline void devm_memunmap_pages(struct device *dev,
+		struct dev_pagemap *pgmap)
+{
+}
+
 static inline struct dev_pagemap *get_dev_pagemap(unsigned long pfn,
 		struct dev_pagemap *pgmap)
 {
diff --git a/kernel/memremap.c b/kernel/memremap.c
index a856cb5ff192..65afbacab44e 100644
--- a/kernel/memremap.c
+++ b/kernel/memremap.c
@@ -266,6 +266,12 @@ void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap)
 }
 EXPORT_SYMBOL_GPL(devm_memremap_pages);
 
+void devm_memunmap_pages(struct device *dev, struct dev_pagemap *pgmap)
+{
+	devm_release_action(dev, devm_memremap_pages_release, pgmap);
+}
+EXPORT_SYMBOL_GPL(devm_memunmap_pages);
+
 unsigned long vmem_altmap_offset(struct vmem_altmap *altmap)
 {
 	/* number of pfns from base where pfn_to_page() is valid */

