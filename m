Return-Path: <SRS0=jE6e=VN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3E70C76192
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 07:37:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A469B20880
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jul 2019 07:37:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbfGPHhC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jul 2019 03:37:02 -0400
Received: from mga01.intel.com ([192.55.52.88]:19290 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726463AbfGPHhC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jul 2019 03:37:02 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jul 2019 00:37:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,497,1557212400"; 
   d="scan'208";a="366127139"
Received: from cvg-ubt08.iil.intel.com ([143.185.152.136])
  by fmsmga005.fm.intel.com with ESMTP; 16 Jul 2019 00:37:00 -0700
From:   Vladimir Kondratiev <vladimir.kondratiev@linux.intel.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vladimir Kondratiev <vladimir.kondratiev@linux.intel.com>
Subject: [PATCH] mips: fix cacheinfo
Date:   Tue, 16 Jul 2019 10:36:56 +0300
Message-Id: <20190716073656.24924-1-vladimir.kondratiev@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because CONFIG_OF defined for MIPS, cacheinfo attempts to fill information
from DT, ignoring data filled by architecture routine. This leads to error
reported

 cacheinfo: Unable to detect cache hierarchy for CPU 0

Way to fix this provided in
commit fac51482577d ("drivers: base: cacheinfo: fix x86 with
 CONFIG_OF enabled")

Utilize same mechanism to report that cacheinfo set by architecture
specific function

Signed-off-by: Vladimir Kondratiev <vladimir.kondratiev@linux.intel.com>
---
 arch/mips/kernel/cacheinfo.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/kernel/cacheinfo.c b/arch/mips/kernel/cacheinfo.c
index e0dd66881da6..f777e44653d5 100644
--- a/arch/mips/kernel/cacheinfo.c
+++ b/arch/mips/kernel/cacheinfo.c
@@ -69,6 +69,8 @@ static int __populate_cache_leaves(unsigned int cpu)
 	if (c->tcache.waysize)
 		populate_cache(tcache, this_leaf, 3, CACHE_TYPE_UNIFIED);
 
+	this_cpu_ci->cpu_map_populated = true;
+
 	return 0;
 }
 
-- 
2.20.1

