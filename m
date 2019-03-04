Return-Path: <SRS0=91bA=RH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B611C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:32:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5880D20836
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Mar 2019 08:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551688363;
	bh=xVK620x2Y83U1N7QGWtLBWiLpY+GsHCz+99J4+m8dKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=s27m2NzcjgFTw8Bvt5rktGepmZFW690m9XdWLx1oT0OlMMt39n4aJHKGTyCb3cimd
	 BzhdZlBxf/HEm64tWEDQ2pF/5buD9cOBUkk03SKyLYxFzCQkydYNxQlUmJVWtrfZwu
	 Ip3e5/iKMPThEb3tWTY/WHqYCzW6izVvh7FGicK0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727813AbfCDIcm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Mar 2019 03:32:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:36268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727089AbfCDIch (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Mar 2019 03:32:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BE4842146E;
        Mon,  4 Mar 2019 08:32:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551688357;
        bh=xVK620x2Y83U1N7QGWtLBWiLpY+GsHCz+99J4+m8dKA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HEnxrLMWQh25/GP2bDscEprYQsh4A8mMf2ia79+Fi6SxeMRW/lbv/NzLCRHLm23Xa
         Th+C34zb/pjN357nXhLhobFwFjbEDl94HicHbCNLOPwLyjb3K5bxh2yf74/NSBHPwd
         cjQ/ZJ1vjTeprPpyNW1zD2jKuZOK5zRY2HAGrYxE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peng Hao <peng.hao2@zte.com.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        dave.hansen@linux.intel.com, peterz@infradead.org, luto@kernel.org,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 20/88] x86/mm/mem_encrypt: Fix erroneous sizeof()
Date:   Mon,  4 Mar 2019 09:22:03 +0100
Message-Id: <20190304081631.403809019@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190304081630.610632175@linuxfoundation.org>
References: <20190304081630.610632175@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

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
index a19ef1a416ff6..4aa9b1480866b 100644
--- a/arch/x86/mm/mem_encrypt_identity.c
+++ b/arch/x86/mm/mem_encrypt_identity.c
@@ -158,8 +158,8 @@ static void __init sme_populate_pgd(struct sme_populate_pgd_data *ppd)
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



