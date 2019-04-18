Return-Path: <SRS0=NWWL=SU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F8EBC10F14
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 20:17:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 19BA920869
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Apr 2019 20:17:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390027AbfDRURS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Apr 2019 16:17:18 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:49920 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728181AbfDRURR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Apr 2019 16:17:17 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=yang.shi@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0TPfSgC1_1555618625;
Received: from e19h19392.et15sqa.tbsite.net(mailfrom:yang.shi@linux.alibaba.com fp:SMTPD_---0TPfSgC1_1555618625)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 19 Apr 2019 04:17:13 +0800
From:   Yang Shi <yang.shi@linux.alibaba.com>
To:     mhocko@suse.com, kirill.shutemov@linux.intel.com, ziy@nvidia.com,
        rppt@linux.vnet.ibm.com, corbet@lwn.net, akpm@linux-foundation.org
Cc:     yang.shi@linux.alibaba.com, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] doc: mm: migration doesn't use FOLL_SPLIT anymore
Date:   Fri, 19 Apr 2019 04:17:04 +0800
Message-Id: <1555618624-23957-1-git-send-email-yang.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When demonstrating FOLL_SPLIT in transhuge document, migration is used
as an example.  But, since commit 94723aafb9e7 ("mm: unclutter THP
migration"), the way of THP migration is totally changed.  FOLL_SPLIT is
not used by migration anymore due to the change.

Remove the obsolete example to avoid confusion.

Cc: Michal Hocko <mhocko@suse.com>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Zi Yan <ziy@nvidia.com>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>
Signed-off-by: Yang Shi <yang.shi@linux.alibaba.com>
---
 Documentation/vm/transhuge.rst | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/Documentation/vm/transhuge.rst b/Documentation/vm/transhuge.rst
index a8cf680..8df3806 100644
--- a/Documentation/vm/transhuge.rst
+++ b/Documentation/vm/transhuge.rst
@@ -55,13 +55,7 @@ prevent page from being split by anyone.
 In case you can't handle compound pages if they're returned by
 follow_page, the FOLL_SPLIT bit can be specified as parameter to
 follow_page, so that it will split the hugepages before returning
-them. Migration for example passes FOLL_SPLIT as parameter to
-follow_page because it's not hugepage aware and in fact it can't work
-at all on hugetlbfs (but it instead works fine on transparent
-hugepages thanks to FOLL_SPLIT). migration simply can't deal with
-hugepages being returned (as it's not only checking the pfn of the
-page and pinning it during the copy but it pretends to migrate the
-memory in regular page sizes and with regular pte/pmd mappings).
+them.
 
 Graceful fallback
 =================
-- 
1.8.3.1

