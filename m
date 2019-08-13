Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 681FBC32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 09:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3986920842
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 09:02:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="df46fyBX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbfHMJCE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 05:02:04 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36488 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728169AbfHMJCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 05:02:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=b4dqbFjYznAR3OsoXfRMpkAzmfx0Cmvs7xo4HKlRTbY=; b=df46fyBXiEBjXRVVCPg+1q+I2U
        wMYxctQ8sENxPFbJXZQT3DsYY8RrqgmwLGKBWXiXUqpM3gO45CkSWeW4KqFoh/QsHD9BY0GmwhJv4
        bdeNV2GXnQLRZTBZCfwebdVqROV+wLQk9EBMl1tpSV1A/qlwle7BDVf9Wi1hS+/lOYTqGAJ1z18cm
        WyfsKNE/ZbBYbmURgIxX4TopgEum6oABg7QvMRpQmQQgPo+DoKFzYCqCeNHyrwCgRDUrJ9ohP+UEp
        PYDgv4egtFhCQDJ7+qSUvT8cN+GDk5NCNRlfMkNKa6uQcPqrJ44HhuXR5kkhIeiR+3ZL/vYF2zkKx
        8RBH+7ag==;
Received: from [2001:4bb8:180:1ec3:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hxSgl-0006Px-MH; Tue, 13 Aug 2019 09:01:56 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, x86@kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] x86: unexport set_memory_x and set_memory_nx
Date:   Tue, 13 Aug 2019 11:01:42 +0200
Message-Id: <20190813090146.26377-3-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190813090146.26377-1-hch@lst.de>
References: <20190813090146.26377-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No module currently messed with clearing or setting the execute
permission of kernel memory, and none really should.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/x86/mm/pageattr.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index 6a9a77a403c9..a02ca8986299 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -1967,7 +1967,6 @@ int set_memory_x(unsigned long addr, int numpages)
 
 	return change_page_attr_clear(&addr, numpages, __pgprot(_PAGE_NX), 0);
 }
-EXPORT_SYMBOL(set_memory_x);
 
 int set_memory_nx(unsigned long addr, int numpages)
 {
@@ -1976,7 +1975,6 @@ int set_memory_nx(unsigned long addr, int numpages)
 
 	return change_page_attr_set(&addr, numpages, __pgprot(_PAGE_NX), 0);
 }
-EXPORT_SYMBOL(set_memory_nx);
 
 int set_memory_ro(unsigned long addr, int numpages)
 {
-- 
2.20.1

