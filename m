Return-Path: <SRS0=1LW7=ZA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC92FC5DF60
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 00:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EC1121D6C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Nov 2019 00:16:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbfKHAQF convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Nov 2019 19:16:05 -0500
Received: from tyo161.gate.nec.co.jp ([114.179.232.161]:43152 "EHLO
        tyo161.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbfKHAQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 19:16:04 -0500
Received: from mailgate01.nec.co.jp ([114.179.233.122])
        by tyo161.gate.nec.co.jp (8.15.1/8.15.1) with ESMTPS id xA80Fj5Y001311
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 8 Nov 2019 09:15:45 +0900
Received: from mailsv01.nec.co.jp (mailgate-v.nec.co.jp [10.204.236.94])
        by mailgate01.nec.co.jp (8.15.1/8.15.1) with ESMTP id xA80FjKP001121;
        Fri, 8 Nov 2019 09:15:45 +0900
Received: from mail01b.kamome.nec.co.jp (mail01b.kamome.nec.co.jp [10.25.43.2])
        by mailsv01.nec.co.jp (8.15.1/8.15.1) with ESMTP id xA80Etp6014126;
        Fri, 8 Nov 2019 09:15:45 +0900
Received: from bpxc99gp.gisp.nec.co.jp ([10.38.151.152] [10.38.151.152]) by mail01b.kamome.nec.co.jp with ESMTP id BT-MMP-10172977; Fri, 8 Nov 2019 09:08:14 +0900
Received: from BPXM20GP.gisp.nec.co.jp ([10.38.151.212]) by
 BPXC24GP.gisp.nec.co.jp ([10.38.151.152]) with mapi id 14.03.0439.000; Fri, 8
 Nov 2019 09:08:14 +0900
From:   Toshiki Fukasawa <t-fukasawa@vx.jp.nec.com>
To:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mhocko@kernel.org" <mhocko@kernel.org>,
        "adobriyan@gmail.com" <adobriyan@gmail.com>,
        "hch@lst.de" <hch@lst.de>,
        "longman@redhat.com" <longman@redhat.com>,
        "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
        "mst@redhat.com" <mst@redhat.com>, "cai@lca.pw" <cai@lca.pw>,
        Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>,
        Junichi Nomura <j-nomura@ce.jp.nec.com>
Subject: [PATCH 3/3] mm: make pfn walker support ZONE_DEVICE
Thread-Topic: [PATCH 3/3] mm: make pfn walker support ZONE_DEVICE
Thread-Index: AQHVlcicrT2ngYobmkioLRJ7DsejPw==
Date:   Fri, 8 Nov 2019 00:08:13 +0000
Message-ID: <20191108000855.25209-4-t-fukasawa@vx.jp.nec.com>
References: <20191108000855.25209-1-t-fukasawa@vx.jp.nec.com>
In-Reply-To: <20191108000855.25209-1-t-fukasawa@vx.jp.nec.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.34.125.135]
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-TM-AS-MML: disable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch allows pfn walker to read pages on ZONE_DEVICE.
There are the following notes:

	a) The reserved pages indicated by vmem_altmap->reserve
	   are uninitialized, so it must be skipped to read.
	b) To get vmem_altmap, we need to use get_dev_pagemap(),
	   but doing it for all pfns is too slow.

This patch solves both of them. Since vmem_altmap could reserve
only first few pages, we can reduce the number of checks by
counting sequential valid pages.

Signed-off-by: Toshiki Fukasawa <t-fukasawa@vx.jp.nec.com>
---
 fs/proc/page.c           | 22 ++++++++++++++++++----
 include/linux/memremap.h |  6 ++++++
 mm/memremap.c            | 29 +++++++++++++++++++++++++++++
 3 files changed, 53 insertions(+), 4 deletions(-)

diff --git a/fs/proc/page.c b/fs/proc/page.c
index a49b638..b6241ea 100644
--- a/fs/proc/page.c
+++ b/fs/proc/page.c
@@ -33,6 +33,7 @@ static ssize_t kpage_common_read(struct file *file, char __user *buf,
 	struct page *ppage;
 	unsigned long src = *ppos;
 	unsigned long pfn;
+	unsigned long valid_pages = 0;
 	ssize_t ret = 0;
 
 	pfn = src / KPMSIZE;
@@ -41,11 +42,24 @@ static ssize_t kpage_common_read(struct file *file, char __user *buf,
 		return -EINVAL;
 
 	while (count > 0) {
-		/*
-		 * TODO: ZONE_DEVICE support requires to identify
-		 * memmaps that were actually initialized.
-		 */
 		ppage = pfn_to_online_page(pfn);
+		if (!ppage && pfn_zone_device(pfn)) {
+			/*
+			 * Skip to read first few uninitialized pages on
+			 * ZONE_DEVICE. And count valid pages starting
+			 * with the pfn so that minimize the number of
+			 * calls to nr_valid_pages_zone_device().
+			 */
+			if (!valid_pages)
+				valid_pages = nr_valid_pages_zone_device(pfn);
+			if (valid_pages) {
+				ppage = pfn_to_page(pfn);
+				valid_pages--;
+			}
+		} else if (valid_pages) {
+			/* ZONE_DEVICE has been hot removed */
+			valid_pages = 0;
+		}
 
 		if (put_user(read_fn(ppage), out)) {
 			ret = -EFAULT;
diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index 6fefb09..d111ae3 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -123,6 +123,7 @@ static inline struct vmem_altmap *pgmap_altmap(struct dev_pagemap *pgmap)
 }
 
 #ifdef CONFIG_ZONE_DEVICE
+unsigned long nr_valid_pages_zone_device(unsigned long pfn);
 void *memremap_pages(struct dev_pagemap *pgmap, int nid);
 void memunmap_pages(struct dev_pagemap *pgmap);
 void *devm_memremap_pages(struct device *dev, struct dev_pagemap *pgmap);
@@ -133,6 +134,11 @@ struct dev_pagemap *get_dev_pagemap(unsigned long pfn,
 unsigned long vmem_altmap_offset(struct vmem_altmap *altmap);
 void vmem_altmap_free(struct vmem_altmap *altmap, unsigned long nr_pfns);
 #else
+static inline unsigned long nr_valid_pages_zone_device(unsigned long pfn)
+{
+	return 0;
+}
+
 static inline void *devm_memremap_pages(struct device *dev,
 		struct dev_pagemap *pgmap)
 {
diff --git a/mm/memremap.c b/mm/memremap.c
index 8a97fd4..307c73e 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -73,6 +73,35 @@ static unsigned long pfn_next(unsigned long pfn)
 	return pfn + 1;
 }
 
+/*
+ * This returns the number of sequential valid pages starting from @pfn
+ * on ZONE_DEVICE. The invalid pages reserved by driver is first few
+ * pages on ZONE_DEVICE.
+ */
+unsigned long nr_valid_pages_zone_device(unsigned long pfn)
+{
+	struct dev_pagemap *pgmap;
+	struct vmem_altmap *altmap;
+	unsigned long pages;
+
+	pgmap = get_dev_pagemap(pfn, NULL);
+	if (!pgmap)
+		return 0;
+	altmap = pgmap_altmap(pgmap);
+	if (altmap && pfn < (altmap->base_pfn + altmap->reserve))
+		pages = 0;
+	else
+		/*
+		 * PHYS_PFN(pgmap->res.end) is end pfn on pgmap
+		 * (not start pfn on next mapping).
+		 */
+		pages = PHYS_PFN(pgmap->res.end) - pfn + 1;
+
+	put_dev_pagemap(pgmap);
+
+	return pages;
+}
+
 #define for_each_device_pfn(pfn, map) \
 	for (pfn = pfn_first(map); pfn < pfn_end(map); pfn = pfn_next(pfn))
 
-- 
1.8.3.1

