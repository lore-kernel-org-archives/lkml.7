Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA9EC433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 08:00:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8687E2133F
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 08:00:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GMnK8vxS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbfHNIAD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 04:00:03 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:39794 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727447AbfHNIAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 04:00:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=vBk1LYfglvU9WhzFBd+HGPsCFZW0PolzMu2uE5RY+Ss=; b=GMnK8vxSRHA4WBgd0X24IGMQFS
        3/qyPBXcIpuzxhIzULi17D+Sxbxfz3UHdutVGw8hYZT7dg9L5K4HJP9Zv1ybkLfKiIvv0Xj0zbKSq
        B4a0igjfBisQeyWlPE6esFoPgkgyt1o7d6hwHwEcaqW86UVtNw/YOYaa4k9WRDj0kqNN6/VIiWs7b
        k1AnlR1SWZoy5oVOjtnLMXcTaUQWZmvy9GDnfMx1qHAWq9eFCgZqC1zu8Fl2N0sOsy8yBZnwinBe/
        G9yeDxATQuVNZHLLRBa8CfidabY+rvSRysvvBABm6agbj9RFnL44HhqRpySHsZz8/p1SnC10Aa8if
        xBnjGJuQ==;
Received: from [2001:4bb8:180:1ec3:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hxoCK-000864-11; Wed, 14 Aug 2019 07:59:56 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>
Cc:     Ralph Campbell <rcampbell@nvidia.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/10] mm: remove the unused MIGRATE_PFN_ERROR flag
Date:   Wed, 14 Aug 2019 09:59:26 +0200
Message-Id: <20190814075928.23766-9-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190814075928.23766-1-hch@lst.de>
References: <20190814075928.23766-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that we can rely errors in the normal control flow there is no
need for this flag, remove it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>
---
 include/linux/migrate.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 18156d379ebf..1e67dcfd318f 100644
--- a/include/linux/migrate.h
+++ b/include/linux/migrate.h
@@ -167,7 +167,6 @@ static inline int migrate_misplaced_transhuge_page(struct mm_struct *mm,
 #define MIGRATE_PFN_LOCKED	(1UL << 2)
 #define MIGRATE_PFN_WRITE	(1UL << 3)
 #define MIGRATE_PFN_DEVICE	(1UL << 4)
-#define MIGRATE_PFN_ERROR	(1UL << 5)
 #define MIGRATE_PFN_SHIFT	6
 
 static inline struct page *migrate_pfn_to_page(unsigned long mpfn)
-- 
2.20.1

