Return-Path: <SRS0=rNeM=SR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14DD6C10F12
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:11:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3D45218DA
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Apr 2019 19:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555355503;
	bh=os3sHdUzInbdpZxlphxhiyFbwlwCjyFjrK3Nr0IaKOk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YDSUWOJRWWEM7aGU2XfZWwClDW17cEQyEuJSHI7RzSS7J5mYaxOnhUw4mRaPe40m6
	 qXtIP2nKRxBm5FfsppeHPm0jp8oSb6eC3vkG6QXknI38MEtqhUX3M2dJ6rBYnmPIGr
	 Zeg3wpTbkAT8grJi0X4+pabUnaY/krCKSkNbkLKU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731283AbfDOTLm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Apr 2019 15:11:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:48694 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731268AbfDOTLj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Apr 2019 15:11:39 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5DB6C218DA;
        Mon, 15 Apr 2019 19:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555355498;
        bh=os3sHdUzInbdpZxlphxhiyFbwlwCjyFjrK3Nr0IaKOk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nv7sILy4gMSrGuxcoZ0cNHa/zsRVhNPunYgfFFzWyGBB5xv7RML+F5WPJwEN0G4mK
         y3+UH5KmSirTUl3Qx0ZrnMjZeDB5LqHlCQ9Z4hAWoxjTurJgMJPXAdKGw31lG6Mu7e
         U/nWB5M84G3PAE9sy4+bGxldDoAblzatNs+ghnvA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Chandan Rajendra <chandan@linux.ibm.com>,
        Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 5.0 058/117] mm/huge_memory.c: fix modifying of page protection by insert_pfn_pmd()
Date:   Mon, 15 Apr 2019 21:00:28 +0200
Message-Id: <20190415183747.881878682@linuxfoundation.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415183744.887851196@linuxfoundation.org>
References: <20190415183744.887851196@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

commit c6f3c5ee40c10bb65725047a220570f718507001 upstream.

With some architectures like ppc64, set_pmd_at() cannot cope with a
situation where there is already some (different) valid entry present.

Use pmdp_set_access_flags() instead to modify the pfn which is built to
deal with modifying existing PMD entries.

This is similar to commit cae85cb8add3 ("mm/memory.c: fix modifying of
page protection by insert_pfn()")

We also do similar update w.r.t insert_pfn_pud eventhough ppc64 don't
support pud pfn entries now.

Without this patch we also see the below message in kernel log "BUG:
non-zero pgtables_bytes on freeing mm:"

Link: http://lkml.kernel.org/r/20190402115125.18803-1-aneesh.kumar@linux.ibm.com
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
Reported-by: Chandan Rajendra <chandan@linux.ibm.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/huge_memory.c |   36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -753,6 +753,21 @@ static void insert_pfn_pmd(struct vm_are
 	spinlock_t *ptl;
 
 	ptl = pmd_lock(mm, pmd);
+	if (!pmd_none(*pmd)) {
+		if (write) {
+			if (pmd_pfn(*pmd) != pfn_t_to_pfn(pfn)) {
+				WARN_ON_ONCE(!is_huge_zero_pmd(*pmd));
+				goto out_unlock;
+			}
+			entry = pmd_mkyoung(*pmd);
+			entry = maybe_pmd_mkwrite(pmd_mkdirty(entry), vma);
+			if (pmdp_set_access_flags(vma, addr, pmd, entry, 1))
+				update_mmu_cache_pmd(vma, addr, pmd);
+		}
+
+		goto out_unlock;
+	}
+
 	entry = pmd_mkhuge(pfn_t_pmd(pfn, prot));
 	if (pfn_t_devmap(pfn))
 		entry = pmd_mkdevmap(entry);
@@ -764,11 +779,16 @@ static void insert_pfn_pmd(struct vm_are
 	if (pgtable) {
 		pgtable_trans_huge_deposit(mm, pmd, pgtable);
 		mm_inc_nr_ptes(mm);
+		pgtable = NULL;
 	}
 
 	set_pmd_at(mm, addr, pmd, entry);
 	update_mmu_cache_pmd(vma, addr, pmd);
+
+out_unlock:
 	spin_unlock(ptl);
+	if (pgtable)
+		pte_free(mm, pgtable);
 }
 
 vm_fault_t vmf_insert_pfn_pmd(struct vm_area_struct *vma, unsigned long addr,
@@ -819,6 +839,20 @@ static void insert_pfn_pud(struct vm_are
 	spinlock_t *ptl;
 
 	ptl = pud_lock(mm, pud);
+	if (!pud_none(*pud)) {
+		if (write) {
+			if (pud_pfn(*pud) != pfn_t_to_pfn(pfn)) {
+				WARN_ON_ONCE(!is_huge_zero_pud(*pud));
+				goto out_unlock;
+			}
+			entry = pud_mkyoung(*pud);
+			entry = maybe_pud_mkwrite(pud_mkdirty(entry), vma);
+			if (pudp_set_access_flags(vma, addr, pud, entry, 1))
+				update_mmu_cache_pud(vma, addr, pud);
+		}
+		goto out_unlock;
+	}
+
 	entry = pud_mkhuge(pfn_t_pud(pfn, prot));
 	if (pfn_t_devmap(pfn))
 		entry = pud_mkdevmap(entry);
@@ -828,6 +862,8 @@ static void insert_pfn_pud(struct vm_are
 	}
 	set_pud_at(mm, addr, pud, entry);
 	update_mmu_cache_pud(vma, addr, pud);
+
+out_unlock:
 	spin_unlock(ptl);
 }
 


