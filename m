Return-Path: <SRS0=camR=ZD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71912C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 09:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D57020856
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Nov 2019 09:57:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfKKJ5Y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Nov 2019 04:57:24 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:5760 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726829AbfKKJ5Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Nov 2019 04:57:24 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5B0F8D393772A28A2BFF;
        Mon, 11 Nov 2019 17:57:22 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.439.0; Mon, 11 Nov 2019 17:57:15 +0800
From:   zhong jiang <zhongjiang@huawei.com>
To:     <dave.hansen@linux.intel.com>, <peterz@infradead.org>,
        <tglx@linutronix.de>, <mingo@redhat.com>
CC:     <luto@kernel.org>, <bp@alien8.de>, <hpa@zytor.com>,
        <zhongjiang@huawei.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH] x86/mm: Mask out unsupported bit when it set noexec=off
Date:   Mon, 11 Nov 2019 17:53:14 +0800
Message-ID: <1573465994-33249-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 510bb96fe5b3 ("x86/mm: Prevent bogus warnings with "noexec=off"")
use  __supported_pte_mask to replace __default_kernel_pte_mask to mask
out the unsupported bits. It works when the command line set noexec=off.

It also seems to works to use __supported_pte_mask instead in native_set_fixmap.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 arch/x86/mm/pgtable.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index 7bd2c3a..13933b9 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -647,7 +647,7 @@ void native_set_fixmap(unsigned /* enum fixed_addresses */ idx,
 		       phys_addr_t phys, pgprot_t flags)
 {
 	/* Sanitize 'prot' against any unsupported bits: */
-	pgprot_val(flags) &= __default_kernel_pte_mask;
+	pgprot_val(flags) &= __supported_pte_mask;
 
 	__native_set_fixmap(idx, pfn_pte(phys >> PAGE_SHIFT, flags));
 }
-- 
1.7.12.4

