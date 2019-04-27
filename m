Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF75C43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 06:20:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 823152077B
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 06:20:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="NUFMy5+f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfD0GUH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 02:20:07 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:48092 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbfD0GUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 02:20:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=eaz8Fey/P6Juel7qA1XCI3pNp2FBZB0JeB9ems7XCtA=; b=NUFMy5+fLZVuKxCmWdQi3ts21
        COWk5nGvKHyFOHTVAbuK3A2ScJCZ5pQxuNiqnWdqzKZgd+Ori4PJ+9dwKMLI/QIr68qg1Wahgs2RS
        oo24w5BEzA2YuU0IBs2xMHkHE8LGwQXX5jCAtD7ZFXHg/KzMX13Mt+0edyWjkKUT2/ZNmXgMbqywQ
        uDckfS+0njOz8P7kVqgVBMH2dkT+JBHkam9SesKZVhCyBeCcIEBgvLqB9DyyWB1CMpOiyqJqmih+7
        64kDFKdiCuBQxIcdkH5t57qGzIF61lIgypkGBPVZmY0cjkbIo5kW1Dy/9Ek9m/DnQzZ7HjFELw5JP
        HYMiGixzw==;
Received: from [93.83.86.253] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1hKGgt-0002Ro-Tl; Sat, 27 Apr 2019 06:20:04 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     x86@kernel.org
Cc:     thomas.lendacky@amd.com, linux-kernel@vger.kernel.org
Subject: [PATCH] x86: Remove various memory encryption exports
Date:   Sat, 27 Apr 2019 08:19:35 +0200
Message-Id: <20190427061935.4876-1-hch@lst.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

None of these is used in modular code, and we should probably try to
keep it that way.  They can be added back if we really get a legitimate
modular user.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---

FYI: this was inspired by the fact the s390 copied some of the exports,
which made me wonder why they added them.  I could not find any
potential users either in their patchkit nor in mainline.

 arch/x86/mm/mem_encrypt.c | 2 --
 arch/x86/mm/pageattr.c    | 2 --
 2 files changed, 4 deletions(-)

diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 385afa2b9e17..031e7702bd1e 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -339,13 +339,11 @@ bool sme_active(void)
 {
 	return sme_me_mask && !sev_enabled;
 }
-EXPORT_SYMBOL(sme_active);
 
 bool sev_active(void)
 {
 	return sme_me_mask && sev_enabled;
 }
-EXPORT_SYMBOL(sev_active);
 
 /* Architecture __weak replacement functions */
 void __init mem_encrypt_free_decrypted_mem(void)
diff --git a/arch/x86/mm/pageattr.c b/arch/x86/mm/pageattr.c
index 4c570612e24e..9d83c724293a 100644
--- a/arch/x86/mm/pageattr.c
+++ b/arch/x86/mm/pageattr.c
@@ -2066,13 +2066,11 @@ int set_memory_encrypted(unsigned long addr, int numpages)
 {
 	return __set_memory_enc_dec(addr, numpages, true);
 }
-EXPORT_SYMBOL_GPL(set_memory_encrypted);
 
 int set_memory_decrypted(unsigned long addr, int numpages)
 {
 	return __set_memory_enc_dec(addr, numpages, false);
 }
-EXPORT_SYMBOL_GPL(set_memory_decrypted);
 
 int set_pages_uc(struct page *page, int numpages)
 {
-- 
2.20.1

