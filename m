Return-Path: <SRS0=K9bG=V2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 010F1C7618B
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 14:29:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF1D0216C8
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jul 2019 14:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PoRZVZGW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728452AbfG2O3S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jul 2019 10:29:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46980 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727129AbfG2O3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 10:29:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ADCug91zuoANeBM/f4yCo270YqgttY1AZGH+RTcphSg=; b=PoRZVZGWUXTPpfSubNbeDA1LdQ
        b1LU/fQcfLbyytc2sKwhS9XHDPhN/gAt57LwReU5qOooafXp0ZDGWpFF/2t4PTI/oaQv6W14tY4mb
        rza6MeZTZ9XBJh/slw1Y3bcBA1QSUV+n4ZlZw0NYQfKPrQTDFtZI5E9tOFs20qu0RAJJTghI3SRgm
        YgD2M6gbXV0E6tWBxPYGCgN/DTlYlaMlgZrQe+O/igafLpjEuov7/uqXg2nCrGYgEePTo7BvTg3Gz
        k3Lax/R6rvcpq4mDKiz84UhDA+aZJS5tGJi7fwLDd/1s0vbKGIGuHFzxXh6MbT37dORGy06wuzQKy
        8BoJHZmQ==;
Received: from [195.167.85.94] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hs6eI-0006N3-7M; Mon, 29 Jul 2019 14:29:14 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Ben Skeggs <bskeggs@redhat.com>
Cc:     Ralph Campbell <rcampbell@nvidia.com>,
        Bharata B Rao <bharata@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 7/9] mm: remove the unused MIGRATE_PFN_ERROR flag
Date:   Mon, 29 Jul 2019 17:28:41 +0300
Message-Id: <20190729142843.22320-8-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190729142843.22320-1-hch@lst.de>
References: <20190729142843.22320-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't use this flag anymore, so remove it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/migrate.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/migrate.h b/include/linux/migrate.h
index 093d67fcf6dd..229153c2c496 100644
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

