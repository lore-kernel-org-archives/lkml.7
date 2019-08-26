Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04580C3A59E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 07:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C69A12173E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 07:56:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EtGk6dwL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730358AbfHZH4S (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 03:56:18 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:36424 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730158AbfHZH4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 03:56:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=E0qCJcl+e9z7ok02FGv9Hjnrfqx9W5rhA77m79a6bTk=; b=EtGk6dwLFR63g2EM6F3UoH6Ip6
        h6vWhXxHUhniPXFPJsfHFaKchDxY9ImHZAqQwrlXzxCyRJA7JAf6LOL0wODevrGF+Sq0XPUrV7T/l
        KAwVLjXMbt0vEru8uH5OLur+hr/i5+IA3XUZ5/KkNCcuCEIjAOtwr7Sj82F+0C3uDOveAawoxbrmf
        x75UbMAgCZFVqjl5Uv8qqvwn4fyxz6/Ixgxv75ZL0FMBiy4NX0zablohv7zaNoJ4/gIVAvWHFqnNW
        Yt00X1VVhRWnnoCdnjgAR5psPzNnlVVBvneW2Ic6to+1puhg3toLiP3LihxweQdf6osCldq1fSFoh
        e32r3vGg==;
Received: from [2001:4bb8:180:3f4c:c944:137d:e92e:5fab] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i29rJ-0000Wt-FV; Mon, 26 Aug 2019 07:56:14 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     x86@kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] x86: remove the unused set_memory_wt function
Date:   Mon, 26 Aug 2019 09:55:57 +0200
Message-Id: <20190826075558.8125-5-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190826075558.8125-1-hch@lst.de>
References: <20190826075558.8125-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/set_memory.h |  1 -
 arch/x86/mm/pageattr.c            | 17 -----------------
 2 files changed, 18 deletions(-)

diff --git a/arch/x86/include/asm/set_memory.h b/arch/x86/include/asm/set_memory.h
index fd549c3ebb17..2ee8e469dcf5 100644
--- a/arch/x86/include/asm/set_memory.h
+++ b/arch/x86/include/asm/set_memory.h
@@ -40,7 +40,6 @@ int _set_memory_wt(unsigned long addr, int numpages);
 int _set_memory_wb(unsigned long addr, int numpages);
 int set_memory_uc(unsigned long addr, int numpages);
 int set_memory_wc(unsigned long addr, int numpages);
-int set_memory_wt(unsigned long addr, int numpages);
 int set_memory_wb(unsigned long addr, int numpages);
 int set_memory_np(unsigned long addr, int numpages);
 int set_memory_4k(unsigned long addr, int numpages);
diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index 0e39b344556d..9acd568c4faa 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -1848,23 +1848,6 @@ int _set_memory_wt(unsigned long addr, int numpages)
 				    cachemode2pgprot(_PAGE_CACHE_MODE_WT), 0);
 }
 
-int set_memory_wt(unsigned long addr, int numpages)
-{
-	int ret;
-
-	ret = reserve_memtype(__pa(addr), __pa(addr) + numpages * PAGE_SIZE,
-			      _PAGE_CACHE_MODE_WT, NULL);
-	if (ret)
-		return ret;
-
-	ret = _set_memory_wt(addr, numpages);
-	if (ret)
-		free_memtype(__pa(addr), __pa(addr) + numpages * PAGE_SIZE);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(set_memory_wt);
-
 int _set_memory_wb(unsigned long addr, int numpages)
 {
 	/* WB cache mode is hard wired to all cache attribute bits being 0 */
-- 
2.20.1

