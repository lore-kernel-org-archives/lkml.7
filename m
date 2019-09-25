Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B76C432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 01:45:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7869120874
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 01:45:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633659AbfIYBpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Sep 2019 21:45:19 -0400
Received: from mga03.intel.com ([134.134.136.65]:20126 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727329AbfIYBpT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Sep 2019 21:45:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Sep 2019 18:45:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,546,1559545200"; 
   d="scan'208";a="218832982"
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
  by fmsmga002.fm.intel.com with ESMTP; 24 Sep 2019 18:45:16 -0700
From:   Wei Yang <richardw.yang@linux.intel.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [PATCH] x86/mm: fix function name typo in pmd_read_atomic() comment
Date:   Wed, 25 Sep 2019 09:44:53 +0800
Message-Id: <20190925014453.20236-1-richardw.yang@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function involved should be pte_offset_map_lock and we never have
function pmd_offset_map_lock defined.

Fixes: 26c191788f18 ("mm: pmd_read_atomic: fix 32bit PAE pmd walk vs pmd_populate SMP race conditio")

Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
---

Hope my understanding is correct.

---
 arch/x86/include/asm/pgtable-3level.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/pgtable-3level.h b/arch/x86/include/asm/pgtable-3level.h
index e3633795fb22..45e6099fe6b7 100644
--- a/arch/x86/include/asm/pgtable-3level.h
+++ b/arch/x86/include/asm/pgtable-3level.h
@@ -44,10 +44,10 @@ static inline void native_set_pte(pte_t *ptep, pte_t pte)
  * pmd_populate rightfully does a set_64bit, but if we're reading the
  * pmd_t with a "*pmdp" on the mincore side, a SMP race can happen
  * because gcc will not read the 64bit of the pmd atomically. To fix
- * this all places running pmd_offset_map_lock() while holding the
+ * this all places running pte_offset_map_lock() while holding the
  * mmap_sem in read mode, shall read the pmdp pointer using this
  * function to know if the pmd is null nor not, and in turn to know if
- * they can run pmd_offset_map_lock or pmd_trans_huge or other pmd
+ * they can run pte_offset_map_lock or pmd_trans_huge or other pmd
  * operations.
  *
  * Without THP if the mmap_sem is hold for reading, the pmd can only
-- 
2.17.1

