Return-Path: <SRS0=ebdT=SX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 804A6C10F14
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 11:55:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FB752087F
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Apr 2019 11:55:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="mHhb2n50"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727345AbfDULzc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Apr 2019 07:55:32 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:4815 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725963AbfDULzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Apr 2019 07:55:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1555847731; x=1587383731;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=hRuqolwJoAT78yTwRbNT0wP5hMUVSvWKN3hzr4UOgnY=;
  b=mHhb2n50zMZqtvd2mO0yX8L12jrG9mcuycWJatN+f43KEIBtXokkxM25
   TQA9oVkpdaA3QhmQF6ufsV/F0T3/u+WBWBaIcJWGydHhZFZ4nAiitw70K
   gQ2mnUKwNKdPkrliOnQD0rw7/oXpcJLbs6zKI4Y9UklCIg1Ir6a+XM08h
   0=;
X-IronPort-AV: E=Sophos;i="5.60,377,1549929600"; 
   d="scan'208";a="800574847"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2a-8549039f.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9101.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 21 Apr 2019 11:54:02 +0000
Received: from EX13MTAUEA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2a-8549039f.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id x3LBrTdY040842
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Sun, 21 Apr 2019 11:53:34 GMT
Received: from EX13D19EUB001.ant.amazon.com (10.43.166.229) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 21 Apr 2019 11:53:33 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D19EUB001.ant.amazon.com (10.43.166.229) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Sun, 21 Apr 2019 11:53:32 +0000
Received: from galpress-VirtualBox.hfa16.amazon.com (10.218.62.27) by
 mail-relay.amazon.com (10.43.162.232) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Sun, 21 Apr 2019 11:53:29 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Mukesh Ojha <mojha@codeaurora.org>,
        Gal Pressman <galpress@amazon.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH v2] lib/scatterlist: Remove leftover from sg_page_iter comment
Date:   Sun, 21 Apr 2019 14:53:16 +0300
Message-ID: <1555847596-1754-1-git-send-email-galpress@amazon.com>
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

