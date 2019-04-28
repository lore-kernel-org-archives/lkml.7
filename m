Return-Path: <SRS0=wfQU=S6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94EDFC4321A
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 06:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62BA021473
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Apr 2019 06:49:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="e+wIoIqx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbfD1Gpo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Apr 2019 02:45:44 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:56128 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbfD1Gpo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Apr 2019 02:45:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1556433943; x=1587969943;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=hRuqolwJoAT78yTwRbNT0wP5hMUVSvWKN3hzr4UOgnY=;
  b=e+wIoIqxUej9Wbg9g6b/ldNC9De6ixIPBEAxviT9eWWENzGAP0zSr87A
   /ZU/amdClDBd7bMbS9kRkKdlhkmNhlpQzkcu6Q38ETkGwkQIka5oYj3nm
   gQAEGxn1rNST17VL0gtxctfTv113SV3UjDfAOxt6OE2CSq6lGvzg2ol6j
   4=;
X-IronPort-AV: E=Sophos;i="5.60,404,1549929600"; 
   d="scan'208";a="730881530"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1e-97fdccfd.us-east-1.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 28 Apr 2019 06:45:36 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-97fdccfd.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id x3S6jZ7u097745
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Sun, 28 Apr 2019 06:45:35 GMT
Received: from EX13D19EUA004.ant.amazon.com (10.43.165.28) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 28 Apr 2019 06:45:35 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D19EUA004.ant.amazon.com (10.43.165.28) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 28 Apr 2019 06:45:33 +0000
Received: from galpress-VirtualBox.amazon.com (10.218.62.27) by
 mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Sun, 28 Apr 2019 06:45:32 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Mukesh Ojha <mojha@codeaurora.org>,
        Gal Pressman <galpress@amazon.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [RESEND PATCH v2] lib/scatterlist: Remove leftover from sg_page_iter comment
Date:   Sun, 28 Apr 2019 09:45:30 +0300
Message-ID: <1556433930-16302-1-git-send-email-galpress@amazon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit d901b2760dc6 ("lib/scatterlist: Provide a DMA page iterator")
added the sg DMA iterator but a leftover remained in the sg_page_iter
documentation as you cannot get the page dma address (only the page
itself), fix it.

Cc: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Gal Pressman <galpress@amazon.com>
Reviewed-by: Mukesh Ojha <mojha@codeaurora.org>
---
Changelog:
v1->v2:
* Reword commit message
---
 include/linux/scatterlist.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/scatterlist.h b/include/linux/scatterlist.h
index b4be960c7e5d..30a9a55c28ba 100644
--- a/include/linux/scatterlist.h
+++ b/include/linux/scatterlist.h
@@ -340,11 +340,11 @@ int sg_alloc_table_chained(struct sg_table *table, int nents,
  * sg page iterator
  *
  * Iterates over sg entries page-by-page.  On each successful iteration, you
- * can call sg_page_iter_page(@piter) to get the current page and its dma
- * address. @piter->sg will point to the sg holding this page and
- * @piter->sg_pgoffset to the page's page offset within the sg. The iteration
- * will stop either when a maximum number of sg entries was reached or a
- * terminating sg (sg_last(sg) == true) was reached.
+ * can call sg_page_iter_page(@piter) to get the current page.
+ * @piter->sg will point to the sg holding this page and @piter->sg_pgoffset to
+ * the page's page offset within the sg. The iteration will stop either when a
+ * maximum number of sg entries was reached or a terminating sg
+ * (sg_last(sg) == true) was reached.
  */
 struct sg_page_iter {
 	struct scatterlist	*sg;		/* sg holding the page */
-- 
2.7.4

