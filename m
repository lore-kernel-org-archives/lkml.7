Return-Path: <SRS0=yQuH=Z3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE6EC43603
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 02:15:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96DFC21823
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Dec 2019 02:15:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728924AbfLECPv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Dec 2019 21:15:51 -0500
Received: from mga02.intel.com ([134.134.136.20]:44510 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728656AbfLECPu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Dec 2019 21:15:50 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Dec 2019 18:15:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,279,1571727600"; 
   d="scan'208";a="263147679"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Dec 2019 18:15:48 -0800
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     richard.weiyang@gmail.com, dave.hansen@linux.intel.com,
        luto@kernel.org, peterz@infradead.or, tglx@linutronix.de,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [Patch v2 4/6] x86/mm: Refine debug print string retrieval function
Date:   Thu,  5 Dec 2019 10:14:01 +0800
Message-Id: <20191205021403.25606-5-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191205021403.25606-1-richardw.yang@linux.intel.com>
References: <20191205021403.25606-1-richardw.yang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Generally, the mapping page size are:

   4K, 2M, 1G

except in case 32-bit without PAE, the mapping page size are:

   4K, 4M

Based on PG_LEVEL_X definition and mr->page_size_mask, we can calculate
the mapping page size from a predefined string array.

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---
 arch/x86/mm/init.c | 39 +++++++++++++--------------------------
 1 file changed, 13 insertions(+), 26 deletions(-)

diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 0eb5edb63fa2..ded58a31c679 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -308,29 +308,20 @@ static void __ref adjust_range_page_size_mask(struct map_range *mr,
 	}
 }
 
-static const char *page_size_string(struct map_range *mr)
+static void __meminit mr_print(struct map_range *mr, unsigned int maxidx)
 {
-	static const char str_1g[] = "1G";
-	static const char str_2m[] = "2M";
-	static const char str_4m[] = "4M";
-	static const char str_4k[] = "4k";
-
-	if (mr->page_size_mask & (1U<<PG_LEVEL_1G))
-		return str_1g;
-	/*
-	 * 32-bit without PAE has a 4M large page size.
-	 * PG_LEVEL_2M is misnamed, but we can at least
-	 * print out the right size in the string.
-	 */
-	if (IS_ENABLED(CONFIG_X86_32) &&
-	    !IS_ENABLED(CONFIG_X86_PAE) &&
-	    mr->page_size_mask & (1U<<PG_LEVEL_2M))
-		return str_4m;
-
-	if (mr->page_size_mask & (1U<<PG_LEVEL_2M))
-		return str_2m;
+#if defined(CONFIG_X86_32) && !defined(CONFIG_X86_PAE)
+	static const char *sz[2] = { "4K", "4M" };
+#else
+	static const char *sz[4] = { "4K", "2M", "1G", "" };
+#endif
+	unsigned int idx, s;
 
-	return str_4k;
+	for (idx = 0; idx < maxidx; idx++, mr++) {
+		s = (mr->page_size_mask >> PG_LEVEL_2M) & (ARRAY_SIZE(sz) - 1);
+		pr_debug(" [mem %#010lx-%#010lx] page size %s\n",
+			 mr->start, mr->end - 1, sz[s]);
+	}
 }
 
 static int __meminit split_mem_range(struct map_range *mr,
@@ -425,11 +416,7 @@ static int __meminit split_mem_range(struct map_range *mr,
 		nr_range--;
 	}
 
-	for (i = 0; i < nr_range; i++)
-		pr_debug(" [mem %#010lx-%#010lx] page %s\n",
-				mr[i].start, mr[i].end - 1,
-				page_size_string(&mr[i]));
-
+	mr_print(mr, nr_range);
 	return nr_range;
 }
 
-- 
2.17.1

