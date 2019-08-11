Return-Path: <SRS0=XJun=WH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34A33C0650F
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 08:13:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09F4A208C2
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Aug 2019 08:13:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bhgtFlj7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbfHKINA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Aug 2019 04:13:00 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42630 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbfHKIM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Aug 2019 04:12:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=MRcXDHnvegEnPa14nfQi3BqEN+g8pBHoWHKAcBcbf9E=; b=bhgtFlj77SWSlCwSjYILq91ceo
        78PkXlraHml2oYRTR5Aj0jTSFviOVyqPHDDUnkcmKulGthcCrePG5BcGiGmgD/LDTEFbLvyt/4rMx
        F9i1oqG6lWV8fjRskKRWX8E8Az+mbfrzAuX+sPxz3sffgBLwEZab/+CfuUHtZfxgh1MxIdIyqqsqX
        IDgtMnbPis2tx5d2oflU1k3GlUhBYF2HmdBl18+u1jcwetya75loik3xMKD2nrkC+5BwuhWMM4DBH
        NrztwG5lvsVuKAtIQBHkFCgrusv8on3mHMP4SVFrhXvL1jJs1azM0fbcipVQUSUH5efpD3zTzGkiS
        vK/3xEtQ==;
Received: from [2001:4bb8:180:1ec3:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hwiyF-0005Co-Hc; Sun, 11 Aug 2019 08:12:55 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Bharata B Rao <bharata@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org
Subject: [PATCH 2/5] resource: add a not device managed request_free_mem_region variant
Date:   Sun, 11 Aug 2019 10:12:44 +0200
Message-Id: <20190811081247.22111-3-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190811081247.22111-1-hch@lst.de>
References: <20190811081247.22111-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just add a simple macro that passes a NULL dev argument to
dev_request_free_mem_region, and call request_mem_region in the
function for that particular case.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/ioport.h | 2 ++
 kernel/resource.c      | 5 ++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/ioport.h b/include/linux/ioport.h
index 0dcc48cafa80..528ae6cbb1b4 100644
--- a/include/linux/ioport.h
+++ b/include/linux/ioport.h
@@ -297,6 +297,8 @@ static inline bool resource_overlaps(struct resource *r1, struct resource *r2)
 
 struct resource *devm_request_free_mem_region(struct device *dev,
 		struct resource *base, unsigned long size, const char *name);
+#define request_free_mem_region(base, size, name) \
+	devm_request_free_mem_region(NULL, base, size, name)
 
 #endif /* __ASSEMBLY__ */
 #endif	/* _LINUX_IOPORT_H */
diff --git a/kernel/resource.c b/kernel/resource.c
index 0ddc558586a7..3a826b3cc883 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -1671,7 +1671,10 @@ struct resource *devm_request_free_mem_region(struct device *dev,
 				REGION_DISJOINT)
 			continue;
 
-		res = devm_request_mem_region(dev, addr, size, name);
+		if (dev)
+			res = devm_request_mem_region(dev, addr, size, name);
+		else
+			res = request_mem_region(addr, size, name);
 		if (!res)
 			return ERR_PTR(-ENOMEM);
 		res->desc = IORES_DESC_DEVICE_PRIVATE_MEMORY;
-- 
2.20.1

