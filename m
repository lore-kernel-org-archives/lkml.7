Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DE17C4320D
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 00:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0031E20874
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 00:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uvRj3VPw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2411313AbfIYAwh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 20:52:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:56896 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404146AbfIYAwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 20:52:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=IYJnfPXQbX2KlchjxVENlwTcxZRg1vNrwgB6nJ+Nk+o=; b=uvRj3VPweMBLx72xxubKIor8iq
        XeXDZdyVqWM27tGKBPBDx1XBnC9cEsaNrnmPRK1zWRHopGOOFEmzAJNbGCvzIaRh7D64dmbJn75Vg
        7Oc4zzfR6j1S/CMnMaNyozzl4LQhTKeoujlhXtgdAg6WlAx0Lf8BuxE+B+4HCe/9DbTD8dxMXLcLK
        NTYP6FCDuOHAbfvVOLJ9npLV93mIZBeo2Eq+RbyqIcdqF2qc+8f7nWx2uzI2F2MSAMLDDLSHT24sI
        lmDu2cBd3FQ2B7lD8J8NL7DwdaNMxOBk2T7gmPDFoTLw5aLTAU1G2CPC5hXpN9EnJp4REFhW4JFUG
        otHYz3EQ==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.2 #3 (Red Hat Linux))
        id 1iCvXV-00076G-68; Wed, 25 Sep 2019 00:52:17 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: [PATCH 01/15] mm: Use vm_fault error code directly
Date:   Tue, 24 Sep 2019 17:52:00 -0700
Message-Id: <20190925005214.27240-2-willy@infradead.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190925005214.27240-1-willy@infradead.org>
References: <20190925005214.27240-1-willy@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

Use VM_FAULT_OOM instead of indirecting through vmf_error(-ENOMEM).

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 mm/filemap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 1146fcfa3215..625ef3ef19f3 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2533,7 +2533,7 @@ vm_fault_t filemap_fault(struct vm_fault *vmf)
 		if (!page) {
 			if (fpin)
 				goto out_retry;
-			return vmf_error(-ENOMEM);
+			return VM_FAULT_OOM;
 		}
 	}
 
-- 
2.23.0

