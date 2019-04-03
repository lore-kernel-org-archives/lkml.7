Return-Path: <SRS0=7x1k=SF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5D5C10F0C
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 19:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 752DB2133D
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Apr 2019 19:33:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbfDCTdl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Apr 2019 15:33:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40906 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726785AbfDCTdh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Apr 2019 15:33:37 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 63F8230842B1;
        Wed,  3 Apr 2019 19:33:37 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-125-190.rdu2.redhat.com [10.10.125.190])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7D2C86012C;
        Wed,  3 Apr 2019 19:33:36 +0000 (UTC)
From:   jglisse@redhat.com
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v3 07/12] mm/hmm: add default fault flags to avoid the need to pre-fill pfns arrays v2
Date:   Wed,  3 Apr 2019 15:33:13 -0400
Message-Id: <20190403193318.16478-8-jglisse@redhat.com>
In-Reply-To: <20190403193318.16478-1-jglisse@redhat.com>
References: <20190403193318.16478-1-jglisse@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Wed, 03 Apr 2019 19:33:37 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jérôme Glisse <jglisse@redhat.com>

The HMM mirror API can be use in two fashions. The first one where the HMM
user coalesce multiple page faults into one request and set flags per pfns
for of those faults. The second one where the HMM user want to pre-fault a
range with specific flags. For the latter one it is a waste to have the user
pre-fill the pfn arrays with a default flags value.

This patch adds a default flags value allowing user to set them for a range
without having to pre-fill the pfn array.

Changes since v1:
    - Added documentation.
    - Added comments in the old API wrapper to explain what is going on.

Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
Reviewed-by: Ralph Campbell <rcampbell@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/vm/hmm.rst | 35 +++++++++++++++++++++++++++++++++++
 include/linux/hmm.h      | 13 +++++++++++++
 mm/hmm.c                 | 12 ++++++++++++
 3 files changed, 60 insertions(+)

diff --git a/Documentation/vm/hmm.rst b/Documentation/vm/hmm.rst
index 945d5fb6d14a..ec1efa32af3c 100644
--- a/Documentation/vm/hmm.rst
+++ b/Documentation/vm/hmm.rst
@@ -276,6 +276,41 @@ report commands as executed is serialized (there is no point in doing this
 concurrently).
 
 
+Leverage default_flags and pfn_flags_mask
+=========================================
+
+The hmm_range struct has 2 fields default_flags and pfn_flags_mask that allows
+to set fault or snapshot policy for a whole range instead of having to set them
+for each entries in the range.
+
+For instance if the device flags for device entries are:
+    VALID (1 << 63)
+    WRITE (1 << 62)
+
+Now let say that device driver wants to fault with at least read a range then
+it does set:
+    range->default_flags = (1 << 63)
+    range->pfn_flags_mask = 0;
+
+and calls hmm_range_fault() as described above. This will fill fault all page
+in the range with at least read permission.
+
+Now let say driver wants to do the same except for one page in the range for
+which its want to have write. Now driver set:
+    range->default_flags = (1 << 63);
+    range->pfn_flags_mask = (1 << 62);
+    range->pfns[index_of_write] = (1 << 62);
+
+With this HMM will fault in all page with at least read (ie valid) and for the
+address == range->start + (index_of_write << PAGE_SHIFT) it will fault with
+write permission ie if the CPU pte does not have write permission set then HMM
+will call handle_mm_fault().
+
+Note that HMM will populate the pfns array with write permission for any entry
+that have write permission within the CPU pte no matter what are the values set
+in default_flags or pfn_flags_mask.
+
+
 Represent and manage device memory from core kernel point of view
 =================================================================
 
diff --git a/include/linux/hmm.h b/include/linux/hmm.h
index ec4bfa91648f..dee2f8953b2e 100644
--- a/include/linux/hmm.h
+++ b/include/linux/hmm.h
@@ -165,6 +165,8 @@ enum hmm_pfn_value_e {
  * @pfns: array of pfns (big enough for the range)
  * @flags: pfn flags to match device driver page table
  * @values: pfn value for some special case (none, special, error, ...)
+ * @default_flags: default flags for the range (write, read, ... see hmm doc)
+ * @pfn_flags_mask: allows to mask pfn flags so that only default_flags matter
  * @pfn_shifts: pfn shift value (should be <= PAGE_SHIFT)
  * @valid: pfns array did not change since it has been fill by an HMM function
  */
@@ -177,6 +179,8 @@ struct hmm_range {
 	uint64_t		*pfns;
 	const uint64_t		*flags;
 	const uint64_t		*values;
+	uint64_t		default_flags;
+	uint64_t		pfn_flags_mask;
 	uint8_t			pfn_shift;
 	bool			valid;
 };
@@ -448,6 +452,15 @@ static inline int hmm_vma_fault(struct hmm_range *range, bool block)
 {
 	long ret;
 
+	/*
+	 * With the old API the driver must set each individual entries with
+	 * the requested flags (valid, write, ...). So here we set the mask to
+	 * keep intact the entries provided by the driver and zero out the
+	 * default_flags.
+	 */
+	range->default_flags = 0;
+	range->pfn_flags_mask = -1UL;
+
 	ret = hmm_range_register(range, range->vma->vm_mm,
 				 range->start, range->end);
 	if (ret)
diff --git a/mm/hmm.c b/mm/hmm.c
index 3e07f32b94f8..0e21d3594ab6 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -419,6 +419,18 @@ static inline void hmm_pte_need_fault(const struct hmm_vma_walk *hmm_vma_walk,
 	if (!hmm_vma_walk->fault)
 		return;
 
+	/*
+	 * So we not only consider the individual per page request we also
+	 * consider the default flags requested for the range. The API can
+	 * be use in 2 fashions. The first one where the HMM user coalesce
+	 * multiple page fault into one request and set flags per pfns for
+	 * of those faults. The second one where the HMM user want to pre-
+	 * fault a range with specific flags. For the latter one it is a
+	 * waste to have the user pre-fill the pfn arrays with a default
+	 * flags value.
+	 */
+	pfns = (pfns & range->pfn_flags_mask) | range->default_flags;
+
 	/* We aren't ask to do anything ... */
 	if (!(pfns & range->flags[HMM_PFN_VALID]))
 		return;
-- 
2.17.2

