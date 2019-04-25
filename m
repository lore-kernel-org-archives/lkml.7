Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F91C282CE
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 01:42:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9460A206BA
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 01:42:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388273AbfDYBmw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Apr 2019 21:42:52 -0400
Received: from mga11.intel.com ([192.55.52.93]:25341 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388217AbfDYBmr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Apr 2019 21:42:47 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Apr 2019 18:42:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,391,1549958400"; 
   d="scan'208";a="152134226"
Received: from zz23f_aep_wp03.sh.intel.com ([10.239.85.39])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Apr 2019 18:42:45 -0700
From:   Fan Du <fan.du@intel.com>
To:     akpm@linux-foundation.org, mhocko@suse.com, fengguang.wu@intel.com,
        dan.j.williams@intel.com, dave.hansen@intel.com,
        xishi.qiuxishi@alibaba-inc.com, ying.huang@intel.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Fan Du <fan.du@intel.com>
Subject: [RFC PATCH 3/5] x86,numa: update numa node type
Date:   Thu, 25 Apr 2019 09:21:33 +0800
Message-Id: <1556155295-77723-4-git-send-email-fan.du@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1556155295-77723-1-git-send-email-fan.du@intel.com>
References: <1556155295-77723-1-git-send-email-fan.du@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Give the newly created node a type per SRAT attribution.

Signed-off-by: Fan Du <fan.du@intel.com>
---
 arch/x86/mm/numa.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/mm/numa.c b/arch/x86/mm/numa.c
index 3c3a1f5..ff8ad63 100644
--- a/arch/x86/mm/numa.c
+++ b/arch/x86/mm/numa.c
@@ -590,6 +590,7 @@ static int __init numa_register_memblks(struct numa_meminfo *mi)
 			continue;
 
 		alloc_node_data(nid);
+		set_node_type(nid);
 	}
 
 	/* Dump memblock with node info and return. */
-- 
1.8.3.1

