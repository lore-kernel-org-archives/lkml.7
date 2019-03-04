Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67915C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3775621741
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551688228;
	bh=RCgANYA5ZBxub8hkOGwLXexzsmXKXoRnLOEF3ebZpFk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ooU6QGXKuggT5gbQ1WQCSGvqHuuNAV1KfKKdTN9UN/iIdDq/V+oqAOlD6PqBlNSVw
	 0hylDSGKbbVZJpT/7JJgrWeUxvwXgu5s3P/YXRMDef+DW9bQwNiELey88eG+Su1gUc
	 IrKIgLUXbyQHY1F1q5OmQSuahjoWYfESSTpV/VQY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727701AbfCDIa1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:30:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:58432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727685AbfCDIaW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:30:22 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93595208E4;
        Mon,  4 Mar 2019 08:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551688222;
        bh=RCgANYA5ZBxub8hkOGwLXexzsmXKXoRnLOEF3ebZpFk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nHYmbLHG9TJI7ttROMnlzpC8jIOu6Y5lhldTxGh63fp48x0VQlQtE9w9RRhMRRHTP
         k+49MVbceRDWMI6IR+/Ilh1dmRnazbQr55m2IKEa/cZjzQqvKRyU9r12wN+fxOjzIz
         /Nz9Ykwz6TgWdEavP/qAmPc+V+6JFm98K+60O10A=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peng Hao <peng.hao2@zte.com.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        dave.hansen@linux.intel.com, peterz@infradead.org, luto@kernel.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 20/78] x86/mm/mem_encrypt: Fix erroneous sizeof()
Date:   Mon,  4 Mar 2019 09:22:03 +0100
Message-Id: <20190304081626.401294692@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081625.508788074@linuxfoundation.org>
References: <20190304081625.508788074@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit bf7d28c53453ea904584960de55e33e03b9d93b1 ]

Using sizeof(pointer) for determining the size of a memset() only works
when the size of the pointer and the size of type to which it points are
the same. For pte_t this is only true for 64bit and 32bit-NONPAE. On 32bit
PAE systems this is wrong as the pointer size is 4 byte but the PTE entry
is 8 bytes. It's actually not a real world issue as this code depends on
64bit, but it's wrong nevertheless.

Use sizeof(*p) for correctness sake.

Fixes: aad983913d77 ("x86/mm/encrypt: Simplify sme_populate_pgd() and sme_populate_pgd_large()")
Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Cc: dave.hansen@linux.intel.com
Cc: peterz@infradead.org
Cc: luto@kernel.org
Link: https://lkml.kernel.org/r/1546065252-97996-1-git-send-email-peng.hao2@zte.com.cn
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/mm/mem_encrypt_identity.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/mem_encrypt_identity.c b/arch/x86/mm/mem_encrypt_identity.c
index 7ae36868aed25..c9faf34cbb62e 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -157,8 +157,8 @@ static void __init sme_populate_pgd(struct sme_populate_pgd_data *ppd)
 	pmd = pmd_offset(pud, ppd->vaddr);
 	if (pmd_none(*pmd)) {
 		pte = ppd->pgtable_area;
-		memset(pte, 0, sizeof(pte) * PTRS_PER_PTE);
-		ppd->pgtable_area += sizeof(pte) * PTRS_PER_PTE;
+		memset(pte, 0, sizeof(*pte) * PTRS_PER_PTE);
+		ppd->pgtable_area += sizeof(*pte) * PTRS_PER_PTE;
 		set_pmd(pmd, __pmd(PMD_FLAGS | __pa(pte)));
 	}
 
-- 
2.19.1



